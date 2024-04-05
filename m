Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C95C16C858
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338955; cv=none; b=jcx4BMIznhb6ULHSz7zaXVNItO4qxuwMXHdBQwB75oA2JJwltnqH0dUmSo6ou9WOy516InqcpjTIWaM+/OPOJX9KdpsPKLOWogQq/T/iLe5IClnzeDkFsGaTwCGmeo3X3y+BBEjZQ0cFdfrv7K1ij+SdtEQ3iorl5TAsNhYJcQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338955; c=relaxed/simple;
	bh=q/t2qHAdejz1vkqTfeF6sfeW1vRNFkF5MWaJrSLZSSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fNzDVFIJTlaRwsthu17wkaYe4Ip1egMzcvcsskN5GEK8dwHAoUJWwRun7SO9P2fQa7lJatY1C5YYnghmXo/p7roOdPQfSrvcBCVWpi6X57q+ECBtK6Y2p99eZfvITeC/+Xwks691CpdCp+0x/WaHIps7NibrtOypI+UcfY3Eojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=exfKbLoh; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="exfKbLoh"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VB5RF2TYWz6CkbBM;
	Fri,  5 Apr 2024 17:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712338952; x=1714930953; bh=Iup0wHytOIYxNxU8CEc4IJRl
	N6GAUd5Z7lQdgSAcOGY=; b=exfKbLoh0xBpVYujv3ktjfyiPrDpXDeibcZ+qeWu
	RMzrY/ygXgm3s/X7IQu/hbYfmy+IzhuLXV7MnGZcj4FE+PmXTb8Ly3YF7RlrlzA9
	5Xx26DEjBTL37h7Ce0wZ0u5yBgEM8xayC3beuZRXsIYMj9L1YeXGzPE1JeANpKG+
	JOhL6RrblexJDwIuhvyM03XTul6gdO6d4jRbUwP/inbekU5tPSoVgzUH9iLWtQZk
	iBy+L3wbs6eYihWm+I6ycGlzNHNdWmAV8BbeCrracjuwSpJEk3+N+pI7PAQbzAbm
	ASZ28A2NEUl7Uj0gLev5x5UGW5P3DUSpr+BTmwW5GuIycg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PS28SUSFAfbt; Fri,  5 Apr 2024 17:42:32 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VB5RC3Zf9z6CkbBQ;
	Fri,  5 Apr 2024 17:42:31 +0000 (UTC)
Message-ID: <be24545e-55b9-4fa5-8189-263f981f50d2@acm.org>
Date: Fri, 5 Apr 2024 10:42:29 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: sysfs-block: document size sysfs entry
Content-Language: en-US
To: Tokunori Ikegami <ikegami.t@gmail.com>, linux-block@vger.kernel.org
References: <20240405165434.12673-1-ikegami.t@gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240405165434.12673-1-ikegami.t@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/5/24 09:54, Tokunori Ikegami wrote:
> Document it since /sys/block/<disk>/size is undocumented.
> 
> Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
> ---
>   Documentation/ABI/stable/sysfs-block | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index 7718ed34777e..881049419054 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -707,6 +707,13 @@ Description:
>   		zoned will report "none".
>   
>   
> +What:		/sys/block/<disk>/size
> +Date:		April 2024
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RO] This is the 512 bytes size sector number.

What is a "sector number"? Please change the description into something 
like the following:

   [RO] Size of the block device in units of 512 bytes.

Thanks,

Bart.

