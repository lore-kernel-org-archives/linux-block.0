Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8884C282C6
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 19:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A748C20663
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 19:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="os3x0oP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbfAXTqL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:46:11 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:37008 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731886AbfAXTqK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 14:46:10 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0OJjamP013929;
        Thu, 24 Jan 2019 11:46:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=sggpkhd2/Apq2RpyAMuSG3wxrUGEyghIdW8Q0VDSFtw=;
 b=os3x0oP+dkvaPQGG1KwkheiVIeINebKmtr9yyVvkLRFVNl/VoK9UuH4stc3ilksHtYw3
 CBqnpBGQrpjiKVGmlFpGLDSI7zW3DP80a9qn232DktDkFH74mVWR1iNV8vLjkENDTqsL
 m/SBrwstmZDCuGJRLerC5xG1M44S3u/2/g2A2mceL8kLHMBEKtydZSMx9lEv0vNqZ1HN
 MftBVGNvfx0tsFswEPAx/tpwzWdEz4Z6PeDzCWBR5mD1J8OgsFXb0CJHhLGcb6vpIYZK
 wdhXz3ZkW/1LCSpQ/NWyXQU1W8JjrD2rU+s2H712NpqzOIyBeypVsGydPIzXEziBJShv PQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2q7jdrrg88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 24 Jan 2019 11:46:07 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 24 Jan
 2019 11:46:06 -0800
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 24 Jan 2019 11:46:06 -0800
Received: from an-git01.marvell.com (unknown [10.80.127.22])
        by maili.marvell.com (Postfix) with ESMTP id 01DA53F7041;
        Thu, 24 Jan 2019 11:46:07 -0800 (PST)
From:   Zhoujie Wu <zjwu@marvell.com>
To:     <mb@lightnvm.io>, <linux-block@vger.kernel.org>,
        <javier@javigon.com>
CC:     <hongd@marvell.com>, Zhoujie Wu <zjwu@marvell.com>
Subject: [PATCH v2] lightnvm: pblk: ignore bad block wp for pblk_line_wp_is_unbalanced
Date:   Thu, 24 Jan 2019 11:47:40 -0800
Message-ID: <1548359260-11005-1-git-send-email-zjwu@marvell.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-24_11:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=872 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901240134
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The write pointer of the bad block could be 0 or undefined, ignore
the checking of the bad block wp for pblk_line_wp_is_unbalanced to
avoid fake warning.

Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
---
v2: changed according to Javier's comments.

 drivers/lightnvm/pblk-recovery.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 6761d2a..3a3ca95 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -312,21 +312,27 @@ static int pblk_line_wp_is_unbalanced(struct pblk *pblk,
 	struct nvm_chk_meta *chunk;
 	struct ppa_addr ppa;
 	u64 line_wp;
-	int pos, i;
+	int pos, i, bit;
 
-	rlun = &pblk->luns[0];
+	bit = find_first_zero_bit(line->blk_bitmap, lm->blk_per_line);
+	if (bit > lm->blk_per_line)
+		return 0;
+	rlun = &pblk->luns[bit];
 	ppa = rlun->bppa;
 	pos = pblk_ppa_to_pos(geo, ppa);
 	chunk = &line->chks[pos];
 
 	line_wp = chunk->wp;
 
-	for (i = 1; i < lm->blk_per_line; i++) {
+	for (i = bit + 1; i < lm->blk_per_line; i++) {
 		rlun = &pblk->luns[i];
 		ppa = rlun->bppa;
 		pos = pblk_ppa_to_pos(geo, ppa);
 		chunk = &line->chks[pos];
 
+		if (chunk->state & NVM_CHK_ST_OFFLINE)
+			continue;
+
 		if (chunk->wp > line_wp)
 			return 1;
 		else if (chunk->wp < line_wp)
-- 
1.9.1

