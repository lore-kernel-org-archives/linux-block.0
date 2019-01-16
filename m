Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06A2C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 22:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC75320840
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 22:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SG2sdomx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732600AbfAPWNc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:13:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33865 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbfAPWNb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 17:13:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so3683183plz.1
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 14:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UX/5xtuAaXTmJVTEaDu2ZMCERupScK6vv2as1/uafME=;
        b=SG2sdomxf7l+KepJWn6zMVDVe+UcalGfDZCo9WcRYFH95xiKmh1Fh4bGD3iWMW5ayI
         mN+71ANPsR3cczoRi88/SVQVtLbrLvINV/JWLmzVEhJAef6yMauIY3/vkmaDmSoSXgtT
         ekPjtGhaNEsGbFh+Ne3W0UBO9lX4YwEiL6sNmbdj73/QUSqE2U4lFYTw1dY//4/T1g3Q
         1oYKHdSY+C8ovjmiMObjyVsHPxYjPfWoGiZe42crylblrB/xOu9q683/7eZwo8HcLN7Q
         kxX/gBZpzyrLrdw1GTWuvKG443GPoJX05lTgnV3aicZO2r+h0bkwJ9En1OgLBRfvamSW
         XS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UX/5xtuAaXTmJVTEaDu2ZMCERupScK6vv2as1/uafME=;
        b=X09ylWAScN63JE0bHP4XyTXpOvv1tvAAqUbquH+0ljwZ8fAsLcAAwgU92Ux+3Vc6us
         jd0pV2Q64cmxZC8m/VfA+JodKJ0tDw00Z4ElsLWArj4MLx8TQi2bfcqUGFL8OcjPvGvi
         phobUnhmz7tAf4Nu02YxTv2dVDzA5BrtE4pvP00ItMQQox+LKYyyRB004rJP5mdmYcCo
         0N/LRQBddwa8jKpq4/yzri1aWsBNNptkd6ubmLLatKfSJjWHlgd5S0pSnb5qOOfOlF0u
         ORIV5JHDKE165t0oJVhOKvqXNFUG0iFiOdpxSFNrU++8hlJxFLaUaf07DHPDf5lVwBQ5
         KxTw==
X-Gm-Message-State: AJcUukdAh6PnD/8UstEDW4dlcSjF+ZQ6l4oDe1rhSDMe8mZFPdIzuIUE
        UDbCnXg1FQRH8Ld0wo+vWhfAHRoSG3R/JA==
X-Google-Smtp-Source: ALg8bN5THmsHxy1YX7rf3ZyRB076aoQr9M5WTxtnJEK76kHqhjKreOKKKsPwYcDH0dNhkiP//R+IBQ==
X-Received: by 2002:a17:902:70c6:: with SMTP id l6mr12492800plt.30.1547676811262;
        Wed, 16 Jan 2019 14:13:31 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id h69sm8067796pge.4.2019.01.16.14.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 14:13:30 -0800 (PST)
Subject: Re: [PATCH 12/15] io_uring: add support for pre-mapped user IO
 buffers
From:   Jens Axboe <axboe@kernel.dk>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-13-axboe@kernel.dk> <20190116205338.GQ4205@dastard>
 <9db63405-6797-9305-3ce1-fdc11edbf49c@kernel.dk>
Message-ID: <e0e574f0-9938-eaba-cffb-c66f754f33c5@kernel.dk>
Date:   Wed, 16 Jan 2019 15:13:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9db63405-6797-9305-3ce1-fdc11edbf49c@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/19 2:20 PM, Jens Axboe wrote:
> On 1/16/19 1:53 PM, Dave Chinner wrote:
>> On Wed, Jan 16, 2019 at 10:50:00AM -0700, Jens Axboe wrote:
>>> If we have fixed user buffers, we can map them into the kernel when we
>>> setup the io_context. That avoids the need to do get_user_pages() for
>>> each and every IO.
>> .....
>>> +			return -ENOMEM;
>>> +	} while (atomic_long_cmpxchg(&ctx->user->locked_vm, cur_pages,
>>> +					new_pages) != cur_pages);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int io_sqe_buffer_unregister(struct io_ring_ctx *ctx)
>>> +{
>>> +	int i, j;
>>> +
>>> +	if (!ctx->user_bufs)
>>> +		return -EINVAL;
>>> +
>>> +	for (i = 0; i < ctx->sq_entries; i++) {
>>> +		struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
>>> +
>>> +		for (j = 0; j < imu->nr_bvecs; j++) {
>>> +			set_page_dirty_lock(imu->bvec[j].bv_page);
>>> +			put_page(imu->bvec[j].bv_page);
>>> +		}
>>
>> Hmmm, so we call set_page_dirty() when the gup reference is dropped...
>>
>> .....
>>
>>> +static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
>>> +				  unsigned nr_args)
>>> +{
>>
>> .....
>>
>>> +		down_write(&current->mm->mmap_sem);
>>> +		pret = get_user_pages_longterm(ubuf, nr_pages, FOLL_WRITE,
>>> +						pages, NULL);
>>> +		up_write(&current->mm->mmap_sem);
>>
>> Thought so. This has the same problem as RDMA w.r.t. using
>> file-backed mappings for the user buffer.  It is not synchronised
>> against truncate, hole punches, async page writeback cleaning the
>> page, etc, and so can lead to data corruption and/or kernel panics.
>>
>> It also can't be used with DAX because the above problems are
>> actually a user-after-free of storage space, not just a dangling
>> page reference that can be cleaned up after the gup pin is dropped.
>>
>> Perhaps, at least until we solve the GUP problems w.r.t. file backed
>> pages and/or add and require file layout leases for these reference,
>> we should error out if the  user buffer pages are file-backed
>> mappings?
> 
> Thanks for taking a look at this.
> 
> I'd be fine with that restriction, especially since it can get relaxed
> down the line. Do we have an appropriate API for this? And why isn't
> get_user_pages_longterm() that exact API already? Would seem that most
> (all?) callers of this API is currently broken then.

I guess for now I can just pass in a vmas array for
get_user_pages_longeterm() and then iterate those and check for
vma->vm_file. If it's set, then we fail the buffer registration.

And then drop the set_page_dirty() on release, we don't need that.

-- 
Jens Axboe

