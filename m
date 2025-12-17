Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707052957B6
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949722; cv=none; b=hDY1mQUdZ6hKtT+TpguKeRjQK1FHDRpnm14KfWnEKOTiCtRlQVyR40rU3BEvjjRiGPnC8nZzMYfU356ccktEq0gJDX9geaqxG2iVX8usHagZKFKwrja8PvUQHJA4Q2i8gAw23qdHFrYjPh6zurvRsLa258qr5pzjxatgXf/gJM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949722; c=relaxed/simple;
	bh=f8EP+bPK1MvqaUPNHimhlYSpt7ZjD3QQvEFMsrXub80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfNvFdiPYgkURPCJ5aApbJbSvB9xzD4tdf1M0RE4j/mPrbys+ZTPGgm+X7k7krTAUrY1y13/9llcjLNREqCPp7+GNqQoQxhdVBOG/NOrVbsUxBd26dY5VW238mzAOFtnNlG9IaJD8HjgKDmPbEP4RMYLG1mATBtIMCWQSHgfyB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bh3R4Mzn; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bh3R4Mzn"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a110548f10so5594755ad.1
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 21:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949714; x=1766554514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0K5vEftPdYiPKum60OYL4RUxMxughkX0Uvdp3aFS+SM=;
        b=bh3R4MznsX4HN2sSwUeUQoF8SG4fShGPMt4lCeGDziENdlf4sfmVtFZS6vwmXpxFum
         v094S6KXgE2NXNo0d61hiXTLLia/8cCnXF9Q2B8Z2QTPz4HP/TJQ4xXA0gdltFkC1uP2
         gVASd5oaqiaLARNd0/rtKfPlzo1FgI1COjau9sw5qf9Ej8VHD75fsD9mvgJxgVAtOSRk
         ipjZ+0c2C7oBqGsKllxmwXvZD2CzKDJ+wDwVfe3PNHPW7Vh8N0vreiwaP0x5IZ4kaTCB
         Fn5nNbvgSQz/CjwWmQYWguX0dOIE/wNSoglxRn9TawzFejrZ8ntjDegmwGS54lqeB+L+
         EJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949714; x=1766554514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0K5vEftPdYiPKum60OYL4RUxMxughkX0Uvdp3aFS+SM=;
        b=QcJICHn5qd7svICIWkPVwW1ogqw0aYXIvpzFUWJ8MlO4mfhLXI2vDoZeEsqtb1Mpuw
         pfu5O7HTPc8Aymt604DF30YxpQzcxO4qMLN5PfgWnk5HM5VM1ACKhKD2nKI/evtQRBId
         RZbhxMrDG2+auslZ/+qTT/tZuwtndzwKCwxo3ekgirDdvTAJotQ72x/N7tvTgN845tL5
         o9LroDDhQENqkHeHtxn8EgHcEtljVyEpR8j8I4dXWMz3+IKS1G6UtIHmLzXyhP5ESNsl
         QCQfGO9Pr6DlbDrE/eagYslUZylbHayJnl2O16+h3koOuYO+M1krH6uIP/YQ3XT37P4m
         CsoQ==
X-Gm-Message-State: AOJu0Yws/dL/PythOFkf3tcFBAVZte0cj3g/HfeYoYIN6S59QHByD6uA
	aw+uSpmQxC2rpkzGnBusxAbUC+Tc1Se77yLDQocX/dj7SoMKrVSZHFIZE9/LQU1vh4tT6ei/QV8
	5yUO4utSwUAQ57N6GGkcCXk9ffdxi+gsUB/R9D5IQIQsKbQrqlL4Z
X-Gm-Gg: AY/fxX63i4uph2CCMYU6p0X3j2D/+eDEQUSJhrH9/YLI3mEOBPwdLg38XNfzx3zqFL4
	HJdsUzLaBHdHKEPfjxTrJ3V3g60I6SBcBgMiPMB6AZIqs0x1zD8RPwnTX1H1wtlZ4QdDjhsH4Nz
	hY1Fwj9TQSZ2FznAC3aqiStuTYlN0qgrnyNzUp5Wx9CXFxH1ZRVBksc7llMVEEDA4UCdkev4VBA
	tHZjk3lOcve1DCKo6gYSZ7rLn4mW3JzXoddfqD7lBM0YZpIibAzfBwciJWTvTdsiJvqpzruorW8
	x3JF0SgqSiVttIzCktKXhMKZXwvMTr/7jHvFPGrUbmzEuEkxtTkH+fiUEM74zIpf3IkqlqNyKBZ
	KJTCNzl9++OvN8ap4NIKS9ta5P3U=
X-Google-Smtp-Source: AGHT+IF3QWWDircA2HU2nyaFINqIKymyhDZzCc1uZwJse38kkaHRBo2S1/CTHo+jeLRwwK8DtAAmlCsojSBS
X-Received: by 2002:a05:7022:fa2:b0:11b:862d:8031 with SMTP id a92af1059eb24-11f34874285mr7166802c88.0.1765949713871;
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-11f2e151243sm3230598c88.0.2025.12.16.21.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 863CE34225B;
	Tue, 16 Dec 2025 22:35:13 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 84110E41A08; Tue, 16 Dec 2025 22:35:13 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 18/20] selftests: ublk: add integrity data support to loop target
Date: Tue, 16 Dec 2025 22:34:52 -0700
Message-ID: <20251217053455.281509-19-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251217053455.281509-1-csander@purestorage.com>
References: <20251217053455.281509-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To perform and end-to-end test of integrity information through a ublk
device, we need to actually store it somewhere and retrieve it. Add this
support to kublk's loop target. It uses a second backing file for the
integrity data corresponding to the data stored in the first file.
The integrity file is opened without O_DIRECT since it will be accessed
at sub-block granularity. Each incoming read/write results in a pair of
reads/writes, one to the data file, and one to the integrity file. If
either backing I/O fails, the error is propagated to the ublk request.
If both backing I/Os read/write some bytes, the ublk request is
completed with the smaller of the number of blocks accessed by each I/O.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/file_backed.c | 63 +++++++++++++++-------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index db4c176a4f28..b8aacaa928a4 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -33,48 +33,62 @@ static int loop_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 	unsigned ublk_op = ublksrv_get_op(iod);
 	unsigned zc = ublk_queue_use_zc(q);
 	unsigned auto_zc = ublk_queue_use_auto_zc(q);
 	enum io_uring_op op = ublk_to_uring_op(iod, zc | auto_zc);
 	struct ublk_io *io = ublk_get_io(q, tag);
+	__u64 offset = iod->start_sector << 9;
+	__u32 len = iod->nr_sectors << 9;
 	struct io_uring_sqe *sqe[3];
 	void *addr = io->buf_addr;
 
+	if (iod->op_flags & UBLK_IO_F_INTEGRITY) {
+		ublk_io_alloc_sqes(t, sqe, 1);
+		/* Use second backing file for integrity data */
+		io_uring_prep_rw(op, sqe[0], ublk_get_registered_fd(q, 2),
+				 io->integrity_buf,
+				 ublk_integrity_len(q, len),
+				 ublk_integrity_len(q, offset));
+		sqe[0]->flags = IOSQE_FIXED_FILE;
+		/* tgt_data = 1 indicates integrity I/O */
+		sqe[0]->user_data = build_user_data(tag, ublk_op, 1, q->q_id, 1);
+	}
+
 	if (!zc || auto_zc) {
 		ublk_io_alloc_sqes(t, sqe, 1);
 		if (!sqe[0])
 			return -ENOMEM;
 
 		io_uring_prep_rw(op, sqe[0], ublk_get_registered_fd(q, 1) /*fds[1]*/,
 				addr,
-				iod->nr_sectors << 9,
-				iod->start_sector << 9);
+				len,
+				offset);
 		if (auto_zc)
 			sqe[0]->buf_index = tag;
 		io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
 		/* bit63 marks us as tgt io */
 		sqe[0]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
-		return 1;
+		return !!(iod->op_flags & UBLK_IO_F_INTEGRITY) + 1;
 	}
 
 	ublk_io_alloc_sqes(t, sqe, 3);
 
 	io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, io->buf_index);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 	sqe[0]->user_data = build_user_data(tag,
 			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
 
 	io_uring_prep_rw(op, sqe[1], ublk_get_registered_fd(q, 1) /*fds[1]*/, 0,
-		iod->nr_sectors << 9,
-		iod->start_sector << 9);
+			len,
+			offset);
 	sqe[1]->buf_index = tag;
 	sqe[1]->flags |= IOSQE_FIXED_FILE | IOSQE_IO_HARDLINK;
 	sqe[1]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
 
 	io_uring_prep_buf_unregister(sqe[2], q, tag, q->q_id, io->buf_index);
 	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, q->q_id, 1);
 
-	return 2;
+	return !!(iod->op_flags & UBLK_IO_F_INTEGRITY) + 2;
 }
 
 static int loop_queue_tgt_io(struct ublk_thread *t, struct ublk_queue *q, int tag)
 {
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
@@ -117,16 +131,21 @@ static void ublk_loop_io_done(struct ublk_thread *t, struct ublk_queue *q,
 {
 	unsigned tag = user_data_to_tag(cqe->user_data);
 	unsigned op = user_data_to_op(cqe->user_data);
 	struct ublk_io *io = ublk_get_io(q, tag);
 
-	if (cqe->res < 0 || op != ublk_cmd_op_nr(UBLK_U_IO_UNREGISTER_IO_BUF)) {
-		if (!io->result)
-			io->result = cqe->res;
-		if (cqe->res < 0)
-			ublk_err("%s: io failed op %x user_data %lx\n",
-					__func__, op, cqe->user_data);
+	if (cqe->res < 0) {
+		io->result = cqe->res;
+		ublk_err("%s: io failed op %x user_data %lx\n",
+				__func__, op, cqe->user_data);
+	} else if (op != ublk_cmd_op_nr(UBLK_U_IO_UNREGISTER_IO_BUF)) {
+		__s32 data_len = user_data_to_tgt_data(cqe->user_data)
+			? ublk_integrity_data_len(q, cqe->res)
+			: cqe->res;
+
+		if (!io->result || data_len < io->result)
+			io->result = data_len;
 	}
 
 	/* buffer register op is IOSQE_CQE_SKIP_SUCCESS */
 	if (op == ublk_cmd_op_nr(UBLK_U_IO_REGISTER_IO_BUF))
 		io->tgt_ios += 1;
@@ -136,10 +155,11 @@ static void ublk_loop_io_done(struct ublk_thread *t, struct ublk_queue *q,
 }
 
 static int ublk_loop_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 {
 	unsigned long long bytes;
+	unsigned long blocks;
 	int ret;
 	struct ublk_params p = {
 		.types = UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DMA_ALIGN,
 		.basic = {
 			.attrs = UBLK_ATTR_VOLATILE_CACHE,
@@ -152,27 +172,34 @@ static int ublk_loop_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 		.dma = {
 			.alignment = 511,
 		},
 	};
 
+	ublk_set_integrity_params(ctx, &p);
 	if (ctx->auto_zc_fallback) {
 		ublk_err("%s: not support auto_zc_fallback\n", __func__);
 		return -EINVAL;
 	}
-	if (ctx->metadata_size) {
-		ublk_err("%s: integrity not supported\n", __func__);
-		return -EINVAL;
-	}
 
+	/* Use O_DIRECT only for data file */
 	ret = backing_file_tgt_init(dev, 1);
 	if (ret)
 		return ret;
 
-	if (dev->tgt.nr_backing_files != 1)
+	/* Expect a second file for integrity data */
+	if (dev->tgt.nr_backing_files != 1 + !!ctx->metadata_size)
 		return -EINVAL;
 
-	bytes = dev->tgt.backing_file_size[0];
+	blocks = dev->tgt.backing_file_size[0] >> p.basic.logical_bs_shift;
+	if (ctx->metadata_size) {
+		unsigned long metadata_blocks =
+			dev->tgt.backing_file_size[1] / ctx->metadata_size;
+
+		/* Ensure both data and integrity data fit in backing files */
+		blocks = min(blocks, metadata_blocks);
+	}
+	bytes = blocks << p.basic.logical_bs_shift;
 	dev->tgt.dev_size = bytes;
 	p.basic.dev_sectors = bytes >> 9;
 	dev->tgt.params = p;
 
 	return 0;
-- 
2.45.2

