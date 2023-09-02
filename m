Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C429CC001DB
	for <linux-block@archiver.kernel.org>; Sat,  2 Sep 2023 15:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjIBPBF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Sep 2023 11:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbjIBPBE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Sep 2023 11:01:04 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD689118
        for <linux-block@vger.kernel.org>; Sat,  2 Sep 2023 08:00:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bf1935f6c2so99715ad.1
        for <linux-block@vger.kernel.org>; Sat, 02 Sep 2023 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693666839; x=1694271639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=No82j0zelLGQZ1We1kpgGnX8WqgyXeJ+fKIBM7K2mfk=;
        b=fThpd0KB93D0Z9q996gYT3PK8biCc9lKLl+87nPvfXy/r116B+6lBjKk4UEXQl6pmt
         b+i/4rVEI15zSsCr43tCoDeSFbad3mZdbZVc06fuSmj1y8q5sUNRpogAu/ITHGrQ1ycs
         /SSnCqGJ1ZW7Zglyny1PgqAjj5Tn5+m3Gv/Bz4xq3VJsKLt2+0cwW1hEDqq4Oeku8lF0
         LXtWxdkEBwkXysBYdGeEbFHfHp+6XhADei7H5GzihhCbgjbFycFIq9BjjRLYPpAHODg7
         uLyVCLxLSKK5w5HgMXWnP4SbL9RignY9TwmKOToVo+AB/QNy+thuF+E4ZlKkJ9i6EbMC
         6lrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693666839; x=1694271639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=No82j0zelLGQZ1We1kpgGnX8WqgyXeJ+fKIBM7K2mfk=;
        b=fp6CAk/hUovBaFBVbdx50wpPrQGe90CV8FcyfR6/vi8ZcFal2ryw8Th0rHYmIz71Y6
         n6P5IM4EYeYcYCT0PTBAkBvnc8Cg6sCz3Qx1awmuJ4r9ZJ6TOiRmBiiJ4M2rE+UeiYoj
         TIBoKzFne0pHXajrCmCNHnnNOBEXHgB90JW1V4GPTvD0mZ7HLvk7Y4B3gmubfbaaG/Hh
         qC18cbiBXK2oT4sTiMsqcFwbz64mpp0tSuh5bcr+N74TjXDCEeRef0nI0eUstX+D5tLq
         INZ8E7I0+vJCvIIydv7PfZjBXbyS9sMoLnbmPP261WwrLMd3kFWVVMXpVGrJYQeJyC5x
         9X3Q==
X-Gm-Message-State: AOJu0YyImAnozoHvcqPxXXE4f/BM5Gh55XTf1HFDbdfJBbUJCfaEEOFh
        /qAlQyjyvmeXTVymGsO0VhR2fQ==
X-Google-Smtp-Source: AGHT+IG5aRowHJhHxeBK0pk6dfUKP7athUbLHijWDRdXGx1tdVm+r/1EhwdRBaCulNtmVhKHfiNyyQ==
X-Received: by 2002:a17:902:a408:b0:1bd:dbec:8673 with SMTP id p8-20020a170902a40800b001bddbec8673mr5868810plq.11.1693666839179;
        Sat, 02 Sep 2023 08:00:39 -0700 (PDT)
Received: from [10.254.27.61] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902748200b001c3267ae317sm1343163pll.165.2023.09.02.08.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 08:00:38 -0700 (PDT)
Message-ID: <fbe24ad1-0d76-0463-0d09-66404991d5b4@bytedance.com>
Date:   Sat, 2 Sep 2023 23:00:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 0/6] blk-mq: optimize the queue_rqs() support
Content-Language: en-US
To:     chengming.zhou@linux.dev, axboe@kernel.dk, hch@lst.de,
        ming.lei@redhat.com, bvanassche@acm.org, kbusch@kernel.org
Cc:     mst@redhat.com, sagi@grimberg.me, damien.lemoal@opensource.wdc.com,
        kch@nvidia.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230824144403.2135739-1-chengming.zhou@linux.dev>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20230824144403.2135739-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/8/24 22:43, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The current queue_rqs() support has limitation that it can't work on
> shared tags queue, which is resolved by patch 1-3. We move the account
> of active requests to where we really allocate the driver tag.
> 
> This is clearer and matched with the unaccount side which now happen
> when we put the driver tag. And we can remove RQF_MQ_INFLIGHT, which
> was used to avoid double account problem of flush request.
> 
> Another problem is that the driver that support queue_rqs() has to
> set inflight request table by itself, which is resolved in patch 4.
> 
> The patch 5 fixes a potential race problem which may cause false
> timeout because of the reorder of rq->state and rq->deadline.
> 
> The patch 6 add support queue_rqs() for null_blk, which showed a
> 3.6% IOPS improvement in fio/t/io_uring benchmark on my test VM.
> And we also use it for testing queue_rqs() on shared tags queue.

Hello, gentle ping.

Thanks.

> 
> Thanks for review!
> 
> Chengming Zhou (6):
>   blk-mq: account active requests when get driver tag
>   blk-mq: remove RQF_MQ_INFLIGHT
>   blk-mq: support batched queue_rqs() on shared tags queue
>   blk-mq: update driver tags request table when start request
>   blk-mq: fix potential reorder of request state and deadline
>   block/null_blk: add queue_rqs() support
> 
>  block/blk-flush.c             | 11 ++-----
>  block/blk-mq-debugfs.c        |  1 -
>  block/blk-mq.c                | 53 ++++++++++++++------------------
>  block/blk-mq.h                | 57 ++++++++++++++++++++++++-----------
>  drivers/block/null_blk/main.c | 20 ++++++++++++
>  drivers/block/virtio_blk.c    |  2 --
>  drivers/nvme/host/pci.c       |  1 -
>  include/linux/blk-mq.h        |  2 --
>  8 files changed, 84 insertions(+), 63 deletions(-)
> 
