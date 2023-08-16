Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60E0C04A6A
	for <linux-block@archiver.kernel.org>; Wed, 16 Aug 2023 13:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244660AbjHPNBw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Aug 2023 09:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245319AbjHPNBi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Aug 2023 09:01:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B93A1BFB
        for <linux-block@vger.kernel.org>; Wed, 16 Aug 2023 06:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692190854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JL9XHCcHn9+lzn3csLfA/07hiNGl99qLxrzUXZlZiMU=;
        b=Ps1CRioxeHnoJPPAkKmytQzcz5mXkXkO3U5sy93TX8CrMWH90JxERdfpYOFT9j7LV/Ysps
        NQuc+H4E/HbuSuPbWXWJgpIIVScThJXjqsWoNTphOtJB5785aK5ubRIrRpttvuOJ7JISDr
        CVXuhq3ICYli5/zJEMf5jHzji0okkOI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-Zdu0GcBbNlWDvx1senW_nQ-1; Wed, 16 Aug 2023 09:00:51 -0400
X-MC-Unique: Zdu0GcBbNlWDvx1senW_nQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09950185A7A3;
        Wed, 16 Aug 2023 13:00:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 491CA492C14;
        Wed, 16 Aug 2023 13:00:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com>
References: <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com> <20230816120741.534415-1-dhowells@redhat.com> <20230816120741.534415-3-dhowells@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@list.de>,
        "Christian Brauner" <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        "Jeff Layton" <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <608852.1692190847.1@warthog.procyon.org.uk>
Date:   Wed, 16 Aug 2023 14:00:47 +0100
Message-ID: <608853.1692190847@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> wrote:

> 
> Couldn't the relevant code directly call __copy_from_iter_mc() ?
> Or a version then checked iov_is_copy_mc() and then fell
> back to the standard function.

No, because the marked iterator is handed by the coredump code to
__kernel_write_iter() and thence on to who-knows-what driver - which will call
copy_from_iter() or some such.  $DRIVER shouldn't need to know about
->copy_mc.

One thing I do wonder about, though, is what should happen if they call, say,
csum_and_copy_from_iter()?  That doesn't have an _mc variant.  Or what if they
extract the pages and operate directly on those?

David

