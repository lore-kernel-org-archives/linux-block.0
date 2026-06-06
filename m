Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9D33C2770;
	Sat,  6 Jun 2026 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777680; cv=none; b=agdZp2ecDQ2NoABnu90gwbtrF7//cisNIHhLM3N6SgzhpPTese2k2xAeqLJMVV3Q3GD74WHHuHH1z0L7/kvI0Q350xnqx+tcwELjYAQtukB1Ku4cGRrdJ6arwf8Yc74xV3Rug0gI/vD2rb9mkj8rUI0XHTebzlau42usy6oXjhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777680; c=relaxed/simple;
	bh=fKGwdJHoNHUwhOIfKcibhxChzxyiTj8/e8WfrQ9PZFs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hi8HAaYfyMaGZ3MTSVrcEr8CLcYDJgpFbC+6twHIKTuPmzLqX4on/9fZx43nNNFTWm1M9E3e/YI+c3r+v6gFEGKxydBk9w2tjlTvGM3FRE1ffQDmQeL5uLiHaKoIdvVrkSTyVjMPKAFNsGn49o0+J238H+68CB2UEMr9tIqyFPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=oSFBNSUh; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="oSFBNSUh"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxcb-007cN9-VP; Sat, 06 Jun 2026 22:27:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=07AM9jxTS+R70+Fd56Eqvb5JidnnKIlts+qfLPC2V4E=; b=oSFBNS
	UhFX+16VsHtYj7kY++Jfjfq4p2Cj4afMSOFA0gsCmfteEeCybHEA888ITriDYlBIGSGOEzwyzhVU+
	DjcM5OmnESNSFLJoB5v+Lu7NvG/h8efpISrDGEBmndiZHQbmlxh7+evkj3g4lJYgH4OwquhJ8v42R
	wrpNEvjx5ei2DnZPwqvrDmRCPlZ06BkZpiTpaRKWAFYmUw9T7cX7S0EF6DLhArm1sDarzBKjP0z+D
	kntMB8LvLc+0WM5JMIMwP7Y7wVT5Hok7wLHubZSZJuezJSwXe3iAs37ZxLjf+YMC+RhtsEquhw/EY
	5nnF0Yf9uns4YNSKiixofu94QS3A==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxcb-0000vy-Lx; Sat, 06 Jun 2026 22:27:57 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxcV-006elj-Ki;
	Sat, 06 Jun 2026 22:27:51 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/block/rbd: Use strscpy() to copy strings into arrays
Date: Sat,  6 Jun 2026 21:27:44 +0100
Message-Id: <20260606202744.5113-5-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Replacing strcpy() with strscpy() ensures than overflow of the target
buffer cannot happen.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4065336ebd1f..632fa2d56ea0 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3672,7 +3672,7 @@ static void __rbd_lock(struct rbd_device *rbd_dev, const char *cookie)
 	struct rbd_client_id cid = rbd_get_cid(rbd_dev);
 
 	rbd_dev->lock_state = RBD_LOCK_STATE_LOCKED;
-	strcpy(rbd_dev->lock_cookie, cookie);
+	strscpy(rbd_dev->lock_cookie, cookie);
 	rbd_set_owner_cid(rbd_dev, &cid);
 	queue_work(rbd_dev->task_wq, &rbd_dev->acquired_lock_work);
 }
-- 
2.39.5

