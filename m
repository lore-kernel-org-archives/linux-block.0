Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B0C216E24
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 00:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661094; cv=none; b=o1x4ddc1XxZRAJ9iOh1nqN600vO+jsj1dyPwI1lxSj7rpata+3q4KBELIHh8NoycRhgTV4cMOEv1Wg2X0TFGgSuXgP4SCO2ITPINujiu/ZC/ldyMlbevgyXS75q5nQSmscbv0DEfDZ3RVIpzotS/an2guW+1OSDsz9foektT6Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661094; c=relaxed/simple;
	bh=jzyih9dafZ4XR2piw4ZWjyPqJoo0c71+VM6fgrf47l8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sv20VPwvQyWumPqACxnjvhxhUfW8YgRWI6HcGrFa/UpFvD3r46Q7NatUimeUpCYvU3njjq4RKj4V+iWaapULQ3GvbcE7sdDegcCbWKJT3YIAcaybxvTptmvhQJnmXGZpap0C2iCpVfKcAldkKGzYY5y4rf1rQNRvQlH6wu0iCrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gI1Z29pP; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gI1Z29pP"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a355c8b808so632795ad.3
        for <linux-block@vger.kernel.org>; Mon, 05 Jan 2026 16:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661089; x=1768265889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieqTxRr9zPk5de54duzCoKw16y8ifpstASg31G9cIt4=;
        b=gI1Z29pP4yAXZVJRn4QamN2Jy0wSyUYwFPSB1tS1W+rn5Puz5rbJGKEkx42meRq3bN
         JUqSUxqEocyePhUbXWGi+2L8GMF3SLTsoqxzdYmdZrVQPc6ZRFtqgd/GXu+VUcYrVvKM
         P5ntAUeiumiqZrznCOJ37C6TLaVPzcOYKf0HGflGWzQ3GnfZHiSFJK5zYpDDluuCTlqH
         jwGQBWd50yv3WzstUaYUthE/E2+UrVek+eh2zzNooo4hd3u32o+G0gBs8yqxV8PRJPnu
         SHDnm33/H5m7hwFZaytbYDHLyBg93tpIrUivECX+1C88MOXe/2fPa2me0MX4UNsCyjXy
         Hmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661089; x=1768265889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ieqTxRr9zPk5de54duzCoKw16y8ifpstASg31G9cIt4=;
        b=d78GakKNajjCz8054wFa39GuON6w0EiSEOgodg4BNB+z5fA++Y9jzdrGuzZ4lxD7Zw
         hMSgi4jFv8p44GIb0PrM4hEgCnMQGW4sj/EomGkGvpKjJf7+8TdrfRopAkfmp0JpWAxk
         YgWglvP1oXXT811iIlIATioRsaRxdxN49UDSgbJwP9Aegyjxl3n9797LzTDvDMYxmk1N
         JF6HziOUm2XUf5gI7c6qQFQ14ErDlMJDgKI4vjRvchnWGNrQHSIHCfCpiIT02tktxl6m
         TKpLJIDaH5xsgWpvKq/bFNhtN+jfqt0TdG4Ji2N3e1VQbF04aPi4jVwaYLZ4VX53C3HD
         X53Q==
X-Gm-Message-State: AOJu0YzUPKftcnnjom9eMgZyjF1YEhCcA7zBXqOEmcjOwLp1kmvh4kLx
	Hw8DA0eQBZuwOjMbRzhl4AH2KlunYYy05yg+wnD3hjnmY4v/1FFkrGooVAooKiPDZQSvPvNdyz9
	FPW4h0V63sW3sXNP+tFor5AxYVF20MvntwXlT
X-Gm-Gg: AY/fxX5n1oNU1BAyrpA0PBwAZnsokEqBdIKvbsbavXVvEHYqNJC90sNeli1z9R8LQFq
	vLdUvMf0P/LK8EV+Vhi/UIp641BXhGMGpASmRH4ytr2gVECSHgY2lhIxABKdWLuB9/7aJJ39n9e
	MiOKKdWcY0lL0tiEMOxqRaZUmVNGZW8AXqAip/b2HAbMI+Vu7nD7tKxrTHyMEZSEyuGK71YCB3O
	XZn6XOaRBL6nOg3Ys6jmFShXkrKMgXEuHhExX2CZ5UMzLPshu5fwF4atJuua0bm51VAUi2JFmSb
	WgbsHA/iqL0Nv2KOooOmMcXh0uD2Pz0zdXg56DQhSFNUPjsa0eeFSOBdiLCjtEAiYxHi7Uk/WFp
	ogsS/c3qgiyvKQlqqSLuw8fYRteFyIbL3X39K1oHlZg==
X-Google-Smtp-Source: AGHT+IGUUIlq0t3uefFMiXwBaG09hS89DAoxd/gq2atTHMJ0YrjcZZdAsObR5myPEQGUUl2SKt5hQt3PWz7w
X-Received: by 2002:a17:903:2f8a:b0:2a0:992c:1ddd with SMTP id d9443c01a7336-2a3e2e22affmr8386995ad.8.1767661089556;
        Mon, 05 Jan 2026 16:58:09 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3cc48e4sm850425ad.41.2026.01.05.16.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:09 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 202AC341D2E;
	Mon,  5 Jan 2026 17:58:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 11EC9E44554; Mon,  5 Jan 2026 17:58:09 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 07/19] ublk: inline ublk_check_and_get_req() into ublk_user_copy()
Date: Mon,  5 Jan 2026 17:57:39 -0700
Message-ID: <20260106005752.3784925-8-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260106005752.3784925-1-csander@purestorage.com>
References: <20260106005752.3784925-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_check_and_get_req() has a single callsite in ublk_user_copy(). It
takes a ton of arguments in order to pass local variables from
ublk_user_copy() to ublk_check_and_get_req() and vice versa. And more
are about to be added. Combine the functions to reduce the argument
passing noise.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 51 ++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 33 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c3832ed8cec1..abb668b460a8 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2650,70 +2650,55 @@ static inline bool ublk_check_ubuf_dir(const struct request *req,
 		return true;
 
 	return false;
 }
 
-static struct request *ublk_check_and_get_req(struct kiocb *iocb,
-		struct iov_iter *iter, size_t *off, int dir,
-		struct ublk_io **io)
+static ssize_t
+ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 {
 	struct ublk_device *ub = iocb->ki_filp->private_data;
 	struct ublk_queue *ubq;
 	struct request *req;
+	struct ublk_io *io;
 	size_t buf_off;
 	u16 tag, q_id;
+	ssize_t ret;
 
 	if (!user_backed_iter(iter))
-		return ERR_PTR(-EACCES);
+		return -EACCES;
 
 	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
-		return ERR_PTR(-EACCES);
+		return -EACCES;
 
 	tag = ublk_pos_to_tag(iocb->ki_pos);
 	q_id = ublk_pos_to_hwq(iocb->ki_pos);
 	buf_off = ublk_pos_to_buf_off(iocb->ki_pos);
 
 	if (q_id >= ub->dev_info.nr_hw_queues)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	ubq = ublk_get_queue(ub, q_id);
 	if (!ublk_dev_support_user_copy(ub))
-		return ERR_PTR(-EACCES);
+		return -EACCES;
 
 	if (tag >= ub->dev_info.queue_depth)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
-	*io = &ubq->ios[tag];
-	req = __ublk_check_and_get_req(ub, q_id, tag, *io, buf_off);
+	io = &ubq->ios[tag];
+	req = __ublk_check_and_get_req(ub, q_id, tag, io, buf_off);
 	if (!req)
-		return ERR_PTR(-EINVAL);
-
-	if (!ublk_check_ubuf_dir(req, dir))
-		goto fail;
-
-	*off = buf_off;
-	return req;
-fail:
-	ublk_put_req_ref(*io, req);
-	return ERR_PTR(-EACCES);
-}
-
-static ssize_t
-ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
-{
-	struct request *req;
-	struct ublk_io *io;
-	size_t buf_off;
-	size_t ret;
+		return -EINVAL;
 
-	req = ublk_check_and_get_req(iocb, iter, &buf_off, dir, &io);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
+	if (!ublk_check_ubuf_dir(req, dir)) {
+		ret = -EACCES;
+		goto out;
+	}
 
 	ret = ublk_copy_user_pages(req, buf_off, iter, dir);
-	ublk_put_req_ref(io, req);
 
+out:
+	ublk_put_req_ref(io, req);
 	return ret;
 }
 
 static ssize_t ublk_ch_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-- 
2.45.2

