Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD1723EABF
	for <linux-block@vger.kernel.org>; Sat,  3 Jan 2026 00:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401143; cv=none; b=Hyur4QAH2cQR6nOjL1f/osG/bHgBoUHFVwgwQXSpaKLyJbelbKpH8+WGxt5dSq6+xusBuB8Z1G+Wu3A5N4GF84mvJwkwQvhfDSlH9dRxotRZudy5VVuIyRV2odeceWibpEJI7oyJiMymPUCgOwI21IVPWirZuUFVHqvrv60Aek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401143; c=relaxed/simple;
	bh=FpSk9SBO7a8fTola1zwsU8+516cI+0H9/8WbLKjGV0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Slp8WUECSkXLrcVwG5yYabEhl3nZXVzAjzUxzUoWSJZglrTl+fCJL/pR6nIP1g/InihWS7yK//22c+pa9Mn5UmbU9Iojere/cKxK4zuzzCe1Xeri7B1B0+MO2AD91pL5gu4Y5Ygc679P0LfLV28/WoYgzpu7JPpcXHQHR/in02Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DRjgjhpF; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DRjgjhpF"
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-88a279995f6so10705176d6.1
        for <linux-block@vger.kernel.org>; Fri, 02 Jan 2026 16:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401135; x=1768005935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdwpGAzUowZ3h68lzOUG2hhVHWdUBrDTU/ZZOy1LyBQ=;
        b=DRjgjhpFNm4N4N6hG4XO3vKRWqUAic75HF8GEWYB8P0Yf+MpZQJ1ftPddE+B4iYAQj
         xcbNX8UoTZ1tkhxJwNZt+JYe8kTVsz0ZBtohgdbvaEsLNyrnxLKZdVq3NqWyN2f6ughX
         IfJ8GPI1n9hTSsCulm0LKdmaR1+vkb71vwZCOVBJQiCNsO7IaV4RB/CUxCgXMzf/7TFm
         t2Yl5E6CTSIVAfGELtfGvd6TAL2jWMH+Vk6ybBMC2rWtw1L120Say7N/knIgdJAOQRcK
         DqhZzDxSBLKFHGlfEVYZMriLD/iB8q9Tl+0kJgZHRVI9sCjAbNj3Sq6/kEujlapOx43f
         xTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401135; x=1768005935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zdwpGAzUowZ3h68lzOUG2hhVHWdUBrDTU/ZZOy1LyBQ=;
        b=pNKRyM6sv+OY+efCjPKuZKeAOh1my98qQqojpW0cnqbLfhA3FvyF3NXYAjzjduugbv
         R2MiDv8iXzKU9RbtsprsUchG+ougDLkjGnN9VbdwUDlWIpfX7lZ8plWNFprQix++yk7y
         lZPSgT6CvY9Kbcw+r720B04SL+IT3ljtmry6YFGcd6ShfNA2OHtDsfUU92dfKM4PMsI/
         5NK3KfF4oiDFJi66agFw1HLdBEY0sQ5kelkvLzkRZHrPdPX5c7mTcgYOj93XurOnVcwC
         L486Brxz/x1VdrIpQWnpDAPMwy8ttuvN1NootVFep2JbmxDQBp024C4/i1jPxK91CFhJ
         Rpgw==
X-Gm-Message-State: AOJu0YxMUUghu6GdJ/UvyO7eh/xLkEkT0wyc/VJdYisOF+X5aCg6F5d4
	HAbhPE86OPcCApLESVyanY1fXiucdzk5bV/CFR5IeW2a24LQl/pYlJtqBwGnbGpYtpeE08/qnS9
	ApVHDMB3WQtZcnoK2C/XJ+j0hliZe/A95EXnc
X-Gm-Gg: AY/fxX44KyVkFuxkcYvaiu4PmR8oA9sxorrLuHE58Cqvboo/a9HiNHhmGO5d9h4YJCR
	yMefarbiWI06iVgN3hd6gjlwaVdT2k7P8X6uQ+zzsSOEJSze4cMc+hJKTdR7mG6l09oOut6nNjb
	IDu9Vny2id3C0UCKMvvZApCvCdctGa8R/MGUYASijPKT+Hyo8GfFxsfZckJ0ZaORrNVM6a77j8x
	C7xng4dIGxA0StkmFfshydEBy1/zCFfj8+t/bRfpNy5XucxZjuR8STT0fV7DRIxqmBpNRObg031
	O5/0HzaJKpXKbzECaaPb9gQdCezbMc3MQ5cwVSOmBOk3uOu1HQUP2x3hdJ+Ba2rwkY25E6gTsy7
	6NefiD8Ni2FgUAUQFQ/HP4/ir6J24CamVDVMZQO/e2g==
X-Google-Smtp-Source: AGHT+IHI3WlUSEHmZ+1u1hXYR6d4oNAiQx5UnNNYk+rdbw2FQFi+pnQTNFmtPF88OIAF0HT6Q1NiahQ34/YP
X-Received: by 2002:a05:622a:1819:b0:4ee:87e:dedf with SMTP id d75a77b69052e-4f4abdc433cmr505476921cf.8.1767401135307;
        Fri, 02 Jan 2026 16:45:35 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88d980505aesm54692196d6.23.2026.01.02.16.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:35 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 99E273402EE;
	Fri,  2 Jan 2026 17:45:34 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 97E34E4426F; Fri,  2 Jan 2026 17:45:34 -0700 (MST)
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
Subject: [PATCH v2 16/19] selftests: ublk: support non-O_DIRECT backing files
Date: Fri,  2 Jan 2026 17:45:26 -0700
Message-ID: <20260103004529.1582405-17-csander@purestorage.com>
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

