Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7850BC77B7C
	for <linux-block@archiver.kernel.org>; Fri, 26 May 2023 08:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242687AbjEZIaZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 May 2023 04:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242671AbjEZIaU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 May 2023 04:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08520D9
        for <linux-block@vger.kernel.org>; Fri, 26 May 2023 01:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685089770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c892gmHnFnyJknfSVBWfjI1O+CRXJGRWy+yybVQO/8A=;
        b=hB1qcqterByHBP5/rRyoLGuvfYlrsGOPhwfMdlUJYr0gFgSarNimjWPiOVcYzg93cMuzzp
        XI2AEe0/uGlsWdLy4w96ljx7usJC5r/zz9CxB7TSame23IBZ3WbHAue1YBRAflbuHEomfN
        PPlqvirn6+Dav2Hqj6cMKFXGpHUB1xs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-bQLEo4I9MN6xV7hqaz2Y0Q-1; Fri, 26 May 2023 04:29:24 -0400
X-MC-Unique: bQLEo4I9MN6xV7hqaz2Y0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A07538035A6;
        Fri, 26 May 2023 08:29:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C9D19D7A;
        Fri, 26 May 2023 08:29:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZHBsXnJcW3L9SXF4@infradead.org>
References: <ZHBsXnJcW3L9SXF4@infradead.org> <20230525223953.225496-1-dhowells@redhat.com> <20230525223953.225496-2-dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH v2 1/3] mm: Don't pin ZERO_PAGE in pin_user_pages()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <520321.1685089759.1@warthog.procyon.org.uk>
Date:   Fri, 26 May 2023 09:29:19 +0100
Message-ID: <520322.1685089759@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> Shouldn't unpin_user_pages

It calls gup_put_folio() which is where the skip is.

> and bio_release_page also be updated to skip a zero page here?

Porbably best to leave it to unpin_user_page() there.  I've tried to hide the
behaviour entirely within gup.c.

David

