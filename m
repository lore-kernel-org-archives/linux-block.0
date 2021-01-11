Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511CEC433DB
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 04:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 283C7225AC
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 04:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbhAKEj6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Jan 2021 23:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbhAKEj6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 23:39:58 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22B7C061786
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 20:39:17 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r3so14984592wrt.2
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 20:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tAFK/IpLV+WvAB95qjgQarDtyUqui990OlL1R4rVIJg=;
        b=q3rtYm5XzpQsBCuy85P4lHr+Kxs7D8Mx/rFx2zYC1PPXMVDhGB+KszcaRTafgYKHJE
         71f3Ii1jocnZRiiLAjy4nwl/OYJdee5AQPjYjEKenBx83SDHZhyONQAoubWPAxf2knw7
         /ob/O9w5jIMg87AHdPMrA+xp2C7GQzgl/jgtzij6LJpppfyAsHtP12Mq9U9vkZAUdR1g
         CD6HOS0asgZHC0to0HnYbfjoOajavo57LArMJQ54EiAVedVicp/deaMZLLofmohifE5p
         ZLbNfrY81yDzpPUTjcxOgdDeeDjVohuZosi3OgUOBxeDdOy9orCEQzot6cmksmIKsOhI
         lvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tAFK/IpLV+WvAB95qjgQarDtyUqui990OlL1R4rVIJg=;
        b=Qc1StkAOED2nmy0gkRx/9O/pNih93mKqOQNLauH9hFKFpusSy/ihWOQk5q0nXPU+Dv
         Poqg6Z3ZA/6wRJEz8FVTvE+h5IyHc+X6Hj+sNC6hci3Ta20vmhSS5s67xRTYBJwa+Yr7
         cQoy499B2W9tYtSfP1O+Zf3DKVMVsB2jGLo5jOoWeUZbQsOQlUEfyfZSq4pxPFiDZ+m+
         sQoWNhk2FCTHqdb5VkMQyo1HKQ/ajih3uSNsHSGBIKqns4NEMuZemrI1s5DA7ZaMXd//
         tIqpJQRUyDdI2UA+M1dniJvXnLol8eQMLx6/YUR+KEoMPyvTGcmVNxQCRlRY9J1EyWXj
         rQbQ==
X-Gm-Message-State: AOAM530shSX2mBxbZqzI1p/B7jmIcCqejv3Qtsk8BYP1YDn1QyX2V5wS
        SbhaZK8DNtB0l+hTHPYf9Dk=
X-Google-Smtp-Source: ABdhPJwYnbKTfZ4L8aLvbjiOjKonJPWoKm2oPiC0Ve0nFIUCDNjSJyWl9+ukZJUuQH5BkjwkzqPfMQ==
X-Received: by 2002:adf:94c7:: with SMTP id 65mr13978928wrr.423.1610339956405;
        Sun, 10 Jan 2021 20:39:16 -0800 (PST)
Received: from [192.168.8.119] ([85.255.237.6])
        by smtp.gmail.com with ESMTPSA id r82sm21137227wma.18.2021.01.10.20.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jan 2021 20:39:16 -0800 (PST)
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210111030557.4154161-1-ming.lei@redhat.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH V3 0/6] block: improvement on bioset & bvec allocation
Message-ID: <1a7824b1-4f85-7851-28f5-9b3e58547f7a@gmail.com>
Date:   Mon, 11 Jan 2021 04:35:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20210111030557.4154161-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/01/2021 03:05, Ming Lei wrote:
> Hello Jens,
> 
> All are bioset / bvec improvement, and most of them are quite
> straightforward.

That's cool. As mentioned before, removing inline bvecs brings
struct blkdev_dio from 3 cachelines to 2. And together with no-copy
bvec we can do that shrinking for all bvec based requests.

> 
> V3:
> 	- share two line code via goto with one label, only patch 1 is
> 	  changed
> 
> V2:
> 	- patch style change, most is in patch 1
> 	- commit log change
> 
> Ming Lei (6):
>   block: manage bio slab cache by xarray
>   block: don't pass BIOSET_NEED_BVECS for q->bio_split
>   block: don't allocate inline bvecs if this bioset needn't bvecs
>   block: set .bi_max_vecs as actual allocated vector number
>   block: move three bvec helpers declaration into private helper
>   bcache: don't pass BIOSET_NEED_BVECS for the 'bio_set' embedded in
>     'cache_set'
> 
>  block/bio.c               | 122 +++++++++++++++++---------------------
>  block/blk-core.c          |   2 +-
>  block/blk.h               |   4 ++
>  drivers/md/bcache/super.c |   2 +-
>  include/linux/bio.h       |   4 +-
>  5 files changed, 61 insertions(+), 73 deletions(-)
> 

-- 
Pavel Begunkov
