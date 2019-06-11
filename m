Return-Path: <SRS0=2dDp=UK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59687C46477
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 20:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F472063F
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 20:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qaVOytcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406376AbfFKUC3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jun 2019 16:02:29 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61749 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406413AbfFKUC3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jun 2019 16:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560283350; x=1591819350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xi7RDZ3LPqv+mzotThtUQvsKQ9oEmzNEqwsBGEsKs/I=;
  b=qaVOytcqM0PaXvJbohXutVBSwE+KnNQ8/c3m5ffm9xvdZ1DAls1tCzco
   m8zLSBFPKBjJpYJn+nVX3IV5mv/zIozIHYTqeiscI5/P7Cw+x+R5q3anS
   WqJq8+gOqjHH0Zm0O7pJZqAbAjWu6DhEzN2jlWfpNJ7Y0BLgPnOh7JCgp
   zdKOtvZmoxUGt0mVKi3S4mWw5g/cU3zrkD6XLXd0/rmB4dDvzCsJkrY9L
   c6XT7nrrP2WWN5uUer0fdk3uT0uoDTST+U5Lx0Cj39ox3YQ7PAAgDLRkc
   11NTU+hrSQrm0SCUyOQDuyYsKRocWgPaiJHof86sMgSTPa/1gT4Psa8QS
   g==;
X-IronPort-AV: E=Sophos;i="5.63,362,1557158400"; 
   d="scan'208";a="115255373"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2019 04:02:18 +0800
IronPort-SDR: zhmCi0fNbQi8iMZKfAOe0IleXouN8fmakNnyoFYm9VYp8kHzA8NrkUa2qgFyL+/o2G+47D2q9N
 YSRPFZ+f1DRD5MRgSVXCv9jmQ7WlwenVzvJ3W3fr8vVfPVsTmZHj3Q8IFCQysNJQ8q1hCbXiTR
 os3Na2ufvAkQIPs41nnsLcheLfp9AwljduIpZSMSBPxlfqbNrP1afaSb+P7Npvi3P1eUSdFVXJ
 MZz9SbLLPZPla6qirdSfYbDBqjVqZmOhxBVWScqOWN3hOnzZqCqydBvmbsnbEZQDMdZBpegAoo
 kfIyCqAybeLCnvh6T4rw02Ry
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 11 Jun 2019 12:39:26 -0700
IronPort-SDR: 0gtUBqb/+z2pzCRKG+6MUymMi83TN7iqOd4q7fff3bIUU1+thJ3WW+0OSEhB/t0kiCVgQdnlSS
 /oNV+7AJauJ+9hM873UggPDe9dQV+ZLv2GEKoerNHQ8T3El/bk5n9bVMfyrV/XUHqxxZi4vIGL
 dtJQn7tITwA8XsKH+Lmn71fwZybTOZcHraGjwZjg+NGh/W5zbTqsxz4Gu0g7i7+wBcagjQQ+q/
 DHihw3a2QpF9fM/h6B9ArGBveeG7YGbvP5PBSS5O83Es7xHDPiDYqopgnSKSB/E4SKKQTJnKIW
 JMw=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jun 2019 13:02:18 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, hare@suse.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/2] block: add more debug data to print_req_err
Date:   Tue, 11 Jun 2019 13:02:10 -0700
Message-Id: <20190611200210.4819-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190611200210.4819-1-chaitanya.kulkarni@wdc.com>
References: <20190611200210.4819-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds more debug data on the top of the existing
print_req_error() where we enhance the print message with the printing
request operations in string format and other request fields.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-core.c | 57 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d1a227cfb72e..659e5ea6f6c9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -167,6 +167,54 @@ int blk_status_to_errno(blk_status_t status)
 }
 EXPORT_SYMBOL_GPL(blk_status_to_errno);
 
+static inline const char *req_op_str(struct request *req)
+{
+       char *ret;
+
+       switch (req_op(req)) {
+       case REQ_OP_READ:
+               ret = "read";
+               break;
+       case REQ_OP_WRITE:
+               ret = "write";
+               break;
+       case REQ_OP_FLUSH:
+               ret = "flush";
+               break;
+       case REQ_OP_DISCARD:
+               ret = "discard";
+               break;
+       case REQ_OP_SECURE_ERASE:
+               ret = "secure_erase";
+               break;
+       case REQ_OP_ZONE_RESET:
+               ret = "zone_reset";
+               break;
+       case REQ_OP_WRITE_SAME:
+               ret = "write_same";
+               break;
+       case REQ_OP_WRITE_ZEROES:
+               ret = "write_zeroes";
+               break;
+       case REQ_OP_SCSI_IN:
+               ret = "scsi_in";
+               break;
+       case REQ_OP_SCSI_OUT:
+               ret = "scsi_out";
+               break;
+       case REQ_OP_DRV_IN:
+               ret = "drv_in";
+               break;
+       case REQ_OP_DRV_OUT:
+               ret = "drv_out";
+               break;
+       default:
+               ret = "unknown";
+       }
+
+       return ret;
+}
+
 static void print_req_error(struct request *req, blk_status_t status,
 		const char *caller)
 {
@@ -176,11 +224,14 @@ static void print_req_error(struct request *req, blk_status_t status,
 		return;
 
 	printk_ratelimited(KERN_ERR
-		"%s: %s error, dev %s, sector %llu op 0x%x flags 0x%x\n",
+		"%s: %s error, dev %s, sector %llu op 0x%x:(%s) flags 0x%x "
+		"phys_seg %u prio class %u\n",
 		caller, blk_errors[idx].name,
 		req->rq_disk ?  req->rq_disk->disk_name : "?",
-		blk_rq_pos(req), req_op(req),
-		req->cmd_flags & ~REQ_OP_MASK);
+		blk_rq_pos(req), req_op(req), req_op_str(req),
+		req->cmd_flags & ~REQ_OP_MASK,
+		req->nr_phys_segments,
+		IOPRIO_PRIO_CLASS(req->ioprio));
 }
 
 static void req_bio_endio(struct request *rq, struct bio *bio,
-- 
2.19.1

