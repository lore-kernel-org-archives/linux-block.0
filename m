Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A6936D4EF;
	Sat, 29 Nov 2025 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764455748; cv=none; b=qTY0KJjN79wMDmJOG7VqRR3l7D4SUM4Obx+FyGQ65x9MCatCucbYtAdEX1Oz/JNIDJ1Dq2cXN5dl5IFuhHdKzjuzlzi3LcYV+dWJE4tOyEZr2naG/KR+5nVnhNuNF3dGNsWNKWw8N9fgsDodCvtisG6+vd4WRF/Qxen3Sv58OvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764455748; c=relaxed/simple;
	bh=xgfpRcrN5A1W/gIzotg2hSXwo+V5fx8Bklg4nPj1Vdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HKQThxClQMBrwin19CPHKk0Dxmh58zeqz9Itrs1DO1EEQOI3YPdTVGb25PXKQVVkFxU1DofFNo2ta4wZeT/UbRHPJ5K7tyueyp36ovMFzFJIKgS3mG6nHRzl6ZJHIochTByposOdu/iQi5vxWa8dibJNdzaluoEbPtR8scHvLzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0hTdFkqs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0hTdFkqs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PT4jE26rH3nV8AcK2onw4vWuj/HBKFDLwigzaTBWvLk=; b=0hTdFkqsEHMYtMCCbv+t/Od/Im
	qFsMHzW0Ff945qYwfrUl9IEBQa8msD/Xc+SwKRsmAEHyH0SDrEEFMp2LkxhHHKMJtA9VQEdTIhRjJ
	gMW/nHXOX7HDTkWIeD7hsaPz5Zn90ftGFePXDqElGdYwyt3oForxkDK/pitS+U3/OwAazY1uFp+6j
	yajhnF9yXjXYlC64GsLGFbsglxDX9sjzVfdNpZolx6PIAa2gPcqa8ZjeBlXATUr6etYUIEk/A82gn
	zxEticobHdpf0gnQazO2dG4rIOA0HduoD78I3/Z41Y2nKSHzVS/V2Iv3fBRanzw6tkM3SQP5XG5Vz
	0BCjtAoQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPTXb-00000001qKR-1tDR;
	Sat, 29 Nov 2025 22:35:43 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH] block/rnbd: correct all kernel-doc complaints
Date: Sat, 29 Nov 2025 14:35:42 -0800
Message-ID: <20251129223542.2047020-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix all kernel-doc warnings in rnbd-proto.h:
- use correct enum name in kdoc comment
- mark several struct members as "/* private: */" so that no kdoc is
  required for them
- don't use "/**" for a non-kernel-doc comment
- use the correct struct member name for "dev_name"
- use " *" for a blank kernel-doc line

Fixes these warnings:
Warning: drivers/block/rnbd/rnbd-proto.h:41 expecting prototype for
 enum rnbd_msg_types. Prototype was for enum rnbd_msg_type instead
Warning: drivers/block/rnbd/rnbd-proto.h:50 struct member '__padding'
 not described in 'rnbd_msg_hdr'
Warning: drivers/block/rnbd/rnbd-proto.h:53 This comment starts with
 '/**', but isn't a kernel-doc comment.
 * We allow to map RO many times and RW only once. We allow to map yet another
Warning: drivers/block/rnbd/rnbd-proto.h:81 struct member 'reserved'
 not described in 'rnbd_msg_sess_info'
Warning: drivers/block/rnbd/rnbd-proto.h:92 struct member 'reserved'
 not described in 'rnbd_msg_sess_info_rsp'
Warning: drivers/block/rnbd/rnbd-proto.h:107 struct member 'resv1'
 not described in 'rnbd_msg_open'
Warning: drivers/block/rnbd/rnbd-proto.h:107 struct member 'dev_name'
 not described in 'rnbd_msg_open'
Warning: drivers/block/rnbd/rnbd-proto.h:107 struct member 'reserved'
 not described in 'rnbd_msg_open'
Warning: drivers/block/rnbd/rnbd-proto.h:158 struct member 'reserved'
 not described in 'rnbd_msg_open_rsp'
Warning: drivers/block/rnbd/rnbd-proto.h:189 bad line:

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Md. Haris Iqbal <haris.iqbal@ionos.com>
Cc: Jack Wang <jinpu.wang@ionos.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 drivers/block/rnbd/rnbd-proto.h |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- linux-next-20251128.orig/drivers/block/rnbd/rnbd-proto.h
+++ linux-next-20251128/drivers/block/rnbd/rnbd-proto.h
@@ -24,7 +24,7 @@
 #define RTRS_PORT 1234
 
 /**
- * enum rnbd_msg_types - RNBD message types
+ * enum rnbd_msg_type - RNBD message types
  * @RNBD_MSG_SESS_INFO:	initial session info from client to server
  * @RNBD_MSG_SESS_INFO_RSP:	initial session info from server to client
  * @RNBD_MSG_OPEN:		open (map) device request
@@ -47,10 +47,11 @@ enum rnbd_msg_type {
  */
 struct rnbd_msg_hdr {
 	__le16		type;
+	/* private: */
 	__le16		__padding;
 };
 
-/**
+/*
  * We allow to map RO many times and RW only once. We allow to map yet another
  * time RW, if MIGRATION is provided (second RW export can be required for
  * example for VM migration)
@@ -78,6 +79,7 @@ static const __maybe_unused struct {
 struct rnbd_msg_sess_info {
 	struct rnbd_msg_hdr hdr;
 	u8		ver;
+	/* private: */
 	u8		reserved[31];
 };
 
@@ -89,6 +91,7 @@ struct rnbd_msg_sess_info {
 struct rnbd_msg_sess_info_rsp {
 	struct rnbd_msg_hdr hdr;
 	u8		ver;
+	/* private: */
 	u8		reserved[31];
 };
 
@@ -97,13 +100,16 @@ struct rnbd_msg_sess_info_rsp {
  * @hdr:		message header
  * @access_mode:	the mode to open remote device, valid values see:
  *			enum rnbd_access_mode
- * @device_name:	device path on remote side
+ * @dev_name:		device path on remote side
  */
 struct rnbd_msg_open {
 	struct rnbd_msg_hdr hdr;
 	u8		access_mode;
+	/* private: */
 	u8		resv1;
+	/* public: */
 	s8		dev_name[NAME_MAX];
+	/* private: */
 	u8		reserved[3];
 };
 
@@ -155,6 +161,7 @@ struct rnbd_msg_open_rsp {
 	__le16			secure_discard;
 	u8			obsolete_rotational;
 	u8			cache_policy;
+	/* private: */
 	u8			reserved[10];
 };
 
@@ -187,7 +194,7 @@ struct rnbd_msg_io {
  * @RNBD_OP_DISCARD:        discard sectors
  * @RNBD_OP_SECURE_ERASE:   securely erase sectors
  * @RNBD_OP_WRITE_ZEROES:   write zeroes sectors
-
+ *
  * @RNBD_F_SYNC:	     request is sync (sync write or read)
  * @RNBD_F_FUA:             forced unit access
  */
