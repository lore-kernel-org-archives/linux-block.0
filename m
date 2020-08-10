Return-Path: <SRS0=DoUd=BU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F5EC433E1
	for <linux-block@archiver.kernel.org>; Mon, 10 Aug 2020 04:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0409020756
	for <linux-block@archiver.kernel.org>; Mon, 10 Aug 2020 04:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3UuBWti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgHJEDL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Aug 2020 00:03:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37156 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725536AbgHJEDK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Aug 2020 00:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597032188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p25URfzxNUZWXR7vBUcLK7+cxQ6MStZ/38NJ/Lqbl0g=;
        b=Z3UuBWti94EJvz1dPxyuQl6FWKUZATcpgvJnZIL3j5ZLFuZ2tbjZyxV+kbRRWYPgiLYR6B
        E4xlJcTADBh2wZZ4TGE/jBuMkD3g98pPXuMuG+iqi3+p2knxT3vIdzBeIRsBr/aVmDlkeP
        sIois6cMAIGVPJlhCUkMF6CaY4X3Rbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-maUD5SuaPryzZVoU7rX1dw-1; Mon, 10 Aug 2020 00:03:06 -0400
X-MC-Unique: maUD5SuaPryzZVoU7rX1dw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 409671932480;
        Mon, 10 Aug 2020 04:03:04 +0000 (UTC)
Received: from T590 (ovpn-13-99.pek2.redhat.com [10.72.13.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 425DF10013D5;
        Mon, 10 Aug 2020 04:02:56 +0000 (UTC)
Date:   Mon, 10 Aug 2020 12:02:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org
Subject: Re: [PATCH] block: allow for_each_bvec to support zero len bvec
Message-ID: <20200810040252.GC2202641@T590>
References: <20200810031915.2209658-1-ming.lei@redhat.com>
 <20200810033309.GK17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810033309.GK17456@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 10, 2020 at 04:33:09AM +0100, Matthew Wilcox wrote:
> On Mon, Aug 10, 2020 at 11:19:15AM +0800, Ming Lei wrote:
> > +++ b/include/linux/bvec.h
> > @@ -117,11 +117,18 @@ static inline bool bvec_iter_advance(const struct bio_vec *bv,
> >  	return true;
> >  }
> >  
> > +static inline void bvec_iter_skip_zero_bvec(struct bvec_iter *iter)
> > +{
> > +	iter->bi_bvec_done = 0;
> > +	iter->bi_idx++;
> > +}
> > +
> >  #define for_each_bvec(bvl, bio_vec, iter, start)			\
> >  	for (iter = (start);						\
> >  	     (iter).bi_size &&						\
> >  		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
> > -	     bvec_iter_advance((bio_vec), &(iter), (bvl).bv_len))
> > +	     (bvl).bv_len ? bvec_iter_advance((bio_vec), &(iter),	\
> > +		     (bvl).bv_len) : bvec_iter_skip_zero_bvec(&(iter)))
> >  
> 
> What if you have two zero-length bvecs in a row?  Won't this just skip
> the first one?

The 2nd one will be skipped too when it is observed in next loop.

> 
> It would seem better to me to put the bv_len test in bvec_iter_advance()
> instead of making the macro more complicated.

The reason is that block layer won't support zero length bvec, and I'd
not bother bvec_iter_advance() for adding this check.


Thanks,
Ming

