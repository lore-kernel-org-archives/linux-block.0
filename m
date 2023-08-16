Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D028C41513
	for <linux-block@archiver.kernel.org>; Wed, 16 Aug 2023 09:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243503AbjHPJv1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Aug 2023 05:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243591AbjHPJu7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Aug 2023 05:50:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1B3D1
        for <linux-block@vger.kernel.org>; Wed, 16 Aug 2023 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692179416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EeY22uFbxE9bAvt1E0mE8TPPOJ4pLMU6pIYR19wlTvg=;
        b=XVldGUFLjQxAXMCYfpI53HJDnPSjV1T3WW8EJOJtUmUBQvAiO6OobUQ4NI+6wIG5Y7yKXL
        5vBcuXDN43UJevDnzECBB4rg/AN6HSNCyqdhUT5U1+L6OKdoM1Sm8uYarxv+gdKU3nUezL
        oAAfFTiQbbW7D1W+y8IC0FpKJjt1Oco=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-u8i2T3oZNvOAN8VauQwTOw-1; Wed, 16 Aug 2023 05:50:15 -0400
X-MC-Unique: u8i2T3oZNvOAN8VauQwTOw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 632D5800159;
        Wed, 16 Aug 2023 09:50:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E52840C207A;
        Wed, 16 Aug 2023 09:50:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <8722207799c342e780e1162a983dc48b@AcuMS.aculab.com>
References: <8722207799c342e780e1162a983dc48b@AcuMS.aculab.com> <855.1692047347@warthog.procyon.org.uk> <5247.1692049208@warthog.procyon.org.uk>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] iov_iter: Convert iterate*() to inline funcs
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <440140.1692179410.1@warthog.procyon.org.uk>
Date:   Wed, 16 Aug 2023 10:50:10 +0100
Message-ID: <440141.1692179410@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> wrote:

> It is harder to compare because of some of the random name changes.

I wouldn't say 'random' exactly, but if you prefer, some of the name changing
can be split out into a separate patch.  The macros are kind of the worst
since they picked up variable names from the callers.

> The version of the source I found seems to pass priv2 to functions
> that don't use it?

That can't be avoided if I convert everything to inline functions and function
pointers - but the optimiser can get rid of it where it can inline the step
function.

I tried passing the iterator to the step functions instead, but that just made
things bigger.  memcpy_from_iter_mc() is interesting to deal with.  I would
prefer to deal with it in the caller so we only do the check once, but that
might mean duplicating the caller.

Actually, ->copy_mc is only set in once place, dump_emit_page() in coredump.c,
and only on a bvec iterator, so I could probably do a special function just
for that that calls iterate_bvec() rather than iterate_and_advance2() and then
make _copy_from_iter() just use memcpy_from_iter() and get rid of
iov_iter::copy_mc entirely.

> Since the functions aren't inlined you get the cost of passing
> the parameters.
> This seems to affect the common cases.

Actually, in v2, the action functions for common cases are marked
__always_inline and do get fully inlined and the code in some paths actually
ends up slightly smaller.

> Is that all left over from a version that passed function pointers
> (with the hope they'd be inlined?).
> Just directly inlining the simple copies should help.

I did that in v2 for things like memcpy_to_iter() and memcpy_from_iter().

> I rather hope the should_fail_usercopy() and instrument_copy_xxx()
> calls are usually either absent or, at most, nops.

Okay - it's probably worth marking those too, then.

> This all seems to have a lot fewer options than last time I looked.

I'm not sure what you mean by 'a lot fewer options'?

> Is it worth optimising the KVEC case with a single buffer?

You mean an equivalent of UBUF?  Maybe.  There are probably a whole bunch of
netfs places that do single-kvec writes, though I'm trying to convert these
over to bvec arrays, combining them with their data, and MSG_SPLICE_PAGES.

David

