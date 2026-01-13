Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D74155C82
	for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 01:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768266197; cv=none; b=rFEDjRbOm4GlvhVw3MFiZl1eDRFmM6ByvXH2uZBq2yfasXfUuW+dcgQm0Itaur/NWdQl05g8MW5RWbWdnYYgfgfmcCCy77QoEQo/B2CtPE5dUUbqIkspbCUlT9ubLyVnbVgBoTT0TS8M7pO7lyeb1X3XhwT9IPzKY3t7YTah7jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768266197; c=relaxed/simple;
	bh=CAum1hCrci+obZUm2BK4HLDKJlzJ6EDk39UUVVOGG3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FhOVvGeoeS/Ycckjvot2LKkptcOQ8ArELv24DZbtpuCETkcyKib+dyhmJunHJNmazYVTsBkVI0VjYsnzPm1Y8seALB5RjKH8fwm8RzGuNfTSD1mNHXcUeAW91LLSfWouTG3w5OXorZw/BwkT0ilKnszKeHsCIYFOnlP9geUI3X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=O/XbCNRS; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="O/XbCNRS"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dqrb810krzlgyG0;
	Tue, 13 Jan 2026 01:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1768266194; x=1770858195; bh=g0kXOZPR3mBGMSZKbOX+aAqb
	Ln/G8AVRlFaJSMpvKSw=; b=O/XbCNRSEkkBN0lb/wiZH1F3DtFceHViNOOx3fhS
	yeBrtWaUmDPwM/R6Lj0UAcagWKWMPSLo3nRN99QmIy1m60msBikUJYza1pTQvfKJ
	SfoiUHv9F7IuMmTxqp1P/IIEa4RrXKGFqTlL2/CPGt+8FuRPr+kr+EiHlRN1X4vU
	IQVmIiKFR2wKiEvU6hI62vw7fsrNMz0WMMY8G4gdwxXmZ3FNjsm4fMvNIT/qVjNn
	fLkdA4oD4iZTWsWMVsdpnQExXje9C68tl0d2DxO1Iuj2xM38kt+dKzuZBKeWXYNf
	ovtPV/7pTCKmi33icOb4icq3ZqFdTNccLfzgoVCbMgh2UA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id DhNk6DIvoEad; Tue, 13 Jan 2026 01:03:14 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dqrb52qbZzlfdfH;
	Tue, 13 Jan 2026 01:03:12 +0000 (UTC)
Message-ID: <777aecd9-4978-450f-8688-74f85e24c372@acm.org>
Date: Mon, 12 Jan 2026 17:03:11 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v6 1/3] check,common,srp/rc: replace module
 removal with patient module removal
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: mcgrof@kernel.org, sw.prabhu6@gmail.com,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20260110101642.174133-1-shinichiro.kawasaki@wdc.com>
 <20260110101642.174133-2-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260110101642.174133-2-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/10/26 2:16 AM, Shin'ichiro Kawasaki wrote:
> diff --git a/tests/srp/rc b/tests/srp/rc
> index 47b9546..517733f 100755
> --- a/tests/srp/rc
> +++ b/tests/srp/rc
> @@ -336,14 +336,14 @@ stop_srp_ini() {
>   	log_out
>   	for ((i=40;i>=0;i--)); do
>   		remove_mpath_devs || return $?
> -		_unload_module ib_srp >/dev/null 2>&1 && break
> +		_patient_rmmod ib_srp >/dev/null 2>&1 && break
>   		sleep 1
>   	done

I don't think that this change is useful since there is a sleep 
statement just below the rmmod call. This change unnecessarily slows
down this loop.

>   	if [ -e /sys/module/ib_srp ]; then
>   		echo "Error: unloading kernel module ib_srp failed"
>   		return 1
>   	fi
> -	_unload_module scsi_transport_srp || return $?
> +	_patient_rmmod scsi_transport_srp || return $?
>   }

This change shouldn't be necessary. Once the ib_srp kernel module
has been unloaded, unloading scsi_transport_srp should succeed.

Thanks,

Bart.
