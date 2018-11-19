Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13B0C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 02:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53AD220684
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 02:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0n4W88YI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AD220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeKSNU7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 08:20:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42470 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbeKSNU7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 08:20:59 -0500
Received: by mail-pl1-f195.google.com with SMTP id x21-v6so11108527pln.9
        for <linux-block@vger.kernel.org>; Sun, 18 Nov 2018 18:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vBVN19zWPLt6v84wvKjJQaFm+7lsxHDsizcvo7CBDcI=;
        b=0n4W88YIrQxwE5Lm0MVL3WgMIZlUmlDWIbXqNiCsmcA4wX/6Hecm1ZIGqsYHaXIZqU
         9Wyn//VmJk4t27tGEAyKWVxdE4ZtBsFnni8wmIB5+Gt3YvLzBD1uqyGpWfQsBHchiASP
         ti5EHKVqlGRgzDuYbUA7ecX8Wvgn1FtIusVIT1abWfvSFwfuKT/F7VDfI95KBhZPgkbd
         DjQmriP1ey7MIfyQelmo0CjYV9u3Msrit9iI9LQ+9JgQTPOBFjAJvUFd5j+H6rl8Rla+
         9eRFUuPLQfRhP1aUbPgDgZgw5jBq2DU23ksZ6fe+pbAP9DoG/4SC2tYMs5q2RDoZ1VuI
         AWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vBVN19zWPLt6v84wvKjJQaFm+7lsxHDsizcvo7CBDcI=;
        b=qxQ/iS16Prg96QHGyeIhToPh4OjR0EXit3PrITQfgQu+zGvNa3TH5ld35njvxHoZEw
         dAmflQeHkhYOP1zSfdxxkFrYJBMY99rYh5CiTvp+beMcqVbI63gi+KV5g1E07A7ma/Hv
         8iDujWMyeffgz5keE7JZVis03x3HiiU/S3QObBe+KXNCHUWoLbk1qitixXVnAFLWntmy
         5aKgszN0ohu4w9lWY9qIF6mzaPTi16p8HXqnqUOnY3h9ji3uIR/qr3I/fiy8157Gm9ow
         sfhHa7PO22vd/rZcm8frohK7/PVnfOeXT7xYfMYbqikrgyM9v3AMUtz5SMUaFm1Lmxrn
         s6aA==
X-Gm-Message-State: AGRZ1gJQcMY8+p1ZgzD2sBFw/spbHt9EZ6FoVI1D8PgNfbz1UxUrbOXg
        R6WUokPyzeZNF/HuxRyeoCxGOg==
X-Google-Smtp-Source: AJdET5ez/4QiXy/XPAniUnDPJsF15QNUf7m0FRJ0qeF1kX8XBKbemT/ThlkVBzC7Oy9W+85KYIu3xg==
X-Received: by 2002:a17:902:8214:: with SMTP id x20-v6mr19800990pln.224.1542596329232;
        Sun, 18 Nov 2018 18:58:49 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id x27sm48756195pfe.178.2018.11.18.18.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 18:58:48 -0800 (PST)
Subject: Re: [PATCH 5/5] aio: add support for file based polled IO
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20181117235317.7366-1-axboe@kernel.dk>
 <20181117235317.7366-6-axboe@kernel.dk> <20181119015753.GP6311@dastard>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7584365c-829a-e97e-74b0-4b89bfa9a7da@kernel.dk>
Date:   Sun, 18 Nov 2018 19:58:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119015753.GP6311@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/18/18 6:57 PM, Dave Chinner wrote:
> On Sat, Nov 17, 2018 at 04:53:17PM -0700, Jens Axboe wrote:
>> Needs further work, but this should work fine on normal setups
>> with a file system on a pollable block device.
> 
> What should work fine? I've got no idea what this patch is actually
> providing....

Sorry, should have made it more clear that this one is just a test
patch to enable polled aio for files, it's not supposed to be
considered complete.

>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/aio.c       | 2 ++
>>  fs/direct-io.c | 4 +++-
>>  fs/iomap.c     | 7 +++++--
>>  3 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/aio.c b/fs/aio.c
>> index 500da3ffc376..e02085fe10d7 100644
>> --- a/fs/aio.c
>> +++ b/fs/aio.c
>> @@ -1310,6 +1310,8 @@ static struct block_device *aio_bdev_host(struct kiocb *req)
>>  
>>  	if (S_ISBLK(inode->i_mode))
>>  		return I_BDEV(inode);
>> +	else if (inode->i_sb && inode->i_sb->s_bdev)
>> +		return inode->i_sb->s_bdev;
> 
> XFS might be doing AIO to files on real-time device, not
> inode->i_sb->s_bdev. So this may well be the wrong block device
> for the IO being submitted.

See patch description, XFS doing AIO on a real-time device is not a
"normal setup".

It doesn't work for btrfs either, for instance. As far as I can tell, there
are a few routes that we can go here:

1) Have an fs ops that returns the bdev.
2) Set it after submit time, like we do in other spots. This won't work
   if we straddle devices.

I don't feel that strongly about it, and frankly I'm fine with just
dropping non-bdev support for now. The patch is provided for testing
for the 99% of use cases, which is a file system on top of a single
device.

>> diff --git a/fs/iomap.c b/fs/iomap.c
>> index 74c1f37f0fd6..4cf412b6230a 100644
>> --- a/fs/iomap.c
>> +++ b/fs/iomap.c
>> @@ -1555,6 +1555,7 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
>>  	struct page *page = ZERO_PAGE(0);
>>  	int flags = REQ_SYNC | REQ_IDLE;
>>  	struct bio *bio;
>> +	blk_qc_t qc;
>>  
>>  	bio = bio_alloc(GFP_KERNEL, 1);
>>  	bio_set_dev(bio, iomap->bdev);
>> @@ -1570,7 +1571,9 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
>>  	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
>>  
>>  	atomic_inc(&dio->ref);
>> -	return submit_bio(bio);
>> +	qc = submit_bio(bio);
>> +	WRITE_ONCE(dio->iocb->ki_blk_qc, qc);
>> +	return qc;
>>  }
> 
> Why is this added to sub-block zeroing IO calls? It gets overwritten
> by the data IO submission, so this value is going to change as the
> IO progresses. What does making these partial IOs visible provide,
> especially as they then get overwritten by the next submissions?
> Indeed, how does one wait on all IOs in the DIO to complete if we
> are only tracking one of many?

That does look like a mistake, the zeroing should just be ignored.
We only care about the actual IO.

-- 
Jens Axboe

