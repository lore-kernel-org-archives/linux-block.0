Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AAAC282C5
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 19:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7815218A4
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 19:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="q96RkxIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfAWTHC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:07:02 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:43947 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAWTHB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 14:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references:
        content-type; bh=zGBoi2BdGBf+q5QFsCXqHbwkyVm+eQEgHz6IZr95UdU=; b=q96RkxIlVEbp
        d9zmrPnBW1BieTIU/xb4MnKfm2fKS1OvgkMSRUMDU+/kWOyInCDOltKvYq2AjGIWlE4vRjwBEN37u
        1w0vetSOLTIPAXt9aDdTNv998dgaXeeWMTIp2B4XH4eb/sCBYqXm25ZY+AdrYcMzSSqQwjyXHSCo5
        FVLLqx5Ve/A5vrKPAhEpLR7hZQwbuLaisUO2U517lhoSdij5H6C57ej5+VWkS3clphDdT/zb+WGYc
        P6YsKBVS2ouwzyYAGc5dEUVKbsKyseAV/83DOFkLApGlqumooabCdpLYTlvAbp9kbOISY4tU3KRXq
        Q7ZBVAglKr5zePOJnO/DAA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gmNrU-000GmL-8e; Wed, 23 Jan 2019 20:06:57 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 99BE9C04F3;
        Wed, 23 Jan 2019 20:06:51 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>, stable@vger.kernel.org
Subject: [PATCH] block: Allocate a sense buffer before executing an SG_IO ioctl
Date:   Wed, 23 Jan 2019 11:06:45 -0800
Message-Id: <20190123190645.119109-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5jBBhj3QuPcpb7OIbtfeCCN602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTZnx3upumnqWBHj0/Vmi/pASQQA8gPlICyOXF4VQA3r6+yO
 hb5GDj0rq8D+3HFJ06Dxr7qaG4fgWdY0QrMiiTmeEsYH1VdEQAg7/rFOVUeDY4lE4xwlSMNZQReC
 h1BkhStCI0sP8PXhzyXWNgtd9W19U2Itm39BdCc4FEP6OrUewuKGjyi7NM5g6YGRfdiuXTYIQZqZ
 9VYloGcRwm9W9EtxWPpqCCxJU9sH3xNqsUWci1prjQPFk8m4tSTfORUp3ykGtwKY6DS+SpoDJebm
 bap+qGwJH8+A52d1poZINYoW99CtCjn6wSDHBAe9zIDaRfTo0okJaE8GqrQcOA/I5j6z9mwSGfNa
 BmafifTJSMMwOH75IHefrt4A8X/Xytq/2cHcjNWYY9Jhwjc/H4SLVZROH9u8bwQR7T6cYAlUQy2v
 pH/S0BGIotuwG/h4FqtFRE2MG2TrPI0uYbltEzJRYsaYNJ05OyK3hsmXlyQ83MBQoPoF/LVPc/Cx
 SizXI1h1M4bXs2KsRjKrCowEavDwQuKoVIcDffLkxvcfI+KUnpkRls2wWVbjHO/cpJpsYlvFhM/0
 vUSheL4IP23ih1QwO5emrgO3SBMQr286U6+kVdeM7K5yPvfmYVwWqhzjLKy9AzwBIkUL/j1Y48Gv
 meURQjjEigLJfUn2YhIEq0qIgb2uxWGymWOQ6GmPPB2ZFS7FQCSXeU0W7Wk+l9kSYUIeo2CS0yql
 Bj/BN1Kf8qaZE9B7VaeCha546VKR9Cus1DRhpW4oXTPAaDGIflVilPXvhw3wW/EN6OpzWBK8DZjE
 JE5wwrYGZHEZAp6DM6bNcPGZcloM9z6tS4iwTBUn4FkxffbCsP/VvZgGcn3fjjsvBa/USealyRw8
 zZuICixnSYIxpl5RXxKF5tPxTxfD0dMN+t5ZFhg8M66H5BiebDMNYM77qwrV1mIdF3Y2e6E0KNH/
 yiv/kFDrhXPeQ9e6PkFg/mKhUL8tt0mV0nzGe0cxxh9Zdl/R0Vlf0U/hJ2/TL4CJHf+Csej0Ge2Y
 HMPq2mzarJ4w7sn//RcLEIwmfxtejjVQPacnfdMobUFB5up0C3YLKidsRpS+COLZt6YIV2rpZU+S
 12mXijXelyhSNIFEAETxJw==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some time ago blk_execute_rq() was modified such that it no longer
allocates a sense buffer. Make sg_io() allocate and use a sense buffer.
This patch avoids that the following bug is triggered when running the
libiscsi tests against the scsi_debug driver:

usercopy: Kernel memory exposure attempt detected from null address (offset 0, size 18)!
------------[ cut here ]------------
kernel BUG at mm/usercopy.c:102!
CPU: 5 PID: 693 Comm: iscsi-test-cu Not tainted 5.0.0-rc3-dbg+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
RIP: 0010:usercopy_abort+0x7a/0x7c
Call Trace:
 __check_object_size.cold.1+0x37/0x3d
 sg_io+0x5a2/0x700
 scsi_cmd_ioctl+0x4d4/0x540
 scsi_cmd_blk_ioctl+0x7b/0x8b
 sd_ioctl+0xba/0x150
 blkdev_ioctl+0x6e1/0xea0
 block_ioctl+0x79/0x90
 do_vfs_ioctl+0x12b/0x9b0
 ksys_ioctl+0x41/0x80
 __x64_sys_ioctl+0x43/0x50
 do_syscall_64+0x71/0x210
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Cc: <stable@vger.kernel.org> # v4.11+
Fixes: 82ed4db499b8 ("block: split scsi_request out of struct request")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/scsi_ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 533f4aee8567..066929ec0d61 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -299,6 +299,7 @@ static int sg_io(struct request_queue *q, struct gendisk *bd_disk,
 	struct request *rq;
 	struct scsi_request *req;
 	struct bio *bio;
+	u8 sense[SCSI_SENSE_BUFFERSIZE];
 
 	if (hdr->interface_id != 'S')
 		return -EINVAL;
@@ -361,6 +362,7 @@ static int sg_io(struct request_queue *q, struct gendisk *bd_disk,
 
 	bio = rq->bio;
 	req->retries = 0;
+	req->sense = sense;
 
 	start_time = jiffies;
 
-- 
2.20.1.321.g9e740568ce-goog

