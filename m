Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372F7C001B0
	for <linux-block@archiver.kernel.org>; Tue, 15 Aug 2023 12:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbjHOMwr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Aug 2023 08:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237315AbjHOMwW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2023 08:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F6310C0
        for <linux-block@vger.kernel.org>; Tue, 15 Aug 2023 05:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692103897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6h9aonqmeDneHn2sCJ+4YLuPQmV9DjwIRMJXM+2v704=;
        b=dfm5vaKdjXYxElC1j5RObNJJvXUd4+p/bVFLBcVdMhGcy9KBBGUTknAM750Y/V1QNXlZ/q
        v2QONwAdTsg59KwPLvUU03J8tS5NfVT2hO22JwgxWWHgxaIYTDzJu013Y2AQuRc6llZ+Vc
        UWQnJfs/MhxQ27Sse3HCFs43COh3FpA=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-qBAZoA6cNmWTtYvAFtxRoA-1; Tue, 15 Aug 2023 08:51:32 -0400
X-MC-Unique: qBAZoA6cNmWTtYvAFtxRoA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 576E33C108C9;
        Tue, 15 Aug 2023 12:51:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3E4B140E917;
        Tue, 15 Aug 2023 12:51:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <aceea2408bf049aebb1f1f893281795c@AcuMS.aculab.com>
References: <aceea2408bf049aebb1f1f893281795c@AcuMS.aculab.com> <3710261.1691764329@warthog.procyon.org.uk>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] iov_iter: Convert iterate*() to inline funcs
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <286906.1692103889.1@warthog.procyon.org.uk>
Date:   Tue, 15 Aug 2023 13:51:29 +0100
Message-ID: <286907.1692103889@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> wrote:

> Actually quite typical because inlining happens much later on.
> I suspect that the #define benefits from the compile front-end
> optimising constants.

I managed to mostly pull it back, and even make some functions slightly
smaller, in the v2 I posted.  Mostly that came about by arranging things to
look a bit more like the upstream macro version.

David

