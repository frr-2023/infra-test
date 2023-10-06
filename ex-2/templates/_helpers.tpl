{{/*
Mandatory labels
*/}}
{{- define "businessLabels" -}}
app: {{ .Chart.Name }}
env: {{ default "local" .Values.statefulset.env }}
{{- end }}