Return-Path: <SRS0=SpOq=7F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A450C433DF
	for <linux-block@archiver.kernel.org>; Sat, 23 May 2020 03:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1564320727
	for <linux-block@archiver.kernel.org>; Sat, 23 May 2020 03:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lr/zufPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbgEWDGC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 May 2020 23:06:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39008 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387492AbgEWDGC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 May 2020 23:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590203160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+T/AdrAwKvpvVNGiH9brZoHHx659hNMp+dwUpatRoc0=;
        b=Lr/zufPp7XWhsUWzexJVC01wdRDQYZAoWvN3vJjf4oUpkJGXqAJjXnVqrYNm+o4qp7/LZq
        s5bKZEButzrvbuTN2lmOfHHJ6D3T+bB+jLzytn5+inYHRYoCybC6pNbRYGGCXcf9sTWxU5
        w53SWRn6TrN8Tfwod4yaup9gwgbHtTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-3wacZeCiNey4zkX0NEUkPw-1; Fri, 22 May 2020 23:05:56 -0400
X-MC-Unique: 3wacZeCiNey4zkX0NEUkPw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA7F980183C;
        Sat, 23 May 2020 03:05:54 +0000 (UTC)
Received: from T590 (ovpn-12-57.pek2.redhat.com [10.72.12.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5FC35D9CD;
        Sat, 23 May 2020 03:05:47 +0000 (UTC)
Date:   Sat, 23 May 2020 11:05:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: blk-mq: improvement CPU hotplug (simplified version) v3
Message-ID: <20200523030543.GA786407@T590>
References: <20200520170635.2094101-1-hch@lst.de>
 <0cbc37cf-5439-c68c-3581-b3c436932388@acm.org>
 <20200521025744.GC735749@T590>
 <9249e1cc-b6f2-010e-78d2-ead5a1b93464@acm.org>
 <20200521043305.GA741019@T590>
 <7accb5b2-6c7d-0e0d-56df-d06e8d9ac5af@acm.org>
 <20200522023923.GC755458@T590>
 <20200522144720.GC3423299@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522144720.GC3423299@dhcp-10-100-145-180.wdl.wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 22, 2020 at 07:47:20AM -0700, Keith Busch wrote:
> On Fri, May 22, 2020 at 10:39:23AM +0800, Ming Lei wrote:
> > On Thu, May 21, 2020 at 12:15:52PM -0700, Bart Van Assche wrote:
> > > On 2020-05-20 21:33, Ming Lei wrote:
> > > > No.
> > > > 
> > > > If vector 3 is for covering hw queue 12 ~ 15, the vector shouldn't be
> > > > shutdown when cpu 14 is offline.
> > > >> Also I am pretty sure that we don't do this way with managed IRQ. And
> > > > non-managed IRQ will be migrated to other online cpus during cpu offline,
> > > > so not an issue at all. See migrate_one_irq().
> > > 
> > > Thanks for the pointer to migrate_one_irq().
> > > 
> > > However, I'm not convinced the above statement is correct. My
> > > understanding is that the block driver knows which interrupt vector has
> > > been associated with which hardware queue but the blk-mq core not. It
> > > seems to me that patch 6/6 of this series is based on the following
> > > assumptions:
> > > (a) That the interrupt that is associated with a hardware queue is
> > >     processed by one of the CPU's in hctx->cpumask.
> > > (b) That hardware queues do not share interrupt vectors.
> > > 
> > > I don't think that either assumption is correct.
> > 
> > What the patch tries to do is just:
> > 
> > - when the last cpu of hctx->cpumask is going to become offline, mark
> > this hctx as inactive, then drain any inflight IO requests originated
> > from this hctx
> > 
> > The correctness is that once we stops to produce request, we can drain
> > any in-flight requests before shutdown the last cpu of hctx. Then finally
> > this hctx becomes quiesced completely. Do you think this way is wrong?
> > If yes, please prove it.
> 
> I don't think this applies to what Bart is saying, but there is a
> pathological case where things break down: if a driver uses managed
> irq's, but doesn't use the same affinity for the hctx's, an offline cpu
> may have been the only one providing irq handling for an online hctx.

Driver needs to keep managed interrupt alive when this hctx is active,
and blk-mq doesn't have knowledge of managed interrupt & its affinity.

For the non-normal managed-irq usage, that won't be fixed by this
patchset, and it isn't blk-mq's responsibility to cover that.

Not to mention, Bart didn't share any such example.

> 
> I feel like that should be a driver bug if it were to set itself up that
> way, but I don't find anything enforces that.

Right, that is driver issue. And only driver has the knowledge of interrupt &
its affinity stuff, and such enforcement shouldn't be done in blk-mq.


Thanks,
Ming

