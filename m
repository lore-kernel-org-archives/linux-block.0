Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C512AC4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 01:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A305A60F58
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 01:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhHDBeU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Aug 2021 21:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbhHDBeT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Aug 2021 21:34:19 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B32C06175F
        for <linux-block@vger.kernel.org>; Tue,  3 Aug 2021 18:34:06 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so1334336pji.5
        for <linux-block@vger.kernel.org>; Tue, 03 Aug 2021 18:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BTZ7ilDLGCC0IC8oeGK7QZmOAxS1irdFIWZilBOxrgg=;
        b=e7gTzVSdMOsdybyNi2r+M/WX7JzmQHyLadztnwZDBYvFnio3Co2ub8wzto5Hh/XtKM
         xM4mWudXoUalzGzDWftI8PJ17Mvw7Z2+fntxKbVzzJIJJRspkpH6beqGSIQKPIa7ET56
         ZTIXOYhz8GeIoK9Pj/ke9NPDns0NgxLxvrxemLN8mhkmKjqeGJTjzJpYTfaJKFPN8fP0
         AP7jt6nBXgtpBpkCN0/kLqjzHJD4ox1U8VMA/MieHbpwrkFqaIoUB2eliRbx4U3je08z
         tpulr3kZezi5PTCsuaeymp4V9j/6l9U2TnLTuWnSm3C8PmLSDZJv162S7LAti7cS1YRz
         AAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BTZ7ilDLGCC0IC8oeGK7QZmOAxS1irdFIWZilBOxrgg=;
        b=cxOY9ZqYPdVdFHrQWPIp3rez1E9QTvG33KLLHQjDcH4luJl5V/EDtqHqxpiTw1s7cC
         mDuFgE5akMm6zXJqeriQRW+emWbz9mHYpf8pp18+PGtM3XK05Hrs4j8hy6rCLuoK7idD
         Qn37J7YWdiLCKMsrFaAr4SkpzXiSmX3IHvhOw/rbLrWXQ7WknBWK+arkVf+lg2RBo97a
         6aRTukq7E99xE4gVns8ZpVHm9yDLnF3mYJQoT9e/qJpJDMWeXkE8vjGko04MG2IAQEwD
         E+jBkOQc27UzjeSGTuLXe2JhwLrADP+SnAfqLM2937c/v41jN2GrvTcsiSTAkmjzTIi1
         R8yQ==
X-Gm-Message-State: AOAM530RkvXnyPm6YAtP75oZvQ4jai1HwyDlFGtZgr9qqqCcf+8xkn8c
        l57+jZfBWMONpcFkK90ObSYxgg==
X-Google-Smtp-Source: ABdhPJyk+2pr2cAjIqd7dyn+9aYnn7lT8ChCsfD0GytlndF88g4wkbRbisRc/kn+AFdKnuTNMELswg==
X-Received: by 2002:a63:d34e:: with SMTP id u14mr752967pgi.244.1628040846083;
        Tue, 03 Aug 2021 18:34:06 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id c14sm424205pgv.86.2021.08.03.18.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 18:34:05 -0700 (PDT)
Subject: Re: [PATCH] blk-iocost: fix lockdep warning on blkcg->lock
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Bruno Goncalves <bgoncalv@redhat.com>
References: <20210803070608.1766400-1-ming.lei@redhat.com>
 <d5b57c0b-4b2a-8ab6-e446-3353f0805fac@kernel.dk> <YQnskyUwX+3icYyU@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fefbae5d-18ed-2150-8dc6-a3e271a49c5f@kernel.dk>
Date:   Tue, 3 Aug 2021 19:34:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YQnskyUwX+3icYyU@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/3/21 7:25 PM, Ming Lei wrote:
> On Tue, Aug 03, 2021 at 07:02:28AM -0600, Jens Axboe wrote:
>> On 8/3/21 1:06 AM, Ming Lei wrote:
>>> blkcg->lock depends on q->queue_lock which may depend on another driver
>>> lock required in irq context, one example is dm-thin:
>>>
>>> 	Chain exists of:
>>> 	  &pool->lock#3 --> &q->queue_lock --> &blkcg->lock
>>>
>>> 	 Possible interrupt unsafe locking scenario:
>>>
>>> 	       CPU0                    CPU1
>>> 	       ----                    ----
>>> 	  lock(&blkcg->lock);
>>> 	                               local_irq_disable();
>>> 	                               lock(&pool->lock#3);
>>> 	                               lock(&q->queue_lock);
>>> 	  <Interrupt>
>>> 	    lock(&pool->lock#3);
>>>
>>> Fix the issue by using spin_lock_irq(&blkcg->lock) in ioc_weight_write().
>>
>> This looks fine to me for blk-iocost, but block/blk-cgroup.c:blkg_create()
>> also looks like it gets the IRQ state of the same lock wrong?
> 
> blkg_create() is called with irq disabled in all three callers: 
> blkg_lookup_create(), blkg_conf_prep() and blkcg_init_queue().

Yes I know, see email sent 1 min after the one you're replying to.

-- 
Jens Axboe

