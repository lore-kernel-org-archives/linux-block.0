Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B27CC77B76
	for <linux-block@archiver.kernel.org>; Mon, 17 Apr 2023 19:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjDQT5j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Apr 2023 15:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjDQT5h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 15:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB0944B0
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 12:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681761371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BuaRDYUpwldyy8tGqEyYIaPXs/s2jpm4A8XddcZ3Smg=;
        b=Ep7Uyby9n0/V1UJu5TWq4KO4fvOhy0+8oyWl7JHLoxCMu32C5G2W9UH/dtuHZ8RgbWkctY
        NeaCtatyhz0AXAFDkBD/1hLna5AB2NVQttcZ9rcNeyOyilkWaPIsyB2zaJ7ibx3sjs/vcm
        /eGlAT5ZGbHPJwxbXg+0SCYPdhgsCZ0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-Vh1ltFWgNZO2r81YiADpfQ-1; Mon, 17 Apr 2023 15:56:08 -0400
X-MC-Unique: Vh1ltFWgNZO2r81YiADpfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 143992817229;
        Mon, 17 Apr 2023 19:56:08 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D7AA040C6E6E;
        Mon, 17 Apr 2023 19:56:07 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 33HJu7gX004333;
        Mon, 17 Apr 2023 15:56:07 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 33HJu7dI004329;
        Mon, 17 Apr 2023 15:56:07 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 17 Apr 2023 15:56:07 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Matthew Wilcox <willy@infradead.org>
cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Mike Snitzer <msnitzer@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix a crash when bio_for_each_folio_all iterates
 over an empty bio
In-Reply-To: <ZD2e5lw5CqueygSA@casper.infradead.org>
Message-ID: <alpine.LRH.2.21.2304171533510.20290@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.21.2304171433370.17217@file01.intranet.prod.int.rdu2.redhat.com> <ZD2e5lw5CqueygSA@casper.infradead.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Mon, 17 Apr 2023, Matthew Wilcox wrote:

> On Mon, Apr 17, 2023 at 03:11:57PM -0400, Mikulas Patocka wrote:
> > If we use bio_for_each_folio_all on an empty bio, it will access the first
> > bio vector unconditionally (it is uninitialized) and it may crash
> > depending on the uninitialized data.
> 
> Wait, how do we have an empty bio in the first place?

dm-crypt (with the patch that you suggested here: 
https://www.spinics.net/lists/kernel/msg4691572.html
https://lore.kernel.org/linux-mm/alpine.LRH.2.21.2302161619430.5436@file01.intranet.prod.int.rdu2.redhat.com/T/
) calls:

gfp_t gfp_mask = GFP_NOWAIT | __GFP_HIGHMEM;
...
pages = mempool_alloc(&cc->page_pool, gfp_mask);
if (!pages) {
	crypt_free_buffer_pages(cc, clone);
	bio_put(clone);
	gfp_mask |= __GFP_DIRECT_RECLAIM;
	order = 0;
	goto retry;
}

If the mempool_alloc of the first page fails (it may happen because it 
uses GFP_NOWAIT), crypt_free_buffer_pages will be called with an empty 
bio.


I also hit this bug when fixing a dm-flakey target - it is triggered by 
this: 
https://people.redhat.com/~mpatocka/patches/kernel/dm-flakey/dm-flakey-02-clone-pages.patch


I think that this patch doesn't have to be backported to the stable 
kernels (because there is currently no user that calls 
bio_for_each_folio_all on an empty bio), but for the next merge window, 
dm-crypt and dm-flakey is going to use it.

Mikulas

