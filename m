Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA05BC001B5
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 16:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbiIBQcV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Sep 2022 12:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbiIBQcT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Sep 2022 12:32:19 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7207E2C42
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2022 09:32:18 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e195so2077584iof.1
        for <linux-block@vger.kernel.org>; Fri, 02 Sep 2022 09:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=P71PQXWfMeET9rAMhMnbA2YOGMCwyBz9FWAbE+ia6CM=;
        b=vbLAECgY8YiLQlt98OatJfJLII0Jpj11iKaaL+5iZa7pJ+fq+GMSMzHOJWXgUc0/7x
         JPLzIVnctYIOeCRSj2M2bufoGd/6YbirudlP4T9rX48BRZZ3KxMSgBLnaZEcYkCeVzH8
         n7Qn6WTQuawON+uwEYrqPAX/sO25n9yiIPujWt5nP7dtx3JxXqEO9DqHGXsjoxRozvGb
         Ucybbzq152zLm/aRUTYOwoo+vy3RmtM+mRuRAxfzJhZgZn3wYRYktiZDUSSVGWGSH+El
         NBxm23v80X3GtUDd7JbbCHza2U3vj40A184b2LKyG4jCFbOTs90HxJ8/pNlzQo67qbfy
         dKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=P71PQXWfMeET9rAMhMnbA2YOGMCwyBz9FWAbE+ia6CM=;
        b=xLzsyX1yRdz/s4eQC0ySyEeEWmvPm5r9EN2hwRiicD+QCNvSxPPSU4N4+bHR/+fdwC
         8hnWKAWHa1ZUq7JHnIron5hjWTxf0Ha+dz/3zD43mk07+2ZePMm+b9CppCW6ioTGiN09
         Nl08geJal9KLH+WohUK/f+Cfg039eXsEKuY0HcYFTxuyKgF8wBcoj7zj7DGwTbxq9UFy
         geOcKZMrV+jQjLUWsqYlHLDOpJKeOXyQbAQWibCJlkH51tDDeuA0Ng3pB7XEYUOTSdjw
         002lpBu2qJI3w05rMFGqAQqNSbwbnbEU8PJgs9YK/p4JvKyFZSJYIti15UEUaDJ1HFWu
         ABdQ==
X-Gm-Message-State: ACgBeo3XlWHS0zsTQsGBo8AgMgT2Q2GVXwhDTHUbFF46FRp4u5R07cNP
        cJ1lm5wnwCjh/G9JDeKyiqjRJw==
X-Google-Smtp-Source: AA6agR5t0hiYdcQSzlOQvgxYMtgGqRrkAxAwKlh2pBZDsfLxA9RcQtKvtayVkimGdSxSjCsZrltZWw==
X-Received: by 2002:a05:6602:14c1:b0:689:34d0:a0ef with SMTP id b1-20020a05660214c100b0068934d0a0efmr17291360iow.69.1662136338200;
        Fri, 02 Sep 2022 09:32:18 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n33-20020a056602342100b00689007ec164sm1004408ioz.48.2022.09.02.09.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 09:32:17 -0700 (PDT)
Message-ID: <2b4a935c-a6b1-6e42-ceca-35a8f09d8f46@kernel.dk>
Date:   Fri, 2 Sep 2022 10:32:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH for-next v3 0/4] fixed-buffer for uring-cmd/passthrough
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
        asml.silence@gmail.com
Cc:     io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com
References: <CGME20220902152701epcas5p1d4aca8eebc90fb96ac7ed5a8270816cf@epcas5p1.samsung.com>
 <20220902151657.10766-1-joshi.k@samsung.com>
 <f1e8a7fa-a1f8-c60a-c365-b2164421f98d@kernel.dk>
In-Reply-To: <f1e8a7fa-a1f8-c60a-c365-b2164421f98d@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/2/22 10:06 AM, Jens Axboe wrote:
> On 9/2/22 9:16 AM, Kanchan Joshi wrote:
>> Hi,
>>
>> Currently uring-cmd lacks the ability to leverage the pre-registered
>> buffers. This series adds the support in uring-cmd, and plumbs
>> nvme passthrough to work with it.
>>
>> Using registered-buffers showed peak-perf hike from 1.85M to 2.17M IOPS
>> in my setup.
>>
>> Without fixedbufs
>> *****************
>> # taskset -c 0 t/io_uring -b512 -d128 -c32 -s32 -p0 -F1 -B0 -O0 -n1 -u1 /dev/ng0n1
>> submitter=0, tid=5256, file=/dev/ng0n1, node=-1
>> polled=0, fixedbufs=0/0, register_files=1, buffered=1, QD=128
>> Engine=io_uring, sq_ring=128, cq_ring=128
>> IOPS=1.85M, BW=904MiB/s, IOS/call=32/31
>> IOPS=1.85M, BW=903MiB/s, IOS/call=32/32
>> IOPS=1.85M, BW=902MiB/s, IOS/call=32/32
>> ^CExiting on signal
>> Maximum IOPS=1.85M
> 
> With the poll support queued up, I ran this one as well. tldr is:
> 
> bdev (non pt)	122M IOPS
> irq driven	51-52M IOPS
> polled		71M IOPS
> polled+fixed	78M IOPS
> 
> Looking at profiles, it looks like the bio is still being allocated
> and freed and not dipping into the alloc cache, which is using a
> substantial amount of CPU. I'll poke a bit and see what's going on...

It's using the fs_bio_set, and that doesn't have the PERCPU alloc cache
enabled. With the below, we then do:

polled+fixed	82M

I suspect the remainder is due to the lack of batching on the request
freeing side, at least some of it. Haven't really looked deeper yet.

One issue I saw - try and use passthrough polling without having any
poll queues defined and it'll stall just spinning on completions. You
need to ensure that these are processed as well - look at how the
non-passthrough io_uring poll path handles it.


diff --git a/block/bio.c b/block/bio.c
index 3d3a2678fea2..cba6b1c02eb8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1754,7 +1754,7 @@ static int __init init_bio(void)
 	cpuhp_setup_state_multi(CPUHP_BIO_DEAD, "block/bio:dead", NULL,
 					bio_cpu_dead);
 
-	if (bioset_init(&fs_bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS))
+	if (bioset_init(&fs_bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS | BIOSET_PERCPU_CACHE))
 		panic("bio: can't allocate bios\n");
 
 	if (bioset_integrity_create(&fs_bio_set, BIO_POOL_SIZE))

-- 
Jens Axboe
