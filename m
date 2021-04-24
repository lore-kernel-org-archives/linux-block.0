Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2AFC433ED
	for <linux-block@archiver.kernel.org>; Sat, 24 Apr 2021 02:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE67B611BD
	for <linux-block@archiver.kernel.org>; Sat, 24 Apr 2021 02:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhDXCkf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Apr 2021 22:40:35 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:41951 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbhDXCke (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Apr 2021 22:40:34 -0400
Received: by mail-pf1-f173.google.com with SMTP id w6so20711043pfc.8
        for <linux-block@vger.kernel.org>; Fri, 23 Apr 2021 19:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qxcu9BvgM2vd4baPmo/mvJM/77QGo5Ai6IwYWYbBFHw=;
        b=CHXAAprttn/ebIRzP+71kouj3vGTPDi9x51UraVWvRZvy8YTWCr+F4iI1bdfawJcmS
         MPMJq54LqGaR1VftaLiv0EwbhPWMoR7pp/yC/4qWmhEzQysEhRfeTs/yf39mc/1LX4wR
         O5nnTH/C5sb8sf/td6/8tahEJyeSLlxDzQnybdhLgcrXF2inTjFMT00vHcLKg9Hvl3C6
         KBVk+eWJbu037HS1F9AZEBz9OlIshM1fNZLCHsULfJpTiKoe5l3AN8JDa1/qlx65T394
         ujpwAm3wDEiGivdmG3XOm0ZhZyGBWdvrM+yueesETY34dlsKevgj2AddKr9RRNn0aZCn
         vSQw==
X-Gm-Message-State: AOAM533p+Dx5D63zVslQYt4iECiRyLR9zPNXSjsR/CitRU9tDC3vtyoQ
        agqxVvniJaHOQDRt3mJ+FYzeMmLLug8=
X-Google-Smtp-Source: ABdhPJzby7MNZnI9huP5MI01+81qowuHmre2SF7HvO1yOxXOWC7HeC8FnCe+Sa/SxN+61xJsfLMg9w==
X-Received: by 2002:a63:4442:: with SMTP id t2mr6842563pgk.232.1619231996993;
        Fri, 23 Apr 2021 19:39:56 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:af89:f38:9063:1d51? ([2601:647:4000:d7:af89:f38:9063:1d51])
        by smtp.gmail.com with ESMTPSA id d3sm8837563pjw.35.2021.04.23.19.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 19:39:55 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: New kernel warning triggered by blktests
To:     Jens Axboe <axboe@kernel.dk>,
        Changheun Lee <nanich.lee@samsung.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <45925919-ea46-1e38-2983-87b12c12003a@acm.org>
 <609bffeb-ab57-35d3-5f75-3c9e37741829@kernel.dk>
Message-ID: <5807356b-c11f-b1af-f1dc-280a377f85f9@acm.org>
Date:   Fri, 23 Apr 2021 19:39:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <609bffeb-ab57-35d3-5f75-3c9e37741829@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/23/21 2:43 PM, Jens Axboe wrote:
> I wonder if this is a case of violating "must always be able to add a page"?
> Bart, does the below change anything?
> 
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index f1a99f0a240c..c6428c9f9bf7 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -121,7 +121,8 @@ static inline bool bio_full(struct bio *bio, unsigned len)
>  	if (bio->bi_vcnt >= bio->bi_max_vecs)
>  		return true;
>  
> -	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
> +	if (bio->bi_iter.bi_size &&
> +	    bio->bi_iter.bi_size > bio_max_size(bio) - len)
>  		return true;
>  
>  	return false;

Hi Jens,

Thank you for having taken a look. If I apply the following debug patch:

--- a/block/bio.c
+++ b/block/bio.c
@@ -1031,8 +1031,13 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 			if (same_page)
 				put_page(page);
 		} else {
-			if (WARN_ON_ONCE(bio_full(bio, len)))
+			if (WARN_ON_ONCE(bio_full(bio, len))) {
+				pr_info("bi_vcnt %u/%u; bi_size %u/%u; len %u\n",
+					bio->bi_vcnt, bio->bi_max_vecs,
+					bio->bi_iter.bi_size, bio_max_size(bio),
+					len);
                                 return -EINVAL;
+			}
 			__bio_add_page(bio, page, len, offset);
 		}
 		offset = 0;

then the following output appears:

	bi_vcnt 12/256; bi_size 126976/130560; len 4096

so I don't think that the above patch would help.

What is remarkable is that test srp/001 does not submit any I/O towards the
block device associated with the SRP initiator (other than a partition table
read). I think this that the following command from tests/srp/rc triggers
the kernel warning:

		dd if=/dev/zero of="${r}" bs=1M count=$((ramdisk_size>>20)) "${oflag[@]}" >/dev/null 2>&1 || return $?

That dd command writes to a null_blk instance. After having added another
debug print statement, the following appeared in the kernel log:

Apr 23 19:08:04 ubuntu-vm kernel: null_blk: module loaded
Apr 23 19:08:04 ubuntu-vm kernel: blk_queue_max_hw_sectors: max_hw_sectors = 255; max_sectors = 255; bio_max_bytes = 130560
Apr 23 19:08:04 ubuntu-vm kernel: blk_queue_max_hw_sectors: max_hw_sectors = 255; max_sectors = 255; bio_max_bytes = 130560

That's the same 130560 byte limit as in the previous print statement.

Bart.
