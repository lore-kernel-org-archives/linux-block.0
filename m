Return-Path: <SRS0=5dBz=7E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FB8C433DF
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 02:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D10A62072C
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 02:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBt0QAFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgEVCjj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 May 2020 22:39:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46845 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727024AbgEVCjj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 May 2020 22:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590115177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I6LwNItbuGN1WLOFHd4l80joJnuPsLwjmgfkBoZeqrc=;
        b=TBt0QAFALeH3n/OpG+yqcGuvsUoozmLjNSpdEiUX36SeG3PWrRGnrqAUmltv/2r2RjbnTg
        fx1PMp9usZyO47T6LRiTfEMltnUjZM7B6Y1FkpzRFYe7G981bCCDsDasKs0FX3YRtQ/zia
        Rh3VMGg6GISaO/hyQBKeUOFUKt4NF8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-LRTeB_HmPdK74XE9wuekzQ-1; Thu, 21 May 2020 22:39:35 -0400
X-MC-Unique: LRTeB_HmPdK74XE9wuekzQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 441381005512;
        Fri, 22 May 2020 02:39:34 +0000 (UTC)
Received: from T590 (ovpn-13-78.pek2.redhat.com [10.72.13.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 071005D9C9;
        Fri, 22 May 2020 02:39:27 +0000 (UTC)
Date:   Fri, 22 May 2020 10:39:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: blk-mq: improvement CPU hotplug (simplified version) v3
Message-ID: <20200522023923.GC755458@T590>
References: <20200520170635.2094101-1-hch@lst.de>
 <0cbc37cf-5439-c68c-3581-b3c436932388@acm.org>
 <20200521025744.GC735749@T590>
 <9249e1cc-b6f2-010e-78d2-ead5a1b93464@acm.org>
 <20200521043305.GA741019@T590>
 <7accb5b2-6c7d-0e0d-56df-d06e8d9ac5af@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7accb5b2-6c7d-0e0d-56df-d06e8d9ac5af@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 21, 2020 at 12:15:52PM -0700, Bart Van Assche wrote:
> On 2020-05-20 21:33, Ming Lei wrote:
> > No.
> > 
> > If vector 3 is for covering hw queue 12 ~ 15, the vector shouldn't be
> > shutdown when cpu 14 is offline.
> >> Also I am pretty sure that we don't do this way with managed IRQ. And
> > non-managed IRQ will be migrated to other online cpus during cpu offline,
> > so not an issue at all. See migrate_one_irq().
> 
> Thanks for the pointer to migrate_one_irq().
> 
> However, I'm not convinced the above statement is correct. My
> understanding is that the block driver knows which interrupt vector has
> been associated with which hardware queue but the blk-mq core not. It
> seems to me that patch 6/6 of this series is based on the following
> assumptions:
> (a) That the interrupt that is associated with a hardware queue is
>     processed by one of the CPU's in hctx->cpumask.
> (b) That hardware queues do not share interrupt vectors.
> 
> I don't think that either assumption is correct.

What the patch tries to do is just:

- when the last cpu of hctx->cpumask is going to become offline, mark
this hctx as inactive, then drain any inflight IO requests originated
from this hctx

The correctness is that once we stops to produce request, we can drain
any in-flight requests before shutdown the last cpu of hctx. Then finally
this hctx becomes quiesced completely. Do you think this way is wrong?
If yes, please prove it.

So correctness of the patch 6/6 does not depend on the two assumptions,
does it?

This way solves the request timeout or never completion issue in case
that managed interrupt affinity is same with the hw queue's cpumask. I believe
this way is the normal usage, and most of storage drivers use managed
interrupt in this way. And motivation of this patch is to fix this kind
of normal usage.

You may argue that two hw queue may share single managed interrupt, that
is possible if driver plays the trick. But if driver plays the trick in
this way, it is driver's responsibility to guarantee that the managed
irq won't be shutdown if either of the two hctxs are active, such as,
making sure that hctx->cpumask + hctx->cpumask <= this managed interrupt's affinity.
It is definitely one strange enough case, and this patch doesn't
suppose to cover this strange case. But, this patch won't break this
case. Also just be curious, do you have such in-tree case? and are you
sure the driver uses managed interrupt?

Again, no such problem in case of non-managed interrupt, because they
will be migrated to other online cpus. But this patchset is harmless for
non-managed interrupt, and still correct to quiesce hctx after all cpus
of hctx become offline from blk-mq queue mapping point, because no request
produced any more.



Thanks,
Ming

