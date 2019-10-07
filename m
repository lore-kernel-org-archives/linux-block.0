Return-Path: <SRS0=HuTb=YA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01685ECE58C
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 15:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF962070B
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 15:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfJGPBS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:01:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfJGPBS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Oct 2019 11:01:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7564488D316;
        Mon,  7 Oct 2019 15:01:17 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA4A95D9CD;
        Mon,  7 Oct 2019 15:01:07 +0000 (UTC)
Date:   Mon, 7 Oct 2019 23:01:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V2 RESEND 3/5] blk-mq: stop to handle IO before hctx's
 all CPUs become offline
Message-ID: <20191007150101.GA1668@ming.t460p>
References: <20191006024516.19996-1-ming.lei@redhat.com>
 <20191006024516.19996-4-ming.lei@redhat.com>
 <efd6edfa-cde1-7ad3-d04f-1204770e6b42@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efd6edfa-cde1-7ad3-d04f-1204770e6b42@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Mon, 07 Oct 2019 15:01:17 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 07, 2019 at 08:23:29AM +0200, Hannes Reinecke wrote:
> On 10/6/19 4:45 AM, Ming Lei wrote:
> > Most of blk-mq drivers depend on managed IRQ's auto-affinity to setup
> > up queue mapping. Thomas mentioned the following point[1]:
> > 
> > "
> >  That was the constraint of managed interrupts from the very beginning:
> > 
> >   The driver/subsystem has to quiesce the interrupt line and the associated
> >   queue _before_ it gets shutdown in CPU unplug and not fiddle with it
> >   until it's restarted by the core when the CPU is plugged in again.
> > "
> > 
> > However, current blk-mq implementation doesn't quiesce hw queue before
> > the last CPU in the hctx is shutdown. Even worse, CPUHP_BLK_MQ_DEAD is
> > one cpuhp state handled after the CPU is down, so there isn't any chance
> > to quiesce hctx for blk-mq wrt. CPU hotplug.
> > 
> > Add new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE for blk-mq to stop queues
> > and wait for completion of in-flight requests.
> > 
> > [1] https://lore.kernel.org/linux-block/alpine.DEB.2.21.1904051331270.1802@nanos.tec.linutronix.de/
> > 
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq-tag.c         |  2 +-
> >  block/blk-mq-tag.h         |  2 ++
> >  block/blk-mq.c             | 65 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/blk-mq.h     |  1 +
> >  include/linux/cpuhotplug.h |  1 +
> >  5 files changed, 70 insertions(+), 1 deletion(-)
> > 
> I really don't like the zillions of 'XXX_in_flight()' helper in blk-mq;
> blk_mq_queue_inflight(), blk_mq_in_flight(), blk_mq_in_flight_rw() et al.
> Can't you implement your one on top of the already existing?

This one returns in-flight rqs on specific tags(hctx), so far no such
kind of interface, that is why blk_mq_all_tag_busy_iter is exported out
in this patch.


Thanks,
Ming
