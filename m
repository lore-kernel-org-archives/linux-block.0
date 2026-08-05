Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33143DEAD6
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965367; cv=none; b=eysStzMUvfqb9BQf4G7GDSCjNV37NY0MRghciOGZhzio+xdR/b6mt7TsH/0nkP2ZDQ89pJttepOmfATJ3/LyRXT1wKJN7YKXDKpVoXuZ+35hXPhlIl6jHzfPAWbi2dWjKhdIt+j5dN+ctjD+DUdlrYYAI4ILoyXHQsciRLuJ320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965367; c=relaxed/simple;
	bh=IjUZsoMQSq/bLBWZASFfsqdiMwzLOxTwXhrNoRRKQ+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQks6AZSdjYF+a8vII2yCVJQQW/aaz/C4JtIrvR29JQLSexmTqeXZeUv9EIkiO3IvDf9HJTeObhYNAqN8uxSYq90z2at0ueq9AoL7xzplO3Znnm5/Odfct8+KBrfLKbfulTn+WX+ORZMGHpHZZAWb+cMVCyKsuxPnHvV7MBWyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=epjrBEri; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="epjrBEri"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hFk7h22Ghz1XM30n;
	Wed,  5 Aug 2026 21:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1785965358; x=1788557359; bh=jUwFTuFb39aDyfjhkgn2uTHK
	QT5oTeDp+DssSA3Y5D4=; b=epjrBEriCJJxG/moxMIAT6hHSEP/ilaDhZi04j2u
	3hdkRa2tj4ktSEtNnu5wNfpiPlwEBmYoDz+l6+PiK1f9pA7ZOHXKIgJ/p8Yyx82h
	XkyEkUtyOnmIOg90IUmf2H5SFH1EDCR4Fn+RoYNqw1jWCfurs/jHJXhiBlttRHn7
	HTUY0HIa3Tm+fWoVbcqMX4D/xP4pDdtH3WkIDHZfgdVZap2X3P8bP46KylJbr/du
	slZ6tGTegEL+L54KAhlj6am72xiYBBsHZaFqkRHP7cpxXzQANrz8ZQeW0JPSIwhs
	HbrpoMDPgYPFmxzTnV9fOlhskT7xzi7dAHTUAYeCVqtJLA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id jdjtnfxj8npx; Wed,  5 Aug 2026 21:29:18 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hFk7c4Tm4z1XM4TB;
	Wed,  5 Aug 2026 21:29:16 +0000 (UTC)
Message-ID: <cd780cfa-068e-41d5-b7df-35558056a1f6@acm.org>
Date: Wed, 5 Aug 2026 14:29:15 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] block: fail reads to offline zones early
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260805022719.735323-1-dlemoal@kernel.org>
 <20260805022719.735323-15-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260805022719.735323-15-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/4/26 7:27 PM, Damien Le Moal wrote:
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 80a4e2bcc3f3..a5c4fcd210bb 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -866,6 +866,11 @@ void submit_bio_noacct(struct bio *bio)
>   
>   	switch (bio_op(bio)) {
>   	case REQ_OP_READ:
> +		if (bdev_is_zoned(bdev) &&
> +		    bdev_zone_is_offline(bdev, bio->bi_iter.bi_sector)) {
> +			bio_set_flag(bio, BIO_QUIET);
> +			goto end_io;
> +		}
>   		break;
>   	case REQ_OP_WRITE:
>   		if (bio->bi_opf & REQ_ATOMIC) {

This change might have a slight negative impact on the performance of 
the hot path for all block devices. Is this change really necessary?

Thanks,

Bart.
