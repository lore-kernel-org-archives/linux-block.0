Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536A0C4338F
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 13:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307D160F94
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 13:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbhHCNDc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Aug 2021 09:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbhHCNDb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Aug 2021 09:03:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E22C061757
        for <linux-block@vger.kernel.org>; Tue,  3 Aug 2021 06:03:20 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u16so15091873ple.2
        for <linux-block@vger.kernel.org>; Tue, 03 Aug 2021 06:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SMh9xIg+KuJyMpcNBHOEIyxN302iXn7bQDh7W5h9Vow=;
        b=BiNXX/HwID1H6JgG+IFwL3Rj7lbFeIIiHZvE0FdpbDIaecQZsLxKpAUxFIcgM2TiU8
         h++8whqBbHMIBu6o67crxyZx03Kjz6lRfrO+q/68xv8wICKyq5ItnpLli5InGamfw58V
         5AaCTtAxbhJAOi2lfroq+tYWTgXyrC35T7RNCgVlMWFdDhZBcRrZCSLPMTANVXjPa/Yx
         iIRlVCqIj/04nOSLMf9OM0F70qxZrm9hAYCnVBbgChyz9QibhO/Q5q3x1SNs7D2ycGG3
         ZbXw6o/HemFQKaDRxeo6WjYmbqkzyh4uYY6fznUMN4c/zz6zZ6hnZ3HE3mCpMHFFGyJC
         uVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SMh9xIg+KuJyMpcNBHOEIyxN302iXn7bQDh7W5h9Vow=;
        b=eF1eEoELv+MflIYHoKum8Kbe7ItmAQ6XK9hQ8K5kRIQSwJDJYNm6p/p1JLawv296LP
         hqTsvLXglNMAkiWZMWivMzVLCyfFmb02Ya2ICw5wN5YfTKM8ueUhKH/5BB6qkgZreIij
         KxySWRz3Fyh/Glirw0ykRGzJF3eOHiP45KoconL/YxXSpwpHmjH/MMn+1mC6CAqEQhJD
         fO+qmTPYtirxdxNWPHhv/gr8CH6KS7cOY/7QjnsGpoT0I0o9Wgu1iqLj1pSzM3WkyAux
         VsdVdhoiuy3CCzQ7iZ3i7ndRTqG7HVg6GGYeRbq2gxKITOJHGJust3oiESTA0v9w3lbA
         l0+A==
X-Gm-Message-State: AOAM531VEIgZlsOMqMFvEmKO6hYtGk7tNkDuWEVLIR4144NDjt5aHkWZ
        0kCKjJaJKUO/DuemheflfICBYQ==
X-Google-Smtp-Source: ABdhPJxyGZuw77A2ij12zalDnAa83TKN1RGw+oJPCwLN5AEhRk00xL4wNhZ+gcOSRYjezCrsANGyEg==
X-Received: by 2002:a63:1456:: with SMTP id 22mr1301236pgu.257.1627995800078;
        Tue, 03 Aug 2021 06:03:20 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id g7sm10143296pfv.66.2021.08.03.06.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 06:03:19 -0700 (PDT)
Subject: Re: [PATCH] blk-iocost: fix lockdep warning on blkcg->lock
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Bruno Goncalves <bgoncalv@redhat.com>
References: <20210803070608.1766400-1-ming.lei@redhat.com>
 <d5b57c0b-4b2a-8ab6-e446-3353f0805fac@kernel.dk>
Message-ID: <9846133f-dc48-f8e7-2dd0-cfb1ff9e538c@kernel.dk>
Date:   Tue, 3 Aug 2021 07:03:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d5b57c0b-4b2a-8ab6-e446-3353f0805fac@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/3/21 7:02 AM, Jens Axboe wrote:
> On 8/3/21 1:06 AM, Ming Lei wrote:
>> blkcg->lock depends on q->queue_lock which may depend on another driver
>> lock required in irq context, one example is dm-thin:
>>
>> 	Chain exists of:
>> 	  &pool->lock#3 --> &q->queue_lock --> &blkcg->lock
>>
>> 	 Possible interrupt unsafe locking scenario:
>>
>> 	       CPU0                    CPU1
>> 	       ----                    ----
>> 	  lock(&blkcg->lock);
>> 	                               local_irq_disable();
>> 	                               lock(&pool->lock#3);
>> 	                               lock(&q->queue_lock);
>> 	  <Interrupt>
>> 	    lock(&pool->lock#3);
>>
>> Fix the issue by using spin_lock_irq(&blkcg->lock) in ioc_weight_write().
> 
> This looks fine to me for blk-iocost, but block/blk-cgroup.c:blkg_create()
> also looks like it gets the IRQ state of the same lock wrong?

Ah, that one is under the queue lock, so irqs are already disabled.

-- 
Jens Axboe

