Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9238C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 01:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A46206B6
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 01:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A46206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbeK2MV4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:21:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbeK2MV4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 07:21:56 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4EA35C057867;
        Thu, 29 Nov 2018 01:18:22 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FE5C7A5F5;
        Thu, 29 Nov 2018 01:18:14 +0000 (UTC)
Date:   Thu, 29 Nov 2018 09:18:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCHv4 0/3] scsi timeout handling updates
Message-ID: <20181129011810.GA23390@ming.t460p>
References: <20181126165430.4519-1-keith.busch@intel.com>
 <b9813c10-776f-46fc-15d4-bbd675edc402@kernel.dk>
 <20181128021959.GG11128@ming.t460p>
 <20181128070010.GA20369@lst.de>
 <20181128100659.GA16495@ming.t460p>
 <20181128100848.GA23567@lst.de>
 <20181128154927.GE6401@localhost.localdomain>
 <ddc31c4c-5d5f-c5ca-67bf-33acdd03ed54@kernel.dk>
 <20181128162655.GF6401@localhost.localdomain>
 <20181128175625.GG6401@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128175625.GG6401@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 29 Nov 2018 01:18:22 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 28, 2018 at 10:56:25AM -0700, Keith Busch wrote:
> On Wed, Nov 28, 2018 at 09:26:55AM -0700, Keith Busch wrote:
> > ---
> > diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> > index 9908082b32c4..116398b240e5 100644
> > --- a/drivers/nvme/target/loop.c
> > +++ b/drivers/nvme/target/loop.c
> > @@ -428,10 +428,14 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
> >  static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
> >  {
> >  	if (ctrl->ctrl.queue_count > 1) {
> > -		nvme_stop_queues(&ctrl->ctrl);
> > -		blk_mq_tagset_busy_iter(&ctrl->tag_set,
> > -					nvme_cancel_request, &ctrl->ctrl);
> > +		/*
> > +		 * The back end device driver is responsible for completing all
> > +		 * entered requests
> > +		 */
> > +		nvme_start_freeze(&ctrl->ctrl);
> > +		nvme_wait_freeze(&ctrl->ctrl);
> >  		nvme_loop_destroy_io_queues(ctrl);
> > +		nvme_unfreeze(&ctrl->ctrl);
> >  	}
> >  
> >  	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
> > ---
> 
> The above tests fine with io and nvme resets on a target nvme loop
> backed by null_blk, but I also couldn't recreate the original report
> without the patch.
> 
> Ming,
> 
> Could you tell me a little more how you set it up? I'm just configuring
> null_blk with queue_mode=2 irqmode=2. Anything else to recreate?

No any parameters for null_blk.

You may find all the scripts and .json here:

http://people.redhat.com/minlei/tests/tools/nvme/

And the test entry is nvme_sanity.

thanks,
Ming
