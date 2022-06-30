Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7267CCCA473
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 20:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbiF3UnC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 16:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbiF3Um4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 16:42:56 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DAA6426
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 13:42:56 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UF76BX021139
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 13:42:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/zU7PuiJ1KZ8+CVYUOg4nHq63Q9/stHoIw4yuqAbJgE=;
 b=GzX0fwCPvDst6W+MHhoP5cIyjQQ42Dt5FWXyLp14pumO7yb0Nma1gx6jEa/eaHQ2Aeon
 3OuFSazJgTp3++dJT0uTfzpFU3iY8c8nDeGC7eFGE+Di05ZXI6Aa+R+DD92RGfCMDWcd
 fsQStzlV/7l0E5m6TmbITyy3qRo1QuyBrUw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h0dgqwy2u-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 13:42:55 -0700
Received: from twshared34609.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:53 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id D79595932DBF; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 07/12] block: allow copying pre-registered bvecs
Date:   Thu, 30 Jun 2022 13:42:07 -0700
Message-ID: <20220630204212.1265638-8-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fxJ4lyXEBH4OKpLTKWgFq6s0-fBQ5dMm
X-Proofpoint-GUID: fxJ4lyXEBH4OKpLTKWgFq6s0-fBQ5dMm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_14,2022-06-28_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

If a bio was initialized with bi_max_vecs, then append the requested
bvec instead of overriding it. This will allow mixing bvecs from
multiple sources.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index b0c85778257a..391cad726ff2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1130,12 +1130,25 @@ void __bio_release_pages(struct bio *bio, bool ma=
rk_dirty)
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
=20
+static void bio_copy_bvec(struct bio *bio, struct iov_iter *iter)
+{
+	memcpy(&bio->bi_io_vec[bio->bi_vcnt], iter->bvec,
+	       iter->nr_segs * sizeof(struct bio_vec));
+	bio->bi_vcnt +=3D iter->nr_segs;
+	bio->bi_iter.bi_size +=3D iov_iter_count(iter);
+}
+
 void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 {
 	size_t size =3D iov_iter_count(iter);
=20
 	WARN_ON_ONCE(bio->bi_max_vecs);
=20
+	if (bio->bi_max_vecs) {
+		bio_copy_bvec(bio, iter);
+		return;
+	}
+
 	if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {
 		struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
 		size_t max_sectors =3D queue_max_zone_append_sectors(q);
--=20
2.30.2

