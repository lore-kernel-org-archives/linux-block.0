Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085DCC43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 03:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10D120870
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 03:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbfDAD3F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Mar 2019 23:29:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731383AbfDAD3F (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Mar 2019 23:29:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB4F785528;
        Mon,  1 Apr 2019 03:29:04 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E3C160851;
        Mon,  1 Apr 2019 03:28:57 +0000 (UTC)
Date:   Mon, 1 Apr 2019 11:28:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/5] blk-mq: allow to run queue if queue refcount is held
Message-ID: <20190401032852.GG30776@ming.t460p>
References: <20190331030954.22320-1-ming.lei@redhat.com>
 <10c8ed10-3c96-b73c-18d8-114773b1d675@acm.org>
 <20190401020036.GB30776@ming.t460p>
 <a64684d1-c3dc-b10a-1a03-0a8b2d01b331@acm.org>
 <20190401025237.GE30776@ming.t460p>
 <21b2000b-16b6-f5a6-692b-73143a49a4ec@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21b2000b-16b6-f5a6-692b-73143a49a4ec@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 01 Apr 2019 03:29:04 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 01, 2019 at 11:25:50AM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 4/1/19 10:52 AM, Ming Lei wrote:
> >> percpu_ref_tryget_live() fails if a per-cpu counter is in the "dead" state.
> >> percpu_ref_kill() changes the state of a per-cpu counter to the "dead"
> >> state. blk_freeze_queue_start() calls percpu_ref_kill(). blk_cleanup_queue()
> >> already calls blk_set_queue_dying() and that last function calls
> >> blk_freeze_queue_start(). So I think that what you wrote is not correct and
> >> that inserting a percpu_ref_tryget_live()/percpu_ref_put() pair in
> >> blk_mq_run_hw_queues() or blk_mq_run_hw_queue() would make a difference and
> >> also that moving the percpu_ref_exit() call into blk_release_queue() makes
> >> sense.
> > If percpu_ref_exit() is moved to blk_release_queue(), we still need to
> > move freeing of hw queue's resource into blk_release_queue() like what
> > the patchset is doing.
> > 
> > Then we don't need to get/put q_usage_counter in blk_mq_run_hw_queues() any more,
> > do we?
> 
> IMO, if we could get a way to prevent any attempt to run queue, it would be
> better and clearer.

It is hard to do that way, and not necessary.

I will post V2 soon for review.

Thanks,
Ming
