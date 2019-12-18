Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F74FC2D0CD
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 19:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6263206D8
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 19:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VH2M7NWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfLRTl6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:41:58 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:52471 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfLRTl6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Dec 2019 14:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576698117; x=1608234117;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MRSADXocSc/kfAUoho20mkAi5Dil2MH3eklNcMW+xlY=;
  b=VH2M7NWJE0e05qS2fwV/aq8nBYNn0kVF2NsAFXWhcWxYD2gmCHQW42D4
   y1+TW4kvEt5vrwW25M1J+kbZFjt7pBuJQCKGLviP7HOyEytzUOjPERHcB
   67a4pFlBmGgTZMWuXmgUcPVwyOmaBX3HaxG+Bux9QfDpDXPYUFIhizFwn
   DhF5Z37BiPujOgNEc5/Xm7OxyRpkPZfSMdz+8rRy209ZW8j6B/1EW3EIi
   JPj3lz1DWj3PrvjUdKkdQib6lWUW7kgV3tHTAmSjlg3x334Xa84E71rDL
   H8wx1O1q3Oidh0Z/+yogTS0yHvmo2AY8SHj863wm4NABBKUlPm5tMyqem
   g==;
IronPort-SDR: aRYCtKEdjKlmQsGA5RMpPC2HI3jQ+gOKvj7di9CFkQLhzBMOiCIYwh0DW1UFuRP7JMqOiUpgny
 aH0YO/sEUzoIFeTr7DWmC6H5o3mIbXaaPCl7mPaKrjjnj79B7M/tpo8s+0MEGO8xi2dgVZwQiu
 Av+shHLev0D3sZ5SCM459aowdC5XXgkuOuKz9ZZ5rBCtNf4NnS4mETIhadnFrBf7rcuXyJHNsh
 hCrQECxnf5fZamTdfXKeP99meDdkcgeQXWYetabMKVyr9DbO5fskI9DK/0zVbGLT7JyPgw3QKb
 iwo=
X-IronPort-AV: E=Sophos;i="5.69,330,1571673600"; 
   d="scan'208";a="233280621"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2019 03:41:57 +0800
IronPort-SDR: d+MnCBYUzT8n6kJzurEnoPs3cPfpHx5saijs9ZSXUM5BMj4sXPcf6VU1Jwsn7IKcjoN6sE7hpx
 FztJv7/rMoCe7Yl6EKteyYr+GqIUcy85xTU8GOkHLgMLBPdVwoQHMuZyLekeDjhhXhLg6wjP4X
 9fCWCU4uQVVT6vUxLewLp7XPjn1gV84HpIaJO2PNHD7MevOG0Uc4QsQguaKx3wN8rQVHTP6/6Z
 AAliVgWnY6VPqjw28uzmuF/T3pTRAQGTNH960S/tTB1IT4bcszdnplMZP/OT8pIytbwZohbpDi
 Y+jFNAPZ85QYebo5AiOATd6D
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 11:36:20 -0800
IronPort-SDR: nxyciRb5vcCdfD/kwV8SawO4ogV+aR6/GpAzqWycE2vDaEHkR8dmagIOgKIxe6KSDaiQLh/WGu
 iDB5tGEPpdoMmMNc1rPLN2/JESDgVEx1LP4tDdt+MwYK/GLz7AvBBZHWhJJYQNpk8cW4zRLKVR
 nSmZhgcDWoQ8PvPfNePMYEtRqRiyUo+d402zV8jjfkxXqZuQhIqpw9qhSjQsIIjO0aMpQshTxJ
 eTpSUMVXQLV9sBRIcV2mQPz79/g0bWt6kE0LEQb58bQ33x8yyzUXhHCpUGL6XP2qlh7Tjc2iiV
 ucM=
WDCIronportException: Internal
Received: from dhcp-10-88-173-170.hgst.com ([10.88.173.170])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Dec 2019 11:41:56 -0800
From:   Dmitry Fomichev <dmitry.fomichev@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PATCH] block: streamline merge possibility checks
Date:   Wed, 18 Dec 2019 14:41:56 -0500
Message-Id: <20191218194156.29430-1-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Checks for data direction in attempt_merge() and blk_rq_merge_ok()
are redundant and will always succeed when the both I/O request
operations are equal. Therefore, remove them.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 block/blk-merge.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index d783bdc4559b..796451aed7d6 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -745,8 +745,7 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (req_op(req) != req_op(next))
 		return NULL;
 
-	if (rq_data_dir(req) != rq_data_dir(next)
-	    || req->rq_disk != next->rq_disk)
+	if (req->rq_disk != next->rq_disk)
 		return NULL;
 
 	if (req_op(req) == REQ_OP_WRITE_SAME &&
@@ -868,10 +867,6 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (req_op(rq) != bio_op(bio))
 		return false;
 
-	/* different data direction or already started, don't merge */
-	if (bio_data_dir(bio) != rq_data_dir(rq))
-		return false;
-
 	/* must be same device */
 	if (rq->rq_disk != bio->bi_disk)
 		return false;
-- 
2.21.0

