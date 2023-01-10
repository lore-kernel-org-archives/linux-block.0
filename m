Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CDAC54EBC
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 13:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjAJN1i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjAJN1P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 08:27:15 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B5B3BB
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 05:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673357235; x=1704893235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AyibMIs0Fjq5vJZru9dnT2TmnjplSYQ6SuX8E1ANMNo=;
  b=oJo6LSXRkVgxGMZaCopCad67evri6i+bfcfulpQdmtxJKPpys0zxUojh
   mI9ais3PdE9fJpJqBcfPJudO3iMK39AeQFU5C1kiDHqvVj5gB9c7sJBKE
   n9oKnbNmYz0joCVTMsIJp2JZhcsCQS65sJVrWyBhClgcWahBeGK/vSUNc
   4oD+ALjnGSsx5mZGjR9Q8m3mqoEfU/36hRsN8ISSTMLtyaK7KI4E1TRQS
   OY4mPfUq1bZ0gQ25wF2IEkgLEkswPg8GvhIt2D7wMlOI2TgSAnSd3QA6e
   p/+/xcuO6F4zOF9/eOdMHjWzKWf7Tj6KhkcvLShFwkeDKneDL8CHImJUg
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="225493135"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:27:14 +0800
IronPort-SDR: hCX8spIAtN1cwegKvTwK6vhjZZQLX5XIJXs37gFxel/rn7Uzg3o8odhCnuKIMfX+h8DSdS1Yvr
 jP1IolUrimp6ynFWMlpRjoy/gQYi1hozQxIQ7GDAf4scum0WBbv8yeCtJykamrE5yrAHCfwxLf
 PP+ZuMjaawY4QTZ+FiwyJFrGyFPCcuht+e3pshpUjCHUKwUPckz7P2kAEpLuoDx5LTFHoqtAas
 K7kEQU1/jJx53qmwuH8aU5gL0gVTMcocJ/kmIvYxgS4eq9yDgw2iYjJLhnQU03brHJeF9qKSLJ
 n20=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:45:04 -0800
IronPort-SDR: pD+JEZ5NvD0H4cxyK86exyca2IlG5mzJizDxlDy7brYMTV3FO4h91Qooo6+Hu8oMaLQCCOCrds
 VKjj+Bn1M3ZOaxksB4n4LO72Zse4KfLD8n8zKQwQKGsEEYmkPfnBKk9nhcSNHqQCr2jUogWPq/
 2zg2PLJq0s+kc/EjljsBmkUPsvre7rKivppgigSyCGluXKW8CS5frR9b/u0ntcKMFln0bxpXeZ
 cguQDwtA6THZhq/qzUZg5vor8PZY03t+CjucN/3AEZbZ7qJaMBMqOzVrQrsa3XCU3dnM/QVs3k
 OJw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:27:15 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nrs6p62kBz1Rwt8
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 05:27:14 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1673357234; x=1675949235; bh=AyibMIs0Fjq5vJZru9
        dnT2TmnjplSYQ6SuX8E1ANMNo=; b=kwhU8ly1QXkOf6LeGbbDIHZPOn02lIKfKw
        JHefJq12srTjZ+cdiqh3zJBO37YOPDQfuhr5tohlXk67KY6TischBOkFJOVGJr51
        7MZ3la2ij4acIDzkyzK/alIK6aj40O7hOyHqBq6jpye+OMj7AEqCS1Of3nhA7VYZ
        4KCYO6j6DCSy6czohxw7kXwZKrFaWrtB458Cg5UkutkkPAdRmxbQQ3r0EGuewRpY
        ocnbsxjLB4hyIeAyhNmbFErwba3q4/jwh8Q2zxYCgPo2Vuy8Mx6TPFFhmWQyplLv
        YeAyVwtbcs7AKkAMagd4AQ6SDS1+wUZ9XLgQ4SmWC1Wxb4mv4yiA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5ArK1Xbxjfa6 for <linux-block@vger.kernel.org>;
        Tue, 10 Jan 2023 05:27:14 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nrs6n3X06z1RvTp;
        Tue, 10 Jan 2023 05:27:13 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v9 1/6] block: add a sanity check for non-write flush/fua bios
Date:   Tue, 10 Jan 2023 22:27:05 +0900
Message-Id: <20230110132710.252015-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110132710.252015-1-damien.lemoal@opensource.wdc.com>
References: <20230110132710.252015-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@infradead.org>

Check that the PREFUSH and FUA flags are only set on write bios,
given that the flush state machine expects that.

[Damien] The check is also extended to REQ_OP_ZONE_APPEND operations as
these are data write operations used by btrfs and zonefs and may also
have the REQ_FUA bit set.

Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 block/blk-core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9321767470dc..c644aac498ef 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -744,12 +744,16 @@ void submit_bio_noacct(struct bio *bio)
 	 * Filter flush bio's early so that bio based drivers without flush
 	 * support don't have to worry about them.
 	 */
-	if (op_is_flush(bio->bi_opf) &&
-	    !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
-		bio->bi_opf &=3D ~(REQ_PREFLUSH | REQ_FUA);
-		if (!bio_sectors(bio)) {
-			status =3D BLK_STS_OK;
+	if (op_is_flush(bio->bi_opf)) {
+		if (WARN_ON_ONCE(bio_op(bio) !=3D REQ_OP_WRITE &&
+				 bio_op(bio) !=3D REQ_OP_ZONE_APPEND))
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
2.39.0

