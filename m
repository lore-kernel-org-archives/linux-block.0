Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AF7C678DC
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 21:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbjAIVkd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 16:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238225AbjAIVj7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 16:39:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484DCE0B1
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 13:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673300263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a63DA35gJAAxc0zkeF1e3iqtqNPsmNmAAW3yG6Igeec=;
        b=X0w0YKHvcroFIRmb7fV1oy5ITn/4bx4dxqNrTG7Wr9eCM4mauTBxBIpzPJy1Adio5Vne5M
        zcy4y6Y6kpYeQ8ZoeqWRGGBeNPtopridtMLOHsHZm/RjuQYRa11SPfI1si5ST/6ajLmlAC
        qec2GE1rdIDj4v0tVuNzMgH7ZaRtrsc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-FYzDasRJMNu5P2dWnJSLYw-1; Mon, 09 Jan 2023 16:37:38 -0500
X-MC-Unique: FYzDasRJMNu5P2dWnJSLYw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CDAC29AA3B4;
        Mon,  9 Jan 2023 21:37:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BEEF40C2064;
        Mon,  9 Jan 2023 21:37:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230109173513.htfqbkrtqm52pnye@quack3>
References: <20230109173513.htfqbkrtqm52pnye@quack3> <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk> <167305166150.1521586.10220949115402059720.stgit@warthog.procyon.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] iov_iter, block: Make bio structs pin pages rather than ref'ing if appropriate
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2008443.1673300255.1@warthog.procyon.org.uk>
Date:   Mon, 09 Jan 2023 21:37:35 +0000
Message-ID: <2008444.1673300255@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jan Kara <jack@suse.cz> wrote:

> So currently we already have BIO_NO_PAGE_REF flag and what you do in this
> patch partially duplicates that. So either I'd drop that flag or instead of
> bi_cleanup_mode variable (which honestly looks a bit wasteful given how we
> microoptimize struct bio) just add another BIO_ flag...

I'm fine with translating the FOLL_* flags to the BIO_* flags.  I could add a
BIO_PAGE_PINNED and translate:

	FOLL_GET => 0
	FOLL_PIN => BIO_PAGE_PINNED
	0	 => BIO_NO_PAGE_REF

It would seem that BIO_NO_PAGE_REF can't be set for BIO_PAGE_PINNED because
BIO_NO_PAGE_REF governs whether bio_release_pages() calls
__bio_release_pages() - which would be necessary.  However, bio_release_page()
can do one or the other on the basis of BIO_PAGE_PINNED being specified.  So
in my patch I would end up with:

	static void bio_release_page(struct bio *bio, struct page *page)
	{
		if (bio->bi_flags & BIO_NO_PAGE_REF)
			;
		else if (bio->bi_flags & BIO_PAGE_PINNED)
			unpin_user_page(page);
		else
			put_page(page);
	}

(This is called from four places, so it has to handle BIO_NO_PAGE_REF).

It might make sense flip the logic of BIO_NO_PAGE_REF so that we have, say:

	FOLL_GET => BIO_PAGE_REFFED
	FOLL_PIN => BIO_PAGE_PINNED
	0	 => 0

Set BIO_PAGE_REFFED by default and clear it in bio_iov_bvec_set().

Note that one reason I was thinking of saving the returned FOLL_* flags is
that I don't know if, at some point, the VM will acquire yet more different
cleanup modes - or even if a page could at some point be both ref'd *and*
pinned.

Also, I could change the interface to return something other than FOLL_* - it
just seems that they're appropriate given the underlying VM interface.

David

