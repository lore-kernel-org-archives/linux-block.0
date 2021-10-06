Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63AFC433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 17:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF72861184
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 17:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhJFR5v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 13:57:51 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:42504 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJFR5v (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 13:57:51 -0400
Received: by mail-pj1-f54.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso528432pjb.1
        for <linux-block@vger.kernel.org>; Wed, 06 Oct 2021 10:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RaNSR5nhuH4MIzXHEr+eJpwQXScc8btGVTFUT4+CjYw=;
        b=jTS7t0T/+upVfBD4qpwULSJdL0vLo3CLLtuFJ2ERxsekiwN+yLxmH1z4SEKtWJGZrC
         UUA057ghkmkx/+CSA1s4Sl3hjAO5KoxZ0HrlpCOjj+7/1OqSqegF64uX+b8XCX9C5rQX
         yTZnjCRCkxTU78Ljw4fAb9qpTVqNUFGOzxyDHjYEXwK26j/vyTKB1xOQ+/4NrsOij+Ab
         igjj25U+ea/wvJYsDDBdc5YMBNmv7QU766Aq9IPRK5ARZSM+HngRiurJJW7v19ByYrtY
         K+GsnIg0zL+WhVEQrk1DP06UgapliHALsZu4y//iXYxywTP3tfRbboCACrZP+zkOea7B
         J0Lw==
X-Gm-Message-State: AOAM532Af8p1EvhMgdWQ40pyd2MJxEg4/0Fd+vMX5RMnpaDnk4C+qtO1
        aLVh+k7biaccWKLydm83HB/8cxb7wGE=
X-Google-Smtp-Source: ABdhPJw0w/eFFpIYMQDaDelBApERaOPDe6xSnzlFmAMlJZAtajEQzB6wFUxpqXfR+i90m0cxlYYiAw==
X-Received: by 2002:a17:90b:4a51:: with SMTP id lb17mr83316pjb.41.1633542958507;
        Wed, 06 Oct 2021 10:55:58 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:6ad6:c36f:fdfb:9e74])
        by smtp.gmail.com with ESMTPSA id x13sm7198749pgt.80.2021.10.06.10.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 10:55:58 -0700 (PDT)
Subject: Re: [PATCH 1/3] block: bump max plugged deferred size from 16 to 32
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20211006163522.450882-1-axboe@kernel.dk>
 <20211006163522.450882-2-axboe@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <54e098e5-8230-a04f-e4fa-83a9cfa94649@acm.org>
Date:   Wed, 6 Oct 2021 10:55:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211006163522.450882-2-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/6/21 9:35 AM, Jens Axboe wrote:
> Particularly for NVMe with efficient deferred submission for many
> requests, there are nice benefits to be seen by bumping the default max
> plug count from 16 to 32. This is especially true for virtualized setups,
> where the submit part is more expensive. But can be noticed even on
> native hardware.
> 
> Reduce the multiple queue factor from 4 to 2, since we're changing the
> default size.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-mq.c         | 4 ++--
>   include/linux/blkdev.h | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a40c94505680..5327abbefbab 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2145,14 +2145,14 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
>   }
>   
>   /*
> - * Allow 4x BLK_MAX_REQUEST_COUNT requests on plug queue for multiple
> + * Allow 2x BLK_MAX_REQUEST_COUNT requests on plug queue for multiple
>    * queues. This is important for md arrays to benefit from merging
>    * requests.
>    */
>   static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
>   {
>   	if (plug->multiple_queues)
> -		return BLK_MAX_REQUEST_COUNT * 4;
> +		return BLK_MAX_REQUEST_COUNT * 2;
>   	return BLK_MAX_REQUEST_COUNT;
>   }
>   
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index b19172db7eef..534298ac73cc 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -727,7 +727,7 @@ struct blk_plug {
>   	bool multiple_queues;
>   	bool nowait;
>   };
> -#define BLK_MAX_REQUEST_COUNT 16
> +#define BLK_MAX_REQUEST_COUNT 32
>   #define BLK_PLUG_FLUSH_SIZE (128 * 1024)
>   
>   struct blk_plug_cb;

Since BLK_MAX_REQUEST_COUNT is only used inside the block layer core but 
not by any block driver, can it be moved from include/linux/blkdev.h 
into block/blk-mq.h?

Thanks,

Bart.


