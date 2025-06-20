Received: from mail-oo1-f100.google.com (mail-oo1-f100.google.com [209.85.161.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D5A2BDC04
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432218; cv=none; b=KT4bp+PdQB0EhsEeA+bXTwedgyHXyTHE60XZjRkRWBi8F5dcMNjQwzvMoYX+//54B0vzxbwMbmbh5B7TC5o3oWCeDCKFEPSbOG1sB2INKd1pzC8PpEY5rQCEcQh/Mh0JeHQ8t5j0IfLvjl8i6i9A9OXECdXgIHhzYsCd6B161EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432218; c=relaxed/simple;
	bh=43wAbtt4xr/+vk7SHqOVBl6StkCkvFvSNXtb7A6FnJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyVacyHgXJFb7/hjHTWTs/iVP+Ywra3DJUKHdson7B0yYRmP7K68HbruaOU65Idbbu7gHKfgKABtfW3A2Vd6GblkFEgjEV8E8hvKMrVwcy/IhG+EuWwOOgKg0ku2AF9GOAd9vW1v83At6Lmhueq5Y7/plF1EHjNqBh3FKq7kMAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LIMaE753; arc=none smtp.client-ip=209.85.161.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LIMaE753"
Received: by mail-oo1-f100.google.com with SMTP id 006d021491bc7-6062024c541so93916eaf.2
        for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 08:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750432216; x=1751037016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14QqlmGoDYKRAcY9RsUvYBgsy1o58MZ4VK/klaLpJJc=;
        b=LIMaE753nIWWq4Dpn37SgClrenAfjIuiK5J2pWq2jRWfYCKEZBAbTjm1APiE8gi2jp
         apu9KfssFILEApb47ASfRc+Ss6IwCB/t2HGv1EyL2LNJEFqIqz36oWgNpmogOFZikxk+
         Qh2pDderv7ZnhKDofj0O6um+nqoWE4l9j+SMpRmlHmlwHNZJPKfd/+uw0mTqkGSB0UUm
         EkB1a1Af3OY0lbgC/XsvWTp9h5/tuZ0ah5P60QKxSTmQpAvjUJGdHF7QHYy+O4vqo/3x
         MuD/ZJipTsbr0uqbPZlN/kIBT0k6xfz5cl5vatbsDEXTjUyhbohNVUunWY/WNvAVaGp9
         PMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750432216; x=1751037016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14QqlmGoDYKRAcY9RsUvYBgsy1o58MZ4VK/klaLpJJc=;
        b=wdqj1iFzUCxxOVWhp8bFD+Yk1gpn3FL/mRN1vLN/hSO+UwP9WOW/08sNAwD448FBhY
         301EBwU/jwRU1sRtN2SaXrPrmYpOUKzVH4EbXngl07PU1CoF9fFCevkjL/J8q0xyTf95
         uuaoNmmYGNAy2fGdSjDgM00RdBeb1/AMzO1MgYzWSYZhQkdA7+KTMzRP6q1u0wLmk2+H
         29DecwoedrTyUl0/3eH/8o9wjGx121Id0a+P+7xkOwDfL4pKDHAe++k8EU6meM07Rq5r
         VjqX8iLmzfNRbypphZOR1vLp7Pv3/Gj/HHsMPD8xuFnBz5uD2O47LG7uP92a9NprsbAI
         mzVw==
X-Gm-Message-State: AOJu0Yw6HfUiGujLmpZAQ6ebx9fR0RScY902UowtCvbTS7QPyudBdiy0
	CdQHKSH50zYGEX4D0TtzRN3FElzRspJcCfMI/+B/XcGTqULdIDt8jLnjuF9BLerYPK5EpRcz4X2
	HIrC+wv17S6XhzAKa0YKhqDkZNFRvt1/udgK7w761difD0jQuhNoO
X-Gm-Gg: ASbGncuSwnDDPOIfi1+uJc/N0lnOLgbsf1krNXtdNHyAjjPepY86rSza8dKbLgIi09T
	YSOoaKBkgKNvMjAmmmjEVC6QKZhbJna7SnXR4KEjrGELSbtUQ62ttiYrzgunoqH9qBc3Ek0L42F
	sZKRb9/JUvs3sa9h9kUwLWWVSp7Yl89PqYYDQlFPL35NPBiAKonhXvYtVuBmjnvQzWPqVDv+A/7
	qxNQKznX4CxbVHZyl6yEPl54qDbqK1WytPkVVMt/wp7T6BrhRAP5ZFULQuK+6r9iG2h2sAQdlOA
	3YcHIPiOcuS5NpPbTt8OE+8hsgPyg+DPhu7qiYAC
X-Google-Smtp-Source: AGHT+IGQZkOdqx1LoAfA6fCk0NFnDmIKF2pnFzA3tyO4fRgQIT/Th1p+oeVsawyUqNDMovSssVdmrKkrYOvH
X-Received: by 2002:a05:6820:2d0c:b0:611:556c:9b09 with SMTP id 006d021491bc7-6115b95cbd4mr886971eaf.1.1750432215801;
        Fri, 20 Jun 2025 08:10:15 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-6115b80a48dsm40577eaf.14.2025.06.20.08.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:10:15 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C6F913405F1;
	Fri, 20 Jun 2025 09:10:14 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C63B6E4548E; Fri, 20 Jun 2025 09:10:14 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 03/14] ublk: check cmd_op first
Date: Fri, 20 Jun 2025 09:09:57 -0600
Message-ID: <20250620151008.3976463-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250620151008.3976463-1-csander@purestorage.com>
References: <20250620151008.3976463-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for skipping some of the other checks for certain IO
opcodes, move the cmd_op check earlier.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 55d5435f1ee2..aea2e9200311 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2177,16 +2177,21 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	struct task_struct *task;
 	struct ublk_queue *ubq;
 	struct ublk_io *io;
 	u32 cmd_op = cmd->cmd_op;
 	unsigned tag = ub_cmd->tag;
-	int ret = -EINVAL;
+	int ret;
 
 	pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n",
 			__func__, cmd->cmd_op, ub_cmd->q_id, tag,
 			ub_cmd->result);
 
+	ret = ublk_check_cmd_op(cmd_op);
+	if (ret)
+		goto out;
+
+	ret = -EINVAL;
 	if (ub_cmd->q_id >= ub->dev_info.nr_hw_queues)
 		goto out;
 
 	ubq = ublk_get_queue(ub, ub_cmd->q_id);
 
@@ -2215,15 +2220,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	 */
 	if ((!!(io->flags & UBLK_IO_FLAG_NEED_GET_DATA))
 			^ (_IOC_NR(cmd_op) == UBLK_IO_NEED_GET_DATA))
 		goto out;
 
-	ret = ublk_check_cmd_op(cmd_op);
-	if (ret)
-		goto out;
-
-	ret = -EINVAL;
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_REGISTER_IO_BUF:
 		return ublk_register_io_buf(cmd, ubq, io, ub_cmd->addr, issue_flags);
 	case UBLK_IO_UNREGISTER_IO_BUF:
 		return ublk_unregister_io_buf(cmd, ubq, ub_cmd->addr, issue_flags);
-- 
2.45.2

