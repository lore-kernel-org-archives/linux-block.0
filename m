Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53ADCCA473
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 05:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240799AbiFCFfg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 01:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240737AbiFCFfe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 01:35:34 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7B738DB6
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 22:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654234531; x=1685770531;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pTkbDw92AA62sgODPO0jtgA6O/KaMXycK3Vphuhgn7Q=;
  b=OBwS68WJZvLN7/8HFtVCBO1oPHrHPGg0W+NRALIHCUPjNJgpPFvrxorG
   N1jeA3XbFkbf8DwYJmCh6LLVQXzwdDspEt7jKUAJQKZXXfb1XmLAtjbPs
   3CEqI7SMEAHW2sHZKW7pzFDF7EgpZmvvpJLpBmcCzXIqYTL3Q7kQfWpLm
   qHQ4B3+O2xR8/WnpPtOy3bCtl2EmeXSLpaT9zbRHNLS7iuER4ULyTQWpV
   +8+dj9zqnuO9k9QZAbjHmZbsrrSnQ1Pn7+1DTFrBEqNLkspoKugiu/+uk
   q+MIKDQnfh3xezkyTrCYw4gPeyea2/J/xDiEqOOiq7c0qnrDdFnD5PNMn
   A==;
X-IronPort-AV: E=Sophos;i="5.91,273,1647273600"; 
   d="scan'208";a="202171435"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2022 13:35:30 +0800
IronPort-SDR: +9oxXGYt+EpeoQ1qzJH7oKg43gOwutEIg9rnfEsMJA3oUMtEbqCNZ+6jtVlo5aaTWHp9fmLJEX
 VuL8ny1b/IQc0ZYBcNCEK4BNCy6Awad/yvLGJXyUlV76+g/hkNC6QTW2gIFm6Nfpqe7kJBG2zj
 YYd0aDJx/aEW4Voe7kPDtroLqq28HsJD5aBai27ccGDY3hWoxeruWTD1NwhFaxv4zh9hLEkuDA
 SGgvCDaQ7oDQ+kHRnuj6vMkBEwMsCEolcKCQxaI/rHmUePn9yG48b4TSkiFY84jLprvkG34wnB
 6GqNhfvVD6kT6wuEVqlaMYGW
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jun 2022 21:59:01 -0700
IronPort-SDR: aOyHW9s7g48xJNdkXSyorK4PCKuGRFBRB67lcBF3Ah6MXnX6/C04/tH3Mu9cP2/uxF/gf70Yjn
 OlvVYcDoZyPOx+WODY2yjYZlNO4HwARNi/C/585Umy38l/ysLhIBGJJ+KNxkBrZ/EX789gWaq7
 oDVFj1Ht9qYFeYRau5e9HgPZF51UDMRojJPlc3LFX+zl59NlxGS4wIRIfow5sc/SEvfy69fjLF
 0Y6NPmClW2CDsbISqWacS0qfcOXVm6zUTGGElPkWf3eCWW20aDEoL9AUnDbB4DGsgmSDjinqEi
 JN4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jun 2022 22:35:33 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LDs6X1X8Sz1Rvlx
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 22:35:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1654234531;
         x=1656826532; bh=pTkbDw92AA62sgODPO0jtgA6O/KaMXycK3Vphuhgn7Q=; b=
        VyWC6V00rYCewerZCgrR8TEUkPRHYKiAzl4zGfdAkygFmjfQ3F1JXOXIXtRTSBmU
        QwGvCxvd0dYpo+6v1n9JpAP7ulGN5uBSs5QplaO8WFx+TK6wEUZBjGzGaGN35jqq
        Eo9KDPHPGtIrgLx7Ynmb8gB8qRgUwKXDyf3WS7D2YXdHi3AKekXcCZbiOs3CZ6e5
        yiGDnLRoDssU9k+u/N9lermKgYX1f6JEZM1mofNhCrfGoH7FrUCfDrj1N894yIB5
        2zqA6gDWgv37HJ2DsGc74kU66cmG6CECO9OPDbowl4VgQ1b313UOk5bOJQ9WxSwU
        YoU19oKH1WANBIEk1Dyzmg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gHJ8nG7LSRw2 for <linux-block@vger.kernel.org>;
        Thu,  2 Jun 2022 22:35:31 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LDs6W36N7z1Rvlc;
        Thu,  2 Jun 2022 22:35:31 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH] block: remove queue from struct blk_independent_access_range
Date:   Fri,  3 Jun 2022 14:35:29 +0900
Message-Id: <20220603053529.76405-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The request queue pointer in struct blk_independent_access_range is
unused. Remove it.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 block/blk-ia-ranges.c  | 1 -
 include/linux/blkdev.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/block/blk-ia-ranges.c b/block/blk-ia-ranges.c
index 56ed48d2954e..47c89e65b57f 100644
--- a/block/blk-ia-ranges.c
+++ b/block/blk-ia-ranges.c
@@ -144,7 +144,6 @@ int disk_register_independent_access_ranges(struct ge=
ndisk *disk,
 	}
=20
 	for (i =3D 0; i < iars->nr_ia_ranges; i++) {
-		iars->ia_range[i].queue =3D q;
 		ret =3D kobject_init_and_add(&iars->ia_range[i].kobj,
 					   &blk_ia_range_ktype, &iars->kobj,
 					   "%d", i);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1b24c1fb3bb1..62633619146e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -341,7 +341,6 @@ static inline int blkdev_zone_mgmt_ioctl(struct block=
_device *bdev,
  */
 struct blk_independent_access_range {
 	struct kobject		kobj;
-	struct request_queue	*queue;
 	sector_t		sector;
 	sector_t		nr_sectors;
 };
--=20
2.36.1

