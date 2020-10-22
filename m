Return-Path: <SRS0=SOzO=D5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C6EC2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 01:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C2BB2245D
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 01:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FOcXEKAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442682AbgJVBDE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Oct 2020 21:03:04 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3948 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440469AbgJVBDD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Oct 2020 21:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603328584; x=1634864584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6NOKkrJ+dd5+a5TidOKmE++eASzCFtwy/mCMZlmbUoE=;
  b=FOcXEKAiY9v1S+da3S+HBcth2/D5IyrkyMJRy/OT4s/G7B81L7+GRlWF
   GT0SWDw6IvaYufW9mHnml1oM9c2y7XfCAk1/xFvDMy18NJ/7a+p1RGL5k
   uyA9tpWFa9JwUjprjAFZpEhMIb4Ruszi+bmYHYY/WBo/WmGevKrjAl1rl
   9KzxBVCC5LkozPpx3/Tz/gTA11FIXAH/NLqhReQmf5gcksjP3stf3774d
   ToykfnwyLfgk/+8YmBTLm9+VnlC5LKpCfTnWZIwHOyC98UBgUpp6JF6ag
   ghyWenc+sxDKQ+bIn1Gqxn7wBLvaVyinMPUrIuqbbA3AqMfGJ6ejBWHOH
   Q==;
IronPort-SDR: SVEV77F8bdccisV4IWwdGBDsQKvCTuJSOheezw33PvRkpao+qjuWBXSV7tX0oNivUCvp0ISx7e
 Q2Phd84Tf6T31yDxwR6TumDNCZ+DokpeXSM0Loa0+3xfV1BNcMQu0ahHTtoqbAPbg0bc9s2A7Z
 HaKH5PhFvd+O/h46DQjph2SSsBLywYwdZ0m1SGDcGefVBOuGhkaFtNbgO5QIPlIZ5e3Hd1X5Ad
 HB4HoogAKAuBPFxyVdeSmDszHcc+90OnLP6Ok5hvdihVJueNy1hcwAD+OVOe8gkR+oZUzs1owz
 vvw=
X-IronPort-AV: E=Sophos;i="5.77,402,1596470400"; 
   d="scan'208";a="155006319"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 09:03:04 +0800
IronPort-SDR: uFMhofvZ94iuLX5Em8b1g6OFyuEgwr2ErcgDzwnlzTsOgOd2n4KkVO9dxbaZCc1y9AezPeJPXc
 SiAA6czsRmPnfaIiMwxrh9QnXpmtRff4iwgtrCS4AQoX/VeMqK6Ggk33W9yZpP2AUpIVhcyOIG
 unhXoSpnpECZCpVsGGooJMsKuzM0AIszHGvRyCoYS+6T3mny1cAoBbestW13EXLlRnI3/tXlpE
 GxkYBltnqUvWk2uTzWIdrYb6ypuTpkbF2wdyxHi6Ibb9zuSbKIEdG/m1MDOtQAHeaV1wuQ3u92
 kd8M0yW9khpkhwOjpiTVWnzL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 17:49:27 -0700
IronPort-SDR: trAgIIh25ehnatCW/4qXNGzjgAUmq7TkPPX5YoqIxeABlzFSK8Lurn3uEl9xrpoWUeXJtzmRL6
 rkK2N9Nb4hr3tsmhLsLjLKqxlJ3houHQXF98mlFOffbun2PiB01b+jGIPKp+8sBlJvA/hGw7sE
 ppy28nYBsLIjIKDSMqC94PetTxQaroySA6TYun954j+dwZCnqJsdlHwxMW/oRCyWntAY6cmrKi
 7kmAh8KOe4u0CBO4DyDfSalCewJZ7WabArjn8PipsQaTD4C4yfjsknqH2iF7p+wKaILeabmXAj
 MZc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Oct 2020 18:03:03 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
        logang@deltatee.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 3/6] nvmet: remove op_flags for passthru commands
Date:   Wed, 21 Oct 2020 18:02:31 -0700
Message-Id: <20201022010234.8304-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For passthru commands setting op_flags has no meaning. Remove the code
that sets the op flags in nvmet_passthru_map_sg().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 76affbc3bd9a..e5b5657bcce2 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -182,18 +182,12 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 {
 	int sg_cnt = req->sg_cnt;
 	struct scatterlist *sg;
-	int op_flags = 0;
 	struct bio *bio;
 	int i, ret;
 
-	if (req->cmd->common.opcode == nvme_cmd_flush)
-		op_flags = REQ_FUA;
-	else if (nvme_is_write(req->cmd))
-		op_flags = REQ_SYNC | REQ_IDLE;
-
 	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
 	bio->bi_end_io = bio_put;
-	bio->bi_opf = req_op(rq) | op_flags;
+	bio->bi_opf = req_op(rq);
 
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		if (bio_add_pc_page(rq->q, bio, sg_page(sg), sg->length,
-- 
2.22.1

