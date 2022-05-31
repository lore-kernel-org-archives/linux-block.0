Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA96C433EF
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 19:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346378AbiEaTNv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 15:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346344AbiEaTNu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 15:13:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE3F674FC
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:13:50 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VFiPpV020101
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:13:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=2A9g7lOqg1/RobT9/8ycPm/h1/V/agiJy74TxI+fFok=;
 b=iVqxCtgBCcI0a/ow8V5LGvAmm8FK1XfIiuAWgM/BlivM7ptaoM08sQ7R/Q7ssloc352k
 kV0gzZYO21svDya6FhygZrBlSsaPTC/ytVnnfvIxP+ZBr7heYWlPwkmFMgtGDeh666wW
 QS2DLZHR1M3c7jMmKKUi32fT9Kb9DzDPZj4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gbfsj00an-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:13:49 -0700
Received: from twshared26317.07.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 31 May 2022 12:13:48 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id D306B4924B0B; Tue, 31 May 2022 12:11:38 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 01/11] block: fix infinite loop for invalid zone append
Date:   Tue, 31 May 2022 12:11:27 -0700
Message-ID: <20220531191137.2291467-2-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220531191137.2291467-1-kbusch@fb.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: WO4xLK-r-hHK0znm1N1Wrd7CdKdV0vvE
X-Proofpoint-ORIG-GUID: WO4xLK-r-hHK0znm1N1Wrd7CdKdV0vvE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_07,2022-05-30_03,2022-02-23_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Returning 0 early from __bio_iov_append_get_pages() for the
max_append_sectors warning just creates an infinite loop since 0 means
success, and the bio will never fill from the unadvancing iov_iter. We
could turn the return into an error value, but it will already be turned
into an error value later on, so just remove the warning. Clearly no one
ever hit it anyway.

Fixes: 0512a75b98f84 ("block: Introduce REQ_OP_ZONE_APPEND")
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a3893d80dccc..e249f6414fd5 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1228,9 +1228,6 @@ static int __bio_iov_append_get_pages(struct bio *b=
io, struct iov_iter *iter)
 	size_t offset;
 	int ret =3D 0;
=20
-	if (WARN_ON_ONCE(!max_append_sectors))
-		return 0;
-
 	/*
 	 * Move page array up in the allocated memory for the bio vecs as far a=
s
 	 * possible so that we can start filling biovecs from the beginning
--=20
2.30.2

