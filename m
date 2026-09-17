Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75793495ACD
	for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680061; cv=none; b=ijHAQYhTDgh93keTlaIfDUh4+N9b+ULiUP+dqH3Ade7kQKL7LPzTn+uVfNAgmes01AT3kT09t/VfflUK4MtNHDbzbUvMDWN6XXBl+4T0TVsCivVslUUiMZBa0+1q3HMOa1XuwhCuwayQ0EXY+PIFbVsWCs7al0+D5ySrr6QfL2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680061; c=relaxed/simple;
	bh=39wAaJOQN2nKzkzR31a8k8Uac8sMgdEbF/hmPZX0dBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXafkzjxTOgzOOp1F4bhGYzD/AeyL2+G/RUjzr+wlrengdoXx7bdFrsi98OTKzznBxW9uQvHWxhG9WWtNuJAoMusqGr/xlje768g7xUkLkN5COakEPYPGFBMyJYlAliYsjCT8KMWixWMPi91yQixp+tKJvf7Wdw7SYwKTP+5oV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NMdDZCyf; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NMdDZCyf"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hm7w96gGTzlfvq0;
	Thu, 17 Sep 2026 21:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1789680049; x=1792272050; bh=9jy9i
	CbJCYJW0f7XVQwGhYYpe5zry6/qD1uiWheGz6g=; b=NMdDZCyfgr7QV4TDjKlri
	7fwpVT0yo1tOUJ63h6qdKRXVzfGQgr0tqekFgBf0uV0mQWIbwaxDHofxrOBLeFK3
	AAFX3c7k9TYUGaWxIlMWbnfCEADHFypCoEuWu09xMBNVOTnHPcmEy9eX4AWRCE4F
	YKEcqtnV6mUGIApLcf9CQhPpNsNavvzoT5JifNKz2gO/o8n9CmR1MqioxS+vi6Yb
	3RXBsQYbZmYMIEmgXxAZmNvbf/mJtab0oFUHfxNBJL3ZCrmztB7vFgmdRA/ZpHZj
	AbE735tysuhR94G2gt79TipY9vy0bS/vqXxpQf6vLrRrqFyVXLkFMDJNJZ2rWTz/
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id j8OemBVde0M6; Thu, 17 Sep 2026 21:20:49 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hm7vx3r9dzlfvpK;
	Thu, 17 Sep 2026 21:20:45 +0000 (UTC)
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
	Tamir Duberstein <tamird@kernel.org>,
	Haoze Xie <royenheart@gmail.com>,
	Ke Sun <sunke@kylinos.cn>
Subject: [PATCH v2 1/2] block: Add post_release() operation
Date: Thu, 17 Sep 2026 14:20:25 -0700
Message-ID: <72661d0de27da8c843faf18f9b79442b0e1bb6b5.1789680010.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <cover.1789679858.git.bvanassche@acm.org>
References: <cover.1789679858.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Add post_release() block device operation which provides a hook for
performing synchronous cleanup without disk->open_mutex held, which is
needed by the loop devices.

Real-world container engines, test suites, and system utilities rely on
fput() from __loop_clr_fd() being completed when lo_release() returns.
But changes which went to the v7.1 merge window broke an assumption that
there is no outstanding I/O when __loop_clr_fd() is called, causing NULL
pointer dereference problem in lo_rw_aio().

In order to fix this regression, we want to allow __loop_clr_fd() to flus=
h
outstanding I/O. But calling drain_workqueue() from __loop_clr_fd() with
disk->open_mutex held causes lockdep warnings. We need a mechanism which
can flush outstanding I/O without disk->open_mutex held.

This post_release() operation may be called multiple times since multiple
threads may open the same path concurrently.

Also, this post_release() operation is called from only bdev_release()
path. This is because loop_configure() is not yet called (there is nothin=
g
to clear) if something went wrong between an initialization lo_open() and
an error-unwinding lo_release() within the bdev_open() path.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
[ bvanassche: changed bdev->bd_disk into disk and removed those reference=
s
  to loop driver internals that are no longer correct ]
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bdev.c                     | 3 +++
 include/linux/blkdev.h           | 8 ++++++++
 rust/kernel/block/mq/gen_disk.rs | 1 +
 3 files changed, 12 insertions(+)

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
index d003a9d2d1f6..5f51fe0d8bcc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1580,6 +1580,14 @@ struct block_device_operations {
 			unsigned int flags);
 	int (*open)(struct gendisk *disk, blk_mode_t mode);
 	void (*release)(struct gendisk *disk);
+	/*
+	 * This operation is called after returned from release() and
+	 * disk->open_mutex was released. But this operation is not called
+	 * after an initialization open() has succeeded but something went
+	 * wrong and an error-unwinding release() was called.
+	 * This operation might sleep and has to be idempotent.
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
