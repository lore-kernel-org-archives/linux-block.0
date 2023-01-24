Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F413AC61D97
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 20:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjAXUmu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 15:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjAXUmt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 15:42:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A9D4DBC8
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 12:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674592920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3huE8CdVQlsjcqy3c/Rtnp6KMjNzs41mKKeUkR+HEO0=;
        b=UhIxCieUvtX7AY1uGVRqe2MFpIbabr/KhYwYX2rJaK5wDyQC0Nm+bZRxb/JyeVIwA7V7Ye
        UerXGRwmJVb7dvJRJ3TkzAdF/QNqBeDT4wB6VjKYWwuOeG5Drfb6E6q3nyGCuVSfb2hGgM
        WmXrRDDPdvIOXNJixGXd7IfmYEdTn6k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-F4JiLlV8Pl66PD56XCXeWg-1; Tue, 24 Jan 2023 15:41:56 -0500
X-MC-Unique: F4JiLlV8Pl66PD56XCXeWg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2457D3804501;
        Tue, 24 Jan 2023 20:41:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36309400D795;
        Tue, 24 Jan 2023 20:41:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y9Aq7eJ/RKSDiliq@infradead.org>
References: <Y9Aq7eJ/RKSDiliq@infradead.org> <20230124170108.1070389-1-dhowells@redhat.com> <20230124170108.1070389-4-dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/8] iomap: Don't get an reference on ZERO_PAGE for direct I/O block zeroing
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1296568.1674592913.1@warthog.procyon.org.uk>
Date:   Tue, 24 Jan 2023 20:41:53 +0000
Message-ID: <1296569.1674592913@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Jan 24, 2023 at 05:01:03PM +0000, David Howells wrote:
> > ZERO_PAGE can't go away, no need to hold an extra reference.
> > 
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> If you send this on this needs your signoff as well, btw.

Um.  You quoted my signoff.  Do you mean your signoff?

David

