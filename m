Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1053A1B6
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742259826; cv=none; b=NqOleIq3gxUOfkT1jxl8CJlp/IRS326SU0DF4+Zm7GUzk9Wy3S+6oSmDh11Kp5RmCSDWqF3GTBgH//T/8SSLMcxEi3yWeQ7jsKw0yriGAypHZoz4kxzfy4DwF1F+kp5NfYSK6JXwxvJN6twdXUe5EXNpieca5hi7eg9XFNvoZ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742259826; c=relaxed/simple;
	bh=tXzFHU+YJe7nAKZfLXM1H84CmAL0HqYIJ8uEIjbxUTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=poIAiMT4EzvDbEe8mxeHOaTjD0E2wYobZkrpO9BQtmvz1yYVcRYI61RzmQlQYco1V8tK5euAP/wZAAy/CLyoKlLbJcaVO0m52MSTCQ/G+hcAWycdOKZ3mS84R5MkYJGDKMImgtUp17A2gLWMdj8QFzJBe0IBx2tvaN8zjKyswu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NW9dpfYp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NW9dpfYp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742259822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NKamC+sBlbOLkmcHPHeh1SSISbeEUTWmv8exOpGvReY=;
	b=NW9dpfYpa37hLBUW/U2Hmvea0HPsPUJcd/o9kSB84Jlxf6AC1h6RPOC7N8pmQbOAW5x8LO
	DA9Hn5NZ2cwdWuRvGuNgUOCWp9GHXR3d74ERKFFS50mkQ7RlFkzxXehO5i66jjrQ7JW5pK
	AniNGvJIjXFjyrVphrW97bqdqtl6MRo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-OA7lMe-vOuGG-mVJPQ8w1w-1; Mon,
 17 Mar 2025 21:03:36 -0400
X-MC-Unique: OA7lMe-vOuGG-mVJPQ8w1w-1
X-Mimecast-MFC-AGG-ID: OA7lMe-vOuGG-mVJPQ8w1w_1742259815
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5BBE19560B0;
	Tue, 18 Mar 2025 01:03:34 +0000 (UTC)
Received: from localhost (unknown [10.72.120.14])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33A4E1956094;
	Tue, 18 Mar 2025 01:03:31 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kun Hu <huk23@m.fudan.edu.cn>,
	Jiaji Qin <jjtan24@m.fudan.edu.cn>
Subject: [PATCH V2] loop: move vfs_fsync() out of loop_update_dio()
Date: Tue, 18 Mar 2025 09:03:18 +0800
Message-ID: <20250318010318.3861682-1-ming.lei@redhat.com>
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
V2:
	- update comment(Christoph)

 drivers/block/loop.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8ca092303794..7ddb3cbc20fe 100644
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
@@ -637,6 +631,9 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
 		goto out_err;
 
+	/* may work in dio, so flush page cache before issuing dio */
+	vfs_fsync(file, 0);
+
 	/* and ... switch */
 	disk_force_media_change(lo->lo_disk);
 	memflags = blk_mq_freeze_queue(lo->lo_queue);
@@ -1105,6 +1102,9 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	if (error)
 		goto out_unlock;
 
+	/* may work in dio, so flush page cache before issuing dio */
+	vfs_fsync(file, 0);
+
 	loop_update_dio(lo);
 	loop_sysfs_init(lo);
 
-- 
2.44.0

