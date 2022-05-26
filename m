Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F2CC433FE
	for <linux-block@archiver.kernel.org>; Thu, 26 May 2022 01:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241026AbiEZBGj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 May 2022 21:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiEZBGg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 May 2022 21:06:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DB89156B
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 18:06:35 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PGtdWU011318
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 18:06:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=chofrzRtFagHUfFlePvR1tikCZVtDw9mOGJhX8Mi6kI=;
 b=ReXw0BazdvpA+dHc8KPzG0ZWotYCo5CRXRwFlhqT50Z4FQuFD5Jdeeb5X3vqrJrU5ich
 SMa64y0IMKhiG6vluKdHYbOK/t4HL6VkKYFDXmqxU3Oo02xUmE/HjQLvBo/I6fiH76VL
 J4YDs8bvj2I5jdEWKqSb0Lp9i1RJgRxyWqE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g93uj23be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 18:06:34 -0700
Received: from twshared10560.18.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 25 May 2022 18:06:34 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id E3B9345C0BC8; Wed, 25 May 2022 18:06:19 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 1/9] block: fix infiniate loop for invalid zone append
Date:   Wed, 25 May 2022 18:06:05 -0700
Message-ID: <20220526010613.4016118-2-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526010613.4016118-1-kbusch@fb.com>
References: <20220526010613.4016118-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: oh4n5R_v625QnRsqS2pxIeDq9WanKta1
X-Proofpoint-ORIG-GUID: oh4n5R_v625QnRsqS2pxIeDq9WanKta1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_07,2022-05-25_02,2022-02-23_01
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

