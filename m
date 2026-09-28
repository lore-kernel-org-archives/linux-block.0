Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03BA4B95BF
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614168; cv=none; b=eP+WLYBPHB5rvjVHF0DRPoqY+SzFdsl1DlXiJwe5lFOAJS5ruJZoAzVNifkgC43sgvF2XnbkAkf5oOJAkVl898LNXFanrM5qPujm0MSVj6vm/6bljjdOo0QuxAf7DuLpDqbPDqpht1avK+62NE0GXKq+9TsHiTh4vmQ5bRu7zl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614168; c=relaxed/simple;
	bh=bp+qWhqWaR9Lz830v75yldw0X9URi4cGTw7lByuKNn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSyFWVuK21uyi0nNxQ8G4JkIkdEcvsNcpqbiOcnFt/ZNcAA09mUpT8lVYgow1wophtv3H/utZvSBKSxuKJ6f5i2WY/GN4FQ8R8ki4psN5XIlW41EguTw7ve3VH5cSW3cYhKE9na+eTXxFrh7vCGxmUmXkfv5oHSsFA9x0dOtVG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfKPSmhL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfKPSmhL"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6aaf28a86b9so72609a12.1
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790614165; x=1791218965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xejTefUm/OK3UUWyW9Ph3jbUHFaoxjGvqLJqChvouko=;
        b=HfKPSmhL1mSfI/omSQRd3bzq9EcoUjfM0sq964iCCu4bnn3RktFWcxWd9DP0ru0yhK
         kcXGxY1m7TX8z3oMnS/YdM5QSMC6OXuJj2EsZXIQtXo+SngOQ6lP5PT0EQwtAh3CLO6+
         7oMxOPqnvOG4dfb9JBUpJinWnuepar3GEH4EcRZdLyvqiCYpcnOGS90pvb+emSBO8dg/
         T8h5gxwQaWZWzQP2bSeW7sYkMML9BqQI15uwuZv18lQf5SQngSqP/WmGga9TsLe25Fm+
         0V8WvYZ+iGa7bmH7vtv0gSQCjYQW+vA4I725Kz4L6l/fSzBcJZ/CJ0kbMgVukTzR4W0V
         yk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790614165; x=1791218965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xejTefUm/OK3UUWyW9Ph3jbUHFaoxjGvqLJqChvouko=;
        b=NzUg52Vlwc3DWAhGpIWeZ0G31LvFHbMZ0yasqj+EYJV/0yTLY5t8+sGgGnnMDZ4Ct8
         xAlPAxvBENKV2c0+WzcvlNWKjt97oqz6yRZeCWs79PL1Fbi/Kqnf0RjBgIdW+xZFzWgY
         KeM18HPa7DQR3PxqkOWAVfHLEyLOHZLVNx9dkR48qMoD6Pn/ZGT4RDuWy2K4EBgaAIzL
         Sd1r6/gp3jOAnrnwwexUVHu9SlSGe45bzdBf6f42T00BP8vM5YxfBF1QAgGDkLdMxq1/
         aV9BcV/gKEFen3hZfnxin1eLq2GpsZHZ6Vjv3GzW8SrDkudKXVgON9bteBsGV1ddru5f
         zOyQ==
X-Forwarded-Encrypted: i=1; AKwUvBydWqzTTcIF0bWq/Xwcm/LYMi+FwBYuOV1r3zfPyU7vh2meLbWdBL0Co5WZvXimqzNvppLypZEokflKLg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKCabImBpwHI19K/K7+Osi4JGt/rRgXLW0XrmKmOCB4MAG4k6O9
	jOnUks9XTsGtmjRrbFMXa1IZ4oNcnSJZDGkCvPsBJ8aelsXXFlSv5yQS
X-Gm-Gg: AYBFou1gZYFEZcF006LNOELbZ+XDQdQ9pVspXjiZwwLP9HIJfHIpt5kQSCbgLkpNOS2
	XqJoLtaRGNvqAokwfR+AuYAUXcYiQ1+ewI+zYiSqBCm+YM4uPjxJFzNy25Daqu7v7BTSRN+QBM0
	KVKwZbDjz6k5tYY1E54RAuOX4QU1B5ofb24oUjfktirAzmnBDQuKkSRG7zRz/ZJeMgav792eAn+
	k9GfkTwZ7CD0t7WHpDEFSh+c51B9kWvjaOOz8JpLOpxz+POCNgVIXkQU6ihjZUhhDDP6SlT/71H
	CAMLPXztxs6xCkDU3WDklxGH8lSJke5LjjxkbriSmC1HTWyIRNDQyuMyQOqFPvK0D991rnroS3P
	j7F0tndZ+wHpkI3qZgoV8+DKY4AtvYAOT2IZqucGOz2BMHYFfYp8Ovjamwq6o+biMTfX9VElgzp
	isUMHpt5oNHJ49LGWwb9E9rZUwPkzKjtV+Gd7ht5XGxsae5EjmTVCqGrb+Yk9IIUNkfVrsNfXQk
	+9u6YwA/3uBKaVBvC3lhbvQrhxgbWU+RdsfdFEDickScYe7heOnMhBMH20Wpzgg9z0fGWjkPa7m
	xEHY4JNbPL4=
X-Received: by 2002:aa7:d1c8:0:b0:6aa:f83e:1da7 with SMTP id 4fb4d7f45d1cf-6aaf83e1fedmr5025670a12.0.1790614164665;
        Mon, 28 Sep 2026 09:49:24 -0700 (PDT)
Received: from localhost.localdomain (84-216-182-59.customers.ownit.se. [84.216.182.59])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ab5be57b13sm3066998a12.33.2026.09.28.09.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:49:24 -0700 (PDT)
From: Pooyan Azad <pooyan.azadparvar@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] zram: fix short reads from block_state
Date: Mon, 28 Sep 2026 18:48:26 +0200
Message-ID: <20260928164826.24858-1-pooyan.azadparvar@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANC3H+LdtoydSp+o2ecErAw7k6R2+gRf9LyxcaoHv_mGhJmyQQ@mail.gmail.com>
References: <CANC3H+LdtoydSp+o2ecErAw7k6R2+gRf9LyxcaoHv_mGhJmyQQ@mail.gmail.com>
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
Compile-tested with:

  make O=/tmp/zram-build W=1 -j$(nproc) \
       drivers/block/zram/zram_drv.o

No runtime testing of the patched kernel was performed.

 drivers/block/zram/zram_drv.c | 101 ++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 48 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a9b3bb1d3bef..66a2fdb1274b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1542,68 +1542,73 @@ static void zram_debugfs_destroy(void)
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
+	return &zram->table[*pos];
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
+	++*pos;
+	if (*pos >= nr_pages)
+		return NULL;
+
+	return &zram->table[*pos];
+}
+
+static void zram_block_state_stop(struct seq_file *seq, void *v)
+{
+	struct zram *zram = seq->private;
+
+	up_read(&zram->dev_lock);
+}
+
+static int zram_block_state_show(struct seq_file *seq, void *v)
+{
+	struct zram *zram = seq->private;
+	struct zram_table_entry *entry = v;
+	unsigned long index = entry - zram->table;
+
+	slot_lock(zram, index);
+	if (!slot_allocated(zram, index)) {
 		slot_unlock(zram, index);
-		*ppos += 1;
+		return SEQ_SKIP;
 	}
 
-	if (copy_to_user(buf, kbuf, written))
-		written = -EFAULT;
-	kvfree(kbuf);
+	seq_printf(seq, "%12lu %12u.%06d %c%c%c%c%c%c\n",
+		   index, zram->table[index].attr.ac_time, 0,
+		   test_slot_flag(zram, index, ZRAM_SAME) ? 's' : '.',
+		   test_slot_flag(zram, index, ZRAM_WB) ? 'w' : '.',
+		   test_slot_flag(zram, index, ZRAM_HUGE) ? 'h' : '.',
+		   test_slot_flag(zram, index, ZRAM_IDLE) ? 'i' : '.',
+		   get_slot_comp_priority(zram, index) ? 'r' : '.',
+		   test_slot_flag(zram, index, ZRAM_INCOMPRESSIBLE) ? 'n' : '.');
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
@@ -1613,7 +1618,7 @@ static void zram_debugfs_register(struct zram *zram)
 	zram->debugfs_dir = debugfs_create_dir(zram->disk->disk_name,
 						zram_debugfs_root);
 	debugfs_create_file("block_state", 0400, zram->debugfs_dir,
-				zram, &proc_zram_block_state_op);
+				zram, &zram_block_state_fops);
 }
 
 static void zram_debugfs_unregister(struct zram *zram)
-- 
2.43.0
