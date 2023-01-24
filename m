Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38134C38142
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 14:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbjAXOhJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 09:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbjAXOhC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 09:37:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5EC2737
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 06:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674570970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3xRZOl0jLzOr6bYmCOtk3JzMhNlxz8niUScogA6swNg=;
        b=Q/5ubCzv9fxB4KDbPcod24lo1WWoCjfFYWtzeo0w7OGCoGCKymKwQZY4Fl/g/cveI/JHWD
        +Rvs67dcS6RsIe8hHeyBo4H46h2wjVfFbKcuZQOZsr5UAjB2g+//Ov36jQ0GPM3vjyk5wQ
        hzETzBOtCLMKFOEfC+aeWnqkKNF48tc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-cU8pMMYzM5in6m-a4K_VPg-1; Tue, 24 Jan 2023 09:36:05 -0500
X-MC-Unique: cU8pMMYzM5in6m-a4K_VPg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A721438123A2;
        Tue, 24 Jan 2023 14:36:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 122FC1121330;
        Tue, 24 Jan 2023 14:35:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1b1eb3d8-c6b4-b264-1baa-1b3eb088173d@redhat.com>
References: <1b1eb3d8-c6b4-b264-1baa-1b3eb088173d@redhat.com> <20230123173007.325544-1-dhowells@redhat.com> <20230123173007.325544-3-dhowells@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Subject: Re: [PATCH v8 02/10] iov_iter: Add a function to extract a page list from an iterator
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <874092.1674570959.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 24 Jan 2023 14:35:59 +0000
Message-ID: <874093.1674570959@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

David Hildenbrand <david@redhat.com> wrote:

> > +#define iov_iter_extract_mode(iter) (user_backed_iter(iter) ? FOLL_PI=
N : 0)
> > +
> =

> Does it make sense to move that to the patch where it is needed? (do we =
need
> it at all anymore?)

Yes, we need something.  Granted, there are now only two alternatives, not
three: either the pages are going to be pinned or they're not going to be
pinned, but I would rather have a specific function that tells you than ju=
st
use, say, user_backed_iter() to make it easier to adjust it later if we ne=
ed
to - and easier to find the places where we need to adjust.

But if it's preferred we could require people to use user_backed_iter()
instead.

David

