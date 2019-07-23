Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B688C7618F
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 01:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E269C21955
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 01:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbfGWBI7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 21:08:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731802AbfGWBI7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 21:08:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03426C057F2E;
        Tue, 23 Jul 2019 01:08:59 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CAC35C220;
        Tue, 23 Jul 2019 01:08:52 +0000 (UTC)
Date:   Tue, 23 Jul 2019 09:08:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/5] nvme: don't abort completed request in
 nvme_cancel_request
Message-ID: <20190723010845.GD30776@ming.t460p>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-4-ming.lei@redhat.com>
 <d82ead02-c893-4d14-307e-70a6d4596439@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d82ead02-c893-4d14-307e-70a6d4596439@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 23 Jul 2019 01:08:59 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 22, 2019 at 08:27:32AM -0700, Bart Van Assche wrote:
> On 7/21/19 10:39 PM, Ming Lei wrote:
> > Before aborting in-flight requests, all IO queues have been shutdown.
> > However, request's completion fn may not be done yet because it may
> > be scheduled to run via IPI.
> > 
> > So don't abort one request if it is marked as completed, otherwise
> > we may abort one normal completed request.
> > 
> > Cc: Max Gurtovoy <maxg@mellanox.com>
> > Cc: Sagi Grimberg <sagi@grimberg.me>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   drivers/nvme/host/core.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index cc09b81fc7f4..cb8007cce4d1 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -285,6 +285,10 @@ EXPORT_SYMBOL_GPL(nvme_complete_rq);
> >   bool nvme_cancel_request(struct request *req, void *data, bool reserved)
> >   {
> > +	/* don't abort one completed request */
> > +	if (blk_mq_request_completed(req))
> > +		return;
> > +
> >   	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
> >   				"Cancelling I/O %d", req->tag);
> 
> Something I probably already asked before: what prevents that
> nvme_cancel_request() is executed concurrently with the completion handler
> of the same request?

The commit log did mention the point:

	Before aborting in-flight requests, all IO queues have been shutdown.

which implies that no concurrent normal completion.

Thanks,
Ming
