Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE49AEE6457
	for <linux-block@archiver.kernel.org>; Fri, 15 Sep 2023 12:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbjIOMhK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Sep 2023 08:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbjIOMhG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2023 08:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B055115
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2023 05:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694781377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hiYpz5dXhxfUZTQa6zmGlfzr3xCWWU+duccDm51H4g4=;
        b=TVbqhPJYOKFrvIn/nADBvyI01sm/lmsu70gw8MHJXx7EBDioiIOGcKCPIQAcLBgJkS2j34
        LuuB+rKnMgU2//NiwVV6EVDafCflXTiCPcCNjcZ8/IQBpbpv6ajXqEaTrP7Ye/WKSZlj3M
        k0FSdUkw7H6We5k8QcuhBljBWSJvXRk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-cqmwHRoKMT67BfSo_FuhuQ-1; Fri, 15 Sep 2023 08:36:10 -0400
X-MC-Unique: cqmwHRoKMT67BfSo_FuhuQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E060811E86;
        Fri, 15 Sep 2023 12:36:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB98F200BFE3;
        Fri, 15 Sep 2023 12:36:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <72e93605b28742c2a496ce4890ecaa80@AcuMS.aculab.com>
References: <72e93605b28742c2a496ce4890ecaa80@AcuMS.aculab.com> <5017b9fa177f4deaa5d481a5d8914ab4@AcuMS.aculab.com> <dcc6543d71524ac488ca2a56dd430118@AcuMS.aculab.com> <20230914221526.3153402-1-dhowells@redhat.com> <20230914221526.3153402-10-dhowells@redhat.com> <3370515.1694772627@warthog.procyon.org.uk> <3449352.1694776980@warthog.procyon.org.uk>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        "Matthew Wilcox" <willy@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        "David Hildenbrand" <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 9/9] iov_iter: Add benchmarking kunit tests for UBUF/IOVEC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3585403.1694781366.1@warthog.procyon.org.uk>
Date:   Fri, 15 Sep 2023 13:36:06 +0100
Message-ID: <3585404.1694781366@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> wrote:

> I was thinking of import_iovec() - or whatever its current
> name is.

That doesn't actually access the buffer described by the iovec[].

> That really needs a single structure that contains the iov_iter
> and the cache[] (which the caller pretty much always allocates
> in the same place).

cache[]?

> Fiddling with that is ok until you find what io_uring does.
> Then it all gets entirely horrid.

That statement sounds like back-of-the-OLS-T-shirt material ;-)

David

