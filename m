Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5AB42A810
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864018; cv=none; b=DVqdBoTX/Gn1kmYC/3oVm3qgMHVVgvYVxzSpXja85xjtbg/ommF6fCeMqj/U521QzwsQLob6+kssP+kKWtn+qmZYEdrhj0gtp8weSh8jOwJHl97kmnVZd8k4P98tiyyC4Ezv31RTzpteeM9dEh5e6OGgnNyUWXoXUYCnOcw8GDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864018; c=relaxed/simple;
	bh=FpSk9SBO7a8fTola1zwsU8+516cI+0H9/8WbLKjGV0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvytWLqkoSt5RBps7Y1ppgTC+3nninvIpRzL0IUGAdynEn09LV63MNISg2EDL5kR0cGmc66Qh+WG/xPrOWuHpBt1DA5Sa06eL0+eTOC/yrSrygTir6Gz4QCNjTz9Pt1Fxg2+A3eJuhfB5rQTRzNlk0yQuqYWtayehDnLEIjT9JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fdnVn3xO; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fdnVn3xO"
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7c78003b948so362715a34.1
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863998; x=1768468798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdwpGAzUowZ3h68lzOUG2hhVHWdUBrDTU/ZZOy1LyBQ=;
        b=fdnVn3xOzniOFrhulHPWBCbcV61TrJZr+RzhgBc8HuMpRWwcadBsxxCk6hmIbR0JF+
         INKXdlqqbp6MTQKCKuQ3YTeBLBtrgH8wrkrNalFS76Zqq+bmZYvnr/rIYGviPfTijAix
         kbK6oELQp/Kn7w33QwWuyqAMAB0HvCGY/0yEElSoKdQqOqmDBRLt06IAg2shcPzLIyYB
         hzk8beGcLPwnURPiR2Ec6ADvnT20H4n10k+L6L/Lwa0e7r4XYXQ248w+VaLTtS1X1Dy6
         w1f/rV5YyY354ft4wQz69spaGGJHKonLTv3FN3lsX5BVNKhtT8YqBHqmhqqpsBiuKual
         x3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863998; x=1768468798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zdwpGAzUowZ3h68lzOUG2hhVHWdUBrDTU/ZZOy1LyBQ=;
        b=JIutlThgDvbxDMp6jV3+Ttl55YELVX1X4UUOi0UY7lL88ZLRqbu8rwSoPq2ngaLOl4
         Cg0Csrzt4qXtf/Xz0fjx+CgDDLZz2n/tLlykgjo3XKykFV5H3C1uEp0bNjALvyxhhET6
         kQDIXu2WEsZS89Jm6GdTQ8lFbYsyshusCRSptdua/YgMdvP6dg6JUkXLu5zHIraQodXH
         OOn1R4DBc5pPZrj2pWprbnAwa2/2XMIawRo0DR84NHSrhJnRYKX3jEGQN4/xlJAiWp8e
         JuJTb9KkxXYPx8IVxIqFeqIUVhVaFPl2tAfbBdzz0Usoe31jbSsweovSjrWf/8mcyWwP
         5btw==
X-Gm-Message-State: AOJu0YxkOsNcXDCR8/d4gF/wbgMCuF98Eh5f5uWEzVX7c8bOnO+1RA92
	4shuoLAIGPoFuey6f2pt75gZ/sBpkE0tl1BbgWUFPJPz46DpVuTjDNUEBGUDoMX2eFcXO90tZFI
	cyu9k0tki4es3GH3vs1bvoSEaoQE1b04RMOBQ
X-Gm-Gg: AY/fxX4eL9GDU0WzG5Pc3buCuA5m0YA6MpWm/VttLG3GNkB7DxnjDUGDW9sQPe0IStk
	5g6BuGwCQfDIN8x0AJpzfTzWuHbqfxJjQ9D6lj0RL2YImknSIqE9H+BZR3ZQVg6h6xmF8dETLjo
	2KjMnU6PAxBJK0ONFaKEi7hkncEzk+/EBqXEduyOAg6uIgbkBp6dQo1J9stmIXgxxEZEl47ttF9
	N9vN+TKrgHcX0sVhjua8zrArfdj7wA65jq7gkC/DlxMwpeRppZg+WGPGP7smq8q94WCcJuePWZP
	cC+AiCNbzTgxL0SJzQOG1MbyV+WU4/apgsMGHm+/dl8lKSQl9j6P4pIv2a24k2AdAvZ9dCDgtI9
	7RjiN/zGaj2Qyu+idVpNanmIb1gAz0zRJ0W9Tqew8Cg==
X-Google-Smtp-Source: AGHT+IGUm/Iy1iheWFfw5eo3T3n1C7/QfcUR6biu7iVn+XpWzIDZiQTmzwOni9Bte3nRtpcuFZadeg9tZXhd
X-Received: by 2002:a05:6870:32ce:b0:3ec:4e27:1f21 with SMTP id 586e51a60fabf-3ffc0c3c800mr2191144fac.8.1767863998371;
        Thu, 08 Jan 2026 01:19:58 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3ffa508e961sm818826fac.14.2026.01.08.01.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:58 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 536BC3400F7;
	Thu,  8 Jan 2026 02:19:57 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 4E6DFE42F2C; Thu,  8 Jan 2026 02:19:57 -0700 (MST)
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
Subject: [PATCH v4 16/19] selftests: ublk: support non-O_DIRECT backing files
Date: Thu,  8 Jan 2026 02:19:44 -0700
Message-ID: <20260108091948.1099139-17-csander@purestorage.com>
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

A subsequent commit will add support for using a backing file to store
integrity data. Since integrity data is accessed in intervals of
metadata_size, which may be much smaller than a logical block on the
backing device, direct I/O cannot be used. Add an argument to
backing_file_tgt_init() to specify the number of files to open for
direct I/O. The remaining files will use buffered I/O. For now, continue
to request direct I/O for all the files.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/common.c      | 4 ++--
 tools/testing/selftests/ublk/file_backed.c | 2 +-
 tools/testing/selftests/ublk/kublk.h       | 2 +-
 tools/testing/selftests/ublk/stripe.c      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ublk/common.c b/tools/testing/selftests/ublk/common.c
index 01580a6f8519..d9873d4d50d0 100644
--- a/tools/testing/selftests/ublk/common.c
+++ b/tools/testing/selftests/ublk/common.c
@@ -10,11 +10,11 @@ void backing_file_tgt_deinit(struct ublk_dev *dev)
 		fsync(dev->fds[i]);
 		close(dev->fds[i]);
 	}
 }
 
-int backing_file_tgt_init(struct ublk_dev *dev)
+int backing_file_tgt_init(struct ublk_dev *dev, unsigned int nr_direct)
 {
 	int fd, i;
 
 	assert(dev->nr_fds == 1);
 
@@ -23,11 +23,11 @@ int backing_file_tgt_init(struct ublk_dev *dev)
 		unsigned long bytes;
 		struct stat st;
 
 		ublk_dbg(UBLK_DBG_DEV, "%s: file %d: %s\n", __func__, i, file);
 
-		fd = open(file, O_RDWR | O_DIRECT);
+		fd = open(file, O_RDWR | (i < nr_direct ? O_DIRECT : 0));
 		if (fd < 0) {
 			ublk_err("%s: backing file %s can't be opened: %s\n",
 					__func__, file, strerror(errno));
 			return -EBADF;
 		}
diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index c14ce6608696..db4c176a4f28 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -161,11 +161,11 @@ static int ublk_loop_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 	if (ctx->metadata_size) {
 		ublk_err("%s: integrity not supported\n", __func__);
 		return -EINVAL;
 	}
 
-	ret = backing_file_tgt_init(dev);
+	ret = backing_file_tgt_init(dev, 1);
 	if (ret)
 		return ret;
 
 	if (dev->tgt.nr_backing_files != 1)
 		return -EINVAL;
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 830b49a7716a..96c66b337bc0 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -460,8 +460,8 @@ extern const struct ublk_tgt_ops null_tgt_ops;
 extern const struct ublk_tgt_ops loop_tgt_ops;
 extern const struct ublk_tgt_ops stripe_tgt_ops;
 extern const struct ublk_tgt_ops fault_inject_tgt_ops;
 
 void backing_file_tgt_deinit(struct ublk_dev *dev);
-int backing_file_tgt_init(struct ublk_dev *dev);
+int backing_file_tgt_init(struct ublk_dev *dev, unsigned int nr_direct);
 
 #endif
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index d4aaf3351d71..2be1c36438e7 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -313,11 +313,11 @@ static int ublk_stripe_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 		return -EINVAL;
 	}
 
 	chunk_shift = ilog2(chunk_size);
 
-	ret = backing_file_tgt_init(dev);
+	ret = backing_file_tgt_init(dev, dev->tgt.nr_backing_files);
 	if (ret)
 		return ret;
 
 	if (!dev->tgt.nr_backing_files || dev->tgt.nr_backing_files > NR_STRIPE)
 		return -EINVAL;
-- 
2.45.2

