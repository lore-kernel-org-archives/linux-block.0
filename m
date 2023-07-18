Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C521FEB64DA
	for <linux-block@archiver.kernel.org>; Tue, 18 Jul 2023 04:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjGREyp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jul 2023 00:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGREyo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jul 2023 00:54:44 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D255A10A
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 21:54:43 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0DE2367373; Tue, 18 Jul 2023 06:54:40 +0200 (CEST)
Date:   Tue, 18 Jul 2023 06:54:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH 3/3] block: Improve performance for BLK_MQ_F_BLOCKING
 drivers
Message-ID: <20230718045439.GA8781@lst.de>
References: <20230717205216.2024545-1-bvanassche@acm.org> <20230717205216.2024545-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717205216.2024545-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 17, 2023 at 01:52:15PM -0700, Bart Van Assche wrote:
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -329,6 +329,9 @@ static void scsi_single_lun_run(struct scsi_device *current_sdev)
>  	starget->starget_sdev_user = NULL;
>  	spin_unlock_irqrestore(shost->host_lock, flags);
>  
> +	/* Combining BLIST_SINGLELUN with BLK_MQ_F_BLOCKING is not supported. */
> +	WARN_ON_ONCE(shost->tag_set.flags & BLK_MQ_F_BLOCKING);

.. but it must work.  BLIST_SINGLELUN is set for specific targets
based on the identification string while BLK_MQ_F_BLOCKING is set by
the LLDD.  Also the blist flags can be set from userspace through
/proc/scsi/device_info.
