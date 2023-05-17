Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C09C77B7F
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 07:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjEQHrz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 03:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjEQHrx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 03:47:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715133AA1
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 00:47:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 264E32050C;
        Wed, 17 May 2023 07:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684309671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TbL6fsgbsCKGzaqciGoEd4JLEL/xl2mVEjFdq31D7WE=;
        b=x3DdkKCLoqPq53qrxyIv6GzfZYBcHnFl9AcVifNYriif89RDmEJN6rOvhll+KIRKhgZG3L
        O+eklf6kmiqch64VVVaR6f4naatlbjwZST8G9PUTWnjWhJjtE3XxHd5broYnd4dzpIYo3B
        VAsrtzJsbzsV62HZIIuHo2g29aLtgCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684309671;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TbL6fsgbsCKGzaqciGoEd4JLEL/xl2mVEjFdq31D7WE=;
        b=SNG9JDIJVlkgv5qjcNVvxD8iUaqmvPHoHKeqPyMKgqgLwUhw0TnH4h2I74PCErHwNFAZno
        Z/YCQqij2qAc3pBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD6E913358;
        Wed, 17 May 2023 07:47:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GUPONKaGZGQLFwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 17 May 2023 07:47:50 +0000
Message-ID: <4a037c7b-ba78-0db1-936b-85e112df00fa@suse.de>
Date:   Wed, 17 May 2023 09:47:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 11/11] block: mq-deadline: Fix handling of at-head
 zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-12-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230516223323.1383342-12-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 00:33, Bart Van Assche wrote:
> Before dispatching a zoned write from the FIFO list, check whether there
> are any zoned writes in the RB-tree with a lower LBA for the same zone.
> This patch ensures that zoned writes happen in order even if at_head is
> set for some writes for a zone and not for others.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 059727fa4b98..67989f8d29a5 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -346,7 +346,7 @@ static struct request *
>   deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>   		      enum dd_data_dir data_dir)
>   {
> -	struct request *rq;
> +	struct request *rq, *rb_rq, *next;
>   	unsigned long flags;
>   
>   	if (list_empty(&per_prio->fifo_list[data_dir]))
> @@ -364,7 +364,12 @@ deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>   	 * zones and these zones are unlocked.
>   	 */
>   	spin_lock_irqsave(&dd->zone_lock, flags);
> -	list_for_each_entry(rq, &per_prio->fifo_list[DD_WRITE], queuelist) {
> +	list_for_each_entry_safe(rq, next, &per_prio->fifo_list[DD_WRITE],
> +				 queuelist) {
> +		/* Check whether a prior request exists for the same zone. */
> +		rb_rq = deadline_from_pos(per_prio, data_dir, blk_rq_pos(rq));
> +		if (rb_rq && blk_rq_pos(rb_rq) < blk_rq_pos(rq))
> +			rq = rb_rq;
>   		if (blk_req_can_dispatch_to_zone(rq) &&
>   		    (blk_queue_nonrot(rq->q) ||
>   		     !deadline_is_seq_write(dd, rq)))

Similar concern here; we'll have to traverse the entire tree here.
But if that's of no concern...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

