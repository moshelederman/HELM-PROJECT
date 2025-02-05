{{/*
חישוב שם מלא של התרשים
*/}}
{{- define "project-stars.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
שם התרשים
*/}}
{{- define "project-stars.name" -}}
{{- .Chart.Name -}}
{{- end -}}
