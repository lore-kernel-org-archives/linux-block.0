Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B91C433FE
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 03:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A7B22D07
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 03:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgLGDOJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Dec 2020 22:14:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22548 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726817AbgLGDOJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 6 Dec 2020 22:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607310762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2tkH1uhUGazgifJwaEB5CdOboILn7Q5P0IVy0Vk4Q0g=;
        b=LKjcr/J6dmBJCNwNqUdDU5+Z7NxA35qkePdW2/QDEppzJ4P6Om0LV3YR2MnTOrgJRZ3LRx
        zB1R2nvWTOzQrym4JBAs01sYZGMs8NgjzuJoKI8+xmL9fsFhwIU/nqePlhxNtvD4rNRz2L
        MUZAMjdKTuwgRLV2bSkZ068R2S9rUoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-P2p0BF6jNRuVeIakzA8tKw-1; Sun, 06 Dec 2020 22:12:39 -0500
X-MC-Unique: P2p0BF6jNRuVeIakzA8tKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84B78180E460;
        Mon,  7 Dec 2020 03:12:37 +0000 (UTC)
Received: from T590 (ovpn-12-193.pek2.redhat.com [10.72.12.193])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EDEF60CED;
        Mon,  7 Dec 2020 03:12:30 +0000 (UTC)
Date:   Mon, 7 Dec 2020 11:12:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tom Yan <tom.ty89@gmail.com>
Cc:     linux-block@vger.kernel.org, hch@lst.de, ming.l@ssi.samsung.com,
        sagig@grimberg.me, axboe@fb.com, tom.leiming@gmail.com
Subject: Re: [PATCH] block: fix bio chaining in blk_next_bio()
Message-ID: <20201207031226.GD985419@T590>
References: <20201206051802.1890-1-tom.ty89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206051802.1890-1-tom.ty89@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 06, 2020 at 01:18:02PM +0800, Tom Yan wrote:
> While it seems to have worked for so long, it doesn't seem right
> that we set the new bio as the parent. bio_chain() seems to be used
> in the other way everywhere else anyway.
> 
> Signed-off-by: Tom Yan <tom.ty89@gmail.com>
> ---
>  block/blk-lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index e90614fd8d6a..918deaf5c8a4 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -15,7 +15,7 @@ struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp)
>  	struct bio *new = bio_alloc(gfp, nr_pages);
>  
>  	if (bio) {
> -		bio_chain(bio, new);
> +		bio_chain(new, bio);
>  		submit_bio(bio);
>  	}

This patch isn't needed. We simply wait for completion of the last issued bio, which
.bi_end_io(submit_bio_wait_endio) is only called after all previous bios are done.

And the last bio is the ancestor of the whole chained bios, which are
submitted in the following way(order):

	bio 0 ---> bio 1 ---> ... -> bio N(the last bio)


thanks,
Ming

