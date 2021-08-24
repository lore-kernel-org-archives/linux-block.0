Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB39C432BE
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 17:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0289E61212
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 17:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbhHXRuR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 13:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241999AbhHXRt1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 13:49:27 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EC2C0698CF
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 10:09:47 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so2223879pjw.2
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 10:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VkDsFQBPqAeZm/MyWtG2DOONsy7CnEGol9UBCxAr/LY=;
        b=L6gNKT2BE6CqeJnQ3mRc1lT3IF4w/MWy147pANGJLdCINcHLJUp4JMNEKPmmXmn42z
         TFdJ6Qe6OGCEHMMjwAlizCmzTomwTt4/mpx2ebQwsjZUarLfzEWdjcYIAggOYTdu/T2J
         6H3nkzVzJEJm6oiwcT2jq7sdwo/JlTnAhl3I6x4Tj3UK8xHo+jHcvqtFQ9CSCif5uzXR
         Jdr4qQ48DcULxg7tldPhIN3JdNdzwR6DC2etIFKI8eS1kXtKF3MkBcUo7/K1RWtqc7ea
         6b7Yv0awBTumBOzIn21WCVInZH0j72YmZ14rR++YXv+nt7J3Y/ES+Y3wwWkwt3eEsZ8s
         Zh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VkDsFQBPqAeZm/MyWtG2DOONsy7CnEGol9UBCxAr/LY=;
        b=eRf+sdfz0GpmKNdAc45TcomDbiXB8JNvP4EBRmeQ5B+71YpDt5GmdMM9BWgCBxyFja
         EMiSUmGNjiQw7LhG4vHKpdCeMUvdpqq9/IVFMLPoKwIT63hazXOp5zVL3m24ZkE9wRcd
         G5xX87ZhHBKWt0UkrQDfedz93cUwzC/ZtSM/Mc3rhFH3IfsCvVB+TgibHGz/UAJ9pqLA
         gF61ke9D5yrqWmXsA7Q//0zxJo6QJzT5eKhrlmZ8l7rmhZxzEoFxEsBXDwkMpZbkQv1A
         ZNQ/G+0sRs0K5jGNSLNPmBL4GCLu4ewcy33BTySpd1rlK5OVbHYIMW/ozDZD4PTSHpgU
         +JUQ==
X-Gm-Message-State: AOAM532Z06Rl0lU04k03Ikmb6AYJj8957EhL7Th+mYH4T9kZ+iSHlfqS
        IBU1lgYg0Hu7sbTYPFH/MXdIZw==
X-Google-Smtp-Source: ABdhPJy2kRZ7tCaQn6LD0yGHxCGwht8rvnBIT+oaxYvDUPQZ92ci2GZzNZHSxi6SX54tLPpnBywrww==
X-Received: by 2002:a17:90a:5305:: with SMTP id x5mr5321474pjh.135.1629824986690;
        Tue, 24 Aug 2021 10:09:46 -0700 (PDT)
Received: from ?IPv6:2600:380:4960:2a4d:1b63:8a6c:25bc:6edc? ([2600:380:4960:2a4d:1b63:8a6c:25bc:6edc])
        by smtp.gmail.com with ESMTPSA id p24sm15626489pgm.54.2021.08.24.10.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:09:46 -0700 (PDT)
Subject: Re: [PATCH] mq-deadline: Fix request accounting
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>
References: <20210824170520.1659173-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <412b4df5-aa1c-c95b-7b71-c0fc61ae3d06@kernel.dk>
Date:   Tue, 24 Aug 2021 11:09:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210824170520.1659173-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/24/21 11:05 AM, Bart Van Assche wrote:
> The block layer may call the I/O scheduler .finish_request() callback
> without having called the .insert_requests() callback. Make sure that the
> mq-deadline I/O statistics are correct if the block layer inserts an I/O
> request that bypasses the I/O scheduler. This patch prevents that lower
> priority I/O is delayed longer than necessary for mixed I/O priority
> workloads.
> 
> Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> Fixes: 08a9ad8bf607 ("block/mq-deadline: Add cgroup support")

This one is a little confusing, since that commit got reverted...
Yet the patch still applies.

Shouldn't it be:

Fixes: 38ba64d12d4c ("block/mq-deadline: Track I/O statistics")


-- 
Jens Axboe

