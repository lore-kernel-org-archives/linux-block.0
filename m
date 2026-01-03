Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667AC23ABA9
	for <linux-block@vger.kernel.org>; Sat,  3 Jan 2026 00:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401142; cv=none; b=rw6v+OFifjbBQEe+27VKO99gJ36lBUuAB/KjrVwPYleULmo8Hd+Dn7e/CKgrDE85p09EPrHczI6n8I/9Kg49BKqlhXkbvNEmLs9QDL9xjuIRUIPt5DdIoPnzvJVOFYZjwMMsZF1biU/az0ESONin8yAxsHq+2RhoWZoRtL1FgjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401142; c=relaxed/simple;
	bh=0HIM3LZ+eBDph53NxGfd2/H3yZfJ10Jd7Xn1nlpLW+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQNdR0F5SqUW7U96JvihbjKwZfR0sJWNq1PNWR+4b7BBF6nDSma0R8xp/wH6Zn7pxtNsy2TjLkLkeMcEpP3hMlfOX4Uw8wAiddmMGOECPyNTUM9M4f7G4ZOo7E/PpDeC/n96VK5kG4nPjiMwq7XzWG0OcctOB4Y4P9AQTrw0Nds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IabHP/Tz; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IabHP/Tz"
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-646d51949f9so215907d50.1
        for <linux-block@vger.kernel.org>; Fri, 02 Jan 2026 16:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401134; x=1768005934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knbpXSf7kdrhZPbbGQ6+cIy0OZGxNBIyH+kDDZckExk=;
        b=IabHP/Tz46C1sY2A57CQJ08tC7X7Wzj+1r8uQq7Xhpc4gQnXiqmZuVH/7NzgrjITS0
         zWQybvNP+i8Rcd6vjPrkJu5FKDx9F4VXq2T//1d9t2DCiLtoGqHimGxmKAMF20jPpeTd
         xz3gz5MqAqt4gvNB/h+VZBGAQMMwTfxB5jpNRhQUFEKrryHm4LgE6RHz9XFDKyWI4sMd
         MGAt5CYX/weg2xROJM78iFJmXBknEokNZFIJS6wvlcmfHDKeLI6ce52o5neJdLnfGBnJ
         bU+LihtgSt0dqFYWKQcP30rOHCE3M/r7lioN245+dAlPHQFcOFj5rdYA38R8WoN7iaSN
         v5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401134; x=1768005934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=knbpXSf7kdrhZPbbGQ6+cIy0OZGxNBIyH+kDDZckExk=;
        b=teq1tZCPFprKkjrVBlntzVNtasKjOJr//aDROIcNySPdsqVBkejfNrSWfl9aelAWRU
         hLgwT4JxSKwAMxQePyLM4UURMMqOjgvDljOEeeqw/e1+YMLtj9Gt2rFeappy8KIdanS8
         3d6kGml54Qae4K2DFBWjuoJKcHLc+723ydB5qLqMlf5wBAnEcmAXGfgsmhnANMFcnhQr
         W4Nud92zrceL0Ie9ehIjpYhE+I8CIFuCMXFvgK6Vjmj+2wYEk4UOxZw/stKEzBecUr0K
         kqj+990cbCcl3k97U339MlRRM3sR2gczHxAgtlrz6JWY0Yikab8s1LbdGljjR7pQiZCa
         IT8Q==
X-Gm-Message-State: AOJu0YzegOIAWBrb/aEtWC70BMs/chJXzdFd0f5rHn8vsedT3k8JK11t
	XCgLFqTCrgrJ19WdQJUpgPmVnIXqS2odEMOv8iiHWw8Eq7EOYrSjN9y2l+Q769oFlNVaiu0CXcY
	JAd01CO81Iu3NJTH5rpVDapKHnCJJvg7e4JkCp1llIatyMf8pYq8h
X-Gm-Gg: AY/fxX5lE9KIQenMBEQ2Zf9n2bv6p5C50Nc0VBY96Mq5lnqx7nP5WCc5WFy0x5pVhm8
	oh+J8ocnwNrLzXWuWm14akIrquXnQgr5vhfGAxMCupLq9XZH58ZmkV3aVZgjMljepQJ5ODbEQDQ
	q1ZIjgz1SIC6MbkuL89QSoUGDkMIphUl7nKvd0Ghr6bp+dNoUiAQ9QErHKjAarIBuxb1v41k1yr
	r430NXP9YHiQJ9ZPF9kt42Izqp0p8COPEuiRxY6v8b0HC/am2kxF86TUtM8V5rP8m/22Cw9AYPG
	xv7hK5i8PJWNDxAcVMWt8t/WCPGhhltq6wSlsg3DAzOl9ZuTGr9MEuTLwOdvSj764k1YEI7zjHs
	NZvKA7dO+8UHDEnzLUuadyumpKug=
X-Google-Smtp-Source: AGHT+IFcHgQg2WiRh4ueJncqPz5X+iE4QwTyWzS9B4z5GXHsWhkWB3IHZcttSGLuqIt6AtP9FCgncVYgpwBp
X-Received: by 2002:a05:690e:158c:10b0:646:5127:ad64 with SMTP id 956f58d0204a3-6466a8e0f63mr23527968d50.8.1767401134561;
        Fri, 02 Jan 2026 16:45:34 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6466a8b1b1dsm2609242d50.2.2026.01.02.16.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:34 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 46CB3341FDC;
	Fri,  2 Jan 2026 17:45:33 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 442AEE4426F; Fri,  2 Jan 2026 17:45:33 -0700 (MST)
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
Subject: [PATCH v2 08/19] ublk: move offset check out of __ublk_check_and_get_req()
Date: Fri,  2 Jan 2026 17:45:18 -0700
Message-ID: <20260103004529.1582405-9-csander@purestorage.com>
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

__ublk_check_and_get_req() checks that the passed in offset is within
the data length of the specified ublk request. However, only user copy
(ublk_check_and_get_req()) supports accessing ublk request data at a
nonzero offset. Zero-copy buffer registration (ublk_register_io_buf())
always passes 0 for the offset, so the check is unnecessary. Move the
check from __ublk_check_and_get_req() to ublk_check_and_get_req().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a4f95a0f1223..3149d705cb9a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -253,11 +253,11 @@ struct ublk_params_header {
 
 static void ublk_io_release(void *priv);
 static void ublk_stop_dev_unlocked(struct ublk_device *ub);
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
-		u16 q_id, u16 tag, struct ublk_io *io, size_t offset);
+		u16 q_id, u16 tag, struct ublk_io *io);
 static inline unsigned int ublk_req_build_flags(struct request *req);
 
 static void ublk_partition_scan_work(struct work_struct *work)
 {
 	struct ublk_device *ub =
@@ -2315,11 +2315,11 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 	int ret;
 
 	if (!ublk_dev_support_zero_copy(ub))
 		return -EINVAL;
 
-	req = __ublk_check_and_get_req(ub, q_id, tag, io, 0);
+	req = __ublk_check_and_get_req(ub, q_id, tag, io);
 	if (!req)
 		return -EINVAL;
 
 	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
 				      issue_flags);
@@ -2609,11 +2609,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
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
@@ -2630,13 +2630,10 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
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
@@ -2714,14 +2711,19 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 
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

