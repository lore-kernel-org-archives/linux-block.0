Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6E0352018
	for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786561389; cv=none; b=KzS3gO4AHeEfF3vfSSs38XG/Of3ybpzQbpdxvLWAlPOzpGxjoYQSPd7pHZkKS/Z9hLg7CrkWPvUn+9wtsNDEm7B2La1NKLb4/ADuW88V3NLBrIhgSw/oGc/q2QgdBOsl69XYoVeN49sIKYlFo3ByamaJfS9aEPKr6g86c03y+nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786561389; c=relaxed/simple;
	bh=7XLYFx10m8xQwXUw9/+Gi19CT7aPUGWYYXKMNYsq5Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8zIf1y/Qcp/DFekDCg6pk252XV+0buQC1RQydAeST8aRb3EHtIRqvBXMRfvJ/tRphCHgKlrE2vflmOF1v2MpsAEQAbvgPc5NTbLa0flypQeMUZ358zJmun/dYGRB+HSaS5gXB0PnyYNCUpNLdQIJsgr3Dlc9tuamiKOLkwMV7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CiGx63tz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CiGx63tz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786561386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jF5vEdjS6Gt9lpkiWy9qRTwoSpjzvZgLsdsLNZ6YZOk=;
	b=CiGx63tzSlvc5FiFO9R1NEHjpd9If/8pUubCGkhR+14z+nLGLznAsfepEWeaKxSRvhg5it
	yqL69LxOWpJjek+gUIB+lo7GWWdJO8ZtM7eSxAP8rlpSw2sil60PNDUIsS7QU5oWw7voek
	yXQAmw1RvUk/jD4E7V5yxxJY+WGGtHQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-RtfgM6IpO3SRgaedx1ldpg-1; Wed,
 12 Aug 2026 15:03:03 -0400
X-MC-Unique: RtfgM6IpO3SRgaedx1ldpg-1
X-Mimecast-MFC-AGG-ID: RtfgM6IpO3SRgaedx1ldpg_1786561382
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F4E2180074B;
	Wed, 12 Aug 2026 19:03:02 +0000 (UTC)
Received: from [10.17.17.225] (unknown [10.17.17.225])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C885195DF98;
	Wed, 12 Aug 2026 19:03:01 +0000 (UTC)
Message-ID: <29b5a54c-09ae-44c8-824a-4bf41bfb8a74@redhat.com>
Date: Wed, 12 Aug 2026 15:03:00 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 1/2] nvme: Add _setup_nvmet_port_marginal
To: Jesse Taube <jtaubepe@redhat.com>, linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com,
 Daniel Wagner <dwagner@suse.de>
References: <20260812174503.3705830-1-jtaubepe@redhat.com>
 <20260812174503.3705830-2-jtaubepe@redhat.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20260812174503.3705830-2-jtaubepe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Good job Jesse. These tests work!

Reviewed-by: John Meneghini <jmeneghi@redhat.com>
Tested-by: John Meneghini <jmeneghi@redhat.com>

On 8/12/26 13:45, Jesse Taube wrote:
> Adds functionality to set up a NVME port in marginal state.
> This is useful for testing the behavior of the NVME driver when a port
> is in a marginal state.
> 
> Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
> ---
>   common/nvme | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/common/nvme b/common/nvme
> index f399937..d389e18 100644
> --- a/common/nvme
> +++ b/common/nvme
> @@ -153,6 +153,15 @@ _nvme_fcloop_add_tport() {
>   	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/add_target_port
>   }
>   
> +_nvme_fcloop_set_rport_marginal() {
> +	local wwnn="$1"
> +	local wwpn="$2"
> +	local marginal="$3"
> +	local loopctl=/sys/class/fcloop/ctl
> +
> +	echo "wwnn=${wwnn},wwpn=${wwpn},marginal=${marginal}" > ${loopctl}/set_marginal_rport
> +}
> +
>   _nvme_fcloop_del_rport() {
>   	local local_wwnn="$1"
>   	local local_wwpn="$2"
> @@ -763,6 +772,27 @@ _create_nvmet_port() {
>   	echo "${port}"
>   }
>   
> +_setup_nvmet_port_marginal() {
> +	local -i port="$1"
> +	local state="${2}"
> +
> +	if [[ ! "${nvme_trtype}" == "fc" ]]; then
> +		echo "FAIL _setup_nvmet_port_marginal() only supports fc transport"
> +		exit 1
> +	fi
> +
> +	if [[ "${state}" == "live" ]]; then
> +		_nvme_fcloop_set_rport_marginal "$(_remote_wwnn $port)" \
> +					"$(_remote_wwpn $port)" 0
> +	elif [[ "${state}" == "marginal" ]]; then
> +		_nvme_fcloop_set_rport_marginal "$(_remote_wwnn $port)" \
> +					"$(_remote_wwpn $port)" 1
> +	else
> +		echo "FAIL _setup_nvmet_port_marginal() invalid state: ${state}"
> +		exit 1
> +	fi
> +}
> +
>   _setup_nvmet_port_ana() {
>   	local port="$1"
>   	local anagrpid="${2:-$def_anagrpid}"

