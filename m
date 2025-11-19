Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AF141AAC
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763594561; cv=none; b=q4YsHLMQy9bjZxhBkV6pUDzaE1tbiamIxnG2tWoN0fYq9P64OlBsgKtlLrnsk6rjegxtCJkFOkfjm/fod4AXc/Qh1NoztOJVBhYv2TyfzAru7yAsYVSFG1cvCH++Ur3lsq2e2pwJH0ex4XfhPnABccYRvseFYg1xc2mjvZegQzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763594561; c=relaxed/simple;
	bh=QjugR5of39jyv4CYlRDPb9mvII2SNe3SzE1+UVNXefI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cdqh/AmjNcJiT9/mJk5SXKzjziek3RcZ9a7PueqlNqp7gL1k6hV24yeDweTYYOg9FWDTIvUnfn/IUabxBKm3wVRHXD++Mkx2S3VrCc3iUNOXdmye9n22QafLW9/gk1Y/DH5UuqvD10IBqjNYthUTz8buzCnGLRm1a5D0hfwcqmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dR4jSj4L; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dR4jSj4L"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b9a5b5b47bfso201818a12.1
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 15:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763594560; x=1764199360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mKxf4jmktf31j02xupmRKH5dO3VmWiI7NlK/tcxwOro=;
        b=dR4jSj4L0zTP4EwcfDXfFArMRNFC/JOcD5+OItjdp/i2O+CxGbt4vswtgZrZ0QIksj
         SS+FAul/+tu306JYJBQzvr0BTF2dKn3jVMs2D+daFGjWsDw2p60B/K+QzCwVqVYUR+4T
         Sm7lWSidZb1Oee3nDdOSpZWQKTVaR9geZIbzlhMHHLBHAvtBQO6FeMTC0K3M8WzSh7yI
         CtLPsSFH5DPar/a03z8f4XMnQbXyn0jdNLJUcg7PM4h0lFDK4VYB3ZYzpykMBxBskhcH
         iF6/odPyhd5rTQO2jPhEm+vwG5Ad1fOVq3puVa157xPVuRZjnXmDhh9igreelhpGH4cR
         NKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763594560; x=1764199360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKxf4jmktf31j02xupmRKH5dO3VmWiI7NlK/tcxwOro=;
        b=LML7OILMgFyqimL1JyECiiJAvFP7xBqqsxq3RQRLhoJIPYxITITLTeHWZLrVXLr2Xu
         p+OLujFYXNcb27LbAwaTfpP3OflkEKI0Ul63wKZj442MU+SGZBEI9cvX+pu4Yqd3NSFi
         7JJq18XLKpnFCxBEw4TPmegZkZxSzmjNGmfzGzJvl5Tyx+CyhQOQkLdGfN7TsDg+0Lju
         cNOYtNFH2Z/8xABGPX7C2J0rdgdlqIAx59oO2XkeQQ7IydITye40Vxp3on65WIoMqATx
         p71KicGUTkhtPaT1rbYlTtJW1K2YUk5qs1GS8xrLEtKIRRi8iJAo6agrl8bxX7yj7Qsm
         0HAw==
X-Gm-Message-State: AOJu0Yy8eGzZTbVJXjoMaN8KWEDMYnqw3Wqden/tqWUzkM3Wihb3kdpK
	QA8IRzjuq2T5euasQRgvFRar5hQsAH4mDB2zovsiRNJksQxH6ntvn92b
X-Gm-Gg: ASbGncukk8Vgj/7dQftF4+OCMJ/XqX+xBF/B18pfRjmQ8XhW5YO2qVnYadvc8ByOeEU
	7XQuQqQ7HVMC9a7vS1HBZDI6MvFZY41ow1/gVr2ijuYLrxh52JeghJPsFIWgGhiwBHdXxMtbZ9h
	uWK4BksAeFBC+syz6IstK8f+dRTkGvLqhtL63A+PI+U+yl2u0nmoHrLWKQEFEpNVHKjbXtI+a05
	J/FL4kCfS2F1BJaKBOeOkVdn7VEXg3TuTL3MJNNzsOp71pScy8NKo9G05e2+GKir/b2TU2judy2
	QlzSlJFXNk2TimDdcM4rikS+/vf/quIB/H5fTi29+h4yoI+XlHCiPbtAp2OLwdzatX+Mr8OO5Dl
	hVuHCzO13MwYp99hguUZw0zuuYUpvs9C4zq1Ea4FEsAhro/OtPcZORn7o19Yg33c8aMA3im0bud
	vDMgEDP88et5Dqs+ywiPOdpVnTSqqosHIO8wrYZCfBRodwj5E=
X-Google-Smtp-Source: AGHT+IEu9NS43G5dTpzF29TFKFJjzLvlEqhCkgDpeD2wjKV1j+aJmZWCmxn+NXLDTVlQ4pp1Qgzlig==
X-Received: by 2002:a05:693c:4085:b0:2a4:3594:d552 with SMTP id 5a478bee46e88-2a6fd17de07mr337854eec.31.1763594559435;
        Wed, 19 Nov 2025 15:22:39 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc5e3750sm2550279eec.6.2025.11.19.15.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 15:22:39 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	hch@lst.de
Cc: linux-block@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH V2 1/2] loop: clear nowait flag in workqueue context
Date: Wed, 19 Nov 2025 15:22:33 -0800
Message-Id: <20251119232234.9969-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The loop driver advertises REQ_NOWAIT support through BLK_FEAT_NOWAIT
(enabled by default for all blk-mq devices), and honors the nowait
behavior throughout loop_queue_rq().

However, actual I/O to the backing file is performed in a workqueue,
where blocking is allowed.

To avoid imposing unnecessary non-blocking constraints in this blocking
context, clear the REQ_NOWAIT flag before processing the request in the
workqueue context.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---

v1->v2:-

Unset REQ_NOWAIT at the start of the workqueue context. (Damien)

HEAD:-

commit 6dbcc40ec7aa17ed3dd1f798e4201e75ab7d7447 (HEAD -> for-next, origin/for-next)
Merge: 58625d626327 ba13710ddd1f
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Nov 5 18:24:17 2025 -0700

    Merge branch 'for-6.19/block' into for-next
    
    * for-6.19/block:
      rust: block: update ARef and AlwaysRefCounted imports from sync::aref


---
 drivers/block/loop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 13ce229d450c..ebe751f39742 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1908,6 +1908,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 		goto failed;
 	}
 
+	/* We can block in this context, so ignore REQ_NOWAIT. */
+	if (rq->cmd_flags & REQ_NOWAIT)
+		rq->cmd_flags &= ~REQ_NOWAIT;
+
 	if (cmd_blkcg_css)
 		kthread_associate_blkcg(cmd_blkcg_css);
 	if (cmd_memcg_css)
-- 
2.40.0

