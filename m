Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA05C54EED
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 21:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbjAXVLZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 16:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbjAXVLY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 16:11:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE054615F
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 13:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674594639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+S5IUZHTVF9Pd6bZbdf7wMuVKpNUwM0nLhEcSQAjNaE=;
        b=gcWOV2ki0yOEcU9hfSEzUXXNGkCEqbAC+g6KC9+lrcwzVrSPQ74mytHOei+RzrvJVnul8s
        JJx8CP5xOS7Znv4pSj57dLAd4A2DbmaZYKhlo+T2P+8xJ8iX+BnNWfNPWIEL6q8rPkY2iX
        MuiloTf3VFybLdNFPJgSYCu/cagZSdg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-PXodvBPsPsCCtt8GzvXR7Q-1; Tue, 24 Jan 2023 16:10:34 -0500
X-MC-Unique: PXodvBPsPsCCtt8GzvXR7Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCB132802E24;
        Tue, 24 Jan 2023 21:10:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBAAE2166B26;
        Tue, 24 Jan 2023 21:10:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <4be974aa-2beb-9ae5-3f48-7dde6241b0c7@nvidia.com>
References: <4be974aa-2beb-9ae5-3f48-7dde6241b0c7@nvidia.com> <20230124170108.1070389-1-dhowells@redhat.com> <20230124170108.1070389-3-dhowells@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, "Jan Kara" <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Christoph Hellwig" <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: [PATCH v9 2/8] iov_iter: Add a function to extract a page list from an iterator
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1353066.1674594631.1@warthog.procyon.org.uk>
Date:   Tue, 24 Jan 2023 21:10:31 +0000
Message-ID: <1353067.1674594631@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

John Hubbard <jhubbard@nvidia.com> wrote:

> > +	for (;;) {
> > +		if (i->nr_segs == 0)
> > +			return 0;
> > +		maxsize = min(maxsize, i->bvec->bv_len - skip);
> > +		if (maxsize)
> > +			break;
> > +		i->iov_offset = 0;
> > +		i->nr_segs--;
> > +		i->kvec++;
> > +		skip = 0;
> > +	}
> > +
> > +	skip += i->bvec->bv_offset;
> > +	page = i->bvec->bv_page + skip / PAGE_SIZE;
> > +	offset = skip % PAGE_SIZE;
> > +	*offset0 = offset;
> > +
> > +	maxpages = want_pages_array(pages, maxsize, offset, maxpages);
> > +	if (!maxpages)
> > +		return -ENOMEM;
> 
> Is it OK that the iov_iter position has been advanced, and left that way,
> in the case of an early -ENOMEM return here?

I think it should be okay.  The for-loop at the top just skips over empty
segments, so it doesn't really advance things.  There is an error there,
though: it should be i->bvec++, not i->kvec++ in the loop.

David

