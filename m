Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5A2C001DF
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 23:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGZXt5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 19:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjGZXt4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 19:49:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592E6AA
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 16:49:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB64661CE1
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 23:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95158C433C7;
        Wed, 26 Jul 2023 23:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690415394;
        bh=duyxayGPGyYB6tDgBD1lGD/hti2swLOmhavt/tWdehw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U1vwc/6WmMJwp45zfrMw9sumtICyNprT4q+WXz8NqRYW8nPqBDpZ34les/xiMt07Z
         wcGyo6flz1jCCUY/NUHj6xRH+YIFdZfBnDOB6a11Z3yFRO74GP99BXcFGrh8poYy5k
         W6RAqD+WOBSpDR0IeagVovBIvV4Hf9egUvBNyAc4/mLvqiKwt7cvcrPZh5NH/ZxMAv
         XFW3DV4UHo3sigvYpP+/PD07Y+gaLkAduxATd87+m5C6c5vnDWeaDC9txXQsUdd8lW
         g9Sq6n4VszxYSLfxZ4WDmeHe4uLHvVp/Kq3W5kjKA3GXp/4Yo9vsT9lJI+0DKA2X/7
         dwkNQQFtOWL3w==
Message-ID: <0d16f27b-24aa-513c-0a55-55244a057c8d@kernel.org>
Date:   Thu, 27 Jul 2023 08:49:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/7] block: Introduce the flag
 QUEUE_FLAG_NO_ZONE_WRITE_LOCK
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20230726193440.1655149-1-bvanassche@acm.org>
 <20230726193440.1655149-2-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230726193440.1655149-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/23 04:34, Bart Van Assche wrote:
> Writes in sequential write required zones must happen at the write
> pointer. Even if the submitter of the write commands (e.g. a filesystem)
> submits writes for sequential write required zones in order, the block
> layer or the storage controller may reorder these write commands.
> 
> The zone locking mechanism in the mq-deadline I/O scheduler serializes
> write commands for sequential zones. Some but not all storage controllers
> require this serialization. Introduce a new flag such that block drivers
> can request that zone write locking is disabled.

For the last sentence:

Introduce the new flag QUEUE_FLAG_NO_ZONE_WRITE_LOCK to allow block device
drivers to indicate that they can preserve wrtie command ordering and thus do
not require zone write locking to be used.

Is in my opinion a lot clearer.

> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/linux/blkdev.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 2f5371b8482c..066ac395f62f 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -534,6 +534,11 @@ struct request_queue {
>  #define QUEUE_FLAG_NONROT	6	/* non-rotational device (SSD) */
>  #define QUEUE_FLAG_VIRT		QUEUE_FLAG_NONROT /* paravirt device */
>  #define QUEUE_FLAG_IO_STAT	7	/* do disk/partitions IO accounting */
> +/*
> + * Do not use the zone write lock for sequential writes for sequential write
> + * required zones.
> + */
> +#define QUEUE_FLAG_NO_ZONE_WRITE_LOCK 8
>  #define QUEUE_FLAG_NOXMERGES	9	/* No extended merges */
>  #define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
>  #define QUEUE_FLAG_SYNCHRONOUS	11	/* always completes in submit context */
> @@ -597,6 +602,11 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
>  #define blk_queue_skip_tagset_quiesce(q) \
>  	test_bit(QUEUE_FLAG_SKIP_TAGSET_QUIESCE, &(q)->queue_flags)
>  
> +static inline bool blk_queue_no_zone_write_lock(struct request_queue *q)
> +{
> +	return test_bit(QUEUE_FLAG_NO_ZONE_WRITE_LOCK, &q->queue_flags);
> +}
> +
>  extern void blk_set_pm_only(struct request_queue *q);
>  extern void blk_clear_pm_only(struct request_queue *q);

Looks good, but I really think this should be squashed with patch 2. More on
this in reply to that patch.

>  

-- 
Damien Le Moal
Western Digital Research

