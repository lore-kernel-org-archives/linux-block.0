Return-Path: <SRS0=CAbX=AS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA0FC433E1
	for <linux-block@archiver.kernel.org>; Tue,  7 Jul 2020 15:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F4120738
	for <linux-block@archiver.kernel.org>; Tue,  7 Jul 2020 15:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wH4DdH9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgGGPGp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGPGp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jul 2020 11:06:45 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FF7C08C5DC
        for <linux-block@vger.kernel.org>; Tue,  7 Jul 2020 08:06:44 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id a6so19540302ilq.13
        for <linux-block@vger.kernel.org>; Tue, 07 Jul 2020 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2XASVM4AqY31qIAgIY2OK3nO95mUNITex7KrDrl4aN8=;
        b=wH4DdH9k2N6o7vtGN88zqDC0UyKEVJYh9gKVvKv4QcghZ6gg4gDJWa+K7ziEZMVP5R
         1ulOADJ0uPAiIKCx+GisYUJhsEXABr6fqoNA1lRFda96CR2yrzJHSPb27ACza0Ssiz9u
         D75mtMPu3cspl57MIEiiFWX+Nrd5eLdsY3Z6gTtbQbaa/ZmdGGZKVTrIcFa0o7lAaK7g
         9QmQn9s8DssW5XFizxB3J9bA7nHDleLo9FqY/f/j5cNaq6IJVfiF6irbtGPG+tiGbJ0c
         ArV3S28t89AoQgARYknI6ZDfkITYD3ntI5oJp/92YOtWt5j2OHn8niGGz3DeuaPt7H5K
         ZRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2XASVM4AqY31qIAgIY2OK3nO95mUNITex7KrDrl4aN8=;
        b=tAJiC4v9l/CKl38WNAjEiSuRiJaTscdn9azNgBGez1oz1y7pgjZKLUzvzdxCQSZKM0
         pzpGASswJ733FD230BSc038XpOdO0vYT9cvwUVm7g0ZBkXtmcUhEjpja0Q/G6dnDnkMv
         x7dzgUAJ1NKJK/D/hrLgm64i6ACkhcgdUrVKRvweTWIwPLEcp4d8zfzxEutAMXYBRuO4
         cMghSHP3NtL2Cxo0y76EX4+0kvujGY2LuTIKCYCi7l/YRk3rr55RSGhgUYdynZ6Ya3gn
         UgQGZWIoJzy7djgTt3eIzk5OEGNBRW74nShY653mRTzl78xPHZtQ2mun+0oisVlrtcL4
         /kAA==
X-Gm-Message-State: AOAM530MOuYP0X3M63Mu62hzOwu507YO8qFJ0P2YyvGaEKuCoUmIAV0P
        CgMW4XTWH2pTI5pAJj9qLxf+yA==
X-Google-Smtp-Source: ABdhPJzRlJE3eTlzkgRAxz2LN+fUaR3t68qtI+trr22emrpJiqK3il2bLM/g1joJmGIus/cnlN+rMQ==
X-Received: by 2002:a92:c502:: with SMTP id r2mr37872563ilg.78.1594134403170;
        Tue, 07 Jul 2020 08:06:43 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v3sm13314560ili.12.2020.07.07.08.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 08:06:42 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: consider non-idle request as "inflight" in
 blk_mq_rq_inflight()
To:     Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org
Cc:     dm-devel@redhat.com, stable@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20200707150433.39480-1-snitzer@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dc5f15f0-db7f-eb1b-f504-d29ec5ef8a7e@kernel.dk>
Date:   Tue, 7 Jul 2020 09:06:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707150433.39480-1-snitzer@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/7/20 9:04 AM, Mike Snitzer wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> dm-multipath is the only user of blk_mq_queue_inflight().  When
> dm-multipath calls blk_mq_queue_inflight() to check if it has
> outstanding IO it can get a false negative.  The reason for this is
> blk_mq_rq_inflight() doesn't consider requests that are no longer
> MQ_RQ_IN_FLIGHT but that are now MQ_RQ_COMPLETE (->complete isn't
> called or finished yet) as "inflight".
> 
> This causes request-based dm-multipath's dm_wait_for_completion() to
> return before all outstanding dm-multipath requests have actually
> completed.  This breaks DM multipath's suspend functionality because
> blk-mq requests complete after DM's suspend has finished -- which
> shouldn't happen.
> 
> Fix this by considering any request not in the MQ_RQ_IDLE state
> (so either MQ_RQ_COMPLETE or MQ_RQ_IN_FLIGHT) as "inflight" in
> blk_mq_rq_inflight().

Applied, thanks.

-- 
Jens Axboe

