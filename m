Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7574C48BC2
	for <linux-block@archiver.kernel.org>; Sun, 27 Jun 2021 22:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D7161C17
	for <linux-block@archiver.kernel.org>; Sun, 27 Jun 2021 22:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhF0W1z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Jun 2021 18:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbhF0W1z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Jun 2021 18:27:55 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD72C061574
        for <linux-block@vger.kernel.org>; Sun, 27 Jun 2021 15:25:29 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id a11so15619422ilf.2
        for <linux-block@vger.kernel.org>; Sun, 27 Jun 2021 15:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q+WdnDPwT9/vbY/v2IudBsNQ7nke/+5lV6Wmm5rsuKI=;
        b=HdWXAKragL6NqYv/3lmngKDcNWKh4FkoOx81k5kZ2ilWaXW3QFox+EK9ycVJYE89yT
         iRJ4jmh9qZRZsiDgGZnCCzFg2w3IylYQp1X86eUbVxRGUdzrKuvxcGQ75gDsQ04cZx8c
         s/4dj3SmSNs5fzVR6k7q40pzzSWMp0kROl/kYU8W4rEd7+HZORnSbLGb1oV8zI7HnZXj
         vVGtD6wOX/U/pVw3OVOUPBLgbwAqaN+nFQq1ds4sGVAdIi7SoHiN6Dry7qlZ83uKmkMc
         ru81cG8fIm19Z2p3wqhQ/6M+Xw1taCeeDX193ltbOQMK1YwFDHf26r95uYnnMJ9MAq5t
         aaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q+WdnDPwT9/vbY/v2IudBsNQ7nke/+5lV6Wmm5rsuKI=;
        b=Ry48rB+O2bZY6nft3lAg1yXH4cyc2pgH5YOxSoO47k355sUodBmEhloh0RsMBMfNxs
         9MIIVTBj0MroqqyZi/4gy1Qm62sPt0ptmJADBMmSnpQEHgAMnnE+2J3COuQ+7C+bc0fH
         oAZD/0Pg00epghqFWxu8eVxE/HxuGKZm+9zhNsQ7vd6Bu3rVngjhA2jdILEo2Rh+CGKZ
         Rc3O0V2UyEH/8n4eFN0GhoS1lzl7sQvjQiUqA61GGL2o+OiZSIIrsy8LNYJ5CkSzbxLq
         zhFUTkEPdzwp+IypS2EatTHOxuVPCM8xqKm6iYWjHcIfqp9CUlsbC99JTkGb3VtYKM26
         7fLg==
X-Gm-Message-State: AOAM531R77EH1+NK7UwWdKXUo2mBYW/zwf5YuYdQ4dtf5cCpcRLS1izN
        NoiKeLkLILvtx6xvvBLU24o2zA==
X-Google-Smtp-Source: ABdhPJwm6M05GbK5Lpm/cJmORmwsgqPf0dJ02Ht6denosK+14EjDgnuB3N6XCjAPfvxan/1wzkj5fw==
X-Received: by 2002:a05:6e02:1054:: with SMTP id p20mr15916634ilj.242.1624832729417;
        Sun, 27 Jun 2021 15:25:29 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id c10sm5356939ild.72.2021.06.27.15.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jun 2021 15:25:29 -0700 (PDT)
Subject: Re: [PATCH] block/mq-deadline: Remove a WARN_ON_ONCE() call
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>
References: <20210627211112.12720-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0d0c81bf-2c81-109a-45e8-4704d627c9a2@kernel.dk>
Date:   Sun, 27 Jun 2021 16:25:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210627211112.12720-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/27/21 3:11 PM, Bart Van Assche wrote:
> The purpose of the WARN_ON_ONCE() statement in dd_insert_request() is to
> verify that dd_prepare_request() cleared rq->elv.priv[0]. Since
> dd_prepare_request() is called during request initialization but not if a
> request is requeued, a warning is triggered if a request is requeued. Fix
> this by removing the WARN_ON_ONCE() statement. This patch suppresses the
> following kernel warning:
> 
> WARNING: CPU: 28 PID: 432 at block/mq-deadline-main.c:740 dd_insert_request+0x4d4/0x5b0
> Workqueue: kblockd blk_mq_requeue_work
> Call Trace:
>  dd_insert_requests+0xfa/0x130
>  blk_mq_sched_insert_request+0x22c/0x240
>  blk_mq_requeue_work+0x21c/0x2d0
>  process_one_work+0x4c2/0xa70
>  worker_thread+0x2e5/0x6d0
>  kthread+0x21c/0x250
>  ret_from_fork+0x1f/0x30

Applied, thanks.

-- 
Jens Axboe

