Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2BD1465B3
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721406630; cv=none; b=HLHleafx+3EPzGdbVCB0LAM29vKEklm0SL0KevbtLBTJxtV22PUsqPn1rVouLt7mEM9w6mQW/4Zl1VLePEAVcotUEcNaCLlpWakJpt58gr9Ow7qjvYcA6N5vziqy9XzriBp9+p8Qbus2gaV2iap8x4fM+g7LpPMTBXj55GddU9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721406630; c=relaxed/simple;
	bh=hZF1phKLBDMYhTj1MpZd5jdGsRrdGKliHbYCwPK5PUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2UwnrZZfEi4uBVBUGqXL+Ja4IMzK3Kk6hW8oolvHWbfv0WDRea4REgdNFS2SlyCthuWgJDXGmh39JYfK8IXXRdRPkxPFwXzvJTwNLguOLkFOLVS3UODtXWS5RbVUmK5Rbv/GpDHADk9ZBNRj7tMALLuANWs6GwISpUk5bNMl4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=WOlc9UHf; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="WOlc9UHf"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WQZsc0DDMz6CmLxj;
	Fri, 19 Jul 2024 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1721406625; x=1723998626; bh=uTj1dDIbvkn2K8NySqz23JRo
	QMkjt37rdd+rEFyZmMk=; b=WOlc9UHf/NxzVa93uahVYiSQo6sYV+Unjqq+gls+
	8J2wXsoRHIpd6ea1CIfQV/JYhXJ3HeKFpM1RQJnYCdKCaZXtVJffD6no+CwIxo7v
	Cu0vRFLM+GllQdc2XJ22LB8zGBo7NDQwD6odf/+GQnPL/RgJz1aph8MhA1AtBrPW
	bYZefFxG9t+XyU61FAYrHZNmt2JgJcp95muinhVXFrMM/V3Vcz6gg8BTKHoo5YUv
	lNktfr4BFV2CeRmDtZAibn4e12ItqQUwbpLsStaLjLFL9/2cEKMHWwadUwOWDWs6
	hCaH9hctxYE/XLlOGHgmNWvt78jzMgdKJnU92QfF4AcJcg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id owc7DVikXRYk; Fri, 19 Jul 2024 16:30:25 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WQZsX5gTFz6CmLxd;
	Fri, 19 Jul 2024 16:30:24 +0000 (UTC)
Message-ID: <3e41d19e-19d4-43c2-bdc0-e321c62aa2f0@acm.org>
Date: Fri, 19 Jul 2024 09:30:22 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2] nbd/rc: check nbd-server port readiness in
 _start_nbd_server()
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, nbd@other.debian.org
Cc: Yi Zhang <yi.zhang@redhat.com>
References: <20240719050726.265769-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240719050726.265769-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/24 10:07 PM, Shin'ichiro Kawasaki wrote:
> Recently, CKI project reported nbd/001 and nbd/002 failure with the
> error message "Socket failed: Connection refused". It is suspected nbd-
> server is not yet ready when nbd-client connects for the first time.
> 
> To avoid the failure, wait for the nbd-server start listening to the
> port at the end of _start_nbd_server(). For that purpose, use
> "nbd-client -l" command, which connects to the server and asks to list
> available exports.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Link: https://github.com/osandov/blktests/issues/142
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> Change from v1:
> * Reduced sleep time from 1 second to 0.1 second
> 
>   tests/nbd/rc | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/tests/nbd/rc b/tests/nbd/rc
> index e96dc61..e200ba6 100644
> --- a/tests/nbd/rc
> +++ b/tests/nbd/rc
> @@ -63,13 +63,24 @@ _wait_for_nbd_disconnect() {
>   }
>   
>   _start_nbd_server() {
> +	local i
> +
>   	truncate -s 10G "${TMPDIR}/export"
>   	cat > "${TMPDIR}/nbd.conf" << EOF
>   [generic]
> +allowlist=true
>   [export]
>   exportname=${TMPDIR}/export
>   EOF
>   	nbd-server -p "${TMPDIR}/nbd.pid" -C "${TMPDIR}/nbd.conf"
> +
> +	# Wait for nbd-server start listening the port
> +	for ((i = 0; i < 100; i++)); do
> +		if nbd-client -l localhost &> "$FULL"; then
> +			break
> +		fi
> +		sleep .1
> +	done
>   }
>   
>   _stop_nbd_server() {

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
