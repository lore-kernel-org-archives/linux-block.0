Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6690129A7B
	for <linux-block@vger.kernel.org>; Tue,  9 Apr 2024 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674829; cv=none; b=aP2ONWUEQKg0JVRi6Gtlex+QsQDKsLPse1s9EwqyytiUlkSNm3DvrfzUX8bmwuDlDTwFuD48XRKVZ9m1zkpGHKn2q5sE7/bGwtlPOR+3Dz47SkdIGy+ypJu8TsCAVhG24cQ7HUUaB6k1YgejGBRNgg+Fr0w42cb/8CGKn5j2jWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674829; c=relaxed/simple;
	bh=BHsQuwEGSZL+RRBAxmIgrsdc/aQ3ywxYrrWIDCHvcTI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=o+f3xSbB+tNBwwOP2gaCw7YaNF4d0eSSsgGsTrjpZAP3ybQnzfdDmYndAzZWdnkldu3c8ZAqoRCNsxRih/G5HxtPzkU2FhqNeEgy4ggKMN1JjTXM27sQL426usghLM0P+9LcuDXms39eOlLQkO2OFVCysTqTYGP/htxycf78qho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dFuXjQ5j; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dFuXjQ5j"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e2ae3a3f66so11015495ad.0
        for <linux-block@vger.kernel.org>; Tue, 09 Apr 2024 08:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712674824; x=1713279624; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lbty9zbCPb02fwd9w4BTKiZpiMJ/peeE4Os3inFvK3k=;
        b=dFuXjQ5jHhz+6FBpNANLSJky5M7VNSEFWoDCMvlGCK1ytASONN4PErOgp+l9U2CHbR
         HYNA+J00jL48V5vilJtgKJI5VJXqzTQ9H/WclrrThGZAuq0kn7sbrntrml185e5RlGtQ
         A4VQEvkOW0dtmwPyxuMLI0mIuwgENUNM34kdwa7Yw0zK2ASXClMXwPulE9raAJfoXJiQ
         b8dNgmjo+1bNTtkcGZ7VB+Dk9cIvFCDwisi1PShL7l37PqBBXTq2OcidVdEWbQ9O0GmZ
         BW9aHFAEdfS+TopLpv4LG8ddyZc1oy9ZTobf5wkJvlUCKgbelJR7EmL7SfObmY2hSr3N
         C8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712674824; x=1713279624;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lbty9zbCPb02fwd9w4BTKiZpiMJ/peeE4Os3inFvK3k=;
        b=GnPHKZIAerg5Y2FvCNegaAXMWWkprE4pU4lArSf63fsqL6xnBGTRMDY+KzsNN+Y1qD
         ZQGMgp84Lw8drqLChmnX3sDsDd5aMaohrHlKjS7VeiGT2TovpA6RgXANfLRSbDgFpaZY
         WRHQSRiqUBZLe00xX4RBlp94Cev/9UNN4O+75y2TbA6/sBQyn8LK5ssALFVRiGiXLHJg
         R7H7ZUnQFVHcX6O/OEDGbVFZSPVFdLLYEodwMbM9iNpYGcKjSbrPCOo35HpQLsRPCkua
         LAd3nc1gXnQCyocDCO7rwPNC3widyrifq37r9FBzCxK3mcCMIvLJLaCm+NaeVYpwtG2r
         99Tw==
X-Gm-Message-State: AOJu0YxrMID3IwjpI4h2NP2LZg8acIk/aZ8iGcPJbvuZhNteH12Ii7l6
	Nxfn0hrXWmiuOxcF7UZnCmYzAK38nR5lyiDmBnbLgw1FZmT+8bUUTnAq3nbR50CUe/9FYlVTcAb
	Q
X-Google-Smtp-Source: AGHT+IGYAhD+ZezASuNvyo0qhS4GL/iGhtKoA2sIlHnb+QlMMMyixOhUnYhVKnzVjaZHTLPiocy+Vg==
X-Received: by 2002:a17:902:d503:b0:1e4:3321:2664 with SMTP id b3-20020a170902d50300b001e433212664mr5971786plg.3.1712674824208;
        Tue, 09 Apr 2024 08:00:24 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e5c900b001dd0d0d26a4sm9001753plf.147.2024.04.09.08.00.23
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 08:00:23 -0700 (PDT)
Message-ID: <dc58cf1e-cfbc-4771-80b8-4dfdf5d7f0d1@kernel.dk>
Date: Tue, 9 Apr 2024 09:00:22 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: convert the debugfs interface to read/write iterators
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert the block debugfs interface to use read/write iterators rather
than the older style ->read()/->write().

No intended functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

This is part of a larger series that intends to fully kill the old
read/write interface.

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 94668e72ab09..a9fa3d7311ac 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -119,9 +119,10 @@ static int queue_state_show(void *data, struct seq_file *m)
 	return 0;
 }
 
-static ssize_t queue_state_write(void *data, const char __user *buf,
-				 size_t count, loff_t *ppos)
+static ssize_t queue_state_write(void *data, struct kiocb *iocb,
+				 struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	struct request_queue *q = data;
 	char opbuf[16] = { }, *op;
 
@@ -137,7 +138,7 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
 		goto inval;
 	}
 
-	if (copy_from_user(opbuf, buf, count))
+	if (!copy_from_iter_full(opbuf, count, from))
 		return -EFAULT;
 	op = strstrip(opbuf);
 	if (strcmp(op, "run") == 0) {
@@ -540,12 +541,11 @@ static int blk_mq_debugfs_show(struct seq_file *m, void *v)
 	return attr->show(data, m);
 }
 
-static ssize_t blk_mq_debugfs_write(struct file *file, const char __user *buf,
-				    size_t count, loff_t *ppos)
+static ssize_t blk_mq_debugfs_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	const struct blk_mq_debugfs_attr *attr = m->private;
-	void *data = d_inode(file->f_path.dentry->d_parent)->i_private;
+	void *data = d_inode(iocb->ki_filp->f_path.dentry->d_parent)->i_private;
 
 	/*
 	 * Attributes that only implement .seq_ops are read-only and 'attr' is
@@ -554,7 +554,7 @@ static ssize_t blk_mq_debugfs_write(struct file *file, const char __user *buf,
 	if (attr == data || !attr->write)
 		return -EPERM;
 
-	return attr->write(data, buf, count, ppos);
+	return attr->write(data, iocb, from);
 }
 
 static int blk_mq_debugfs_open(struct inode *inode, struct file *file)
@@ -591,8 +591,8 @@ static int blk_mq_debugfs_release(struct inode *inode, struct file *file)
 
 static const struct file_operations blk_mq_debugfs_fops = {
 	.open		= blk_mq_debugfs_open,
-	.read		= seq_read,
-	.write		= blk_mq_debugfs_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= blk_mq_debugfs_write,
 	.llseek		= seq_lseek,
 	.release	= blk_mq_debugfs_release,
 };
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index 9c7d4b6117d4..22c65e5ff430 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -12,7 +12,7 @@ struct blk_mq_debugfs_attr {
 	const char *name;
 	umode_t mode;
 	int (*show)(void *, struct seq_file *);
-	ssize_t (*write)(void *, const char __user *, size_t, loff_t *);
+	ssize_t (*write)(void *, struct kiocb *, struct iov_iter *);
 	/* Set either .show or .seq_ops. */
 	const struct seq_operations *seq_ops;
 };

-- 
Jens Axboe

