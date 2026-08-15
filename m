Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1FD3542F8
	for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786784825; cv=none; b=KPIDqq/+/C36fZosIpHRHRHoRSBE3tjeNruLstS0n0gryHFpYwI85uNIDFQAHDcXfDXvWAtjoo/F2QHj4qT+yLedpjFqh1GAMod0SeNWbSusTJoG2Alo7EFtZ7f9xuqQhG88Bz0SL2dVDvH7M6Txpp/6UWesghnd6jD7dGaRD/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786784825; c=relaxed/simple;
	bh=pUCoknRO42rshHuztPa0AZyneE9IrZ1Pa0Z88SEqE6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JlDKRiRV0L1ectAuPUP5AXGnETSeijy9UA/utg09uWyCGo+uFWrlWoVHPXcurqMvcsS1+GvPD9DWP8QMc0mGku1gXVFqizpwLDSqbBgAHtcU6PHy6IYr4jbzWoixjFyyKWTIUEkDuBSfcARl6puGrg4ewVAjQ2HVBYm0C3APTko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPwWegJo; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPwWegJo"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-3931e624fd8so966934a91.1
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 02:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786784823; x=1787389623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XpQ8+TZjRTQUnqAoiCQwtaTRq0NxtCaa9SSOsajcBHE=;
        b=mPwWegJogZW2e8L1tVWA+UTzec+xugMib6/xNv3VJnPa5bEhX+Wu14K9PlkrbMAgJp
         rFckmyyf7hGVXAxgl/2Z9AC7Gtb5zubaVJImMS1kXlxRqgm1cB1jxzjU+dyainOfFk8w
         wbjLf8oHNqj5l1LLOaNpKQM+m7UX/Hksp75qgotYfpSnExn1kpgKgJUdlwbJtgOtP4fp
         UpNhXRihWC+jW4ubAclTr3jfS8nuUol2D5Ab+yWGc3LwqpF/yxOtKFi3sxF77zdcbbGD
         zPWCknAZzIB/xCHSmqw6HBm0bv1K8La91Vr4teSRjXiVYg+FvqNm6xoqreAYgbuFzSfF
         YWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786784823; x=1787389623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XpQ8+TZjRTQUnqAoiCQwtaTRq0NxtCaa9SSOsajcBHE=;
        b=AgkxtMndKKsTDG57TEH6psG4kdyaVJWA8X/ifSBM405z9dvLGo8NavgMaZACRMAzDZ
         aLRJlCMgc0aIVdEmdc7p+OixSY0wTL729U/JONjKraFWQ8477LTWAcUJh5GkizQGk0G/
         oFWbDlvlPkLn3HHdFamSzdsTaFDUrtIK8ZQCZp63AMG/sI9DLTNwBk4Zn8e0IzBcXV6d
         ph3+uLknlcWbKjd3Rf7PtxB7WYPHjvw1s5eFANeK0XW45xakX7hZbaEVt+9ECbFZDDWI
         a2DS8Y+Uk1uu/IhtsTDP3EU9lkiYRHg+ctNbzDChlrCMWRSZf9Zj2UP3ZubdzI6vvdZA
         1gwQ==
X-Forwarded-Encrypted: i=1; AHgh+RqnSyQhLuNdPVKKk7nFNZGz/6FPHbnBZ+jOzQc3/XaooCi/PQFAaFwSCwTHT4dLE28rWCFbUjnM+YeAww==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFBognwUZLhVSj66mxByFqwWyDSdnUWxZ/0rc+p9015aRHf8EE
	H+ar3CKPJVNBKsF9YSqJh/1crwRbAKWIzM2HSbQG1HrE77baJb5OEuzgGSsDokY7xw4=
X-Gm-Gg: AR+sD108a1G4qwkSKoYmgM4/Rj+HmdSDLUJD8TZY9dxFdb39I9aqFND8G5GLB0L9uHy
	ZI2rVTlmGMqMeRK/mrWaLYFahYLTfqXgozaS5zEAqDnnUkHPnETwhaOvbFxnKpSeVJT345hu41z
	h0Di1w8OWG6Xn39x+7Vo1LjbyF5/HCUdDf3LxSxPMBw2+np9rxh8F9IrmW1k2v4fqrdPEz0dndq
	AmQmmrH+z8CYS3ASr013mVCU4T7jeUALHpjLOQ1hcBu28KchpyBzxIdRkU4JfnTg45JN9Oui9m0
	P92Bh6OStC2tvPTG2Op8xVI1XxkRkGzMlMADEDYrYf1+bGaHeVk5iwQFTL2mNn4dWKPnBbEJK5x
	Ftp3l6RzDSGfUuRcrEt5c+/pbM1dKRp7v+FBJZQ5aFrq8gT/+CaJj20Juh16HmBLjAEKydWkQ+z
	90rVaGhOSvviMD4QwX48PyGa3gL5xKCeS/AsICoLN6NGA29ZGLLFcXbMa2GMEbquf8vA==
X-Received: by 2002:a17:90b:1f88:b0:392:c868:35af with SMTP id 98e67ed59e1d1-3933bd46d96mr13909701a91.20.1786784823216;
        Sat, 15 Aug 2026 02:07:03 -0700 (PDT)
Received: from localhost.localdomain ([61.8.202.166])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eaca2959sm5587140a91.9.2026.08.15.02.07.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 02:07:02 -0700 (PDT)
From: Zhenxian Ma <mzx199711@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org,
	Zhenxian Ma <mazhenxian@xiaohongshu.com>
Subject: [PATCH v2 1/2] block: skip redundant flush for O_DSYNC direct writes
Date: Sat, 15 Aug 2026 17:06:52 +0800
Message-Id: <f847707d772a9225460406b5aecba030d7209b05.1786782832.git.mzx199711@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1786782832.git.mzx199711@gmail.com>
References: <20260812130335.60354-1-mzx199711@gmail.com> <cover.1786782832.git.mzx199711@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For an O_DIRECT | O_DSYNC write, dio_bio_write_op() adds REQ_FUA to the
bio, so the data is durable once the direct I/O returns.  The
unconditional generic_write_sync() in blkdev_write_iter() then issues a
REQ_PREFLUSH that is redundant.

Skip it when the direct path already provided durability via FUA.  A
need_sync flag, clear by default, is set only for buffered writes and
for the buffered fallback after a partial direct write.

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
 block/fops.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 15783a6180de..a2c3af38106b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -726,6 +726,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	bool atomic = iocb->ki_flags & IOCB_ATOMIC;
 	loff_t size = bdev_nr_bytes(bdev);
 	size_t shorted = 0;
+	bool need_sync = false;
 	ssize_t ret;
 
 	if (bdev_read_only(bdev))
@@ -763,9 +764,11 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = blkdev_direct_write(iocb, from);
-		if (ret >= 0 && iov_iter_count(from))
+		if (ret >= 0 && iov_iter_count(from)) {
 			ret = direct_write_fallback(iocb, from, ret,
 					blkdev_buffered_write(iocb, from));
+			need_sync = true;
+		}
 	} else {
 		/*
 		 * Take i_rwsem and invalidate_lock to avoid racing with
@@ -775,9 +778,10 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		inode_lock_shared(bd_inode);
 		ret = blkdev_buffered_write(iocb, from);
 		inode_unlock_shared(bd_inode);
+		need_sync = true;
 	}
 
-	if (ret > 0)
+	if (ret > 0 && need_sync)
 		ret = generic_write_sync(iocb, ret);
 	iov_iter_reexpand(from, iov_iter_count(from) + shorted);
 	return ret;
-- 
2.43.5

