Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5866CEB64DD
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 03:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjHJDnm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Aug 2023 23:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjHJDnk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Aug 2023 23:43:40 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4441FF7
        for <linux-block@vger.kernel.org>; Wed,  9 Aug 2023 20:42:55 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bc9811558cso448842a34.0
        for <linux-block@vger.kernel.org>; Wed, 09 Aug 2023 20:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691638975; x=1692243775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B4RSMo1fBND8rVHHnIuWYp8oZATIFXug9YVVpx6JvSU=;
        b=R7Jc4sXsiFXrA4yW5WqDxMVpJ2WvcRSR/7OGGAzasL5sQeG0HYp3rDsg0S5rbqw5dc
         hseFMOvB9l2g6gpt1lce4yyYJzJoht16qkDlDBmLR8RMT/tJ7MaPMrHNQC34bsCkkkPW
         T8kbKF4ODjVFr1i/xl5Fd6AffGAcIqp158ltGD2cQ8HRAofcKrZBrFwI7atzlr1WtBnn
         WApOG8SNAVJRYwiI3wlDbped0h8/+qVTcU6QPGya57ENEhj8TvEs6desGai2gNkn7UrQ
         onbfKV8tUTpAr5tbUbCVaIr6ySeCpiaaXDeyh+NDV6tBHjF3O+hG4M8UfRR2b28uKy6v
         fnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691638975; x=1692243775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4RSMo1fBND8rVHHnIuWYp8oZATIFXug9YVVpx6JvSU=;
        b=VAUiR964KUmG3OgpemQsceGlQPqxahAWRA4wonuu3Zb/ehFd3DrMIXQ8HBjoFNxYwJ
         g9Rk1yv3DLkmdi+tjsD0LdDub2hus4jqSaKLH3+EJYa+d5Gm2sWXqpOJu/wqZD4/G6NG
         aTZ8f753Pi1EgxVGP8gazsDDIqqWMooG3KHDi1Bawv80D9OaleSuT5drv9kaKIlJ0f+4
         BytZmHYzGNY2zp4SrOgVWsEjp1jiZyZRmzvurOTzx4TrnNnFdFf9CsoQazyG8VGyoNl+
         F8cUdS2kcPd85UPebg9hJPAh9HI1VGVz0xXO9ciI9Fv/cPBsqucOjHrylCUvM52VV03b
         anyQ==
X-Gm-Message-State: AOJu0YwWcIo1D2m7uiegUR4tW0VTey7GOOuls82EeiaW3kcZtgoBWRzm
        iomGoplwY4dWp6DpxxGVHGmXXg==
X-Google-Smtp-Source: AGHT+IEdmG2XuZqwzOtBW9SyX+LO81ptV0L1FDqwtJVZqePG/lQZ75vsbzufQXK4dBu2HSEL3Q4k9g==
X-Received: by 2002:a05:6358:e488:b0:135:449c:341b with SMTP id by8-20020a056358e48800b00135449c341bmr1289104rwb.10.1691638974739;
        Wed, 09 Aug 2023 20:42:54 -0700 (PDT)
Received: from [10.4.190.166] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a034800b00262e485156esm2383811pjf.57.2023.08.09.20.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 20:42:54 -0700 (PDT)
Message-ID: <86ce2299-ce42-c0bb-e577-9d23f8af494c@bytedance.com>
Date:   Thu, 10 Aug 2023 11:42:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH RFC] block: Revert 615939a2ae73
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Chuck Lever <cel@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <169158653156.2034.8363987273532378512.stgit@bazille.1015granger.net>
 <d51b0683-8872-4e10-8589-5c6de8db61d4@kernel.dk>
 <20230809161105.GA2304@lst.de>
 <9BADCC53-72E9-44FB-80C8-CEBC9897809D@oracle.com>
 <20230809214913.GA9902@lst.de>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20230809214913.GA9902@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/8/10 05:49, Christoph Hellwig wrote:
> Oh well.  I don't feel like we're going to find the root cause
> given that its late in the merge window and I'm running out of
> time I have to work due to the annual summer vacation.  Unless
> someone like Chengming who knows the flush code pretty well
> feels like working with chuck on a few more iterations we'll

Hi,

No problem, I can work with Chuck to find the root cause if Chuck
has time too, since I still can't reproduce it by myself.

Maybe we should first find what's the status of the hang request?
I can write a Drgn script to find if any request hang in the queue.

Christoph, it would be very helpful if you share some thoughts
and directions.


> have to revert it.  Which is going to be a very painful merge
> with Chengming's work in the for-6.6 branch.
> 

Maybe we can revert it manually if we still fail since that commit
just let postflushes go to the normal I/O path, instead of going to
the flush state machine.

So I think it should be fine if we just delete that case?

Chuck, could you please help to check this change on block/for-next?

Thanks!

diff --git a/block/blk-flush.c b/block/blk-flush.c
index e73dc22d05c1..7ea3c00f40ce 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -442,17 +442,6 @@ bool blk_insert_flush(struct request *rq)
                 * Queue for normal execution.
                 */
                return false;
-       case REQ_FSEQ_DATA | REQ_FSEQ_POSTFLUSH:
-               /*
-                * Initialize the flush fields and completion handler to trigger
-                * the post flush, and then just pass the command on.
-                */
-               blk_rq_init_flush(rq);
-               rq->flush.seq |= REQ_FSEQ_PREFLUSH;
-               spin_lock_irq(&fq->mq_flush_lock);
-               fq->flush_data_in_flight++;
-               spin_unlock_irq(&fq->mq_flush_lock);
-               return false;
        default:
                /*
                 * Mark the request as part of a flush sequence and submit it




