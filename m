Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C7543BDC3
	for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588357; cv=none; b=S/y5BNfUL0p6QAM+i5AlnD89tNyqx0v5gOSotp0rmjRUug/yhoffzIK/iwDi55eO+Tvyu0EKq+Ks2JlK/Pf8WbogGrPy0pqvq6ctQKj7oMQN4AMgZbG4paNxyLYPHmvnky+BTQ7UKqCp6zzsd50GVLSty9u5HIAGmgY+lELM1aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588357; c=relaxed/simple;
	bh=1oZqw0aMGLb50TUR28U9o3GL8AvzDOuIKOU1ian2Esw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgaGB1BxiZKj0zwiGaflMmbJzP/Ap35kS5L+iIn/d2SwKV/wKxwS6t/7D+h7vMVUFAFdw+P9a1UDFjEe9hFoLPAHS6edapRGN0pjy7ajqjAe3nQjXsZtE6APG/scBCdFwgkjDkMSKpYG+TEdi0vw5e8kMbyIgCA4PaVxEYp40Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=kbQAoK/4; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="kbQAoK/4"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hlV0V6NK9zlfvqH;
	Wed, 16 Sep 2026 19:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1789588340; x=1792180341; bh=Dk2Rc
	Ywb04sibsB7/M3nrme66iQWONCkIamJ1b4I7K8=; b=kbQAoK/4dEFAG438rq8YZ
	ntITvGfG6lC2546peJXw52IXriRckBPSu2rQpAhdLm41PaF93Ue+iyrMFOwjGtpV
	Q0rBbEm4ntvoYEsziebia7CKjCU6yv8DnG5B3y+4QfLkRktGIvTxkInc0Usppj34
	lRvMyD1RxRGtNzAhQzGT/x+/6e4Gs6z/s+c9IWhHSbPRH0i/EQTXeSFXdbmPZZ16
	kSjPFYuRwMvhkDdhG+FLb2Ybgp9OO1qWpaB/44DB4F6oX5KVBBXLr3rQEOlkv383
	ZvZHK+m6IgaUvJx1CnwT7rgydNIOe3P8Y/qHyCwgrm/ylPT9ilQl97gwlM9G4xX+
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 5vXslY4j_iAD; Wed, 16 Sep 2026 19:52:20 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hlV0H6FMnzlfvpG;
	Wed, 16 Sep 2026 19:52:15 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Haoze Xie <royenheart@gmail.com>,
	Ke Sun <sunke@kylinos.cn>
Subject: [PATCH 1/2] block: Add post_release() operation
Date: Wed, 16 Sep 2026 12:51:52 -0700
Message-ID: <31df153b91170a7c91c717978c94cb4e140af1f3.1789587960.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <cover.1789587960.git.bvanassche@acm.org>
References: <cover.1789587960.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add post_release() block device operation which provides a hook for
performing synchronous cleanup without disk->open_mutex held.
This is needed by block drivers (such as the loop device) that must
drain in-flight I/O and perform synchronization after disk->open_mutex
has been released.

Suggested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bdev.c                     | 3 +++
 include/linux/blkdev.h           | 5 +++++
 rust/kernel/block/mq/gen_disk.rs | 1 +
 3 files changed, 9 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index fac74319e9fb..350f3c29d682 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1189,6 +1189,9 @@ void bdev_release(struct file *bdev_file)
 		blkdev_put_whole(bdev);
 	mutex_unlock(&disk->open_mutex);
=20
+	if (disk->fops->post_release)
+		disk->fops->post_release(disk);
+
 	module_put(disk->fops->owner);
 put_no_open:
 	blkdev_put_no_open(bdev);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d003a9d2d1f6..b35f8af1243e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1580,6 +1580,11 @@ struct block_device_operations {
 			unsigned int flags);
 	int (*open)(struct gendisk *disk, blk_mode_t mode);
 	void (*release)(struct gendisk *disk);
+	/*
+	 * Called after disk->open_mutex is released in the bdev_release() path=
,
+	 * after .release(). Implementations may sleep.
+	 */
+	void (*post_release)(struct gendisk *disk);
 	int (*ioctl)(struct block_device *bdev, blk_mode_t mode,
 			unsigned cmd, unsigned long arg);
 	int (*compat_ioctl)(struct block_device *bdev, blk_mode_t mode,
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_=
disk.rs
index fc97dd873974..2ff77ef49781 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -129,6 +129,7 @@ pub fn build<T: Operations>(
             submit_bio: None,
             open: None,
             release: None,
+            post_release: None,
             ioctl: None,
             compat_ioctl: None,
             check_events: None,
