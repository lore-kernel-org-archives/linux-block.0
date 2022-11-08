Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F29C4332F
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 05:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiKHFzy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 00:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbiKHFzu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 00:55:50 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD422F67D
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 21:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667886950; x=1699422950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vr6aZ39Sl8l5+IvhfiJt7mmTQgIrV6exE26ZC1eho1g=;
  b=BGNw4ijUlVbaaOVX8Gvk+vZ6VC4828Vg7vlDdU6n8oqTn/c3KPnR0cJR
   QKbTex8CykKH/0mTKnM84alG0c3R9EY4SN86NZz/jpV5ZrORHp0QKI5hc
   FThjw8bMB2vdPd2/qRv1SPqAI66nj9afY+HXmoRiKjUD8Yk+Q7pbfZtfn
   owHql9321Q1kvaPxV0iKUIZviHV5iC6THi+Va/INdpMAEoyjyqxxgieMg
   IisUyhnWtZ5tuIrd7ZRU4GJadB1tSbc5jQtjDiGnIzC2Xil4hG3SdPqwp
   9lKJQdExlq1/JmtWZI+h11L9hbRnchfLAGX2gECDkmcPTupDm0WKrFGL8
   w==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665417600"; 
   d="scan'208";a="320067439"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 13:55:49 +0800
IronPort-SDR: uBfY5ISW5CiN2nzYh9okuivRfsDn0lYaS6dxU26UYCSAoktUyW6WttwBPywFNBQvu39Ombe/3U
 ggIh5tePoBWxL0U7VLPBNWP5osPbUxx5X7r4eFxQaHrzatJG9jTFBu5oWQec9fSrcyhyHmTbDj
 6ibdis+QP5tYAtZYLcCs139jesUigza3cu5WS7Tc5js3EqhlzYVyKx8vzsKeL6Rr7bopC0D7lD
 m0eZdGptFefH+E8/OCrBMAXGDY4rznrSUDO7jqFdj1mIpEuJpm35mYGIbTz4fXDXtc6zonbbAX
 dr4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 21:09:11 -0800
IronPort-SDR: ZEpzpklL+hGzkBQ2iyjSe3iKnztDwz3Z/M8xfrzosIJyxkaiUWPBmrGClWhw4+3P0VHrP5KmnP
 jo5dxe/XdMCYx9N2JAEa6U1aYtqleBbeI3QbonuUBHuammWpcwjl1NF714p1Ko80nThrXsRFey
 1DiMdwp2pAjfyL73Qwb5BJq533ship6MCcqFhaI+/uRVe5jsWYuTFTcGz1N8Dd0SK5XMKtbnvQ
 lmUEB+ElF5YSdi07F85Dk+HrTLmbBY0WN70E5ZiZG9Nwxx9PWVv0Sy3cs3N3Zmi++/VOYH5dgL
 g6k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 21:55:50 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5y511t2mz1RvTr
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 21:55:49 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667886948; x=1670478949; bh=vr6aZ39Sl8l5+Ivhfi
        Jt7mmTQgIrV6exE26ZC1eho1g=; b=WpS9ChoUvJMnqO2XMCvbIgdveBv4dsZprV
        okAy4MoJjNEsZ5EJRhBRaAm+xscbCTZV6zFVWk8t+FJg9bUMBP8bYktssZ9YglkT
        vjHf2zstfb14ISEzVlhmP4OgP9EHTcaorraeapewn/syx0s4zTMLzAF3QNkahx/O
        nrg5TCfI96efGRth0gu8I++pWrqoR0fUIOcP8/mFTKg8NosvX8Sn3YhbuCE32iBH
        GtPZprr8dTU08WUMcLFGabS5PCLipjFtj7CUC3rT69M3kYRZzuhEau1FnsoW0NH7
        IOUJqf4oWjbm8YWr5rJwbLH7FfPPoVUQpaK/zYHCJd6H55yWnljw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id d9ZUmDfVj5tn for <linux-block@vger.kernel.org>;
        Mon,  7 Nov 2022 21:55:48 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5y4z60ZXz1RvTp;
        Mon,  7 Nov 2022 21:55:47 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 1/7] block: add a sanity check for non-write flush/fua bios
Date:   Tue,  8 Nov 2022 14:55:38 +0900
Message-Id: <20221108055544.1481583-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@infradead.org>

Check that the PREFUSH and FUA flags are only set on write bios,
given that the flush state machine expects that.

Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 17667159482e..d3446d38ba77 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -730,12 +730,15 @@ void submit_bio_noacct(struct bio *bio)
 	 * Filter flush bio's early so that bio based drivers without flush
 	 * support don't have to worry about them.
 	 */
-	if (op_is_flush(bio->bi_opf) &&
-	    !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
-		bio->bi_opf &=3D ~(REQ_PREFLUSH | REQ_FUA);
-		if (!bio_sectors(bio)) {
-			status =3D BLK_STS_OK;
+	if (op_is_flush(bio->bi_opf)) {
+		if (WARN_ON_ONCE(bio_op(bio) !=3D REQ_OP_WRITE))
 			goto end_io;
+		if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
+			bio->bi_opf &=3D ~(REQ_PREFLUSH | REQ_FUA);
+			if (!bio_sectors(bio)) {
+				status =3D BLK_STS_OK;
+				goto end_io;
+			}
 		}
 	}
=20
--=20
2.38.1

