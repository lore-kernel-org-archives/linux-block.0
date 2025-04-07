Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EBD846D
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034361; cv=none; b=Zf5+JC5laknLk+RDHErywQhgxZJAyPENrUsIdFXYxyfT+2eyUPUYEhTeVDqpwILCk/OL97r+3539Rd+OijgMGruw5q/0U0TMD2E5JCs/lpXaLZg5Y/bizWBNGzblQ9jK7Z871X+bLp+UPK6iK/KDFP8hn7H25qGXOeLi7RYM8Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034361; c=relaxed/simple;
	bh=xB7vibHM+7qIn0NcIAyAvl+pbDDDLtxq72ruMTUNZqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7f8fjaC19eR/REq8zekNEPJMpVX07yHTYRta9v6wStoUNc+1RVlf0RX8ZHSNCzXxaSfJlObHaRxncaaYowYrzoJ4kM5UcdeMTQVuLPgMrWZw1jA9bCH5XsTdjvGszKtZo2CpRginzvTqjAqifPd/NKqFDCiZthVe3hwkhAQFaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFAgnUti; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFAgnUti"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8ff1b051dso7895866d6.1
        for <linux-block@vger.kernel.org>; Mon, 07 Apr 2025 06:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744034358; x=1744639158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b+p7u5FdlfThNBRjpUxwLrX7JQ4X7Ee79QhKDIgPRZs=;
        b=BFAgnUtibOBAStkqgdD0YKyk0vYrK00Jr3JNzXiMXZa/0sbL33RX5C14QPfE4k80cj
         ODb+mUBPO0LiAJwzok53bdLQ9VBGWBQZ80PjC3SZ7AV7ZMcaB0DEeO8Y2JrxAyIqHlad
         upK9kz46gd4rSsorCJvHUTtgy42BjXagab3FsUGt5BSA0FQTAG3Syb6HxTjaVAVyr8zC
         8hN/YzXhuu7h4pAPLUaRr/RHviXbcQcODSfc2Hg66KVqilIhjJonJDk9xu5HX+U8CIv9
         2vnhsUE4jR+vHSWE1Up6VIy55/7z0nj+POLq1NSAFtYTW4xSxoTtCXqdsOc7+bh74bjR
         PgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744034358; x=1744639158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+p7u5FdlfThNBRjpUxwLrX7JQ4X7Ee79QhKDIgPRZs=;
        b=S66lHDpcBGaDvgnQnKstqTc7/eTsP04dbJ4miasXLGz9wdAgBf9jVwuuHAUJGrK7Ma
         BwRu/fiwYszpFA0vSuc4q43kygbHMF0+JWgNQTtGzlK7H/7+NrJpEnlyLe9S702L6n1s
         gGtWlP1TMfI2gr7T2BXRm+bzWonB7bHCyYRFjcJKITgk7qDQZUkbRBDYcycg0mOjdrNi
         ZkTm+bm+tQoPF/zEoiz6iIPqCOzdUjzirEMnByPWw6PB6hiJgnRGa3rE20rC3PiEKPlF
         IMa7vFONKXXcAnpOpRco4FV0MNsxoHgP2C0HtdLV6Fo4xRLAH/SgXrxdpPsrEcQ/hr1P
         k9dg==
X-Forwarded-Encrypted: i=1; AJvYcCW9xAu7uIC9x+hy3blgB7zvzagqkFgWlXIvDB9MPGwYxfLHbBY8RVlhsG59ZwVGSBWZOIotTWP87Wsa2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUeN6oQJgYPcv5RtWX7DWV8a2ZxbvYioKKgH6s7yr+RLPFkuS9
	Vkri3rjfKJFb5P1qZVWbVjGuHZD1rcVZUjqJXT/eGD+xIjTE1siC
X-Gm-Gg: ASbGnctjSIZ7gcbudxlwwvuGjvXAgsuU2AHVcPF6wNEL1zeK+QInyh8c5wO/V5Bcv+3
	uLJZYtnib/PKTxM+othmtDOVZP6LNqe9AMkiOW1QdVUoUMtrsTtdXEqrrmciVhyIX9abln+Birx
	KB5yPdeg3k0Ab+UcRtGq5HcoZsAUNeXT6Pljjfx95xqYIq5AuY4KqX9n8HS9+R2mtpBWCJPhhM9
	Pfi3CdkUUuuCwQzGnq2Xv1/Xh+DwPZoEHsUY9L7XOv6i0kmq3IeJEuLu0bpUl04Larflxo0WBe1
	O76dSHhCzyhDk250yndBHkyrmcuaY1ZCR3iwudcZGsTNEshfs04bHeaFX/U+4RCSveJG8OCDfYh
	tGMwx1kIO9jKf4wk9CT3j
X-Google-Smtp-Source: AGHT+IEcQkEG7UiDHZ8FfbWwLtLbiboJYSgLM4hyRK7ffo3V8W1s4yWgT3tOy+x7J0LtvNUUUMS1zQ==
X-Received: by 2002:a05:6214:2486:b0:6e8:f589:ee3c with SMTP id 6a1803df08f44-6f00deee8admr57938826d6.4.1744034358460;
        Mon, 07 Apr 2025 06:59:18 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-176-137.washdc.fios.verizon.net. [108.48.176.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f1501ccsm58215336d6.118.2025.04.07.06.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 06:59:18 -0700 (PDT)
Message-ID: <28cd9608-5c62-7acc-ed52-41c9a74e8724@gmail.com>
Date: Mon, 7 Apr 2025 09:59:16 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: bio segment constraints
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org, Zhihao Cheng <chengzhihao1@huawei.com>
References: <8dfd97ac-59e7-ae69-238a-85b7a2dae4f1@gmail.com>
 <Z_N5nxLDOBb5NDAM@infradead.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <Z_N5nxLDOBb5NDAM@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/25 03:07, Christoph Hellwig wrote:
> On Sun, Apr 06, 2025 at 03:40:04PM -0400, Sean Anderson wrote:
>> Hi all,
>>
>> I'm not really sure what guarantees the block layer makes regarding the
>> segments in a bio as part of a request submitted to a block driver. As
>> far as I can tell this is not documented anywhere. In particular,
> 
> First you need to define what segment you mean.  We have at least two and
> a half historical uses of the name.  One is for each bio_vec attached to
> the bio, either directly as submitted into ->submit_bio for bio based
> drivers (case 1a), or generated by bio_split_to_limits (case 1b), which
> is called for every blk-mq driver before calling into ->queue_rq(s) or
> explicitly called by a few bio based driver.
> 
> The other is the bio-vec synthesized by bio_for_each_segment (case 2).

I'm referring to the bio_vecs you get from queue_mq. Which I think is the
latter.

>> - Is bv_len aligned to SECTOR_SIZE?
> 
> Yes.
> 
>> - To logical_sector_size?
> 
> Yes.

OK, but...

>> - What if logical_sector_size > PAGE_SIZE?
> 
> Still always aligned to logical_sector_size.
> 
>> - What about bv_offset?
> 
> bv_offset is a memory offset and must only be aligned to the
> dma_alignment limit.
> 
>> - Is it possible to have a bio where the total length is a multiple of
>>    logical_sector_size, but the data is split across several segments
>>    where each segment is a multiple of SECTOR_SIZE?
> 
> Yes.

...if this is the case, then for some of those segments wouldn't bv_len
not be a multiple of logical_sector_size?

>> - Is is possible to have segments not even aligned to SECTOR_SIZE?
> 
> No.
> 
>> - Can I somehow request to only get segments with bv_len aligned to
>>    logical_sector_size?
> 
> For drivers that use bio_split_to_limits implicitly or explicitly you can
> do that by setting the right seg_boundary_mask.

Is that the right knob? It operates on the physical address, so it looked
more like something for broken DMA engines. For example (if I recall correctly)
MMC SDMA can't cross a page boundary, so you could use seg_boundary_mask to
enforce that.

>> make some big assumptions (which might be bugs?) For example, in
>> drivers/mtd/mtd_blkdevs.c, do_blktrans_request looks like:
> 
>> - There is only one bio in a request. This one is a bit of a soft
>>    assumption since we should only flush the pages in the bio and not the
>>    whole request otherwise.
> 
> It always operates on the first bio in the request and then uses
> blk_update_request to move the context past that.  It is an old
> and somewhat arkane way to write drivers, but should work.  The
> rq_for_each_segment looks do call flush_dcache_page look horribly
> wrong for this model, though.
> 
>> - The data is in lowmem OR bv_offset + bv_len <= PAGE_SIZE. kmap() only
>>    maps a single page, so if we go past one page we end up in adjacent
>>    kmapped pages.
> 
> Yes, this looks broken.
> 
>> Am I missing something here? Handling highmem seems like a persistent
>> issue. E.g. drivers/mtd/ubi/block.c doesn't even bother doing a kmap.
>> Should both of these have BLK_FEAT_BOUNCE_HIGH?
> 
> BLK_FEAT_BOUNCE_HIGH needs to go away rather sooner than later.
> 
> in the short run the best fix would be to synthesized a
> bio_for_each_segment like bio_vec that stays inside a single page
> using bio_iter_iovec) at the top of do_blktrans_request and use
> that for all references to the data.
> 

OK, but if you have to stay inside a single page couldn't you end up
with a sector spanning a page boundary due to only being aligned to
dma_alignment? Or maybe we set seg_boundary_mask to PAGE_MASK to enforce that?

--Sean
