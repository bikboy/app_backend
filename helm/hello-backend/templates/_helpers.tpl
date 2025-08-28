{{- define "hello-backend.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "hello-backend.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}

{{- define "hello-backend.labels" -}}
app.kubernetes.io/name: {{ include "hello-backend.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
