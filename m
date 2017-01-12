Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:46990 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750829AbdALPxJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2017 10:53:09 -0500
Date: Thu, 12 Jan 2017 16:52:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dexuan Cui <decui@microsoft.com>
Cc: Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        "Chris Valean (Cloudbase Solutions SRL)" <v-chvale@microsoft.com>
Subject: Re: [Regression] fstrim hangs on Hyper-V: caused by "block:
        improve handling of the magic discard payload"
Message-ID: <20170112155241.GA18147@lst.de>
References: <MWHPR03MB26693D8327D27CA1CFDA50A8BF790@MWHPR03MB2669.namprd03.prod.outlook.com> <20170112134412.GB15178@lst.de> <MWHPR03MB26695378D0512A7C840A0A30BF790@MWHPR03MB2669.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <MWHPR03MB26695378D0512A7C840A0A30BF790@MWHPR03MB2669.namprd03.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Can you check if this debug printk triggers for the discard commands?

---
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 888e16e..7ab7d08 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1031,6 +1031,10 @@ static void storvsc_command_completion(struct storvsc_cmd_request *cmd_request,
 			data_transfer_length = 0;
 	}
 
+	if (cmd_request->payload->range.len != data_transfer_length)
+		printk_ratelimited("request len: %u, transfer len: %u\n",
+			cmd_request->payload->range.len,
+			data_transfer_length);
 	scsi_set_resid(scmnd,
 		cmd_request->payload->range.len - data_transfer_length);
 
