Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED4A46EC6D
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838493; cv=none; b=OiezlM1DiSX1idzWdt57b+0v4745cAKCk3oRqwGVuHitkuKZqGJhTf0JIsQnQ303p9xnXoRctIYAc0+c5Q3nIbPlM5MJ2q9ewuJJnqkl0yx1OIFi9izsYK9y/hoNVeHwSfvaPv/2cEeljq7wDo/P6dV7L/zSTZ+0sT7CsT0mo0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838493; c=relaxed/simple;
	bh=SEflLOzL0lfGY+k+oJM8VDufIcUJjBUR3+9oikCWla4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ian6m3DV1V0skb4Oh0OufVjyf/JnsMeV8bdSUtR0Pm0oH49Snr2SENwZcIMOIuj/SSX++YJh3FJzhdwUN73BvxeQhVFWXcX3NIpAioK+F68NY37YaOGiyPgDv3dOVF52Tq5bAfWKkro+DxSN6FJSdj5KC/gNle+Fg/skMJZpyBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=K8n5m4dm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="K8n5m4dm"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so17709065e9.1
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 03:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1785838487; x=1786443287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zEbGOJa+VWUmYMgmNNATFxA3erx26Syz6kDMhAYS8wo=;
        b=K8n5m4dmm3SGreYwoXzDTWsPSOBuwPIk88zzxat9EcZjLoaIeVNRf3KFL4W5lD91aH
         zmuQnVzHAhFyDhQ/HSHHC/rOp4RrkxP0qqFt/iuoC0VMi6FbrjFRrrrIN15OEr+G0uw8
         Zl/xkgglQoG8ZWeG29vB+rR60ThFXnuZPDYl3V601DUBNprPqPLyoPSFFWeQSR78AqGW
         RJkEsBeDI0MtFxgxshX4+DR7bo+ETpoX/q2XjDBc4asrZTJo80rxNCDrVfanf37ofWgV
         I+FnkrsxnjR4BA0zlZ50KuG/wTjMgAfNGr8BL+wM4/Bx5BjuszCncYsB5NvhxXT5Y4rN
         LEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785838487; x=1786443287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zEbGOJa+VWUmYMgmNNATFxA3erx26Syz6kDMhAYS8wo=;
        b=lB0o6zQBTQYB4cGFsESk64jF3NgQlFNzc6cGebK2JczMboP+ePhKrhHdtf+e58IdrH
         KATlS3WF/SKrSwGYlsrLG9ZfG3YaVnNr2FFCGFEjKOfdRqxleUio80ln8sJHW+LCjC9L
         CgLE6r/ROAbyljVctsDHc6mXmHv2cFVW45uR3bXltGMgxAcoGT51CtlSOEr55xh1DMWu
         DfGS/6bGW6LbX7V1mXOZXXbyW6XSM0EofRI5umBdZqqmGPcrAzy+HPFAFYi+xZsxfBqW
         Cfd1XLwPzQlMs/m/G0zAtVD1n7AjCFmkTPkO4DUYk+W2VIrbeYlvpHIucbr0ikn1x/DI
         CVWg==
X-Forwarded-Encrypted: i=1; AHgh+RoFhj0IOy8HZDxfkkt70ZTJjcuxRq3SfeTQ+Mdvc8gIbPR2aesSeU4VIrtYqDekI9TEzCpa/jH3gtirVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPOp7X1SmIP/Gs91n5zusHZ0tG01MJydgt144lI4eeeJW0zFFS
	zBfPyCC4ryKK7QiF/ypyb8IPapEMLQ7Y5KgYmM2/vrbSj9Yh+jCZLmM5W1/wyWkTZQ==
X-Gm-Gg: AR+sD12PPLrpm8fa3CVJhM/FaoeiQRaBGnnp+yBaq640Tsydm/i3fc4ucHgiZsx3M5J
	+0RK27lik1+yQ2GznZmTeyUVprfAqUmWFypzV+QF7+vwlbgulCU1mUflSx6eWm8M6iDWNcF+AxA
	6rckhBAcjw6tkYhcQGMHEhK0LrChhdxTuvfjEx2CAwZEYsnfguGijxBM97S5yTdc/ttXz+5/iDG
	vz3jhckaSGU0wFbjhY5wiGRna0C+t3bKCJ4YooEItvivDYOPmVwOC4TJg2+uKF9XbFBkom+VSTY
	U0hU/YBSVO8wIAtZF7D0MhJT6/aueX5pCpr8DcAxu9vrNyLnJQ0/HDGZNfL0bfrKcJCR53oMquz
	vcTBWlFNrZ0f7DJF4A1/007h6CiySF0NUlZCtA6W9ncw1tymrzjh5FnWtYYRCO+jjEcJLKGhfPY
	gBv1VhQHf/+YxDfFynqoZT4UhJh8Gi2Yb1oy5KX8M4nkPVorNwD0iWRQ/M+/aGDw51XYQ6g9I8B
	cVyTI7DNP6iI42PejUX+frg9+KDQHVW
X-Received: by 2002:a05:600c:34c6:b0:493:a966:d5b5 with SMTP id 5b1f17b1804b1-4980c66b50emr347664965e9.2.1785838487020;
        Tue, 04 Aug 2026 03:14:47 -0700 (PDT)
Received: from horizon.localdomain ([216.128.28.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7bf4sm73248805e9.11.2026.08.04.03.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:14:46 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sean Rhodes <sean@starlabs.systems>,
	Evan Green <evgreen@chromium.org>,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 4/4] PM: hibernate: harden encrypted snapshot write path
Date: Tue,  4 Aug 2026 11:14:37 +0100
Message-ID: <996978852410335e8d08a43ee8c33f35cd19069c.1785838445.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785838445.git.sean@starlabs.systems>
References: <cover.1785838445.git.sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Encrypted uswsusp permits the snapshot device under lockdown only after
encryption is enabled, but userspace still writes the image through the
normal block path. Track the snapshot owner, encrypted bytes read, swap
extents and swap header offset so lockdown only permits writes that match
the active encrypted image.

Tighten the encrypted stream bookkeeping while here: frame the metadata
boundary only when a user key switch is in use, report userspace copy
failures as -EFAULT, and reset encryption state when the snapshot is
freed.

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 Documentation/power/userland-swsusp.rst |   7 +-
 block/fops.c                            |  55 +++-
 include/linux/suspend.h                 |  22 ++
 include/linux/swap.h                    |  16 ++
 include/uapi/linux/suspend_ioctls.h     |   2 +-
 kernel/power/power.h                    |   2 +
 kernel/power/snapenc.c                  | 344 ++++++++++++++----------
 kernel/power/swap.c                     |  98 +++++++
 kernel/power/user.c                     | 177 +++++++++++-
 kernel/power/user.h                     |  22 +-
 mm/swapfile.c                           |  32 +++
 11 files changed, 606 insertions(+), 171 deletions(-)

diff --git a/Documentation/power/userland-swsusp.rst b/Documentation/power/userland-swsusp.rst
index 777518ac591d..df8eca9e6e36 100644
--- a/Documentation/power/userland-swsusp.rst
+++ b/Documentation/power/userland-swsusp.rst
@@ -130,9 +130,10 @@ SNAPSHOT_SET_USER_KEY
 	Mixes additional user key material into the data portion of an encrypted
 	hibernate image. The ioctl argument points to struct uswsusp_user_key.
 	key_len must be between 8 and USWSUSP_USER_KEY_SIZE bytes, and reserved
-	must be zero. The kernel writes meta_size with the encrypted metadata
-	size that userspace may transfer before providing the user key during
-	resume.
+	must be zero. During hibernation the kernel writes meta_size with the
+	encrypted metadata size. During resume, userspace passes the saved
+	meta_size back so the kernel can switch keys at the metadata boundary
+	before the snapshot header has been decrypted.
 
 The device's read() operation can be used to transfer the snapshot image from
 the kernel.  It has the following limitations:
diff --git a/block/fops.c b/block/fops.c
index 15783a6180de..efeb485e91e6 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -723,43 +723,65 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct file *file = iocb->ki_filp;
 	struct inode *bd_inode = bdev_file_inode(file);
 	struct block_device *bdev = I_BDEV(bd_inode);
+	dev_t dev = bd_inode->i_rdev;
 	bool atomic = iocb->ki_flags & IOCB_ATOMIC;
 	loff_t size = bdev_nr_bytes(bdev);
+	enum hibernate_snapshot_write hibernate_write;
+	size_t hibernate_len = 0;
 	size_t shorted = 0;
+	ssize_t hibernate_written = 0;
 	ssize_t ret;
 
 	if (bdev_read_only(bdev))
 		return -EPERM;
 
-	if (IS_SWAPFILE(bd_inode) && !is_hibernate_resume_dev(bd_inode->i_rdev))
-		return -ETXTBSY;
+	if (IS_SWAPFILE(bd_inode) && !is_hibernate_resume_dev(dev)) {
+		if (!is_sync_kiocb(iocb) || !iocb_is_dsync(iocb) ||
+		    (iocb->ki_flags & IOCB_DIRECT))
+			return -ETXTBSY;
 
-	if (!iov_iter_count(from))
-		return 0;
+		hibernate_len = iov_iter_count(from);
+		hibernate_write = hibernate_snapshot_write_begin(dev, iocb->ki_pos, hibernate_len);
+		if (hibernate_write == HIBERNATE_SNAPSHOT_WRITE_NONE)
+			return -ETXTBSY;
+	} else {
+		hibernate_write = HIBERNATE_SNAPSHOT_WRITE_NONE;
+	}
 
-	if (iocb->ki_pos >= size)
-		return -ENOSPC;
+	if (!iov_iter_count(from)) {
+		ret = 0;
+		goto out_hibernate;
+	}
 
-	if ((iocb->ki_flags & (IOCB_NOWAIT | IOCB_DIRECT)) == IOCB_NOWAIT)
-		return -EOPNOTSUPP;
+	if (iocb->ki_pos >= size) {
+		ret = -ENOSPC;
+		goto out_hibernate;
+	}
+
+	if ((iocb->ki_flags & (IOCB_NOWAIT | IOCB_DIRECT)) == IOCB_NOWAIT) {
+		ret = -EOPNOTSUPP;
+		goto out_hibernate;
+	}
 
 	if (atomic) {
 		ret = generic_atomic_write_valid(iocb, from);
 		if (ret)
-			return ret;
+			goto out_hibernate;
 	}
 
 	size -= iocb->ki_pos;
 	if (iov_iter_count(from) > size) {
-		if (atomic)
-			return -EINVAL;
+		if (atomic) {
+			ret = -EINVAL;
+			goto out_hibernate;
+		}
 		shorted = iov_iter_count(from) - size;
 		iov_iter_truncate(from, size);
 	}
 
 	ret = file_update_time(file);
 	if (ret)
-		return ret;
+		goto out_hibernate;
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = blkdev_direct_write(iocb, from);
@@ -777,9 +799,16 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		inode_unlock_shared(bd_inode);
 	}
 
-	if (ret > 0)
+	if (ret > 0) {
+		hibernate_written = ret;
 		ret = generic_write_sync(iocb, ret);
+	}
 	iov_iter_reexpand(from, iov_iter_count(from) + shorted);
+
+out_hibernate:
+	if (hibernate_len)
+		hibernate_snapshot_write_end(hibernate_write, hibernate_len,
+					     hibernate_written);
 	return ret;
 }
 
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index b02876f1ae38..8308a6583756 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -426,10 +426,32 @@ static inline bool pm_hibernation_mode_is_suspend(void) { return false; }
 
 int arch_resume_nosmt(void);
 
+enum hibernate_snapshot_write {
+	HIBERNATE_SNAPSHOT_WRITE_NONE,
+	HIBERNATE_SNAPSHOT_WRITE_IMAGE,
+	HIBERNATE_SNAPSHOT_WRITE_HEADER,
+};
+
 #ifdef CONFIG_HIBERNATION_SNAPSHOT_DEV
 int is_hibernate_resume_dev(dev_t dev);
+enum hibernate_snapshot_write
+hibernate_snapshot_write_begin(dev_t dev, loff_t pos, size_t count);
+void hibernate_snapshot_write_end(enum hibernate_snapshot_write type,
+				  size_t reserved, ssize_t written);
 #else
 static inline int is_hibernate_resume_dev(dev_t dev) { return 0; }
+
+static inline enum hibernate_snapshot_write
+hibernate_snapshot_write_begin(dev_t dev, loff_t pos, size_t count)
+{
+	return HIBERNATE_SNAPSHOT_WRITE_NONE;
+}
+
+static inline void hibernate_snapshot_write_end(enum hibernate_snapshot_write type,
+						size_t reserved,
+						ssize_t written)
+{
+}
 #endif
 
 /* Hibernation and suspend events */
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 8f0f68e245ba..b36685d1f314 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -439,6 +439,9 @@ extern int find_hibernation_swap_type(dev_t device, sector_t offset);
 int find_first_swap(dev_t *device);
 extern unsigned int count_swap_pages(int, int);
 extern sector_t swapdev_block(int, pgoff_t);
+int swapdev_block_to_offset(int type, sector_t block, pgoff_t *offset);
+int swapdev_block_to_extent(int type, sector_t block, pgoff_t *offset,
+			    pgoff_t *nr_pages);
 extern int __swap_count(swp_entry_t entry);
 extern bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry);
 extern int swp_swapcount(swp_entry_t entry);
@@ -535,6 +538,19 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
 {
 	return -EINVAL;
 }
+
+static inline int swapdev_block_to_offset(int type, sector_t block,
+					  pgoff_t *offset)
+{
+	return -EINVAL;
+}
+
+static inline int swapdev_block_to_extent(int type, sector_t block,
+					  pgoff_t *offset,
+					  pgoff_t *nr_pages)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_SWAP */
 #ifdef CONFIG_MEMCG
 static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
diff --git a/include/uapi/linux/suspend_ioctls.h b/include/uapi/linux/suspend_ioctls.h
index 2615dbd03404..5e23bf936277 100644
--- a/include/uapi/linux/suspend_ioctls.h
+++ b/include/uapi/linux/suspend_ioctls.h
@@ -31,7 +31,7 @@ struct uswsusp_key_blob {
  * image.
  */
 struct uswsusp_user_key {
-	/* Kernel returns the metadata size. */
+	/* Kernel returns the metadata size; resume passes the saved value in. */
 	__u64 meta_size;
 	__u32 key_len;
 	__u32 reserved;
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 68ed191b905c..39ef04be283d 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -171,6 +171,8 @@ extern void hibernate_release(void);
 bool hibernation_snapshot_dev_available(void);
 
 extern sector_t alloc_swapdev_block(int swap);
+bool swsusp_swap_range_allocated(int swap, loff_t pos, size_t count);
+u64 swsusp_swap_map_bytes(u64 image_bytes);
 extern void free_all_swap_pages(int swap);
 extern int swsusp_swap_in_use(void);
 
diff --git a/kernel/power/snapenc.c b/kernel/power/snapenc.c
index e6b2fcad9807..cd29803ec6c5 100644
--- a/kernel/power/snapenc.c
+++ b/kernel/power/snapenc.c
@@ -5,6 +5,7 @@
 #include <crypto/aead.h>
 #include <crypto/gcm.h>
 #include <crypto/sha2.h>
+#include <crypto/utils.h>
 #include <linux/hex.h>
 #include <linux/mutex.h>
 #include <linux/random.h>
@@ -52,7 +53,7 @@ int snapshot_store_encryption_seed(const char *buf, size_t count)
 
 	mutex_lock(&snapshot_seed_mutex);
 	if (snapshot_seed_valid) {
-		ret = memcmp(snapshot_seed, seed, sizeof(seed)) ? -EPERM : 0;
+		ret = crypto_memneq(snapshot_seed, seed, sizeof(seed)) ? -EPERM : 0;
 		goto out;
 	}
 
@@ -266,6 +267,22 @@ static int snapshot_check_user_key_switch(struct snapshot_data *data)
 	return 0;
 }
 
+static loff_t snapshot_encrypted_byte_count(loff_t plain_size);
+
+static void snapshot_set_meta_size(struct snapshot_data *data, u64 meta_size)
+{
+	data->meta_size = meta_size;
+	data->crypt_meta_size = snapshot_encrypted_byte_count(meta_size);
+}
+
+static void snapshot_record_encrypted_read(struct snapshot_data *data,
+					   size_t count)
+{
+	spin_lock(&data->crypt_lock);
+	data->crypt_bytes_read += count;
+	spin_unlock(&data->crypt_lock);
+}
+
 /* Encrypt more data from the snapshot into the staging area. */
 static int snapshot_encrypt_refill(struct snapshot_data *data)
 {
@@ -277,7 +294,8 @@ static int snapshot_encrypt_refill(struct snapshot_data *data)
 	int res;
 
 	if (data->crypt_total == 0) {
-		data->meta_size = snapshot_get_meta_page_count() << PAGE_SHIFT;
+		snapshot_set_meta_size(data,
+				       snapshot_get_meta_page_count() << PAGE_SHIFT);
 	} else {
 		res = snapshot_check_user_key_switch(data);
 		if (res)
@@ -294,8 +312,8 @@ static int snapshot_encrypt_refill(struct snapshot_data *data)
 	for (pg_idx = 0; pg_idx < CHUNK_SIZE; pg_idx++) {
 		void *buf = data->crypt_pages[pg_idx];
 
-		/* Stop at the meta page boundary to potentially switch keys. */
-		if (total &&
+		/* Stop at the meta page boundary before switching keys. */
+		if (data->user_key_valid && total &&
 		    ((data->crypt_total + total) == data->meta_size))
 			break;
 
@@ -316,6 +334,9 @@ static int snapshot_encrypt_refill(struct snapshot_data *data)
 		total += PAGE_SIZE;
 	}
 
+	if (!total)
+		return 0;
+
 	sg_set_buf(&data->sg[1 + pg_idx], &data->auth_tag, SNAPSHOT_AUTH_TAG_SIZE);
 	aead_request_set_callback(req, 0, crypto_req_done, &wait);
 	/*
@@ -422,8 +443,12 @@ static int snapshot_decrypt_drain(struct snapshot_data *data)
 		total += PAGE_SIZE;
 	}
 
-	if (data->crypt_total == 0)
+	if (data->crypt_total == 0) {
 		data->meta_size = snapshot_get_meta_page_count() << PAGE_SHIFT;
+		if (data->user_key_valid)
+			data->crypt_meta_size =
+				snapshot_encrypted_byte_count(data->meta_size);
+	}
 
 	data->crypt_total += total;
 	res = snapshot_check_user_key_switch(data);
@@ -449,6 +474,8 @@ static ssize_t snapshot_read_next_encrypted(struct snapshot_data *data,
 		rc = snapshot_encrypt_refill(data);
 		if (rc < 0)
 			return rc;
+		if (!data->crypt_size)
+			return 0;
 	}
 
 	/* Return data pages if the offset is in that region. */
@@ -471,133 +498,130 @@ static ssize_t snapshot_read_next_encrypted(struct snapshot_data *data,
 static ssize_t snapshot_write_next_encrypted(struct snapshot_data *data,
 					     void **buf)
 {
+	size_t size_avail;
 	size_t tag_off;
 
 	/* Return data pages if the offset is in that region. */
 	if (data->crypt_offset < (PAGE_SIZE * CHUNK_SIZE)) {
 		size_t pg_idx = data->crypt_offset >> PAGE_SHIFT;
 		size_t pg_off = data->crypt_offset & (PAGE_SIZE - 1);
-		size_t size_avail = PAGE_SIZE;
-		*buf = data->crypt_pages[pg_idx] + pg_off;
 
-		/*
-		 * If this is the boundary where the meta pages end, then just
-		 * return enough for the auth tag.
-		 */
-		if (data->meta_size &&
-		    data->crypt_total < data->meta_size) {
-			u64 total_done =
-				data->crypt_total + data->crypt_offset;
-
-			if (total_done >= data->meta_size &&
-			    (total_done <
-			     (data->meta_size + SNAPSHOT_AUTH_TAG_SIZE))) {
-				size_avail = SNAPSHOT_AUTH_TAG_SIZE;
-			}
-		}
+		*buf = data->crypt_pages[pg_idx] + pg_off;
+		size_avail = PAGE_SIZE - pg_off;
+	} else {
+		/* Use offsets just beyond the size to return the tag. */
+		tag_off = data->crypt_offset - (PAGE_SIZE * CHUNK_SIZE);
+		if (tag_off > SNAPSHOT_AUTH_TAG_SIZE)
+			tag_off = SNAPSHOT_AUTH_TAG_SIZE;
 
-		return size_avail - pg_off;
+		*buf = data->auth_tag + tag_off;
+		size_avail = SNAPSHOT_AUTH_TAG_SIZE - tag_off;
 	}
 
-	/* Use offsets just beyond the size to return the tag. */
-	tag_off = data->crypt_offset - (PAGE_SIZE * CHUNK_SIZE);
-	if (tag_off > SNAPSHOT_AUTH_TAG_SIZE)
-		tag_off = SNAPSHOT_AUTH_TAG_SIZE;
+	if (data->crypt_meta_size &&
+	    data->crypt_stream_total < data->crypt_meta_size) {
+		u64 meta_avail = data->crypt_meta_size - data->crypt_stream_total;
 
-	*buf = data->auth_tag + tag_off;
-	return SNAPSHOT_AUTH_TAG_SIZE - tag_off;
+		size_avail = min_t(u64, size_avail, meta_avail);
+	}
+
+	return size_avail;
 }
 
 ssize_t snapshot_read_encrypted(struct snapshot_data *data,
 				char __user *buf, size_t count, loff_t *offp)
 {
-	ssize_t total = 0;
-
-	/* Loop getting buffers of varying sizes and copying to userspace. */
-	while (count) {
-		size_t copy_size;
-		size_t not_done;
-		void *src;
-		ssize_t src_size = snapshot_read_next_encrypted(data, &src);
-
-		if (src_size <= 0) {
-			if (total == 0)
-				return src_size;
-
-			break;
-		}
-
-		copy_size = min(count, (size_t)src_size);
-		not_done = copy_to_user(buf + total, src, copy_size);
-		copy_size -= not_done;
-		total += copy_size;
-		count -= copy_size;
-		data->crypt_offset += copy_size;
-		if (copy_size == 0) {
-			if (total == 0)
-				return -EFAULT;
-
-			break;
-		}
-	}
-
-	*offp += total;
-	return total;
+	size_t copy_size;
+	size_t not_done;
+	size_t pg_off;
+	void *src;
+	ssize_t src_size;
+
+	if (!count)
+		return 0;
+
+	pg_off = *offp & (PAGE_SIZE - 1);
+	count = min_t(size_t, count, PAGE_SIZE - pg_off);
+
+	src_size = snapshot_read_next_encrypted(data, &src);
+	if (src_size <= 0)
+		return src_size;
+
+	copy_size = min_t(size_t, count, src_size);
+	not_done = copy_to_user(buf, src, copy_size);
+	copy_size -= not_done;
+	if (!copy_size)
+		return -EFAULT;
+
+	data->crypt_offset += copy_size;
+	*offp += copy_size;
+	snapshot_record_encrypted_read(data, copy_size);
+	return copy_size;
 }
 
 ssize_t snapshot_write_encrypted(struct snapshot_data *data,
 				 const char __user *buf, size_t count,
 				 loff_t *offp)
 {
-	ssize_t total = 0;
+	size_t copy_size;
+	size_t not_done;
+	size_t pg_off;
+	void *dst;
+	ssize_t dst_size;
+	int rc;
 
-	/* Loop getting buffers of varying sizes and copying from. */
-	while (count) {
-		size_t copy_size;
-		size_t not_done;
-		void *dst;
-		ssize_t dst_size = snapshot_write_next_encrypted(data, &dst);
+	if (!count)
+		return 0;
 
-		if (dst_size <= 0) {
-			if (total == 0)
-				return dst_size;
+	pg_off = *offp & (PAGE_SIZE - 1);
+	count = min_t(size_t, count, PAGE_SIZE - pg_off);
 
-			break;
-		}
+	dst_size = snapshot_write_next_encrypted(data, &dst);
+	if (dst_size <= 0)
+		return dst_size;
 
-		copy_size = min(count, (size_t)dst_size);
-		not_done = copy_from_user(dst, buf + total, copy_size);
-		copy_size -= not_done;
-		total += copy_size;
-		count -= copy_size;
-		data->crypt_offset += copy_size;
-		if (copy_size == 0) {
-			if (total == 0)
-				return -EFAULT;
-
-			break;
-		}
+	copy_size = min_t(size_t, count, dst_size);
+	not_done = copy_from_user(dst, buf, copy_size);
+	copy_size -= not_done;
+	if (!copy_size)
+		return -EFAULT;
 
-		/*
-		 * Drain the encrypted buffer if it's full, or if we hit the end
-		 * of the meta pages and need a key change.
-		 */
-		if (data->crypt_offset >=
-		    (PAGE_SIZE * CHUNK_SIZE) + SNAPSHOT_AUTH_TAG_SIZE ||
-		    (data->meta_size &&
-		     data->crypt_total < data->meta_size &&
-		     data->crypt_total + data->crypt_offset ==
-		     data->meta_size + SNAPSHOT_AUTH_TAG_SIZE)) {
-			int rc;
-
-			rc = snapshot_decrypt_drain(data);
-			if (rc < 0)
-				return rc;
-		}
+	data->crypt_offset += copy_size;
+	data->crypt_stream_total += copy_size;
+	/*
+	 * Drain the encrypted buffer if it's full, or if we hit the end of the
+	 * encrypted metadata and need a key change before user data pages.
+	 */
+	if (data->crypt_offset >=
+	    (PAGE_SIZE * CHUNK_SIZE) + SNAPSHOT_AUTH_TAG_SIZE ||
+	    (data->crypt_meta_size &&
+	     data->crypt_stream_total == data->crypt_meta_size)) {
+		rc = snapshot_decrypt_drain(data);
+		if (rc < 0)
+			return rc;
 	}
 
-	*offp += total;
-	return total;
+	*offp += copy_size;
+	return copy_size;
+}
+
+static void snapshot_reset_encryption_state(struct snapshot_data *data)
+{
+	data->crypt_offset = 0;
+	data->crypt_size = 0;
+	data->crypt_total = 0;
+	data->crypt_stream_total = 0;
+	data->nonce_low = 0;
+	data->nonce_high = 0;
+	data->meta_size = 0;
+	data->crypt_meta_size = 0;
+	data->user_key_valid = false;
+	spin_lock(&data->crypt_lock);
+	data->crypt_bytes_read = 0;
+	data->crypt_swap_reserved = 0;
+	data->crypt_header_reserved = 0;
+	spin_unlock(&data->crypt_lock);
+	memset(data->auth_tag, 0, sizeof(data->auth_tag));
 }
 
 void snapshot_teardown_encryption(struct snapshot_data *data)
@@ -623,21 +647,20 @@ void snapshot_teardown_encryption(struct snapshot_data *data)
 
 	memzero_explicit(data->encryption_key, sizeof(data->encryption_key));
 	memzero_explicit(data->user_key, sizeof(data->user_key));
+	snapshot_reset_encryption_state(data);
 }
 
 static int snapshot_setup_encryption_common(struct snapshot_data *data)
 {
 	int i, rc;
 
-	data->crypt_total = 0;
-	data->crypt_offset = 0;
-	data->crypt_size = 0;
-	data->user_key_valid = false;
-	memset(data->crypt_pages, 0, sizeof(data->crypt_pages));
 	/* This only works once per hibernate. */
 	if (data->aead_tfm)
 		return -EINVAL;
 
+	snapshot_reset_encryption_state(data);
+	memset(data->crypt_pages, 0, sizeof(data->crypt_pages));
+
 	/* Set up the encryption transform */
 	data->aead_tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
 	if (IS_ERR(data->aead_tfm)) {
@@ -653,7 +676,7 @@ static int snapshot_setup_encryption_common(struct snapshot_data *data)
 
 	/* Allocate the staging area */
 	for (i = 0; i < CHUNK_SIZE; i++) {
-		data->crypt_pages[i] = (void *)__get_free_page(GFP_ATOMIC);
+		data->crypt_pages[i] = (void *)__get_free_page(GFP_KERNEL);
 		if (!data->crypt_pages[i])
 			goto setup_fail;
 	}
@@ -714,13 +737,15 @@ int snapshot_get_encryption_key(struct snapshot_data *data,
 
 	BUILD_BUG_ON(sizeof(wrapped) >
 		     sizeof(((struct uswsusp_key_blob *)0)->blob));
-	rc = copy_to_user(&key->blob, &wrapped, sizeof(wrapped));
-	if (rc)
+	if (copy_to_user(&key->blob, &wrapped, sizeof(wrapped))) {
+		rc = -EFAULT;
 		goto fail;
+	}
 
-	rc = copy_to_user(&key->nonce, &nonce, sizeof(nonce));
-	if (rc)
+	if (copy_to_user(&key->nonce, &nonce, sizeof(nonce))) {
+		rc = -EFAULT;
 		goto fail;
+	}
 
 	memzero_explicit(image_key, sizeof(image_key));
 	memzero_explicit(&wrapped, sizeof(wrapped));
@@ -801,47 +826,73 @@ static loff_t snapshot_encrypted_byte_count(loff_t plain_size)
 	return plain_size + (chunks * SNAPSHOT_AUTH_TAG_SIZE);
 }
 
-static loff_t snapshot_get_meta_data_size(void)
+static loff_t snapshot_encrypted_split_byte_count(loff_t raw_size,
+						  loff_t meta_plain_size)
 {
-	loff_t pages = snapshot_get_meta_page_count();
+	if (raw_size <= meta_plain_size)
+		return snapshot_encrypted_byte_count(raw_size);
 
-	return snapshot_encrypted_byte_count(pages << PAGE_SHIFT);
+	return snapshot_encrypted_byte_count(meta_plain_size) +
+		snapshot_encrypted_byte_count(raw_size - meta_plain_size);
 }
 
 int snapshot_set_user_key(struct snapshot_data *data,
 			  struct uswsusp_user_key __user *key)
 {
-	struct uswsusp_user_key user_key;
+	struct uswsusp_user_key user_key = {};
 	unsigned int key_len;
 	u64 size;
 	int rc;
 
-	/*
-	 * Return the metadata size, the number of bytes that can be fed in before
-	 * the user data key is needed at resume time.
-	 */
-	size = snapshot_get_meta_data_size();
-	rc = put_user(size, &key->meta_size);
-	if (rc)
-		return rc;
+	if (!snapshot_encryption_enabled(data))
+		return -EINVAL;
 
-	rc = copy_from_user(&user_key, key, sizeof(struct uswsusp_user_key));
-	if (rc)
-		return rc;
+	if (copy_from_user(&user_key, key, sizeof(struct uswsusp_user_key)))
+		return -EFAULT;
 
 	BUILD_BUG_ON(sizeof(data->user_key) < sizeof(user_key.key));
+	rc = -EINVAL;
 	if (user_key.reserved)
-		return -EINVAL;
+		goto out;
 	if (user_key.key_len > sizeof(data->user_key))
-		return -EINVAL;
+		goto out;
 	if (user_key.key_len < 8)
-		return -EINVAL;
+		goto out;
+
+	if (data->mode == O_RDONLY && !data->ready) {
+		rc = -ENODATA;
+		goto out;
+	}
+
+	/*
+	 * Return the metadata size, the number of bytes that can be fed in before
+	 * the user data key is needed at resume time.
+	 */
+	if (data->mode == O_WRONLY && !data->meta_size) {
+		if (user_key.meta_size < PAGE_SIZE + SNAPSHOT_AUTH_TAG_SIZE)
+			goto out;
+
+		data->crypt_meta_size = user_key.meta_size;
+		size = data->crypt_meta_size;
+	} else {
+		snapshot_set_meta_size(data,
+				       snapshot_get_meta_page_count() << PAGE_SHIFT);
+		size = data->crypt_meta_size;
+	}
+
+	rc = put_user(size, &key->meta_size);
+	if (rc)
+		goto out;
 
 	key_len = user_key.key_len;
 
 	/* Don't allow it if it's too late. */
-	if (data->crypt_total > data->meta_size)
-		return -EBUSY;
+	if ((data->meta_size && data->crypt_total > data->meta_size) ||
+	    (data->crypt_meta_size &&
+	     data->crypt_stream_total > data->crypt_meta_size)) {
+		rc = -EBUSY;
+		goto out;
+	}
 
 	memset(data->user_key, 0, sizeof(data->user_key));
 	memcpy(data->user_key, user_key.key, key_len);
@@ -849,19 +900,30 @@ int snapshot_set_user_key(struct snapshot_data *data,
 	/* Install the key if the user is just under the wire. */
 	rc = snapshot_check_user_key_switch(data);
 	if (rc)
-		return rc;
+		goto out;
 
-	return 0;
+	rc = 0;
+
+out:
+	memzero_explicit(&user_key, sizeof(user_key));
+	return rc;
 }
 
-loff_t snapshot_get_encrypted_image_size(loff_t raw_size)
+loff_t snapshot_get_encrypted_image_size(struct snapshot_data *data,
+					 loff_t raw_size)
 {
-	loff_t pages = raw_size >> PAGE_SHIFT;
-	loff_t meta_size;
+	loff_t meta_plain_size = data->meta_size;
+	loff_t split_size;
+
+	if (!meta_plain_size)
+		meta_plain_size = snapshot_get_meta_page_count() << PAGE_SHIFT;
+
+	split_size = snapshot_encrypted_split_byte_count(raw_size,
+							 meta_plain_size);
+	if (!data->user_key_valid)
+		return max(snapshot_encrypted_byte_count(raw_size), split_size);
 
-	pages -= snapshot_get_meta_page_count();
-	meta_size = snapshot_get_meta_data_size();
-	return snapshot_encrypted_byte_count(pages << PAGE_SHIFT) + meta_size;
+	return split_size;
 }
 
 int snapshot_finalize_decrypted_image(struct snapshot_data *data)
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index c626e9dc3c1c..3bdd58d5b62c 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -166,6 +166,104 @@ static int swsusp_extents_insert(unsigned long swap_offset)
 	return 0;
 }
 
+static bool swsusp_extents_contain_range(unsigned long swap_offset,
+					 unsigned long nr_pages)
+{
+	struct rb_node *node = swsusp_extents.rb_node;
+	struct swsusp_extent *ext;
+	unsigned long end;
+
+	if (!nr_pages)
+		return false;
+
+	end = swap_offset + nr_pages - 1;
+	if (end < swap_offset)
+		return false;
+
+	while (node) {
+		ext = rb_entry(node, struct swsusp_extent, node);
+		if (swap_offset < ext->start)
+			node = node->rb_left;
+		else if (swap_offset > ext->end)
+			node = node->rb_right;
+		else
+			goto found;
+	}
+
+	return false;
+
+found:
+	for (;;) {
+		if (swap_offset < ext->start)
+			return false;
+		if (end <= ext->end)
+			return true;
+		if (ext->end == (unsigned long)-1)
+			return false;
+
+		swap_offset = ext->end + 1;
+		node = rb_next(&ext->node);
+		if (!node)
+			return false;
+
+		ext = rb_entry(node, struct swsusp_extent, node);
+	}
+}
+
+bool swsusp_swap_range_allocated(int swap, loff_t pos, size_t count)
+{
+	u64 block;
+	u64 end;
+	u64 end_block;
+
+	if (swap < 0 || pos < 0 || !count)
+		return false;
+
+	end = (u64)pos + count - 1;
+	if (end < (u64)pos)
+		return false;
+
+	block = (u64)pos >> PAGE_SHIFT;
+	end_block = end >> PAGE_SHIFT;
+
+	for (;;) {
+		u64 remaining_pages = end_block - block + 1;
+		pgoff_t swap_offset;
+		pgoff_t mapped_pages;
+		sector_t page_block = block;
+		u64 pages;
+
+		if (!remaining_pages)
+			return false;
+		if ((u64)page_block != block)
+			return false;
+		if (swapdev_block_to_extent(swap, page_block, &swap_offset,
+					    &mapped_pages))
+			return false;
+		if (!mapped_pages)
+			return false;
+		pages = min_t(u64, mapped_pages, remaining_pages);
+		if ((u64)(unsigned long)pages != pages)
+			return false;
+		if (!swsusp_extents_contain_range(swap_offset, pages))
+			return false;
+		if (pages == remaining_pages)
+			return true;
+		block += pages;
+	}
+}
+
+u64 swsusp_swap_map_bytes(u64 image_bytes)
+{
+	u64 image_pages = DIV_ROUND_UP_ULL(image_bytes, PAGE_SIZE);
+	u64 map_pages = image_pages / MAP_PAGE_ENTRIES + 1;
+
+	if (map_pages > U64_MAX >> PAGE_SHIFT)
+		return U64_MAX;
+
+	return map_pages << PAGE_SHIFT;
+}
+
 sector_t alloc_swapdev_block(int swap)
 {
 	unsigned long offset;
diff --git a/kernel/power/user.c b/kernel/power/user.c
index d30aed4bc35f..57b8ce83a626 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -21,6 +21,8 @@
 #include <linux/console.h>
 #include <linux/cpu.h>
 #include <linux/freezer.h>
+#include <linux/pid.h>
+#include <linux/sched/signal.h>
 #include <linux/security.h>
 
 #include <linux/uaccess.h>
@@ -33,12 +35,136 @@ struct snapshot_data snapshot_state;
 
 int is_hibernate_resume_dev(dev_t dev)
 {
-	return hibernation_snapshot_dev_available() && snapshot_state.dev == dev;
+	return hibernation_available() && snapshot_state.dev == dev;
 }
 
-static bool snapshot_encryption_required(void)
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+static bool snapshot_encrypted_output_active(struct snapshot_data *data, dev_t dev)
 {
-	return security_locked_down(LOCKDOWN_HIBERNATION);
+	return data->encryption_required && data->mode == O_RDONLY &&
+		data->ready && data->dev == dev &&
+		data->owner_tgid == task_tgid(current) &&
+		snapshot_encryption_enabled(data);
+}
+
+static bool snapshot_header_write_range(struct snapshot_data *data,
+					loff_t pos, size_t count)
+{
+	loff_t header_offset = data->swap_header_offset;
+	loff_t offset;
+
+	if (pos < header_offset)
+		return false;
+
+	offset = pos - header_offset;
+	return offset < PAGE_SIZE && count <= PAGE_SIZE - offset;
+}
+
+static u64 snapshot_swap_write_budget(struct snapshot_data *data)
+{
+	u64 image_bytes = round_up(data->crypt_bytes_read, PAGE_SIZE);
+	u64 map_bytes = swsusp_swap_map_bytes(data->crypt_bytes_read);
+	u64 budget = image_bytes + map_bytes;
+
+	if (image_bytes < data->crypt_bytes_read || budget < image_bytes)
+		return U64_MAX;
+
+	return budget;
+}
+
+static void snapshot_reset_swap_write_reservation(struct snapshot_data *data)
+{
+	spin_lock(&data->crypt_lock);
+	data->crypt_swap_reserved = 0;
+	spin_unlock(&data->crypt_lock);
+}
+#endif
+
+enum hibernate_snapshot_write
+hibernate_snapshot_write_begin(dev_t dev, loff_t pos, size_t count)
+{
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+	struct snapshot_data *data = &snapshot_state;
+	enum hibernate_snapshot_write type = HIBERNATE_SNAPSHOT_WRITE_NONE;
+	bool image_range_allocated;
+	u64 swap_budget;
+
+	if (!count || !snapshot_encrypted_output_active(data, dev))
+		return HIBERNATE_SNAPSHOT_WRITE_NONE;
+
+	mutex_lock(&system_transition_mutex);
+
+	if (!snapshot_encrypted_output_active(data, dev))
+		goto unlock;
+
+	image_range_allocated = swsusp_swap_range_allocated(data->swap, pos, count);
+
+	spin_lock(&data->crypt_lock);
+	swap_budget = snapshot_swap_write_budget(data);
+	if (snapshot_header_write_range(data, pos, count) &&
+	    data->crypt_header_reserved <= PAGE_SIZE &&
+	    PAGE_SIZE - data->crypt_header_reserved >= count) {
+		data->crypt_header_reserved += count;
+		type = HIBERNATE_SNAPSHOT_WRITE_HEADER;
+	} else if (image_range_allocated &&
+		   swap_budget >= data->crypt_swap_reserved &&
+		   swap_budget - data->crypt_swap_reserved >= count) {
+		data->crypt_swap_reserved += count;
+		type = HIBERNATE_SNAPSHOT_WRITE_IMAGE;
+	}
+	spin_unlock(&data->crypt_lock);
+
+	if (type == HIBERNATE_SNAPSHOT_WRITE_NONE)
+		goto unlock;
+
+	return type;
+
+unlock:
+	mutex_unlock(&system_transition_mutex);
+	return HIBERNATE_SNAPSHOT_WRITE_NONE;
+#else
+	return HIBERNATE_SNAPSHOT_WRITE_NONE;
+#endif
+}
+
+void hibernate_snapshot_write_end(enum hibernate_snapshot_write type,
+				  size_t reserved, ssize_t written)
+{
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+	struct snapshot_data *data = &snapshot_state;
+	u64 *reserved_total;
+	size_t unused;
+
+	if (type == HIBERNATE_SNAPSHOT_WRITE_NONE)
+		return;
+	if (!reserved)
+		goto unlock;
+
+	if (type == HIBERNATE_SNAPSHOT_WRITE_HEADER)
+		unused = reserved;
+	else if (written <= 0)
+		unused = reserved;
+	else if (written < reserved)
+		unused = reserved - written;
+	else
+		goto unlock;
+
+	reserved_total = type == HIBERNATE_SNAPSHOT_WRITE_HEADER ?
+		&data->crypt_header_reserved : &data->crypt_swap_reserved;
+
+	spin_lock(&data->crypt_lock);
+	*reserved_total -= min_t(u64, *reserved_total, unused);
+	spin_unlock(&data->crypt_lock);
+
+unlock:
+	mutex_unlock(&system_transition_mutex);
+#endif
+}
+
+static bool snapshot_encryption_required(struct snapshot_data *data)
+{
+	data->encryption_required = security_locked_down(LOCKDOWN_HIBERNATION);
+	return data->encryption_required;
 }
 
 static int snapshot_open(struct inode *inode, struct file *filp)
@@ -66,6 +192,14 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	data = &snapshot_state;
 	filp->private_data = data;
 	memset(&data->handle, 0, sizeof(struct snapshot_handle));
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+	spin_lock_init(&data->crypt_lock);
+	data->crypt_bytes_read = 0;
+	data->crypt_swap_reserved = 0;
+	data->crypt_header_reserved = 0;
+	data->swap_header_offset = 0;
+	data->owner_tgid = NULL;
+#endif
 	if ((filp->f_flags & O_ACCMODE) == O_RDONLY) {
 		/* Hibernating.  The image device should be accessible. */
 		data->swap = pin_hibernation_swap_type(swsusp_resume_device, 0);
@@ -96,7 +230,11 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	data->ready = false;
 	data->platform_support = false;
 	data->dev = 0;
-	data->encryption_required = snapshot_encryption_required();
+	data->encryption_required = snapshot_encryption_required(data);
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+	if (!error)
+		data->owner_tgid = get_task_pid(current, PIDTYPE_TGID);
+#endif
 
  unlock:
 	unlock_system_sleep(sleep_flags);
@@ -114,6 +252,10 @@ static int snapshot_release(struct inode *inode, struct file *filp)
 	swsusp_free();
 	data = filp->private_data;
 	data->dev = 0;
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+	put_pid(data->owner_tgid);
+	data->owner_tgid = NULL;
+#endif
 	free_all_swap_pages(data->swap);
 	unpin_hibernation_swap_type(data->swap);
 	if (data->frozen) {
@@ -148,7 +290,8 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
 		res = -ENODATA;
 		goto unlock;
 	}
-	if (data->encryption_required && !snapshot_encryption_enabled(data)) {
+	if (snapshot_encryption_required(data) &&
+	    !snapshot_encryption_enabled(data)) {
 		res = -EPERM;
 		goto unlock;
 	}
@@ -194,7 +337,8 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 
 	data = filp->private_data;
 
-	if (data->encryption_required && !snapshot_encryption_enabled(data)) {
+	if (snapshot_encryption_required(data) &&
+	    !snapshot_encryption_enabled(data)) {
 		res = -EPERM;
 		goto unlock;
 	}
@@ -271,6 +415,9 @@ static int snapshot_set_swap_area(struct snapshot_data *data,
 	if (data->swap < 0)
 		return swdev ? -ENODEV : -EINVAL;
 	data->dev = swdev;
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+	data->swap_header_offset = (loff_t)offset << PAGE_SHIFT;
+#endif
 	return 0;
 }
 
@@ -337,7 +484,8 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			error = -EPERM;
 			break;
 		}
-		if (data->encryption_required && !snapshot_encryption_enabled(data)) {
+		if (snapshot_encryption_required(data) &&
+		    !snapshot_encryption_enabled(data)) {
 			error = -EPERM;
 			break;
 		}
@@ -351,7 +499,8 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		break;
 
 	case SNAPSHOT_ATOMIC_RESTORE:
-		if (data->encryption_required && !snapshot_encryption_enabled(data)) {
+		if (snapshot_encryption_required(data) &&
+		    !snapshot_encryption_enabled(data)) {
 			error = -EPERM;
 			break;
 		}
@@ -379,6 +528,7 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		swsusp_free();
 		memset(&data->handle, 0, sizeof(struct snapshot_handle));
 		data->ready = false;
+		snapshot_teardown_encryption(data);
 		/*
 		 * It is necessary to thaw kernel threads here, because
 		 * SNAPSHOT_CREATE_IMAGE may be invoked directly after
@@ -402,7 +552,7 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		size = snapshot_get_image_size();
 		size <<= PAGE_SHIFT;
 		if (snapshot_encryption_enabled(data))
-			size = snapshot_get_encrypted_image_size(size);
+			size = snapshot_get_encrypted_image_size(data, size);
 		error = put_user(size, (loff_t __user *)arg);
 		break;
 
@@ -432,6 +582,9 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			break;
 		}
 		free_all_swap_pages(data->swap);
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+		snapshot_reset_swap_write_reservation(data);
+#endif
 		break;
 
 	case SNAPSHOT_S2RAM:
@@ -439,7 +592,8 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			error = -EPERM;
 			break;
 		}
-		if (data->encryption_required && !snapshot_encryption_enabled(data)) {
+		if (snapshot_encryption_required(data) &&
+		    !snapshot_encryption_enabled(data)) {
 			error = -EPERM;
 			break;
 		}
@@ -456,7 +610,8 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		break;
 
 	case SNAPSHOT_POWER_OFF:
-		if (data->encryption_required && !snapshot_encryption_enabled(data)) {
+		if (snapshot_encryption_required(data) &&
+		    !snapshot_encryption_enabled(data)) {
 			error = -EPERM;
 			break;
 		}
diff --git a/kernel/power/user.h b/kernel/power/user.h
index 3c3498bdb752..4df2f9ae9ada 100644
--- a/kernel/power/user.h
+++ b/kernel/power/user.h
@@ -2,10 +2,13 @@
 
 #include <linux/crypto.h>
 #include <linux/scatterlist.h>
+#include <linux/spinlock.h>
 #include <linux/suspend_ioctls.h>
 #include <crypto/aead.h>
 #include <crypto/aes.h>
 
+struct pid;
+
 #define SNAPSHOT_ENCRYPTION_KEY_SIZE AES_KEYSIZE_128
 #define SNAPSHOT_AUTH_TAG_SIZE 16
 
@@ -32,12 +35,25 @@ struct snapshot_data {
 	size_t crypt_offset;
 	size_t crypt_size;
 	u64 crypt_total;
+	u64 crypt_stream_total;
 	u64 nonce_low;
 	u64 nonce_high;
 	u8 encryption_key[SNAPSHOT_ENCRYPTION_KEY_SIZE] __nonstring;
 	u8 user_key[USWSUSP_USER_KEY_SIZE] __nonstring;
 	bool user_key_valid;
 	u64 meta_size;
+	u64 crypt_meta_size;
+	/*
+	 * Protects crypt_bytes_read and the reservation counters below.
+	 * crypt_swap_reserved covers encrypted snapshot bytes and userspace
+	 * generated swap-map pages.
+	 */
+	spinlock_t crypt_lock;
+	u64 crypt_bytes_read;
+	u64 crypt_swap_reserved;
+	u64 crypt_header_reserved;
+	loff_t swap_header_offset;
+	struct pid *owner_tgid;
 #endif
 
 };
@@ -66,7 +82,8 @@ int snapshot_set_user_key(struct snapshot_data *data,
 
 int snapshot_store_encryption_seed(const char *buf, size_t count);
 
-loff_t snapshot_get_encrypted_image_size(loff_t raw_size);
+loff_t snapshot_get_encrypted_image_size(struct snapshot_data *data,
+					 loff_t raw_size);
 
 int snapshot_finalize_decrypted_image(struct snapshot_data *data);
 
@@ -115,7 +132,8 @@ static inline int snapshot_store_encryption_seed(const char *buf, size_t count)
 	return -ENOTTY;
 }
 
-static inline loff_t snapshot_get_encrypted_image_size(loff_t raw_size)
+static inline loff_t snapshot_get_encrypted_image_size(struct snapshot_data *data,
+						       loff_t raw_size)
 {
 	return raw_size;
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 78b49b0658ad..11df0c556f4e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2366,6 +2366,38 @@ sector_t swapdev_block(int type, pgoff_t offset)
 	return se->start_block + (offset - se->start_page);
 }
 
+int swapdev_block_to_extent(int type, sector_t block, pgoff_t *offset,
+			    pgoff_t *nr_pages)
+{
+	struct swap_info_struct *si = swap_type_to_info(type);
+	struct swap_extent *se;
+	struct rb_node *rb;
+
+	if (!si || !(si->flags & SWP_WRITEOK))
+		return -ENODEV;
+
+	for (rb = rb_first(&si->swap_extent_root); rb; rb = rb_next(rb)) {
+		se = rb_entry(rb, struct swap_extent, rb_node);
+		if (block >= se->start_block &&
+		    block - se->start_block < se->nr_pages) {
+			pgoff_t page = block - se->start_block;
+
+			*offset = se->start_page + page;
+			*nr_pages = se->nr_pages - page;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+int swapdev_block_to_offset(int type, sector_t block, pgoff_t *offset)
+{
+	pgoff_t nr_pages;
+
+	return swapdev_block_to_extent(type, block, offset, &nr_pages);
+}
+
 /*
  * Return either the total number of swap pages of given type, or the number
  * of free pages of that type (depending on @free)
