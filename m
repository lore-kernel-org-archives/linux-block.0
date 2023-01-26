Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46A2C54E94
	for <linux-block@archiver.kernel.org>; Thu, 26 Jan 2023 11:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbjAZLfJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Jan 2023 06:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237242AbjAZLfF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2023 06:35:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2265745F42
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 03:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674732860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vQe5NpZwYsKo7kAgmlBPvHS4P0xn6hUuxnEkAKO3Voc=;
        b=Cp1f4g6OMg6Fn8pcGJvjfkfjT/kD2RPapzZQAA0exBjQE87/4rZcABfV32elLfg5M5sQjo
        swbMcOOaIiSEOczpsPjKojU9SXOOvDCLJ1p/0sJ3XIMruXqj8a4uPN9uQCPpMKLy7OBZ9u
        XieCZfY+mL2OEkuZTdg5YQSkubOQSVA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-YQTcYeUeMWCzoABBoC_j_Q-1; Thu, 26 Jan 2023 06:34:14 -0500
X-MC-Unique: YQTcYeUeMWCzoABBoC_j_Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3F2E185A78B;
        Thu, 26 Jan 2023 11:34:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EF24492C14;
        Thu, 26 Jan 2023 11:34:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <f70c9b67-5284-cd6a-7360-92a883bf9bb5@redhat.com>
References: <f70c9b67-5284-cd6a-7360-92a883bf9bb5@redhat.com> <20230125210657.2335748-1-dhowells@redhat.com> <20230125210657.2335748-6-dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v10 5/8] block: Replace BIO_NO_PAGE_REF with BIO_PAGE_REFFED with inverted logic
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2642147.1674732850.1@warthog.procyon.org.uk>
Date:   Thu, 26 Jan 2023 11:34:10 +0000
Message-ID: <2642148.1674732850@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

David Hildenbrand <david@redhat.com> wrote:

> > Signed-off-by: David Howells <dhowells@redhat.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> > cc: Al Viro <viro@zeniv.linux.org.uk>
> > cc: Jens Axboe <axboe@kernel.dk>
> > cc: Jan Kara <jack@suse.cz>
> > cc: Matthew Wilcox <willy@infradead.org>
> > cc: Logan Gunthorpe <logang@deltatee.com>
> > cc: linux-block@vger.kernel.org
> > ---
> 
> Oh, and I agree with a previous comment that this patch should also hold a
> Signed-off-by from Christoph above your Signed-off-by, if he is mentioned as
> the author via "From:".

I think that was actually in reference to patch 3, but yes - and possibly a
Co-developed-by tag.  Christoph?

David

