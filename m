Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E73C636CC
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 13:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjAaNm3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 08:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjAaNm1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 08:42:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D9351419
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 05:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675172498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N57QrcvIUdB6yMuxeijZFNjUyQe/qI762WSp3dGqEHA=;
        b=U3PxU4FKamxhQqHaunvXMd9ksg8PB4ApNhG9C/IMNN6RgWI0TYeeox033DwptQHtdsCCsq
        4QdOC/9oCwDLbw0sU+9yrfJK+dUSNX4Q0x8g9w2KW71HsX2/FAIPKhzPnC/LKkOY0quphB
        u9pT9jAwp96VHLcxscfnbbH+kP2TVHo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-rgZuwSzoNbaxXdxSRxQ9xQ-1; Tue, 31 Jan 2023 08:41:34 -0500
X-MC-Unique: rgZuwSzoNbaxXdxSRxQ9xQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D35D857A89;
        Tue, 31 Jan 2023 13:41:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97CA140444C0;
        Tue, 31 Jan 2023 13:41:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <040ed7a7-3f4d-dab7-5a49-1cd9933c5445@redhat.com>
References: <040ed7a7-3f4d-dab7-5a49-1cd9933c5445@redhat.com> <e68c5cab-c3a6-1872-98fa-9f909f23be79@nvidia.com> <3351099.1675077249@warthog.procyon.org.uk> <fd0003a0-a133-3daf-891c-ba7deafad768@kernel.dk> <f57ee72f-38e9-6afa-182f-2794638eadcb@kernel.dk> <e8480b18-08af-d101-a721-50d213893492@kernel.dk> <3520518.1675116740@warthog.procyon.org.uk> <f392399b-a4c4-2251-e12b-e89fff351c4d@kernel.dk>
To:     David Hildenbrand <david@redhat.com>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jeff Layton <jlayton@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] iov_iter: Improve page extraction (pin or just list)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3791871.1675172490.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 31 Jan 2023 13:41:30 +0000
Message-ID: <3791872.1675172490@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

David Hildenbrand <david@redhat.com> wrote:

> >> percpu counters maybe - add them up at the point of viewing?
> > They are percpu, see my last email. But for every 108 changes (on
> > my system), they will do two atomic_long_adds(). So not very
> > useful for anything but low frequency modifications.
> > =

> =

> Can we just treat the whole acquired/released accounting as a debug mech=
anism
> to detect missing releases and do it only for debug kernels?
> =

> =

> The pcpu counter is an s8, so we have to flush on a regular basis and ca=
nnot
> really defer it any longer ... but I'm curious if it would be of any hel=
p to
> only have a single PINNED counter that goes into both directions (inc/de=
c on
> pin/release), to reduce the flushing.
> =

> Of course, once we pin/release more than ~108 pages in one go or we swit=
ch
> CPUs frequently it won't be that much of a help ...

What are the stats actually used for?  Is it just debugging, or do we actu=
ally
have users for them (control groups spring to mind)?

David

