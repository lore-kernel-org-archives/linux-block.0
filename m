Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C88C001DE
	for <linux-block@archiver.kernel.org>; Wed,  2 Aug 2023 09:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbjHBJMV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Aug 2023 05:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbjHBJMT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Aug 2023 05:12:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F5C2D4E
        for <linux-block@vger.kernel.org>; Wed,  2 Aug 2023 02:12:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C260D618B8
        for <linux-block@vger.kernel.org>; Wed,  2 Aug 2023 09:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDC0C433C8;
        Wed,  2 Aug 2023 09:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690967537;
        bh=UTxARlk7ZzXtrJK2zj2BkEzYy5IvjFv8aDaq/qtlTts=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nz3abdTpKf6f9XcXYgVFjNGu3zhjGjox9AlATBpGULGqNltBm0jem/lQFUZ5cYHEX
         6m8kGFuAxAv5H+wgmuBHIyjspu9Lu17KzUqH+qr4ZU5vs7w2lwOvDxbAvDNN13r0on
         S+Gy8nCcrwugzBKnU1lzL9vmFHbDc/CvJD8WeMUsyjuXKDi9ozLdzzImzQa1o6Fwj7
         oRd8GXe4s0HfmVXuAb0wPlsMd6PDzy3CJnpJjMZgIe1py6l17JwArHsB8ti/hdFvtX
         JI5UGlrsGV/046EO6laW55CULfegWTocqun/TD09qhJvZhASNikYRIPsbLvbgDg2vY
         5mxjEK+IeBbgA==
Message-ID: <b07c0809-26ba-ab28-9c6c-8d0438fbbeb4@kernel.org>
Date:   Wed, 2 Aug 2023 18:12:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/7] block: Introduce the flag
 QUEUE_FLAG_NO_ZONE_WRITE_LOCK
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230731221458.437440-1-bvanassche@acm.org>
 <20230731221458.437440-2-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230731221458.437440-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/1/23 07:14, Bart Van Assche wrote:
> Writes in sequential write required zones must happen at the write
> pointer. Even if the submitter of the write commands (e.g. a filesystem)
> submits writes for sequential write required zones in order, the block
> layer or the storage controller may reorder these write commands.
> 
> The zone locking mechanism in the mq-deadline I/O scheduler serializes
> write commands for sequential zones. Some but not all storage controllers
> require this serialization. Introduce a new request queue flag to allow
> block drivers to indicate that they preserve the order of write commands
> and thus do not require serialization of writes per zone.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks OK.
Very minor nit below.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  include/linux/blkdev.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 2f5371b8482c..de5e05cc34fa 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -534,6 +534,11 @@ struct request_queue {
>  #define QUEUE_FLAG_NONROT	6	/* non-rotational device (SSD) */
>  #define QUEUE_FLAG_VIRT		QUEUE_FLAG_NONROT /* paravirt device */
>  #define QUEUE_FLAG_IO_STAT	7	/* do disk/partitions IO accounting */
> +/*
> + * Do not serialize sequential writes (REQ_OP_WRITE, REQ_OP_WRITE_ZEROES) sent
> + * to a sequential write required zone (BLK_ZONE_TYPE_SEQWRITE_REQ).
> + */

I would be very explicit here, for this to be clear to people who are not
familiar with zone device write operation handling. Something like:

/*
 * The device supports not using the zone write locking mechanism to serialize
 * write operations (REQ_OP_WRITE, REQ_OP_WRITE_ZEROES) issued to a sequential
 * write required zone (BLK_ZONE_TYPE_SEQWRITE_REQ).
 */

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
>  

-- 
Damien Le Moal
Western Digital Research

