Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FCBFA3744
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 02:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiJaC1A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 22:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJaC04 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 22:26:56 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EB5B1DE
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 19:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667183215; x=1698719215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xz6ycfIfidoOOGiPhXlSF5Bv4e0fjijWd4+tMRv7Bmo=;
  b=mhRhfVukeayVSVSj6pDvzlb79JnTQR9XKwsI8/pYE819gdmkakPKQiy6
   /J+mfm/sRBNqvjOyvCZwf9vBJ7S3eTH2M9pWbkrNJmL+dv2T3eavgADTQ
   1jBeuYaMuvsGig8A2z7uDnz89idkxBje5t8ZQZ+BhKwT2o7Ibc6beCzAq
   8IUvh4PorM+Xy51p/kCeq5JZ2E/b2dY3wALHsOrgwqyGHa3g3kWjE2GU0
   hZYZm6aFlmhaz1mtaRUBA3VTTfHBGraKee0ZndHKTBvyJMxyCKWqG/eOG
   kZvZb5DyuMoPAo0ZcFqbU3qn/MkzFRcYujM0HhP2eXhvbxd68prYGFT4/
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="215446864"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 10:26:55 +0800
IronPort-SDR: 5m91IC0dl6/+em1rtBKfCJ6tfIFcoptb4odIbQTRuIOcmSbXr4NyTVp0xi3B3HGI4zI8NLlxIQ
 4Iaw83k/OKJIkoauMztOHlCY+YMEgYbyQeTlMcTdcmKgMsiDAQZEvWsUAwaRbNXa5guLG2yU4A
 ADWOk7ZmVZgPxQ8cVeO+ErVd1LLmZtTGmMBvtmwZ4zUc47xZX+QBcE0yEdybAFZ5lKdD/GUyB9
 xH0PtCXB1qybProXBKFOO/x5+cDDDSHlYyXUKCkYuUNr+NIiCo3i8JJFlY4cY8zQPGmJ0DJ22/
 /g3mEJ0fskxtntuC6k/RYfgA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:46:11 -0700
IronPort-SDR: 8xIc2e0Mw8/kSVC0N7NlAcEhs+KRkzjZ4hrlqTUK+Fnz1joFGijvMWuAmwjr+8oMFAGjDb2h7I
 8IDDfjrlWiPKfu3FKDN5fO9AtBhtXHl0kGBYfZIAC6Z/u8HcrD5z20G/OiZdZRawDGUd/gLbO9
 jlLgkzW4phPahRxu2jQ4xSaQEtEY8elbmvak6UYiVqOJ1Q/8YadYqf6D1q2wQssqyjlmAmO6TD
 QRQctZa6eKhaVd94gZzF0gCX/U2ECu4GifiWWc06/eOfFeFbNSHoCnNYSgKPruAa+YIDOwjY6n
 +Y8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 19:26:55 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N0xqf534pz1Rwrq
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 19:26:54 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667183214; x=1669775215; bh=xz6ycfIfidoOOGiPhX
        lSF5Bv4e0fjijWd4+tMRv7Bmo=; b=mSFPBxsKCyB+SZa2mL2FrrvuEukrzZHxrM
        XDzfN585gQGvVt+c2ZwuQ8sl8t9SNDstQ08FeuvZQiyPjygzLaLFCVbZklszwdMQ
        /e162TUmjz2f/MWXzf9H5bznUlQ4zTHd6ArZi8uSxs+zPQZJrgzmJaMC6G5+ueb3
        scEykZNNBHDZ0NEqMXBvwnj0g6HTzKVtrjrylz61VcDXjUfJ/26xirBNUwHNow2A
        fZwp9hQnGukR/tYi5tqBk1wR6+d/VhkmkW+mNzAOFk2AtkuLaA7SljayQDUR2wGX
        Sfr7leXJrdhXdTFeX3aPlMmudvYmyimhghhNsOr9UAOL1sAOS1Rw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rOKBg5DoEtkv for <linux-block@vger.kernel.org>;
        Sun, 30 Oct 2022 19:26:54 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N0xqc5fNBz1RvTp;
        Sun, 30 Oct 2022 19:26:52 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 3/7] ata: libata: Rename and cleanup ata_rwcmd_protocol()
Date:   Mon, 31 Oct 2022 11:26:38 +0900
Message-Id: <20221031022642.352794-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
References: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Rename ata_rwcmd_protocol() to ata_set_rwcmd_protocol() to better
reflect the fact that this function sets a task file command and
protocol. The arguments order is also reversed and the function return
type changed to a bool to indicate if the command and protocol were set
corretly (instead of returning a completely arbitrary "-1" value.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 884ae73b11ea..6ee1cbac3ab0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -574,17 +574,18 @@ static const u8 ata_rw_cmds[] =3D {
 };
=20
 /**
- *	ata_rwcmd_protocol - set taskfile r/w commands and protocol
- *	@tf: command to examine and configure
- *	@dev: device tf belongs to
+ *	ata_set_rwcmd_protocol - set taskfile r/w command and protocol
+ *	@dev: target device for the taskfile
+ *	@tf: taskfile to examine and configure
  *
- *	Examine the device configuration and tf->flags to calculate
- *	the proper read/write commands and protocol to use.
+ *	Examine the device configuration and tf->flags to determine
+ *	the proper read/write command and protocol to use for @tf.
  *
  *	LOCKING:
  *	caller.
  */
-static int ata_rwcmd_protocol(struct ata_taskfile *tf, struct ata_device=
 *dev)
+static bool ata_set_rwcmd_protocol(struct ata_device *dev,
+				   struct ata_taskfile *tf)
 {
 	u8 cmd;
=20
@@ -607,11 +608,12 @@ static int ata_rwcmd_protocol(struct ata_taskfile *=
tf, struct ata_device *dev)
 	}
=20
 	cmd =3D ata_rw_cmds[index + fua + lba48 + write];
-	if (cmd) {
-		tf->command =3D cmd;
-		return 0;
-	}
-	return -1;
+	if (!cmd)
+		return false;
+
+	tf->command =3D cmd;
+
+	return true;
 }
=20
 /**
@@ -744,7 +746,7 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 bl=
ock, u32 n_block,
 			/* request too large even for LBA48 */
 			return -ERANGE;
=20
-		if (unlikely(ata_rwcmd_protocol(tf, dev) < 0))
+		if (unlikely(!ata_set_rwcmd_protocol(dev, tf)))
 			return -EINVAL;
=20
 		tf->nsect =3D n_block & 0xff;
@@ -762,7 +764,7 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 bl=
ock, u32 n_block,
 		if (!lba_28_ok(block, n_block))
 			return -ERANGE;
=20
-		if (unlikely(ata_rwcmd_protocol(tf, dev) < 0))
+		if (unlikely(!ata_set_rwcmd_protocol(dev, tf)))
 			return -EINVAL;
=20
 		/* Convert LBA to CHS */
--=20
2.38.1

