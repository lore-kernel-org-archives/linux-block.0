Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA879C432BE
	for <linux-block@archiver.kernel.org>; Sat, 21 Aug 2021 03:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A1AE611C4
	for <linux-block@archiver.kernel.org>; Sat, 21 Aug 2021 03:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhHUDHN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Aug 2021 23:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhHUDHK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 23:07:10 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0986C061575
        for <linux-block@vger.kernel.org>; Fri, 20 Aug 2021 20:06:31 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id i7so14730195iow.1
        for <linux-block@vger.kernel.org>; Fri, 20 Aug 2021 20:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zXnabTutSfjB58xCglYCbD1BnmX0pP7FO9Kb6wQ0tqQ=;
        b=ySg/4hvw7AdU9m0RA3FhiU52lPBfwv+cSdN6PRcuaUw6MLZvOtr8qTmEBuMA0oyRDz
         8u/iuZIGDzk9YJIqEznpHJ+BA9EKEdi5DHlevUuEeF8QSUa5xCnSHl6B1uKwzVwmisGJ
         2IBO14lj/P4Zunr9bvBfbPLOrSSUzMJZd9GwI/oP8ExgD0w5TY/JM5ZoGpzOn1RqPFNj
         wIU3V2t96zOOOA//oTQF05IAXJ6HJVUY0VTd4F8dSdRXQasLcJaeYM5IJTeIFPKta8pM
         H7dJ0RtjxknFrOPFGEmOoQgwqcEOgvlWJhnKTobEdojxrESsDxiDA3V5d02tQSOGIywQ
         molQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zXnabTutSfjB58xCglYCbD1BnmX0pP7FO9Kb6wQ0tqQ=;
        b=c90D6UNGqjghRAywwxLFsJbjLmIyJ8aVoG1mZjxhInwphjlRXLMS1woL/fvSC5tRAW
         83oiXT0pqM+0nrH0iIERnlBULeZnJVknua4jqxumcmtJGz0ixw4r8hPwLYHRMjqgL3D9
         LZr6ah2jvTmS2lzItbS2+h0SZ1BaOviYV0PFVJky3o/XEaUTVHjZRuTVIovVv71WXrPu
         w7GFx5zkHxobEISoqBzA/MVCbcqgU6ojhpZTa/7H0VTBXj3k85A/IMGjk2/oZ6DwL5jC
         Ao93lu6gQdBeIT6vgYqtuGYdWbYYr21NhHfuPI0B/sA3OPeffKapEOA1sFKm6rmufIKT
         K37g==
X-Gm-Message-State: AOAM531OL1O9GiCOlwPqkzeixdnH8yCfRTdko059Z2AwIv6epkfigf7E
        2DLjCMRP5nBirLOsuzODZIq2R+Z0QBjkAX9q
X-Google-Smtp-Source: ABdhPJy0kDwlez1T2XHjkJHDHXXBr6mUe36iz6gvr0nWnCdEv6WCidxIMgYgKmUnUAxMZNJwm6FUxw==
X-Received: by 2002:a6b:6a14:: with SMTP id x20mr19476329iog.177.1629515191165;
        Fri, 20 Aug 2021 20:06:31 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id u10sm4537280ilg.15.2021.08.20.20.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 20:06:30 -0700 (PDT)
Subject: Re: slab-out-of-bounds access in bio_integrity_alloc()
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <4b6318fb-0008-1747-64d5-b31991324acf@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7ed9a751-8874-14d1-cbc1-af39768cce95@kernel.dk>
Date:   Fri, 20 Aug 2021 21:06:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4b6318fb-0008-1747-64d5-b31991324acf@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/20/21 4:58 PM, Bart Van Assche wrote:
> Hi,
> 
> It's been a while since I ran blktests. If I run it against Jens' for-next
> branch (39916d4054e7 ("Merge branch 'for-5.15/io_uring' into for-next")) a
> slab-out-of-bounds access complaint appears. Is anyone already looking into
> this?

Does this help?

diff --git a/block/bio.c b/block/bio.c
index ae9085b97deb..94a0c01465a8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -282,8 +282,9 @@ void bio_init(struct bio *bio, struct bio_vec *table,
 	atomic_set(&bio->__bi_remaining, 1);
 	atomic_set(&bio->__bi_cnt, 1);
 
-	bio->bi_io_vec = table;
 	bio->bi_max_vecs = max_vecs;
+	bio->bi_io_vec = table;
+	bio->bi_pool = NULL;
 }
 EXPORT_SYMBOL(bio_init);
 

-- 
Jens Axboe

