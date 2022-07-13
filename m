Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2921EC433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Jul 2022 12:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiGMMZ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jul 2022 08:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbiGMMZv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jul 2022 08:25:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEF8E9213
        for <linux-block@vger.kernel.org>; Wed, 13 Jul 2022 05:25:42 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g1so13850653edb.12
        for <linux-block@vger.kernel.org>; Wed, 13 Jul 2022 05:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qXqGFu8U4gPDVSr/ggPX1zJdQr5HzeAZdYNrxVaBP2U=;
        b=vTibGfqb8AoB8dfwXHh8bxVf5FbFeYJTrOLebeWcAQTsARpBmyHDJEnUnBIrIfttvA
         r3uR8GsvihZGcnixyJ1ybBzhizpsWGC8XNv0eah0RCuuKzDmiAti20pRwJemgLF+BEVc
         ehKpt9RsXGhj8HC0ZOoluR+VGr8i6Ga8NNvsMXbCqi6yI57KT9Rt3agP9JXsB/Han+gK
         zlfO+6gnu5fZbFAJFUVBzLfGv6wM7uLmp/82YfF6L0pZCUM5prM7HSQT6YHfrk27znqQ
         xp645/qTAw+03mufD09Axo2GVH6ifvt1mOsvsUAtOalPKP2vZRehwNJrzk4M4k10rqJY
         g68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qXqGFu8U4gPDVSr/ggPX1zJdQr5HzeAZdYNrxVaBP2U=;
        b=W/PWT7gttTsKT5mEhaWD0H1NeNH+NUpwSVF7mmYGV7aL3GTrBq8u8WuuLgnrxHLc9y
         gTelK9wSDJpZUUzhiAfD1f1Iku4SUD5rRZ5x6WGke8LJ9R3WUcjTXuUaNc1QWC/MnKZl
         Ja+vYx7mMNP47pUN32dd1m5cErWZWs6R8Dj7DawmT+eJvGEz6jE8Djrv04FizWjav27D
         yIj43l6WJJ3dxbW1CiZC1FLcMLTQlLCp3ZEhzfSomj+qq1O33wqE6pB9SPt62pdctBrq
         NZuQjR0hdau6HCfDxtrWfKEYKLD67KjEQ6j3G5gxVLYna3rm7oaud85L8c1P8Nwx9jtH
         eqSw==
X-Gm-Message-State: AJIora95aDnRai9+1cMicnnxQhtOFm33zawo1S4VHb5J98CJgsZ/T0NG
        fdSHXRF7qHEx+m2RwqV0i9Zh9A==
X-Google-Smtp-Source: AGRyM1t2anjpsABs9moN8/saQwoeQFzlk9BcJwJ81FhrhmrzcGBgnKja0O11XVp6U4a5FFOg06Pmhg==
X-Received: by 2002:a05:6402:354c:b0:43a:dc59:657 with SMTP id f12-20020a056402354c00b0043adc590657mr4381358edd.405.1657715140797;
        Wed, 13 Jul 2022 05:25:40 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090632c500b0072aa014e852sm4924686ejk.87.2022.07.13.05.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 05:25:40 -0700 (PDT)
Message-ID: <1304fd58-1577-3f27-0ee8-64964bd54467@linbit.com>
Date:   Wed, 13 Jul 2022 14:25:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/9] drbd: stop using bdevname in drbd_report_io_error
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Song Liu <song@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
References: <20220713055317.1888500-1-hch@lst.de>
 <20220713055317.1888500-4-hch@lst.de>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220713055317.1888500-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 13.07.22 um 07:53 schrieb Christoph Hellwig:
> Just use the %pg format specifier instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/drbd/drbd_req.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
> index e64bcfba30ef3..6d8dd14458c69 100644
> --- a/drivers/block/drbd/drbd_req.c
> +++ b/drivers/block/drbd/drbd_req.c
> @@ -523,16 +523,14 @@ static void mod_rq_state(struct drbd_request *req, struct bio_and_error *m,
>  
>  static void drbd_report_io_error(struct drbd_device *device, struct drbd_request *req)
>  {
> -        char b[BDEVNAME_SIZE];
> -
>  	if (!__ratelimit(&drbd_ratelimit_state))
>  		return;
>  
> -	drbd_warn(device, "local %s IO error sector %llu+%u on %s\n",
> +	drbd_warn(device, "local %s IO error sector %llu+%u on %pg\n",
>  			(req->rq_state & RQ_WRITE) ? "WRITE" : "READ",
>  			(unsigned long long)req->i.sector,
>  			req->i.size >> 9,
> -			bdevname(device->ldev->backing_bdev, b));
> +			device->ldev->backing_bdev);
>  }
>  
>  /* Helper for HANDED_OVER_TO_NETWORK.

For the drbd part:

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

Thanks.

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
