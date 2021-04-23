Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C976C433B4
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 21:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE8661422
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 21:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhDWVoj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Apr 2021 17:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhDWVof (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Apr 2021 17:44:35 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA42C061574
        for <linux-block@vger.kernel.org>; Fri, 23 Apr 2021 14:43:58 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u14-20020a17090a1f0eb029014e38011b09so1977790pja.5
        for <linux-block@vger.kernel.org>; Fri, 23 Apr 2021 14:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/A9dfiq2GqipA2zAm/PsVQWh2gbROzCfpK+hnlsKU2w=;
        b=itjAnoPOtJtU/K110v60w8iP0JoeqaMOIDOJwGklo8Su8HI536/mjWPfPlCg6+UMs8
         jtC2ZJOzkSp7MC5QjbU9nmumwnBjByV/29UkcGfFSNVUjPYskHHJNK3kcBrQw5pgJZlh
         F11G2YAJl4Ss9qW3qWJAN7ao3pzRnVqAT+4mFSrwRTyang0l+PLxiJDElpqNTJXET1mr
         R6Z+iQES7/ENvt7ZGLS4Zq+1+rY18IeAN40Ybw//wIPLmR+wjxJyUFb3BMiOR1qtyDpJ
         I8iY0Iilg905Wc/PGV+C5G4bX2LpuJDHrw6tffoIt5Z4VqoiOmkyEibTTBK3VCCM6sh1
         nM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/A9dfiq2GqipA2zAm/PsVQWh2gbROzCfpK+hnlsKU2w=;
        b=lbdo1lD1S1+J1400RwODlL1JlQYlx5kyr3NNZOVWPMRDhdGNjqLTFsxuetz4wFS2Og
         ogonDJHHFzMe3jJrCvsDj7ZpiAjz+aovariYOK50UGhH5yTFjqX7MIbdtwU/ANY4/+cV
         mKD+SMilk+1yMIWRJKk0haWDvbAOqGufUDabw7k1ZNJ7lQvSEc2/6Wxh1lYfP9ut2F6b
         8jXeUr4XoSeIq1g1MTbQjFtMOEvsrT2hrcs33KO+JFS6DPgEWpzzdkUTg9Ey1a8WRZf3
         ZIT6WDOtIUrICm4Xe1JLif0D+sWcwUZYDkD/xM2EiBz+4u13s4+nf4km6IcI8QOkEGao
         hMYw==
X-Gm-Message-State: AOAM532khXAcPTvnz8yIMDAzVgQileyEo0zvS8am75natWsYqzACGZhQ
        HfmsjfYdvWb8tTFdJeY+zJ4k2ytNbQ5pMA==
X-Google-Smtp-Source: ABdhPJyobnAfnLLnjXnKR84Yozbk26GVAlyi7BnLyTiWpjWsQ4mhifdDw8+bSFvsC5p4ENfSKLQUHg==
X-Received: by 2002:a17:90a:f2c5:: with SMTP id gt5mr6597790pjb.67.1619214236813;
        Fri, 23 Apr 2021 14:43:56 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id r1sm5754278pjo.26.2021.04.23.14.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 14:43:56 -0700 (PDT)
Subject: Re: New kernel warning triggered by blktests
To:     Bart Van Assche <bvanassche@acm.org>,
        Changheun Lee <nanich.lee@samsung.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <45925919-ea46-1e38-2983-87b12c12003a@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <609bffeb-ab57-35d3-5f75-3c9e37741829@kernel.dk>
Date:   Fri, 23 Apr 2021 15:43:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <45925919-ea46-1e38-2983-87b12c12003a@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/23/21 2:38 PM, Bart Van Assche wrote:
> Hi Changheun,
> 
> If I run blktest srp/001 then a kernel warning appears that I haven't
> seen before. I think this is a side-effect of the patch that limits the
> bio size. Please take a look.
> 
> Thanks,
> 
> Bart.
> 
> WARNING: CPU: 1 PID: 15449 at block/bio.c:1034
> __bio_iov_iter_get_pages+0x324/0x350
> Call Trace:
>  bio_iov_iter_get_pages+0x6c/0x360
>  __blkdev_direct_IO_simple+0x291/0x580
>  blkdev_direct_IO+0xb5/0xc0
>  generic_file_direct_write+0x10d/0x290
>  __generic_file_write_iter+0x120/0x290
>  blkdev_write_iter+0x16e/0x280
>  new_sync_write+0x268/0x380
>  vfs_write+0x3e0/0x4f0
>  ksys_write+0xd9/0x180
>  __x64_sys_write+0x43/0x50
>  do_syscall_64+0x32/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae

I wonder if this is a case of violating "must always be able to add a page"?
Bart, does the below change anything?


diff --git a/include/linux/bio.h b/include/linux/bio.h
index f1a99f0a240c..c6428c9f9bf7 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -121,7 +121,8 @@ static inline bool bio_full(struct bio *bio, unsigned len)
 	if (bio->bi_vcnt >= bio->bi_max_vecs)
 		return true;
 
-	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
+	if (bio->bi_iter.bi_size &&
+	    bio->bi_iter.bi_size > bio_max_size(bio) - len)
 		return true;
 
 	return false;

-- 
Jens Axboe

