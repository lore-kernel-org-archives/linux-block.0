Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC93A264638
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949718; cv=none; b=TaTsdFmi7dZKv2jQTNFY9paSZ3q8HKn/3o4+ry4cYZmLwt0lNfiw0jj4lpKir7J3nfXucwUwVz4zaUNMsQicGtqwJDYG1gN8r0ed/qprtt+UX4U5tE79pnroWtFHRKybtLt3vfaUDhAQGOgkVRW4lnuP6yDKRjXWP9GThmRXTps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949718; c=relaxed/simple;
	bh=9ogkOXR+Y8uacI3HACJU9UwIkpxDQMrtkJbS21SD2to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+QAS+w3D21eqHN8EMfUWqUE7xF83CwOaSS64WTSRKhAqB/uwfI1qWkXg8tELjtEFnwf3wZfGQN2YmDgK4Zftjjzlhqc/K5/uvGYZ8i1b1J71XEp5EYyROtPjrxdN+Bbw5pacNPb/E8SsHJCvO0sTO4kvmYB++44woQIVwhNKDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=X9IKB0HT; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="X9IKB0HT"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-29f3018dfc3so9002815ad.0
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 21:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949713; x=1766554513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7u5SiWUWisiZXxTwmOVFVNPK/bGMmkGtOM56/HKpE6I=;
        b=X9IKB0HTSYwklfV72sIvrTmR4B2CqtOLnXtG8R2O5FpHPadljp1bm+uDHWkC6RSgwI
         8rCnt/YXXTjQrI743mRN8KGSZnknG2aUJWqF09O3hUNci/168Rn46JV5h2IDvoF85nwa
         hIaZBu6xCJ0dtjFUd6DsjGQM5Hz4OZa/4YVFZ92Hw2QKXSjz4FTBUpqxJ1I9H3KYhDjP
         nqCTmcrhBSHQMpgrT0LyLBU8PFmX0SQAdHS4VJQtV55Hxy2VAFFZwGLb3xu6LOc6qjJ6
         4AS0eNI7NqOL0S0+Jcx3zRUFlPLyUMed068vl2DRkP5gJaer1rOT9ZCaDwL570PvrjrD
         HZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949713; x=1766554513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7u5SiWUWisiZXxTwmOVFVNPK/bGMmkGtOM56/HKpE6I=;
        b=dGKLXRoISfe8ArTw7KPBOCXgzyhQF1eoXU6uNos2NB7hGAtzGwwYOt/uo9eYjvKo/p
         R6+c1CUyF3n8jKpAZg53sUzt5V0BIWL+v330TYpuqMvodJQWi8ozMXo5m6cmd/PNQwz6
         SdQHb5w/jqQwm5oD0kOnMCvibdTw2+VPT3BPoGpt61nYYQrncFTwFefcNqhSET/UYtqF
         onwI0BDthg7aamn8QaYwbDe/UW/StTieCPRUkLb65zIZNEnsgThOJh0U06GS3gXC1lVz
         KsbzeWsZpLrMnn4RERp0qmutqPHZVRLoNIblniI0pd4IPJr4hSFAPPrza88i7xZ6C7aG
         jzxA==
X-Gm-Message-State: AOJu0YyjNYN6DPMUH1nouAKXrBJdGqunfRA6BjXo+Yj4HqNx8L7WBAue
	LFBHYcsTkM+5eZ9C1aDIvdWUguSTlU4kjSxdlD1ov97JKpuH4hFlRyWvbZrM/Fl55ekqbTIAkNe
	mdXkZ7x2n345Sy69Z2o9Vx5ut9fOpNE8yXo5lWqvTQpiqR9tF965b
X-Gm-Gg: AY/fxX6XbT0zLX3wOoowkUBivd82gSokH8nZ9wqpMZMRzzZGObic34BK+Gce6V+ddJt
	1g2DM5pscHkLP0iuJsuhLoYROsHN6xayXmOXvEUPc53+4+fekVdYXVc4Ivsz+V+gJ08EjQNQo5k
	w6Zo/6Gy9W0Oc5VYJxMA/mHj/l0PwlRFXUKE+8lZxzwhoqz+q37HXhJ02MB8srGZWLuUDJuzqcO
	0VLg5FC2qM5IjBKguQvDJzyLWvkHjJ0YxETkQ3nkKBUabN3+ERKJ7LQirj4KzfKc3N2BWYvVy+l
	S49SiwrCSPXy+cq87JeAacu0SHM6Lci/VBEBRJ2dv6I+QH3pUzQiQGq3+Sbf+XRXhY7ue7knY7Q
	GuDNhEqpnwWw+WqcNxD5nI+bZGzM=
X-Google-Smtp-Source: AGHT+IEj41P1BUf7dMXgS7Hk43sGC2zUpFq8+vGee37eWRP/iFh7GVlQpIzMmAj5i5ENXIqxkVkgxN4N88rt
X-Received: by 2002:a17:902:ef4c:b0:295:745a:800a with SMTP id d9443c01a7336-29f23afa321mr119245915ad.2.1765949713116;
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a086eaceaesm18721215ad.5.2025.12.16.21.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A24773420E8;
	Tue, 16 Dec 2025 22:35:12 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 9FF0EE41A08; Tue, 16 Dec 2025 22:35:12 -0700 (MST)
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
Subject: [PATCH 11/20] ublk: move offset check out of __ublk_check_and_get_req()
Date: Tue, 16 Dec 2025 22:34:45 -0700
Message-ID: <20251217053455.281509-12-csander@purestorage.com>
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

__ublk_check_and_get_req() checks that the passed in offset is within
the data length of the specified ublk request. However, only user copy
(ublk_check_and_get_req()) supports accessing ublk request data at a
nonzero offset. Zero-copy buffer registration (ublk_register_io_buf())
always passes 0 for the offset, so the check is unnecessary. Move the
check from __ublk_check_and_get_req() to ublk_check_and_get_req().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 273d580ddc46..7fa0a9f0bfae 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -252,11 +252,11 @@ struct ublk_params_header {
 
 static void ublk_io_release(void *priv);
 static void ublk_stop_dev_unlocked(struct ublk_device *ub);
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
-		u16 q_id, u16 tag, struct ublk_io *io, size_t offset);
+		u16 q_id, u16 tag, struct ublk_io *io);
 static inline unsigned int ublk_req_build_flags(struct request *req);
 
 static inline struct ublksrv_io_desc *
 ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
 {
@@ -2245,11 +2245,11 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 	int ret;
 
 	if (!ublk_dev_support_zero_copy(ub))
 		return -EINVAL;
 
-	req = __ublk_check_and_get_req(ub, q_id, tag, io, 0);
+	req = __ublk_check_and_get_req(ub, q_id, tag, io);
 	if (!req)
 		return -EINVAL;
 
 	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
 				      issue_flags);
@@ -2539,11 +2539,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 			__func__, cmd_op, tag, ret, io ? io->flags : 0);
 	return ret;
 }
 
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
-		u16 q_id, u16 tag, struct ublk_io *io, size_t offset)
+		u16 q_id, u16 tag, struct ublk_io *io)
 {
 	struct request *req;
 
 	/*
 	 * can't use io->req in case of concurrent UBLK_IO_COMMIT_AND_FETCH_REQ,
@@ -2560,13 +2560,10 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		goto fail_put;
 
 	if (!ublk_rq_has_data(req))
 		goto fail_put;
 
-	if (offset > blk_rq_bytes(req))
-		goto fail_put;
-
 	return req;
 fail_put:
 	ublk_put_req_ref(io, req);
 	return NULL;
 }
@@ -2644,14 +2641,19 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 
 	if (tag >= ub->dev_info.queue_depth)
 		return -EINVAL;
 
 	io = &ubq->ios[tag];
-	req = __ublk_check_and_get_req(ub, q_id, tag, io, buf_off);
+	req = __ublk_check_and_get_req(ub, q_id, tag, io);
 	if (!req)
 		return -EINVAL;
 
+	if (buf_off > blk_rq_bytes(req)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (!ublk_check_ubuf_dir(req, dir)) {
 		ret = -EACCES;
 		goto out;
 	}
 
-- 
2.45.2

