Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF8CC433B4
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 19:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F053461139
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 19:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbhDOTTV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 15:19:21 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:36678 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbhDOTTT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 15:19:19 -0400
Received: by mail-pg1-f173.google.com with SMTP id j7so8158195pgi.3;
        Thu, 15 Apr 2021 12:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2/mLy6Qs38Bvj+YcPWXxnazVy7EEcqhvZh36iJtGe/k=;
        b=RnVSwskXBY+Tw3xUCKBZDp7ZakDj+QRRP4bwpoeVxqDc5ROd9oMlD1MaPpbzoOAurl
         p6WmJTtMLuH9SowsSK2PpDZpQJ+R0VgOu6oO2h6uvB3HgsEeMs1xfXXTxmofQ0ULX9pA
         ZJrPcwHWk7E4jI8zFS3SHfNHydLV+MD7nTwl/pzsbEaCaf4Bt6jwHKzR7l/YqbkL2EOY
         TObDuanFtLGmAlUcvyXxOjd+PWXYjakdOsCBOLvTCoqz4GeF7ZQcuAlRofuqEXeESTrF
         MqU73vCze2gaecim0JnCkikWG7pOqXO+ZWqFXLmdcQ7tD7otAR9mxPWACF1yh6vSz/NF
         bo2Q==
X-Gm-Message-State: AOAM533XG8ZGUxDUftEWpyjsTEcI/iYiYfkbnCzSITGngzFNJR4B2QxE
        X2QQsyYlR6S3DghLr7X9HgI=
X-Google-Smtp-Source: ABdhPJxcEkFOz6ufalkpcUWU6vIEZxqym/3RNh3KzZq4gpOTNmEEkp/ON7d1ksaDya0GjnK/kkOxWg==
X-Received: by 2002:a65:6704:: with SMTP id u4mr4763609pgf.169.1618514335629;
        Thu, 15 Apr 2021 12:18:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:f031:1d3a:7e95:2876? ([2601:647:4000:d7:f031:1d3a:7e95:2876])
        by smtp.gmail.com with ESMTPSA id p22sm3154516pjg.39.2021.04.15.12.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 12:18:54 -0700 (PDT)
Subject: Re: [PATCH v7 1/3] bio: limit bio max size
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, gregkh@linuxfoundation.org,
        hch@infradead.org, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        mj0123.lee@samsung.com, osandov@fb.com, patchwork-bot@kernel.org,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        tj@kernel.org, tom.leiming@gmail.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
References: <2e54f27a-ae4c-af65-34ba-18b43bd4815d@acm.org>
 <CGME20210415105608epcas1p269bae87b8a7dab133753f7916420251e@epcas1p2.samsung.com>
 <20210415103820.23272-1-nanich.lee@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <bb8f7127-edff-4a32-2d5c-4343002bda19@acm.org>
Date:   Thu, 15 Apr 2021 12:18:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210415103820.23272-1-nanich.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/15/21 3:38 AM, Changheun Lee wrote:
> @@ -167,6 +168,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
>  	max_sectors = round_down(max_sectors,
>  				 limits->logical_block_size >> SECTOR_SHIFT);
>  	limits->max_sectors = max_sectors;
> +	limits->bio_max_bytes = max_sectors << SECTOR_SHIFT;
>  
>  	q->backing_dev_info->io_pages = max_sectors >> (PAGE_SHIFT - 9);
>  }

Can the new shift operation overflow? If so, how about using
check_shl_overflow()?

> @@ -538,6 +540,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>  {
>  	unsigned int top, bottom, alignment, ret = 0;
>  
> +	t->bio_max_bytes = min_not_zero(t->bio_max_bytes, b->bio_max_bytes);
> +
>  	t->max_sectors = min_not_zero(t->max_sectors, b->max_sectors);
>  	t->max_hw_sectors = min_not_zero(t->max_hw_sectors, b->max_hw_sectors);
>  	t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);

The above will limit bio_max_bytes for all stacked block devices, which
is something we do not want. I propose to set t->bio_max_bytes to
UINT_MAX in blk_stack_limits() and to let the stacked driver (e.g.
dm-crypt) decide whether or not to lower that value.

> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index d0246c92a6e8..e5add63da3af 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -106,6 +106,8 @@ static inline void *bio_data(struct bio *bio)
>  	return NULL;
>  }
>  
> +extern unsigned int bio_max_size(struct bio *bio);

You may want to define bio_max_size() as an inline function in bio.h
such that no additional function calls are introduced in the hot path.

Thanks,

Bart.


