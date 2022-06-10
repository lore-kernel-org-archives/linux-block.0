Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515CBC43334
	for <linux-block@archiver.kernel.org>; Fri, 10 Jun 2022 20:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346385AbiFJUVU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jun 2022 16:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344532AbiFJUVT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jun 2022 16:21:19 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA2F2FAC1D
        for <linux-block@vger.kernel.org>; Fri, 10 Jun 2022 13:21:17 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25AHOMP8003663
        for <linux-block@vger.kernel.org>; Fri, 10 Jun 2022 13:21:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=qTth+ppG1ZjwXraXMR+U8AMElWzxev/HoVAAn9Cuo0g=;
 b=eEWccvzobcg0vZw/OguU4JlSyQCcm2H9YJ4Uh40cFBtk6auUnyjt95EUpW/F0Aza8R1Y
 4t3yZUkDcqYSFCWZAP8hIVmFV5iELmjqbvca7BR2/4PYP7jawS11+5TT3diWiNMPiMLw
 lqjwfW2ahm3nidn08hQ2mKYRq/t1pRcMizE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gmab0h84p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 10 Jun 2022 13:21:16 -0700
Received: from twshared5131.09.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 10 Jun 2022 13:21:12 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 467E84E9D68A; Fri, 10 Jun 2022 12:58:31 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCHv6 01/11] block: fix infinite loop for invalid zone append
Date:   Fri, 10 Jun 2022 12:58:20 -0700
Message-ID: <20220610195830.3574005-2-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220610195830.3574005-1-kbusch@fb.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: uyLLLrvoR3Ab0YT7T2R4Ax5KBG4zYSD_
X-Proofpoint-GUID: uyLLLrvoR3Ab0YT7T2R4Ax5KBG4zYSD_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_08,2022-06-09_02,2022-02-23_01
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index f92d0223247b..d481d5e4fe47 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1229,9 +1229,6 @@ static int __bio_iov_append_get_pages(struct bio *b=
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

