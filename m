Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AB7429000
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255879; cv=none; b=AVJ5L9CUD+xHxoQ1os6TG1T1iocOzteEgZKMuoULM7dPFubTqJULkRfvLn9VCfZHMgxE/Js2012SXDANO6w1bJgceWc4pc2D/SDiZZXH8hik0DWLCnR0IiPrkHT/jHwmHSkygtEczaYAlaJ9kYSAZoN+mYwBc3wVBP7Suh2/6RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255879; c=relaxed/simple;
	bh=hl/U15MhMg0pR+grXTw1SCpkOMVEgduzvvmsFIIV0mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGRYxr6rDqW2R+yEMvWtYNNzf/CgOVuhPow+VY0IswWMvpyzooJTFLAe0nL3wd1oi3H7WRmeptoAt75u+G2PeYHdfpl6GGeBKzp0DVvP+gybd4rAq4O+f6vZc+rfNebaZ9MlpEIvot6pT29dAFoJGqWANktxKUxdZUTMxMNfzME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=qLlyIfh7; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="qLlyIfh7"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hQvPH30rxzlfsTm;
	Thu, 20 Aug 2026 19:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1787255870; x=1789847871; bh=q10t+
	rDE4LOTh1oUh0lvuC7SuuThwqX88u76tmnb7BU=; b=qLlyIfh7zpfnNsozBCqk+
	AkoV9O+c/QwS2c8fv2xi7131kgPn6y1HyvxvxN0T6hePNgM8El/ZhlsnRvcZKYMX
	a8fWh6xvA2h0L6HKMROjqrvCXjW6hG7Qeg6Tdv9IxsciJyL9zhWX0wg/ar835zKU
	0QkchnOlBubffZBt2201w6NH/zWn9+1QOFLVqaV6Cith7SXrNQv+aPcChZrHowjW
	TfSblTphCfIgkHIKTq6lIC+GxvR+tekbqYI3VXQSt9MxhBxhrDluYmZkpEyxN1kY
	QMM/gVhX0MalYwBQC+okjF2qoqUobidvUM/wwlSYd0/i7eSvSJzHtvN4s8xoMU2w
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tbPx9D92GGoN; Thu, 20 Aug 2026 19:57:50 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hQvP92sh0zlfsVF;
	Thu, 20 Aug 2026 19:57:49 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 06/13] loop: Protect all lo_backing_file accesses with lo->lo_mutex
Date: Thu, 20 Aug 2026 12:57:14 -0700
Message-ID: <48e8ddcc0f73cd6684e645b7ee06cc808ecdf694.1787255652.git.bvanassche@acm.org>
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

Protect all lo_backing_file accesses from the control path with
lo->lo_mutex. Use READ_ONCE() to read lo_backing_file from the data path.
Serialization of I/O path lo_backing_file reads and control path
lo_backing_file changes happens by freezing the request queue.

Remove lo_lock because it is no longer used.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 45 ++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index aa40a6ed7f35..c5f026520836 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -53,14 +53,13 @@ struct loop_device {
 	int		lo_flags;
 	char		lo_file_name[LO_NAME_SIZE];
=20
-	struct file	*lo_backing_file;
+	struct file	*lo_backing_file __guarded_by(&lo_mutex);
 	unsigned int	lo_min_dio_size;
 	unsigned int	lo_dio_mem_align;
 	struct block_device *lo_device;
=20
 	gfp_t		old_gfp_mask;
=20
-	spinlock_t		lo_lock;
 	int			lo_state;
 	spinlock_t              lo_work_lock;
 	struct workqueue_struct *workqueue;
@@ -261,7 +260,7 @@ static int lo_fallocate(struct loop_device *lo, struc=
t request *rq, loff_t pos,
 	 * We use fallocate to manipulate the space mappings used by the image
 	 * a.k.a. discard/zerorange.
 	 */
-	struct file *file =3D lo->lo_backing_file;
+	struct file *file =3D context_unsafe(READ_ONCE(lo->lo_backing_file));
 	int ret;
=20
 	mode |=3D FALLOC_FL_KEEP_SIZE;
@@ -285,7 +284,7 @@ static int lo_fallocate(struct loop_device *lo, struc=
t request *rq, loff_t pos,
=20
 static int lo_req_flush(struct loop_device *lo, struct request *rq)
 {
-	int ret =3D vfs_fsync(lo->lo_backing_file, 0);
+	int ret =3D vfs_fsync(context_unsafe(READ_ONCE(lo->lo_backing_file)), 0=
);
 	if (unlikely(ret && ret !=3D -EINVAL))
 		ret =3D -EIO;
=20
@@ -354,7 +353,7 @@ static int lo_rw_aio(struct loop_device *lo, struct l=
oop_cmd *cmd,
 	struct iov_iter iter;
 	struct req_iterator rq_iter;
 	struct request *rq =3D blk_mq_rq_from_pdu(cmd);
-	struct file *file =3D lo->lo_backing_file;
+	struct file *file =3D context_unsafe(READ_ONCE(lo->lo_backing_file));
 	unsigned int nr_bvec;
 	int ret;
=20
@@ -511,6 +510,19 @@ static inline bool is_loop_device(struct file *file)
 	return bdev && bdev->bd_disk->major =3D=3D LOOP_MAJOR;
 }
=20
+static struct file *loop_get_backing_file(struct loop_device *lo)
+	__must_hold(&lo->lo_mutex)
+{
+	if (lo->lo_state !=3D Lo_bound)
+		return NULL;
+	/*
+	 * Order wrt setting lo->lo_backing_file in
+	 * loop_configure().
+	 */
+	rmb();
+	return lo->lo_backing_file;
+}
+
 /* Returns 0 if and only if @file is not backed by loop device @bdev. */
 static int loop_validate_file(struct loop_device *lo, struct file *file,
 			      struct block_device *bdev)
@@ -532,11 +544,10 @@ static int loop_validate_file(struct loop_device *l=
o, struct file *file,
 			return -EBADF;
=20
 		l =3D f_bdev->bd_disk->private_data;
-		if (l->lo_state !=3D Lo_bound)
+		scoped_guard(mutex, &l->lo_mutex)
+			f =3D loop_get_backing_file(l);
+		if (!f)
 			return -EINVAL;
-		/* Order wrt setting lo->lo_backing_file in loop_configure(). */
-		rmb();
-		f =3D l->lo_backing_file;
 	}
 	return 0;
 }
@@ -693,10 +704,9 @@ static ssize_t loop_attr_backing_file_show(struct lo=
op_device *lo, char *buf)
 	ssize_t ret;
 	char *p =3D NULL;
=20
-	spin_lock_irq(&lo->lo_lock);
-	if (lo->lo_backing_file)
-		p =3D file_path(lo->lo_backing_file, buf, PAGE_SIZE - 1);
-	spin_unlock_irq(&lo->lo_lock);
+	scoped_guard(mutex, &lo->lo_mutex)
+		if (lo->lo_backing_file)
+			p =3D file_path(lo->lo_backing_file, buf, PAGE_SIZE - 1);
=20
 	if (IS_ERR_OR_NULL(p))
 		ret =3D PTR_ERR(p);
@@ -1174,10 +1184,10 @@ static void __loop_clr_fd(struct loop_device *lo)
 	gfp_t gfp =3D lo->old_gfp_mask;
 	int err;
=20
-	spin_lock_irq(&lo->lo_lock);
-	filp =3D lo->lo_backing_file;
-	lo->lo_backing_file =3D NULL;
-	spin_unlock_irq(&lo->lo_lock);
+	scoped_guard(mutex, &lo->lo_mutex) {
+		filp =3D lo->lo_backing_file;
+		lo->lo_backing_file =3D NULL;
+	}
=20
 	lo->lo_device =3D NULL;
 	lo->lo_offset =3D 0;
@@ -2134,7 +2144,6 @@ static int loop_add(int i)
 	lockdep_register_key(&lo->lo_mutex_key);
 	mutex_init_with_key(&lo->lo_mutex, &lo->lo_mutex_key);
 	lo->lo_number		=3D i;
-	spin_lock_init(&lo->lo_lock);
 	spin_lock_init(&lo->lo_work_lock);
 	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
 	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
