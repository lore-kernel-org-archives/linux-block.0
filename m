Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4577646D0B0
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255874; cv=none; b=s6rwx8UcyNIvko6ArecmmNY+qgLmE33Nec/bv5yFcMocUFSXbex8BPOlSAVmI8n4RV/BB6waLCLn1sPbwc4xqgFrep6jkjw9THMqShadKSRuP8FkXGd1x0X/AjjGXexO6ajClP34wJIfjCZep7+Okg6AVB2u1sFYU6pvdWtXZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255874; c=relaxed/simple;
	bh=c1qEmH+UL/pFvCmcNNgkQhECskOUbfiX/BI/jDkVfvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AthhnemcfL5srkUkLDoq27v+bsfgJy8MyX9GV5N2Xg4TSDgYqhmk+g4tzObcSXmCoAA2brnHCLsCRo+COc7G/ELUU82Qi71P0vWUYHzhl7Dmjz17Da1PPtY8e8lrm+0HV+KYUeqfDjo1pqjBFda5wwrKGr/6omdoK/7fvK0/LnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Qv5W3Pu9; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Qv5W3Pu9"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hQvP9019NzlfsTm;
	Thu, 20 Aug 2026 19:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1787255866; x=1789847867; bh=TFqIQ
	ijKk9ttA/mkHwC11GKVs6CEeK/5Vbu3CVs2zxQ=; b=Qv5W3Pu9YUmB1I2k9Z9sd
	vyWQgeHxo4d6ahz12Da1U4Xo6zIzs6ndAn5tyO10jrGeJx/RmjZy+FQ+YEqfzi8n
	Fsvh4WqyPCGLfGVI27YWwFr0Znq8P7KlLQ712TDKwwt3r+XKsOseS0p5P5nvEZ5R
	9T1yoBBMu0u2xpNCHRfj7aFecxLwYM8O3qp9s9woS2Kx9m3pSJx1P05fEP7Jm8hx
	wOx9XP+LNGLcuNdQZcPRKraM6wi1kIRjsH7U6rwY0GYfY8FawYVkGLNqcgJfRqOO
	IsjDu2iDrdRw/+4TbsZgNhK0hXLjSCVtcExQUaYsT1fW5BRJuJLJnCXPjNjjsPWw
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6dQDuKDgzPri; Thu, 20 Aug 2026 19:57:46 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hQvP44kpbzlfsVF;
	Thu, 20 Aug 2026 19:57:44 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 04/13] loop: Assign a unique lockdep key to each lo_mutex instance
Date: Thu, 20 Aug 2026 12:57:12 -0700
Message-ID: <be98ebce1b597795e5b72565fc4c256e22de0e62.1787255652.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
In-Reply-To: <cover.1787255652.git.bvanassche@acm.org>
References: <cover.1787255652.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for nesting lo_mutex in loop_validate_file().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 638d97293a79..5c7f72e01345 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -20,6 +20,7 @@
 #include <linux/suspend.h>
 #include <linux/freezer.h>
 #include <linux/mutex.h>
+#include <linux/lockdep.h>
 #include <linux/writeback.h>
 #include <linux/completion.h>
 #include <linux/highmem.h>
@@ -74,6 +75,7 @@ struct loop_device {
 	struct blk_mq_tag_set	tag_set;
 	struct gendisk		*lo_disk;
 	struct mutex		lo_mutex;
+	struct lock_class_key	lo_mutex_key;
 	bool			idr_visible;
 };
=20
@@ -1801,6 +1803,7 @@ static void lo_free_disk(struct gendisk *disk)
 	loop_free_idle_workers(lo, true);
 	timer_shutdown_sync(&lo->timer);
 	mutex_destroy(&lo->lo_mutex);
+	lockdep_unregister_key(&lo->lo_mutex_key);
 	kfree(lo);
 }
=20
@@ -2114,7 +2117,8 @@ static int loop_add(int i)
 	 */
 	if (!part_shift)
 		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
-	mutex_init(&lo->lo_mutex);
+	lockdep_register_key(&lo->lo_mutex_key);
+	mutex_init_with_key(&lo->lo_mutex, &lo->lo_mutex_key);
 	lo->lo_number		=3D i;
 	spin_lock_init(&lo->lo_lock);
 	spin_lock_init(&lo->lo_work_lock);
