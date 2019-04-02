Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69652C43381
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 02:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC3A20833
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 02:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfDBCKu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:10:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfDBCKu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Apr 2019 22:10:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FDEC307B95F;
        Tue,  2 Apr 2019 02:10:50 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C82C16B8E4;
        Tue,  2 Apr 2019 02:10:45 +0000 (UTC)
Date:   Tue, 2 Apr 2019 10:10:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix build warning in __blk_bios_map_sg()
Message-ID: <20190402021039.GA26316@ming.t460p>
References: <20190402014638.25633-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190402014638.25633-1-ming.lei@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 02 Apr 2019 02:10:50 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 02, 2019 at 09:46:38AM +0800, Ming Lei wrote:
> Commit f6970f83ef79 ("block: don't check if adjacent bvecs in one bio can
> be mergeable") changes bvec merge by only considering two bvecs from
> different bios. However, if the former bio doesn't inlcude any io bvec,
> then the following warning may be triggered:
> 
>  warning: ‘bvec.bv_offset’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> In practice, it shouldn't be triggered.
> 
> Fixes it by adding check on former bio, the check shouldn't add any cost
> given 'bio->bi_iter' can be hit in cache.
> 
> Reported-by: Jens Axboe <axboe@kernel.dk>
> Fixes: f6970f83ef79 ("block: don't check if adjacent bvecs in one bio can be mergeable")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-merge.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 8f96d683b577..1fc66d03893f 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -527,7 +527,7 @@ static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
>  			     struct scatterlist *sglist,
>  			     struct scatterlist **sg)
>  {
> -	struct bio_vec bvec, bvprv = { NULL };
> +	struct bio_vec uninitialized_var(bvec), bvprv = { NULL };
>  	struct bvec_iter iter;
>  	int nsegs = 0;
>  	bool new_bio = false;
> @@ -550,8 +550,10 @@ static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
>   next_bvec:
>  			new_bio = false;
>  		}
> -		bvprv = bvec;
> -		new_bio = true;
> +		if (likely(bio->bi_iter.bi_size)) {
> +			bvprv = bvec;
> +			new_bio = true;
> +		}
>  	}

Looks __blk_recalc_rq_segments() needs the similar fix too, so please
ignore this one, and I will handle them all in one patch.

Thanks,
Ming
