Return-Path: <SRS0=rKNO=6Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF228C47255
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 03:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C02022070B
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 03:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXc3KfEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgEKDsr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 May 2020 23:48:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26138 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728058AbgEKDsq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 May 2020 23:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589168924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3IfYj3ViZof2SfY22paUT3NYbCsvIYP1WEr7GqZyZIU=;
        b=WXc3KfEiwJ9ZrUe2AIwOY0VdI6/54OIdAg6RaSEok1taczgtR90OA/g2JcQa4LwhouR7mn
        UF2BNbkcI5QDQhHW73VvWJT5dgtkX5Jdo/lM5eM2odi0Kgcj4rwJ5JmVOMv83QW+At42zk
        OnAPyJuzjCG/AX8ZXDJuRqMCoOl8xn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-gI2lLNy8NmSknGJY8InL1g-1; Sun, 10 May 2020 23:48:41 -0400
X-MC-Unique: gI2lLNy8NmSknGJY8InL1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 894AC1895A4D;
        Mon, 11 May 2020 03:48:39 +0000 (UTC)
Received: from T590 (ovpn-13-75.pek2.redhat.com [10.72.13.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B16BA5C1D2;
        Mon, 11 May 2020 03:48:32 +0000 (UTC)
Date:   Mon, 11 May 2020 11:48:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V10 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200511034827.GD1418834@T590>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
 <20200505020930.1146281-8-ming.lei@redhat.com>
 <dbada06d-fcc4-55df-935e-2a46433f28a1@acm.org>
 <20200509022051.GC1392681@T590>
 <0f578345-5a51-b64a-e150-724cfb18dde4@acm.org>
 <20200509041042.GG1392681@T590>
 <1918187b-2baa-5703-63ee-097a307cf594@acm.org>
 <20200511014538.GB1418834@T590>
 <8ef5352b-a1bb-a3c1-3ad2-696df6e86f1f@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ef5352b-a1bb-a3c1-3ad2-696df6e86f1f@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 10, 2020 at 08:20:24PM -0700, Bart Van Assche wrote:
> On 2020-05-10 18:45, Ming Lei wrote:
> > On Sat, May 09, 2020 at 07:18:46AM -0700, Bart Van Assche wrote:
> >> On 2020-05-08 21:10, Ming Lei wrote:
> >>> queue freezing can only be applied on the request queue level, and not
> >>> hctx level. When requests can't be completed, wait freezing just hangs
> >>> for-ever.
> >>
> >> That's indeed what I meant: freeze the entire queue instead of
> >> introducing a new mechanism that freezes only one hardware queue at a time.
> > 
> > No, the issue is exactly that one single hctx becomes inactive, and
> > other hctx are still active and workable.
> > 
> > If one entire queue is frozen because of some of CPUs are offline, how
> > can userspace submit IO to this disk? You suggestion justs makes the
> > disk not usable, that won't be accepted.
> 
> What I meant is to freeze a request queue temporarily (until hot
> unplugging of a CPU has finished). I would never suggest to freeze a
> request queue forever and I think that you already knew that.

But what is your motivation to freeze queue temporarily?

I don's see any help of freezing queue for this issue. Also even though
it is temporary, IO effect still can be observed for other online CPUs.

If you want to block new allocation from the inactive hctx, that isn't
necessary cause no new allocation is basically possible because all
cpus of this hctx will be offline.

If you want to wait completion of in-flight requests, that isn't doable
because requests may not be completed at all when one hctx becomes
inactive and the managed interrupt is shutdown.

> 
> >> Please clarify what "when requests can't be completed" means. Are you
> >> referring to requests that take longer than expected due to e.g. a
> >> controller lockup or to requests that take a long time intentionally?
> > 
> > If all CPUs in one hctx->cpumask are offline, the managed irq of this hw
> > queue will be shutdown by genirq code, so any in-flight IO won't be
> > completed or timedout after the managed irq is shutdown because of cpu
> > offline.
> > 
> > Some drivers may implement timeout handler, so these in-flight requests
> > will be timed out, but still not friendly behaviour given the default
> > timeout is too long.
> > 
> > Some drivers don't implement timeout handler at all, so these IO won't
> > be completed.
> 
> I think that the block layer needs to be notified after the decision has

I have added new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE for getting the
notification and blk_mq_hctx_notify_online() will be called before this
cpu is put offline.

> been taken to offline a CPU and before the interrupts associated with
> that CPU are disabled. That would allow the block layer to freeze a
> request queue without triggering any timeouts (ignoring block driver and
> hardware bugs). I'm not familiar with CPU hotplugging so I don't know
> whether or not such a mechanism already exists.

How can freezing queue avoid to triggering timeout?

Freezing queue basically blocks new request allocation, and follows wait
for completion of all in-flight request. As I explained, either no new
allocation on this inactive hctx, or in-flight request won't be completed
without this patch's solution.

> 
> >> The former case is handled by the block layer timeout handler. I propose
> >> to handle the latter case by introducing a new callback function pointer
> >> in struct blk_mq_ops that aborts all outstanding requests.
> > 
> > As I mentioned, timeout isn't a friendly behavior. Or not every driver
> > implements timeout handler or well enough.
> 
> What I propose is to fix those block drivers instead of complicating the
> block layer core further and instead of introducing potential deadlocks
> in the block layer core.

The deadlock you mentioned can be fixed with help of BLK_MQ_REQ_PREEMPT.

> 
> >> Request queue
> >> freezing is such an important block layer mechanism that I think we
> >> should require that all block drivers support freezing a request queue
> >> in a short time.
> > 
> > Firstly, we just need to drain in-flight requests and re-submit queued
> > requests from one single hctx, and queue wide freezing causes whole
> > userspace IOs blocked unnecessarily.
> 
> Freezing a request queue for a short time is acceptable. As you know we
> already do that when the queue depth is modified, when the write-back
> throttling latency is modified and also when the I/O scheduler is changed.

Again, how can freeze queue help the issue addressed by this patchset?

> 
> > Secondly, some requests may not be completed at all, so freezing can't
> > work because freeze_wait may hang forever.
> 
> If a request neither can be aborted nor completes then that's a severe
> bug in the block driver that submitted the request to the block device.

It is hard to implement timeout handler for every driver, or remove all
BLK_EH_RESET_TIMER returning from driver.

Even for drivers which implementing timeout handler elegantly, it isn't
friendly to wait several dozens of seconds or more than one hundred seconds
to wait IO completion during cpu hotplug. Who said that IO timeout has
to be triggered during cpu hotplug? At least there isn't such issue with
non-managed interrupt.



Thanks, 
Ming

