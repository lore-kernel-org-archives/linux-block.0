Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58CBC43217
	for <linux-block@archiver.kernel.org>; Thu, 10 Nov 2022 18:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiKJSpf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Nov 2022 13:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiKJSpe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2022 13:45:34 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD0E64CE
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 10:45:33 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAIf5vH016747
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 10:45:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=Ll0sgKlomAV+roxD3aMEq7jXr8qS91KLuWJSCi6hOAk=;
 b=XT40UE2+dcwVBJyQqp2dMh607UYRnv3AvwVRb1iTA9a7tUXzQwYCCdlHuDp/KESTe2AI
 YcgjvDJiVQO3++LuObHY2A90nzLXPkpNep6tM/D1bRjL09J5SswfCeSz/cjV9NKtt/mt
 AaQ8CUvDxBPvXn2MVqQap1MxYp32VbYbpIk/U/E2TCKpAkmefPUA1FgEwPHavZW0tcOk
 t8edFxZwrp5Yw8GnYyOmOxKuUsJF1eGoM92zdPmGZyMzsviEZAwT+e1mw5T0SnpQzvrv
 CIvDlrLulcN2TfPP3sraZm+jNPcjcTmfJ5W9boO+qTcU4Q2z27JBjJcnyWdqo3Ww2xFr 4Q== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kr3jpfdrt-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 10:45:32 -0800
Received: from twshared9088.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 10:45:29 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 40874B08CDF4; Thu, 10 Nov 2022 10:45:04 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
        <axboe@kernel.dk>
CC:     <stefanha@redhat.com>, <ebiggers@kernel.org>, <me@demsh.org>,
        <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 5/5] dm-log-writes: set dma_alignment limit in io_hints
Date:   Thu, 10 Nov 2022 10:45:01 -0800
Message-ID: <20221110184501.2451620-6-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221110184501.2451620-1-kbusch@meta.com>
References: <20221110184501.2451620-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: JA7bgonllFV0y60UgJKz_raTwVWap2jm
X-Proofpoint-ORIG-GUID: JA7bgonllFV0y60UgJKz_raTwVWap2jm
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
 drivers/md/dm-log-writes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 20fd688f72e7..178e13a5b059 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -875,6 +875,7 @@ static void log_writes_io_hints(struct dm_target *ti,=
 struct queue_limits *limit
 	limits->logical_block_size =3D bdev_logical_block_size(lc->dev->bdev);
 	limits->physical_block_size =3D bdev_physical_block_size(lc->dev->bdev)=
;
 	limits->io_min =3D limits->physical_block_size;
+	limits->dma_alignment =3D limits->logical_block_size - 1;
 }
=20
 #if IS_ENABLED(CONFIG_FS_DAX)
--=20
2.30.2

