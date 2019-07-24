Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D04C76186
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 01:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FE02253D
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 01:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfGXBez (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 21:34:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbfGXBez (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 21:34:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 32AF2308C21E;
        Wed, 24 Jul 2019 01:34:55 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 335431001DD7;
        Wed, 24 Jul 2019 01:34:42 +0000 (UTC)
Date:   Wed, 24 Jul 2019 09:34:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/5] blk-mq: introduce
 blk_mq_tagset_wait_completed_request()
Message-ID: <20190724013432.GB22421@ming.t460p>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-3-ming.lei@redhat.com>
 <c2722892-9cbf-0747-58a8-91a99b72bc53@acm.org>
 <20190723010616.GC30776@ming.t460p>
 <d4d3ded9-0012-68c1-7511-f5ac3aa7b1fb@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4d3ded9-0012-68c1-7511-f5ac3aa7b1fb@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 24 Jul 2019 01:34:55 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 23, 2019 at 01:54:52PM -0700, Bart Van Assche wrote:
> On 7/22/19 6:06 PM, Ming Lei wrote:
> > On Mon, Jul 22, 2019 at 08:25:07AM -0700, Bart Van Assche wrote:
> > > On 7/21/19 10:39 PM, Ming Lei wrote:
> > > > blk-mq may schedule to call queue's complete function on remote CPU via
> > > > IPI, but doesn't provide any way to synchronize the request's complete
> > > > fn.
> > > > 
> > > > In some driver's EH(such as NVMe), hardware queue's resource may be freed &
> > > > re-allocated. If the completed request's complete fn is run finally after the
> > > > hardware queue's resource is released, kernel crash will be triggered.
> > > > 
> > > > Prepare for fixing this kind of issue by introducing
> > > > blk_mq_tagset_wait_completed_request().
> > > 
> > > An explanation is missing of why the block layer is modified to fix this
> > > instead of the NVMe driver.
> > 
> > The above commit log has explained that there isn't sync mechanism in
> > blk-mq wrt. request completion, and there might be similar issue in other
> > future drivers.
> 
> That is not sufficient as a motivation to modify the block layer because
> there is already a way to wait until request completions have finished,
> namely the request queue freeze mechanism. Have you considered to use that
> mechanism instead of introducing blk_mq_tagset_wait_completed_request()?

The introduced interface is used in EH, during which the aborted
requests will stay at blk-mq sw/scheduler queue, so queue freeze will
cause deadlock. We simply can't use it.

Thanks,
Ming
