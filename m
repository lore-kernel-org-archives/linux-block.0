Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376123451D6
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 07:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666344; cv=none; b=mhHxwk9UCbYMbKH5unQyLrv0Y8gt+600ktyh3W36FJaBiu49z8cvGknR9scb74Jn8n3LMAhC8Eckrpg3Vyrb4eyNg4XnjSUIpOJP6KcVi8i6GSgoUebPDofGH0eBCAqPZOkEoYd+YM3rg0qbKiLrgV/Edv5DH+HOLB2V3+X9kfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666344; c=relaxed/simple;
	bh=bnEXWvKJF57lCv/hfP6HgDOvGMB5vUts2zsKKU8VlVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REAeHfIuAHNvnvDad6cCjrz2w6PG3G6uxYvcQOS7ulYPR8aMD/s0sOke376CmuaAo5wXL+32Zcs7uZCWV5qX/ShWUQHxDzo7nqDoYLUIasLD9EWfROj2VfpXMIgT4EqTppELrBNeIx6Q7bh+YFrFDeSbK5uijtUbYzYwpt15bh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfvxpjST; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfvxpjST"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb796so538297266b.2
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 00:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790666341; x=1791271141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KF0t7lF1YQsUy6xMrljRa81d87fO5cJ7MZDzH2vsnqc=;
        b=mfvxpjSTsm6WeJ5NnxLqEiRKhonqueip8v7lJEM484MD/csm+uKEu8gyLpsvP6oh8T
         rvNZQrmZiAsKygcfuZu1gr6QMnNJjDlbMnd7Jq2kafxWXta2otOtc3bbfFk953oR0IeE
         4sM73I2eH2Nf7/foDOaNDZkXXapvHwN67+yJ7l+TmzczBPUvzedYto/5cfETQ/PpmmAl
         GvsDUEnUmBc6l8T8NY1O3RxBiYk6gdCqqLVIMk67EV4qo8MxS9MJ5Q2+Mh82c7JInESe
         odfWkynr34OOmZyeqMlFLW+i0yyBtU2EBpo1vZlhYNyu1qegBgbnNET1uN88IbcQe6w8
         J6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666341; x=1791271141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KF0t7lF1YQsUy6xMrljRa81d87fO5cJ7MZDzH2vsnqc=;
        b=dPxAjNcT1WYOmIAgZ+AWTz4edDTMX6t6S70Rp5Nq+/ViTGcEVVKIlQIrOGLxT+iOL0
         Fgu1j5gT4zqeU21bk2fsIihkVSnW6UKGG2rnaK0TC44VxEzhSTtutZPw5TfcOF7RFipt
         Uf1D5qAFfdRI5W8Q2Oe8ZLbWnC3tASYzxeMaBrgVRNcGb7aLYv5s0EzagIrrL5JtKa6s
         qXb2Tj6Fovcd5FtJJXh3BaIDoB7MamcScKZ4i8otzr5nBgr9CNreajupXK5/yHl40d+B
         oRFzpgGgRHV0eKTDXklxC86C2ew4xx/oI1l8YvOEph0TMBfzGGL+OtQ6oavJL6R9nbHy
         snww==
X-Forwarded-Encrypted: i=1; AKwUvBzwu8xlEuMyNs0BwQeKiG06u6uCfqEus8fAZdY+CvUB8avPBo/zaHggnpR7aV8DXPCGxshyj/BcMw9wYA==@vger.kernel.org
X-Gm-Message-State: AFuF++l0WtETnxo2rmGzKAinjSUrvnaY005epIHFZPaY4YXYoflx+tpT
	RvKeUH6UJDUeGVtMdyV4mcGeb777bUpWbHLRY8HBftLkZng/Jd4JpeWD
X-Gm-Gg: AYBFou0oqF4OD8iJdoqqKR+VJiIuz7EpGOkl7z6YRHSCY0tL6qwgkFCqG+efpKdTkY/
	2pldvDBKKdo/6KwH+RjOf9VjuP93wfmTFSS0KM4pP6vMtipMre8oRzliZDwFQv5h9AKTfOP1aEo
	j0yUu1vMP5exdwBx2A/0+7ZMkuE0lFh3Hbv4fFN9xWSbBgtJcy6pgGWb7f/WJWdhBofjb1NGjo1
	VCBV+qirbMKOWLKTV3jPvrA3U7H9cYWrAMOXkeBadXP0oyjGTQbTuHkFV/eIrV2kR8ZVR5ySv3b
	t2wdhOY8khNN8N37+i8s3gUL1lED0+pclbFWz+qL9CCmInwWcp90EMMUz02gxdCKpxwoi+O2YhA
	kGC01qd+Nu4cQQUugtdonoXiTaaEDqPV2RaIZ761QSyV2yo8c7v/A/kFBMv0moH6FjC5Gil9Saz
	etUlbcIXkjVEX2w73DhZ2cXFzBKbwIPVOvI5iI9rGN9bKPhFyBsiLLnr9QJ5emZ8zeVP9jLHW6G
	JyL4Yo4mGvSqyH2ruf2cGfNy4MlHte6wmwu9jBI7NJX3kD3JJ2G2ZLzVf128/D2OvFim1pcabAN
	lN2oG086u/xdhZPXIjV+Ew==
X-Received: by 2002:a17:907:e1c1:20b0:c2d:bd95:874a with SMTP id a640c23a62f3a-c2dbd958b3cmr403241966b.17.1790666341214;
        Tue, 29 Sep 2026 00:19:01 -0700 (PDT)
Received: from localhost.localdomain (84-216-182-59.customers.ownit.se. [84.216.182.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc6b7f2f4sm344709666b.10.2026.09.29.00.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 00:19:00 -0700 (PDT)
From: Pooyan Azad <pooyan.azadparvar@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] zram: fix short reads from block_state
Date: Tue, 29 Sep 2026 09:18:46 +0200
Message-ID: <20260929071846.24829-1-pooyan.azadparvar@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928164826.24858-1-pooyan.azadparvar@gmail.com>
References: <20260928164826.24858-1-pooyan.azadparvar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

read_block_state() formats each entry directly into the buffer supplied
by read(). If the remaining buffer is too small for one complete record,
snprintf() returns the full record length and the function stops without
copying data or advancing the file position. A read smaller than a record
therefore returns zero at a non-EOF position and cannot make progress.

Convert block_state to seq_file so formatted records are buffered
independently of the userspace read size. Keep dev_lock held across each
seq_file iteration and continue to protect individual entries with their
slot locks.

Fixes: c0265342bff4 ("zram: introduce zram memory tracking")
Closes: https://lore.kernel.org/r/CANC3H+LdtoydSp+o2ecErAw7k6R2+gRf9LyxcaoHv_mGhJmyQQ@mail.gmail.com/
Signed-off-by: Pooyan Azad <pooyan.azadparvar@gmail.com>
---
Changes in v2:
- Return the seq_file position from the iterator callbacks.
- Treat the iterator value as a pointer to the current offset.
- Avoid SEQ_SKIP for unallocated slots.
- Runtime-tested full and repeated one-byte reads under UML.

The one-byte reader is a boundary-case regression test. The same
zero-progress behavior occurs with any userspace buffer smaller than one
formatted block_state record.

Runtime testing was performed under UML with
CONFIG_ZRAM_MEMORY_TRACKING=y. A full read and repeated one-byte reads
produced matching output, and every short read advanced the file position.

 drivers/block/zram/zram_drv.c | 102 +++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 50 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a9b3bb1d3bef..6b39c22823f5 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1542,68 +1542,70 @@ static void zram_debugfs_destroy(void)
 	debugfs_remove_recursive(zram_debugfs_root);
 }
 
-static ssize_t read_block_state(struct file *file, char __user *buf,
-				size_t count, loff_t *ppos)
+static void *zram_block_state_start(struct seq_file *seq, loff_t *pos)
 {
-	char *kbuf;
-	unsigned long index;
-	ssize_t written = 0;
-	struct zram *zram = file->private_data;
+	struct zram *zram = seq->private;
 	unsigned long nr_pages;
 
-	kbuf = kvmalloc(count, GFP_KERNEL);
-	if (!kbuf)
-		return -ENOMEM;
-
-	guard(rwsem_read)(&zram->dev_lock);
-	if (!init_done(zram)) {
-		kvfree(kbuf);
-		return -EINVAL;
-	}
+	down_read(&zram->dev_lock);
+	if (!init_done(zram))
+		return ERR_PTR(-EINVAL);
 
 	nr_pages = zram->disksize >> PAGE_SHIFT;
+	if (*pos >= nr_pages)
+		return NULL;
 
-	for (index = *ppos; index < nr_pages; index++) {
-		int copied;
+	return pos;
+}
 
-		slot_lock(zram, index);
-		if (!slot_allocated(zram, index))
-			goto next;
+static void *zram_block_state_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct zram *zram = seq->private;
+	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
 
-		copied = snprintf(kbuf + written, count,
-			"%12lu %12u.%06d %c%c%c%c%c%c\n",
-			index, zram->table[index].attr.ac_time, 0,
-			test_slot_flag(zram, index, ZRAM_SAME) ? 's' : '.',
-			test_slot_flag(zram, index, ZRAM_WB) ? 'w' : '.',
-			test_slot_flag(zram, index, ZRAM_HUGE) ? 'h' : '.',
-			test_slot_flag(zram, index, ZRAM_IDLE) ? 'i' : '.',
-			get_slot_comp_priority(zram, index) ? 'r' : '.',
-			test_slot_flag(zram, index,
-				       ZRAM_INCOMPRESSIBLE) ? 'n' : '.');
-
-		if (count <= copied) {
-			slot_unlock(zram, index);
-			break;
-		}
-		written += copied;
-		count -= copied;
-next:
-		slot_unlock(zram, index);
-		*ppos += 1;
-	}
+	++*pos;
+	if (*pos >= nr_pages)
+		return NULL;
+
+	return pos;
+}
+
+static void zram_block_state_stop(struct seq_file *seq, void *v)
+{
+	struct zram *zram = seq->private;
 
-	if (copy_to_user(buf, kbuf, written))
-		written = -EFAULT;
-	kvfree(kbuf);
+	up_read(&zram->dev_lock);
+}
+
+static int zram_block_state_show(struct seq_file *seq, void *v)
+{
+	struct zram *zram = seq->private;
+	unsigned long index = *(loff_t *)v;
+
+	slot_lock(zram, index);
+	if (slot_allocated(zram, index)) {
+		seq_printf(seq, "%12lu %12u.%06d %c%c%c%c%c%c\n",
+			   index, zram->table[index].attr.ac_time, 0,
+			   test_slot_flag(zram, index, ZRAM_SAME) ? 's' : '.',
+			   test_slot_flag(zram, index, ZRAM_WB) ? 'w' : '.',
+			   test_slot_flag(zram, index, ZRAM_HUGE) ? 'h' : '.',
+			   test_slot_flag(zram, index, ZRAM_IDLE) ? 'i' : '.',
+			   get_slot_comp_priority(zram, index) ? 'r' : '.',
+			   test_slot_flag(zram, index,
+					  ZRAM_INCOMPRESSIBLE) ? 'n' : '.');
+	}
+	slot_unlock(zram, index);
 
-	return written;
+	return 0;
 }
 
-static const struct file_operations proc_zram_block_state_op = {
-	.open = simple_open,
-	.read = read_block_state,
-	.llseek = default_llseek,
+static const struct seq_operations zram_block_state_sops = {
+	.start = zram_block_state_start,
+	.next = zram_block_state_next,
+	.stop = zram_block_state_stop,
+	.show = zram_block_state_show,
 };
+DEFINE_SEQ_ATTRIBUTE(zram_block_state);
 
 static void zram_debugfs_register(struct zram *zram)
 {
@@ -1613,7 +1615,7 @@ static void zram_debugfs_register(struct zram *zram)
 	zram->debugfs_dir = debugfs_create_dir(zram->disk->disk_name,
 						zram_debugfs_root);
 	debugfs_create_file("block_state", 0400, zram->debugfs_dir,
-				zram, &proc_zram_block_state_op);
+				zram, &zram_block_state_fops);
 }
 
 static void zram_debugfs_unregister(struct zram *zram)
-- 
2.43.0
