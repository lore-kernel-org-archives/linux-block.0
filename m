Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B820342A80F
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864018; cv=none; b=Mxox/EJKidse7jcoJTx+uCgAjFnXlHccgfE0gNZuT6FNKKMwNQTGoPJUOtxdBY0HEbVWXO0kMvOCwAmcT1ioYcegMnllpZXA3RfANzm1hVxQkFlWigcY4WjWhuYHWq5pKoQfltNJfKXkOkUeexQNbKSfFAWwpfQlThiKxKAx8PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864018; c=relaxed/simple;
	bh=qzsJurzlV9hUfDVcU9i4OUZ+UejCEkO4N42HNf4MzXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBqigN4hjnb1U0B6sm0Tter+Y+7LMbIvO6dhP/QpO3FaYXgdG49iK/vCCJu41MdmjI7Rn46H9cRA/zi82oxJsI11cyOx1+gwxQYGH52rOCBqUrlWgRco1f1e99VuGQMehHMgJvG8pg5JVoL8tNCzREEeOr2n8bfPF6AWaQ3AQMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gdedlbDm; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gdedlbDm"
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-64477ac6363so221357d50.1
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863997; x=1768468797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6L8O7VQPCwW+Dpp1xErYdb+ZqWEFO3CxWIIuwxx/go=;
        b=gdedlbDmLcnGcXRXTUXoeDKMeNhBU1TCRV+vaiEgEjD8Hrol+fzHIexiutYmEC3v+Z
         PrJSulAlOryNDCM/cKGdTcpfqGfG5GKrHklV1gaWN8WAe5Hd1LZp2vwpKccdJ2TX7N5k
         KEBe2MraMSZPxTozqBmcjrVNY7WAF8uqIDYOnOKHsFY4RVDoeuy0RjTzCgCy4MBwtw+q
         GDuy89KUYLhllfUo1fYjkS6oLPQjrW159iJaEl07C3KJrLsunty1X0Sii/kI9lR/pIdR
         bfN3ooeT5+DUMGn+zYXDZ6Q5LbSV9hYPwgx/lagNtJgoudECuITxjR7DYPDHYCSmu6Wt
         XSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863997; x=1768468797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w6L8O7VQPCwW+Dpp1xErYdb+ZqWEFO3CxWIIuwxx/go=;
        b=kyPXHPtnfPvLScvL5CVWCTMHJbFzFB6WezPjUEI2ldmorKThuNucp9wae6mI86UIvZ
         EfapPEyIkOgwx+Gw+PIFaytbjsgA+mMMfAcmPVvQvC0hb5UwcYRLVkW8CwsSPsSuhkm4
         c9IBkrWjvs861S1RiNuLfDnflT4DItLm5oPqCWdaAkfRtpn16LlOAQilYbqUg4PRGM7c
         TsIh1W7oa1LTUXBPwyHIgZMNjkgBxaJ9tQf3mBZmBafunUmhqqvx2zxtkAfQ9zCaUazx
         h0ey+NEgQelnxJZKvqcxDcuiXzCwhCEaq3APX6xhgy4t77UV3BuYbYgUI2RtH2H+lr82
         mPwg==
X-Gm-Message-State: AOJu0Yy6tMaCQR5BArIRHu1GE69ps6I3Rl6Hi3UWZMa6ovy0RkHzYss/
	VsPBAsbdHqnraS2/kEm/E05nauyT9dT2R/98l0V5aJTk1ZgqEHG0Nam0D9d2YvqdNIvTOrP8IAf
	Lz2vT5dQkkk4NMWGaIHvaZBgDEUwlK4HHAOeh
X-Gm-Gg: AY/fxX4/UoL/1vlQcZYTNF9dOLrDf1RZloGzAYeWncOIjZnQzTKS79hiX1fsZVKdOV9
	Id4ljcqmBM/eZUKpMwwrS5ZR8bQPukJ/pWwGfaQE+Va1Noxa285bZFwZrzeX6KrL6nvrt3G3eHb
	xvSBSi/JTt9fEgrsNoj43bwXTcyC3MqWGxYLVHlGVjRGG2VSY7ZBAwy9hRhiDWLcQnX8wJ0JbDR
	/W3K2DGRs6Aom2IqICd5c2Q8gKmJzBYv5AchD53nr2/BTLspB2BG7M5XH+QYli+Lwv3O/L0D8Td
	NV0MKPAYY9cNqZlgjRo+c3MauOwlFdMQh43x0Apf9ktw91ZddqSaMZF3tc+tuhL5yNagpDNtMZX
	Ipb63fEkEp9ur473PW8d3pMMkXF+uSKZM+5hoyL41Vw==
X-Google-Smtp-Source: AGHT+IGzstdvk99AUHsnHlUESoV5UXHeI/e7ommP+XsKGXPgaR0u1lkbQBwz8eafd13Iz7pLe/WMMqJtieFI
X-Received: by 2002:a05:690c:fc8:b0:78f:c09e:9ad5 with SMTP id 00721157ae682-790b57caf50mr52170977b3.7.1767863996888;
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-790aa563f37sm5687287b3.7.2026.01.08.01.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0A113342170;
	Thu,  8 Jan 2026 02:19:56 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 04E81E42F2C; Thu,  8 Jan 2026 02:19:56 -0700 (MST)
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
Subject: [PATCH v4 07/19] ublk: inline ublk_check_and_get_req() into ublk_user_copy()
Date: Thu,  8 Jan 2026 02:19:35 -0700
Message-ID: <20260108091948.1099139-8-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
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
index 225372cca404..e7697dc4a812 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2655,70 +2655,55 @@ static inline bool ublk_check_ubuf_dir(const struct request *req,
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

