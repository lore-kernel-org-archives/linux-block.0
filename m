Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F97CC433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 11:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350818AbiDSLD0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 07:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349185AbiDSLDZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 07:03:25 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57451FA4E
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 04:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650366041; x=1681902041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nuvLET3FkxQ2IhEHfvY2HsBqxfN20BNRsXCgeBTTX/g=;
  b=QhgF0RB3ZEMtUl447eYnWIOWItiICz4wa1wBXOF8Daa1a9Z8duoXLQNv
   8FKut47jTs9i2cOKmb6PFSNPw2E6yIdBceIHakyBmZvAaFiCr2scD7rXK
   QsWpK//Fppcq/sfMzvG5Qt96WSDxN1eXvJyy78ZhvoNVHkNbJHf9cLc4G
   l3fa8TpNBLeJK6/l/cOM2XxLzepWdecl1nGGnq4T1IEEtmaFyJBZqwlI5
   sKQldAdlwqjy9YFOlygCofkVvMnyn4RybPYfv7Y8Hq7V/OjQ6SW8J8vXW
   95KtsXtozlm1kOpsH6NXHcl3t2wP7bvhbD+MXkUKH3T/FAlK5F8ORYcgP
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643644800"; 
   d="scan'208";a="198252952"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2022 19:00:41 +0800
IronPort-SDR: 7mPXfHE/dPx+vw1HO4+q3rx/1X6hH2iAsv3HrIFQ6X6WcC6p84WvzaYlUW4ihnoTHxpm5/mVz+
 ANJvnI+DeJvRvT0qvgNnch8GXMEEWp2GnSYU/rBwS/HBY0pybHCFGdh+ykBiW75VECaWp0MBDY
 wbQM7OSbehIz1zNGmq031IKRirOL/JfL07LVTwovsztjQNmJ4JY4he6MYHd1n1ETO+yW94e9qT
 R/7ck0bi8xPzbMEKKUhItGxtIKLI1LsqtFL8ys/a+uCwt1U3cogQXFbM9ShcNgXcgzg+qnbTNi
 WNWEclUJbxdI+jCBcv0OpNJP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 03:31:47 -0700
IronPort-SDR: Xo9D5E5Wy6g0OI5mQ5xcLa3HYsrk4d7ekGNsAUnyKZ6ZEAo/XrrqX1BHwUT0/mNxn5LSNUN6Ws
 RxRf6JlR6ncp1k2sdfFMkDEn7mFDhrhpckdEz5uLQ6sU1hdL43xQjXQojGZZMJrt6hvMI7OhfU
 QOSMl7ADoyuh+hRBww22QhpVS6CC+gjRK4bNn96FoEloilon+esgI98kgJgKJ+zJL4T2qx4CYu
 yhcMnDpn1kRCRtELRXYjjMz9TnRtNOPVjgmNU4NBchgVDuVKjZB4xKQR+Usw1XsoLpOnwP6d9e
 lvU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 04:00:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KjLST6fGFz1SHwl
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 04:00:41 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650366041; x=1652958042; bh=nuvLET3FkxQ2IhEHfv
        Y2HsBqxfN20BNRsXCgeBTTX/g=; b=R/im/0bZoTufQPi2wYWuv6X1CyQzRiKBNR
        HcWSJdWI/DGnInSMbxvojCE++MtqeyWf8pBZA0D5InNbdD2NMl6UGnwKybkcvKol
        Ar7WbQFB+8YISYLHWS9ZiiqSjLc9h/JQwhzzzOiRGGjlNlAy/ph2EALc8xtpjElF
        F9atDve6gcZh9Wod6fcgi/D2zQVQ+ES1kqAGR0U/V3eXM7yNtC0txwDczJdK94iW
        6c3DDKAHLh5gkR9OP7u4K8fw/L7t4sBMH6qEJAxTo58sLbFsIGlpqpyrRl4adh3y
        SWBJ2eDZfsXlYKSQJq1nKKjvr9w5FuohjsbEhFchLbCq7zu3EmYA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Gmp0GxyN6oUy for <linux-block@vger.kernel.org>;
        Tue, 19 Apr 2022 04:00:41 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KjLSS6zTsz1Rwrw;
        Tue, 19 Apr 2022 04:00:40 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 1/4] block: null_blk: Fix code style issues
Date:   Tue, 19 Apr 2022 20:00:35 +0900
Message-Id: <20220419110038.3728406-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419110038.3728406-1-damien.lemoal@opensource.wdc.com>
References: <20220419110038.3728406-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix message grammar and code style issues (brackets and indentation) in
null_init().

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/block/null_blk/main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index c441a4972064..1aa4897685f6 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2113,19 +2113,21 @@ static int __init null_init(void)
 	}
=20
 	if (g_queue_mode =3D=3D NULL_Q_RQ) {
-		pr_err("legacy IO path no longer available\n");
+		pr_err("legacy IO path is no longer available\n");
 		return -EINVAL;
 	}
+
 	if (g_queue_mode =3D=3D NULL_Q_MQ && g_use_per_node_hctx) {
 		if (g_submit_queues !=3D nr_online_nodes) {
 			pr_warn("submit_queues param is set to %u.\n",
-							nr_online_nodes);
+				nr_online_nodes);
 			g_submit_queues =3D nr_online_nodes;
 		}
-	} else if (g_submit_queues > nr_cpu_ids)
+	} else if (g_submit_queues > nr_cpu_ids) {
 		g_submit_queues =3D nr_cpu_ids;
-	else if (g_submit_queues <=3D 0)
+	} else if (g_submit_queues <=3D 0) {
 		g_submit_queues =3D 1;
+	}
=20
 	if (g_queue_mode =3D=3D NULL_Q_MQ && shared_tags) {
 		ret =3D null_init_tag_set(NULL, &tag_set);
--=20
2.35.1

