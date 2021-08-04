Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51ADC4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 17:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 830D760F94
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 17:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbhHDR67 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 13:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbhHDR67 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Aug 2021 13:58:59 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC2CC0613D5
        for <linux-block@vger.kernel.org>; Wed,  4 Aug 2021 10:58:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so4664410pjh.3
        for <linux-block@vger.kernel.org>; Wed, 04 Aug 2021 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DY1ycG0HBesX9rvAByRfVLd6t1wgu6XO9EafdSK48o8=;
        b=zyYaF/u/+977dGXhPDXs9Ua0ZvqvMA1ni1OcOzmjlkmy9v7MGVBaE9AF9H1eBTXSek
         HlZtnk5b5LWGv9LEncyUw4jCn+TQuPEP3ma+8w8W6bpnenGNaiReAS5tMQfwgrs+tMuk
         U/b5cwODgsM1aOZkV0UULL7xXaN68WrkfFmCnyuhNWhUCW3G8JPJfxFjas/8t/c/azBj
         jKSFWPmYpYNIuPUT7E8V3lApjlO1PZ51bHYQe/o/uSnm/Qc7zIbNc1PQIA5/lesh4S+l
         LSKePvBNwtsfFm0dZDQd7kNsvBvoON+OD8kX89ak+grRckMfpvXfunaY7jg2PANg9ygf
         hS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DY1ycG0HBesX9rvAByRfVLd6t1wgu6XO9EafdSK48o8=;
        b=lUSWaydx2lypQa1rdngYa22giXKoeOt64C2LJUgK/Vyb8JneqoTdiKWYYMYWDApdog
         Khip2IZjy8FxuU3LFyZqnnanTULDE1GGQ/VVq2M+jPUf2Ce2PsyJ9zCKW+odsnYybKK3
         ygrxHRuuQ4TrjOSqh9PfnMhetQ9vmoKr/+Ii2Mkps5Z5UrgYB0kajIY7BnexV8GmiaKT
         mYubPv/nXmdfPElE/t2qUY/CHVvpcEaca9185Agpn5PvOrsPC2WAb5z7cyq/5tVhThiL
         WNU5MN5kR38XP7Zso7UfXHsu4xK+PqSDWrCH2C1hXISkSBClZHtatgWUL6uF2eNLlPtL
         HAiw==
X-Gm-Message-State: AOAM530l5JH43FeD7zsd/M8s3e5wDgIPX6XF/gLmXRUDDwlpwYxoe/SH
        70aMaSsQUx6iy4Z5gN1UZM2b6A==
X-Google-Smtp-Source: ABdhPJy5jpHHGPknD2dqSLsbeDhrdiVGBmW3Q77gHMla/7KYLK8bVwIQI+ftF425xV/nvhNIu0Zi4g==
X-Received: by 2002:a65:42c3:: with SMTP id l3mr118926pgp.377.1628099925853;
        Wed, 04 Aug 2021 10:58:45 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id f66sm3860247pfa.21.2021.08.04.10.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 10:58:45 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] loop: Select I/O scheduler 'none' from inside
 add_disk()
To:     Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Martijn Coenen <maco@android.com>
References: <20210803182304.365053-1-bvanassche@acm.org>
 <20210803182304.365053-3-bvanassche@acm.org> <YQn924DHk4axOUso@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7cf7cf6d-bf89-0df2-9aec-6ea7d3efd515@kernel.dk>
Date:   Wed, 4 Aug 2021 11:58:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YQn924DHk4axOUso@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/3/21 8:39 PM, Ming Lei wrote:
> On Tue, Aug 03, 2021 at 11:23:03AM -0700, Bart Van Assche wrote:
>> We noticed that the user interface of Android devices becomes very slow
>> under memory pressure. This is because Android uses the zram driver on top
>> of the loop driver for swapping, because under memory pressure the swap
>> code alternates reads and writes quickly, because mq-deadline is the
>> default scheduler for loop devices and because mq-deadline delays writes by
> 
> Maybe we can bypass io scheduler always for request with REQ_SWAP, such as:

I don't think that's a good idea at all, what happens if you have a mixed
swap in/out on a rotating drive?

-- 
Jens Axboe

