Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BE5C43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 05:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EED120856
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 05:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfDAFQc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 01:16:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfDAFQc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Apr 2019 01:16:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C228786673;
        Mon,  1 Apr 2019 05:16:31 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F46D5C206;
        Mon,  1 Apr 2019 05:16:22 +0000 (UTC)
Date:   Mon, 1 Apr 2019 13:16:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 0/5] blk-mq: allow to run queue if queue refcount is held
Message-ID: <20190401051617.GH30776@ming.t460p>
References: <20190331030954.22320-1-ming.lei@redhat.com>
 <10c8ed10-3c96-b73c-18d8-114773b1d675@acm.org>
 <20190401020036.GB30776@ming.t460p>
 <a64684d1-c3dc-b10a-1a03-0a8b2d01b331@acm.org>
 <20190401025237.GE30776@ming.t460p>
 <a6dc5d0e-8e51-0714-ac25-6cb6ab78fa18@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6dc5d0e-8e51-0714-ac25-6cb6ab78fa18@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 01 Apr 2019 05:16:31 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Dongli,

On Mon, Apr 01, 2019 at 01:05:46PM +0800, Dongli Zhang wrote:
> 
> 
> On 4/1/19 10:52 AM, Ming Lei wrote:
> > On Sun, Mar 31, 2019 at 07:39:17PM -0700, Bart Van Assche wrote:
> >> On 3/31/19 7:00 PM, Ming Lei wrote:
> >>> On Sun, Mar 31, 2019 at 08:27:35AM -0700, Bart Van Assche wrote:
> >>>> I'm not sure the approach of this patch series is really the direction we
> >>>> should pursue. There are many block driver that free resources immediately
> >>>
> >>> Please see scsi_run_queue(), and the queue refcount is always held
> >>> before run queue.
> >>
> >> That's not correct. There is no guarantee that q->q_usage_counter > 0 when
> >> scsi_run_queue() is called from inside scsi_requeue_run_queue().
> > 
> > We don't need the guarantee of 'q->q_usage_counter > 0', I mean the
> > queue's kobj reference counter.
> > 
> > What we need is to allow run queue to work correctly after queue is frozen
> > or cleaned up.
> > 
> >>
> >>>> I'd like to avoid having to modify all block drivers that free resources
> >>>> immediately after blk_cleanup_queue() has returned. Have you considered to
> >>>> modify blk_mq_run_hw_queues() such that it becomes safe to call that
> >>>> function while blk_cleanup_queue() is in progress, e.g. by inserting a
> >>>> percpu_ref_tryget_live(&q->q_usage_counter) /
> >>>> percpu_ref_put(&q->q_usage_counter) pair?
> >>>
> >>> It can't work because blk_mq_run_hw_queues may happen after
> >>> percpu_ref_exit() is done.
> >>>
> >>> However, if we move percpu_ref_exit() into queue's release handler, we
> >>> don't need to grab q->q_usage_counter any more in blk_mq_run_hw_queues(),
> >>> and we still have to free hw queue resources in queue's release handler,
> >>> that is exactly what this patchset is doing.
> >>>
> >>> In short, getting q->q_usage_counter doesn't make a difference on this
> >>> issue.
> >>
> >> percpu_ref_tryget_live() fails if a per-cpu counter is in the "dead" state.
> >> percpu_ref_kill() changes the state of a per-cpu counter to the "dead"
> >> state. blk_freeze_queue_start() calls percpu_ref_kill(). blk_cleanup_queue()
> >> already calls blk_set_queue_dying() and that last function calls
> >> blk_freeze_queue_start(). So I think that what you wrote is not correct and
> >> that inserting a percpu_ref_tryget_live()/percpu_ref_put() pair in
> >> blk_mq_run_hw_queues() or blk_mq_run_hw_queue() would make a difference and
> >> also that moving the percpu_ref_exit() call into blk_release_queue() makes
> >> sense.
> > 
> > If percpu_ref_exit() is moved to blk_release_queue(), we still need to
> > move freeing of hw queue's resource into blk_release_queue() like what
> > the patchset is doing.
> 
> Hi Ming,
> 
> Would you mind help explain why we still need to move freeing of hw queue's
> resource into blk_release_queue() like what the patchset is doing?
> 
> Let's assume there is no deadlock when percpu_ref_tryget_live() is used,

Could you explain why the assumption is true?

We have to run queue after starting to freeze queue for draining
allocated requests and making forward progress. Inside blk_freeze_queue_start(),
percpu_ref_kill() marks this ref as DEAD, then percpu_ref_tryget_live() returns
false, then queue won't be run.


Thanks, 
Ming
