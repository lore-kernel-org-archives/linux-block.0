Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAF6C433E6
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 16:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120E564F7C
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 16:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhBCQZP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 11:25:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233321AbhBCQZN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Feb 2021 11:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612369426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AmmDkyKTVx/FUwFo6G18NorDTDDlJKLWJ24FzcBD1wY=;
        b=dbcipVYLGofr8sHzz2fTlS05GSyxU0q+qSy7j5WACE/ptyTpHJIDlWPNPdrGfktuvrmaHV
        7qEOBsm5EhAl0yrW2zB7AriQMX7nljF9/TdgIMW2hZ8n+Uq5SMPegY1hovr5birF7ptBYw
        1BkokyUl3G7Hm5ygkhQIeF+5PEVnIO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-iNX2vabpMRiEbl_sXY9_3Q-1; Wed, 03 Feb 2021 11:23:45 -0500
X-MC-Unique: iNX2vabpMRiEbl_sXY9_3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57F9180364C;
        Wed,  3 Feb 2021 16:23:43 +0000 (UTC)
Received: from redhat (ovpn-118-158.rdu2.redhat.com [10.10.118.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB18B5D6A8;
        Wed,  3 Feb 2021 16:23:39 +0000 (UTC)
Date:   Wed, 3 Feb 2021 11:23:37 -0500
From:   David Jeffery <djeffery@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org,
        Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH] block: recalculate segment count for multi-segment
 discard requests correctly
Message-ID: <20210203162337.GA40163@redhat>
References: <20210201164850.391332-1-djeffery@redhat.com>
 <20210202033343.GA165584@T590>
 <20210202204355.GA31803@redhat>
 <20210203023517.GA948998@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203023517.GA948998@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 03, 2021 at 10:35:17AM +0800, Ming Lei wrote:
> 
> On Tue, Feb 02, 2021 at 03:43:55PM -0500, David Jeffery wrote:
> > The return 0 does seem to be an old relic that does not make sense anymore.
> > Moving REQ_OP_SECURE_ERASE to be with discard and removing the old return 0,
> > is this what you had in mind?
> > 
> >  
> > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > index 808768f6b174..68458aa01b05 100644
> > --- a/block/blk-merge.c
> > +++ b/block/blk-merge.c
> > @@ -383,8 +383,14 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
> >  	switch (bio_op(rq->bio)) {
> >  	case REQ_OP_DISCARD:
> >  	case REQ_OP_SECURE_ERASE:
> > +		if (queue_max_discard_segments(rq->q) > 1) {
> > +			struct bio *bio = rq->bio;
> > +			for_each_bio(bio)
> > +				nr_phys_segs++;
> > +			return nr_phys_segs;
> > +		}
> > +		/* fall through */
> >  	case REQ_OP_WRITE_ZEROES:
> > -		return 0;
> >  	case REQ_OP_WRITE_SAME:
> >  		return 1;
> 
> WRITE_SAME uses same buffer, so the nr_segment is still one; WRITE_ZERO
> doesn't need extra payload, so nr_segments is zero, see
> blk_bio_write_zeroes_split(), blk_bio_write_same_split, attempt_merge()
> and blk_rq_merge_ok().
> 

I thought you mentioned virtio-blk because of how some drivers handle
zeroing and discarding similarly and wanted to align the segment count with
discard behavior for WRITE_ZEROES too. (Though that would also need an update
to blk_bio_write_zeroes_split as you pointed out.)  So you want me to leave
WRITE_ZEROES behavior alone and let blk_rq_nr_discard_segments() keep doing
the hiding of a 0 rq->nr_phys_segments as 1 segment in the WRITE_ZEROES treated
as a discard case?

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 808768f6b174..756473295f19 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -383,6 +383,14 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
 	switch (bio_op(rq->bio)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
+		if (queue_max_discard_segments(rq->q) > 1) {
+			struct bio *bio = rq->bio;
+
+			for_each_bio(bio)
+				nr_phys_segs++;
+			return nr_phys_segs;
+		}
+		return 1;
 	case REQ_OP_WRITE_ZEROES:
 		return 0;
 	case REQ_OP_WRITE_SAME:

--
David Jeffery

