Return-Path: <SRS0=XolY=P5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9E7C282DB
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 08:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7A82085A
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 08:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfAUIO2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:14:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbfAUIO2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 03:14:28 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D7BEEB9A3;
        Mon, 21 Jan 2019 03:25:57 +0000 (UTC)
Received: from ming.t460p (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA89019C7D;
        Mon, 21 Jan 2019 03:25:47 +0000 (UTC)
Date:   Mon, 21 Jan 2019 11:25:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, NeilBrown <neilb@suse.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/4] dm: fix clone_bio() to trigger blk_recount_segments()
Message-ID: <20190121032542.GB24610@ming.t460p>
References: <20190119180506.1300-1-snitzer@redhat.com>
 <20190119180506.1300-2-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119180506.1300-2-snitzer@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 21 Jan 2019 03:25:57 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jan 19, 2019 at 01:05:03PM -0500, Mike Snitzer wrote:
> DM's clone_bio() now benefits from using bio_trim() by fixing the fact
> that clone_bio() wasn't clearing BIO_SEG_VALID like bio_trim() does;
> which triggers blk_recount_segments() via bio_phys_segments().
> 
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> ---
>  drivers/md/dm.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index d67c95ef8d7e..fcb97b0a5743 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1320,7 +1320,7 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
>  
>  	__bio_clone_fast(clone, bio);
>  
> -	if (unlikely(bio_integrity(bio) != NULL)) {
> +	if (bio_integrity(bio)) {
>  		int r;
>  
>  		if (unlikely(!dm_target_has_integrity(tio->ti->type) &&
> @@ -1336,11 +1336,7 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
>  			return r;
>  	}
>  
> -	bio_advance(clone, to_bytes(sector - clone->bi_iter.bi_sector));
> -	clone->bi_iter.bi_size = to_bytes(len);
> -
> -	if (unlikely(bio_integrity(bio) != NULL))
> -		bio_integrity_trim(clone);
> +	bio_trim(clone, sector - clone->bi_iter.bi_sector, len);
>  
>  	return 0;
>  }
> -- 
> 2.15.0
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
