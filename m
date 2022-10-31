Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D33FA373D
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 02:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJaC0x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 22:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJaC0v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 22:26:51 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02AC2678
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 19:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667183210; x=1698719210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u+YhafSOih06QZfSN+lI+siqPo+e0Kz4p8AfqVOVZpQ=;
  b=e3tNBLGsYxuPHYqi6AMku1G8CeUz+vyFZ1EgXy16drr8sv7OOM/OohNt
   eb1Lcuyhq3PiH/qOBLja2oNyjjJTZT77/24zr1cAZ/ZTrjtb38cmiuxX/
   bUuahlmaHx17k9/UrQ4x22X28i+KM8Cyf9TJ/l/adzBnd9xAEPT9sm6Kx
   bp2/ZULkpf5GfdXKF8rOgQeZXJOMLrhSx2kruxNDWF/ypmbIkOJ9MagDD
   ZHPcaira8lmWpNI2F6CJ5sOFosrZX4JKNVdJ957SQdE7I3fbDpDi32oqt
   uesE0AeyzSN4KZxQunL1RwxQInQ1tgqX/HDW/p0nBEPljbyCgVcojEdd0
   g==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="215446857"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 10:26:50 +0800
IronPort-SDR: lXSzYLGNHXTDglUf0xQiELObUbY8qOvbJtIqa9/s0H8++H9gRBJt9n4mPWO89RyqGFHhi5LoSf
 fUjPmdm9UbQh8nnSgUbHvlldcEixlgfRWh1PqEne6fpt6BBVdGpa7j8sDFEF4T50plbEmQlMYB
 o1RfKI2cwMlEJYEVPc2U3euiQLTiEF/oACjP+edUP0sFNk/zP7uWgsYn/JRIP7qYsVyfhAd3uv
 upw5B9ZRuyWdSVvcny9ca5g+mU/mRLYsWO1kJ7WecWSv4JJPtcju0lq0qjiz3lHbmHQn0yOY0h
 RC+sIW0rBOq22UwoxKQHw3z1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:40:23 -0700
IronPort-SDR: WoZlcPV5oxNQn7EPg1Px22LJ1EVB8JVYdxAOIlUfhzkMe551rruC6y/SK5bVaKJmIgXvqmClIR
 ykFwXb0e73MvT2P4h9xMNArhvihfwUBxHfikNtsMGvjuo8zlTZpqZoW94Xpa/VeZnM+iUMYs6O
 K+3XmSR401XVmyF6XwXA7xdbiCQ/IRlNLYCcHZMlXT3cDaHLO6ZR43cWGjvQ624U7EIoKuQ0fG
 MT3raQ/g/Q6ytyQ4jazgUCI/2jx6mktXzFfoPMX0d54GObJhHkhOkeCkg8ziSlO7tizzq3/uRJ
 oBQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 19:26:50 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N0xqZ17c9z1RvTr
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 19:26:50 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667183209; x=1669775210; bh=u+YhafSOih06QZfSN+
        lI+siqPo+e0Kz4p8AfqVOVZpQ=; b=PgVGgsto9AHwhU9xCf9B4tVL1gcvJbK3wn
        Wgf1xCLC2Xvhfbp6iCNmC+QSdd+I3ddzH+yTd90aiihdgi9xuqw2Z3VG3SCRPVw8
        caRyzbunbuLipzMGsCnXLx2x5xx35TeMG6brQ3Q/qdTX19zasCLdsfWcXAGemrIo
        UgcwqrjJ/uDrapXsq1QNUCQVmBuZwfAuunQe7S0YaT2wkewFKMSLpJs71acof4Tj
        jo+S36F/OkGv66MUO3rAm45w01IIdcAUP3v97dmqhV+Yr5cMHpayX2Qp/4HrSyPA
        dvT2cKdorWD6dD//ot1Xnq1JcZZKxRoIB/hGsuRBeAe2V816IfnA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 96UVYQhP12ja for <linux-block@vger.kernel.org>;
        Sun, 30 Oct 2022 19:26:49 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N0xqV5GHcz1RvTp;
        Sun, 30 Oct 2022 19:26:46 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 1/7] block: Prevent the use of REQ_FUA with read operations
Date:   Mon, 31 Oct 2022 11:26:36 +0900
Message-Id: <20221031022642.352794-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
References: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For block devices that do not support FUA, the blk-flush machinery using
preflush/postflush (synchronize cache) does not enforce media access on
the device side for a REQ_FUA read. Furthermore, not all block devices
support FUA for read operations (e.g. ATA devices with NCQ support
turned off). Finally, while all the blk-flush.c code is clearly intended
at processing FUA writes, there is no explicit checks verifying that the
issued request is a write.

Add a check at the beginning of blk_insert_flush() to ensure that any
REQ_FUA read request is failed, reporting "not supported" to the user.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 block/blk-flush.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 53202eff545e..4a2693c7535b 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -397,6 +397,18 @@ void blk_insert_flush(struct request *rq)
 	unsigned int policy =3D blk_flush_policy(fflags, rq);
 	struct blk_flush_queue *fq =3D blk_get_flush_queue(q, rq->mq_ctx);
=20
+	/*
+	 * REQ_FUA does not apply to read requests because:
+	 * - There is no way to reliably force media access for read operations
+	 *   with a block device that does not support FUA.
+	 * - Not all block devices support FUA for read operations (e.g. ATA
+	 *   devices with NCQ support turned off).
+	 */
+	if (!op_is_write(rq->cmd_flags) && (rq->cmd_flags & REQ_FUA)) {
+		blk_mq_end_request(rq, BLK_STS_NOTSUPP);
+		return;
+	}
+
 	/*
 	 * @policy now records what operations need to be done.  Adjust
 	 * REQ_PREFLUSH and FUA for the driver.
--=20
2.38.1

