Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B02C282C0
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 00:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724A7218A1
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 00:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MExa9BBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfAXAxq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 19:53:46 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:47082 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726235AbfAXAxq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 19:53:46 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0O0ofm4009225;
        Wed, 23 Jan 2019 16:53:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=39seH9BIGgwKLy34+cjto5LLTAO2AKserxzbhKE1J0w=;
 b=MExa9BBOykIjWViXcRs1p2jKLasV50Wip8NTbUfqAZzGABu/1/ciX9ZvZMLrAJaNySJY
 4Zqh7CGUJ6Fdxtbg1fJmkpVOB+SITDRdp9AXC19kmAG1bJi6mZAI1C41m79RPjBtOrLJ
 3hqd8NyZwVj90JQLFesX4w0hcXlcKenUS12WAZCjwGnZYyonDQlNLOsQWK7x77hhFBgc
 JQbWMds6Ouvs52THnB5HLyKG2haAxbXPddd6+CJ+H6zo4V1cJQ5iFkraFtNcoW7EJD9R
 /ompWRYxfOz2W4K4ogh0DL3py7J952peSo4NOY7s5WFbkYuO6oGCJzmGaVO+Ej1HeaEr 0A== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2q6w0khwwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 23 Jan 2019 16:53:42 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 23 Jan
 2019 16:53:41 -0800
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 23 Jan 2019 16:53:41 -0800
Received: from an-git01.marvell.com (unknown [10.80.127.22])
        by maili.marvell.com (Postfix) with ESMTP id 01AA13F703F;
        Wed, 23 Jan 2019 16:53:42 -0800 (PST)
From:   Zhoujie Wu <zjwu@marvell.com>
To:     <mb@lightnvm.io>, <linux-block@vger.kernel.org>,
        <hans.holmberg@cnexlabs.com>
CC:     <hongd@marvell.com>, Zhoujie Wu <zjwu@marvell.com>
Subject: [PATCH] lightnvm: pblk: ignore bad block wp for pblk_line_wp_is_unbalanced
Date:   Wed, 23 Jan 2019 16:55:14 -0800
Message-ID: <1548291314-27225-1-git-send-email-zjwu@marvell.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_12:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=757 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901240004
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The write pointer of the bad block could be 0 or undefined, ignore
the checking of the bad block wp for pblk_line_wp_is_unbalanced to
avoid fake warning.

Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
---
 drivers/lightnvm/pblk-recovery.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 5ee20da..e1fba98 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -312,21 +312,27 @@ static int pblk_line_wp_is_unbalanced(struct pblk *pblk,
 	struct nvm_chk_meta *chunk;
 	struct ppa_addr ppa;
 	u64 line_wp;
-	int pos, i;
+	int pos, i, v_blk;
 
-	rlun = &pblk->luns[0];
+	v_blk = find_first_zero_bit(line->blk_bitmap, lm->blk_per_line);
+	if (v_blk > lm->blk_per_line)
+		return 0;
+	rlun = &pblk->luns[v_blk];
 	ppa = rlun->bppa;
 	pos = pblk_ppa_to_pos(geo, ppa);
 	chunk = &line->chks[pos];
 
 	line_wp = chunk->wp;
 
-	for (i = 1; i < lm->blk_per_line; i++) {
+	for (i = v_blk + 1; i < lm->blk_per_line; i++) {
 		rlun = &pblk->luns[i];
 		ppa = rlun->bppa;
 		pos = pblk_ppa_to_pos(geo, ppa);
 		chunk = &line->chks[pos];
 
+		if (test_bit(pos, line->blk_bitmap))
+			continue;
+
 		if (chunk->wp > line_wp)
 			return 1;
 		else if (chunk->wp < line_wp)
-- 
1.9.1

