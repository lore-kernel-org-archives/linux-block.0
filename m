Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3407B397E83
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475157; cv=none; b=klQUakH8pfj2NmDg2UEiyBXxnPwwahFUhtuf8WwZXR4uQBC9L2xXpCWsoJpDgFSeDRCjOIiO2xebIsAL4W59lZdX6ZjyqnZRQxKjFPaAdJct4fJcoxY7S/V1X0/+KBPMEJVwkP+YgvWgvOUy/ZdKdirnH3xLbS4qps1bH+5798E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475157; c=relaxed/simple;
	bh=QQ0+f9FpQcpcyF/mBaY/eSnlM+UvYOEFa/xhirhhDBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiCcGKGO2GutyObfsIYhfjyDvhtzx1hntzEIjYSY/FW5tfR4YvNlPK6fYVpYe5jfYNtX086+Erxcbfc84VQNlXM6vffmepaNOK3VXNaMAfihSiLns1KMPn+BS+tUYndfGdG+zywfJznPkTIOZjNyouyk5wba65u+0fi1emNGo9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=499oY6d3; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="499oY6d3"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0pB5584zlfvpM;
	Wed, 25 Mar 2026 21:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475151; x=1777067152; bh=CCXLZ
	rtoeBeJvtZ5JDvSLdcCSU6v6E0f8jtQwb4l3ss=; b=499oY6d3/cg+h1GB/h2ox
	zjlb8D3AWR5/ckT/m/kkDTqMvfzldRgVC1ynNMbRXfFEE9VE+RgQoUh0P40ZS9kK
	cJNuS5/tGsP+BZl53ZlpSU3/Pawvjd98tw1cGm7z16YgY5JxqI1a+cnpepDT9Wjx
	p/ODA0SE/yHsj8Dd7SMswTftmVvpBjikqWtwOxi7Mw9XK75sy3MANbqEK0egiv+j
	9EvwvyU+0Cw1Zc+JdUfBbjZuAq7D5Asr/xP2vIrCfcaY15HUAwZeCUEqfKVQV8ID
	J/qbLtfDSEeWMSDvXqttrm2Uaa83ECBomzP0xAY8NxIpa83hcmzTFu4+FLlfVQTZ
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id g7EPz8h6RIO4; Wed, 25 Mar 2026 21:45:51 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0p56s0SzlgyGT;
	Wed, 25 Mar 2026 21:45:49 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 09/26] block/blk-zoned: Add lock context annotations
Date: Wed, 25 Mar 2026 14:44:50 -0700
Message-ID: <20260325214518.2854494-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325214518.2854494-1-bvanassche@acm.org>
References: <20260325214518.2854494-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the lock context annotations required for Clang's thread-safety
analysis.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index e1a23c8b676d..df0800e69ad7 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -439,6 +439,7 @@ static int blkdev_truncate_zone_range(struct block_de=
vice *bdev,
  */
 int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 			   unsigned int cmd, unsigned long arg)
+	__cond_acquires(0, bdev->bd_mapping->host->i_rwsem)
 {
 	void __user *argp =3D (void __user *)arg;
 	struct blk_zone_range zrange;
