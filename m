Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B625BC63777
	for <linux-block@archiver.kernel.org>; Fri, 27 Nov 2020 02:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B65221FB
	for <linux-block@archiver.kernel.org>; Fri, 27 Nov 2020 02:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9exW4NV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgK0CHB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 21:07:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31496 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392135AbgK0CHB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 21:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606442820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hGLCPSmQvTRpLdJCaDXYXNqOYhXsHqGX1aYMMHVnxi4=;
        b=H9exW4NVWc+QGSKfSd/bTBI5ncqQzIK+2qL9xkKW9I5e6W9peV4kAmxz/qntQHDb5iftD6
        Bq37Oq3NfhLFdf9UHCjXWVLIFlwcjC3fPlXW57GiKuw+niCmKjwTwk8Fiee9PM7qX2Ds2b
        ioOtiDFaK20+WRRth/PFqMl4N9T0V8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-_4i70gR6PYqQkEhIdpkl1g-1; Thu, 26 Nov 2020 21:06:56 -0500
X-MC-Unique: _4i70gR6PYqQkEhIdpkl1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 943125224;
        Fri, 27 Nov 2020 02:06:54 +0000 (UTC)
Received: from T590 (ovpn-12-114.pek2.redhat.com [10.72.12.114])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C588A5C1C2;
        Fri, 27 Nov 2020 02:06:48 +0000 (UTC)
Date:   Fri, 27 Nov 2020 10:06:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] sbitmap: remove swap_lock
Message-ID: <20201127020643.GA126383@T590>
References: <cover.1606058975.git.asml.silence@gmail.com>
 <488177c02dccda60c5e8af2e53156c42b7f1acc0.1606058975.git.asml.silence@gmail.com>
 <20201126024658.GA42718@T590>
 <3ef0bee9-e0e5-a249-9dfb-3ea3c0af2160@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ef0bee9-e0e5-a249-9dfb-3ea3c0af2160@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 26, 2020 at 01:44:36PM +0000, Pavel Begunkov wrote:
> On 26/11/2020 02:46, Ming Lei wrote:
> > On Sun, Nov 22, 2020 at 03:35:46PM +0000, Pavel Begunkov wrote:
> >> map->swap_lock protects map->cleared from concurrent modification,
> >> however sbitmap_deferred_clear() is already atomically drains it, so
> >> it's guaranteed to not loose bits on concurrent
> >> sbitmap_deferred_clear().
> >>
> >> A one threaded tag heavy test on top of nullbk showed ~1.5% t-put
> >> increase, and 3% -> 1% cycle reduction of sbitmap_get() according to perf.
> >>
> >> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> >> ---
> >>  include/linux/sbitmap.h |  5 -----
> >>  lib/sbitmap.c           | 14 +++-----------
> >>  2 files changed, 3 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> >> index e40d019c3d9d..74cc6384715e 100644
> >> --- a/include/linux/sbitmap.h
> >> +++ b/include/linux/sbitmap.h
> >> @@ -32,11 +32,6 @@ struct sbitmap_word {
> >>  	 * @cleared: word holding cleared bits
> >>  	 */
> >>  	unsigned long cleared ____cacheline_aligned_in_smp;
> >> -
> >> -	/**
> >> -	 * @swap_lock: Held while swapping word <-> cleared
> >> -	 */
> >> -	spinlock_t swap_lock;
> >>  } ____cacheline_aligned_in_smp;
> >>  
> >>  /**
> >> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> >> index c1c8a4e69325..4fd877048ba8 100644
> >> --- a/lib/sbitmap.c
> >> +++ b/lib/sbitmap.c
> >> @@ -15,13 +15,9 @@
> >>  static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
> >>  {
> >>  	unsigned long mask, val;
> >> -	bool ret = false;
> >> -	unsigned long flags;
> >>  
> >> -	spin_lock_irqsave(&map->swap_lock, flags);
> >> -
> >> -	if (!map->cleared)
> >> -		goto out_unlock;
> >> +	if (!READ_ONCE(map->cleared))
> >> +		return false;
> > 
> > This way might break sbitmap_find_bit_in_index()/sbitmap_get_shallow().
> > Currently if sbitmap_deferred_clear() returns false, it means nothing
> > can be allocated from this word. With this patch, even though 'false'
> > is returned, free bits still might be available because another
> > sbitmap_deferred_clear() can be run concurrently.
> 
> But that can happen anyway if someone frees a requests right after we
> return from sbitmap_deferred_clear().

When one request is freed, and if there is any allocator waiting for,
sbitmap_queue_wake_up() will wake up the allocator for retrying.

If there isn't any allocator waiting for, freeing request will make
empty bits, and the following way is applied to make forward
progress for either request allocation or driver tag:

	tag = __blk_mq_get_tag(data, bt);	[1]
	if (tag != BLK_MQ_NO_TAG)
		break;
	sbitmap_prepare_to_wait(bt, ws, &wait, TASK_UNINTERRUPTIBLE);
	tag = __blk_mq_get_tag(data, bt);	[2]
	if (tag != BLK_MQ_NO_TAG)
		break;
	io_schedule()

When allocation[2] and sbitmap_resize() is run concurrently,
allocation[2] may fail because map cleared bits are cleared.
But looks it can happen without your patch.

> Can you elaborate what exactly
> it breaks? Something in sbq wakeup paths?

Thinking of further, looks your patch is good: when one allocation
wins(removing swap_lock won't change this point), the winning bit will
be freed in future, then wakeup is run for other waiters if all allocation
take same approach with above.


Thanks,
Ming

