Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00E64E80B4
	for <linux-block@vger.kernel.org>; Fri, 18 Sep 2026 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731845; cv=none; b=Xz9CUWKvPfY8RyqdV6k+VyNCTxl5XlA4AWdT4QyV1IZ0zSyTGoPHHhWbkYvz9N48Qbe/dtpmJsGv4MXuKSyFIKadEuJFnYySfdAXYEYsONLVLD6Tg+pC30gMPZOMjeng2yGKOpZ/ZMCqT28NauoMSrO1nlxQwTrG7ATsay4dhP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731845; c=relaxed/simple;
	bh=TLmFSaGZ6YlfSIeQ9CJTEgY2bTQ6Uc8e6Zt8WOBkoCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8rfbBEbpZkitQv69ok/4mPItzOaJwbJbzDCYkOLQ0EixNRT3hzf74M0ur9iRkqiIJwoT6/HZEoKf4wG6ok9aG0bTZ6O6zHgLCSIAEejW7VImq9buPha/RtVpMknNQBLJaUgby2WgiKLUtRdBpCWTtP6MeaAeUyX7/HPprmgxcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGmqb0Yu; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGmqb0Yu"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8692a8568e9so545275b3a.3
        for <linux-block@vger.kernel.org>; Fri, 18 Sep 2026 04:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789731843; x=1790336643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LQcaFZ1+zYaV5pEknG6YG0muENfu4eg72I6eX4kOQzo=;
        b=CGmqb0Yu65zzdUUzUmepcbz+tf4FhYM3HJtqx084QCUciqeCp8jhRZ416E0YoVkoeW
         MQbCuxMsY0cvVmcoN/S5Ltaiud5mPwFKE0fFGIOKfQTFd24OWrUVXaYNjQPy+6PA5CKj
         qk+1+Tt1Cgz3KMu796UomgACMFPG2te2UBEyJR484q/rJYpmPvUhRsWFI3Rc5RatVbyk
         t1OIGtk2eHNErNehHqSzUSe6aOSl4E6kPDQ+JRgF57iy735wATgssIGyqEWRukdrk1gh
         Eg8e7uH00h/5ES2inb1IPYAqltIxuF2LLvYAQSLgyYdqdRS+jDzWGTE4TvrUSR2sI+Oa
         s/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789731843; x=1790336643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LQcaFZ1+zYaV5pEknG6YG0muENfu4eg72I6eX4kOQzo=;
        b=2iGACWx6NvCYVBYUsZQsJx7wuKc9xcE+8mB/+OUEDx3r8Qezkocp0P2M+60ceV7+AX
         7mIZ2e2IrCDgt9cpKZHKSOgZ+oig4sDAN2kh1O+b4uvOA+m8uxdSjXGgUFsBrWzN/2ws
         z2ksgd0uHPSd0bGPZ/Zi6r6aCdCHteuFfCSSPI11VDa2wy1j9DrQNeWvzIR9EY6Xt3pF
         XaTdEJ7U/LEyM6YBU9Pl9e/4/+Wp92faUeO/w5oPxkjf8x0QFEglwLciMVnTZ8rZEyfO
         djhEH6Gt/D/HEI9hHwIZ39yBC6cC6Emkxx+GHrOiuGKk6S60P/gLzSMQT/m6tcNwvPMk
         /mSA==
X-Forwarded-Encrypted: i=1; AKwUvBy6uYAjncvPrBVzwUxX4jfMomn4ufbXZLehfAZObvItBnD6XM3vDk+XYESTYkMWUc7/Oosnv8g2dst5bQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lzymeJ2rwD/vO65QXDb54VPfgEacpCJrmLpZ1x7+cUWvpyJquu
	94w0Xlimx7FuZMb9iu09HwJkf/vcrf7g/RwsUgKriMZl0MbC/UDrEMQu
X-Gm-Gg: AYBFou0s3E3U5Oh3uS3kCfkYClb9k28Km+J0TyRDyU25uhzXtSYEXe6j8aQ2UHz+C+W
	BPYzHe5Gi60Y7VwAozO5HuUddvdJBRviomt8TYEvEcCb/1YEGA+Sxdr7ERxoS50SVSvX3Sp+tH1
	7esX2fE+m/b516AWJZxZR4LLkGNTVsW+3HDLNdFzkfT6BcLKlNKjQcidOgSEuKqkxypyKF+uM8t
	IsbVwHQKBLnTD6i14FiavhjQyklRA3wrXRbht23+6KKi+KQEaSVi4FBU5ZONR0Le9zBWtRVGxSv
	FSrmo1cYT/flbtTXoJnr+ptmNNxjBQoNhdd1sjb06oVUBZ6ZW4yWc56yI6cvRPSehE1E34VvwQw
	u/0Vcj8OGWdfFDqnuUW9GtdIMhmZmIcZOXDJQFAqU3CQ/A7BK/5VNO91G6SY4ZTt+cdT1zva0YR
	O7hA4D7/3Y+ScpdXb3uq5tvFphPn+ZoRV88eYaVwaJG/vCuf5oyQBHWMe00gq1UGwQJkG5KbOap
	VV1QcLL8hU=
X-Received: by 2002:a05:6a21:9204:b0:3d1:e510:905f with SMTP id adf61e73a8af0-3dd8c3fd351mr4731985637.1.1789731843082;
        Fri, 18 Sep 2026 04:44:03 -0700 (PDT)
Received: from 73ebd4c7787b ([183.194.144.114])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144ce02b063sm3404520c88.9.2026.09.18.04.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 04:44:02 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH 1/1] xen-blkfront: unbind irq before tearing down ring and shadow requests
Date: Fri, 18 Sep 2026 19:43:54 +0800
Message-ID: <20260918114354.3660102-2-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918114354.3660102-1-ndaugoing@gmail.com>
References: <20260918114354.3660102-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In blkif_free_ring(), the driver tears down the ring's persistent grants,
shadow request arrays, and shared ring structure (xenbus_teardown_ring),
and only calls unbind_from_irqhandler() at the very end.

While blkif_free_ring() is freeing persistent grants and clearing the
shadow array, the event channel interrupt (blkif_interrupt) is still
registered and active.  If an interrupt arrives from the backend during
this teardown window, blkif_interrupt() reads rinfo->ring.sring and,
via blkif_completion(), accesses rinfo->shadow[id].grants_used and
rinfo->shadow[id].sg.  blkif_free_ring() tears these structures down
without holding rinfo->ring_lock, and the handler only checks
info->connected at entry, so this is a real race resulting in a
use-after-free or NULL pointer dereference.

Fix this by moving unbind_from_irqhandler() to the beginning of
blkif_free_ring().  Calling unbind_from_irqhandler() first frees the
IRQ and synchronizes with any in-flight interrupt handlers on other CPUs
before ring memory and shadow request structures are deallocated,
matching the teardown order in drivers/net/xen-netfront.c.

Fixes: 907c3eb18e0b ("xen-blkfront: convert to blk-mq APIs")
Cc: stable@vger.kernel.org
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
---
 drivers/block/xen-blkfront.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 8dad7bf5f664..e70b78ca4df2 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1210,6 +1210,10 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 	struct blkfront_info *info = rinfo->dev_info;
 	int i, j, segs;
 
+	if (rinfo->irq)
+		unbind_from_irqhandler(rinfo->irq, rinfo);
+	rinfo->evtchn = rinfo->irq = 0;
+
 	/*
 	 * Remove indirect pages, this only happens when using indirect
 	 * descriptors but not persistent grants
@@ -1292,10 +1296,6 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 	/* Free resources associated with old device channel. */
 	xenbus_teardown_ring((void **)&rinfo->ring.sring, info->nr_ring_pages,
 			     rinfo->ring_ref);
-
-	if (rinfo->irq)
-		unbind_from_irqhandler(rinfo->irq, rinfo);
-	rinfo->evtchn = rinfo->irq = 0;
 }
 
 static void blkif_free(struct blkfront_info *info, int suspend)
-- 
2.53.0

