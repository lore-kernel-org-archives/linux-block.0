Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E828FC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 18:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DC022360
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 18:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DC022360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeKOERt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:17:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:1260 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbeKOERt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 23:17:49 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 10:13:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,233,1539673200"; 
   d="scan'208";a="106254506"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 14 Nov 2018 10:13:33 -0800
Date:   Wed, 14 Nov 2018 11:10:07 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/3] scsi: Do not rely on blk-mq for double completions
Message-ID: <20181114181007.GD11416@localhost.localdomain>
References: <20181114162601.11477-1-keith.busch@intel.com>
 <20181114162601.11477-2-keith.busch@intel.com>
 <1542217896.100259.2.camel@acm.org>
 <20181114180018.GC11416@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114180018.GC11416@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 11:00:18AM -0700, Keith Busch wrote:
> On Wed, Nov 14, 2018 at 09:51:36AM -0800, Bart Van Assche wrote:
> > Regarding this patch: I think this patch introduces a subtle but severe bug
> > in the SCSI core, namely that if an abort is processed concurrently with
> > request completion with "fake timeout" enabled that the abort is ignored.
> 
> That requires the following occur concurrently:
> 
>   1. A real completion
>   2. A real timeout
>   3. A fake timeout
> 
> That can't happen on a production kernel, and highly improbable
> on the fake one. We can still fix it by having scsi timeout return
> BLK_EH_RESET_TIMER in this case. I didn't like adding code just to work
> around error injection, but there isn't a good alternative at the moment.

So do this instead:

--8<---
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index ff372b335ced..d343024e732a 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -199,9 +199,6 @@ scsi_abort_command(struct scsi_cmnd *scmd)
 		return FAILED;
 	}
 
-	if (test_and_set_bit(__SCMD_COMPLETE, &scmd->flags))
-		return SUCCESS;
-
 	spin_lock_irqsave(shost->host_lock, flags);
 	if (shost->eh_deadline != -1 && !shost->last_reset)
 		shost->last_reset = jiffies;
@@ -299,6 +296,8 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
 		rtn = host->hostt->eh_timed_out(scmd);
 
 	if (rtn == BLK_EH_DONE) {
+		if (test_and_set_bit(__SCMD_COMPLETE, &scmd->flags))
+			return BLK_EH_RESET_TIMER;
 		if (scsi_abort_command(scmd) != SUCCESS) {
 			set_host_byte(scmd, DID_TIME_OUT);
 			scsi_eh_scmd_add(scmd);
-->8---
