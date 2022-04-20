Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377D0C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 00:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348110AbiDTBAM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 21:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348108AbiDTBAI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 21:00:08 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02EB13CEA
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 17:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650416244; x=1681952244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nuvLET3FkxQ2IhEHfvY2HsBqxfN20BNRsXCgeBTTX/g=;
  b=cVpbD6YH7G6cB7WHlLAxyQj+c04cDbsiVmjVsBXW/OjoiSgOo70bFB/x
   XSGn/P8w55H395I/BoVvIyh1G9zQoSy1BSB6Q9kUBZjg/7HOdU5lOQSRe
   wpDRY3isliwhLWmZ5Hvtal43xEGfEyQInhmpcl3Yp3RG5xdh0HL1s19Hj
   Xayd3xE26Fulw1jK9NWzc9Oxm7KRQBQwSK0oELDX3p10k/VeOX1FzKpfy
   NPZ6memS/LGrBmweDNNMVUQ/hpC774B13/d6gf63nY0yVBGtHUxUuRQfp
   ljrYfy8Xo7GDWtPZRschrBZLEdRMymGvgHAx4y2snGjM7wjyGgTin4FlZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643644800"; 
   d="scan'208";a="302507267"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 08:57:23 +0800
IronPort-SDR: PNkcZfHOurDGJko3a4Y2jy/MRjKt2YjVnpASFYrzOA9vK+zaB8mxOyoiYfw+UI1j4MhW9OyTLj
 UhlIhyrxzeY4BNnZ6D+9Y6SSt1M5rgDeZ7lfppdUehjTxB58x9XeZWSZuTT8lMoGj4eL21fxR3
 kUknLT7WKhCGl+VDxizul1zUkn/a800naFjdIuRNRtp1dPBUFkUNEBxKiJ+9ZCv/eEjhTswZVW
 GisszcWGqD41NIAO2PPIl21aRytertV5pm+NU2Bw8zIZgvGlK5I6ELECstNjgLrmGaynjfA5Hc
 1xfpCa+Qfip5SNK7gQMFbNoo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 17:27:41 -0700
IronPort-SDR: DiESS+jYYJ0JeYzKhs91GfD4Jh2xhVuWGahpkv3FMKycP/gsri3HqQwH8aq1uCfqvSZ1aTW9bg
 5mP9ymbFFI4PE4cSBKcceU6t33F4LEwGIzI/uM+OzeS1cppYuW+GJvm0T6TlfJhmjTxMedWSNI
 IONMjhaW0Vt2Fj7YrVgdK2C6+Whm/M4COziwFTKnlqXZqS70CagPxseugezReV6HOGHBMrXcgX
 IgiXX5/pRmSnIahiAEiXYOnkD0CAB1khuR3W4FVhbGRYNjJ+hJ5Lohw6adAWnLR9S+pnlO4qDo
 Td4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 17:57:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kjj1t0yxQz1SHwl
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 17:57:22 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650416241; x=1653008242; bh=nuvLET3FkxQ2IhEHfv
        Y2HsBqxfN20BNRsXCgeBTTX/g=; b=Mi3xm1m1+XNlMT/kpVJM8REw6hKfkGZ+TS
        kn4cvYXN9IwQKibxrEHatuid7kl4VjVHeeDqXbxmgtnAisxbrgkO8w67l0VxnAcI
        qvlHVuQZ2+FuJ7XO1aMLM5ZyxKsJF81gOPu+Ly9x05dEnOjwpB71hN2nldKFsrMi
        y/xjiNi9GeaSBb9Mgtzn7upPSx1BSo6pj1fkjrAFAa6hZpSzp7jHl5mGqEpO01na
        fbTmV3JB17pDRMub/GMnUnZLKL747gnJqIh/KmtHPNentAHHSkLNVlMU2G/ac6UF
        XW5RD4F4efH70EqLUhIQcIqXkO/4J/9xURiNzZ7wc5dykmnZ2nRw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VmSHTHYxf6Hx for <linux-block@vger.kernel.org>;
        Tue, 19 Apr 2022 17:57:21 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kjj1s1YtCz1Rwrw;
        Tue, 19 Apr 2022 17:57:21 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 1/4] block: null_blk: Fix code style issues
Date:   Wed, 20 Apr 2022 09:57:15 +0900
Message-Id: <20220420005718.3780004-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420005718.3780004-1-damien.lemoal@opensource.wdc.com>
References: <20220420005718.3780004-1-damien.lemoal@opensource.wdc.com>
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

