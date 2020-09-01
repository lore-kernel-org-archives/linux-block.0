Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B89DC433E6
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 20:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D85207D3
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 20:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KZizb+Dd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgIAUCF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732069AbgIAUCD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 16:02:03 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A6FC061245
        for <linux-block@vger.kernel.org>; Tue,  1 Sep 2020 13:02:02 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s2so1145178pjr.4
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2020 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0TFvfjapBtpOjCK3cnf0JVXwOOm9nRjQC9YR5LerqTw=;
        b=KZizb+DdvnIhtxo9NJ/Mj4uCuEuWwUiJI2z2QI8dHInz2CbTiSw03qvl8d7N0gM/VK
         lZouzCV/sW+xZ0kBkq0kvenYq2rqkgf1HiE1wQoFV5I9UkGWHNHNImzOgvpN51xuPvyW
         Q8LffDrfTl4v2t9wFOHvUHZPDnurDYyg2OkTAdWlbQTTjQVdENs5I+//6wTXWNIMPGmk
         PUAUi+KsPluN8g1Gb6uzv0uQJEgtnyeqwNPb4nIOFIp9HTanGC1w2ooJx5O2WatjtOFh
         s+BwRafjpzAi3X+pEXXgTO+TY6Dd1ORudlPnSa6MtteW2sdiz706begthdfAItvuS9PT
         evbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0TFvfjapBtpOjCK3cnf0JVXwOOm9nRjQC9YR5LerqTw=;
        b=RhTQfPLrhsSh9tt6sgigblLKxSe2ZaQ2L2hPuD9KU3yvqp5ID00T/JoAZmLSa6tMTJ
         qqjkH2HqcAod4+fABK6IDd+2u/2vvq0d5sdeNgztFso/FtnDgvlQnAUvKF8/5eRsswc3
         NZS39h1+rEU3doZadZbaEktaRS8bYtvh36NIYqTgTPtGz7ppWfTP2JGHXxNGiKqU8ExR
         y1eZazBX+29eLOHFEW9UMXDnqPEHqSw1RWMR7A6Q7mk8+28QpTu7TsMNzYWOOPnLf/Sg
         f6qdSD/gpLU44DIyk/pRK/fHUsRZ6YwMAHk7frF8UjDp+xPSEl69CcfeUlPGxUZ0riMJ
         MwVQ==
X-Gm-Message-State: AOAM533jA/Bjpvsf9nSJN8j277ENUxxqlyfDmKmle168y4mjsb9yJUFm
        URgO3VXSXM8kdyIFYQ2v/C75zLhfcV53OuZO
X-Google-Smtp-Source: ABdhPJw4z0MtzIa/uyRVdxpAtHcbKBFq10NoDMe7R9TwBTG7E94El7Zku9kR9xW9ZZcV0wpl5FfwpA==
X-Received: by 2002:a17:902:6a8b:: with SMTP id n11mr2849235plk.75.1598990522125;
        Tue, 01 Sep 2020 13:02:02 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x188sm2851565pfb.37.2020.09.01.13.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 13:02:01 -0700 (PDT)
Subject: Re: [PATCH] io_uring: Fix NULL pointer dereference in
 io_sq_wq_submit_work()
From:   Jens Axboe <axboe@kernel.dk>
To:     yinxin_1989 <yinxin_1989@aliyun.com>,
        viro <viro@zeniv.linux.org.uk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200901015442.44831-1-yinxin_1989@aliyun.com>
 <ae9f3887-5205-8aa8-afa7-4e01d03921bc@kernel.dk>
 <67f27d17-81fa-43a8-baa9-429b1ccd65d0.yinxin_1989@aliyun.com>
 <4eeefb43-488c-dc90-f47c-10defe6f9278@kernel.dk>
Message-ID: <98f2cbbf-4f6f-501b-2f4e-1b8b803ce6a6@kernel.dk>
Date:   Tue, 1 Sep 2020 14:01:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4eeefb43-488c-dc90-f47c-10defe6f9278@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/1/20 8:52 AM, Jens Axboe wrote:
> On 8/31/20 10:59 PM, yinxin_1989 wrote:
>>
>>> On 8/31/20 7:54 PM, Xin Yin wrote:
>>>> the commit <1c4404efcf2c0> ("<io_uring: make sure async workqueue
>>>> is canceled on exit>") caused a crash in io_sq_wq_submit_work().
>>>> when io_ring-wq get a req form async_list, which may not have been
>>>> added to task_list. Then try to delete the req from task_list will caused
>>>> a "NULL pointer dereference".
>>>
>>> Hmm, do you have a reproducer for this?
>>
>> I update code to linux5.4.y , and I can reproduce this issue on an arm
>> board and my x86 pc by fio tools.
> 
> Right, I figured this was 5.4 stable, as that's the only version that
> has this patch.

I took a closer look, and I think your patch can basically be boiled down
to this single hunk. If you agree, can you resend your patch with the
description based on that, then I'll get it queued up for 5.4-stable.
Thanks!

diff --git a/fs/io_uring.c b/fs/io_uring.c
index fada14ee1cdc..cbbcd85780c4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2378,6 +2378,16 @@ static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
 		list_del_init(&req->list);
 		ret = false;
 	}
+
+	if (ret) {
+		struct io_ring_ctx *ctx = req->ctx;
+		unsigned long flags;
+
+		spin_lock_irqsave(&ctx->task_lock, flags);
+		list_add(&req->task_list, &ctx->task_list);
+		req->work_task = NULL;
+		spin_unlock_irqrestore(&ctx->task_lock, flags);
+	}
 	spin_unlock(&list->lock);
 	return ret;
 }

-- 
Jens Axboe

