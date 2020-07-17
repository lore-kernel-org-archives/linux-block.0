Return-Path: <SRS0=LVe3=A4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744B8C433E1
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 13:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A10120717
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 13:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BtVjkUFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgGQNOn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgGQNOn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 09:14:43 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC26C061755
        for <linux-block@vger.kernel.org>; Fri, 17 Jul 2020 06:14:43 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u185so5388651pfu.1
        for <linux-block@vger.kernel.org>; Fri, 17 Jul 2020 06:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U13Ob9CqtP5QVOsxRTmnDFDbLa4trp/O+/NS45Pe4Uo=;
        b=BtVjkUFWwBSvkC4wyM7M3sTUuL6XiQ0te2ewo0FJPAZmIpZ19HADnfclKyUYszT3Ol
         K6BYTvYAwor9FYj/aW9TolcvzPBiHbAtIYOxmnQhme9Ng+6Sg6M3CnEplQfEVuE2BllG
         rOB74+gIAPnuXI2tjkS0UelJPfdXtIfeAKLWFagUhG7QSrk4JmD6+BxKU75RbhvCj7k5
         UarzhkaREdF45Z9lP3Q54g8YQw088Bw9vOgyXaxNuSZQ3v170+9X3f2Nh6NCjaTeL2tv
         4Mzk/EJOj43BXXDjlPve2R4541fH9UAEk2op50QgP/wtdYhEYac294uDWKUN1tO2eoV/
         SPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U13Ob9CqtP5QVOsxRTmnDFDbLa4trp/O+/NS45Pe4Uo=;
        b=LcGDy10aQq1NRYZd4fWvBT7vDEbHu7skfRwosf392XtOmhsnjbLk2eEKvr57O9YFZv
         tIlPi4bhGaA8US1A4JD9RjijjVDbqJWXCah3+S3zesqKfrouVdiXtxAdGNpJKgoVJJ1V
         +jxEnUn/eweAnixtwCKbjiCweAX3PwBZNKxnxEImzn114ctnUWdlU/6UY6GxnjNEZk0N
         MXh0/9lEXW1VxEGpBZpEwFuuYo+zJx/LUe1+TTYeCq9gs04p2ZkHHCwb0Sa8k7x9yTfE
         tFdYspYSa1/N0d0giDN4eRi3+fl/mD7FZeXK9x3rnUTU0+IY40awxoGC5ZUhLEARGb42
         Ni/g==
X-Gm-Message-State: AOAM532C+e7pmQEmxdyl23W46uZ18OVy0CnYwaaOZNDe1lG4/1+18num
        M9gFFouku8U2p/1L4WxE28vddw==
X-Google-Smtp-Source: ABdhPJxEhhjvakhtRneWaqAlhxBAVXHbU1HN80n/nPUWb8BGK91UwQYaNn2ls4ZuRFGB0v09WvDPTg==
X-Received: by 2002:a63:1548:: with SMTP id 8mr8365754pgv.172.1594991682726;
        Fri, 17 Jul 2020 06:14:42 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id z2sm7457093pfq.67.2020.07.17.06.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 06:14:42 -0700 (PDT)
Subject: Re: [RFC PATCH] block: defer flush request no matter whether we have
 elevator
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-block@vger.kernel.org, tj@kernel.org, hch@lst.de
References: <20200716065201.3213045-1-yuyufen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <115a73e6-371f-5d21-4739-cb38ffed7b8a@kernel.dk>
Date:   Fri, 17 Jul 2020 07:14:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716065201.3213045-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/16/20 12:52 AM, Yufen Yu wrote:
> Commit 7520872c0cf4 ("block: don't defer flushes on blk-mq + scheduling")
> tried to fix deadlock for cycled wait between flush requests and data
> request into flush_data_in_flight. The former holded all driver tags
> and wait for data request completion, but the latter can not complete
> for waiting free driver tags.
> 
> After commit 923218f6166a ("blk-mq: don't allocate driver tag upfront
> for flush rq"), flush requests will not get driver tag before queuing
> into flush queue.
> 
> * With elevator, flush request just get sched_tags before inserting
>   flush queue. It will not get driver tag until issue them to driver.
>   data request on list fq->flush_data_in_flight will complete in
>   the end.
> 
> * Without elevator, each flush request will get a driver tag when
>   allocate request. Then data request on fq->flush_data_in_flight
>   don't worry about lacking driver tag.
> 
> In both of these cases, cycled wait cannot be true. So we may allow
> to defer flush request.

Applied, thanks.

-- 
Jens Axboe

