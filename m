Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA30DC4167B
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 17:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357219AbiBNRol (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 12:44:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357217AbiBNRoj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 12:44:39 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995F865482
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 09:44:28 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 21EHPrtw019408
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 09:44:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=LSdyRHAc+fsIsWQJgyJviG9+Wzpmsxt7o7RJSYAE/qo=;
 b=a2NSIZRDQjUIc/rxJ19LXaDPQ1pgcWrQ8PPmaQ8O6UV7g2p3zJCPOt7WEQUXKDEpA3/X
 7KfKna1RI81sgGaSsWMWHh6EeyXZwkS9V2FZ8jhdz93kE8EYaDOfxTfkIxDqQRZPOrm5
 IKbCrCeR+PquW4gFE1y70dIoI7zvRMIjNNY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3e7ufp85xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 09:44:27 -0800
Received: from twshared14630.35.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 09:44:26 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 9B758ABBD0F9; Mon, 14 Feb 2022 09:44:09 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <io-uring@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v1 03/14] mm: add noio support in filemap_get_pages
Date:   Mon, 14 Feb 2022 09:43:52 -0800
Message-ID: <20220214174403.4147994-4-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220214174403.4147994-1-shr@fb.com>
References: <20220214174403.4147994-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9TrRfESuULAiUjt5VVqN8I-AMBTQSMeG
X-Proofpoint-GUID: 9TrRfESuULAiUjt5VVqN8I-AMBTQSMeG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_07,2022-02-14_03,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=959
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds noio support for async buffered writes in filemap_get_pages.
The idea is to handle the failure gracefully and return -EAGAIN if we
can't get the memory quickly.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 mm/filemap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d2fb817c0845..0ff4278c3961 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2591,10 +2591,15 @@ static int filemap_get_pages(struct kiocb *iocb, =
struct iov_iter *iter,
 		filemap_get_read_batch(mapping, index, last_index, fbatch);
 	}
 	if (!folio_batch_count(fbatch)) {
+		unsigned int pflags;
+
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
-			return -EAGAIN;
+			pflags =3D memalloc_noio_save();
 		err =3D filemap_create_folio(filp, mapping,
 				iocb->ki_pos >> PAGE_SHIFT, fbatch);
+		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
+			memalloc_noio_restore(pflags);
+
 		if (err =3D=3D AOP_TRUNCATED_PAGE)
 			goto retry;
 		return err;
--=20
2.30.2

