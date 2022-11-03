Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB8AC43217
	for <linux-block@archiver.kernel.org>; Thu,  3 Nov 2022 15:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiKCP0P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Nov 2022 11:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiKCP0O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Nov 2022 11:26:14 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ED81A213
        for <linux-block@vger.kernel.org>; Thu,  3 Nov 2022 08:26:14 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2A3Ehd6s026649
        for <linux-block@vger.kernel.org>; Thu, 3 Nov 2022 08:26:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=aqbEu7FwfUoPtiNVDBTBB/4tMMl0CFp26nCKV0L1wz0=;
 b=XcF/B2vl8J6JDXEg6039YQL5N+u2aZfmH8NXFW4GbEKdjbdK+tPkiGwETUpFab7M8cgD
 ngJcQ+j8TZVLG1iDEEcS7dHZG5HT4QqySOqDiMQ/PhY1Dkw5kjaX2Vd3tkjUWU8ptNmg
 UD+a3F/yIXsH78HKmiTjC8tkKNxeJSKDcfN3iwjPrZ6ZtW6v7uYOImKIaVXxKax7BKO+
 1zMzBq1RvVMPDqc3w7f4I/fDS0uC4JxoWO7aZ/pArlQ+3vqhBwL+nlKW18fzgQbAk0K8
 VNrqbR67zjUJTQs/0dCsj7HtuEMHbEzoa0R7btLIrMlmSapZAwPfm2g3xPdHROCOxMhZ 6w== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3kkshd3xke-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 03 Nov 2022 08:26:13 -0700
Received: from twshared25017.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 08:26:11 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 6AAF0AA9A07C; Thu,  3 Nov 2022 08:26:00 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
        <axboe@kernel.dk>
CC:     <stefanha@redhat.com>, <ebiggers@kernel.org>, <me@demsh.org>,
        <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/3] dm-crypt: provide dma_alignment limit in io_hints
Date:   Thu, 3 Nov 2022 08:25:58 -0700
Message-ID: <20221103152559.1909328-3-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221103152559.1909328-1-kbusch@meta.com>
References: <20221103152559.1909328-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: uYr3rA_vJ4HnCHBiHZJWWWvuNbu6aYfq
X-Proofpoint-GUID: uYr3rA_vJ4HnCHBiHZJWWWvuNbu6aYfq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

This device mapper needs bio vectors to be sized and memory aligned to
the logical block size. Set the minimum required queue limit
accordingly.

Fixes: b1a000d3b8ec5 ("block: relax direct io memory alignment")
Reportred-by: Eric Biggers <ebiggers@kernel.org>
Reported-by: Dmitrii Tcvetkov <me@demsh.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/md/dm-crypt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 159c6806c19b..2653516bcdef 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -3630,6 +3630,7 @@ static void crypt_io_hints(struct dm_target *ti, st=
ruct queue_limits *limits)
 	limits->physical_block_size =3D
 		max_t(unsigned, limits->physical_block_size, cc->sector_size);
 	limits->io_min =3D max_t(unsigned, limits->io_min, cc->sector_size);
+	limits->dma_alignment =3D limits->logical_block_size - 1;
 }
=20
 static struct target_type crypt_target =3D {
--=20
2.30.2

