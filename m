Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88227C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 08:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AEF32084B
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 08:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfDCI36 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:29:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfDCI36 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Apr 2019 04:29:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 656F0C057EC9;
        Wed,  3 Apr 2019 08:29:57 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD65360145;
        Wed,  3 Apr 2019 08:29:47 +0000 (UTC)
Date:   Wed, 3 Apr 2019 16:29:43 +0800
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
Message-ID: <20190403082941.GA22102@ming.t460p>
References: <21b2000b-16b6-f5a6-692b-73143a49a4ec@oracle.com>
 <20190401032852.GG30776@ming.t460p>
 <ef192658-74cd-e193-cb40-aed546c2b309@oracle.com>
 <20190401100334.GA5493@ming.t460p>
 <ad0f8f4c-5efe-e50f-a3a7-4f7e3d368d28@oracle.com>
 <20190402025505.GB26316@ming.t460p>
 <ac11c70b-0914-cce7-7ed4-22acb292a965@oracle.com>
 <20190402110558.GA12221@ming.t460p>
 <1554227580.118779.158.camel@acm.org>
 <20190403032053.GA9968@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403032053.GA9968@ming.t460p>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 03 Apr 2019 08:29:57 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 03, 2019 at 11:20:53AM +0800, Ming Lei wrote:
> On Tue, Apr 02, 2019 at 10:53:00AM -0700, Bart Van Assche wrote:
> > On Tue, 2019-04-02 at 19:05 +0800, Ming Lei wrote:
> > > On Tue, Apr 02, 2019 at 04:07:04PM +0800, jianchao.wang wrote:
> > > > percpu_ref is born for fast path.
> > > > There are some drivers use it in completion path, such as scsi, does it really
> > > > matter for this kind of device ? If yes, I guess we should remove blk_mq_run_hw_queues
> > > > which is the really bulk and depend on hctx restart mechanism.
> > > 
> > > Yes, it is designed for fast path, but it doesn't mean percpu_ref
> > > hasn't any cost. blk_mq_run_hw_queues() is called for all blk-mq devices,
> > > includes the fast NVMe.
> > 
> > I think the overhead of adding a percpu_ref_get/put pair is acceptable for
> > SCSI drivers. The NVMe driver doesn't call blk_mq_run_hw_queues() directly.
> > Additionally, I don't think that any of the blk_mq_run_hw_queues() calls from
> > the block layer matter for the fast path code in the NVMe driver. In other
> > words, adding a percpu_ref_get/put pair in blk_mq_run_hw_queues() shouldn't
> > affect the performance of the NVMe driver.
> 
> But it can be avoided easily and cleanly, why abuse it for protecting hctx?
> 
> > 
> > > Also:
> > > 
> > > It may not be enough to just grab the percpu_ref for blk_mq_run_hw_queues
> > > only, given the idea is to use the percpu_ref to protect hctx's resources.
> > > 
> > > There are lots of uses on 'hctx', such as other exported blk-mq APIs.
> > > If this approach were chosen, we may have to audit other blk-mq APIs,
> > > cause they might be called after queue is frozen too.
> > 
> > The only blk_mq_hw_ctx user I have found so far that needs additional
> > protection is the q->mq_ops->poll() call in blk_poll(). However, that is not
> > a new issue. Functions like nvme_poll() access data structures (NVMe
> > completion queue) that shouldn't be accessed while blk_cleanup_queue() is in
> > progress. If blk_poll() is modified such that it becomes safe to call that
> > function while blk_cleanup_queue() is in progress then blk_poll() won't
> > access any hardware queue that it shouldn't access.
> 
> There can be lots of such case:
> 
> 1) blk_mq_run_hw_queue() from blk_mq_flush_plug_list()
> - requests can be completed just after added to ctx queue or scheduler queue
> becasue there can be concurrent run queue, then queue freezing may be done
> 
> - then the following blk_mq_run_hw_queue() in blk_mq_sched_insert_requests()
> may see freed hctx fields

Actually this one is blk-mq internal race, and queue's refcount isn't
guaranteed to be held when blk_mq_run_hw_queue is called.

We might have to address this one by grabbing .q_usage_count in
blk_mq_sched_insert_requests just like commit 8dc765d438f1 ("SCSI: fix queue cleanup
race before queue initialization is done"), but I do want to avoid it.

Thanks,
Ming
