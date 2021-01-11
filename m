Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966FCC433E0
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 07:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B87225A9
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 07:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbhAKHMH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 02:12:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:43752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbhAKHMH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 02:12:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 00E1CAFB4;
        Mon, 11 Jan 2021 07:11:25 +0000 (UTC)
Subject: Re: [PATCH] blk-mq-debugfs: Add decode for BLK_MQ_F_TAG_HCTX_SHARED
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1610096137-187414-1-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <574c9ec8-d262-b47d-9fc8-f09ede4516fc@suse.de>
Date:   Mon, 11 Jan 2021 08:11:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1610096137-187414-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/8/21 9:55 AM, John Garry wrote:
> Showing the hctx flags for when BLK_MQ_F_TAG_HCTX_SHARED is set gives
> something like:
> 
> root@debian:/home/john# more /sys/kernel/debug/block/sda/hctx0/flags
> alloc_policy=FIFO SHOULD_MERGE|TAG_QUEUE_SHARED|3
> 
> Add the decoding for that flag.
> 
> Fixes: 32bc15afed04b ("blk-mq: Facilitate a shared sbitmap per tagset")
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 3094542e12ae..ea4ab98e6b25 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -245,6 +245,7 @@ static const char *const hctx_flag_name[] = {
>   	HCTX_FLAG_NAME(BLOCKING),
>   	HCTX_FLAG_NAME(NO_SCHED),
>   	HCTX_FLAG_NAME(STACKING),
> +	HCTX_FLAG_NAME(TAG_HCTX_SHARED),
>   };
>   #undef HCTX_FLAG_NAME
>   
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
