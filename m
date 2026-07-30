Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D493D564B
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400810; cv=none; b=Bp7sqih1zty7ukxX8y427Wam4b9QT+D1wEzqLvOAQG70o3mT35MLnsBqozqEMI1g7pHqWPiF2SJ74GbgXKL27/ukN9IplSCB83+TaSsx9GEuhIs4OaAaiH5YYRDcdiQs2Xa45XcLmoTjv98hyw/IQiz/bMImk1w7ijxAQHZnWQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400810; c=relaxed/simple;
	bh=F6UJWQIoL4kX/qvNM9OgktLW6TykNB7tRUOyNBlzmgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LUojRkqVG6FHKB7YCbetaClExgGIJ0p1p2G6sb1BwixLIORP+OXPSsCzQXHU9EOlAr6ZzzvTMrTgwIhfLY46tfrhZaP4gRkdNDr2NrLsd8QKLoZvQzr19Xop6H6pgGdPZ8SJo1GPj1XtL6jrLkGbus4Fi0jW5IdZ4wU8xd7LOn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/cV7ma5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/cV7ma5"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso21238905ad.2
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 01:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785400806; x=1786005606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zw36b6isDpAagmijX70XpIGwqKUfzgvnzMxTieNxr40=;
        b=j/cV7ma5fVAsnLVIMNMvBivpuYoIMJg6WA7W2Cr1DdHWdBYRb/SbTyVNhniKEtMiSL
         xdwuFRcPRrddevvnd2Ff1PPyhaBr/nLaBt5XRwcT21W2ddVpZjXN0/84ogdElCB/EvoP
         End91y9tgt7mCB2Dx7bTn9xRO072m67SUhsSlU0uO+OQNumkY9n/HcEi1kHWvZzHD9mE
         HlezK8y7jNCRlwW3ZdF4LRfimanT1hx3DaRMRH0d4eu96flJ0II7cf+wjxBE9QFh7R0h
         CQikdwbDMw/oUzAqOpQ5ZkODAsMZAAcmIpb6PglRehgF4REYZTTwtvu6RsOyUFQhOXb6
         fYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785400806; x=1786005606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zw36b6isDpAagmijX70XpIGwqKUfzgvnzMxTieNxr40=;
        b=hjnh7O3QyrZ2TvOSYOb/uFZd17zB46lpr4Rx59ojB49OQaq89uUbwyraeeNAjPt0du
         ZnsAFItEccmi8Y23EM3ndvcvOneShRKIGAYV5UxKYdWxPbdXCfCv6avvKL1UZJ1gunQn
         zCtjQFpEGTNNnd/Zf2skpVEG0Rl5xgNz68aLTCL7TJLlTpc5s7sdMoZTyP9vUxBTSonf
         043LtgcwPMzgp4ewZqCTsdYvT+LIPnjVwIGTc+fsjrq6J5QYWjTwBwn9Fva1dEBY90P2
         MJj2+hQqQqfCUU6IfvW6hREBHiaXNQSnEvHOC2MjhGD8yyopjOOMUen38YeWhKshGKl9
         0CKw==
X-Forwarded-Encrypted: i=1; AHgh+RohUxnDTE00aySnCDIhj3TngceDAis5m2N5IheEEV9jTngy2cOUCoETbnI9NrW6RO1ZGX4j34W9HVzlYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YygrtRrLUZ432zeQmu9tFs4/MmlfH68bjBYX2Ttdefc4SZ1Nl+m
	gmJVadI5Mgyo+E5A0UXPCqfAkFx9TwxH+B9CZFEPDznBPDQw+9C5CGqJ
X-Gm-Gg: AR+sD10e8heFD6zuw1MJUCKKCERgr0bgfwtqJ0V5kJ+vj16LBbEP1QDwRs3T4M/CVMf
	LKsB/ixWBhhlsk+pKdqQHuj8nLQnTo9371uCbnndg1YuJedB5xOw6+tzyhLZylcLQlCQp1EJzEz
	F/ofdamSAw+pFu3g3BtbLatvEh3VxZvriiuGi0/G+lAJCEboYrxkcici598vf4M3JTTCZHRa6gU
	fqKtKqjoKXWnfWrew6xmWRGa4BxsVad9aAk0mZQXtggrnMkkt/MS2BD2PrnG6YTzUNAcFYNsCFa
	qOPnQ9ikJ5lbg5aFX8KylSMG8trvWV2Sogee/axgPVGROuNrgE5Pjp+0pS5RNVkMBdQ46f+DiFF
	reWkOb+4UhvCxo2nnPEEFTcOEisk+kTbnQpzjVQDKw0XOi7oGhqIBBMYBkHAU1wML+viTFielet
	6yezMdQ8RUV98SuF04IvqngtLnJlEGoqIc6AnZuJ3+HkUgcW6cqbFbGejlvJ/YUIqF1uIpOhQg2
	zzny0ZjmTGDes3bsRbKnNEui2rLj++0CTcx5fh3P1/+ruPS7QoB8ab2TFHVHSTeaySQQezCqnMd
	hvf2ORdFVEa447dtfgN9Z2EL5RkQ
X-Received: by 2002:a17:902:f652:b0:2ca:f21a:a6c5 with SMTP id d9443c01a7336-2d035b84ae8mr17886105ad.1.1785400806137;
        Thu, 30 Jul 2026 01:40:06 -0700 (PDT)
Received: from bass-virtual-machine.. ([114.247.65.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a465f7sm23003015ad.24.2026.07.30.01.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 01:40:05 -0700 (PDT)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: roger@xenproject.org,
	xen-devel@lists.xenproject.org
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	konrad.wilk@oracle.com,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH] xen/blkback: Prevent missed completion when draining I/O
Date: Thu, 30 Jul 2026 16:40:00 +0800
Message-Id: <20260730084000.3305702-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xen_blk_drain_io() sets drain before checking inflight.
xen_blkbk_unmap_and_respond_callback() decrements inflight with
atomic_dec_and_test() before checking drain.

The pre-wait condition check was added to avoid missing a completion, but
atomic_set() is unordered. With one I/O in flight, the drain path can set
drain to 1 and read inflight as 1 before the completion decrement. The
completion path then decrements inflight to 0 but can still read drain as
0. It skips complete(), so the drain path waits until the timeout despite
no I/O remaining.

Add a full barrier between setting drain and reading inflight.
atomic_dec_and_test() already provides full ordering on the completion
side.

Fixes: 6927d92091df ("xen/blkback: Fix two races in the handling of barrier requests.")
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
Found by auditing atomic operations used for synchronization.
A similar fix can be found in 6df8e84aa6b5.
---
 drivers/block/xen-blkback/blkback.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 7871099bc0d4..88526e349ce1 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -1021,6 +1021,13 @@ static void xen_blk_drain_io(struct xen_blkif_ring *ring)
 	struct xen_blkif *blkif = ring->blkif;
 
 	atomic_set(&blkif->drain, 1);
+	/*
+	 * Publish drain before checking inflight. Otherwise,
+	 * xen_blkbk_unmap_and_respond_callback() can decrement inflight with
+	 * atomic_dec_and_test() and still see drain == 0 after this path saw
+	 * inflight > 0, missing the completion.
+	 */
+	smp_mb();
 	do {
 		if (atomic_read(&ring->inflight) == 0)
 			break;
-- 
2.34.1

