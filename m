Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97CDC4360C
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 13:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DF8217D9
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 13:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iLGncnXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfI0NBr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:01:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39901 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfI0NBq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 09:01:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id v17so6071023wml.4
        for <linux-block@vger.kernel.org>; Fri, 27 Sep 2019 06:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dm0+3pJ8C7A27/ghnUCkgnZEVBR1uv4FF47ldr/VWOQ=;
        b=iLGncnXmqTJOOg3y9rebaiWAn6ZDu2gF2WJywjPvA+s9Er3cNSkl2NEXaB0C2sw4ig
         o0w5LHBi2Rb9XwtmRPAgzf6x66HQxEyQJTL/p7RJWfhoJJsPRA6Yqgo4l/yj3opYDJPw
         iDwDV+wiPjW8+hF8kjetA3i8dLG8ozipmrkc2LRWVkVBBKyNvvhRuIHPTAAJJ/Y21tM1
         va0XJpGyybKa1GpRh1gUnVFrEOoln4odwrFx5697WFKEZeMh04/765gbDU86QWEDx9wm
         oaX7g+LntaF4RpMbyire864DuSLYIeqnsoP6WoeZJQuVjMauqGpAM3I6AAw2GKK0EK2T
         azEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dm0+3pJ8C7A27/ghnUCkgnZEVBR1uv4FF47ldr/VWOQ=;
        b=ozbIFU0aovCJK7FdQD2lhagEVRvl79hhTy8O+tbvkN2+V6lfEI5609cP1G7Kx1uEEx
         7V9QNW7iRE3MJem3ZrV21m6GhYBY4exWVuPilvJJJmbi8e2rmT5bXooVbGth4KwG8RhH
         ok6yiOI8VYVPdlUhdq29r/f5gj4z7xwm46zU7lmoxy8vukym9I4mq2Mqk0Zf3497mvGx
         TUnWRMDBmhnB6ARXXTABSxe2NrRw6CC+3J+xdp2z0gjKKDetH+jZLFwkB0cnJsUXtVCm
         LuzzCgDa3wMoCsYYLvxIZIKDAvItQm1b/Ag8+j75dJzcN1HKeIbZwW3nV+tzDz4li9fR
         DEpQ==
X-Gm-Message-State: APjAAAXfjR7O52oj5XuuIhRc+42JlVsbOwaVU/pFYEVNWebiB5CDJ+6D
        BDPOCA/jOmCyU2+MnmUh0S9Orw==
X-Google-Smtp-Source: APXvYqxVqStuH3J1VX7LXm9qXAX/EQWD21jqa3f/IOPu0N+rKDEOXvUZLFxyH1vl3bhaLsMxkd4IOw==
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr6628984wmj.4.1569589302790;
        Fri, 27 Sep 2019 06:01:42 -0700 (PDT)
Received: from [172.20.9.27] ([83.167.33.93])
        by smtp.gmail.com with ESMTPSA id z189sm15558858wmc.25.2019.09.27.06.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 06:01:42 -0700 (PDT)
Subject: Re: [PATCH v5] block: fix null pointer dereference in
 blk_mq_rq_timed_out()
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com,
        hch@infradead.org, keith.busch@intel.com, bvanassche@acm.org
References: <20190927081955.44680-1-yuyufen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3b195278-91cd-c10e-3d80-8423f89a3060@kernel.dk>
Date:   Fri, 27 Sep 2019 15:01:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927081955.44680-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/27/19 10:19 AM, Yufen Yu wrote:
> We got a null pointer deference BUG_ON in blk_mq_rq_timed_out()
> as following:
> 
> [  108.825472] BUG: kernel NULL pointer dereference, address: 0000000000000040
> [  108.827059] PGD 0 P4D 0
> [  108.827313] Oops: 0000 [#1] SMP PTI
> [  108.827657] CPU: 6 PID: 198 Comm: kworker/6:1H Not tainted 5.3.0-rc8+ #431
> [  108.829503] Workqueue: kblockd blk_mq_timeout_work
> [  108.829913] RIP: 0010:blk_mq_check_expired+0x258/0x330
> [  108.838191] Call Trace:
> [  108.838406]  bt_iter+0x74/0x80
> [  108.838665]  blk_mq_queue_tag_busy_iter+0x204/0x450
> [  108.839074]  ? __switch_to_asm+0x34/0x70
> [  108.839405]  ? blk_mq_stop_hw_queue+0x40/0x40
> [  108.839823]  ? blk_mq_stop_hw_queue+0x40/0x40
> [  108.840273]  ? syscall_return_via_sysret+0xf/0x7f
> [  108.840732]  blk_mq_timeout_work+0x74/0x200
> [  108.841151]  process_one_work+0x297/0x680
> [  108.841550]  worker_thread+0x29c/0x6f0
> [  108.841926]  ? rescuer_thread+0x580/0x580
> [  108.842344]  kthread+0x16a/0x1a0
> [  108.842666]  ? kthread_flush_work+0x170/0x170
> [  108.843100]  ret_from_fork+0x35/0x40
> 
> The bug is caused by the race between timeout handle and completion for
> flush request.
> 
> When timeout handle function blk_mq_rq_timed_out() try to read
> 'req->q->mq_ops', the 'req' have completed and reinitiated by next
> flush request, which would call blk_rq_init() to clear 'req' as 0.
> 
> After commit 12f5b93145 ("blk-mq: Remove generation seqeunce"),
> normal requests lifetime are protected by refcount. Until 'rq->ref'
> drop to zero, the request can really be free. Thus, these requests
> cannot been reused before timeout handle finish.
> 
> However, flush request has defined .end_io and rq->end_io() is still
> called even if 'rq->ref' doesn't drop to zero. After that, the 'flush_rq'
> can be reused by the next flush request handle, resulting in null
> pointer deference BUG ON.
> 
> We fix this problem by covering flush request with 'rq->ref'.
> If the refcount is not zero, flush_end_io() return and wait the
> last holder recall it. To record the request status, we add a new
> entry 'rq_status', which will be used in flush_end_io().

Thanks, applied.

-- 
Jens Axboe

