Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C74C433FE
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 00:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbiDTBAJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 21:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbiDTBAH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 21:00:07 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D98E13D01
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 17:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650416242; x=1681952242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RZlj07dLeyil7KbTI710dFh/tAqPF60wAmdflvFXwJw=;
  b=Y9gl06TVmZK2uLq51NoA31ofWfemHTNV1Bc0rUzNsBpHKX42kM8JKITZ
   RjItLtxw3ni/VgGsUUlrsowxQIXQtCIFY3Wmhyyag35fL7KLwhD62q4qn
   ZIBMyBtg2YgqEOGs1J+aVRQDupHbMEOdPu/jsQ6lHsuJld7opTX+C/AXb
   9lqe49eOMowWxE1wx5Q6NqEKFqjwyIdrbqmxKmYwsqxjIMTMbF2YymM6n
   gprGZ4ZXBvE3qSGUfnl8GZWmQllT2m4YJ7vU1bfAo4/zubcF/87oWU/GO
   vkeIk5h8joip8xLxrcshOAzUXoIfqzC4gRdzqKQBVguEGIO2A6FQMUWch
   w==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643644800"; 
   d="scan'208";a="198310332"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 08:57:22 +0800
IronPort-SDR: 37TSn9WA9A+dQf3rgvndPZbs4FDgV2POp7yULELoYnGpGy2L/7SMoctpd8wdhemyvxHnBULHuA
 0TV0ld894BBxfrONAuQ96VpOe2mM63scAPdwzVLrDTtH9T9F6k53OaLnTNw2/Iiibc8ranh60K
 2x+eeKP/ejIkV+z0REaZJaFoEbQbTIEjccjjtQd0f8g8ALYm081/YuS+rWpZ0rmGga0AQgwUFv
 xyUMLTZWTxwaiGKzZvOJ9UsUU4NxOu742m5i/u7IebB/F4eLqlwacTu7iQiGW1zpFZ9mmn8JLJ
 BI3eMlMXGdOr3bsuU1nJT4sr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 17:27:41 -0700
IronPort-SDR: 25JjB3Z4Nbb+N1dCACgeWIcSW9jm4GW/Tp5kiL5COsVOREjv+B1bTKwrCqq2K1Or8oBWDk++qm
 wto/wtkdzIjk+qZN/WZj9Gq/JdzEC6vOCP3crMfN/9veRZrS8OynErxBZmnT799LW5QlBkARjT
 B06j0xcdKp/xaeGx/1A6ZLWrGXPnkcXDDOm+DDYrF5IDew6v//KXwR5ZhyM/5GYXHajM16vXhd
 Cx5l/VHu+XknKqEbnWiVdTqszp3wQVPmRnGASyLCdR7mAiRKIId03yVPMfYtaJk/fRwa2PXqxQ
 HVM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 17:57:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kjj1v03lzz1SHwl
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 17:57:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650416242; x=1653008243; bh=RZlj07dLeyil7KbTI7
        10dFh/tAqPF60wAmdflvFXwJw=; b=HgixLoIMszocxMU6LJ+RIe7PqOC3kwCzF/
        WrgKTBFPxzNBv3VroLlOoeySthk2QkrtDwzHHH4TohfckBcOz/fhwzGlaGndbGBk
        IQKO0UTiRBl2Tv5yVK51v+Iger2iK5QcuiWbyIRQEDbJXQE49IXYAb/kbFzclMIP
        nxCknW/Ku9uczk0ePD9+/SukQ9iuqTrBLCDE305YP92pJx89AkZhz779u8o+sykM
        wjc3W0Gi6TwqTq+BmdflEPDQyxCrEY2Q995fmT6oM9jrOe3J0cguqjx8g+ypdLLP
        vNBWa5jKsDCYTbZPMHINH0JI0agqaQsYVkIQIBMKdJLbTc3zA7Vw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CFa0vhDLkebR for <linux-block@vger.kernel.org>;
        Tue, 19 Apr 2022 17:57:22 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kjj1t0j3Jz1Rvlx;
        Tue, 19 Apr 2022 17:57:21 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 2/4] block: null_blk: Cleanup device creation and deletion
Date:   Wed, 20 Apr 2022 09:57:16 +0900
Message-Id: <20220420005718.3780004-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420005718.3780004-1-damien.lemoal@opensource.wdc.com>
References: <20220420005718.3780004-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce the null_create_dev() and null_destroy_dev() helper functions
to respectivel create nullb devices on modprobe and destroy them on
rmmod. The null_destroy_dev() helper avoids duplicated code in the
null_init() and null_exit() functions for deleting devices.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/block/null_blk/main.c | 48 ++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index 1aa4897685f6..4d6bc94086da 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2088,12 +2088,37 @@ static int null_add_dev(struct nullb_device *dev)
 	return rv;
 }
=20
+static int null_create_dev(void)
+{
+	struct nullb_device *dev;
+	int ret;
+
+	dev =3D null_alloc_dev();
+	if (!dev)
+		return -ENOMEM;
+
+	ret =3D null_add_dev(dev);
+	if (ret) {
+		null_free_dev(dev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void null_destroy_dev(struct nullb *nullb)
+{
+	struct nullb_device *dev =3D nullb->dev;
+
+	null_del_dev(nullb);
+	null_free_dev(dev);
+}
+
 static int __init null_init(void)
 {
 	int ret =3D 0;
 	unsigned int i;
 	struct nullb *nullb;
-	struct nullb_device *dev;
=20
 	if (g_bs > PAGE_SIZE) {
 		pr_warn("invalid block size\n");
@@ -2151,16 +2176,9 @@ static int __init null_init(void)
 	}
=20
 	for (i =3D 0; i < nr_devices; i++) {
-		dev =3D null_alloc_dev();
-		if (!dev) {
-			ret =3D -ENOMEM;
-			goto err_dev;
-		}
-		ret =3D null_add_dev(dev);
-		if (ret) {
-			null_free_dev(dev);
+		ret =3D null_create_dev();
+		if (ret)
 			goto err_dev;
-		}
 	}
=20
 	pr_info("module loaded\n");
@@ -2169,9 +2187,7 @@ static int __init null_init(void)
 err_dev:
 	while (!list_empty(&nullb_list)) {
 		nullb =3D list_entry(nullb_list.next, struct nullb, list);
-		dev =3D nullb->dev;
-		null_del_dev(nullb);
-		null_free_dev(dev);
+		null_destroy_dev(nullb);
 	}
 	unregister_blkdev(null_major, "nullb");
 err_conf:
@@ -2192,12 +2208,8 @@ static void __exit null_exit(void)
=20
 	mutex_lock(&lock);
 	while (!list_empty(&nullb_list)) {
-		struct nullb_device *dev;
-
 		nullb =3D list_entry(nullb_list.next, struct nullb, list);
-		dev =3D nullb->dev;
-		null_del_dev(nullb);
-		null_free_dev(dev);
+		null_destroy_dev(nullb);
 	}
 	mutex_unlock(&lock);
=20
--=20
2.35.1

