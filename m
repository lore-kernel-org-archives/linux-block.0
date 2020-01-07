Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85CEC282DD
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 18:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9FA20656
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 18:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgAGSsK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:48:10 -0500
Received: from mx.ewheeler.net ([173.205.220.69]:54695 "EHLO mx.ewheeler.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728440AbgAGSsJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Jan 2020 13:48:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by mx.ewheeler.net (Postfix) with ESMTP id D0A54A0692;
        Tue,  7 Jan 2020 18:48:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
        by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id QR2IEJIFYrx1; Tue,  7 Jan 2020 18:47:38 +0000 (UTC)
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx.ewheeler.net (Postfix) with ESMTPSA id EA247A0633;
        Tue,  7 Jan 2020 18:47:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net EA247A0633
Date:   Tue, 7 Jan 2020 18:47:36 +0000 (UTC)
From:   Eric Wheeler <dm-devel@lists.ewheeler.net>
X-X-Sender: lists@mx.ewheeler.net
To:     Joe Thornber <thornber@redhat.com>
cc:     LVM2 development <lvm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, markus.schade@gmail.com,
        ejt@redhat.com, linux-block@vger.kernel.org, dm-devel@redhat.com,
        joe.thornber@gmail.com
Subject: Re: [dm-devel] [lvm-devel] kernel BUG at
 drivers/md/persistent-data/dm-space-map-disk.c:178
In-Reply-To: <20200107122825.qr7o5d6dpwa6kv62@reti>
Message-ID: <alpine.LRH.2.11.2001071845350.2074@mx.ewheeler.net>
References: <alpine.LRH.2.11.1909251814220.15810@mx.ewheeler.net> <alpine.LRH.2.11.1912201829300.26683@mx.ewheeler.net> <alpine.LRH.2.11.1912270137420.26683@mx.ewheeler.net> <alpine.LRH.2.11.1912271946380.26683@mx.ewheeler.net> <20200107103546.asf4tmlfdmk6xsub@reti>
 <20200107104627.plviq37qhok2igt4@reti> <20200107122825.qr7o5d6dpwa6kv62@reti>
User-Agent: Alpine 2.11 (LRH 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 7 Jan 2020, Joe Thornber wrote:

> On Tue, Jan 07, 2020 at 10:46:27AM +0000, Joe Thornber wrote:
> > I'll get a patch to you later today.
> 
> Eric,
> 
> Patch below.  I've run it through a bunch of tests in the dm test suite.  But
> obviously I have never hit your issue.  Will do more testing today.


Thank you Joe, I'll apply the patch and pull out the spinlock.  

I'm not familiar with how sync IO prevents a spinlock.  Can you give a 
brief explaination or point me at documentation?

--
Eric Wheeler



> 
> - Joe
> 
> 
> 
> Author: Joe Thornber <ejt@redhat.com>
> Date:   Tue Jan 7 11:58:42 2020 +0000
> 
>     [dm-thin, dm-cache] Fix bug in space-maps.
>     
>     The space-maps track the reference counts for disk blocks.  There are variants
>     for tracking metadata blocks, and data blocks.
>     
>     We implement transactionality by never touching blocks from the previous
>     transaction, so we can rollback in the event of a crash.
>     
>     When allocating a new block we need to ensure the block is free (has reference
>     count of 0) in both the current and previous transaction.  Prior to this patch we
>     were doing this by searching for a free block in the previous transaction, and
>     relying on a 'begin' counter to track where the last allocation in the current
>     transaction was.  This 'begin' field was not being updated in all code paths (eg,
>     increment of a data block reference count due to breaking sharing of a neighbour
>     block in the same btree leaf).
>     
>     This patch keeps the 'begin' field, but now it's just a hint to speed up the search.
>     Instead we search the current transaction for a free block, and then double check
>     it's free in the old transaction.  Much simpler.
> 
> diff --git a/drivers/md/persistent-data/dm-space-map-common.c b/drivers/md/persistent-data/dm-space-map-common.c
> index bd68f6fef694..b4983e4022e6 100644
> --- a/drivers/md/persistent-data/dm-space-map-common.c
> +++ b/drivers/md/persistent-data/dm-space-map-common.c
> @@ -380,6 +380,34 @@ int sm_ll_find_free_block(struct ll_disk *ll, dm_block_t begin,
>  	return -ENOSPC;
>  }
>  
> +int sm_ll_find_common_free_block(struct ll_disk *old_ll, struct ll_disk *new_ll,
> +	                         dm_block_t begin, dm_block_t end, dm_block_t *b)
> +{
> +	int r;
> +	uint32_t count;
> +
> +	do {
> +		r = sm_ll_find_free_block(new_ll, begin, new_ll->nr_blocks, b);
> +		if (r)
> +			break;
> +
> +		/* double check this block wasn't used in the old transaction */
> +		if (*b >= old_ll->nr_blocks)
> +			count = 0;
> +
> +		else {
> +			r = sm_ll_lookup(old_ll, *b, &count);
> +			if (r)
> +				break;
> +
> +			if (count)
> +				begin = *b + 1;
> +		}
> +	} while (count);
> +
> +	return r;
> +}
> +
>  static int sm_ll_mutate(struct ll_disk *ll, dm_block_t b,
>  			int (*mutator)(void *context, uint32_t old, uint32_t *new),
>  			void *context, enum allocation_event *ev)
> diff --git a/drivers/md/persistent-data/dm-space-map-common.h b/drivers/md/persistent-data/dm-space-map-common.h
> index b3078d5eda0c..8de63ce39bdd 100644
> --- a/drivers/md/persistent-data/dm-space-map-common.h
> +++ b/drivers/md/persistent-data/dm-space-map-common.h
> @@ -109,6 +109,8 @@ int sm_ll_lookup_bitmap(struct ll_disk *ll, dm_block_t b, uint32_t *result);
>  int sm_ll_lookup(struct ll_disk *ll, dm_block_t b, uint32_t *result);
>  int sm_ll_find_free_block(struct ll_disk *ll, dm_block_t begin,
>  			  dm_block_t end, dm_block_t *result);
> +int sm_ll_find_common_free_block(struct ll_disk *old_ll, struct ll_disk *new_ll,
> +	                         dm_block_t begin, dm_block_t end, dm_block_t *result);
>  int sm_ll_insert(struct ll_disk *ll, dm_block_t b, uint32_t ref_count, enum allocation_event *ev);
>  int sm_ll_inc(struct ll_disk *ll, dm_block_t b, enum allocation_event *ev);
>  int sm_ll_dec(struct ll_disk *ll, dm_block_t b, enum allocation_event *ev);
> diff --git a/drivers/md/persistent-data/dm-space-map-disk.c b/drivers/md/persistent-data/dm-space-map-disk.c
> index 32adf6b4a9c7..bf4c5e2ccb6f 100644
> --- a/drivers/md/persistent-data/dm-space-map-disk.c
> +++ b/drivers/md/persistent-data/dm-space-map-disk.c
> @@ -167,8 +167,10 @@ static int sm_disk_new_block(struct dm_space_map *sm, dm_block_t *b)
>  	enum allocation_event ev;
>  	struct sm_disk *smd = container_of(sm, struct sm_disk, sm);
>  
> -	/* FIXME: we should loop round a couple of times */
> -	r = sm_ll_find_free_block(&smd->old_ll, smd->begin, smd->old_ll.nr_blocks, b);
> +	/*
> +	 * Any block we allocate has to be free in both the old and current ll.
> +	 */
> +	r = sm_ll_find_common_free_block(&smd->old_ll, &smd->ll, smd->begin, smd->ll.nr_blocks, b);
>  	if (r)
>  		return r;
>  
> diff --git a/drivers/md/persistent-data/dm-space-map-metadata.c b/drivers/md/persistent-data/dm-space-map-metadata.c
> index 25328582cc48..9e3c64ec2026 100644
> --- a/drivers/md/persistent-data/dm-space-map-metadata.c
> +++ b/drivers/md/persistent-data/dm-space-map-metadata.c
> @@ -448,7 +448,10 @@ static int sm_metadata_new_block_(struct dm_space_map *sm, dm_block_t *b)
>  	enum allocation_event ev;
>  	struct sm_metadata *smm = container_of(sm, struct sm_metadata, sm);
>  
> -	r = sm_ll_find_free_block(&smm->old_ll, smm->begin, smm->old_ll.nr_blocks, b);
> +	/*
> +	 * Any block we allocate has to be free in both the old and current ll.
> +	 */
> +	r = sm_ll_find_common_free_block(&smm->old_ll, &smm->ll, smm->begin, smm->ll.nr_blocks, b);
>  	if (r)
>  		return r;
>  
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel
> 
> 
