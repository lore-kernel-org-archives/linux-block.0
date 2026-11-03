Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793682349;
	b=spyOZnVzz4I3X3VEfM5nQba5dIk2N+IG+qE8ue3QSD/+l5TFJAyriTI9nakTBwu+7RJP
	 kyf0E+CP8Jbq6gdp3bIw3q+VtczBkq2MohAbTKcdfQegfTliT43h648q764Z0w8W0KFtf
	 Ue4q4RO7F3xnAd1PUGf/vBHVII2tyAhW2HKrsCoTZjE5GnNgc7Z15VHIURcFYQJJMKcfT
	 kRKYzEdAdtYca3kaJH55SZjntK4LtNT26U7AtDhrmkcMeyVu5SlYd12TTAfvIKKGtaxAw
	 25fDo6ZXIydjvGOj6X/XbCaXa9pZDtpHz1zIAcDGJIkXGAZEMoOV+0xFWo1xQ4LCZ1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793682349;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Wy1B7kK31jh2U/Ek3h8NaYXmd8oP124iADt0yBcYVuo=;
	b=1/Jm9LRKVfWZNY1xdI+w9HFhIHAn1HITEQVolnf0chF3ja5H+/rhtG679m16TRSN6mDy
	 UHVkI/gDNbznxrzPvGM6PtvStxrDtnGqOEJugxIjk/KaWCJc5TGA8gq01B8Q01204DDe4
	 AZykGcKFlmpQnmFE6/HfghuAfRTk6NLDu5RjTKCKK2KWWVpBPRoSbhPbbEjZfBHyQ3Kko
	 OOt5rSQen/le6+ZFdyFOyaIZObCmG+0kIlg1rV8a/Mva8C/OdShQ3FP+0PU74qlrdc8dI
	 bjCx9OfrG81vHUy0G8vwJoF074Mln6nl5LzQWxnwn3T1sK2RFK/pEROwPZn6QGqPydQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jIIfcR7H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B58606A326;
	Tue,  3 Nov 2026 05:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jIIfcR7H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E061F000C1;
	Tue,  3 Nov 2026 05:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793682349;
	bh=Wy1B7kK31jh2U/Ek3h8NaYXmd8oP124iADt0yBcYVuo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jIIfcR7HJwB84zqnAdDFom3Zyliu689D31HB2GRVWvl+Xw/9dIdDWfvBgxEvKb81Z
	 Z4yYgzXIE9EHQs9UCzmFc0dd1FovoSScM7uI7Mjljmre41ew7B2UtwBWH/gpF5wWth
	 Yn582gWoZMQFPcBlr5TMcA9EeZ+JhYRW6QY4fPcQ0T9Z63mF9OWE15HThru8YR2Ts+
	 a8QDiSxk7blnwW+vkHlQdiKbVWKzvGulSPI4NlDMVk82B/JvDFXGzUYFZIsOSJPW2e
	 3NYQ0w4MHLYL+YX7lYWe/kpojNMUIgpnsc1Ng2MFR6Xlv09Hhhvu/MAPf8YO2bLs7n
	 pTL88kQLGfrxQ==
Message-ID: <80a2d229-f4c5-441f-bcca-1a201ff5c271@kernel.org>
Date: Tue, 3 Nov 2026 14:05:47 +0900
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zloop: fix the error code in the blk_mq_alloc_disk
 message
To: shao.mingyin@zte.com.cn, hch@lst.de, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org
References: <20261031221737569WQ3bg8y80Ht7JdTCWwlkL@zte.com.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261031221737569WQ3bg8y80Ht7JdTCWwlkL@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/26 23:17, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> When blk_mq_alloc_disk() fails, "ret" still holds the zero returned by the
> preceding blk_mq_alloc_tag_set() call, so the error message always reports
> "err=0".  Save PTR_ERR(zlo->disk) in "ret" before printing it, like the
> blk_mq_alloc_tag_set() and add_disk() failure paths do.
> 
> Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
