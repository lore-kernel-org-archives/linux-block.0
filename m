Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C11C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 03:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B0F2146E
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 03:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfDCDVI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:21:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfDCDVI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Apr 2019 23:21:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25D588552A;
        Wed,  3 Apr 2019 03:21:08 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 95A925C57E;
        Wed,  3 Apr 2019 03:20:59 +0000 (UTC)
Date:   Wed, 3 Apr 2019 11:20:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/5] blk-mq: allow to run queue if queue refcount is held
Message-ID: <20190403032053.GA9968@ming.t460p>
References: <20190401025237.GE30776@ming.t460p>
 <21b2000b-16b6-f5a6-692b-73143a49a4ec@oracle.com>
 <20190401032852.GG30776@ming.t460p>
 <ef192658-74cd-e193-cb40-aed546c2b309@oracle.com>
 <20190401100334.GA5493@ming.t460p>
 <ad0f8f4c-5efe-e50f-a3a7-4f7e3d368d28@oracle.com>
 <20190402025505.GB26316@ming.t460p>
 <ac11c70b-0914-cce7-7ed4-22acb292a965@oracle.com>
 <20190402110558.GA12221@ming.t460p>
 <1554227580.118779.158.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554227580.118779.158.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 03 Apr 2019 03:21:08 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 02, 2019 at 10:53:00AM -0700, Bart Van Assche wrote:
> On Tue, 2019-04-02 at 19:05 +0800, Ming Lei wrote:
> > On Tue, Apr 02, 2019 at 04:07:04PM +0800, jianchao.wang wrote:
> > > percpu_ref is born for fast path.
> > > There are some drivers use it in completion path, such as scsi, does it really
> > > matter for this kind of device ? If yes, I guess we should remove blk_mq_run_hw_queues
> > > which is the really bulk and depend on hctx restart mechanism.
> > 
> > Yes, it is designed for fast path, but it doesn't mean percpu_ref
> > hasn't any cost. blk_mq_run_hw_queues() is called for all blk-mq devices,
> > includes the fast NVMe.
> 
> I think the overhead of adding a percpu_ref_get/put pair is acceptable for
> SCSI drivers. The NVMe driver doesn't call blk_mq_run_hw_queues() directly.
> Additionally, I don't think that any of the blk_mq_run_hw_queues() calls from
> the block layer matter for the fast path code in the NVMe driver. In other
> words, adding a percpu_ref_get/put pair in blk_mq_run_hw_queues() shouldn't
> affect the performance of the NVMe driver.

But it can be avoided easily and cleanly, why abuse it for protecting hctx?

> 
> > Also:
> > 
> > It may not be enough to just grab the percpu_ref for blk_mq_run_hw_queues
> > only, given the idea is to use the percpu_ref to protect hctx's resources.
> > 
> > There are lots of uses on 'hctx', such as other exported blk-mq APIs.
> > If this approach were chosen, we may have to audit other blk-mq APIs,
> > cause they might be called after queue is frozen too.
> 
> The only blk_mq_hw_ctx user I have found so far that needs additional
> protection is the q->mq_ops->poll() call in blk_poll(). However, that is not
> a new issue. Functions like nvme_poll() access data structures (NVMe
> completion queue) that shouldn't be accessed while blk_cleanup_queue() is in
> progress. If blk_poll() is modified such that it becomes safe to call that
> function while blk_cleanup_queue() is in progress then blk_poll() won't
> access any hardware queue that it shouldn't access.

There can be lots of such case:

1) blk_mq_run_hw_queue() from blk_mq_flush_plug_list()
- requests can be completed just after added to ctx queue or scheduler queue
becasue there can be concurrent run queue, then queue freezing may be done

- then the following blk_mq_run_hw_queue() in blk_mq_sched_insert_requests()
may see freed hctx fields

2) blk_mq_delay_run_hw_queue
- what if it is called after blk_sync_queue() is done in
  blk_cleanup_queue()
- but the caller follows the old rule by holding request queue's
  refcount

3) blk_mq_quiesce_queue
- called after blk_mq_free_queue() is done, then use-after-free on hctx->srcu
- but the caller follows the old rule by holding request queue's

...

Thanks,
Ming
