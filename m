Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D2B1AD405
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896743; cv=none; b=gc9aHnwbH6ji87HrOKUdRg5UilbbWY5OTeFeO67az9bLPiHMCzzf0j16wypVz235oJVTDuijxgdRyYseknjTsnUy81CCWJ8A27vPB49+AiQTzKx9dPOLmCQIwGpAn8szK5evRQ+mz5at+lGCUgMPuoG3inAs3PGEok7F0IAhG9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896743; c=relaxed/simple;
	bh=gKkWo0rcrIjAELXC3rvqdnuDWSiqfQHX4Q+aPrtxxc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsWunem+kf2ZF6Kfa+j9gFa5O/WHk4jGZRw0xLtK592bhjwwUSW0ZWtbAaFgFsjiGcKT3Xm0V+kUWBgbieTZszhxTL77nYsFBE9v6qkK2M7HyCfPtreRQJvVVGZKlO1uR9LDPBbi0SQSoLNT2YCBheYRGaaDwqjQUJWfLMPeGtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3TMjM+Ft; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3TMjM+Ft"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d1b6b6b2c5so39803b6e.0
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718896740; x=1719501540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bg9dUhZOcOBUNZKG8Aq376MeF6BjTDCioQTFTxLs8Rs=;
        b=3TMjM+Fty95tqkl0uq/4UtBZEDu8m0LNe8XEnv04+wV5iogyZjxbUyDAsjr9//MJ7i
         IBDw59Tr3NxJVe4FgapP+nB3RyGf7GlYzcpkIjnoFnbdgwFNtoL33nz9715o8H+ZSQqD
         j4/lAmDnRVZf0rxfYnb66oq3xYU14Tmc207MZS8YcfzURE5fQRgcBrlLWmweXOzWeSTm
         ZmjZ/pzmSTAIe8/NZJ1p95R1aSH4Szk6latO54P948WhjYa3uFfWcybSja4ACVkdQ/eX
         mIsnyuqmvQUFXrBhZc3ghd8KvSUfj32xCr+/YIm2G6n+Q3RfupWGVWso3ld62NAlr+Z5
         r/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718896740; x=1719501540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bg9dUhZOcOBUNZKG8Aq376MeF6BjTDCioQTFTxLs8Rs=;
        b=r6Ac+sPzazjWZlmis1O1o44R7qx7YcNDMsGvBIhvNLDeY2FZRdS0Xfcd9jA2CqBvmj
         6+h2I5in3KNSa1yfhYjW8kTVDawQL3Jm3Puqgbx7qyecmzbMO+DtcPKwmUC4rfzuSDTB
         vJqdef8B6/BX8Oue5IOaLXSHyYuHehLEs6HX4SCJBOuZ4MkNZejxjf0QMwy96VwzrnQq
         jUDFyMHyWc1C28ZHaKlbhjhOWaV4tv0XHOVWFXEMvFJIkMLYsrwX6Q3CaaWPjXsWKZoP
         K9uHplUHcfNr1HvxkFNN/d0gdZz+R0lP+F8uzHaCnDSUcXBe0JGTDSmq2Pg60AeuaQ0E
         Tt0A==
X-Forwarded-Encrypted: i=1; AJvYcCVn+YLkHVL+9CZmYY1TJ8/hcECwAWsKh51yVEYfPBNuk+Sgk7eFK3eriVTpXqCX+18wqb3z1VnIF6sIJw1ld52uYQsWkGgA0spLyoo=
X-Gm-Message-State: AOJu0Yxp+AMGLf69+KB8848GVsP8f0Hpq1WTZJN2ozBYaXTBMiRoLxrO
	k6LcMYQZ+E9TJo8qT6nVgVgqDoGG66nh7m9btmeHhNUlfyI/gHulUV4JU1p9czo=
X-Google-Smtp-Source: AGHT+IFqdBnwgZVg8xIJS0ZdFswsi7ckSZACE4V7rQa8sePkDWpTwP1Yim6PqDI2SIlHvgaftjT1eg==
X-Received: by 2002:a05:6808:1a07:b0:3d2:1b8a:be58 with SMTP id 5614622812f47-3d51bb164eemr6083028b6e.3.1718896740525;
        Thu, 20 Jun 2024 08:19:00 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d247605f99sm2536749b6e.19.2024.06.20.08.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 08:19:00 -0700 (PDT)
Message-ID: <861a0926-40bf-4180-8092-c84a3749f1cf@kernel.dk>
Date: Thu, 20 Jun 2024 09:18:58 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bvec_iter.bi_sector -> loff_t?
To: Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Hongbo Li <lihongbo22@huawei.com>, linux-bcachefs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, hch@lst.de,
 Keith Busch <kbusch@kernel.org>
References: <20240620132157.888559-1-lihongbo22@huawei.com>
 <bbf7lnl2d5sxdzqbv3jcn6gxmtnsnscakqmfdf6vj4fcs3nasx@zvjsxfwkavgm>
 <ZnQ0gdpcplp_-aw7@casper.infradead.org>
 <pfxno4kzdgk6imw7vt2wvpluybohbf6brka6tlx34lu2zbbuaz@khifgy2v2z5n>
 <ZnRBkr_7Ah8Hj-i-@casper.infradead.org>
 <0f74318e-2442-4d7d-b839-2277a40ca196@kernel.dk>
 <ZnRHi3Cfh_w7ZQa1@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZnRHi3Cfh_w7ZQa1@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/24 9:15 AM, Matthew Wilcox wrote:
> On Thu, Jun 20, 2024 at 08:56:39AM -0600, Jens Axboe wrote:
>> On 6/20/24 8:49 AM, Matthew Wilcox wrote:
>>> On Thu, Jun 20, 2024 at 10:16:02AM -0400, Kent Overstreet wrote:
>>> I'm more sympathetic to "lets relax the alignment requirements", since
>>> most IO devices actually can do IO to arbitrary boundaries (or at least
>>> reasonable boundaries, eg cacheline alignment or 4-byte alignment).
>>> The 512 byte alignment doesn't seem particularly rooted in any hardware
>>> restrictions.
>>
>> We already did, based on real world use cases to avoid copies just
>> because the memory wasn't aligned on a sector size boundary. It's
>> perfectly valid now to do:
>>
>> struct queue_limits lim {
>> 	.dma_alignment = 3,
>> };
>>
>> disk = blk_mq_alloc_disk(&tag_set, &lim, NULL);
>>
>> and have O_DIRECT with a 32-bit memory alignment work just fine, where
>> before it would EINVAL. The sector size memory alignment thing has
>> always been odd and never rooted in anything other than "oh let's just
>> require the whole combination of size/disk offset/alignment to be sector
>> based".
> 
> Oh, cool!  https://man7.org/linux/man-pages/man2/open.2.html
> doesn't know about this yet; is anyone working on updating it?

Probably not... At least we do have STATX_DIOALIGN which can be used to
figure out what the alignment is, but I don't recall if any man date
updates got done. Keith may remember, CC'ed.

-- 
Jens Axboe

