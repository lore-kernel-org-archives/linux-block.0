Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D3AC77B7C
	for <linux-block@archiver.kernel.org>; Mon,  1 May 2023 15:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjEAPdb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 May 2023 11:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjEAPda (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 11:33:30 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD7910E9
        for <linux-block@vger.kernel.org>; Mon,  1 May 2023 08:33:25 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34146sFn005201
        for <linux-block@vger.kernel.org>; Mon, 1 May 2023 08:33:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=zN8/BtsC/plhymDR0YrBtDqGFWFnMyTPOQP4TEUp75M=;
 b=S6ViWi9cUN+4SgBa2tW65yG8O+QQIE2M56i9br1p8gVXJgHHoJHN3aUBlL2PQ7aAPPP6
 mT7ZGljVKdOn9WibudbrkVZCkaQxyY8EAyDMNA42wy1uyArfFc3aJvsIoIodSMqITQh8
 IKYDAhYwvvIhHpBjJuZhPL1ftTboUiBFMHv7LqnNzRxS8w/8MwUBwvfeG1FHTwWV9F71
 Z+9KcCFMZPAAvFbvxLzYl1MlFjmqPkHa0ElSrgiwXPf2T/UnolqDbyfz3mWg84WlPYHQ
 QGDpoLGLuR0au6iEb7zKgZrIbIXPT6vhqoLtEqURZPvYZe6kA4Pq2bUOJf2gO6yOSwV7 uQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q923huhsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 01 May 2023 08:33:24 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 1 May 2023 08:33:23 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 46DA71777ADBD; Mon,  1 May 2023 08:33:07 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <joshi.k@samsung.com>, <axboe@kernel.dk>, <hch@lst.de>,
        <xiaoguang.wang@linux.alibaba.com>
CC:     Keith Busch <kbusch@kernel.org>
Subject: [RFC 1/3] nvme: skip block cgroups for passthrough commands
Date:   Mon, 1 May 2023 08:33:04 -0700
Message-ID: <20230501153306.537124-2-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230501153306.537124-1-kbusch@meta.com>
References: <20230501153306.537124-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: qJV3Dw-GEZvqyhy7HA0wpv6y3yLiTHk6
X-Proofpoint-ORIG-GUID: qJV3Dw-GEZvqyhy7HA0wpv6y3yLiTHk6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_08,2023-04-27_01,2023-02-09_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Passthrough requests don't go through the submit_bio() path, so all the
overhead of setting up the bio's cgroup is wasted cycles. Provide a path
to skip this setup.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c | 2 +-
 include/linux/bio.h       | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d24ea2e051564..3804e5205b42b 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -192,7 +192,7 @@ static int nvme_map_user_request(struct request *req,=
 u64 ubuffer,
 		goto out;
 	bio =3D req->bio;
 	if (bdev)
-		bio_set_dev(bio, bdev);
+		__bio_set_dev(bio, bdev);
=20
 	if (bdev && meta_buffer && meta_len) {
 		meta =3D nvme_add_user_metadata(req, meta_buffer, meta_len,
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d766be7152e15..bf003412653dc 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -509,12 +509,17 @@ static inline void bio_clone_blkg_association(struc=
t bio *dst,
 					      struct bio *src) { }
 #endif	/* CONFIG_BLK_CGROUP */
=20
-static inline void bio_set_dev(struct bio *bio, struct block_device *bde=
v)
+static inline void __bio_set_dev(struct bio *bio, struct block_device *b=
dev)
 {
 	bio_clear_flag(bio, BIO_REMAPPED);
 	if (bio->bi_bdev !=3D bdev)
 		bio_clear_flag(bio, BIO_BPS_THROTTLED);
 	bio->bi_bdev =3D bdev;
+}
+
+static inline void bio_set_dev(struct bio *bio, struct block_device *bde=
v)
+{
+	__bio_set_dev(bio, bdev);
 	bio_associate_blkg(bio);
 }
=20
--=20
2.34.1

