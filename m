Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CA91E8344
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283016; cv=none; b=nBtr89ZKvNUTo80He3rVBkxF9vVum8BrLbArDbSJowHhLU5OYgN4tq2V5S4V3XcZZVtn4jD18EpMzOMKmQ4Vvxq9GDgz9llk0JxMpxG8AW+g/hewhfdErH+Emvxi3YyHMEH+3ydLtfcJE/VKl5X1q5zRpL2xdxPHMHF6BpX+9GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283016; c=relaxed/simple;
	bh=mPQe5jyzGkiT9fc3vZLGVVqn+kIzoIdAIWfDqZz60o4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S/xdH12LAmpPiyAvF6YoGIEWMWj+baubecyT8z3EEVLO8PfH8tmOo+Brj+7CcI0FC9hCZbzcovt1nhinIICpoNglQqP/4kmgK6gJ3MDZjFqcPq0fwDHaKq1R5YwFrY+/6gL2s93rBRyNdDFfFRFg065VwGL58+NqMJN0sgr+blM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vg7Op2Td; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vg7Op2Td"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742283012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+QiWbSF6w77Vxmgs9pymecmjPKeDqaRIzPvvqyvzzrM=;
	b=Vg7Op2Tdmfmi2Bd2k7wFKxfps4Kw9pdqxm6KOY6IcxmSh8x9nHrsJNOM4/sGj4Wn45arL6
	9536zgTvTk3DrKt3u6uoq2X0YlpeCD283ZxbIzfJPqAVBFcDk30QCeUinwZUq6FXZMNr6d
	Jy36VluzsN9VxE+5+0kB7S4NU45jcT8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-KCelIgecMAC-gYmSwz7k_Q-1; Tue,
 18 Mar 2025 03:30:11 -0400
X-MC-Unique: KCelIgecMAC-gYmSwz7k_Q-1
X-Mimecast-MFC-AGG-ID: KCelIgecMAC-gYmSwz7k_Q_1742283009
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C84A1801A12;
	Tue, 18 Mar 2025 07:30:09 +0000 (UTC)
Received: from localhost (unknown [10.72.120.33])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0863D1956094;
	Tue, 18 Mar 2025 07:30:00 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kun Hu <huk23@m.fudan.edu.cn>,
	Jiaji Qin <jjtan24@m.fudan.edu.cn>
Subject: [PATCH V3] loop: move vfs_fsync() out of loop_update_dio()
Date: Tue, 18 Mar 2025 15:29:55 +0800
Message-ID: <20250318072955.3893805-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

If vfs_flush() is called with queue frozen, the queue freeze lock may be
connected with FS internal lock, and lockdep warning can be triggered
because the queue freeze lock is connected with too many global or
sub-system locks.

Fix the warning by moving vfs_fsync() out of loop_update_dio():

- vfs_fsync() is only needed when switching to dio

- only loop_change_fd() and loop_configure() may switch from buffered
IO to direct IO, so call vfs_fsync() directly here. This way is safe
because either loop is in unbound, or new file isn't attached

- for the other two cases of set_status and set_block_size, direct IO
can only become off, so no need to call vfs_fsync()

Cc: Christoph Hellwig <hch@infradead.org>
Reported-by: Kun Hu <huk23@m.fudan.edu.cn>
Reported-by: Jiaji Qin <jjtan24@m.fudan.edu.cn>
Closes: https://lore.kernel.org/linux-block/359BC288-B0B1-4815-9F01-3A349B12E816@m.fudan.edu.cn/T/#u
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V3:
	- replace comment with Christoph's words(Christoph)
V2:
	- update comment(Christoph)

 drivers/block/loop.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8ca092303794..674527d770dc 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -189,18 +189,12 @@ static bool lo_can_use_dio(struct loop_device *lo)
  */
 static inline void loop_update_dio(struct loop_device *lo)
 {
-	bool dio_in_use = lo->lo_flags & LO_FLAGS_DIRECT_IO;
-
 	lockdep_assert_held(&lo->lo_mutex);
 	WARN_ON_ONCE(lo->lo_state == Lo_bound &&
 		     lo->lo_queue->mq_freeze_depth == 0);
 
 	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !lo_can_use_dio(lo))
 		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
-
-	/* flush dirty pages before starting to issue direct I/O */
-	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !dio_in_use)
-		vfs_fsync(lo->lo_backing_file, 0);
 }
 
 /**
@@ -637,6 +631,13 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
 		goto out_err;
 
+	/*
+	 * We might switch to direct I/O mode for the loop device, write back
+	 * all dirty data the page cache now that so that the individual I/O
+	 * operations don't have to do that.
+	 */
+	vfs_fsync(file, 0);
+
 	/* and ... switch */
 	disk_force_media_change(lo->lo_disk);
 	memflags = blk_mq_freeze_queue(lo->lo_queue);
@@ -1105,6 +1106,13 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	if (error)
 		goto out_unlock;
 
+	/*
+	 * We might switch to direct I/O mode for the loop device, write back
+	 * all dirty data the page cache now that so that the individual I/O
+	 * operations don't have to do that.
+	 */
+	vfs_fsync(file, 0);
+
 	loop_update_dio(lo);
 	loop_sysfs_init(lo);
 
-- 
2.47.1

