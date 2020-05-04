Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B50AC3A5A9
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 08:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 740BE206B9
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 08:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W10acwOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgEDIiv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 04:38:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43124 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726445AbgEDIiu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 May 2020 04:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588581529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yEniwgZmCQFdwEIiSM2pwNnItHg+TCCTXOOtHXNQWic=;
        b=W10acwOTQdIIoAPnfRyxXjut40pSCPrZEVrhAkS4AJD6QIRPdOrAKhI14PaAqolo/wTo73
        MHzPFRgz/wBiz4f8Fmg8GtTd2OmzTBz8Sfp7Q4LJ0JFtDVcRpSmR3ZfjWsGSL7V4wHaenA
        PK/2w40AdjDDGaFz80uWzFR62Arl19M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-Zqcn11JwMd-D4gLov73aUQ-1; Mon, 04 May 2020 04:38:45 -0400
X-MC-Unique: Zqcn11JwMd-D4gLov73aUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CFD318FE861;
        Mon,  4 May 2020 08:38:43 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E03E610002A8;
        Mon,  4 May 2020 08:38:36 +0000 (UTC)
Date:   Mon, 4 May 2020 16:38:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V9 00/11] blk-mq: improvement CPU hotplug
Message-ID: <20200504083831.GA1139563@T590>
References: <20200502235454.1118520-1-ming.lei@redhat.com>
 <5db8635b-b606-3dd9-ce1d-5280097acbd3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5db8635b-b606-3dd9-ce1d-5280097acbd3@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 04, 2020 at 09:14:20AM +0100, John Garry wrote:
> On 03/05/2020 00:54, Ming Lei wrote:
> > Hi,
> > 
> > Thomas mentioned:
> >      "
> >       That was the constraint of managed interrupts from the very beginning:
> >        The driver/subsystem has to quiesce the interrupt line and the associated
> >        queue _before_ it gets shutdown in CPU unplug and not fiddle with it
> >        until it's restarted by the core when the CPU is plugged in again.
> >      "
> > 
> > But no drivers or blk-mq do that before one hctx becomes inactive(all
> > CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
> > to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().
> > 
> > This patchset tries to address the issue by two stages:
> > 
> > 1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE
> > 
> > - mark the hctx as internal stopped, and drain all in-flight requests
> > if the hctx is going to be dead.
> > 
> > 2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx becomes dead
> > 
> > - steal bios from the request, and resubmit them via generic_make_request(),
> > then these IO will be mapped to other live hctx for dispatch
> > 
> > Thanks John Garry for running lots of tests on arm64 with this patchset
> > and co-working on investigating all kinds of issues.
> > 
> > Thanks Christoph's review on V7.
> > 
> > Please comment & review, thanks!
> > 
> 
> Hi Ming,
> 
> Bad news, I see this on the first hotplug loop:
> 
> [66.628964] CPU2: shutdown
> [66.631663] psci: CPU2 killed (polled 0 ms)
> [66.681062] CPU3: shutdown
> [66.683761] psci: CPU3 killed (polled 0 ms)
> [66.717097] CPU4: shutdown
> [66.719796] psci: CPU4 killed (polled 0 ms)
> [66.753136] CPU5: shutdown
> [66.755834] psci: CPU5 killed (polled 0 ms)
> [66.801234] CPU6: shutdown=2746MiB/s,w=0KiB/s][r=703k,w=0 IOPS][eta 00m:55s]
> [66.803932] psci: CPU6 killed (polled 0 ms)
> [66.837170] irq_shutdown irq150
> [66.840410] CPU7: shutdown
> [66.843112] psci: CPU7 killed (polled 0 ms)
> [66.885394] CPU8: shutdown
> [66.888092] psci: CPU8 killed (polled 0 ms)
> [66.925431] CPU9: shutdown
> [66.928128] psci: CPU9 killed (polled 0 ms)
> [66.965526] CPU10: shutdown
> [66.968311] psci: CPU10 killed (polled 0 ms)
> [67.025569] irq_shutdown irq151
> [67.028808] CPU11: shutdown
> [67.031599] psci: CPU11 killed (polled 0 ms)
> [67.306393] CPU12: shutdown
> [67.309179] psci: CPU12 killed (polled 0 ms)
> [67.347266] CPU13: shutdown
> [67.350058] psci: CPU13 killed (polled 0 ms)
> [67.410910] CPU14: shutdown
> [67.413695] psci: CPU14 killed (polled 0 ms)
> [67.454453] irq_shutdown irq152
> [67.457699] CPU15: shutdown
> [67.457799] ------------[ cut here ]------------
> [67.460506] psci: CPU15 killed (polled 0 ms)
> [67.465091] refcount_t: underflow; use-after-free.
> [67.465112] WARNING: CPU: 0 PID: 557 at lib/refcount.c:28
> refcount_warn_saturate+0x6c/0x13c
> [67.482468] Modules linked in:
> [67.485511] CPU: 0 PID: 557 Comm: irq/149-hisi_sa Not tainted
> 5.7.0-rc2-13190-gb615db31b5f4 #331
> [67.494281] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT21
> Nemo 2.0 RC0 04/18/2018
> [67.503398] pstate: 20000005 (nzCv daif -PAN -UAO)
> [67.508176] pc : refcount_warn_saturate+0x6c/0x13c
> [67.512954] lr : refcount_warn_saturate+0x6c/0x13c
> [67.517730] sp : ffff80001fd3b920
> [67.521031] x29: ffff80001fd3b920 x28: ffff001f9c549500
> [67.526329] x27: ffff001f9c54956c x26: 000000000000d8d0
> [67.531627] x25: ffff001fb08c7378 x24: 0000000000000000
> [67.536925] x23: ffff001f9a6eef00 x22: 0000000000000000
> [67.542223] x21: 0000000000001000 x20: ffff001f9ebd0918
> [67.547521] x19: ffff001f9a6eef00 x18: 0000000000000000
> [67.552820] x17: 000000007fffffff x16: 0000000000000311
> [67.558118] x15: 000000000001ffff x14: 0000000000000001
> [67.563416] x13: 000000000000001f x12: 0000000000000000
> [67.568714] x11: ffff800011aca468 x10: 0000000000fddfa0
> [67.574012] x9 : 0000000000000000 x8 : ffff041faa022098
> [67.579310] x7 : 0000000000000000 x6 : ffff001ffbe871d0
> [67.584608] x5 : 0000000000000001 x4 : 0000000000000000
> [67.589906] x3 : 0000000000000000 x2 : 0000000000000007
> [67.595204] x1 : 0000000100000001 x0 : 0000000000000026
> [67.600503] Call trace:
> [67.602937]  refcount_warn_saturate+0x6c/0x13c
> [67.607369]  aio_complete_rw+0x350/0x384
> [67.611279]  blkdev_bio_end_io+0xc4/0x12c
> [67.615276]  bio_endio+0x104/0x130
> [67.618665]  blk_update_request+0x98/0x37c
> [67.622748]  blk_mq_end_request+0x24/0x138
> [67.626831]  blk_mq_resubmit_end_rq+0x40/0x58
> [67.631174]  __blk_mq_end_request+0xb0/0x10c
> [67.635432]  scsi_end_request+0xdc/0x20c

Looks an old issue, I believe the following patch can fix the issue:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 12dee4ecd5cc..3fc79d4b2fe0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2415,6 +2415,10 @@ static void blk_mq_resubmit_rq(struct request *rq)
 	nrq->bio = rq->bio;
 	nrq->biotail = rq->biotail;
 
+	/* Now all bios ownership is transfered to 'nrq' */
+	rq->bio = rq->biotail = NULL;
+	rq->__data_len = 0;
+
 	if (blk_insert_cloned_request(nrq->q, nrq) != BLK_STS_OK)
 		blk_mq_request_bypass_insert(nrq, false, true);
 }


Thanks,
Ming

