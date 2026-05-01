Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727671E9B3D
	for <linux-block@vger.kernel.org>; Fri,  1 May 2026 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777625556; cv=none; b=b9Bmxq5hyx4gn36Yxh7oMR0cdVOb8UBwhJI7M1zztxP4YHmV58m6c/5GgReVYya6/v6W56d146uWCriEnzhs9Cf4XnQ5qTt06Pd2I5y1iDttBR38BQWmUmI3QFniMyMDQyrNo+g2+OORTC9cnAI7now0Re8i+JH3Bl6kz0Nv7AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777625556; c=relaxed/simple;
	bh=tOWy5KkNU+lQlpU6iuyeTOc10Jhb8gpApDMMgFyw4wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gIuxHEPSb702Qm3PwEQrA/imECDCBoAFkaLPvrCGAwWja2D5FS5Sjnp2GBr9P3plCcMwIR6Q1D3DwodLNONWU/9ysg0FUggU3kjkFTqDwot7mP2BEtyzEJvVvwZN7iK9KWhFB147nJiQcNPVFuoALG2PfanPNsbK2aPV44JiZBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wew8qhoj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wew8qhoj"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cfce3a195so910769f8f.2
        for <linux-block@vger.kernel.org>; Fri, 01 May 2026 01:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777625554; x=1778230354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cIdGQMxdD48ClFWHMMFsQ1FxD52xNDyfzsrG3mM8w+g=;
        b=Wew8qhoj9p15uFKxAvt8a/c+fW1fC68q9OCgY2sZTVtXFjaGlqpnZ25DPFs7PuPTYY
         E3zebgDr6/P7/AKkrjHBFaDwRZaPDmj8wg44dnwhNP3IAqPVtZ541SvososcESSXl+ir
         IJzzrGDGF053OmKtIiifI8LExTyIJJXtjyvOVckd0mY2k1IKNplZDea69JSCYFo1F7G4
         iAby83FxcmVQVqnzGlxyVH9nzdx3GwTN5DbxpFHyXtV1SFcT9rqVgAsAAoB+dWiNEHOj
         oYLwMWnZjuB2nxMWKes9y1jbmYjW/vNuN1CIKsFp0FdPkghYrHksW+k2bI0X43R5EG1o
         Ik5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777625554; x=1778230354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIdGQMxdD48ClFWHMMFsQ1FxD52xNDyfzsrG3mM8w+g=;
        b=mAzc+/XHZr0DWw2m4I8U1irsJeL4zJBK/vMu8FX3pAbsYVQU9GJ+XQYvWbpl76FuCg
         wjpMVxZ1M9MxuArzLHugtsmiCUeXy85o3lI7jAsZtzZ2kGtp2/3WC+vXrBMxKEe/XnN8
         k1bltuDG0bVbdBULgmYFlv0SktLlrUgzMhepMP4HvNZoSDIavJwOMOAFvb3EK5FlM/ku
         WVQBxLAQOFUtkSz1dZbH3QNFE6efnBIlqXxTiv80MdduhjFtYHHE3M4AxamIGSFxw0g+
         tzj4V6PGxRxUEZiMBlrQqjm0y8aDQ5qiNBDxlURVo5de7630n+y5YpWf0R5Nl7wKiRml
         zU5A==
X-Forwarded-Encrypted: i=1; AFNElJ8I+cJcGezEzhekEpF235mCYEITwqEq0E/EfNUrWho3L7MhrswSWl+x9dDtY3c3s2l3uNuMiouo6oGTqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOraBrXRUyQMcqGsO23ktAxIiWhXCw0sn/Qz5LHTNZsVPAfrwK
	KBB5ab/IwFAYg5XalTbhDMeNJlxILu8eNyYya2zTKFdTcx8s6tkRZ8on
X-Gm-Gg: AeBDievcsK/JMccb88ShJbZw0/+FNtvFVGtmmx4hzU2DkhtGVgp3Za9V4NFZY/lLHWz
	Pzm6gIsSNtyWS3rjLE4Lzpp30hYchuHdxfuadRUWwpa7KmPc9+4d6CG23fZzy6hVK7BGDPr5D7Z
	ilayAPaQ8t1BY+NhxSa1wYL6lsww1JZ5Icp7TxXjFZ3d8VhJW0SkjTe9Pu0Z7lfIcZxbb2mjyxG
	pK/C76F6DlCA/9ggJuTGd5rKXVwObyA7EOI42CAC4UT/dyd3ScXUQ6eAG1TqZcMH3tCshNqUzR6
	xF37TbYaPpcglBZVahCTzho186Kxb0y27kkG0qdhFALyUOfjqwkEUbXvEb2wYVLqkDXYqvcT39o
	eis034fc9qVf+A5WBrfzIYmQrgaxohIRlJ5wQNDaVulB0D8OVvWaT7Fv0x10jZsy6pCxkIskPFS
	lI4u4BRzAPE9byft0BtP22xRgTCma0fDspFbDZvT7k5XOXQOEVdtq43Ry8qcz1rDNIxZJTThR7j
	Sfv+VcY1y/sB4+HOEU=
X-Received: by 2002:a05:6000:1ac7:b0:44a:2509:fbf with SMTP id ffacd0b85a97d-44a25091139mr5800719f8f.21.1777625553683;
        Fri, 01 May 2026 01:52:33 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a9879ef89sm4089588f8f.30.2026.05.01.01.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 01:52:33 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH] ublk: reject FETCH from non-userspace context
Date: Fri,  1 May 2026 16:52:16 +0800
Message-ID: <20260501085216.905401-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__ublk_fetch() sets io->task to current, which is later checked
against io_uring_cmd_get_task() in ublk_uring_cmd_cancel_fn().
With REQ_F_FORCE_ASYNC, the FETCH uring_cmd can be issued from
task work, which can be run from io_uring's fallback workqueue,
causing a task mismatch and triggering the WARN in cancel_fn.

Reject FETCH if current is not a real userspace task, and it is
reasonable for failing it in case of io_uring fallback.

Fixes: 3421c7f68bba ("ublk: make sure io cmd handled in submitter task context")
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 8e5f3738c203..57abc0e9681f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3251,12 +3251,19 @@ static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
 
-	ublk_fill_io_cmd(io, cmd);
-
-	if (ublk_dev_support_batch_io(ub))
+	if (ublk_dev_support_batch_io(ub)) {
 		WRITE_ONCE(io->task, NULL);
-	else
+	} else {
+		/*
+		 * FETCH must come from a real userspace task, not a
+		 * kworker is actually io_uring fallback workqueue.
+		 */
+		if (current->flags & (PF_KTHREAD | PF_WQ_WORKER))
+			return -EINVAL;
 		WRITE_ONCE(io->task, get_task_struct(current));
+	}
+
+	ublk_fill_io_cmd(io, cmd);
 
 	return 0;
 }
-- 
2.53.0

