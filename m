Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:48122 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750788AbdALSSh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2017 13:18:37 -0500
Date: Thu, 12 Jan 2017 19:18:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dexuan Cui <decui@microsoft.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        "Chris Valean (Cloudbase Solutions SRL)" <v-chvale@microsoft.com>
Subject: Re: [Regression] fstrim hangs on Hyper-V: caused by "block:
        improve handling of the magic discard payload"
Message-ID: <20170112181834.GA8808@lst.de>
References: <MWHPR03MB26693D8327D27CA1CFDA50A8BF790@MWHPR03MB2669.namprd03.prod.outlook.com> <20170112134412.GB15178@lst.de> <MWHPR03MB26695378D0512A7C840A0A30BF790@MWHPR03MB2669.namprd03.prod.outlook.com> <20170112155241.GA18147@lst.de> <MWHPR03MB26694FAE82E6D0FAEA02BE04BF790@MWHPR03MB2669.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <MWHPR03MB26694FAE82E6D0FAEA02BE04BF790@MWHPR03MB2669.namprd03.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Next try:  (I've also dropped most of the Cc list)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index c35b6de..2f358f7 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1018,7 +1018,10 @@ static int scsi_init_sgtable(struct request *req, struct scsi_data_buffer *sdb)
 	count = blk_rq_map_sg(req->q, req, sdb->table.sgl);
 	BUG_ON(count > sdb->table.nents);
 	sdb->table.nents = count;
-	sdb->length = blk_rq_bytes(req);
+	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
+		sdb->length = req->special_vec.bv_len;
+	else
+		sdb->length = blk_rq_bytes(req);
 	return BLKPREP_OK;
 }

