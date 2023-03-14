Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1C2C7618D
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 21:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCNVxG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 17:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjCNVxE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 17:53:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F5C5293E
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 14:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678830736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KL7RUrUlJgDEAxq9GYJFCawiEJWge2p1Oaahbua9byM=;
        b=QQu1NO8Sbj6vR5itRaRL8AKiblmFHb0kkLAqP1auMC4MBHTVv+0I5zGlv4OEdQyhA5KT1g
        d23gESM5xS9VMKIGaNHNP1cIQXE0uxHoEU3k9PUmw/0AJ2tU6BLNWO0fQ144eQhzQkApvF
        JtJbwq5CjgUCkNJku46e339EC3bRb1A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-uS-EDXNSN3qnzq1H8duDKw-1; Tue, 14 Mar 2023 17:52:11 -0400
X-MC-Unique: uS-EDXNSN3qnzq1H8duDKw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76942385F36D;
        Tue, 14 Mar 2023 21:52:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21BD9C164E7;
        Tue, 14 Mar 2023 21:52:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZBCvqQyOgEa626ON@infradead.org>
References: <ZBCvqQyOgEa626ON@infradead.org> <20230308165251.2078898-1-dhowells@redhat.com> <20230308165251.2078898-8-dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Steve French <smfrench@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH v17 07/14] splice: Do splice read from a file without using ITER_PIPE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3826684.1678830727.1@warthog.procyon.org.uk>
Date:   Tue, 14 Mar 2023 21:52:07 +0000
Message-ID: <3826685.1678830727@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> > Make cifs use generic_file_splice_read() rather than doing it for itself.
> 
> Please split the cifs patch out into a separate one.

Okay - I've done that.  It needs to go after this one and the unexport of
filemap_splice_read() needs to go with it (or in a separate follow-up patch).

David

