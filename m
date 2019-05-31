Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DE2C04AB6
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 15:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F99218D1
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 15:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfEaPhm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 May 2019 11:37:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38713 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaPhm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 May 2019 11:37:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id v11so4249028pgl.5;
        Fri, 31 May 2019 08:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GYc1gNT1Xe9N3fTCA8MDQH9AU47pfIUOquAhYDNc18I=;
        b=mpL0KmP7NG4T4j/WafbPOfo0Q+k3KwqACmzmhcs+hsC7Uv/k6u0vkZ2ZRiohLAyLod
         xO/tcUMlWei5pQ4TQdUFuujFYUL9xzVbBRnLr2bpb5Q3DSMO4xrovFKaknycPzVo1TqJ
         Hx+jotoVVVH4hxNwS4Ways7iDaeTMp6FTsgbFb7+uqLWe5wi0AABzbrrVO0thhdaffEM
         yzKYzLrQQRizT5eMbkGUMckhyyY79uW1mrgp1zUBYS/wt1frWw2SAeWlmROZTiRIFKeg
         KqqAL8ClO84ThnDcxIFyb++rn2aoLekliXmxH5Hwg/KgJa0DAc1Wsd1QnmWp+Qm5X+A5
         cH4g==
X-Gm-Message-State: APjAAAW1VoPUxkgwqok9vwQumla/DMxWw5fPoyDjc+ZCSLut4UvceOzF
        LxBKvrhHd38rSkxE26QLYMM=
X-Google-Smtp-Source: APXvYqzLZfkFMT5ikwvb/uIBEwiRnxzcn5Mx3p6yryK4GXrt7HIRr5nAzFlxut2dsZAuGFeOotaUOw==
X-Received: by 2002:a17:90a:fa09:: with SMTP id cm9mr10066010pjb.137.1559317061195;
        Fri, 31 May 2019 08:37:41 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id u1sm6509024pfh.85.2019.05.31.08.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 08:37:40 -0700 (PDT)
Subject: Re: [PATCH 1/9] blk-mq: allow hw queues to share hostwide tags
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190531022801.10003-1-ming.lei@redhat.com>
 <20190531022801.10003-2-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <90d85b99-3bc0-fb3b-8537-aeac03414eae@acm.org>
Date:   Fri, 31 May 2019 08:37:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531022801.10003-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/30/19 7:27 PM, Ming Lei wrote:
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 6aea0ebc3a73..3d6780504dcb 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -237,6 +237,7 @@ static const char *const alloc_policy_name[] = {
>   static const char *const hctx_flag_name[] = {
>   	HCTX_FLAG_NAME(SHOULD_MERGE),
>   	HCTX_FLAG_NAME(TAG_SHARED),
> +	HCTX_FLAG_NAME(HOST_TAGS),
>   	HCTX_FLAG_NAME(BLOCKING),
>   	HCTX_FLAG_NAME(NO_SCHED),
>   };

The name BLK_MQ_F_HOST_TAGS suggests that tags are shared across a SCSI 
host. That is misleading since this flag means that tags are shared 
across hardware queues. Additionally, the "host" term is a term that 
comes from the SCSI world and this patch is a block layer patch. That 
makes me wonder whether another name should be used to reflect that all 
hardware queues share the same tag set? How about renaming 
BLK_MQ_F_TAG_SHARED into BLK_MQ_F_TAG_QUEUE_SHARED and renaming 
BLK_MQ_F_HOST_TAGS into BLK_MQ_F_TAG_HCTX_SHARED?

Bart.
