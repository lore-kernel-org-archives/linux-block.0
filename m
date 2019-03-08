Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F704C43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 18:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211C520661
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 18:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfCHSSe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:18:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:43542 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfCHSSe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 13:18:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 10:18:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="130000195"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 08 Mar 2019 10:18:33 -0800
Date:   Fri, 8 Mar 2019 11:19:05 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 4/5] nvme: Fail dead namespace's entered requests
Message-ID: <20190308181905.GA5232@localhost.localdomain>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <20190308174006.5032-4-keith.busch@intel.com>
 <1552068927.45180.30.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552068927.45180.30.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 08, 2019 at 10:15:27AM -0800, Bart Van Assche wrote:
> On Fri, 2019-03-08 at 10:40 -0700, Keith Busch wrote:
> > End the entered requests on a quieced queue directly rather than flush
> > them through the low level driver's queue_rq().
> > 
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > ---
> >  drivers/nvme/host/core.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index cc5d9a83d5af..7095406bb293 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -94,6 +94,13 @@ static void nvme_put_subsystem(struct nvme_subsystem *subsys);
> >  static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
> >  					   unsigned nsid);
> >  
> > +static bool nvme_fail_request(struct blk_mq_hw_ctx *hctx, struct request *req,
> > +			      void *data, bool reserved)
> > +{
> > +	blk_mq_end_request(req, BLK_STS_IOERR);
> > +	return true;
> > +}
> 
> Calling blk_mq_end_request() from outside the .queue_rq() or .complete()
> callback functions is wrong. Did you perhaps want to call
> blk_mq_complete_request()?

This callback can only see requests in MQ_RQ_IDLE state, and
bkl_mq_end_request() is the correct way to end those that never entered
a driver's queue_rq().
