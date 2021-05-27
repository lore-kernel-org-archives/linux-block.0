Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D589C4708A
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 06:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014C7613D4
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 06:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbhE0G1r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 02:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbhE0G1b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 02:27:31 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B156C061346
        for <linux-block@vger.kernel.org>; Wed, 26 May 2021 23:25:57 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id m190so2938511pga.2
        for <linux-block@vger.kernel.org>; Wed, 26 May 2021 23:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7qRojVMpYFdiX61pTt3xFJTOaRfkAgjYhVNeclsGqiI=;
        b=mBeF7SfLApvFyFqgbgGnjoOPddBFRbQ+PZqpIS9Irhx919vm4Dj6BL9vpkuA9gFQat
         HX7neY9ZL8x8cdUBjRBYTX9QTnCPj/F0/zq13kYOKB9b3QldClvHWbjYvYm2aMFDnnMh
         P5Gab5aIO9vRAc2hKJ/2Eixtxaw8vFdaMmXF7z1+m+ti1+kEjs6kXp50y+f3W5/bEoah
         BYgUaC7STLAI9cJDT41vGRaTufOMTW+LOVOblu2ahw4L0+eea/oSaDcEBn+DaPR4gyyO
         VGNF6cJPRn9tlZaVN9OKzSlEp4WBf4hi/Ti8JfJ5U9ej9Tx2wVFNyxbgnUaFmZzegdbN
         Gdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7qRojVMpYFdiX61pTt3xFJTOaRfkAgjYhVNeclsGqiI=;
        b=uM3cwAomTN8R4g0HrihCE1cU7vGGWaiaa6U+tx8SD2/tjNft0k5D6FhMER0uwITSeg
         WPl9MDuYjvooRDWhm08UgdSbldPO6jTN6FfXfT0ZmwcKIXOIKiOwWY3AeU3/Xwyh+XXV
         rIRgg8IbNfvmSa5BL6/LWFhyqADu+i6DTvwtcrf78xpZfnUTmeYg5IK890uOrEu9W/Sa
         rcAs8JtZ5LrD2cmda529FpwJRFVOu2nDyIReSqI/Bfjxsqe8mNhUbuKuopT2b5x43PYw
         E/CXd9w5VsvW7DRO3U43n8akH0bZmG4tThIcNSX6emhuSaI5alZcaT05Zbr8e8NDuhlJ
         0y/A==
X-Gm-Message-State: AOAM5338v/GYI8SKtuDgSFe8adYzbiDjmT9H7L0kI/sTy0Xd6hVYBMY7
        h2Tz7GCq9jF4i8xvKNXXLNs=
X-Google-Smtp-Source: ABdhPJxbKZ9KCrtYiqpiK0zjo7sTNN7CFPf/FjGzjwoGZ+U1abtNXgEerkAn5nZ+vQvjqf0eXnTXYg==
X-Received: by 2002:a63:5c01:: with SMTP id q1mr2251377pgb.447.1622096757117;
        Wed, 26 May 2021 23:25:57 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([103.112.79.202])
        by smtp.gmail.com with ESMTPSA id mp21sm1039921pjb.50.2021.05.26.23.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 23:25:56 -0700 (PDT)
Subject: Re: [PATCH 0/9] Improve I/O priority support
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Message-ID: <b58840a8-0122-26cd-e756-92562064075a@gmail.com>
Date:   Thu, 27 May 2021 14:25:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210527010134.32448-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/5/27 9:01 AM, Bart Van Assche wrote:
> Hi Jens,
> 
> A feature that is missing from the Linux kernel for storage devices that
> support I/O priorities is to set the I/O priority in requests involving page
> cache writeback. Since the identity of the process that triggers page cache
> writeback is not known in the writeback code, the priority set by ioprio_set()
> is ignored. However, an I/O cgroup is associated with writeback requests
> by certain filesystems. Hence this patch series that implements the following
> changes for the mq-deadline scheduler:
Hi Bart

How about implement this feature based on the rq-qos framework ?
Maybe it is better to make mq-deadline a pure io-scheduler.

Best regards
Jianchao

> * Make the I/O priority configurable per I/O cgroup.
> * Change the I/O priority of requests to the lower of (request I/O priority,
>   cgroup I/O priority).
> * Introduce one queue per I/O priority in the mq-deadline scheduler.
> 
> Please consider this patch series for kernel v5.14.
> 
> Thanks,
> 
> Bart.
> 
> Bart Van Assche (9):
>   block/mq-deadline: Add several comments
>   block/mq-deadline: Add two lockdep_assert_held() statements
>   block/mq-deadline: Remove two local variables
>   block/mq-deadline: Rename dd_init_queue() and dd_exit_queue()
>   block/mq-deadline: Improve compile-time argument checking
>   block/mq-deadline: Reduce the read expiry time for non-rotational
>     media
>   block/mq-deadline: Reserve 25% of tags for synchronous requests
>   block/mq-deadline: Add I/O priority support
>   block/mq-deadline: Add cgroup support
> 
>  block/Kconfig.iosched      |   6 +
>  block/Makefile             |   1 +
>  block/mq-deadline-cgroup.c | 206 +++++++++++++++
>  block/mq-deadline-cgroup.h |  73 ++++++
>  block/mq-deadline.c        | 524 +++++++++++++++++++++++++++++--------
>  5 files changed, 695 insertions(+), 115 deletions(-)
>  create mode 100644 block/mq-deadline-cgroup.c
>  create mode 100644 block/mq-deadline-cgroup.h
> 
