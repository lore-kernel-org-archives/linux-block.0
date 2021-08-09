Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DC4C4338F
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 20:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF116101E
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 20:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhHIUgs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 16:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbhHIUgs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Aug 2021 16:36:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C880C0613D3
        for <linux-block@vger.kernel.org>; Mon,  9 Aug 2021 13:36:27 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso1868459pjb.1
        for <linux-block@vger.kernel.org>; Mon, 09 Aug 2021 13:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hTaguwncf2XKMO+pO2y0YKJLbDQenref+BiU7csmOpE=;
        b=HlEPGYGYLbMu2TK/XUGjRDQ7p6DbkFY1Wj6KdGobC9bXX4blpTWKRPtBmV49mWqRmF
         GdFkilkyaqnWFUb3MWNlyE8g7M/VaiOb8ImI9zPvoHncwaGCtHYENbvfBFX1ciGxhlF5
         /bXPXKWZH9AYr4qDI5eU6riXzi3lA4BsdfASHzVbXndU4pCVHVl+WNwvjGtzPb6R6Cig
         vTUJ11b0wwMn8Zq4P7PdcK+V1/9DCJKgmEJkfX2jPduO8W5Iz2Z3UB0W/PBF7aiqBPGX
         ReV8NzbUzTC944oaZloqSFp57V2RDLhQy2M/TM3Uv3Wr80J0l5iM6GkETEgZdn1S+P3J
         TcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hTaguwncf2XKMO+pO2y0YKJLbDQenref+BiU7csmOpE=;
        b=EiKBLyihOLwSwIgbVZ+vB1wfAJuFATQ2Qwul17oI2Rn86PDYHu4e7jee6X9UjAHXrD
         ScAZvRz4iuT/15UwxGM/52c43phkJvOC+ZSAyCi3gWP/+G+FjJl0IS8cFzBf+PI1zdWt
         TgDYcEGvCfUY3PZ27Vy8f0HRP2WkviYiqusJUzrYjW0I4O2Rp4fB31NdWUdXiAilOaEB
         fDZLtQMFEhdveinRN0ehwaLpbSnPnI6UajQq1KuoTjdsAu6uUYWBgSQh7V5OBsfBX3kq
         N9O7pRyCF4vt1PHTmWc0vW+caF8OtZo4omuzgopRY535Zj4hHZSOiJHV2BqYbBTTGU3S
         KVRg==
X-Gm-Message-State: AOAM530XIekEmVu6rqCGQwEbFSIo2KXvkjZkce4NXMrWec5PDdlb0033
        js1D/ddmCSzc20w2iBRbXtpVbdM+it1f3/8L
X-Google-Smtp-Source: ABdhPJzUgxyBY/k0vRkF9hhmPJH9m8/iX9oGRMAXk74RnrRbH4QK7OTZYAMKfqveOY972tTKGMGAkQ==
X-Received: by 2002:a63:441c:: with SMTP id r28mr11250pga.337.1628541386794;
        Mon, 09 Aug 2021 13:36:26 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id z11sm21592226pfr.201.2021.08.09.13.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 13:36:26 -0700 (PDT)
Subject: Re: [PATCH] block: return ELEVATOR_DISCARD_MERGE if possible
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
References: <20210729034226.1591070-1-ming.lei@redhat.com>
 <YQtcZHgE1cTl+KVz@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a60094bf-c5b7-9b26-43b6-11188409edf1@kernel.dk>
Date:   Mon, 9 Aug 2021 14:36:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YQtcZHgE1cTl+KVz@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/4/21 9:35 PM, Ming Lei wrote:
> On Thu, Jul 29, 2021 at 11:42:26AM +0800, Ming Lei wrote:
>> When merging one bio to request, if they are discard IO and the queue
>> supports multi-range discard, we need to return ELEVATOR_DISCARD_MERGE
>> because both block core and related drivers(nvme, virtio-blk) doesn't
>> handle mixed discard io merge(traditional IO merge together with
>> discard merge) well.
>>
>> Fix the issue by returning ELEVATOR_DISCARD_MERGE in this situation,
>> so both blk-mq and drivers just need to handle multi-range discard.
>>
>> Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Hello Jens and Guys,
> 
> Ping...

Since this isn't a new regression this release and since this kind
of change always makes me a bit nervous, any objections to queueing
it up for 5.15 with the stable/fixes tags?

-- 
Jens Axboe

