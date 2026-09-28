Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97B54D598B
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611405; cv=none; b=WzKBlPN79nV5mltNgbk1+A5ZquH6tN4bRrV7Qf8Pz2rap+ukDnDQ15zohyrHzxa+RuHqhGYkvmSY072UBGVDsdA1EXtYATgXSgd+kiRsIEpKLU4iPmLc0LRRWEgDPE1vCltsuVxYsA3+J+nZ8GN+QGHhNgtljhSkFAt2SYX8tIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611405; c=relaxed/simple;
	bh=zhxsWtMFxkMNLy0cVXpiLrIefZp4GMqj/Axxeo0tWa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l5wNsWOAKhKyuD1crAaOz7g9KHSL65uMJjvj/4uhJDvuKTeayCRmtwuRhB44OMy3xMMSDMqNzO6gO/xCkqj26Izz7sVCq9+OMO/D/6x0aINhsBuG6bexEkMHqR6IcJeoHh5zK9lBQ8qu6AzVJ+Vuu1Yrql5D8WrDseF+HQo0gYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=C7RAg0EN; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="C7RAg0EN"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4aa8d882so3405846d50.0
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 09:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790611402; x=1791216202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uv8hzXE4YDFWdArobAYOZWOpWqi/QMlwCECAVD9+99I=;
        b=C7RAg0ENAA9DkVYpAiiUz3lz4DEOehejT94AupE1umo1+fjHcqkwCNvH1QrIf+4wkP
         RDsqwqJZVh4DlT1MCHuzOLar8PxLS5zEQqJfuCL3tK7YmIxy7QPszX5mwhGYoFTXDkyf
         VzOUk4hlz4CUmvkNK4xxHk07XnGSS7Rmq8cehBnQ3ysKD41JnTYBVqSW1PueW+zRdT7m
         qor1Dmqg89T1umaL85wrVswe5bFA87Emm4DZ7anFTpFVlgxG3nz/Ht6LLqnWsQ34B1rM
         MFCt1viSU24jZ/EzVk9yEHd+4gd0PpbkOgYmW80X8u0GLEza+qYbXnhs212tln2b9hPR
         QgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790611402; x=1791216202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uv8hzXE4YDFWdArobAYOZWOpWqi/QMlwCECAVD9+99I=;
        b=kRJg//iJFi55VxZJHnVn1CTj4OQBU6ELlIv6ihknO9cfAWbiZhFSbJdkybZaFvfLqg
         eUFjCa+7Sl93MkvXbyOtaMzxHt9zkh/guZSgKHkHcLtd45GiS4mJ89UpfS3Jdhh2RYK8
         htFuUaQlywAvAVqS15l07apnMSrniDFbVTg/sfghm65R5KsCrawHPovt8vIfeSy6Aod+
         Ocflkt7jd7SWEBxd72GEq5E/bmjhxLoJk5sd2t+lOlqJFvQss5kAp7bEcOvTHKPmOMvX
         iO/0fZ9GNdVDWziAWDcFaMKaw0ok4KzB14UiKxpVSEXUijCecsTmB0zXt4fP0CyC4dJa
         dj/w==
X-Gm-Message-State: AFq9FYL8NgUqjyD7sg9OkjncRv0SUO5dLerc1k1CO9lka0T37ZefprNV
	oNap/ATvUsRvCu+1lhWCuicWxuLBF+S4k4ofBq5pE/mpizUV/IN2MMq40RwPjPYxKZY=
X-Gm-Gg: AYBFou0GEAR1+1TjVeLl1xcgYHuLPv3n4JgdRg+kqPVOYXdnHrQQUh/VcVUTScnZHWm
	ZCCCbNebQAT3mnMAQE9bT5idRHEjL3fIymZ6UZBbLHZgZCzmy2QJXPDdTRgMTvTMMBdlP5wAxaQ
	L6kGAHI60S/L0ZNJZypHsPuPaJL/kvCD6S8+mimU56yBy0vZmOtlTe6Fz/DO0qfsuB3KvpQNe7u
	38dpjzLwUeZLFT0AAYvf5ggY4Cmj8/pmdTfuHL0/fBvMoSbTP7yPseQKJKZwTFgR4c1vsMfsgRn
	Qk+gct+cYrTSzcuo8cERlFrEDte+JIN6xX9OlmaE6nwMfl5crFmGTqwS9cZfWvknhpLIHaXGoP4
	KPZeRzi6eH7a/2ST/+62fiKxKzGwtX0iLvDjWFSUVy0PY2lYfXcEcCssQLN9bNPuUVNxMYNLptu
	P2jTDpqTtBDD9wfajIDpq4Gt8Xk9j2c64SMLKulyzs0CRUu2U0rz63AaawCkv7io72uULoH/L+K
	l/YdhIrMQOY4sY=
X-Received: by 2002:a05:690e:11c7:b0:675:4a9d:4a85 with SMTP id 956f58d0204a3-6754a9d4f55mr1642232d50.59.1790611401599;
        Mon, 28 Sep 2026 09:03:21 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430df77adsm82622156d6.26.2026.09.28.09.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:03:19 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 28 Sep 2026 16:00:39 +0000
Subject: [PATCH 3/9] ublk: publish io->cmd under io->lock in the commit
 paths
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-ublk-cancel-stop-v1-3-4a4360232a46@toxicpanda.com>
References: <20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com>
In-Reply-To: <20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com>
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1790611254; l=3087;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=zhxsWtMFxkMNLy0cVXpiLrIefZp4GMqj/Axxeo0tWa4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QO0A5en96j57mWOrVyPwEj1dTuFJh8twc9kPT03FkNtjzIoQF/ah9T8LSfOgPFSTMdcKR5SC1tH
 zizyeZh9tlAA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

io->cmd shares its storage with io->req. FETCH, COMMIT_AND_FETCH and
NEED_GET_DATA switch the io from one to the other in
ublk_fill_io_cmd() without a lock of their own. That was fine as long
as everything else looking at io->cmd ran under the uring_lock of the
same ring, which is the case for the io_uring cancel callback.

ublk_cancel_cmd() is also called from the control path, from
ublk_cancel_dev() with IO_URING_F_UNLOCKED, and the next patches add
more such callers which run while the server still commits requests.
Nothing orders their reads of io->flags and io->cmd against
ublk_fill_io_cmd() then. A reader can find UBLK_IO_FLAG_ACTIVE set and
still pick up the request pointer from the union.

The batch commit path calls ublk_fill_io_cmd() under io->lock already.
Do the same in the other three callers, so that io->lock covers every
switch of the union to a command. io->lock is per io and only taken by
the task which commits that io, so the fast path gains an uncontended
lock in a cacheline it writes anyway.

ublk_batch_prep_io() calls __ublk_fetch() with io->lock held, which
makes the order io->lock, then ubq->cancel_lock.

The readers move under io->lock in the next patch.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/block/ublk_drv.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 50c99b28ef21..17a33539f271 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3169,6 +3169,9 @@ ublk_fill_io_cmd(struct ublk_io *io, struct io_uring_cmd *cmd)
 {
 	struct request *req = io->req;
 
+	/* io->cmd shares its storage with io->req, switch them under io->lock */
+	lockdep_assert_held(&io->lock);
+
 	io->cmd = cmd;
 	io->flags |= UBLK_IO_FLAG_ACTIVE;
 	/* now this cmd slot is owned by ublk driver */
@@ -3338,8 +3341,11 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 	 */
 	mutex_lock(&ub->mutex);
 	ret = ublk_validate_io_buf(ub, cmd, &auto_buf);
-	if (!ret)
+	if (!ret) {
+		ublk_io_lock(io);
 		ret = __ublk_fetch(cmd, ub, io, q_id);
+		ublk_io_unlock(io);
+	}
 	if (!ret) {
 		ublk_apply_io_buf(ub, io, cmd, buf_addr, &auto_buf, NULL);
 		ublk_mark_io_ready(ub, q_id);
@@ -3496,7 +3502,9 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		if (ret)
 			goto out;
 		io->res = result;
+		ublk_io_lock(io);
 		req = ublk_fill_io_cmd(io, cmd);
+		ublk_io_unlock(io);
 		ublk_apply_io_buf(ub, io, cmd, addr, &auto_buf, &buf_idx);
 		if (buf_idx != UBLK_INVALID_BUF_IDX)
 			io_buffer_unregister(cmd, buf_idx, issue_flags);
@@ -3514,7 +3522,9 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		 * uring_cmd active first and prepare for handling new requeued
 		 * request
 		 */
+		ublk_io_lock(io);
 		req = ublk_fill_io_cmd(io, cmd);
+		ublk_io_unlock(io);
 		io->buf.addr = addr;
 		if (likely(ublk_get_data(ubq, io, req))) {
 			__ublk_prep_compl_io_cmd(io, req);

-- 
2.55.0

