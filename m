Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1F8140E29
	for <linux-block@vger.kernel.org>; Thu, 18 Jul 2024 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313324; cv=none; b=mTHV3N3+e8W2fNnf4yV7IvymtUCFmCvepGC5phOr8wExzHo/A39lEH6et2Oe/zNqi/Gvljkiobc1M8kFOhMl9ofPdrA5y65snrUYnP6Z4G4ci5/S4jI2TfG/dtjjbgZSySwZIK7qmP0MPoMGqZv02bHbLBjFxEFYb3dVC0d9lJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313324; c=relaxed/simple;
	bh=tEtMW0Cf1jm3biFkQzRO7oPa3CeZmN5Yfqoo/kRz1lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMLojLRsU0R+yNa8jHeirUKkXx8hGu3hrp6uqWwpqRoKKHLyACfgDpButQemwMqOKO6Y6iYNMU6UIv2NIZm/EIY9aQaKEBlq6zQklBJD0gSkEBuD/AzvhXvDoPCxoPHc7VvOK5VtPDyFlWpyDPqeJrxzOsqMQIZ2U7bnMU2udpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=bHuqSYe5; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="bHuqSYe5"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WPwM825jyz6CmLxd;
	Thu, 18 Jul 2024 14:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1721313314; x=1723905315; bh=r6WUwL/AfTAg9k1QGtJY47h5
	tBIVOkzCh9ntIdhu1rE=; b=bHuqSYe5G72TAkCmGwlNsDahkRrCnIgnWin59G5Q
	kG6VaIsXTuMEquYI8AXHzjc38rtgaFYxmWx4VKcbojWzpIw3B4Jf6gn+vXnp0vCb
	LZBRqkkfW+60/KyHyg/+dET4FxLD123IQ6GjzL5CyTqUwkKgeiWZ1yBn2STbY6ct
	zc8FImVQ0SmLQp0VHs5aFm4WcfgOk+HEPo0D3ByGz5fID+pr6LZDFWumGtagK9Ca
	4ca+bECAy9jDUXXnnaKxspEhQHduOD2Fr/asCyGrMuIg4UW7JBIKfQ58cYXCYX0x
	iSUPOPQp5hFtXlajZJ2NP7pAbA6fgdgK2Amq71kQdcC5HQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id SdmrPCUDONgQ; Thu, 18 Jul 2024 14:35:14 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WPwM62lPWz6CmLxY;
	Thu, 18 Jul 2024 14:35:14 +0000 (UTC)
Message-ID: <72c1c93e-4ee0-4830-8950-ecfd72c0e102@acm.org>
Date: Thu, 18 Jul 2024 07:35:12 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nbd/rc: check nbd-server port readiness in
 _start_nbd_server()
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, nbd@other.debian.org
Cc: Yi Zhang <yi.zhang@redhat.com>
References: <20240718111207.257567-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240718111207.257567-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/24 4:12 AM, Shin'ichiro Kawasaki wrote:
> +	# Wait for nbd-server start listening the port
> +	for ((i = 0; i < 10; i++)); do
> +		if nbd-client -l localhost &> "$FULL"; then
> +			break
> +		fi
> +		sleep 1
> +	done

Has it been considered to reduce the delay from one second to e.g. a
tenth of a second and to increase the number of iterations? I do not
expect it to take one second for nbd-server to start.

Thanks,

Bart.
