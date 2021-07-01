Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6433DC11F66
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 01:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4057961466
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 01:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbhGABmZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 21:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238337AbhGABmX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 21:42:23 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64326C061756
        for <linux-block@vger.kernel.org>; Wed, 30 Jun 2021 18:39:38 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id v5so4886720ilo.5
        for <linux-block@vger.kernel.org>; Wed, 30 Jun 2021 18:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1hqXKZSGMg3CSP26imBZZO41DFIqQcx09xhUSdTS4U4=;
        b=Y0PMs54t5ofGBNVFJYq2DbsZKdZzzHuj3VHHGeoA4xrSNBxzYRGj3GAILB6l7dQ4qQ
         xC4BAA5rjG64jLpLFANeObMdNICpS0TnO1D7Rly/lvN9xAdsZNaGY3xbap6NXq5KEZQC
         zz5M4Se0m4MpPIqlKCIdJkOabTSrGMoZ6zoVOcy5pLuIyazZt6EIrkI1rM04u0ZbNNLj
         SGXo2TjwJMZfxWKxG876sd+vG2Eqam+GP5i3lUHJLsOEQdFs7AgZNJyOfZscaMW3Rr/1
         HMzRGCtwIg1qsKxjpAyGxKhWP37mxvJ4oNyOhbHHLwPXsHDOtfbAbkStwNX1oUdMVr0C
         sVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1hqXKZSGMg3CSP26imBZZO41DFIqQcx09xhUSdTS4U4=;
        b=GX5X/KKXXIzSBlYRApyCNiU1NCCX4G/WYotUahCjXlwDsER9zDPyhoRL4rkyMJH65Q
         uaokODWDYwqz6aadAl5AeY0Yn715pPhQgRHYhaV/p8sl3AbuAlMNtwphdAuu7vZwk0RD
         qJH0NW8r/k8dTZp1RmsbWZFM7eDslCJXMZLGCXzP6UY/2+e/gn9tcpVn5tYZY2WWhGj8
         T+dH2y1s7rgBnGvVwO+yuS3sPFNUEU7WUV2ENryTeYcsmfspRqvVxg6zWZMrkjUb6/oW
         qlZKUE8PV47a6JwS63zmnottOosFrQmhMZvA4/Q1OPJcawixY2bdEtGPiHHU2HySO3Hu
         mxTA==
X-Gm-Message-State: AOAM530lV+2M+ROQVvtv4yo44vsXMzzrcX0mvIdhJx0wkUCotBcmefrE
        28Q/ykEEeaS4/GOqJ3GBDVOEqQ==
X-Google-Smtp-Source: ABdhPJxLJr0112hvRSzh2ru77N70EFbgf7AVDfWHFT0qubzTLrzazkGZu7/aMn+/Fx420fbNNtqBFw==
X-Received: by 2002:a05:6e02:1010:: with SMTP id n16mr28748362ilj.146.1625103577695;
        Wed, 30 Jun 2021 18:39:37 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id b6sm9068193ioz.33.2021.06.30.18.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 18:39:37 -0700 (PDT)
Subject: Re: [PATCH v2] block: check disk exist before trying to add partition
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
References: <20210610023241.3646241-1-yuyufen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9c26b7d0-d234-d92e-0390-c4c872d69f1a@kernel.dk>
Date:   Wed, 30 Jun 2021 19:39:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210610023241.3646241-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/21 8:32 PM, Yufen Yu wrote:
> If disk have been deleted, we should return fail for ioctl
> BLKPG_DEL_PARTITION. Otherwise, the directory /sys/class/block
> may remain invalid symlinks file. The race as following:
> 
> blkdev_open
> 				del_gendisk
> 				    disk->flags &= ~GENHD_FL_UP;
> 				    blk_drop_partitions
> blkpg_ioctl
>     bdev_add_partition
>     add_partition
>         device_add
> 	    device_add_class_symlinks
> 
> ioctl may add_partition after del_gendisk() have tried to delete
> partitions. Then, symlinks file will be created.

Applied, thanks.

-- 
Jens Axboe

