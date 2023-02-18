Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15830C64EC4
	for <linux-block@archiver.kernel.org>; Sat, 18 Feb 2023 09:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjBRJ0F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Feb 2023 04:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjBRJ0E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Feb 2023 04:26:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416EF211DB
        for <linux-block@vger.kernel.org>; Sat, 18 Feb 2023 01:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676712322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pdGdALM3vDuQShb1BnFFi6PogQZvGQG8yp/KLX/QzU0=;
        b=c74eO1tF1gvrL8GOArKVk4rUfgUqa9TaEOkAok/j6wBfW5/sgZqzAG2PyiaEt3F9fvlgck
        wFxqD18J+W+Kmi6gHXiFSucESqnROvihg9X13qSEgVz7xSpzfGGA1U+KIZ52M4vNfFG45N
        eKcV8WDOUuefBI27ZxXn0h/9xvaaEFQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-Ju0ujkZFOMmZjdPqfTMn8g-1; Sat, 18 Feb 2023 04:25:17 -0500
X-MC-Unique: Ju0ujkZFOMmZjdPqfTMn8g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69C491C05B0F;
        Sat, 18 Feb 2023 09:25:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22046492B11;
        Sat, 18 Feb 2023 09:25:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y/A67a6LovSYHhHz@T590>
References: <Y/A67a6LovSYHhHz@T590> <20230214171330.2722188-1-dhowells@redhat.com> <20230214171330.2722188-3-dhowells@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v14 02/17] splice: Add a func to do a splice from a buffered file without ITER_PIPE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1085803.1676712307.1@warthog.procyon.org.uk>
Date:   Sat, 18 Feb 2023 09:25:07 +0000
Message-ID: <1085804.1676712307@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ming Lei <ming.lei@redhat.com> wrote:

> > +	/* Work out how much data we can actually add into the pipe */
> > +	used = pipe_occupancy(pipe->head, pipe->tail);
> > +	npages = max_t(ssize_t, pipe->max_usage - used, 0);
> > +	len = min_t(size_t, len, npages * PAGE_SIZE);
> 
> Do we need to consider offset in 1st page here?

Well, it won't break since we check further on that we don't overrun the ring,
but it's probably a bit more efficient to subtract the offset into the page at
this point.

That said, we don't know how big the first folio is yet, though I'm not sure
if that matters.

David

