Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB0C22D793
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 00:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661098; cv=none; b=oT6dvH7OS33o/d8oSONefbJZtxcrB0wkrEiityMlLkAIIJ0HUgJwl5Kw2MCxzaSXE81jfkezZCm5VYyoz8W0xZKrx4JKQ7uYEVrWWZkRvNWSpAxYKPA3VYolIMBYIDqq2ZkYtJfiEmpUh10jYFWtR4tchz12IXGYk3goRnZoYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661098; c=relaxed/simple;
	bh=FpSk9SBO7a8fTola1zwsU8+516cI+0H9/8WbLKjGV0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0hydLalplciAyLST5FoB3jpbPxRpnbtSHua5qOwC1WBVQf9KWKc8riy0vp7zBvljJT+tpi8245EkJMmgYl3L8ugA7qW/YDcq88bcJFWyVZcVLY7SzQvynEr2Q5ptJd2WfC2FCZNths82O7LTuMUeEqALbNo4H2oOXvSYMMVuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LGcaG0XY; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LGcaG0XY"
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-888872eb53bso630486d6.2
        for <linux-block@vger.kernel.org>; Mon, 05 Jan 2026 16:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661092; x=1768265892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdwpGAzUowZ3h68lzOUG2hhVHWdUBrDTU/ZZOy1LyBQ=;
        b=LGcaG0XYIdxQstnTwYEDXzPqNmcfkhEnx32a1N9Az6x/y/Muv2t7Kx8x9Ft79tsKum
         PzEXKqt9yLndcefuHKJt1gJ/XT3dAkPbPcz8P+ryWa1Y011R+8A25m8CkZst+WZWpmPw
         YtEAX4zfoO9LZE7DNO1+JbaD0QqiHbFYVSKj2+oXVId9+zsFDyQrdMsLRwrRDzr+XeA4
         ZBbmKcIfP+Y3kutivmL4OqI1REp6vxdYbZFH+DX5wrzs09jwpCnrnacjjy7PljZjDHGn
         +3WgV5D8mvrx/isuyhLoApQrsc0gqLf4Z7OTGSgSiYuRtfIs97Oequed8xNAUxeyZ9FE
         c6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661092; x=1768265892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zdwpGAzUowZ3h68lzOUG2hhVHWdUBrDTU/ZZOy1LyBQ=;
        b=XxVRDnstfzq6nbRrP2i2H3u4lLjTCpbJ71nYEPWKdGUpxnRnFIoQD0qqwX9FRUJjei
         DXHkRb7okkfsPmthZD21dyjxVrJ8ISN9Co16ZDYXEg0tKhpb9kmSmkFfViZv6zVImLXk
         vEVSTUfnkSdqRGH6/bjvvuMOONv/5T92FtP+9s+opUMKj60RJn1H3EiKKZhzJx2FYTWS
         HTxK1Oraai4qOQ6HGTwlhdjTUyZ9vDm8Gh2029J0yrSoScJQzpLfdREw9vtXHBn0UwhZ
         GXR81pDBt1QZ8An+9xeMCcmA86w+VZ2fuVXkWJBCz/1COPaptRoEMY9TwV/S3uJQJBP7
         ngGQ==
X-Gm-Message-State: AOJu0YzRxFP3U52bgxskXIRXiZf9DIaqpfJSIpwDedqAY6CTB35WpN4R
	dmE5me9xsc6HeutNY/eImsgKS4SIXrAsYDEr22acWFuNboxI86AbyYemPnsy+FR05pLZc/kpqrp
	DrmCU3zq16+1V99jt3GZ6hn3iEFFa1KfVzRmmydEfY7EVOCEV5yGi
X-Gm-Gg: AY/fxX6bV19MdUZ4/ixDogz/MN7wNNOw1Gr4/ISBuNZxeHD6IAkChVpNfRz7p/AWsn3
	ldDNmWdvbfqu21/Z+v79IXyKOzs0H23qQ/eORccAZyoKrRn/7Dq3lRBhofu6vKzGSqkV/09FEkf
	TiQQ9FQzjj+r3AL3AwRYzR8/W2IQug6Zvldemq/hz3I12hZjDsjrok6ued41w7auhja2772xsSq
	EgM7G5ObbMHI5SfDjUdWXkgbL1v8ZEZ7SrgE+tIAk5kPkioWAP4VsxZT8hiOln//9a//4N6Be6a
	vbVQXUCN/N6zejwdbWup4VGTnmESqelD212RcA5k0u82T+Q/dKLr/zoItigX+GW+PWD/AUMytca
	/Bu/QW9FzxKk0Wa3ApCAQGa3OBoo=
X-Google-Smtp-Source: AGHT+IFwU/pBJWR2dwidv8JAygHGSrQWnV5pCYktkIbCd+APT962DRxhuMqf8abnSh/I/kA4ymWysHLBGQ+5
X-Received: by 2002:a05:622a:198d:b0:4e8:a54d:cce8 with SMTP id d75a77b69052e-4ffa76dc314mr16457471cf.4.1767661092015;
        Mon, 05 Jan 2026 16:58:12 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89077179352sm796626d6.32.2026.01.05.16.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:12 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0A5523401CC;
	Mon,  5 Jan 2026 17:58:11 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id EFEB7E44554; Mon,  5 Jan 2026 17:58:10 -0700 (MST)
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
Subject: [PATCH v3 16/19] selftests: ublk: support non-O_DIRECT backing files
Date: Mon,  5 Jan 2026 17:57:48 -0700
Message-ID: <20260106005752.3784925-17-csander@purestorage.com>
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

