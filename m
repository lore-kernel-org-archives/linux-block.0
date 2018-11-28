Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3303C04EB8
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E002133F
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E002133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeK2Jhy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:37:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:47102 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbeK2Jhy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 04:37:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 14:34:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,292,1539673200"; 
   d="scan'208";a="115152942"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga002.fm.intel.com with ESMTP; 28 Nov 2018 14:34:43 -0800
Date:   Wed, 28 Nov 2018 15:31:46 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCHv4 0/3] scsi timeout handling updates
Message-ID: <20181128223146.GH6401@localhost.localdomain>
References: <20181126165430.4519-1-keith.busch@intel.com>
 <b9813c10-776f-46fc-15d4-bbd675edc402@kernel.dk>
 <20181128021959.GG11128@ming.t460p>
 <20181128070010.GA20369@lst.de>
 <20181128100659.GA16495@ming.t460p>
 <20181128100848.GA23567@lst.de>
 <20181128154927.GE6401@localhost.localdomain>
 <ddc31c4c-5d5f-c5ca-67bf-33acdd03ed54@kernel.dk>
 <20181128162655.GF6401@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128162655.GF6401@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 28, 2018 at 09:26:55AM -0700, Keith Busch wrote:
> ---
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index 9908082b32c4..116398b240e5 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -428,10 +428,14 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
>  static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
>  {
>  	if (ctrl->ctrl.queue_count > 1) {
> -		nvme_stop_queues(&ctrl->ctrl);
> -		blk_mq_tagset_busy_iter(&ctrl->tag_set,
> -					nvme_cancel_request, &ctrl->ctrl);
> +		/*
> +		 * The back end device driver is responsible for completing all
> +		 * entered requests
> +		 */
> +		nvme_start_freeze(&ctrl->ctrl);
> +		nvme_wait_freeze(&ctrl->ctrl);
>  		nvme_loop_destroy_io_queues(ctrl);
> +		nvme_unfreeze(&ctrl->ctrl);
>  	}
>  
>  	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
> ---

Grr, the above doesn't work so well when not using NVMe mpath because
nvmf_check_ready() will requeue it, leaving entered requests that won't
be started.

Waiting for a freeze isn't really the criteria we need anyway: we don't
care if there are entered requests in REQ_MQ_IDLE. We just want to wait
for dispatched ones to return, and we currently don't have a good way
to sync with that condition.
