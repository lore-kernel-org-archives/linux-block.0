Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1875DC25B4E
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 18:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjAXSlU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 13:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjAXSlH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 13:41:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999073C282
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 10:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674585534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dYpdPXdEFf48+Fw8paU8lVXvr14u0ENB9v6e/C9UfnU=;
        b=ZVtGbm5txoxsY8ELmci6U0Z1abqJqA3CZhPgdUmCe+lrKvsRUMwNHQRQvIpNXGvHMnDluI
        Hwg5mC9Z6yMap2C0yJyk8M+rmmY+7Z8voxwsDc71oPF4Qxa+/cWzjZEG88xdQ5QvQ7bPeU
        2lPRtz0k58Iqf43e4i5j5bMKhKP4Ksk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-Ddn31EIsP36hlkHGu4IzTA-1; Tue, 24 Jan 2023 13:38:52 -0500
X-MC-Unique: Ddn31EIsP36hlkHGu4IzTA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DBFF811E6E;
        Tue, 24 Jan 2023 18:38:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFE2AC15BA0;
        Tue, 24 Jan 2023 18:38:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2172496c-2cd2-a2c8-9ddb-cd7d56bcfc75@redhat.com>
References: <2172496c-2cd2-a2c8-9ddb-cd7d56bcfc75@redhat.com> <Y8/xApRVtqK7IlYT@infradead.org> <2431ffa0-4a37-56a2-17fa-74a5f681bcb8@redhat.com> <20230123173007.325544-1-dhowells@redhat.com> <20230123173007.325544-8-dhowells@redhat.com> <874829.1674571671@warthog.procyon.org.uk> <875433.1674572633@warthog.procyon.org.uk> <Y9AK+yW7mZ2SNMcj@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 07/10] block: Switch to pinning pages.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1291741.1674585530.1@warthog.procyon.org.uk>
Date:   Tue, 24 Jan 2023 18:38:50 +0000
Message-ID: <1291742.1674585530@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

David Hildenbrand <david@redhat.com> wrote:

> In case this series gets resend (which I assume), it would be great to CC
> linux-mm on the whole thing.

v9 is already posted, but I hadn't added linux-mm to it.  I dropped all the
bits that touched the mm side of things.

David

