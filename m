Return-Path: <SRS0=5kok=TX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EACBC282DD
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 10:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D152168B
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 10:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfEWKUD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 May 2019 06:20:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfEWKUD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 May 2019 06:20:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ACF8830A6986;
        Thu, 23 May 2019 10:20:02 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0443319C4F;
        Thu, 23 May 2019 10:19:58 +0000 (UTC)
Date:   Thu, 23 May 2019 18:19:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: reset request timeouts during fw activation
Message-ID: <20190523101953.GA18805@ming.t460p>
References: <20190522174812.5597-1-keith.busch@intel.com>
 <20190522174812.5597-3-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522174812.5597-3-keith.busch@intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 23 May 2019 10:20:02 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 22, 2019 at 11:48:12AM -0600, Keith Busch wrote:
> The nvme controller may pause command processing during firmware
> activation. The driver will quiesce queues during this time, but commands
> dispatched prior to the notification will not be processed until the
> hardware completes this activation.
> 
> We do not want those requests to time out while the hardware is in
> this paused state as we don't expect those commands to complete during
> this time, and that handling will interfere with the firmware activation
> process.
> 
> In addition to quiescing the queues, halt timeout detection during the
> paused state and reset the dispatched request deadlines when the hardware
> exists that state. This action applies to IO and admin queues.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/nvme/host/core.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1b7c2afd84cb..37a9a66ada22 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -89,6 +89,7 @@ static dev_t nvme_chr_devt;
>  static struct class *nvme_class;
>  static struct class *nvme_subsys_class;
>  
> +static void nvme_reset_queues(struct nvme_ctrl *ctrl);
>  static int nvme_revalidate_disk(struct gendisk *disk);
>  static void nvme_put_subsystem(struct nvme_subsystem *subsys);
>  static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
> @@ -3605,6 +3606,11 @@ static void nvme_fw_act_work(struct work_struct *work)
>  				msecs_to_jiffies(admin_timeout * 1000);
>  
>  	nvme_stop_queues(ctrl);
> +	nvme_sync_queues(ctrl);
> +
> +	blk_mq_quiesce_queue(ctrl->admin_q);
> +	blk_sync_queue(ctrl->admin_q);

blk_sync_queue() may not halt timeout detection completely since the
timeout work may reset timer again.

Also reset still may come during activating FW, is that a problem?


Thanks,
Ming
