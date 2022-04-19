Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D7BC4332F
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 11:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349185AbiDSLD0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 07:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350816AbiDSLDZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 07:03:25 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843141BE91
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 04:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650366042; x=1681902042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RZlj07dLeyil7KbTI710dFh/tAqPF60wAmdflvFXwJw=;
  b=oC3CT6CvVVMJPEV+MpLdCrZTJQBpY/1erWt/Zchh4sjw6pMjKBcD1IOG
   VtFrveCAZgnFQ+/LCfaMZt/IyyuHOFMGFTKPGSZzHgHwxXYOe+eBB5AZW
   uYReHsMXBFb2aSZk7CTRWcOxwLW9h2kfqFhmtUeFkQJ58WlKQGuAUwyHn
   WrS7GaL0kz8Pk0BxMFlq6cRXU0kiizol8o7qw+GZ86SGrm6VrN4OrhQkr
   0IzClTQg/nmfos2vgWmA0D7h/ENHz8LQ18uGypbDf214TmfKXLeKStYnO
   mLIwg+klDPWnXeu0JPDIC1kqf75/tT05VnT8oehTQiqDI6ljk3Qc6HshN
   w==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643644800"; 
   d="scan'208";a="198252954"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2022 19:00:41 +0800
IronPort-SDR: 1GZt4T8mBEzhXfwsfKiDre1Lw0O3UTFjgvBbMjyvCfp59jwxKJ99yqrI6yCXpNmh6cfmCB32Ci
 CcPI01epmpTkokov8+HH3t6sUjtgMMxv8bhxQSa1/WSgaNLfUJ57gkWjoJHq/fT12fnL4EarZj
 1qyqGwoI28eipfFlHPE4gv1GVvUlk+GaI/fnIrxB82JQYEbNl28bm0NH5ObzQdVsdE/z6i7INs
 wuRxb4TmYXApaNLs8/4kntNqzCvKGf4ACAtK+RjN32BHnrS4bxu1i5hsK34qBCanBJ5cKlLDFG
 gNwt/6y9QNpSY1Sfm1t0nVkd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 03:31:48 -0700
IronPort-SDR: JpHc2VBjagl6vmJBbSlh2ozzF2lfkxYwwTiflGZVJz/vrBb7eLy5tdHNA+ZUQ3zC6QvBHV14Dp
 4gMrdi3KT1malZiaQJTcLmYRotKeMKWUIGkJso4irt4m9cBba28YlnpgUhNkzS2dKHcdEcmeRC
 DHGCeS38w4Px9xU0C26g9Y73QEVTyPhU524Xv9KkUAzlTHK0iQNNTkH1sV6Cxg74s8gxIFKUtf
 R3QuLr26PW7E+JO7oTxVeKahkownCRNERGxaNFQygQEFgtlvp+mThqaNQiLRoDP+d1UmmkswYO
 mmo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 04:00:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KjLSV66Z2z1SVp0
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 04:00:42 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650366042; x=1652958043; bh=RZlj07dLeyil7KbTI7
        10dFh/tAqPF60wAmdflvFXwJw=; b=D/g5ffs7os6/YV7Csk6BB7iXVPXfk3zexI
        y0CWKn8L9cEFKPBzWPlNkCqQuA9zfiefjZrPFcaw+1xHnFON9/UfCmQwKPK0YTTx
        xQGWvobZOdR80bD9ZlfRkXvG5dbr4swGZKRiBuJ5R7KVRfYpvwjhLYFu9Mqsq512
        4gcgCEUBUDLQ/z3tbdpCnnSQgTch+mJCMjFwa6QIpee6I2eZNteESsoBuagPj9UY
        GS7w3P5M1i5nY7CdSkkTx2y/4ZOJxUYJaTzS3uGEhN/finFM31V7+57HEeGGiCSQ
        g/Ymfwx2w5g1z63LsmEpcmv45P0H17oAJuMbVCNZTPwNR88GBDgA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oAYuX52K1H3g for <linux-block@vger.kernel.org>;
        Tue, 19 Apr 2022 04:00:42 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KjLST5wVsz1Rvlx;
        Tue, 19 Apr 2022 04:00:41 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 2/4] block: null_blk: Cleanup device creation and deletion
Date:   Tue, 19 Apr 2022 20:00:36 +0900
Message-Id: <20220419110038.3728406-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419110038.3728406-1-damien.lemoal@opensource.wdc.com>
References: <20220419110038.3728406-1-damien.lemoal@opensource.wdc.com>
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

