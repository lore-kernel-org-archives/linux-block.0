Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4288C25B0E
	for <linux-block@archiver.kernel.org>; Fri,  5 Aug 2022 16:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbiHEQ0E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Aug 2022 12:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241114AbiHEQZq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Aug 2022 12:25:46 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FBC11D
        for <linux-block@vger.kernel.org>; Fri,  5 Aug 2022 09:25:10 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 275G6sTP012179
        for <linux-block@vger.kernel.org>; Fri, 5 Aug 2022 09:25:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/ZWLqbL5tGSYE5Rcc02OrOw2EnF/iFGjGINklpZXyq8=;
 b=gQ1S6EffymZ1w7OH/pjBevA/cscGar7djsJcGQaB/vIz3x0MZAGdtoHX7Jhibe/IrZH4
 sO5iWYijReq3w6x/xavEVCu8+7oCPsriZh91mGmDIghvRaVWI6UtwvtM+jzf36cV+S4g
 l5MRwaDQ3ydjQij8SJAjAsNG8e7jXq0ND0A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hs3cf1d84-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 05 Aug 2022 09:25:10 -0700
Received: from twshared22934.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 09:25:02 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 9F1D7703750A; Fri,  5 Aug 2022 09:24:46 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <io-uring@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Team <Kernel-team@fb.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 5/7] io_uring: introduce file slot release helper
Date:   Fri, 5 Aug 2022 09:24:42 -0700
Message-ID: <20220805162444.3985535-6-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220805162444.3985535-1-kbusch@fb.com>
References: <20220805162444.3985535-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rJmfQQeCeXXsNG7FKQ4lCZWlPKz7M0lj
X-Proofpoint-GUID: rJmfQQeCeXXsNG7FKQ4lCZWlPKz7M0lj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_09,2022-08-05_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Releasing the pre-registered file follows a repeated pattern. Introduce
a helper to make it easier to add more complexity to this resource in
the future.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 io_uring/filetable.c | 33 +++++++++++++++++++++------------
 io_uring/filetable.h |  3 +++
 io_uring/rsrc.c      |  5 +----
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/io_uring/filetable.c b/io_uring/filetable.c
index 7b473259f3f4..1b8db1918678 100644
--- a/io_uring/filetable.c
+++ b/io_uring/filetable.c
@@ -76,19 +76,13 @@ static int io_install_fixed_file(struct io_ring_ctx *=
ctx, struct file *file,
 	file_slot =3D io_fixed_file_slot(&ctx->file_table, slot_index);
=20
 	if (file_slot->file_ptr) {
-		struct file *old_file;
-
 		ret =3D io_rsrc_node_switch_start(ctx);
 		if (ret)
 			goto err;
=20
-		old_file =3D (struct file *)(file_slot->file_ptr & FFS_MASK);
-		ret =3D io_queue_rsrc_removal(ctx->file_data, slot_index,
-					    ctx->rsrc_node, old_file);
+		ret =3D io_file_slot_queue_removal(ctx, file_slot);
 		if (ret)
 			goto err;
-		file_slot->file_ptr =3D 0;
-		io_file_bitmap_clear(&ctx->file_table, slot_index);
 		needs_switch =3D true;
 	}
=20
@@ -148,7 +142,6 @@ int io_fixed_fd_install(struct io_kiocb *req, unsigne=
d int issue_flags,
 int io_fixed_fd_remove(struct io_ring_ctx *ctx, unsigned int offset)
 {
 	struct io_fixed_file *file_slot;
-	struct file *file;
 	int ret;
=20
 	if (unlikely(!ctx->file_data))
@@ -164,13 +157,10 @@ int io_fixed_fd_remove(struct io_ring_ctx *ctx, uns=
igned int offset)
 	if (!file_slot->file_ptr)
 		return -EBADF;
=20
-	file =3D (struct file *)(file_slot->file_ptr & FFS_MASK);
-	ret =3D io_queue_rsrc_removal(ctx->file_data, offset, ctx->rsrc_node, f=
ile);
+	ret =3D io_file_slot_queue_removal(ctx, file_slot);
 	if (ret)
 		return ret;
=20
-	file_slot->file_ptr =3D 0;
-	io_file_bitmap_clear(&ctx->file_table, offset);
 	io_rsrc_node_switch(ctx, ctx->file_data);
 	return 0;
 }
@@ -191,3 +181,22 @@ int io_register_file_alloc_range(struct io_ring_ctx =
*ctx,
 	io_file_table_set_alloc_range(ctx, range.off, range.len);
 	return 0;
 }
+
+int io_file_slot_queue_removal(struct io_ring_ctx *ctx,
+			       struct io_fixed_file *file_slot)
+{
+	u32 slot_index =3D file_slot - ctx->file_table.files;
+	struct file *file;
+	int ret;
+
+	file =3D (struct file *)(file_slot->file_ptr & FFS_MASK);
+	ret =3D io_queue_rsrc_removal(ctx->file_data, slot_index,
+				    ctx->rsrc_node, file);
+	if (ret)
+		return ret;
+
+	file_slot->file_ptr =3D 0;
+	io_file_bitmap_clear(&ctx->file_table, slot_index);
+
+	return 0;
+}
diff --git a/io_uring/filetable.h b/io_uring/filetable.h
index ff3a712e11bf..e52ecf359199 100644
--- a/io_uring/filetable.h
+++ b/io_uring/filetable.h
@@ -34,6 +34,9 @@ int io_fixed_fd_remove(struct io_ring_ctx *ctx, unsigne=
d int offset);
 int io_register_file_alloc_range(struct io_ring_ctx *ctx,
 				 struct io_uring_file_index_range __user *arg);
=20
+int io_file_slot_queue_removal(struct io_ring_ctx *ctx,
+			       struct io_fixed_file *file_slot);
+
 unsigned int io_file_get_flags(struct file *file);
=20
 static inline void io_file_bitmap_clear(struct io_file_table *table, int=
 bit)
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 59704b9ac537..1f10eecad4d7 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -469,12 +469,9 @@ static int __io_sqe_files_update(struct io_ring_ctx =
*ctx,
 		file_slot =3D io_fixed_file_slot(&ctx->file_table, i);
=20
 		if (file_slot->file_ptr) {
-			file =3D (struct file *)(file_slot->file_ptr & FFS_MASK);
-			err =3D io_queue_rsrc_removal(data, i, ctx->rsrc_node, file);
+			err =3D io_file_slot_queue_removal(ctx, file_slot);
 			if (err)
 				break;
-			file_slot->file_ptr =3D 0;
-			io_file_bitmap_clear(&ctx->file_table, i);
 			needs_switch =3D true;
 		}
 		if (fd !=3D -1) {
--=20
2.30.2

