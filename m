Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1864FC4332F
	for <linux-block@archiver.kernel.org>; Thu, 10 Nov 2022 18:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiKJSpe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Nov 2022 13:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiKJSpd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2022 13:45:33 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B916764CE
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 10:45:32 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAIf5vF016747
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 10:45:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=bRGAEXe8GKpvjXjC0/98Zh/J75WOQ5GbUJ0TpUBKgug=;
 b=UqZAYq92lh0EqiRGYCanR/+HieWxl2ausqAVvLEumHnIXaUtSQ2oEbr8FztpzBid4vVk
 bQ9L2RJa0+zHnTwxyYEbQQ9ItY/N1xHR1np+k7Fd6Qfp/JJWkTGQwnebmDSKWxD5vKzI
 PUxdNjDjd46iNsO1F0hDqIB+ig443DUhWuAfc91pXpQbsgLnCTZqPXJctRZ+HLmpFR9I
 P9QNG7jvJemZUZftbUMbxcxOtknTlEE3GfmfiPCIuKxmdKfKoLn4Tdg3zBdIwTGlMfAY
 Aip8jOiP2Sjgo9BJRyoJUluSmjMKJEV215FXieEfZnZjf5Q2oaCzVjnB6BNKEPBLZV5h Uw== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kr3jpfdrt-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 10:45:31 -0800
Received: from twshared9088.05.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 10:45:28 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 93DDBB08CDF1; Thu, 10 Nov 2022 10:45:04 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
        <axboe@kernel.dk>
CC:     <stefanha@redhat.com>, <ebiggers@kernel.org>, <me@demsh.org>,
        <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 4/5] dm-integrity: set dma_alignment limit in io_hints
Date:   Thu, 10 Nov 2022 10:45:00 -0800
Message-ID: <20221110184501.2451620-5-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221110184501.2451620-1-kbusch@meta.com>
References: <20221110184501.2451620-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: kZq5GpnylRoUg6SpYNjYkGH0p5w3FxT4
X-Proofpoint-ORIG-GUID: kZq5GpnylRoUg6SpYNjYkGH0p5w3FxT4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_12,2022-11-09_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

This device mapper needs bio vectors to be sized and memory aligned to
the logical block size. Set the minimum required queue limit
accordingly.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/md/dm-integrity.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index aaf2472df6e5..e1e7b205573f 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3370,6 +3370,7 @@ static void dm_integrity_io_hints(struct dm_target =
*ti, struct queue_limits *lim
 		limits->logical_block_size =3D ic->sectors_per_block << SECTOR_SHIFT;
 		limits->physical_block_size =3D ic->sectors_per_block << SECTOR_SHIFT;
 		blk_limits_io_min(limits, ic->sectors_per_block << SECTOR_SHIFT);
+		limits->dma_alignment =3D limits->logical_block_size - 1;
 	}
 }
=20
--=20
2.30.2

