Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3AE39C635
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692667; cv=none; b=rblN2TueMOD1yHBBvipqWk4DEJyuOZQg48TCSyWBY3i0yv8uZt8gpuQGwSGmxy0ymauviP00kle5AQGXL/yceVxIGuLLOeGXrElPoRPAhPCOt0sTtr2JUwaSP4wNN2CJ+8PlLPGT7QkrWQeX45eOoxY7EKmLWOJIsCVmg9MkEbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692667; c=relaxed/simple;
	bh=fXi9+EE0lFyWarCMNYTRb8+JJAUdViW64eRJ6Q4r3Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hMmJ4/dw4vk3uQBxMieJpsZL6MQVKZyy3nUtu7pTLGIPP85XxDN5NreObLrM6IN0uXaIn48CX8WuTr5PYhQvCbRoI7YhLHW1+Srvb7jY0R7YEPyV3+QlKC7O8fLHTDQ7a+krFqo0rkvKnM7MOaWuU+Vg1ZkNu8D5WMZly9kBWv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=31J5wPR6; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="31J5wPR6"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gG0X45znNzlfvq4;
	Wed, 13 May 2026 17:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778692659; x=1781284660; bh=W5VRl8ltPodg7qMo3kzB1I0s
	0Y0Yl1BeSf/hylmz5kE=; b=31J5wPR6+Crk6+DCaFdiOaR3JAeXMEnvT+TbP8ar
	QPcmi2vm+rv7ksOOgfnW3xc/Y/p2caT83Rbilzi9DIhXTyv9nZMmlv+PbrlsWOKu
	6+KLqCFUq2Q51ildOrgEPafTVFGN1/UJgOn7GzC/YEzy+CzZD08eREH9ye0QDuGW
	Xkv7TeyVpVw8elGMVkaRw3EKOxhPmDkrsftEcxG5oKX8wAzaxILpN2Bvd+Z5yyGi
	3UPIFAK8mCmOaryETBKWFZlDHstnhqLgzsEPLkp4LHL6ukHg2Hx7yjMCOKzMKo1e
	8x0tAqNUopM5HhDNaZwh4ROekPZLQiPrBiVfEv3tbj0TOA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vCwJhxmN0PKE; Wed, 13 May 2026 17:17:39 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gG0X16kX5zlfvpK;
	Wed, 13 May 2026 17:17:37 +0000 (UTC)
Message-ID: <472b55a1-cef3-4473-b8b2-08b501efcd77@acm.org>
Date: Wed, 13 May 2026 10:17:37 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 2/3] common/rc: add _echo() function to trace
 sysfs attribute writes
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>, John Meneghini <jmeneghi@redhat.com>
References: <20260513112326.584256-1-shinichiro.kawasaki@wdc.com>
 <20260513112326.584256-3-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260513112326.584256-3-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/26 4:23 AM, Shin'ichiro Kawasaki wrote:
> +# Echo a value to a file. This wrapper is used to trace sysfs attribute writes

Echo -> Write
file -> sysfs/debugfs/configfs attribute
sysfs -> sysfs/debugfs/configfs

> +# when the --cmd-trace option is enabled.
> +_echo() {
> +	echo "$1" > "$2"
> +}

If this is only used to write into sysfs/debugfs/configfs, there are 
probably better names for this function than _echo, e.g. _set_attr(),
_write_attr() or _write_sys_attr().

Should "echo" or "echo -n" be used in the above shell function?

Thanks,

Bart.
