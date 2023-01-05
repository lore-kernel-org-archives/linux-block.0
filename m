Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7A5C3DA7D
	for <linux-block@archiver.kernel.org>; Thu,  5 Jan 2023 20:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbjAEUv4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Jan 2023 15:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjAEUvz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Jan 2023 15:51:55 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA594FCE7
        for <linux-block@vger.kernel.org>; Thu,  5 Jan 2023 12:51:54 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305Fn25l000920
        for <linux-block@vger.kernel.org>; Thu, 5 Jan 2023 12:51:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=FEpjTYucHDuh1QyR744Eg07p4aVB9+zGkL+1xjoKI/c=;
 b=npTqzWoTTdgBvadd0/gUD6jTYo5Ncn5FWWF3q6aI7/99dqr0Tz5ZG1cpEEJryT7bJRc6
 J3WKjlZpQsQH1xqI45lGkuRI7WdvC+b+NwzfcAdCKO2dPINohHfV1Tkj19t3QfJP8MfU
 BsVZHQETXfYQhekOFa9EQQLA7K+yOixCNGDxqexvWM2+hnyn6lLFbretoeMAP3hyILdA
 LxRmaKG8Y+TlmsbkSqRi3pJ260NWnR5bozeVAcmxPO6ZnmHVtyRvqPdH339k0fWYJ4+w
 ddAjb2ChLZK0MYT0lKrLy9N8zSYOlMrv0SsccYGhv7JR4xL3jcIKN7K9PB3zlJr5cvK0 BQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mwkfdpsmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 05 Jan 2023 12:51:53 -0800
Received: from twshared0337.04.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 5 Jan 2023 12:51:53 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 4DB51E45DCBF; Thu,  5 Jan 2023 12:51:47 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC:     <hch@lst.de>, <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 2/2] block: save user max_sectors limit
Date:   Thu, 5 Jan 2023 12:51:46 -0800
Message-ID: <20230105205146.3610282-3-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230105205146.3610282-1-kbusch@meta.com>
References: <20230105205146.3610282-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 7nD9Y_hNEIyJRbd2Vmrzf7vmSokVPWde
X-Proofpoint-ORIG-GUID: 7nD9Y_hNEIyJRbd2Vmrzf7vmSokVPWde
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_12,2023-01-05_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The user can set the max_sectors limit to any valid value via sysfs
/sys/block/<dev>/queue/max_sectors_kb attribute. If the device limits
are ever rescanned, though, the limit reverts back to the potentially
artificially low BLK_DEF_MAX_SECTORS value.

Preserve the user's setting as the max_sectors limit as long as it's
valid. The user can reset back to defaults by writing 0 to the sysfs
file.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 Documentation/ABI/stable/sysfs-block |  3 ++-
 block/blk-settings.c                 |  9 +++++++--
 block/blk-sysfs.c                    | 21 +++++++++++++++------
 include/linux/blkdev.h               |  1 +
 4 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/sta=
ble/sysfs-block
index cd14ecb3c9a5a..ac1e519272aa2 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -432,7 +432,8 @@ Contact:	linux-block@vger.kernel.org
 Description:
 		[RW] This is the maximum number of kilobytes that the block
 		layer will allow for a filesystem request. Must be smaller than
-		or equal to the maximum size allowed by the hardware.
+		or equal to the maximum size allowed by the hardware. Write 0
+		to use default kernel settings.
=20
=20
 What:		/sys/block/<disk>/queue/max_segment_size
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9875ca131eb0c..9c9713c9269cc 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -40,7 +40,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->virt_boundary_mask =3D 0;
 	lim->max_segment_size =3D BLK_MAX_SEGMENT_SIZE;
 	lim->max_sectors =3D lim->max_hw_sectors =3D BLK_SAFE_MAX_SECTORS;
-	lim->max_dev_sectors =3D 0;
+	lim->max_user_sectors =3D lim->max_dev_sectors =3D 0;
 	lim->chunk_sectors =3D 0;
 	lim->max_write_zeroes_sectors =3D 0;
 	lim->max_zone_append_sectors =3D 0;
@@ -135,7 +135,12 @@ void blk_queue_max_hw_sectors(struct request_queue *=
q, unsigned int max_hw_secto
 	limits->max_hw_sectors =3D max_hw_sectors;
=20
 	max_sectors =3D min_not_zero(max_hw_sectors, limits->max_dev_sectors);
-	max_sectors =3D min(max_sectors, BLK_DEF_MAX_SECTORS);
+
+	if (limits->max_user_sectors)
+		max_sectors =3D min(max_sectors, limits->max_user_sectors);
+	else
+		max_sectors =3D min(max_sectors, BLK_DEF_MAX_SECTORS);
+
 	max_sectors =3D round_down(max_sectors,
 				 limits->logical_block_size >> SECTOR_SHIFT);
 	limits->max_sectors =3D max_sectors;
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 93d9e9c9a6ea8..5486b6c57f6b8 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -239,19 +239,28 @@ static ssize_t queue_zone_append_max_show(struct re=
quest_queue *q, char *page)
 static ssize_t
 queue_max_sectors_store(struct request_queue *q, const char *page, size_=
t count)
 {
-	unsigned long max_sectors_kb,
+	unsigned long var;
+	unsigned int max_sectors_kb,
 		max_hw_sectors_kb =3D queue_max_hw_sectors(q) >> 1,
 			page_kb =3D 1 << (PAGE_SHIFT - 10);
-	ssize_t ret =3D queue_var_store(&max_sectors_kb, page, count);
+	ssize_t ret =3D queue_var_store(&var, page, count);
=20
 	if (ret < 0)
 		return ret;
=20
-	max_hw_sectors_kb =3D min_not_zero(max_hw_sectors_kb, (unsigned long)
+	max_sectors_kb =3D (unsigned int)var;
+	max_hw_sectors_kb =3D min_not_zero(max_hw_sectors_kb,
 					 q->limits.max_dev_sectors >> 1);
-
-	if (max_sectors_kb > max_hw_sectors_kb || max_sectors_kb < page_kb)
-		return -EINVAL;
+	if (max_sectors_kb =3D=3D 0) {
+		q->limits.max_user_sectors =3D 0;
+		max_sectors_kb =3D min(max_hw_sectors_kb,
+				     BLK_DEF_MAX_SECTORS >> 1);
+	} else {
+		if (max_sectors_kb > max_hw_sectors_kb ||
+		    max_sectors_kb < page_kb)
+			return -EINVAL;
+		q->limits.max_user_sectors =3D max_sectors_kb << 1;
+	}
=20
 	spin_lock_irq(&q->queue_lock);
 	q->limits.max_sectors =3D max_sectors_kb << 1;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2b85161e22561..b87ed829ab941 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -288,6 +288,7 @@ struct queue_limits {
 	unsigned int		max_dev_sectors;
 	unsigned int		chunk_sectors;
 	unsigned int		max_sectors;
+	unsigned int		max_user_sectors;
 	unsigned int		max_segment_size;
 	unsigned int		physical_block_size;
 	unsigned int		logical_block_size;
--=20
2.30.2

