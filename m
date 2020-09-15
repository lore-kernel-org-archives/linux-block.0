Return-Path: <SRS0=t3nT=CY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1268C433E2
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 02:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D5D6208E4
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 02:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUyaxCPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgIOCEF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 22:04:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57948 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726019AbgIOCEE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 22:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600135443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fYUJ6d6K7+Gyu6GlffuHiz0GaTO1luxq6mjfS2130II=;
        b=OUyaxCPoyIs8JFHzzHKUh+yHUyVSvrrTXuyIIKgYoS5JzA3+3DE/R8SKzUww+hiVlWrG8U
        r0vhL/NZBgPNo3c1hf1pwNagtGYMDwfaGkjmlPpn9sKwgpHN290oH4bHUOE3AOEeRF1n6D
        SGRZhLKidEFPTbt8wMVRtOfws+wCFJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-04j_yamGOliXBMNHw2pd-g-1; Mon, 14 Sep 2020 22:04:01 -0400
X-MC-Unique: 04j_yamGOliXBMNHw2pd-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9E6B801A9E;
        Tue, 15 Sep 2020 02:03:59 +0000 (UTC)
Received: from T590 (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 71CA27EEA7;
        Tue, 15 Sep 2020 02:03:48 +0000 (UTC)
Date:   Tue, 15 Sep 2020 10:03:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/3] block: fix blk_rq_get_max_sectors() to flow more
 carefully
Message-ID: <20200915020344.GB738570@T590>
References: <20200911215338.44805-1-snitzer@redhat.com>
 <20200911215338.44805-2-snitzer@redhat.com>
 <20200912135252.GA210077@T590>
 <CY4PR04MB3751DAB758BAF8EB8A792FD2E7230@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751DAB758BAF8EB8A792FD2E7230@CY4PR04MB3751.namprd04.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 14, 2020 at 12:43:06AM +0000, Damien Le Moal wrote:
> On 2020/09/12 22:53, Ming Lei wrote:
> > On Fri, Sep 11, 2020 at 05:53:36PM -0400, Mike Snitzer wrote:
> >> blk_queue_get_max_sectors() has been trained for REQ_OP_WRITE_SAME and
> >> REQ_OP_WRITE_ZEROES yet blk_rq_get_max_sectors() didn't call it for
> >> those operations.
> > 
> > Actually WRITE_SAME & WRITE_ZEROS are handled by the following if
> > chunk_sectors is set:
> > 
> >         return min(blk_max_size_offset(q, offset),
> >                         blk_queue_get_max_sectors(q, req_op(rq)));
> >  
> >> Also, there is no need to avoid blk_max_size_offset() if
> >> 'chunk_sectors' isn't set because it falls back to 'max_sectors'.
> >>
> >> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> >> ---
> >>  include/linux/blkdev.h | 19 +++++++++++++------
> >>  1 file changed, 13 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> >> index bb5636cc17b9..453a3d735d66 100644
> >> --- a/include/linux/blkdev.h
> >> +++ b/include/linux/blkdev.h
> >> @@ -1070,17 +1070,24 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
> >>  						  sector_t offset)
> >>  {
> >>  	struct request_queue *q = rq->q;
> >> +	int op;
> >> +	unsigned int max_sectors;
> >>  
> >>  	if (blk_rq_is_passthrough(rq))
> >>  		return q->limits.max_hw_sectors;
> >>  
> >> -	if (!q->limits.chunk_sectors ||
> >> -	    req_op(rq) == REQ_OP_DISCARD ||
> >> -	    req_op(rq) == REQ_OP_SECURE_ERASE)
> >> -		return blk_queue_get_max_sectors(q, req_op(rq));
> >> +	op = req_op(rq);
> >> +	max_sectors = blk_queue_get_max_sectors(q, op);
> >>  
> >> -	return min(blk_max_size_offset(q, offset),
> >> -			blk_queue_get_max_sectors(q, req_op(rq)));
> >> +	switch (op) {
> >> +	case REQ_OP_DISCARD:
> >> +	case REQ_OP_SECURE_ERASE:
> >> +	case REQ_OP_WRITE_SAME:
> >> +	case REQ_OP_WRITE_ZEROES:
> >> +		return max_sectors;
> >> +	}>> +
> >> +	return min(blk_max_size_offset(q, offset), max_sectors);
> >>  }
> > 
> > It depends if offset & chunk_sectors limit for WRITE_SAME & WRITE_ZEROS
> > needs to be considered.
> 
> That limit is needed for zoned block devices to ensure that *any* write request,
> no matter the command, do not cross zone boundaries. Otherwise, the write would
> be immediately failed by the device.

Looks both blk_bio_write_zeroes_split() and blk_bio_write_same_split()
don't consider chunk_sectors limit, is that an issue for zone block?


thanks,
Ming

