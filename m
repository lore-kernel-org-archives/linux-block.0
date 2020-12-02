Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37881C64E8A
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 01:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2DA520709
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 01:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgLBBsd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 20:48:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50438 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbgLBBsc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Dec 2020 20:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606873625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IP0Aieu6kqIL09lNyhRGJvXhQboPOH1LjqLNy6tHc/4=;
        b=VdSWeiC/1Qr1imLQQNqGyPTEkmXz8t0QCwSLYpR9Gs7bxrmooULQ3T6qjNbRdccO6E4GQV
        S0RcjPx/sewH1fDXOqVFNp9F3CavpSDsOFI9sMBH0uneWrMJPHlq1yAbbvqyr+ZGVDEBzR
        lt/9QnnPJe8+Q0cgggI1iAoXNJ5kNlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-rQSFvIS5MTiOe8Y9zO26xA-1; Tue, 01 Dec 2020 20:47:04 -0500
X-MC-Unique: rQSFvIS5MTiOe8Y9zO26xA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 140BA5F9E7;
        Wed,  2 Dec 2020 01:47:02 +0000 (UTC)
Received: from T590 (ovpn-13-72.pek2.redhat.com [10.72.13.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CFDC85D9DD;
        Wed,  2 Dec 2020 01:46:54 +0000 (UTC)
Date:   Wed, 2 Dec 2020 09:46:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
Message-ID: <20201202014650.GA494805@T590>
References: <20201201120652.487077-1-ming.lei@redhat.com>
 <20201201125251.GA11935@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201125251.GA11935@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 01, 2020 at 12:52:51PM +0000, Matthew Wilcox wrote:
> On Tue, Dec 01, 2020 at 08:06:52PM +0800, Ming Lei wrote:
> > Pavel reported that iov_iter_npages is a bit heavy in case of bvec
> > iter.
> > 
> > Turns out it isn't necessary to iterate every page in the bvec iter,
> > and we call iov_iter_npages() just for figuring out how many bio
> > vecs need to be allocated. And we can simply map each vector in bvec iter
> > to bio's vec, so just return iter->nr_segs from bio_iov_iter_nvecs() for
> > bvec iter.
> > 
> > Also rename local variable 'nr_pages' as 'nr_vecs' which exactly matches its
> > real usage.
> > 
> > This patch is based on Mathew's post:
> > 
> > https://lore.kernel.org/linux-block/20201120123931.GN29991@casper.infradead.org/
> 
> But the only reason we want to know 'nr_vecs' is so we can allocate a
> BIO which has that many vecs, right?  But we then don't actually use the
> vecs in the bio because we use the ones already present in the iter.
> That was why I had it return 1, not nr_vecs.
> 
> Did I miss something?

Please see bio_iov_iter_get_pages():

  do {
  		...
      	if (is_bvec)
        	ret = __bio_iov_bvec_add_pages(bio, iter);
		...
   } while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));


So all bvecs in bvec iter will be added to the bio, and it isn't
correct or efficient to just return 1.

thanks,
Ming

