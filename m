Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793820317;
	b=AFiXhJ2yIdeXfKpj00vPhw/FcAzP7MB/kzmrAr+p07S/pe6mgxOGL1NDlDDYMEvY4k8M
	 M/OhWCuYJBc9aK/rmiqQxS3v9dImJI2H+5gTe7VWNjUBas2LKdQWqH2fmJ+bU8L0in19F
	 mzBNFs6ikV+V6KrOKYj2wkxGuh1tKMYFzkbPTxlUMzD4+FtbmD6nAnNMv3oB3HQJ0faXi
	 zhoJ8wSNOta/Clg41FdI0opzXBd1qSqdMcUZmQrssb+Z+sc6/McuW2CQa8mvvdQ0ic45N
	 w32zOBa3ekOZKY29TOK0WmBr3yujMq9TWT9mnMjg51ehAfrieRBRu/i8JSDT7pTP9+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820317;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wAQcQMzKgPULF8QzohUPO4g4obE8zAX+zU0B1WJrY2w=;
	b=HbtLWAxNES0XlsL9yPsi9Fa8SKCGL9MA7fdztJLJ+9fkVcidZESxMqr65033T4uaNAg+
	 F4oZiLGSqZo/aSkdm1en4O05kXcAT987N8mAWHjkOKyan+iQgfvtfF7fZdld5d1pz261Z
	 N5kYowWwLXf1wTzd4nMMgg2UfBEywOoRfdXbHdeotRWoqOaJKTaYDmAjw3ty2vgXyXsA3
	 3YNhOlAIciALM/xRo0PRejD9afjkjDa4SEVeqabKb5uBmio4v6FwKXS+dA4OxXcE3Kla6
	 qkEMAG6ng+yfmBRC8X2zF6Zamnb2IQqlT48rlBk2EsJPF8FcbCYjXcPpCjYMdeYlVBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VzJ9f5B7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C058A6070F21;
	Wed,  4 Nov 2026 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VzJ9f5B7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793820316;
	b=nx1dVQX+7ozJ9Xu4YEBuDkgZ4yt1mhsmHxarQ0ch6+0AWT/YaFqy+wsdsbWO6eT1McgX
	 ub3728eHHbloXwoYtjBAViIX2XZyNliG9HfIct209d7CHH31tmEn1dQ8LnnMIXvbQ51cT
	 gKVFlXsyjnir25oEw4abUdM5aQg6a07EPyJ3jtBDRaj8Sw5UFQeu35FwNyHC4pEdxk8gZ
	 YWCqjiHlxwI80/IJEJm7oi8Kz8nTmz8XA0xobrIRym1KX0/AkmvhbyIK+U0GdAUD73zdF
	 dArOJV96MlVMfnayLL6W/VC3euY0EXl5IIQrTwA2mmhN0H2jgFP/sKrom+tZuAB1XFg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793820316;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wAQcQMzKgPULF8QzohUPO4g4obE8zAX+zU0B1WJrY2w=;
	b=zZmiOjNIvkXghi4n4sNSHOAfiI3MgukCZylOrBWq3q9vphLHDA/mkt7t1eNmtMgfnSLh
	 sbNIH4bh8yIEbbrrx28JjV7XTSjfrHBR2OLxplJCVI1IL8iEZpbTGd46YPxLMbcfAEjxr
	 POUTR7VJBSR0bpXmcDs++2vCFhEQ6k0Lq/1ylV9iKa7v5tFCWDgkFAGTN3OGPRkfIr+oT
	 HzVuUj3NfgaWEf55Jf+lqWuqTRqqhE1AwCvT/KYlakKXyKtRviAa50eZshFI0dUSyi2uj
	 JmIrhWWiQmMd3UOZCDCVBhATDRCyOa9Flw/FiL76SiCru2Tzn3LSxBMLmVNDGuZSUSw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DAF281F00A29;
	Wed,  4 Nov 2026 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820316;
	bh=wAQcQMzKgPULF8QzohUPO4g4obE8zAX+zU0B1WJrY2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=VzJ9f5B7CEqMcifXOFQBN3gDUqQ/DxGz2L0KMHXkzNBwF1DB7UHhweCBVy40nWF+E
	 qK0Foa8Pu8EMQs3bK8QRddbexBeyBdgn/9TuZThAvF/62aebf6spl1zpDF8R2jlId0
	 5xWCKRzhEwBJoD8+NsxxPBZRxOYfMgZf8wmrmz1xVfnunxF2v7cd3i2OsTfocMM2U7
	 F7ujUKOA/C0Lgefx66N13yQZLc8+O5/veFE6j4jkYjW3/u2FTZh7Ck7wm4WMxVcnEf
	 0VjJRNJ6g5QZouQO/pBH+Vir9c99RSDpyi/qafutp/UZo3gm5qL8PgHtkZllDrK/Lu
	 T12Gjv/avRFnw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4208546F54;
	Wed,  4 Nov 2026 19:25:06 +0000 (UTC)
From: Mark Korenberg via B4 Relay <devnull+socketpair.gmail.com@kernel.org>
Date: Thu, 05 Nov 2026 00:25:05 +0500
Subject: [PATCH 1/2] ublk: publish a new device by its id only once it is
 set up
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-ublk-del-gendisk-hang-v1-1-913a91a4314d@gmail.com>
References: <20261105-ublk-del-gendisk-hang-v1-0-913a91a4314d@gmail.com>
In-Reply-To: <20261105-ublk-del-gendisk-hang-v1-0-913a91a4314d@gmail.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>, 
 Mark Korenberg <socketpair@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793820305; l=2820;
 i=socketpair@gmail.com; s=20260603; h=from:subject:message-id;
 bh=kErRrExpI2LtJAMvv3KNrq5h1atq5uq7x5u9yvNiW0k=;
 b=wGCIBYj0ASQ8ToPwvpJBCU6doUyE+kmK3ox+J7uRIlsmHnyZ3vkPISWKJxGdYVtxgUnJYIMVF
 1DeqksiQfXGB0CdULrSsihuqh1eb5n/FCB9ykRmxHE4nnD2eq08geMH
X-Developer-Key: i=socketpair@gmail.com; a=ed25519;
 pk=2iAMjWhs7kA9X8ccetT2YVX8dvniXua2okQogw3Don8=
X-Endpoint-Received: by B4 Relay for socketpair@gmail.com/20260603 with
 auth_id=806
X-Original-From: Mark Korenberg <socketpair@gmail.com>
Reply-To: socketpair@gmail.com
Content-Transfer-Encoding: 7bit

From: Mark Korenberg <socketpair@gmail.com>

ADD_DEV stores the device in ublk_index_idr when it allocates the id,
and control commands find it there as soon as ublk_add_chdev() has
initialized its struct device, before the char device is added. If
dev_set_name() or cdev_device_add() then fails, ublk_add_chdev() drops
the initial reference to free the device. A DEL_DEV that found the
device meanwhile waits for ublk_ctl_mutex, then calls ublk_remove():
cdev_device_del() of a device that was never added, and a second put of
the initial reference, which frees the device under the callers still
holding references.

Reserve the id with a NULL entry, which idr_find() and the idr iterators
skip, and store the device once ublk_add_chdev() succeeded.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Mark Korenberg <socketpair@gmail.com>
---
 drivers/block/ublk_drv.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 72e9c435208c..14d2823a92e5 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -4405,14 +4405,18 @@ static int ublk_alloc_dev_number(struct ublk_device *ub, int idx)
 	int i = idx;
 	int err;
 
+	/*
+	 * Only reserve the id: the device is published by
+	 * ublk_publish_dev_number() once it is fully set up.
+	 */
 	spin_lock(&ublk_idr_lock);
 	/* allocate id, if @id >= 0, we're requesting that specific id */
 	if (i >= 0) {
-		err = idr_alloc(&ublk_index_idr, ub, i, i + 1, GFP_NOWAIT);
+		err = idr_alloc(&ublk_index_idr, NULL, i, i + 1, GFP_NOWAIT);
 		if (err == -ENOSPC)
 			err = -EEXIST;
 	} else {
-		err = idr_alloc(&ublk_index_idr, ub, 0, UBLK_MAX_UBLKS,
+		err = idr_alloc(&ublk_index_idr, NULL, 0, UBLK_MAX_UBLKS,
 				GFP_NOWAIT);
 	}
 	spin_unlock(&ublk_idr_lock);
@@ -4423,6 +4427,19 @@ static int ublk_alloc_dev_number(struct ublk_device *ub, int idx)
 	return err;
 }
 
+/*
+ * Make the device visible to control commands by its id. Before its char
+ * device is added, DEL_DEV could find it and remove a char device that was
+ * never added, and drop the reference that ublk_add_chdev() drops on
+ * failure.
+ */
+static void ublk_publish_dev_number(struct ublk_device *ub)
+{
+	spin_lock(&ublk_idr_lock);
+	WARN_ON_ONCE(idr_replace(&ublk_index_idr, ub, ub->ub_number) != NULL);
+	spin_unlock(&ublk_idr_lock);
+}
+
 static void ublk_free_dev_number(struct ublk_device *ub)
 {
 	spin_lock(&ublk_idr_lock);
@@ -4991,6 +5008,8 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 	 * ublk_add_chdev() will cleanup everything if it fails.
 	 */
 	ret = ublk_add_chdev(ub);
+	if (!ret)
+		ublk_publish_dev_number(ub);
 	goto out_unlock;
 
 out_deinit_queues:

-- 
2.56.0


