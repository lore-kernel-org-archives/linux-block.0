Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8665DC54EBE
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 18:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjAPSjT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 13:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbjAPSi3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 13:38:29 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B666F468E
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 10:30:56 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id g23so15534835plq.12
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 10:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gPWrS3SWlH32/5t1p88eL09GsgqLjjKNrgDvPiBDAF4=;
        b=QAvy7cthbviMokX+abVSF122VF4d258/2YTgpj8poPNmtRIFG1RVOaN+P8yR2Etn2F
         bsOpgTSYQ4LWz1Zzs/CyByJveYaLBlEzfWyToZ1p+WKg8PRxJ1Jk0U9fbTYdsgT0Zs6G
         zaNIDtNZETRNVyC2737O3o7+6a2+rydf5p+FzUxyJhmHpO90kKfIHtw7u971ushu10t2
         92b/7sZ/rcXGQNhaC2AbG30UmsFDPyDXukwDSpEv0oR7/DcakCSGK7gNGlVnj/e0b/2K
         e/0wq88QdevDRFl/X1LrrQKK3bAnlps/Sq6ernzAblRETM3mm8dEwmMDf54LkjhFYgkJ
         7yBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gPWrS3SWlH32/5t1p88eL09GsgqLjjKNrgDvPiBDAF4=;
        b=hVn9Y3g2t2zwmIhoSesQ7Eei2n7xIIfa3Y0GzEyfIzz0o/CJJ473Efbd4xOKLA2BZO
         mCjbj3eR6RzKg+M8CGa2ZC+0fYAkCBxMM8cWoXeCOjHBMWtC2G5VI+YivUXgwKwOeTtR
         7LpcZuKSQm8WeafsMmyTmpPTs7okAv70JfpKkxO/Pzk9zaPPks5Ym1P/6D8+sOp5q3Pf
         c5kiHHGh869zNo+QVPtM6vVtDKccVw/GKKb5JhHak4ZxOlFwtkyrhkxokbwiEVHBR9T3
         6n3TzFog99tFwPowMgvkZI5x/43Okd2EHgMMt4JHvKPqHYOYMWIWOYOE0kYKKd30bQ3O
         XdfQ==
X-Gm-Message-State: AFqh2kpuNQRKuVW54HP4uJma8zclpRQocXNs9nV6CCHhGGZbwMha2wkF
        DYrMlFuhxAmp9vII7hvzAycg9KXaiyhUEPLd
X-Google-Smtp-Source: AMrXdXtnUTcVG7FLVrm/AO/kpg+HkAHLqB2bmKZvM7EYXlzZMHDfHtVMC+HTjXttBQ56Ti4d3ccxwQ==
X-Received: by 2002:a17:90b:886:b0:221:705a:7e96 with SMTP id bj6-20020a17090b088600b00221705a7e96mr69599pjb.2.1673893856061;
        Mon, 16 Jan 2023 10:30:56 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n10-20020a17090a394a00b0022979c9959esm1796603pjf.57.2023.01.16.10.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 10:30:55 -0800 (PST)
Message-ID: <9bdd64c6-2c8e-cfc9-059b-2922ce685994@kernel.dk>
Date:   Mon, 16 Jan 2023 11:30:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] block: don't allow multiple bios for IOCB_NOWAIT issue
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
References: <c5631d66-3627-5d04-c810-c060c9fd7077@kernel.dk>
 <Y8WOuHQ21PP/W6Rv@infradead.org>
 <ec218e9e-5433-c6b5-a6a6-85a64fd2ea7f@kernel.dk>
 <74da71bf-d352-0aad-3cb5-3d65cba5bc24@kernel.dk>
In-Reply-To: <74da71bf-d352-0aad-3cb5-3d65cba5bc24@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/23 11:15?AM, Jens Axboe wrote:
> On 1/16/23 11:03?AM, Jens Axboe wrote:
>>>> +	/*
>>>> +	 * We're doing more than a bio worth of IO (> 256 pages), and we
>>>> +	 * cannot guarantee that one of the sub bios will not fail getting
>>>> +	 * issued FOR NOWAIT as error results are coalesced across all of
>>>> +	 * them. Be safe and ask for a retry of this from blocking context.
>>>> +	 */
>>>> +	if (iocb->ki_flags & IOCB_NOWAIT)
>>>> +		return -EAGAIN;
>>>>  	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
>>>
>>> If the I/O is too a huge page we could easily end up with a single
>>> bio here.
>>
>> True - we can push the decision making further down potentially, but
>> honestly not sure it's worth the effort.
> 
> And even for page merges too, fwiw. We could probably do something like
> the below (totally untested), downside there would be that we've already
> mapped and allocated a bio at that point.

Was missing a plug finish, but apart from that it works in testing.
Question is just if we end up doing the punt anyway in the majority of
the cases, then it's slower then it was before. If we end up skipping
some -EAGAIN's, then it'd be better. Even without huge pages, I see fio
runs that have a 1:1 ratio between them (eg we always end up punting
anyway), and cases where we now do zero punting. This must be down to
memory layout - if we can successfully merge pages in a vec, then we
don't punt anyway.

I'm leaning towards the below likely being the more optimal fix, even
with a worse worst case behavior of punting anyway and now allocating
and mapping data twice.

diff --git a/block/fops.c b/block/fops.c
index a03cb732c2a7..1a371f50cb13 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -221,6 +221,15 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 			bio_endio(bio);
 			break;
 		}
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			if (iov_iter_count(iter)) {
+				bio_release_pages(bio, false);
+				bio_put(bio);
+				blk_finish_plug(&plug);
+				return -EAGAIN;
+			}
+			bio->bi_opf |= REQ_NOWAIT;
+		}
 
 		if (is_read) {
 			if (dio->flags & DIO_SHOULD_DIRTY)
@@ -228,9 +237,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		} else {
 			task_io_account_write(bio->bi_iter.bi_size);
 		}
-		if (iocb->ki_flags & IOCB_NOWAIT)
-			bio->bi_opf |= REQ_NOWAIT;
-
 		dio->size += bio->bi_iter.bi_size;
 		pos += bio->bi_iter.bi_size;
 

-- 
Jens Axboe

