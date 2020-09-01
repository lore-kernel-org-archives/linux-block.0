Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8270EC433E2
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 14:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C46D206EB
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 14:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="15tSL2fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgIAOxO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbgIAOwy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 10:52:54 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E286AC061245
        for <linux-block@vger.kernel.org>; Tue,  1 Sep 2020 07:52:53 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id o16so745744pjr.2
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2020 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PeEvLT3ZeLb9RUi+PCRykN+cW6hUGCxRkYbA2o4fn5k=;
        b=15tSL2fbI1s+CH/9pPU2MqmXgB6/4QeX47wS7112qGbNIbllC+VReFbU8PMENPfa7/
         YhGkLVV/NXqToUlWR0dd5cqj5i3+LuRzFuOPA2r14lrGeui0AUsFompldgpWid5xQ5Qt
         lxx4Ps1ygDasjk4UWEGYex/Aa0Rt1VQUz6m5E5Ux0If38eFA4DRnntq/uWf22C1WDHTs
         MsFL0FWJnsM+uB1OHGOi+CNI2lgFfhcM3K0BiFMfnGHECt5FJ6gHT1ZOuB4t+U1X57/e
         ip5MwuUoB0mJQZVWNLDb5YCy/njsBdpgLKqf+2KOOvlXgI5cJjBF8LR4VKor3XhENude
         3x2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PeEvLT3ZeLb9RUi+PCRykN+cW6hUGCxRkYbA2o4fn5k=;
        b=a6xym0bthdbQU7xdIk2EjY81OLdgVFj3PGJ0fCrGGvt+3RnbqWdwMAC0z+pVbr4sSf
         k9AozqiDuP9CrW+pw+Ma1C/s4YxRPTlPHNOpYq8Q+77bdX6iMHjQUmIpWudu72b+8oeD
         GEQnErqpjR6bFlxWuFDyDvd095en0hPYCVWfenwpH+VDDDAUI4SbS7HyUQXg/bBuzul/
         ChGTekUecqfHi4+pvJUtvHif3foLzPwiqc6MxJf5h09JkmD/PC/a4TiTgFeoy9QYXNUs
         6s4KOthFZfxfvozyC7bqGbLQTWQbER4qKmelKFVsUpI4S5LHCz/6m9MAAHai7Q7TToEB
         7SMQ==
X-Gm-Message-State: AOAM530MX9mJ3vIfnUybIoRkVezEJiDHbe5oM6EkoMBTSeqZLXADKz6Q
        pZ2eeS9Edszo/SXgAyc/F3MDfw==
X-Google-Smtp-Source: ABdhPJx9iVsy84SXSpOJhrRsgO11zARscHkukzKgfd1qNsRoO9jOB5lRdzHX9yX/AlMI0IMgj0mLqQ==
X-Received: by 2002:a17:90a:a583:: with SMTP id b3mr1941881pjq.127.1598971973129;
        Tue, 01 Sep 2020 07:52:53 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e124sm2351945pfa.87.2020.09.01.07.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 07:52:52 -0700 (PDT)
Subject: Re: [PATCH] io_uring: Fix NULL pointer dereference in
 io_sq_wq_submit_work()
To:     yinxin_1989 <yinxin_1989@aliyun.com>,
        viro <viro@zeniv.linux.org.uk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200901015442.44831-1-yinxin_1989@aliyun.com>
 <ae9f3887-5205-8aa8-afa7-4e01d03921bc@kernel.dk>
 <67f27d17-81fa-43a8-baa9-429b1ccd65d0.yinxin_1989@aliyun.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4eeefb43-488c-dc90-f47c-10defe6f9278@kernel.dk>
Date:   Tue, 1 Sep 2020 08:52:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <67f27d17-81fa-43a8-baa9-429b1ccd65d0.yinxin_1989@aliyun.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/31/20 10:59 PM, yinxin_1989 wrote:
> 
>>On 8/31/20 7:54 PM, Xin Yin wrote:
>>> the commit <1c4404efcf2c0> ("<io_uring: make sure async workqueue
>>> is canceled on exit>") caused a crash in io_sq_wq_submit_work().
>>> when io_ring-wq get a req form async_list, which may not have been
>>> added to task_list. Then try to delete the req from task_list will caused
>>> a "NULL pointer dereference".
>>
>>Hmm, do you have a reproducer for this?
> 
> I update code to linux5.4.y , and I can reproduce this issue on an arm
> board and my x86 pc by fio tools.

Right, I figured this was 5.4 stable, as that's the only version that
has this patch.

> fio -filename=/home/yinxin/testfile -direct=0 -ioengine=io_uring -iodepth 128 -rw=read -bs=16K -size=1G -numjobs=1 -runtime=60 -group_reporting -name=iops

Gotcha, thanks!

>>> @@ -2356,9 +2358,11 @@ static void io_sq_wq_submit_work(struct work_struct *work)
>>>   * running. We currently only allow this if the new request is sequential
>>>   * to the previous one we punted.
>>>   */
>>> -static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
>>> +static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req,
>>> +       struct io_ring_ctx *ctx)
>>>  {
>>>   bool ret;
>>> + unsigned long flags;
>>>  
>>>   if (!list)
>>>    return false;
>>> @@ -2378,6 +2382,13 @@ static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
>>>    list_del_init(&req->list);
>>>    ret = false;
>>>   }
>>> +
>>> + if (ret) {
>>> +  spin_lock_irqsave(&ctx->task_lock, flags);
>>> +  list_add(&req->task_list, &ctx->task_list);
>>> +  req->work_task = NULL;
>>> +  spin_unlock_irqrestore(&ctx->task_lock, flags);
>>> + }
>>>   spin_unlock(&list->lock);
>>>   return ret;
>>>  }
>>> @@ -2454,7 +2465,7 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
>>>     s->sqe = sqe_copy;
>>>     memcpy(&req->submit, s, sizeof(*s));
>>>     list = io_async_list_from_req(ctx, req);
>>> -   if (!io_add_to_prev_work(list, req)) {
>>> +   if (!io_add_to_prev_work(list, req, ctx)) {
>>>      if (list)
>>>       atomic_inc(&list->cnt);
>>>      INIT_WORK(&req->work, io_sq_wq_submit_work);
>>> 
>>ctx == req->ctx, so you should not need that change.
> 
> In my test , the req have not been add to req->task_list(maybe waiting
> for the ctx->task_lock) , and in io_sq_wq_submit_work() try to delete
> it from req->task_list ,which will cause this issue.

Sure, but req->ctx is set when the req is initialized. If req->ctx !=
ctx here, then that would be pretty disastrous... So you can drop that
part of the patch.

Care to send with that changed? Then I'm fine with queueing this up for
5.4-stable. Thanks!

-- 
Jens Axboe

