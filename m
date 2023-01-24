Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B237BC61D9D
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 18:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjAXSiQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 13:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbjAXSiK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 13:38:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436082B60E
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 10:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674585444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uZwECejmisQ0fjshTfnhZV5crtPOU/wzqGiZf40ig2g=;
        b=iU0soMOG8SuQWIw9va7AloUB3f7+SjbV5RAuXA+XQKDNcKzAyr2C9rDi11jpb7u5HaA/SS
        7AVzfDS0+4WK/ZV/GvLFc62qQmOjpVyP4bNe0IFuaTh7N5LT1YpiN1w/K44mGos7a6HRbI
        prPBrU2jrzSUWSf5EkmhlHoRrrbDqmc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-jhcozZ53NgWu-gSrQeZ6cQ-1; Tue, 24 Jan 2023 13:37:20 -0500
X-MC-Unique: jhcozZ53NgWu-gSrQeZ6cQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A816802D1A;
        Tue, 24 Jan 2023 18:37:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFFE753A0;
        Tue, 24 Jan 2023 18:37:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y9AOYXpU1cRAHfQz@infradead.org>
References: <Y9AOYXpU1cRAHfQz@infradead.org> <Y8/xApRVtqK7IlYT@infradead.org> <2431ffa0-4a37-56a2-17fa-74a5f681bcb8@redhat.com> <20230123173007.325544-1-dhowells@redhat.com> <20230123173007.325544-8-dhowells@redhat.com> <874829.1674571671@warthog.procyon.org.uk> <875433.1674572633@warthog.procyon.org.uk> <Y9AK+yW7mZ2SNMcj@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, David Hildenbrand <david@redhat.com>,
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
Content-ID: <1291657.1674585437.1@warthog.procyon.org.uk>
Date:   Tue, 24 Jan 2023 18:37:17 +0000
Message-ID: <1291658.1674585437@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> +	WARN_ON_ONCE(bio_flagged(bio, BIO_PAGE_REFFED));

It's still set by fs/direct-io.c.

David

