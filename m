Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AFDCA9EB5
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 08:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB08A20873
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 08:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="HVer5Mp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfJUIt5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:49:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42799 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfJUIt5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 04:49:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id s20so3383093edq.9
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2019 01:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Kp4usqZVrtmDJWgUxaXZFXUmZgsZITrUEg5HAm2fC2k=;
        b=HVer5Mp5JngFn7RQPJ+vhjSKvusbNItcPm4kb2W3U1nNyzo2wDx+EqqgwBCS3zhQYx
         fsbq2itXFz6XStGD0oNqkGLU7T8VuGs8rvB9IJAYoxOIc4xv3ZDLrMezxzkh0bYUS9oU
         JzQ+IPmYxCvABY5oEAi0zrb+fjxQ54M2y+1BCNrgMP7zuwh//AzmaXnfGshAcPRkDq9j
         ITFWfUTEPHWYDihwZh+Wg7j7TV49DuassnWVshvHPi1DYP1rzUUCIsTBblpRhJAUpRNj
         OEVf5qa6hWNPrT5//4Ml8enri8t8ILkpGt7AZh8ipYO2V1iKEoa5+fJX2cY1SkrS8MAg
         dbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Kp4usqZVrtmDJWgUxaXZFXUmZgsZITrUEg5HAm2fC2k=;
        b=eGtUVM7AoYbUPZ8NNk1+6LusKemgld8TcQpThuhve/dspPs4CsCzHtXicHE/YpZ+xg
         LWq/mF99q9V82/xgKGG4LTq/8MUY50IqPN/KR4vIIwAFhhfLZ9wIY4JyXKge+WvNM1YG
         DYtjACbMvNV8Hbsm6FduapSVOBZ9KzT5V/H3uFWwtFL67d8CJ2Z6B9+Wp0RVEXwB1MQN
         9w2eTVBGwdW4giGV9hQBQv/2H2qyAeW1Cu8V/add1ntWY1E4d9MINeFKEUVz4I2WAtJB
         ejDSXUXqPs3Ft4Q4qVUEsaiwRutRtFLpE2QcB+oK1CFh1rRZQNDW2+pPbj9tvtEufvGc
         m/jg==
X-Gm-Message-State: APjAAAVPx3H86FouONtrAU0i1XuaG07CeStGmCR9JjkXagestY8xDkrG
        jm31hG8asL6Bjl56I2t/tKs5m6joP+ro+g==
X-Google-Smtp-Source: APXvYqzfH11SQrJlN+9ycZNlVO7mcoxYlwn+f1loAH5KGc35o9JFm5xs3sWf0fs+yZJ9w02n+2OdOQ==
X-Received: by 2002:a05:6402:304c:: with SMTP id bu12mr7323143edb.230.1571647795277;
        Mon, 21 Oct 2019 01:49:55 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:2920:f165:80aa:e780? ([2001:1438:4010:2540:2920:f165:80aa:e780])
        by smtp.gmail.com with ESMTPSA id s20sm307014edu.9.2019.10.21.01.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 01:49:54 -0700 (PDT)
Subject: Re: [PATCH 2/2] bdev: Refresh bdev size for disks without
 partitioning
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20191021083132.5351-1-jack@suse.cz>
 <20191021083808.19335-2-jack@suse.cz>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <4d58a159-e935-1200-1a71-8eb252fc5bdc@cloud.ionos.com>
Date:   Mon, 21 Oct 2019 10:49:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191021083808.19335-2-jack@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 10/21/19 10:38 AM, Jan Kara wrote:
> Currently, block device size in not updated on second and further open
> for block devices where partition scan is disabled. This is particularly
> annoying for example for DVD drives as that means block device size does
> not get updated once the media is inserted into a drive if the device is
> already open when inserting the media. This is actually always the case
> for example when pktcdvd is in use.
>
> Fix the problem by revalidating block device size on every open even for
> devices with partition scan disabled.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>   fs/block_dev.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 88c6d35ec71d..d612468ee66b 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1403,11 +1403,7 @@ static void flush_disk(struct block_device *bdev, bool kill_dirty)
>   		       "resized disk %s\n",
>   		       bdev->bd_disk ? bdev->bd_disk->disk_name : "");
>   	}
> -
> -	if (!bdev->bd_disk)
> -		return;
> -	if (disk_part_scan_enabled(bdev->bd_disk))
> -		bdev->bd_invalidated = 1;
> +	bdev->bd_invalidated = 1;
>   }
>   
>   /**
> @@ -1514,10 +1510,15 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
>   
>   static void bdev_disk_changed(struct block_device *bdev, bool invalidate)
>   {
> -	if (invalidate)
> -		invalidate_partitions(bdev->bd_disk, bdev);
> -	else
> -		rescan_partitions(bdev->bd_disk, bdev);
> +	if (disk_part_scan_enabled(bdev->bd_disk)) {
> +		if (invalidate)
> +			invalidate_partitions(bdev->bd_disk, bdev);
> +		else
> +			rescan_partitions(bdev->bd_disk, bdev);

Maybe use the new common helper to replace above.

Thanks,
Guoqing

> +	} else {
> +		check_disk_size_change(bdev->bd_disk, bdev, !invalidate);
> +		bdev->bd_invalidated = 0;
> +	}
>   }
>   
>   /*

