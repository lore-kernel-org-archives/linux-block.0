Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367CBC77B7F
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 08:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjESIo1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 04:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjESIo0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 04:44:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8FCE56
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 01:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684485824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XqulE8q9IX0TG97OlqccamVpFcIlEkKL1KejXgaitAk=;
        b=dfOqYPti2SNSJVRLs14F+WhrM2b5gPjTvWuVVthWp3+mXsPrG44iFytc08vTn/cWcw6tg7
        qgmo6/bA2ojYlaahnASKcIHnCeHIMgJQNZ+gDlads9BwigdMFg++SvanTqLaBc2MmQWNG4
        kN0sItR0t/Ya1y72oesHfm+IYpEoMow=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-RPMCJFogMQCYbOjG6Sj0GA-1; Fri, 19 May 2023 04:43:39 -0400
X-MC-Unique: RPMCJFogMQCYbOjG6Sj0GA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5319B3802AC6;
        Fri, 19 May 2023 08:43:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D3F840C6CCD;
        Fri, 19 May 2023 08:43:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZGcusJQfz68H1s7S@infradead.org>
References: <ZGcusJQfz68H1s7S@infradead.org> <20230519074047.1739879-1-dhowells@redhat.com> <20230519074047.1739879-4-dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v20 03/32] splice: Make direct_read_splice() limit to eof where appropriate
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1742092.1684485814.1@warthog.procyon.org.uk>
Date:   Fri, 19 May 2023 09:43:34 +0100
Message-ID: <1742093.1684485814@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> I'm really not sure if this is a good idea.  Right now
> direct_read_splice (which also appears a little misnamed) really is
> a splice by calling ->read_iter helper.

It can be renamed if you want a different name.  copy_splice_read() or
copy_splice_read_iter()?

> I we don't do any of this validtion we can just call it directly from
> splice.c instead of calling into ->splice_read for direct I/O and DAX and
> remove a ton of boilerplate code.

There's a couple of places where we might not want to do that - at least for
non-DAX.  shmem and f2fs for example.  f2fs calls back to buffered reading
under some circumstances.  shmem ignores O_DIRECT and always splices from the
pagecache.

David

