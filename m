Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5077F339853
	for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539829; cv=none; b=e2JXEe/MlzXpksyeTAPo6OXeVP/8LzaCbIcPuu7XgGYYx0yAjs2eBecDWHsl6p1Bw5mPfG50W27VD2m7lq8yuKU7tE/now2q2Dszqmc8aN850fRDeUzDWpfPakMJT2YOy5Hc3vwduwc07y55S2IF0k5MdpeqVD0DWzNq8fqYirY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539829; c=relaxed/simple;
	bh=Nf+yQGJgkbwMPbTd5inciSdV4SFDYEQytDwG0JOvv68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iX2cld61hkFHN5tw/YQssSsBXfZzLrof6WbDAu0tN4lBrOEVmgrCtL1xUuxSADqkURnbybB+MDZvdiSPxz0JTCvSz1Dr4JqqvZ6KJqIuVNUJrwAHILmSqLgw3pVZ4LaNlJN7rEb0VBE8vijcrMHnQviYzpFJvW7tGTVG/imQjWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIF9KG4o; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIF9KG4o"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-38111ea8a88so575557a91.1
        for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786539827; x=1787144627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J08Exr9ywasYkWhTfe4dQDxairJ9Jk0Q/bK1oRGZQ6Y=;
        b=eIF9KG4oVoO01dXg6df9WHEZJx65HuqxRuLk5Xbk0BUXCpKBDcCD1qmahK8AuYYRko
         WY12O6n3usEuDa6WSiYezNQPQ1xV9mff69FEooJ0AYV8+RFo8bc88KIGlnQsydr7bMyv
         dMQh7dIofzLAY0ZssyHr6hM9FitS72P+qTL2a9/TdtTdVhIo9ZkulfwEHHUCEhvHBpsd
         fB6wfsAWK6lwwzT/CS2ggmxrw9RLIxMKNNy+nU95mL7tTWCYXtX1LpMEigU6c4LQniBd
         X9QqnSt1K16/+EFeRyfRZaP7GGvD01n3MbrDUpjaDdxjtiniec5wGAnrmHDQLwGiNqa9
         X86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786539827; x=1787144627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J08Exr9ywasYkWhTfe4dQDxairJ9Jk0Q/bK1oRGZQ6Y=;
        b=fjacSIABVhJUxi9hnoW/oY/wgznAQYVfcoqOxNlXf5Du+SKLZ7ByDlzIAad87nBAGg
         taF6J59ObVz/ckkpq2zS9rMcpNBO950WW85kn6zwuVYk8JwJkPzHJ2N/HAVtN8m0I4v7
         ANH8kU+vAbK6OwP1F+mSFH3Y+Re36m6ymR88spo2zkfi1GCACXVz02E0wenuXl1T7gcv
         5hWAdhx+E34ZPceaa/muXp+cyHsImCL9Jw7H2theDXu93jn6bdNEBqUUnrAx0MJsVhzF
         +C5HOCHQHvqvmxy3O020XMs12ux98LDFXS1FcF2XOESX0ZoGaURTc38Andj0p8YvVxOq
         Pqqg==
X-Gm-Message-State: AOJu0YxLd0Kd8E15U/zxFd0GxjqhiFTN0PYKWH15UvEBxw4mPImek5al
	SWHVK/+RBS6XWBL/9EwwGTTVADWEUfEnGeOGsH2BXrr88OE3++nA0XWL
X-Gm-Gg: AR+sD10RtP84WZmIXf9dHnzlr6skT96Y+/ixn8JkE6lIxz0c3pBf3smdZgyHYQguN2u
	25XbN8yIRKAo1fEz1zF0aauRhQk1a3ZqHuccsbI2Hm9WSQ+vt8YVhyt7CUlPRb9jvqxH/QykVY/
	M9WXwbyvCqluEwCoM33mWAHBWgc2s1UNNKZhdKeBN93URO9hWvlRaKsdsYtDMR7X4DUjXLEESdH
	CfyznFSFDErijmxPL8JSGlTm7MLlOStoCPwAGplYyQjzxChSBFHlS8OygtJSW3K9oHMGy0XUt4L
	q2eaFwbVp18xA+Y+SaCUKDqtTlwqL5P8OPU81jSCGUBX5F60rZ4PntyWWyPNRSKYUvEgDr1diTa
	OhCv+r+0k3hHQ/Ac6budV/2vv5Vj3xig7Hrq4M7U5pFZmqziDsoIkYQ6gHfdcy2rdqhYZUmT2tN
	DupWo0GWyzAbnXi2dPkbC78jG6AbKlT9LuB7INatnJ2bg9wb2CtKaQrxEPOoyV7ffm+N9kVPPmp
	WlLQQrlsNbKc2sKShmqAN0T
X-Received: by 2002:a17:90b:52cc:b0:383:5a16:bd70 with SMTP id 98e67ed59e1d1-39301663b84mr5720506a91.16.1786539825914;
        Wed, 12 Aug 2026 06:03:45 -0700 (PDT)
Received: from HXYG4FPMGD.xiaohongshu.sh ([61.8.202.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f8cfdaccsm3622924a91.11.2026.08.12.06.03.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Aug 2026 06:03:44 -0700 (PDT)
From: Zhenxian Ma <mzx199711@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Zhenxian Ma <mzx199711@gmail.com>,
	Zhenxian Ma <mazhenxian@xiaohongshu.com>
Subject: [PATCH] block: skip redundant flush for O_DSYNC direct writes
Date: Wed, 12 Aug 2026 21:03:35 +0800
Message-Id: <20260812130335.60354-1-mzx199711@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For an O_DIRECT | O_DSYNC write to a block device, dio_bio_write_op()
adds REQ_FUA to the bio, so the data is durable when the direct-IO
returns.  blkdev_write_iter() then falls through to
generic_write_sync(), which for O_DSYNC turns into an additional
REQ_PREFLUSH.  That flush is redundant: the FUA write already made
the data persistent.

Skip generic_write_sync() when the direct-IO path already provided
durability via FUA.  The buffered and direct_write_fallback() paths
are unchanged.

Measured on a Seagate ST20000NM007D (20 TB, 7200 rpm, fua=1,
write_cache=write back), Linux v7.2.0-rc7, single-threaded pwrite()
loop opening the raw block device with O_WRONLY | O_DIRECT | O_DSYNC,
4 KiB writes for 60 s:

  Sequential 4 KiB writes:
                            baseline    patched
    IOPS                       119.7     7497.0
    avg latency (us)            8357        133
    p50 latency (us)            8346        127
    p99 latency (us)            8368        395
    p99.9 latency (us)          8728        569

  Random 4 KiB writes (100 GiB span):
                            baseline    patched
    IOPS                       156.1      666.4
    avg latency (us)            6405       1500
    p50 latency (us)            6186       1450
    p99 latency (us)           16133       2285
    p99.9 latency (us)         17250       9916

Signed-off-by: Zhenxian Ma <mzx199711@gmail.com>
Signed-off-by: Zhenxian Ma <mazhenxian@xiaohongshu.com>
---
 block/fops.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 15783a6180de..9c34a372b476 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -726,6 +726,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	bool atomic = iocb->ki_flags & IOCB_ATOMIC;
 	loff_t size = bdev_nr_bytes(bdev);
 	size_t shorted = 0;
+	bool dio_fua_done = false;
 	ssize_t ret;
 
 	if (bdev_read_only(bdev))
@@ -763,9 +764,13 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = blkdev_direct_write(iocb, from);
-		if (ret >= 0 && iov_iter_count(from))
+		if (ret >= 0 && iov_iter_count(from)) {
 			ret = direct_write_fallback(iocb, from, ret,
 					blkdev_buffered_write(iocb, from));
+		} else if (ret > 0 && iocb_is_dsync(iocb)) {
+			/* FUA from dio_bio_write_op() already made it durable */
+			dio_fua_done = true;
+		}
 	} else {
 		/*
 		 * Take i_rwsem and invalidate_lock to avoid racing with
@@ -777,7 +782,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		inode_unlock_shared(bd_inode);
 	}
 
-	if (ret > 0)
+	if (ret > 0 && !dio_fua_done)
 		ret = generic_write_sync(iocb, ret);
 	iov_iter_reexpand(from, iov_iter_count(from) + shorted);
 	return ret;
-- 
2.43.5

