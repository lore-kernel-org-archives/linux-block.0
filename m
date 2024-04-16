Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DF6130A63
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281348; cv=none; b=TbdrmQKRUyA9jWT/PvZf0HbaTbSqEMq7E1PU08rYrzIKsO8di5KYZW9Eh3ne45Hno/sCIR2lbx22FOD46GvIwmwaq+jR9CDU/6CVphOOSMJes+lJ6x7wMQnIYgPFVS3EQYxMNk+pqBkBkkKbVtM+L5UxtD89DhxiYsJCUKUdx6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281348; c=relaxed/simple;
	bh=04LmKJy9tv3jnf8es510u+F1veLrMcBHefejr9yQqoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dNH8qZ9QtnMNfK4JBucwW1KWgb98451x7nd4EyACSMw1RLpnQu1iD72HiVayl9sCeU3TsjfeTHst8En3youj4TgsRancmR4a9v4VHDb9RebLdQs9SVgRMo+wcSX6YLpRijm1cvO940h22qbWGl0Xo7Oib60GoQVi+u6v+Eir0Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-436c149d910so4577281cf.0
        for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 08:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713281345; x=1713886145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNYj7H9P7fHg2UmrKFO+txY1tWvttbrM2kjJrAop9rQ=;
        b=E0giUnseg55ahXPuB6ODklWh7WWstLG7CdIGX3Wer7Jx8vQvqotR1OsNjRegpqqY4E
         j6yEVxhYBCOBqZ0kwNQ0n8fM/ooI/gOxAUZ68v3+an8YSC3BqJTqfUHRJ26JtT2pjPAZ
         gIeZoX73IYdZxiuHo++3OCkHLENGAhgfsCvpO2wK8f7bSvmfa3YTh0mEFgRdhkXQ+9ct
         DLrrXWPYHSA+jXqtKdOeKoR9aW2YsB5KXqz+VHqw/xhR2QcDc0B26+YcFYGaycJ9UIiT
         bdByKfUD7lYCz5n4awahEb1ctB3OKIuwTIjnTTdJjcswmNAvcT8gNwj+LFUiKo2feUUb
         jOcA==
X-Forwarded-Encrypted: i=1; AJvYcCVxRgnKzSKNWoZOXwTi4Dmt199nh0SIYkiop6UOUS+ZxhLLJv7lt4+vxj2jXVPseOVWLh1nNn9bgqzEwX9V3A3U/kiposp6wUqYKdc=
X-Gm-Message-State: AOJu0Yyn4JIbDj+UT90S1s5r5qavmGrF6PzKCg26Bb9LBX9zprY4FqyS
	4Lao6kTsaSxZNXDeLbBQUQXgx9G1UybMpX7wGiJSNGRGliOjraycdzoT5E+30A==
X-Google-Smtp-Source: AGHT+IF6tklWOylUTS1UEDno/7QyHEfpcQ9UJz6XptzNyZPKu+upsSY/4Wln6nxMJzW7adK8zA6cVA==
X-Received: by 2002:ac8:5747:0:b0:432:ec1e:efc3 with SMTP id 7-20020ac85747000000b00432ec1eefc3mr15876571qtx.7.1713281345362;
        Tue, 16 Apr 2024 08:29:05 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id x26-20020ac84d5a000000b00436c05b12a6sm4509361qtv.60.2024.04.16.08.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:29:04 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: ming.lei@redhat.com
Cc: brauner@kernel.org,
	czhong@redhat.com,
	dm-devel@lists.linux.dev,
	jack@suse.cz,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2] dm: restore synchronous close of device mapper block device
Date: Tue, 16 Apr 2024 11:28:42 -0400
Message-Id: <20240416152842.13933-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20240416005633.877153-1-ming.lei@redhat.com>
References: <20240416005633.877153-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

'dmsetup remove' and 'dmsetup remove_all' require synchronous bdev
release. Otherwise dm_lock_for_deletion() may return -EBUSY if the open
count is > 0, because the open count is dropped in dm_blk_close()
which occurs after fput() completes.

So if dm_blk_close() is delayed because of asynchronous fput(), this
device mapper device is skipped during remove, which is a regression.

Fix the issue by using __fput_sync().

Also: DM device removal has long supported being made asynchronous by
setting the DMF_DEFERRED_REMOVE flag on the DM device. So leverage
using async fput() in close_table_device() if DMF_DEFERRED_REMOVE flag
is set.

Reported-by: Zhong Changhui <czhong@redhat.com>
Fixes: a28d893eb327 ("md: port block device access to file")
Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
[snitzer: editted commit header, use fput() if DMF_DEFERRED_REMOVE set]
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 56aa2a8b9d71..7d0746b37c8e 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -765,7 +765,7 @@ static struct table_device *open_table_device(struct mapped_device *md,
 	return td;
 
 out_blkdev_put:
-	fput(bdev_file);
+	__fput_sync(bdev_file);
 out_free_td:
 	kfree(td);
 	return ERR_PTR(r);
@@ -778,7 +778,13 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
 {
 	if (md->disk->slave_dir)
 		bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
-	fput(td->dm_dev.bdev_file);
+
+	/* Leverage async fput() if DMF_DEFERRED_REMOVE set */
+	if (unlikely(test_bit(DMF_DEFERRED_REMOVE, &md->flags)))
+		fput(td->dm_dev.bdev_file);
+	else
+		__fput_sync(td->dm_dev.bdev_file);
+
 	put_dax(td->dm_dev.dax_dev);
 	list_del(&td->list);
 	kfree(td);
-- 
2.40.0

