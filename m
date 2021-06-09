Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B637C47095
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 06:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A40261278
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 06:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhFIGOm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 02:14:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42633 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230353AbhFIGOm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Jun 2021 02:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623219167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wsM4h3EkGEQmgmsNgnC2R5LoMvPDTkfK4KK+tHDX7DY=;
        b=jREiR5MLg6e/khI1QMCftYjm+3h0ZTQO955e3RoFDWMGtOq9g61PdAigRefYqjxtaErRR3
        bLEu7qH9I//M36mQ/mstE6gqEEoTfbnNanb7ml9JO9qsowFjQ0Pxq5uwmLEOiS9TxH9up+
        muKX80lJ4bNfllUsuw4D9RiDALb2YGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-n1pWRk-7On6jWsatSSV6uw-1; Wed, 09 Jun 2021 02:12:44 -0400
X-MC-Unique: n1pWRk-7On6jWsatSSV6uw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69B3E801106;
        Wed,  9 Jun 2021 06:12:43 +0000 (UTC)
Received: from T590 (ovpn-12-143.pek2.redhat.com [10.72.12.143])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F64260C04;
        Wed,  9 Jun 2021 06:12:36 +0000 (UTC)
Date:   Wed, 9 Jun 2021 14:12:32 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Wang Shanker <shankerwangmiao@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: support bio merge for multi-range discard
Message-ID: <YMBb0E01P/nXq8fJ@T590>
References: <20210609004556.46928-1-ming.lei@redhat.com>
 <20210609004556.46928-3-ming.lei@redhat.com>
 <AAAB68D1-3F92-4F88-B192-2A202F7CE53D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AAAB68D1-3F92-4F88-B192-2A202F7CE53D@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 09, 2021 at 11:05:59AM +0800, Wang Shanker wrote:
> 
> 
> > 2021年06月09日 08:45，Ming Lei <ming.lei@redhat.com> 写道：
> > 
> > So far multi-range discard treats each bio as one segment(range) of single
> > discard request. This way becomes not efficient if lots of small sized
> > discard bios are submitted, and one example is raid456.
> > 
> > Support bio merge for multi-range discard for improving lots of small
> > sized discard bios.
> > 
> > Turns out it is easy to support it:
> > 
> > 1) always try to merge bio first
> > 
> > 2) run into multi-range discard only if bio merge can't be done
> > 
> > 3) add rq_for_each_discard_range() for retrieving each range(segment)
> > of discard request
> > 
> > Reported-by: Wang Shanker <shankerwangmiao@gmail.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> > block/blk-merge.c          | 12 ++++-----
> > drivers/block/virtio_blk.c |  9 ++++---
> > drivers/nvme/host/core.c   |  8 +++---
> > include/linux/blkdev.h     | 51 ++++++++++++++++++++++++++++++++++++++
> > 4 files changed, 66 insertions(+), 14 deletions(-)
> > 
> > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > index bcdff1879c34..65210e9a8efa 100644
> > --- a/block/blk-merge.c
> > +++ b/block/blk-merge.c
> > @@ -724,10 +724,10 @@ static inline bool blk_discard_mergable(struct request *req)
> > static enum elv_merge blk_try_req_merge(struct request *req,
> > 					struct request *next)
> > {
> > -	if (blk_discard_mergable(req))
> > -		return ELEVATOR_DISCARD_MERGE;
> > -	else if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next))
> > +	if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next))
> > 		return ELEVATOR_BACK_MERGE;
> > +	else if (blk_discard_mergable(req))
> 
> Shall we adjust how req->nr_phys_segments is calculated in 
> bio_attempt_discard_merge() so that multiple contiguous bio's can
> be seen as one segment?

I think it isn't necessary, because we try to merge discard IOs first
just like plain IO. So when bio_attempt_discard_merge() is reached, it
means that IOs can't be merged, so req->nr_phys_segments should be
increased by 1.


Thanks,
Ming

