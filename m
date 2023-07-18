Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB63EB64DA
	for <linux-block@archiver.kernel.org>; Tue, 18 Jul 2023 06:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjGRGeI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jul 2023 02:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjGRGeH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jul 2023 02:34:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2F9FC
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 23:34:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3322B61477
        for <linux-block@vger.kernel.org>; Tue, 18 Jul 2023 06:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C761C433C7;
        Tue, 18 Jul 2023 06:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689662045;
        bh=h6IV+0AF6EdspkaKxVjuE4e+v+qFCPwySSlaMJcs0gQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BXlh30W/CBE/7XRu5IBgzNHB3Wz4UownQu/6/pbulpUuytlIPB5FtqxBmk49IQvWa
         bmIzKCyqftFi4XOQsu6ZjjXoVB0q1qm/pkvq/WoyH6I9gPNdMvOfVQnIt2wCoo/xUK
         YZq3mD3zQcltVXGBjAp8YzmWXQG1a1fU9R4H4shYm/3IVAIomSFQrt/hFCL+gVrC3N
         XIvw+I7OtWR5EsGnBsk0v1Gd+Z4quXyXXJO4x/o2wJtQBQWORbhK2EEVTQ1L2XradO
         NiPlJzl+3SQ9G0Boby4q9dieJgcH2ZcgSqAgCLgnpL4WwCb5wmSgQIyPSbNnE6TsTm
         JC/jwRNIboeRw==
Message-ID: <9feab737-acb6-9e03-effb-8b130fdfa12a@kernel.org>
Date:   Tue, 18 Jul 2023 15:34:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/5] block: Introduce a request queue flag for
 pipelining zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20230710180210.1582299-1-bvanassche@acm.org>
 <20230710180210.1582299-2-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230710180210.1582299-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/11/23 03:01, Bart Van Assche wrote:
> Writes in sequential write required zones must happen at the write
> pointer. Even if the submitter of the write commands (e.g. a filesystem)
> submits writes for sequential write required zones in order, the block
> layer or the storage controller may reorder these write commands.
> 
> The zone locking mechanism in the mq-deadline I/O scheduler serializes
> write commands for sequential zones. Some but not all storage controllers
> require this serialization. Introduce a new flag such that block drivers
> can request pipelining of writes for sequential write required zones.
> 
> An example of a storage controller standard that requires write
> serialization is AHCI (Advanced Host Controller Interface). Submitting
> commands to AHCI controllers happens by writing a bit pattern into a
> register. Each set bit corresponds to an active command. This mechanism
> does not preserve command ordering information.
> 
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/linux/blkdev.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index ed44a997f629..805012c5a6ab 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -534,6 +534,8 @@ struct request_queue {
>  #define QUEUE_FLAG_NONROT	6	/* non-rotational device (SSD) */
>  #define QUEUE_FLAG_VIRT		QUEUE_FLAG_NONROT /* paravirt device */
>  #define QUEUE_FLAG_IO_STAT	7	/* do disk/partitions IO accounting */
> +/* Writes for sequential write required zones may be pipelined. */
> +#define QUEUE_FLAG_PIPELINE_ZONED_WRITES 8

I am not a big fan of this name as "pipeline" does not necessarily imply "high
queue depth write". What about simply calling this
QUEUE_FLAG_NO_ZONE_WRITE_LOCK, indicating that there is no need to write-lock
zones ?

>  #define QUEUE_FLAG_NOXMERGES	9	/* No extended merges */
>  #define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
>  #define QUEUE_FLAG_SYNCHRONOUS	11	/* always completes in submit context */
> @@ -596,6 +598,11 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
>  #define blk_queue_skip_tagset_quiesce(q) \
>  	test_bit(QUEUE_FLAG_SKIP_TAGSET_QUIESCE, &(q)->queue_flags)
>  
> +static inline bool blk_queue_pipeline_zoned_writes(struct request_queue *q)
> +{
> +	return test_bit(QUEUE_FLAG_PIPELINE_ZONED_WRITES, &q->queue_flags);
> +}
> +
>  extern void blk_set_pm_only(struct request_queue *q);
>  extern void blk_clear_pm_only(struct request_queue *q);
>  

-- 
Damien Le Moal
Western Digital Research

