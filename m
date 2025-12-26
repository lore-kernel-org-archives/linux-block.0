Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F071DA23
	for <linux-block@vger.kernel.org>; Fri, 26 Dec 2025 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766740147; cv=none; b=JP1iyRVaNZTl5ttN2pQjLBWQ6uujjrbfuPQxf+2KA2hRvb+XNKRLj+AHY+tLxctzYh1KU7T3Te48U8fWq8Fb/alTt8lNoLR/bLrXsSRCSaxbiVJXUbbWVa4PUFtHUjQ6qTxJuKiCuVTSEy7K7XtXtz1MaxXcYlPe0PcSOH4BYBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766740147; c=relaxed/simple;
	bh=uLlNYW+nNrF0CIma0CP9mqSXFFgx3oB5Slk1+wVd7hQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYlOAyPrN+FMD/ahi/HhVEMrI6k6U5I3bKE5k2Cj6VaXYQfQGAauukG/OEgkwjSqy0Iin+OwAgM4p1zLmzbI1xuQRdny21A5Bha0zyGJW7WsIKKBSQTuGUq/P8gUyMmnY9CWUBkPkchY8oSJn+AjBT2QXa12opV04Wf8VLrXke8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=D6TW/FOP; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="D6TW/FOP"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4dd0Cv3lSFz1XM6JT;
	Fri, 26 Dec 2025 09:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1766740138; x=1769332139; bh=qLVHmZ8mFNbjo0e4nTlJJqjO
	LYWwKLAvdUMvNecrTCg=; b=D6TW/FOPPYiOO+9qrzuaBuIZnD444CjidPq7VzY5
	0ftYUJ/88hGsLLEcpwfHxx3SpZSkNSL6VMHEQYL8f8IFBHJLvAJ9BCX5oEfH1dAk
	W5EdVhv7/9vFG94VQnXemwDJ6Xb3NgJEuEr+rFg1PaeX3P66AQGDIH2mzme3eCiS
	sXJBTQ5KlInkplTNnfJDmb/etq+vm4PguPsWM2lnTGkd/J36ScWHohHgnXoGE1S3
	OrUiI+cLvVB+KCaVg/mgvVdS95sObxp78bXU1jguYiD8glD/ZABir/IndyQFvYvI
	gwU5Y+Glv3YrOMDvMRBq4nWireaF1eD80gTYNTd2HNsEFQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id iEuLSXjVTIG5; Fri, 26 Dec 2025 09:08:58 +0000 (UTC)
Received: from [192.168.1.35] (127.234-65-87.adsl-dyn.isp.belgacom.be [87.65.234.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4dd0Cq1w81z1XM5kt;
	Fri, 26 Dec 2025 09:08:54 +0000 (UTC)
Message-ID: <435451b8-4d54-4306-b29c-819a55b6b5f1@acm.org>
Date: Fri, 26 Dec 2025 10:08:50 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v5 2/4] srp/rc: replace module removal with
 patient module removal
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: mcgrof@kernel.org, sw.prabhu6@gmail.com,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20251225120919.1575005-1-shinichiro.kawasaki@wdc.com>
 <20251225120919.1575005-3-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251225120919.1575005-3-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/25/25 1:09 PM, Shin'ichiro Kawasaki wrote:
> Suggested-by: Bart Van Assche <bvanassche@acm.org>

I can't remember that I suggested to use _patient_rmmod. Luis, can you
provide a link that shows that I suggested to use _patient_rmmod for the
SRP tests? If not, please leave out the Suggested-by tag.

> diff --git a/tests/srp/rc b/tests/srp/rc
> index 47b9546..2d3d615 100755
> --- a/tests/srp/rc
> +++ b/tests/srp/rc
> @@ -331,19 +331,10 @@ start_srp_ini() {
>   
>   # Unload the SRP initiator driver.
>   stop_srp_ini() {
> -	local i
> -
>   	log_out
> -	for ((i=40;i>=0;i--)); do
> -		remove_mpath_devs || return $?
> -		_unload_module ib_srp >/dev/null 2>&1 && break
> -		sleep 1
> -	done
> -	if [ -e /sys/module/ib_srp ]; then
> -		echo "Error: unloading kernel module ib_srp failed"
> -		return 1
> -	fi
> -	_unload_module scsi_transport_srp || return $?
> +	remove_mpath_devs || return $?
> +	_patient_rmmod ib_srp || return 1
> +	_patient_rmmod scsi_transport_srp || return $?
>   }

The loop should be around both remove_mpath_devs and _unload_module
because multipathd may add new paths concurrently with the for-loop.
Please back out the above changes from this patch.

Thanks,

Bart.
