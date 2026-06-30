Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1427A261B9E
	for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854318; cv=none; b=NXrHwcwYuHdzaEYuT132kqmC4UX7jkJJdBlFZtBgdwrMIv74kK38hJ+1JgS5avQPdDFRH5mIOf2moQoxeXUS1EKyH47ti41apFdACrQ9vFqJqrliAh3ccdP40CXiYqwlrrGgptyQ5/3AIWiwBU30JmRMpnzZNjWv0LEhx+L8KLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854318; c=relaxed/simple;
	bh=GWK3vz0iRuHbMgrM0TESuIGL6z0pCRGR+33geI5gyLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WOiO2fDVxI4GJrb7QnNoQxtOkDGX3CmFOHkT74VCvO9j6JUvolKFkQsgm0DMEv9WM8rsqwyu4JTSCGKuyHcN3Iw7h8elXRkSvGLdJaXYTRJOp7odSK709UzzdtTWm9flddoITU0Y9GSCF5zRLHIYcyLwL7czGkpD70MR5y5PgSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oDsHmtrQ; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDsHmtrQ"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-664d910cc75so2916674d50.1
        for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 14:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782854316; x=1783459116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pmTw3Vr2+LsyNMbam3ooBMySK+M5u/Z76CpvLSVF7Ac=;
        b=oDsHmtrQ/jcZ+h+zavxh+u1pzcLzIwDcxX6NKeiR4SjF6xlFTPp0upeKXwEoDexWjz
         OsQshZDBrixoyX5Ynw/SXNHamM7z33/sPsN80mI/qMMWmMyJNUFLHJ1rbiDqFOfPDJwJ
         acJ0HibIVaG83eOR4P0DFhppHUDb0yd140j46K9udG+TNpzU8iFdsuNyVUjP+uGlVlTJ
         GS6Zr1wGs7fxnXkgkdohlA3rPOB8gC23akTmChN9PHFptdLAp84+wAKVz25kKH+Zw47a
         hMzjgbb3PSRLw5B+AMJOGF2YJZoiiLErqvABeZInWV341NMRvqID3fpPd89ho8l2dSn6
         +HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854316; x=1783459116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmTw3Vr2+LsyNMbam3ooBMySK+M5u/Z76CpvLSVF7Ac=;
        b=SnufF1DHn1HBBrzPT03+AMbsII+50QlZ5EWO9ptJat+TZ3znWtSLh+zLhxjysKg4Ef
         BSTM6dmJHKI3/mh/RuPqAgJPsQNZAlfUKcTAdqx1LXf2gD7C0Fivy27ztlqPZUiuwB6/
         1jUJZDLCum+teWYoH1ubWuTsRIYXRAXti9CflmMEFenfwTnBYBkZqvl2U3kzZDO9DTD6
         qyoAqJhJ2WByqLRvtNQ4ywTe7g1Xg55+7Z5K8AxrPLpMwi5JtrPuCGZVH9JnpuAlvwsO
         ehccvoDZUVop2yP/0jBxox0iHQU4WBlJdjaGLNSC0qOtAwKVYOHHxph5vQ6eE4QuzX04
         Otnw==
X-Forwarded-Encrypted: i=1; AHgh+RouPECIiSGEk728ONa0CUpe7dD7CXKBmKpPKaZ7d8u7fI1xIw/Mmun/Mo6llYxWkyoUiogP/RZAliMUuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ+jbwGQOBTaqdrxkMzH2Zsn7xG8rgv4JKALLFe2+Y+x4Zljmo
	VBa37oSEWOmMLe4phDMU9eDBd7DTF9Ci3CA7oPQayQRs6x2ommoWq44F
X-Gm-Gg: AfdE7cmDVW1W6pGKd0TEfKt0sRtNSZEFOnT7+rg9sN03cK6n0yEcxq+nwj9eQiUWENM
	tNGOo/ExkQsUdFVMYUwaKekHKkxe+2jBvTPKOkH042YlICHspsl0bac+aHB88Mr5YbloBY/l5Qm
	N7yeKCqD0T1yeBaPq4NS+H6jDgrD7Knq8kBf+EO7DfP8ahitOM9kr9Ds7THEJTr3+8St3uSbyAp
	Wuv0lHNSnULogolveAW5X86yKxu5SR6yUpsjwqXs8mMc1DGqvQhcfCnEP2h8KekheQAOaH/yY2W
	xzPfgn+p6SGJKkdx984sBm+kllgp2ue7QCgQ8dBf/U2tPsUwIvoxaohMRaISlsxHOQlFm024MEc
	Amml1PhEYPdRRvg7j4CfYiOhmNkG9A+qoNLfhl+oSUsMFeBrEsV5hbT/1aZhFz2Y3TG0HXPnfhm
	BSYWc42ep7xhneeoNG+hNDdXKN4A==
X-Received: by 2002:a05:690c:b03:b0:80c:1317:5928 with SMTP id 00721157ae682-810d7eb0c40mr57756567b3.1.1782854316202;
        Tue, 30 Jun 2026 14:18:36 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8128ac35643sm132357b3.14.2026.06.30.14.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:18:35 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+1a67ee1aa79484801ec6@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] ublk: snapshot batch commands before preparing I/O
Date: Tue, 30 Jun 2026 23:18:27 +0200
Message-ID: <20260630211827.50475-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The batch prepare path rereads its userspace element array when rolling
back a partially prepared batch. Userspace can change an already
processed tag before the second read, causing rollback to reject the
replacement tag and leave earlier I/O slots prepared. The
WARN_ON_ONCE() in the rollback path then fires.

Copy the bounded batch into kernel memory before changing any I/O state
and use the same snapshot for preparation and rollback. Commit and fetch
batches retain the existing chunked userspace walk.

Fixes: b256795b3606 ("ublk: handle UBLK_U_IO_PREP_IO_CMDS")
Reported-by: syzbot+1a67ee1aa79484801ec6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1a67ee1aa79484801ec6
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/block/ublk_drv.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4f6d9e652187..c2c11f2a01e7 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3584,6 +3584,7 @@ ublk_batch_auto_buf_reg(const struct ublk_batch_io *uc,
 #define UBLK_CMD_BATCH_TMP_BUF_SZ  (48 * 10)
 struct ublk_batch_io_iter {
 	void __user *uaddr;
+	const u8 *kaddr;
 	unsigned done, total;
 	unsigned char elem_bytes;
 	/* copy to this buffer from user space */
@@ -3632,7 +3633,10 @@ static int ublk_walk_cmd_buf(struct ublk_batch_io_iter *iter,
 	while (iter->done < iter->total) {
 		unsigned int len = min(sizeof(iter->buf), iter->total - iter->done);
 
-		if (copy_from_user(iter->buf, iter->uaddr + iter->done, len)) {
+		if (iter->kaddr) {
+			memcpy(iter->buf, iter->kaddr + iter->done, len);
+		} else if (copy_from_user(iter->buf, iter->uaddr + iter->done,
+				  len)) {
 			pr_warn("ublk%d: read batch cmd buffer failed\n",
 					data->ub->dev_info.dev_id);
 			return -EFAULT;
@@ -3723,14 +3727,21 @@ static int ublk_handle_batch_prep_cmd(const struct ublk_batch_io_data *data)
 		.total = uc->nr_elem * uc->elem_bytes,
 		.elem_bytes = uc->elem_bytes,
 	};
+	void *cmd_buf;
 	int ret;
 
+	cmd_buf = vmemdup_user(iter.uaddr, iter.total);
+	if (IS_ERR(cmd_buf))
+		return PTR_ERR(cmd_buf);
+	iter.kaddr = cmd_buf;
+
 	mutex_lock(&data->ub->mutex);
 	ret = ublk_walk_cmd_buf(&iter, data, ublk_batch_prep_io);
 
 	if (ret && iter.done)
 		ublk_batch_revert_prep_cmd(&iter, data);
 	mutex_unlock(&data->ub->mutex);
+	kvfree(cmd_buf);
 	return ret;
 }
 
-- 
2.55.0

