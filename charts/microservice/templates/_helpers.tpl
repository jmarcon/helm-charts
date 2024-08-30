{{/*
Expand the name of the chart.
*/}}
{{- define "microservice.name" -}}
{{- default .Chart.Name .Values.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "microservice.fullname" -}}
{{- if .Values.name }}
{{- .Values.name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.name }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "microservice.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Change the default application version string.
*/}}
{{- define "microservice.appVersion" }}
{{- default .Chart.AppVersion .Values.version | quote }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "microservice.labels" -}}
helm.sh/chart: {{ include "microservice.chart" . }}
{{ include "microservice.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ include "microservice.appVersion" . }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.git.repo }}
git/repo: {{ .Values.git.repo | quote }}
{{- end }}
{{- if .Values.git.branch }}
git/branch: {{ .Values.git.branch | quote }}
{{- end }}
{{- if .Values.git.commit }}
git/commit: {{ .Values.git.commit | quote }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "microservice.selectorLabels" -}}
app.kubernetes.io/name: {{ include "microservice.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "microservice.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
  {{- default (include "microservice.fullname" .) .Values.serviceAccount.name }}
{{- else }}
  {{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Define resource limits default
*/}}
{{- define "microservice.resources.limits.cpu" -}}
{{- if .Values.resources }}
  {{- if .Values.resources.limits }}
    {{- default "200m" .Values.resources.limits.cpu }}
  {{- else }}
    {{- default "200m" }}
  {{- end }}
{{- else }}
    {{- default "200m" }}
{{- end }}
{{- end }}

{{- define "microservice.resources.limits.memory" -}}
{{- if .Values.resources }}
  {{- if .Values.resources.limits }}
    {{- default "128Mi" .Values.resources.limits.memory }}
  {{- else }}
    {{- default "128Mi" }}
  {{- end }}
{{- else }}
    {{- default "128Mi" }}
{{- end }}
{{- end }}

{{- define "microservice.resources.requests.cpu" -}}
{{- if .Values.resources }}
  {{- if .Values.resources.requests }}
    {{- default "100m" .Values.resources.requests.cpu }}
  {{- else }}
    {{- default "100m" }}
  {{- end }}
{{- else }}
    {{- default "100m" }}
{{- end }}
{{- end }}

{{- define "microservice.resources.requests.memory" -}}
{{- if .Values.resources }}
  {{- if .Values.resources.requests }}
    {{- default "64Mi" .Values.resources.requests.memory }}
  {{- else }}
    {{- default "64Mi" }}
  {{- end }}
{{- else }}
    {{- default "64Mi" }}
{{- end }}
{{- end }}

