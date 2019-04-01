Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB915C43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 03:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21F620870
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 03:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbfDAD1d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Mar 2019 23:27:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39040 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731383AbfDAD1c (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Mar 2019 23:27:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 56B763083392;
        Mon,  1 Apr 2019 03:27:32 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6216B5D71A;
        Mon,  1 Apr 2019 03:27:21 +0000 (UTC)
Date:   Mon, 1 Apr 2019 11:27:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 0/5] blk-mq: allow to run queue if queue refcount is held
Message-ID: <20190401032716.GF30776@ming.t460p>
References: <20190331030954.22320-1-ming.lei@redhat.com>
 <10c8ed10-3c96-b73c-18d8-114773b1d675@acm.org>
 <20190401020036.GB30776@ming.t460p>
 <a64684d1-c3dc-b10a-1a03-0a8b2d01b331@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a64684d1-c3dc-b10a-1a03-0a8b2d01b331@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 01 Apr 2019 03:27:32 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 31, 2019 at 07:39:17PM -0700, Bart Van Assche wrote:
> On 3/31/19 7:00 PM, Ming Lei wrote:
> > On Sun, Mar 31, 2019 at 08:27:35AM -0700, Bart Van Assche wrote:
> > > I'm not sure the approach of this patch series is really the direction we
> > > should pursue. There are many block driver that free resources immediately
> > 
> > Please see scsi_run_queue(), and the queue refcount is always held
> > before run queue.
> 
> That's not correct. There is no guarantee that q->q_usage_counter > 0 when
> scsi_run_queue() is called from inside scsi_requeue_run_queue().
> 
> > > I'd like to avoid having to modify all block drivers that free resources
> > > immediately after blk_cleanup_queue() has returned. Have you considered to
> > > modify blk_mq_run_hw_queues() such that it becomes safe to call that
> > > function while blk_cleanup_queue() is in progress, e.g. by inserting a
> > > percpu_ref_tryget_live(&q->q_usage_counter) /
> > > percpu_ref_put(&q->q_usage_counter) pair?
> > 
> > It can't work because blk_mq_run_hw_queues may happen after
> > percpu_ref_exit() is done.
> > 
> > However, if we move percpu_ref_exit() into queue's release handler, we
> > don't need to grab q->q_usage_counter any more in blk_mq_run_hw_queues(),
> > and we still have to free hw queue resources in queue's release handler,
> > that is exactly what this patchset is doing.
> > 
> > In short, getting q->q_usage_counter doesn't make a difference on this
> > issue.
> 
> percpu_ref_tryget_live() fails if a per-cpu counter is in the "dead" state.
> percpu_ref_kill() changes the state of a per-cpu counter to the "dead"
> state. blk_freeze_queue_start() calls percpu_ref_kill(). blk_cleanup_queue()
> already calls blk_set_queue_dying() and that last function calls
> blk_freeze_queue_start(). So I think that what you wrote is not correct and
> that inserting a percpu_ref_tryget_live()/percpu_ref_put() pair in
> blk_mq_run_hw_queues() or blk_mq_run_hw_queue() would make a difference and
> also that moving the percpu_ref_exit() call into blk_release_queue() makes
> sense.

This way is easy to cause deadlock!!!

If percpu_ref_tryget_live() is called in the entry of blk_mq_run_hw_queues(), 
at the same time, blk_freeze_queue_start() is called, then percpu_ref_tryget_live()
will fail, and run queue can't move on, then blk_mq_freeze_queue_wait() will wait
forever.

Thanks,
Ming
