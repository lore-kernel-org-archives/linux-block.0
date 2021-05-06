Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9300C433ED
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 13:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 922D9613EC
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 13:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhEFNj5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 09:39:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36586 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233811AbhEFNj4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 May 2021 09:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620308337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IKx7ChpiXfVy/EbzpA4Qp8qEDnEAkAOm8JedcdiYlQY=;
        b=WOYi7iUtZ6SohKGPSl88qQDwkRLoozPyzYdQUWdZV1bAcvjugCc8/shn6yrgwcu2cy6WgI
        3W3vv/a3jY6CmeJ4mBBU/f4BoUZw1yUJeQELDLNozZTnNM/jCImcjdA5OWkXIlp+lqEsD9
        w4Ej/v23tbAny8HrdR119sBQvACl4nA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-Gc6Zp0hbOKawOWsHWvm9NA-1; Thu, 06 May 2021 09:38:56 -0400
X-MC-Unique: Gc6Zp0hbOKawOWsHWvm9NA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F041A1008066;
        Thu,  6 May 2021 13:38:54 +0000 (UTC)
Received: from T590 (ovpn-12-192.pek2.redhat.com [10.72.12.192])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D14A19C9B;
        Thu,  6 May 2021 13:38:45 +0000 (UTC)
Date:   Thu, 6 May 2021 21:38:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V5 3/4] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
Message-ID: <YJPxYXCZ2j1r1my1@T590>
References: <20210505145855.174127-1-ming.lei@redhat.com>
 <20210505145855.174127-4-ming.lei@redhat.com>
 <20210506071256.GD328487@infradead.org>
 <YJOb+a85Cpb56Mdz@T590>
 <20210506121849.GA400362@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506121849.GA400362@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 06, 2021 at 01:18:49PM +0100, Christoph Hellwig wrote:
> On Thu, May 06, 2021 at 03:34:17PM +0800, Ming Lei wrote:
> > > {
> > > 	struct blk_mq_tags *drv_tags = set->tags[hctx_idx];
> > > 	unsigned int i = 0;
> > > 	unsigned long flags;
> > > 
> > > 	spin_lock_irqsave(&drv_tags->lock, flags);
> > > 	for (i = 0; i < set->queue_depth; i++)
> > > 		WARN_ON_ONCE(refcount_read(&drv_tags->rqs[i]->ref) != 0);
> > > 		drv_tags->rqs[i] = NULL;
> > 
> > drv_tags->rqs[] may be assigned from another LUN at the same time, then
> > the simple clearing will overwrite the active assignment. We just need
> > to clear mapping iff the stored rq will be freed.
> 
> So.  Even a different LUN shares the same tagset.  So I can see the
> need for the cmpxchg (please document it!), but I don't see the need
> for the complex iteration.  All the rqs are freed in one single loop,
> so we can just iterate through them sequentially.

That is exactly what the patch is doing, requests are stored in page
list, so check if one request(covered in page list) reference in
drv_tags->rq[i] exists, if yes, we clear the request reference.

The code is actually sort of self-document: before we free requests,
clear the reference in hostwide drv->rqs[].

> 
> Btw, I think ->lock might better be named ->clear_lock to document its
> purpose better.

OK.


thanks, 
Ming

