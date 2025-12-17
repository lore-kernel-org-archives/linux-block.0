Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12BA28AB0B
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949720; cv=none; b=TTCzsYtCpozfxaI4aopC7OuWBZCNedWQJix93t/LthpHTwFiyOWiNQRFcZjZ0SnkHUeylcO46ybLWePVjaI/K2Ewy6xtQ1ZMEkrvnentJWvUILebXby/R/7SdFeaF4dkhDKwbQfp9f4C6Tsp113pXk4lp4Er9rrm4P1tGxQPucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949720; c=relaxed/simple;
	bh=GHoPeIBMgfFtWJ8ncdyC6wl5P7hl0IaKfGFtCbYkhNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbPD4e+EDp3q8xnpr57GfRvJoXrNzli0xUVfGcEm07YnuwtYmQylRBegzAzWaMZdhi93ygYg5+4R1Touh59WpqfSL4EWIketDlXG8pAdBr1KWiTUIpJu1NGFV79C5vPvJwJ+cnwYwWuLfYJ0KGD7xPLk+zxcTzdktwVXPjDcDSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Z8THq8hs; arc=none smtp.client-ip=209.85.217.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Z8THq8hs"
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-5dfa7048c21so343396137.2
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 21:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949714; x=1766554514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3mOq9Y+rhC9S4U+IJUmG6OBz92i+diStuHtdFNS8Qs=;
        b=Z8THq8hs2puTbEwt2aaqEUl21ZZRJTpYdT607oKOeEnP5LyMHRmf7Rd1GgCYUQgp0W
         H5okYgYOUQkkmo//Tc0F3i81JOmhrWCtehdLX07tvhcu4VDdnYwDx416oERRt0xYFCuF
         5rfHmMw8sK3EID0bzVyr7sg7S+YhbKdyhyWhfMOq7sR2HFiHfjrA4w1LYq433+O4Hrt7
         0AA00qJ3ja65XrzfP+uYfjtbgx7EGwU8cQvnVLqUzag42Z0reufCybARHehC2bMJtCjH
         KKrWdMXH75sepahy7tPBkp8wCt9O5/0LJgzI08oD5uTJhxVNeKwWdjCBvEUQVrRHMSn8
         +AFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949714; x=1766554514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z3mOq9Y+rhC9S4U+IJUmG6OBz92i+diStuHtdFNS8Qs=;
        b=U2ZsO2sQaYqh6RgWjcEDXE1+Exsbz2krauML14AHCssbvvaiD3sK2KtI/5veFYWD48
         8tDmRxZCF7QexXDMwtLaARBlujKqX6ya7VdbLre7lTZTAzLRX5JGDg6wfN+ui1QuUW+u
         tz3lus72D73+IkemEVsF8Tope4UWZBSZK6KgqeuHLet9INrFf0niaWN3n6I0dLQahTh4
         /BMfCrbfsgZ+OcDeFdpVwFRS0UGsIyf0USf9ZummL+ieTxQaESr4I8uKJ+ydL+RUqBNH
         EMFzUSX4Iglc+Z4uAJfm0tESjq+JU+3c6uGfxXzQVMQg7maJONq30s2a8Id1vx5aQhrn
         gp7g==
X-Gm-Message-State: AOJu0Yxw+/KCyGFYEj81pcZ3S8Xj/7Doq5UviwiOLkdSluUjXHq6Z4Xf
	pZZuHeRS0LCRe/1wkxO6SkVIGr7dXOHT99eQ2lo43H7MeDI4kTHUP7ZLweWuB70CLYuK2M1ahPh
	GwSCFAlT0B0WWWqPj1ZQTYcHcxxcyvCG4dfYyfbDEJDrNyMLvC1cE
X-Gm-Gg: AY/fxX6QORdGT0n3j8tsbPq+RX2+/BtRvZ6Q+QKxF2SYDLgQ4G/8oQXfowdFEmB4rkc
	gyihE++zaqYr8fXfYXLifxiHCH9E3xV9xE7ZIbkkbH+/VEDuaE3RDmE2h6dZwfLLnUZRJljhMeR
	lRTgt2b103On6cx9UrcbZbujnmpMZL30pqzP9donnubPTRg7o1+inlkGwOncWhoJmsoHT18krKH
	UaD27IaS/qF70g8fF3DnlFxW/yOYeeBmbjer7gMJiTIUtezG43wte/oIc2/08zkhtBkADe8Cct7
	Sk3j0EuQ/xs83T44epj9QV+vMefJja02p9b+n0ZfecfpwYrfxS3Gf38BVKONlG/CEeqG8iKJV+l
	EcocrKjWyDT97hNGRdTazPoqRpY8=
X-Google-Smtp-Source: AGHT+IEdiu/wz3LFaYfCFvm/xPf9JRqbDWXdAzTEtw+g7b1hcvx8k1bBanbe2UHRij72QmFAixdEIBRJ1PFo
X-Received: by 2002:a67:c585:0:b0:5db:e851:9386 with SMTP id ada2fe7eead31-5e827470360mr3060384137.2.1765949713752;
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5e81e5a1d6bsm2447945137.1.2025.12.16.21.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7FF503404B4;
	Tue, 16 Dec 2025 22:35:12 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7C0C1E41A08; Tue, 16 Dec 2025 22:35:12 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 10/20] ublk: inline ublk_check_and_get_req() into ublk_user_copy()
Date: Tue, 16 Dec 2025 22:34:44 -0700
Message-ID: <20251217053455.281509-11-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251217053455.281509-1-csander@purestorage.com>
References: <20251217053455.281509-1-csander@purestorage.com>
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
---
 drivers/block/ublk_drv.c | 51 ++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 33 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e39ed8a0f0ae..273d580ddc46 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2612,70 +2612,55 @@ static inline bool ublk_check_ubuf_dir(const struct request *req,
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

