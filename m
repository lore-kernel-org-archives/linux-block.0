Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD3AC4741F
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7601D206C0
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Pdkw+uze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgKJCYa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 21:24:30 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:31468 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729777AbgKJCYa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Nov 2020 21:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604975069; x=1636511069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XoQ22JwDeYI/Y/DWLZcgR5ylbUQpu3lntdI38exCX0U=;
  b=Pdkw+uze9l5FFYGMtLUl25j833/76Fj35rIGeBSapIexxTY0GdOnia8e
   tP/8skVq+5T4SbgtNOZX0CqMgH0oQjHDqY3AmznzGftzmdr437cxHMVvs
   UEitbczqGy4Mg6mkVj0wzFQsy7WCe4HGo/DqmBDhiSMPhGByrs3KVgzM7
   rD2J8jjYZ/loAqibUFKADkVoCYTeD6958eYLrUha9YxBfrcOVMEBBJe4k
   mEkeBQqAJAunCaxpgmR0H6osArlYr7+tbnHQZ37InAkjxTpPLFpVG8Yfy
   NertsAMm0d4DIxCNTH/wBGrX6QOYanoTEAspU36PU++18rKxqoAeLelMv
   A==;
IronPort-SDR: TEPiBkTuI89GnmtuLgWcXx/KkbH1T6uTLswULUHqNpaROqslISqXFP5tHnHParvM+3f0UhTtvO
 QHaz5c1aYRrHzNQWtm44XQFtEHZSEvjGAWbgcix7Ee9fccycplyl5668MPfK5pghonsSo9lStE
 6ej4bMQTjSng0n6zzjGvWay+ebBDm2IZkZdJGFnNT7pkpL0rdSFFyHl8h134r+BZ77AN77OOEv
 XszW9YgWw4MSirCiHovcaaoWuIf7JU7X0NYmrUdmIYN1y4ezIAJDWRvU/cyoWofy+Cc57Uo8v7
 MgQ=
X-IronPort-AV: E=Sophos;i="5.77,465,1596470400"; 
   d="scan'208";a="152138846"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 10:24:29 +0800
IronPort-SDR: /dcTPkIfbjLwLPpt6chfaR0k7Vz4XPlpCrciXkBFiPW8GmUGYo70NrkNHh4EM4M/t6erkHhpEo
 rdQ1V06f0hhbAFeW4zfgZfhI2LE608RJ01jb4SR/SWRZieA76HNJJDvlS5sn2ZKCj/6jl35e5Z
 kpyM6NWdc2n9i+J9V15HmEt7DDNMa9t2c0OF3Z4pthiokxXB3FyjmMuwByGwmkT0OLZfzwM36P
 N3FnY1G9QI+iP/k2dVXhs7rfMbUKCEpRyo5ybZoRXcT2u0g+/MK6W8L/sghNj9JWsOCrH72tQJ
 A5uLnOWiaVlGdhf0OS5d2H0J
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 18:10:30 -0800
IronPort-SDR: k/oTFRZ0M7LN/uh6B+sFf+F/T1+gy4L387SrYXmBm4vrxBZpsmbuOqaJ9OUzv/pUXW0lHaU4kR
 tABtCSeGGpcIFJ6qPqjA9azj5fbbvhDnaWJuvY5TZPbMfgCJq3o76qftchjAnZVqQG42K0se1R
 8eObAWZkcetWaWrLnrPgQOLx777z278+yJDFiRP+RabwQtHwODhp7Q/DDlHTeoh9tbMAkeiDoV
 K51A74o6H6ZRCzcFZZ2GS2n7gad1CUU0kWtmxZwkhITqXWKRQ/Ycn2eumRd9YcxFgcjtHrAyWD
 YQ0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 18:24:28 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH V4 3/6] nvmet: remove op_flags for passthru commands
Date:   Mon,  9 Nov 2020 18:24:02 -0800
Message-Id: <20201110022405.6707-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
References: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For passthru commands setting op_flags has no meaning. Remove the code
that sets the op flags in nvmet_passthru_map_sg().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/passthru.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index be8ae59dcb71..1c84dadfb38f 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -188,21 +188,15 @@ static void nvmet_passthru_req_done(struct request *rq,
 static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 {
 	struct scatterlist *sg;
-	int op_flags = 0;
 	struct bio *bio;
 	int i, ret;
 
 	if (req->sg_cnt > BIO_MAX_PAGES)
 		return -EINVAL;
 
-	if (req->cmd->common.opcode == nvme_cmd_flush)
-		op_flags = REQ_FUA;
-	else if (nvme_is_write(req->cmd))
-		op_flags = REQ_SYNC | REQ_IDLE;
-
 	bio = bio_alloc(GFP_KERNEL, req->sg_cnt);
 	bio->bi_end_io = bio_put;
-	bio->bi_opf = req_op(rq) | op_flags;
+	bio->bi_opf = req_op(rq);
 
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		if (bio_add_pc_page(rq->q, bio, sg_page(sg), sg->length,
-- 
2.22.1

