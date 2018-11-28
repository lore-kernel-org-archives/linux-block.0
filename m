Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDC5C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 16:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED732086B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 16:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED732086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeK2DcH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:32:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:55658 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbeK2DcG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 22:32:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 08:29:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,291,1539673200"; 
   d="scan'208";a="278321091"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 28 Nov 2018 08:29:52 -0800
Date:   Wed, 28 Nov 2018 09:26:55 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCHv4 0/3] scsi timeout handling updates
Message-ID: <20181128162655.GF6401@localhost.localdomain>
References: <20181126165430.4519-1-keith.busch@intel.com>
 <b9813c10-776f-46fc-15d4-bbd675edc402@kernel.dk>
 <20181128021959.GG11128@ming.t460p>
 <20181128070010.GA20369@lst.de>
 <20181128100659.GA16495@ming.t460p>
 <20181128100848.GA23567@lst.de>
 <20181128154927.GE6401@localhost.localdomain>
 <ddc31c4c-5d5f-c5ca-67bf-33acdd03ed54@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddc31c4c-5d5f-c5ca-67bf-33acdd03ed54@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 28, 2018 at 08:58:00AM -0700, Jens Axboe wrote:
> On 11/28/18 8:49 AM, Keith Busch wrote:
> > On Wed, Nov 28, 2018 at 11:08:48AM +0100, Christoph Hellwig wrote:
> >> On Wed, Nov 28, 2018 at 06:07:01PM +0800, Ming Lei wrote:
> >>>> Is this the nvme target on top of null_blk?
> >>>
> >>> Yes.
> >>
> >> And it goes away if you revert just the last patch?
> > 
> > It looks like a problem existed before that last patch. Reverting it
> > helps only if the request happened to have not been reallocated. If it
> > had been reallocated, the NULL_IRQ_TIMER would have completed the wrong
> > request out-of-order. If this were a real device, that'd probably result
> > in data corruption.
> 
> null_blk just needs updating for this.

Isn't this the nvme target's problem? It shouldn't complete requests
dispatched to its backing device, so I'm thinking something like the
following is what should happen. Untested at the moment, but will try
it out shortly.

---
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9908082b32c4..116398b240e5 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -428,10 +428,14 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 {
 	if (ctrl->ctrl.queue_count > 1) {
-		nvme_stop_queues(&ctrl->ctrl);
-		blk_mq_tagset_busy_iter(&ctrl->tag_set,
-					nvme_cancel_request, &ctrl->ctrl);
+		/*
+		 * The back end device driver is responsible for completing all
+		 * entered requests
+		 */
+		nvme_start_freeze(&ctrl->ctrl);
+		nvme_wait_freeze(&ctrl->ctrl);
 		nvme_loop_destroy_io_queues(ctrl);
+		nvme_unfreeze(&ctrl->ctrl);
 	}
 
 	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
---
