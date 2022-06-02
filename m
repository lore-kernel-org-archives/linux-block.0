Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2244C433EF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jun 2022 12:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbiFBMEK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jun 2022 08:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiFBMEH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 08:04:07 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CAD9FEF
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 05:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654171427; x=1685707427;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U9CKYAfi7G8KU8C3eUV5aJTz1VyQ+0ZNllGM8+D4b24=;
  b=ZhnyHHf8Z9hzO6KcDfYezwYxAdnjVZezSQ0UaxeujzINAl6K0L8gD+xC
   ly0Hyo7e9ixD8IctPRjwPlEchD76WefMaXXRWC6OG+HrXE84gZ7u0ED/5
   Sv21ewbOtgofOjF5e1wwuP6cTu5eDRrs4NkkwwmwyuLkGfDav4dxlTNMv
   19H1Llvh98eirnTGgZjze42H8b3yAJqfsPAdUw5swYe+EArLcqBkRgudu
   ViqZwazPvzT+04KsIm5k2UU/F+6Rx7QgJfpnQ9WJfpff2z3+AinMnheAw
   aNJp5W/0abFj7lNYfzMh5vt0Z9ItVDCNHIqYrqT69wHTcHGrtaDMuFm7k
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,271,1647273600"; 
   d="scan'208";a="202097062"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2022 20:03:47 +0800
IronPort-SDR: 0rgIsZoeHlTTbGUCB59USwLiKB7FgQYivuAh7LTiggw2joUE5KvkwX5aWJDzzGOYdUttNm1rhn
 /hzcSnTPloRNkCeUScjsSMQNFFjhUXDUxQ693Ooub7HApGhM6SI6GOMgTJBHfjefPlhVzyu42I
 T+X7+ed0QHrD5lAbodQAJHuCBkdnO2JCzA4mYgsZeDITmckp3/rUudBUGGJg2WX5CvP/N8ZmEH
 SafE2lB81RKPjsKmo364yr9C7uP1gRazEr2ndRELZFCUmva3lnIUWusy8/tD83ghBLq9sfAJVE
 ck0XSAl9AhDs6Ny88RV34i1P
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jun 2022 04:27:24 -0700
IronPort-SDR: mUPKaPav8KlSQNKKHglVWkq8F9+YRF0PYmEVR+X/lebZPMjJbsKzHqCKlkK8vcW48DS8tMEjkj
 3hVy5GJ82hDo89+KwkVG/q28SmOim4yjZ2Eo+BP/OLAdg/2OKJf+X2pWiu+YRFoNmBoo3/SVtH
 JibADetqxX+SQqosLSbFEgpLCCjZodti4xOClNHpjnf4qh8l85I2PnorZM1AQkPA8tXV9vdSvs
 qOeOrqWEK+Zlu2m/M0sjjltWpTlwGBHD3VVdQ5HW77IkbIHNXEV1V5Ly7szsYhqu9mDp9Va1eK
 yII=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jun 2022 05:03:47 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LDPmz1wTQz1Rwrw
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 05:03:47 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1654171426;
         x=1656763427; bh=U9CKYAfi7G8KU8C3eUV5aJTz1VyQ+0ZNllGM8+D4b24=; b=
        FdAG3my5JzopfM3DlnxagcXuAUkES0TbBrfh1boF70Xa/6pAmDAvQCGDR0CTZ4Hq
        oi5CznwsBrZsej4YlG/+PMENgo8x/dZGYxoQ5hQAjcnciIelx/13Jnf0pFTkxn1P
        H7DiRu4tKkXzl4BnmddhePAiDVZ7Y64jd2h4sSaTFmPbVLrVzSKgUzgC6rcrZH89
        5vfu9cQwqgHcTv9iWiNcVAevwBikSZLwRlgemY9zwtFgPhnE1t3JjqdQORum256B
        NjeZ8e9YzD5J2ovbBEdGGwfcQoGiD3U4YhLzUyhi2YqJZikzPEYhBu6p/fGCJf39
        9kFF61QvqfBprq+QlbL4aA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mJ9AL7mjUM9h for <linux-block@vger.kernel.org>;
        Thu,  2 Jun 2022 05:03:46 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LDPmy3FPYz1Rvlc;
        Thu,  2 Jun 2022 05:03:46 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH] block: null_blk: Fix null_zone_write()
Date:   Thu,  2 Jun 2022 21:03:44 +0900
Message-Id: <20220602120344.1365329-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The bio and rq fields of struct nullb_cmd are now overlapping in a
union. So we cannot use a test on ->bio being non-NULL to detect the
NULL_Q_BIO queue mode. null_zone_write() use such broken test to set the
sector position of a zone append write in the command bio or request.
When the null_blk device uses the NULL_Q_MQ queue mode,
null_zone_write() wrongly end up setting the bio sector position,
resulting in the command request to be broken and random crashes
following.

Fix this by testing the device queue mode directly.

Fixes: 8ba816b23abd ("null-blk: save memory footprint for struct nullb_cm=
d")
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/block/null_blk/main.c     | 6 ------
 drivers/block/null_blk/null_blk.h | 7 +++++++
 drivers/block/null_blk/zoned.c    | 6 +++---
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index 539cfeac263d..6b67088f4ea7 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -77,12 +77,6 @@ enum {
 	NULL_IRQ_TIMER		=3D 2,
 };
=20
-enum {
-	NULL_Q_BIO		=3D 0,
-	NULL_Q_RQ		=3D 1,
-	NULL_Q_MQ		=3D 2,
-};
-
 static bool g_virt_boundary =3D false;
 module_param_named(virt_boundary, g_virt_boundary, bool, 0444);
 MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the devi=
ce. Default: False");
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/n=
ull_blk.h
index 4525a65e1b23..8359b43842f2 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -60,6 +60,13 @@ struct nullb_zone {
 	unsigned int capacity;
 };
=20
+/* Queue modes */
+enum {
+	NULL_Q_BIO	=3D 0,
+	NULL_Q_RQ	=3D 1,
+	NULL_Q_MQ	=3D 2,
+};
+
 struct nullb_device {
 	struct nullb *nullb;
 	struct config_item item;
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zone=
d.c
index ed158ea4fdd1..2fdd7b20c224 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -398,10 +398,10 @@ static blk_status_t null_zone_write(struct nullb_cm=
d *cmd, sector_t sector,
 	 */
 	if (append) {
 		sector =3D zone->wp;
-		if (cmd->bio)
-			cmd->bio->bi_iter.bi_sector =3D sector;
-		else
+		if (dev->queue_mode =3D=3D NULL_Q_MQ)
 			cmd->rq->__sector =3D sector;
+		else
+			cmd->bio->bi_iter.bi_sector =3D sector;
 	} else if (sector !=3D zone->wp) {
 		ret =3D BLK_STS_IOERR;
 		goto unlock;
--=20
2.36.1

