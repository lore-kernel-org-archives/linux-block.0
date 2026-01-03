Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF581230BCB
	for <linux-block@vger.kernel.org>; Sat,  3 Jan 2026 00:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401137; cv=none; b=Bsa8Cft+3OJyDUE4RuYyuzAHv53NNbNE/alfku3NjD/vJ99y+pTVoD4KJWmqMpbP6hDuakJIxhBs2JPZjkOKRFL6cGQm1a0IENZCUQgOyJJFgfjozroW4h+2BL5pvmadn+04wUNSocfGb875x7ga3dc5AE5DOR10gWXZTBS3JFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401137; c=relaxed/simple;
	bh=5miXCM+/LRoHoro59T+z+kk+Lnrwb+6jT45GlYIcY/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2tD0oWKrzam3A2QtHEdew/nUJxhrF9+ToKUnvx9XFVhGC6nnnKR6flxoV4x9Q7kGuHOKQRDGpYashtmRJYtq9uToYLxd4wAGQAG/EmtTVK3VNeHg9Ua4M+0vGIZN1l/TOlfbG95FSziI6jBiWqW9+1bMXOW5buaUyq78n+Cw7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cOgDs9t5; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cOgDs9t5"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a0abca9769so22701525ad.1
        for <linux-block@vger.kernel.org>; Fri, 02 Jan 2026 16:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401134; x=1768005934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1p1lVHFdfrJVwcqNN1Ki9cbLGf4AMYaFBS/YOLtQ7ow=;
        b=cOgDs9t515MUNFKkFh3u1OsUX6W22RI2o6cDtXm71uJnVDtd/dcwQKzCiE/qwwhd1q
         tal4757Yg9EJn3hqVZMSJeXvWp084F06CYyw+lePbATcb6LkgP++CZjuN3dfvg0NLjte
         V2o6tOeX6PCumaDBL/gb5CIi3JdpbhC1iGloTezxKmLlVseBmWoHQ2ROcYCVANEnvlqn
         SVvi+dewPEjZ26j7c0t4dIBZbHY327GOWFIh+MXgSpfCyOOJA4iJ04JOOassLkahWMaU
         OhboYg2yroTpWrlk8t1do0vo4EsNYjoeocPlArhG7tS3hl35OI7REKpqCoF0kTdBk+HQ
         4FTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401134; x=1768005934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1p1lVHFdfrJVwcqNN1Ki9cbLGf4AMYaFBS/YOLtQ7ow=;
        b=u/MByNBorCbDQON+AOSRY031isA67fFESrQmDNpo73mmhUPVlTQyG8S2tMBu+cvqMj
         f+nRXy93iPSke+zLKU4b+aV45FzJ+HsW10mywdiR4qJkvETsJRwBN0w87VyrshTm6nkc
         k/lCdg0d7epE2fch39OeTMws1CqsRPh4gOGXCSlXkQ+SwijxYCIlHdtxwzKoNiRCrYiq
         w5AB/eg3lvI0pERK1+dU8xSeOthf/yj8ZCdAExZRSlvLjx82yFPooIVlu9MD9tgS/Qtn
         v0bNiz3hbHnHyqu2Q2pGXg+G1Mm1B3V3UbydGwdcb/PmzsQ9lM3IFL6X1Zm3HyOSR4uZ
         g+pw==
X-Gm-Message-State: AOJu0YwzlMKN7MQ0G5VtBwTOSZDACHfti6ZdYNi1nJvtG/+v+ahTbHl8
	5Pw53bkoXyijj9L2iPeE6pqi4oozPkzjO03/n9VCrszZ1mmoJR4i+rkZNJ3bj/AfkaT0WraST85
	9c1hCJ5nr6iAfDDCgcL7mknSi27bOEGlInRrWQIIJjztQ+R1cEx/n
X-Gm-Gg: AY/fxX4A0UYiricynrIuBrMsThVorA1g+ux6mVUStLElD95vT6pursdJhdYEWh8hQzi
	ailgPH/MXv4PQDYKHCGl0rEAWpSymAYrpiOzru0Ay4GOvBkVwkhZePGpqKV27hRC3Gj1x8Et0OJ
	hqgG5pikvfRNs0786Qwd4/oy2cQAbATouW6bvY0AOXbN/y35ky//rvYaFgtg+ZEbGWSAZ9+dS64
	cuMD1ZViZ8p0eIzoaiLAl2ZQSi73yebGoCm3yEt0nO4nI+kzHifvi9xEIt+2m54PLlclfzKFDXl
	gnRJtVbvW2o9Gb/DohYmCKfvz5MfyVv36hXHMHfr/NDTPQjO89sBKwt5HBdYTR5ZJn3/YnoBdHr
	iPOhOjQz+0k5QzJIZz72aMMxtqHw=
X-Google-Smtp-Source: AGHT+IEwudaVuvqRly7l0IRDlqEmKMwk/cSbKTNqZ6zXG9WgrlcQ8cTYpnhco7okGJPfRp9k59cr+7f7Cz0/
X-Received: by 2002:a17:902:da4b:b0:2a0:d662:7283 with SMTP id d9443c01a7336-2a2f2216199mr286221655ad.3.1767401133671;
        Fri, 02 Jan 2026 16:45:33 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a2f3c64bd9sm8170985ad.7.2026.01.02.16.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 1AA0F341FB6;
	Fri,  2 Jan 2026 17:45:33 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 183DFE4426F; Fri,  2 Jan 2026 17:45:33 -0700 (MST)
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
Subject: [PATCH v2 07/19] ublk: inline ublk_check_and_get_req() into ublk_user_copy()
Date: Fri,  2 Jan 2026 17:45:17 -0700
Message-ID: <20260103004529.1582405-8-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260103004529.1582405-1-csander@purestorage.com>
References: <20260103004529.1582405-1-csander@purestorage.com>
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
index 73547ecf14cd..a4f95a0f1223 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2682,70 +2682,55 @@ static inline bool ublk_check_ubuf_dir(const struct request *req,
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

