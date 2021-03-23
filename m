Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0970AC433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 11:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE1E3619C0
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 11:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhCWL3t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 07:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229728AbhCWL3l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 07:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616498980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OcLqJ54i9XylFCC6CIDnOKsaauV5bJuF0aAmd3uf7lw=;
        b=F2hD0X0t1a17DJozsufvibJy/Eo18TKx3frhAd0IzvOKvkkfEMhcFE2X9xERjED7Zt9Juk
        NI8WrWnSOSOkQkbtEp4fIVALSBgRznh5Wb3UtB4ce+YUOw0LIzNmbzY5COwj6bNLwcHrXC
        RvY3Fm0Y8+2p6sCc4x8vV/G2wWE3PLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-LNksVTdXOBe-rwNCkTxneg-1; Tue, 23 Mar 2021 07:29:36 -0400
X-MC-Unique: LNksVTdXOBe-rwNCkTxneg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74A0F1083E82;
        Tue, 23 Mar 2021 11:29:35 +0000 (UTC)
Received: from T590 (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19B9A5FCBE;
        Tue, 23 Mar 2021 11:29:23 +0000 (UTC)
Date:   Tue, 23 Mar 2021 19:29:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com
Subject: Re: [RFC PATCH V2 06/13] block: add new field into 'struct bvec_iter'
Message-ID: <YFnRDm5XZaQAO83Q@T590>
References: <20210318164827.1481133-1-ming.lei@redhat.com>
 <20210318164827.1481133-7-ming.lei@redhat.com>
 <20210319174422.GD9938@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319174422.GD9938@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 19, 2021 at 01:44:22PM -0400, Mike Snitzer wrote:
> On Thu, Mar 18 2021 at 12:48pm -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > There is a hole at the end of 'struct bvec_iter', so put a new field
> > here and we can save cookie returned from submit_bio() here for
> > supporting bio based polling.
> > 
> > This way can avoid to extend bio unnecessarily.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  include/linux/bvec.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> > index ff832e698efb..61c0f55f7165 100644
> > --- a/include/linux/bvec.h
> > +++ b/include/linux/bvec.h
> > @@ -43,6 +43,15 @@ struct bvec_iter {
> >  
> >  	unsigned int            bi_bvec_done;	/* number of bytes completed in
> >  						   current bvec */
> > +
> > +	/*
> > +	 * There is a hole at the end of bvec_iter, define one filed to
> 
> s/filed/field/
> 
> > +	 * hold something which isn't relate with 'bvec_iter', so that we can
> 
> s/relate/related/
> or
> s/isn't relate with/doesn't relate to/
> 
> > +	 * avoid to extend bio. So far this new field is used for bio based
> 
> s/to extend/extending/
> 
> > +	 * pooling, we will store returning value of underlying queue's
> 
> s/pooling/polling/
> 

Good catch, will fix all in V3.

-- 
Ming

