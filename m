Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9078C6FD1D
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 22:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCQW2R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 18:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCQW2Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 18:28:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFD94C6FD
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 15:28:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E65E31FE34;
        Fri, 17 Mar 2023 22:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679092093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nq97KjuKrJoKusuMAN0Ul4Ghjteo9qeitM20sZqhuws=;
        b=ceKCTaWB5u/afkoxzo2SEj/0V7GZQRGutgFWKMHqkTAnhgYrhkAYHzODzjNkJ+iIwYHBZk
        ZzjGjjq3vIPwEL0SBGoA6nR4/r6VEkVB5pi6jht+eFCT3zvSMbkW63QVeDEcCpwbo+3XaT
        yOvNsu0gjBxMM31+fBj41W6cjBBqHbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679092093;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nq97KjuKrJoKusuMAN0Ul4Ghjteo9qeitM20sZqhuws=;
        b=vfXCoiCwk+zhBV2jT8XO2B3DhZVmY2h00LMO2RCVm3QLc/oyOSs/v1yrVbL8SF56MLBuj6
        jr8SI0pS9L7J1+BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8CE313428;
        Fri, 17 Mar 2023 22:28:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CKvnNH3pFGTYTwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 17 Mar 2023 22:28:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 63585A06FD; Fri, 17 Mar 2023 23:28:13 +0100 (CET)
Date:   Fri, 17 Mar 2023 23:28:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Message-ID: <20230317222813.xkjia2cottjwzls7@quack3>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230317195938.1745318-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317195938.1745318-3-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 17-03-23 12:59:38, Bart Van Assche wrote:
> Instead of submitting the bio fragment with the highest LBA first,
> submit the bio fragment with the lowest LBA first. If plugging is
> active, append requests at the end of the list with plugged requests
> instead of at the start. This approach prevents write errors when
> submitting large bios to host-managed zoned block devices.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

...

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index cc32ad0cd548..9b0f9f3fdba0 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1300,7 +1300,7 @@ static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
>  
>  static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
>  {
> -	struct request *last = rq_list_peek(&plug->mq_list);
> +	struct request *last = rq_list_peek(&plug->mq_list), **last_p;
>  
>  	if (!plug->rq_count) {
>  		trace_block_plug(rq->q);
> @@ -1317,7 +1317,10 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
>  	if (!plug->has_elevator && (rq->rq_flags & RQF_ELV))
>  		plug->has_elevator = true;
>  	rq->rq_next = NULL;
> -	rq_list_add(&plug->mq_list, rq);
> +	last_p = &plug->mq_list;
> +	while (*last_p)
> +		last_p = &(*last_p)->rq_next;
> +	rq_list_add_tail(&last_p, rq);
>  	plug->rq_count++;
>  }

Uh, I don't think we want to traverse the whole plug list each time we are
adding a request to it. We have just recently managed to avoid that at
least for single-device cases and apparently it was a win for fast devices
(see commit d38a9c04c0d5 ("block: only check previous entry for plug merge
attempt")).

If anything, I'd rather modify blk_mq_dispatch_plug_list() to add requests
to the queuelist in reverse order in this case, like I did it in
34e0a279a993 ("block: do not reverse request order when flushing plug
list") which is now in Jens' tree.

> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index dd5ce1137f04..5e01791967c0 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -228,6 +228,12 @@ static inline unsigned short req_get_ioprio(struct request *req)
>  	*(listptr) = rq;				\
>  } while (0)
>  
> +#define rq_list_add_tail(lastpptr, rq) do {		\
> +	(rq)->rq_next = NULL;				\
> +	**(lastpptr) = rq;				\
> +	*(lastpptr) = &rq->rq_next;			\
> +} while (0)
> +

And this function should be already in Jens's tree as part of commit
34e0a279a993 ("block: do not reverse request order when flushing plug
list").

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
