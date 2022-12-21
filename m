Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A37C4332F
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 16:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbiLUQ3x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 11:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbiLUQ3v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 11:29:51 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D95C10568
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 08:29:51 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BL8nDcr015931
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 08:29:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=x4X/tb8y9WMZHzUJmgZ0hhCdLnOwJASLg4Ay7tIx8wA=;
 b=KyHMhcuEbK6mMiBfCFZXzsjqXw7LA2Mu+37bLv0ev+7ACOUi4ZdUzap3Mn0MkFAEWeu4
 Gn9yCS6M9f2lhGFJFGt7O3acWfUvbLV+Vy7CRwQgzuQeqDTMv5rRPofVNv4zC6JbC8yP
 PvfoNHMLxJK+cMOks4PArcuhi95AxfpYZkTGiD4XR6Ci4oi2rqIB5V957+hW+iGf9p4C
 ESkzRdZAGUCFCefjEsgVF01TUzZyNU8lpM+3/lAC7TDlb5ruB8Rcwr9D7pgDpNmNqBXZ
 UBA+35o6gxNIgEr3oyDdzOjzWjdIky16IlPjJoslwR6biDItPoDe5apypebzyZqfjVv8 tQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3mkd0a1uu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 08:29:50 -0800
Received: from twshared41876.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 21 Dec 2022 08:29:48 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id E032FD4FCA3C; Wed, 21 Dec 2022 08:29:39 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC:     <hch@lst.de>, <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH] block: save user max_sectors limit
Date:   Wed, 21 Dec 2022 08:27:58 -0800
Message-ID: <20221221162758.407742-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: J2U2uRXnKNYktyluLlCHef9rWIsntqRx
X-Proofpoint-GUID: J2U2uRXnKNYktyluLlCHef9rWIsntqRx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_08,2022-12-21_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The user can set the max_sectors limit to any valid value via sysfs
/sys/block/<dev>/queue/max_sectors_kb attribute. If the device limits
are ever rescanned, though, the limit reverts back to the potentially
artificially low BLK_DEF_MAX_SECTORS value.

Preserve the user's setting as long as it's valid and greater than the
default.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-settings.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 0477c4d527fee..523348926a800 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -135,7 +135,8 @@ void blk_queue_max_hw_sectors(struct request_queue *q=
, unsigned int max_hw_secto
 	limits->max_hw_sectors =3D max_hw_sectors;
=20
 	max_sectors =3D min_not_zero(max_hw_sectors, limits->max_dev_sectors);
-	max_sectors =3D min_t(unsigned int, max_sectors, BLK_DEF_MAX_SECTORS);
+	max_sectors =3D min_t(unsigned int, max_sectors, max(limits->max_sector=
s,
+							  BLK_DEF_MAX_SECTORS));
 	max_sectors =3D round_down(max_sectors,
 				 limits->logical_block_size >> SECTOR_SHIFT);
 	limits->max_sectors =3D max_sectors;
--=20
2.30.2

