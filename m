Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393CAC282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 08:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CB7217D6
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 08:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfBDIBj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:01:39 -0500
Received: from verein.lst.de ([213.95.11.211]:47359 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfBDIBj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Feb 2019 03:01:39 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CA08068D93; Mon,  4 Feb 2019 09:01:36 +0100 (CET)
Date:   Mon, 4 Feb 2019 09:01:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, martin.petersen@oracle.com, ooo@electrozaur.com
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] block: remove req->special
Message-ID: <20190204080136.GA5582@lst.de>
References: <20190201075557.9249-1-hch@lst.de> <20190201075557.9249-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201075557.9249-8-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

FYI, this needs the following fold, as Bart added another reference
to ->special past the branch point for my tree:

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 4fbb8310e268..a1e43e77ceef 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1171,8 +1171,6 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 	if (ret != BLK_STS_OK)
 		return ret;
 
-	WARN_ON_ONCE(cmd != rq->special);
-
 	if (!scsi_device_online(sdp) || sdp->changed) {
 		scmd_printk(KERN_ERR, cmd, "device offline or changed\n");
 		return BLK_STS_IOERR;
