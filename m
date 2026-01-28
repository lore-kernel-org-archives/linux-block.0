Received: from mail-dl1-f98.google.com (mail-dl1-f98.google.com [74.125.82.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303DC227BB9
	for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769633810; cv=none; b=RyPqlz1riUx7cKnFvRzvhtVsIgVKM1c0l/iDuitPadM/Hn9bQRcCNp2ZSXgw0PGo0fbGN9+pdnVyS98cr54M2dqO9MzG9MuS1tlcrvNjUK5oKMSRAegi4RsgfC8chYWebq+HQxGr70dXQKQlnVHDO2poReTJwpszeBHMoTc858g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769633810; c=relaxed/simple;
	bh=j3IPvz1LpPuTKWahD0Q/UYmQVwi3IapKNfsYkzqoKDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aZ+lrqgIQO008JruokhcSx7xToBsndIKFqDL4wwjrzpmrIbNBvuXIU0wCJy5ESCTqm3XG9G+2SlD7cpFV90uSCMJ5GkxQANFqcDBhI7gaCExB6YjF1YVHFck7qxQG4HDyVFGFv0W/urbfiwczYGlsqvN5HimrW6ZbZsPlzmpsJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=arYxTewk; arc=none smtp.client-ip=74.125.82.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="arYxTewk"
Received: by mail-dl1-f98.google.com with SMTP id a92af1059eb24-1233e05c77bso29089c88.1
        for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 12:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769633807; x=1770238607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ldyXpbjF5YoL332qMySKAZqRWvja9CU9WDWDsQ99LX0=;
        b=arYxTewkxouFLSv11L9SbPjjMqcEXPqusZWAJNQP/cZUamZX//L2ZAJeKo7zQjy4iU
         I7CzXjN7tl0ahb6RUSMkjxHSUR3cBfko58QcojqfpUu/vanQDBQ5oo+1l/rAiFb5bEBB
         O5wBmtrjpvqBGletvHhQL5+Zp1QE4d6zBkofqMFRnOxGhZe2Zzg91vnH1RT3a+uUiiv0
         O3HE5MOuM3nvgFe22CBUKaQJ+Wt+ZXhxPjDvQmvxHBg2rqYWjlRzAG+1N6rlvYel19Cy
         3xcsH2HWzMNEURfWK80X8a+O1DOcCLOc4h0Ku5Y+624vLBxK1j9sYZhZa0nVfCFGFc6N
         kiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769633807; x=1770238607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldyXpbjF5YoL332qMySKAZqRWvja9CU9WDWDsQ99LX0=;
        b=U3qpWr+gkoWphKX8VAjAoqghYAzgEpddM1tJuuU1egBYnMBgEwkws250bbtvak6d9K
         nqu2Hre59vLh0rmt+8RjoUKSlBO94NJyWQXm2fqL53NVqAz75jTIHiEWwlAJjg/cjAvv
         XBnFUrq5YkJEaHHMRVDoGbPeWuJr0hvqAQcrkQCg9/c1H7G8KZv3qb/E6Nx4tC49mAzg
         LP83DwvGiNRoEQihbdZ0x5IN8zb+d2S71G0Gttdzt58QqxlmoPM8FbIC8Rs+iUT37aiQ
         g5Uz5CmS0N3UHruZsqcmG4l/3j8ljgEPdbZ/R34w8FJgrxaMQtLrlbEDLs7mWsOX8bcw
         6Y0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+Nj0fX5zhEmCKGzKOEpYRLcmBWCj4qMGOvxMRChmTcU/BNVWEPksaidUnYzox2opEYSf9XJ1wObWddA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDkGIFJ8LCOY7G5JBNaGsB690MiuKtLwOlywsecJX/sA6AZqt
	OiK8czn4X2iE+Kg45h2nsTN6ogxT+DLspzHV1ZHCLNqXkQvKFmyZSgkiIA4si9+1Z5ViQdslN6s
	SL7gYHB7OmH4b+1ITvUwntNyT8QYO+BR170rO
X-Gm-Gg: AZuq6aKxf+VkaslOeeVVvcR5B1IvhMA4FLnWRPIqMtjz5VUdLEiDy0B929Fwazyh0J3
	fidfIEpo87GqHtftUACbbxJgK5OHsHExVcbnErQm9RkxRw3v48wABoiz/RdFe+EUv4o3VjmllHD
	Lp2LzyH6oAHEm+fDZ3ctHOFPq7NS+vtGjFE0TPHExhCfF0OpxmbLTPHMRqqVgJLS7hjeOxP1y/E
	sqsNH2dC+IjtNASyqyQ0UxxJS23FRdkSLHwaDkG3NyoksrWuYQZmjy397Z9mbalINKElnZzA/1D
	NHH1NZzrKhD6hj8vAb0OZ7j0llxhjbMYyQrVAQ0HLb6iwJch5Ly1RP8htsy1MvdkueXpg27ZEll
	sKi2h//vmva3yoHS2u6mM7B/HxCeOhJUzBNlnTIPioA==
X-Received: by 2002:a05:7300:760b:b0:2b6:f613:74e6 with SMTP id 5a478bee46e88-2b7af673b6amr377307eec.4.1769633807141;
        Wed, 28 Jan 2026 12:56:47 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2b7a170c8fdsm282360eec.6.2026.01.28.12.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 12:56:47 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 1A751340361;
	Wed, 28 Jan 2026 13:56:46 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id ECC8BE41CCC; Wed, 28 Jan 2026 13:56:45 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: restore auto buf unregister refcount optimization
Date: Wed, 28 Jan 2026 13:56:34 -0700
Message-ID: <20260128205636.4003327-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1ceeedb59749 ("ublk: optimize UBLK_IO_UNREGISTER_IO_BUF on daemon
task") optimized ublk request buffer unregistration to use a non-atomic
reference count decrement when performed on the ublk_io's daemon task.
The optimization applied to auto buffer unregistration, which happens as
part of handling UBLK_IO_COMMIT_AND_FETCH_REQ on the daemon task.
However, commit b749965edda8 ("ublk: remove ublk_commit_and_fetch()")
reordered the ublk_sub_req_ref() for the completed request before the
io_buffer_unregister_bvec() call. As a result, task_registered_buffers
is already 0 when io_buffer_unregister_bvec() calls ublk_io_release()
and the non-atomic refcount optimization doesn't apply.
Move the io_buffer_unregister_bvec() call back to before
ublk_need_complete_req() to restore the reference counting optimization.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: b749965edda8 ("ublk: remove ublk_commit_and_fetch()")
---
 drivers/block/ublk_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 7981decd1cee..f864a0f2f572 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3243,15 +3243,15 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		if (ret)
 			goto out;
 		io->res = result;
 		req = ublk_fill_io_cmd(io, cmd);
 		ret = ublk_config_io_buf(ub, io, cmd, addr, &buf_idx);
+		if (buf_idx != UBLK_INVALID_BUF_IDX)
+			io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
 		compl = ublk_need_complete_req(ub, io);
 
 		/* can't touch 'ublk_io' any more */
-		if (buf_idx != UBLK_INVALID_BUF_IDX)
-			io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
 		if (req_op(req) == REQ_OP_ZONE_APPEND)
 			req->__sector = addr;
 		if (compl)
 			__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub), NULL);
 
-- 
2.45.2

