Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680CFC433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Nov 2022 18:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiKJSpS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Nov 2022 13:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiKJSpR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2022 13:45:17 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A05C10067
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 10:45:16 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2AAIf51h024763
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 10:45:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=UHEhmaMtY8UgsBKpwlSNUDAWJ7UAF41+m7Jc670rni0=;
 b=Fp+o74kupHeSQAqJSwxMyrafVmwtPttFZUR4SpvhdtoNwU1lGizuMhkdBbukMUXY1LoV
 ndDbYynCLlFHY3Hpq4L2AFw+abeJlDTJRUuq+EaU5PvyLr4uozewrCpw4X9yNuWSQnUK
 jWa4yrOWN1F/ihKYSU8EgWoynitqS7cywyE9B1SqyEx3LBr+A/UHZ/h3x89WFbptl0Ya
 /wnNm7RqrtSyB8Osk2nZ3tlC94pDjA1mxyMX4zWrShOFtdPGglNValJHwNDeGhkuoAZO
 hxgxxB7YFMQBYkhxyDwf1PRJxI4fx7zyYKwDa+P0FmEav0TU8xEoBEPREvGmDSxfExGB Vw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3krmwrfekb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 10:45:15 -0800
Received: from twshared9088.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 10:45:14 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 2BFD2B08CDE8; Thu, 10 Nov 2022 10:45:02 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
        <axboe@kernel.dk>
CC:     <stefanha@redhat.com>, <ebiggers@kernel.org>, <me@demsh.org>,
        <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 2/5] dm-crypt: provide dma_alignment limit in io_hints
Date:   Thu, 10 Nov 2022 10:44:58 -0800
Message-ID: <20221110184501.2451620-3-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221110184501.2451620-1-kbusch@meta.com>
References: <20221110184501.2451620-1-kbusch@meta.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: yELAMZbh_ewgeb2VqqunOxXlfTCP9q_O
X-Proofpoint-ORIG-GUID: yELAMZbh_ewgeb2VqqunOxXlfTCP9q_O
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
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

Link: https://lore.kernel.org/linux-block/20221101001558.648ee024@xps.demsh=
.org/
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
@@ -3630,6 +3630,7 @@ static void crypt_io_hints(struct dm_target *ti, stru=
ct queue_limits *limits)
 	limits->physical_block_size =3D
 		max_t(unsigned, limits->physical_block_size, cc->sector_size);
 	limits->io_min =3D max_t(unsigned, limits->io_min, cc->sector_size);
+	limits->dma_alignment =3D limits->logical_block_size - 1;
 }
=20
 static struct target_type crypt_target =3D {
--=20
2.30.2

