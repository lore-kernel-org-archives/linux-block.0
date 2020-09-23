Return-Path: <SRS0=LQCZ=DA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55F2C4363D
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 07:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52AEA2223E
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 07:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1CE5Xiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgIWHQT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 03:16:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49162 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbgIWHQT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 03:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600845377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dQSJKKR/v1J7OgmdvXhUmyi3iPGltzP9AZ3/AICQ3ww=;
        b=P1CE5Xiu0ZCZjHHxyrNG92x+946NjY5VXUFT2NGpQh7fNjqu3vJsjJLCKK6AoAL4oz0Swn
        j1XdyIRzCmmVeCAGBDYQurMLe1snqD6VtCidvmcxKB8HKPVv0DYAGtEqRS3hAyOnXwLyEg
        Z/NIQFJslke4CXDQ2rr7bcnDusuOHqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-hRnbrOffMVaCcCLRxzKEPQ-1; Wed, 23 Sep 2020 03:16:13 -0400
X-MC-Unique: hRnbrOffMVaCcCLRxzKEPQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C4DB188C122;
        Wed, 23 Sep 2020 07:16:12 +0000 (UTC)
Received: from T590 (ovpn-12-168.pek2.redhat.com [10.72.12.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A113A7882D;
        Wed, 23 Sep 2020 07:16:00 +0000 (UTC)
Date:   Wed, 23 Sep 2020 15:15:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [RFC] block: enqueue splitted bios into same cpu
Message-ID: <20200923071556.GA1666956@T590>
References: <20200911032958.125068-1-jefflexu@linux.alibaba.com>
 <20200911110101.GA143560@T590>
 <e787faa8-d31f-04e7-f722-5013a52dc8ab@linux.alibaba.com>
 <20200913140017.GA230984@T590>
 <c709e970-c711-11b7-e897-c66a12be454e@linux.alibaba.com>
 <20200922115622.GA1484750@T590>
 <54172f93-be49-6957-6fbe-c636b60a3430@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54172f93-be49-6957-6fbe-c636b60a3430@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 22, 2020 at 08:19:00PM +0800, JeffleXu wrote:
> 
> On 9/22/20 7:56 PM, Ming Lei wrote:
> > On Tue, Sep 22, 2020 at 12:43:37PM +0800, JeffleXu wrote:
> > > Thanks for replying. Comments embedded below.
> > > 
> > > 
> > > On 9/13/20 10:00 PM, Ming Lei wrote:
> > > > On Fri, Sep 11, 2020 at 07:40:14PM +0800, JeffleXu wrote:
> > > > > Thanks for replying ;)
> > > > > 
> > > > > 
> > > > > On 9/11/20 7:01 PM, Ming Lei wrote:
> > > > > > On Fri, Sep 11, 2020 at 11:29:58AM +0800, Jeffle Xu wrote:
> > > > > > > Splitted bios of one source bio can be enqueued into different CPU since
> > > > > > > the submit_bio() routine can be preempted or fall asleep. However this
> > > > > > > behaviour can't work well with iopolling.
> > > > > > Do you have user visible problem wrt. io polling? If yes, can you
> > > > > > provide more details?
> > > > > No, there's no practical example yet. It's only a hint from the code base.
> > > > > 
> > > > > 
> > > > > > > Currently block iopolling only polls the hardwar queue of the input bio.
> > > > > > > If one bio is splitted to several bios, one (bio 1) of which is enqueued
> > > > > > > into CPU A, while the others enqueued into CPU B, then the polling of bio 1
> > > > > > > will cotinuously poll the hardware queue of CPU A, though the other
> > > > > > > splitted bios may be in other hardware queues.
> > > > > > If it is guaranteed that the returned cookie is from bio 1, poll is
> > > > > > supposed to work as expected, since bio 1 is the chained head of these
> > > > > > bios, and the whole fs bio can be thought as done when bio1 .end_bio
> > > > > > is called.
> > > > > Yes, it is, thanks for your explanation. But except for polling if the input
> > > > > bio has completed, one of the
> > > > > 
> > > > > important work of polling logic is to reap the completion queue. Let's say
> > > > > one bio is split into
> > > > > 
> > > > > two bios, bio 1 and bio 2, both of which are enqueued into the same hardware
> > > > > queue.When polling bio1,
> > > > > 
> > > > > though we have no idea about bio2 at all, the polling logic itself is still
> > > > > reaping the completion queue of
> > > > > 
> > > > > this hardware queue repeatedly, in which case the polling logic still
> > > > > stimulates reaping bio2.
> > > > > 
> > > > > 
> > > > > Then what if these two split bios enqueued into two different hardware
> > > > > queue? Let's say bio1 is enqueued
> > > > > 
> > > > > into hardware queue A, while bio2 is enqueued into hardware queue B. When
> > > > > polling bio1, though the polling
> > > > > 
> > > > > logic is repeatedly reaping the completion queue of hardware queue A, it
> > > > > doesn't help reap bio2. bio2 is reaped
> > > > > 
> > > > > by IRQ as usual. This certainly works currently, but this behavior may
> > > > > deviate the polling design? I'm not sure.
> > > > > 
> > > > > 
> > > > > In other words, if we can ensure that all split bios are enqueued into the
> > > > > same hardware queue, then the polling
> > > > > 
> > > > > logic *may* be faster.
> > > > __submit_bio_noacct_mq() returns cookie from the last bio in current->bio_list, and
> > > > this bio should be the bio passed to __submit_bio_noacct_mq() when bio splitting happens.
> > > > 
> > > > Suppose CPU migration happens during bio splitting, the last bio should be
> > > > submitted to LLD much late than other bios, so when blk_poll() finds
> > > > completion on the hw queue of the last bio, usually other bios should
> > > > be completed already most of times.
> > > > 
> > > > Also CPU migration itself causes much bigger latency, so it is reasonable to
> > > > not expect good IO performance when CPU migration is involved. And CPU migration
> > > > on IO task shouldn't have been done frequently. That said it should be
> > > > fine to miss the poll in this situation.
> > > Yes you're right. After diving into the code of nvme driver, currently nvme
> > > driver indeed allocate interrupt for polling queues,
> > No, nvme driver doesn't allocate interrupt for poll queues, please see
> > nvme_setup_irqs().
> 
> Sorry I was wrong here. Indeed interrupts are disabled for IO queues in
> polling mode. Then this can be a problem.
> 
> If CPU migration happens, separate split bios can be enqueued into different
> polling hardware queues (e.g. queue 1
> 
> and queue 2). The caller is continuously polling on one of the polling
> hardware queue (e.g. queue 1) indicated by the
> 
> returned cookie. If there's no other thread polling on the other hardware
> queue (e.g. queue 2), the split bio on queue 2
> 
> will not be reaped since the interrupt of queue 2 is disabled. Finally the
> completion of this bio (on queue 2) relies on
> 
> timeout mechanism.

OK, looks one real issue, just found that request can only be completed
explicitly in nvme_mq_ops.poll(). Without calling ->poll() on specified
poll hw queue, request can't be completed at all.


Thanks,
Ming

