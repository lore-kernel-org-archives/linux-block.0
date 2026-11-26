Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795736238;
	b=scQTZrr7ZXJSJpRYi9sdHqePSgN5QOHzbDqtWMbe+3Y07yfDXfewo5CfALoGO3dUhScn
	 dMRudNUSWVDY8pImf/o0G+W877R6dAFrmaTZdXIMRipdCepTHk+BrLBKTQqdxAKezLZRd
	 yHTrx2kUnPmR2zkWoQ70Chgmgt7EUEShZ1wAViV0SmHzCn3GfAoevVxn/woQ5+Mp2JuGu
	 iNpahWqzVIu8q4yMwuobhT7G5BkaN2Bf8euo/ZXEDSsozdU/Ppwqg9nQs/ZHmBdWT4JzK
	 DJUIfJxUcWO7mqpzGkp+hOlBciWdWjbb9G9RDSoIr9OSPr53TZWOmL4oyVBo5gfIK8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795736238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LDm3bBcnTnKtfKRSJliMl96Xk4mD8qAAxIPVCJmwuZQ=;
	b=iyyPdoj7vLmK4voZ6ohe1U7kYkn1a9TTsXkPS9OYa0vOscs+/gZhWPzo5cEhn0TjNuAA
	 8+ssR6SejlJsVWVuCHJhxsFKF/F3u0VpQn55000y5q+YiWUDVagR/ayQYeAKkQmLVk5+d
	 avbA17W/pTPb3qg/MuGkvKYryNwTSNZ++dmyCPnpKujXn1XnPVg/XnqWdkLvlOqdrcf74
	 PVC6lljYbYymgbgrfGc+dXg+rZ3UfZXomY8QpEnsMPL1Mjz0QgIUlu7xjHT3E4IPGfKtR
	 w3Ra4m/IXq5asce1tf4/A4/5JVk+i8MdECcyUr7uRJRiEkK49zSXz6sgilsgsK84QtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qcoco8Qk;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE0A606A31E
	for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 23:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BE0A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qcoco8Qk
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4acb44dcd7bso6760884f8f.0
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 15:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795736237; x=1796341037; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LDm3bBcnTnKtfKRSJliMl96Xk4mD8qAAxIPVCJmwuZQ=;
        b=Qcoco8QkasuK/e53iBKD2sD2ghxxpi0c7lgK88dZuX7Xjr7fCAdxBuFDgZi0npMr6l
         OLlZ/WL4pPrbmoifO8P6RydTtVS7soXQNWmBD364Jc5KpuP/cXQAkpeRZeoQ5E3pLze0
         cq1k216au9JWBWmAcSfG2BWX9GqrY3W2CcBfVl2AnkvAuFVL7mZBB+UuzU8hrUfI8+Wj
         uPlhGu4mZqvuvztRqVEeGSzIJb0Lvi0tmg8xsTaho6kb4iaKOfz+MTO7t5lABLS8IBKJ
         XivmiSZB1VwTWQnErL8ZpmGUmxKL5NbYd86WxuQU5OLsmxpg+Uy+SLvltxNwW/aNNUlQ
         MLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795736237; x=1796341037;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LDm3bBcnTnKtfKRSJliMl96Xk4mD8qAAxIPVCJmwuZQ=;
        b=yUWlK/94rB00D4+ojCGMqYC+MwuwDsf/jlwR/j7VgUFO9mAb7sF2Qzsd7+j6GdViH7
         UZNOJZlEapItGJkyf/brFpTsCcSwqcM5iuz0fZPc3ZDbuwKp/RafqIONpIPY+leIHElD
         65rT8iSAB0J2CLP2aYmIsV7hwTqmxQh3H5XioYu4/bIRwz+9sYkj12fra+puiyvVdeKK
         3XZTpTnILxfKyxgLAhwRuZlHPYzSMP83ZHrC+82X4RrNFI88HYN5PTy93Qa2p0Nn3Pxq
         LeIemEPXOv3tSs9llxFkQ1A5L8xfH/hA3UBNv8g8yCNWIWnKKOhLZJjolrPcNJZbb+3c
         NyNg==
X-Gm-Message-State: APuU4Z9+CUeEYBhjfsO2A4QFJHxuR5c5L0fubcjSCxf9uRoxJp9lm59b
	yTJfg/eYnYo8s51WiJUVCYDc4p3v6M+UL2mnH86rHnor3aLqt4/dpK66
X-Gm-Gg: AZFdTZea6p5EVtDvqaDA0FM6YLMR+xNP7R4XSd2jXXbtDH72HSlJwFolgsr7Ed6hvY0
	xr1d59ntwE53XnJvyCdX/Wyk5GY55LfcH4zhDgh7HImv4ofu9Xz4VuR3oEIknGKMJ/aDKtlyMI2
	vGE9aTzYTgAN4Ldqql55rbDZIiezqPevfP2u6/A3yLpZjiBF+T/8gUbw20ksySYK24LKCfdxWAs
	7S2pFgcuGXINvvah1763rWwrEvXLxW7No+PlGLRlr77Ns0t6gRde4B49reWXE6euzSlFQYaRJDL
	9IyOC5UZQWj+SyyKjaBn3sY/MYNMJbqspolpreLSgtIVkpK3AEO3X44dMSQBh1QzBHvOprHLIdb
	AcV0Cmt4/LUhOcBMq8vvREbm0Y1v27Sl+PGeVDYpunTEO/MummRZ+HeaOuFA/lK9qK88nQkq+wD
	8LHG32v8Od69jaLL0MTLPP9DiSet4HeoofEyyTn5MkcuepjQbN5VLXr4D8dwRxdatFD2ybd9W4O
	IOvlIERzqFcvSSmdMipw7QxdjVfVKgIYoPO95Z2LPHnYyWJ7d7QJO1szyK4zgxkk1ZeWivznQ3N
	N25CM+rO6XU7rNF8gMfJbg9ex8IXgByTa4FVxMC7qu0yaXKotA4Q3nDQHR5odGUsYo20OH5o1+4
	w1kQXU3PS
X-Received: by 2002:a05:600c:3b94:b0:4bb:6f41:39be with SMTP id 5b1f17b1804b1-4bb8880ca3cmr564837615e9.15.1795736236738;
        Thu, 26 Nov 2026 15:37:16 -0800 (PST)
Received: from Mac ([2a01:599:843:3686:f8c1:c9a5:9d66:c45e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm630189005e9.10.2026.11.26.15.37.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 15:37:15 -0800 (PST)
From: =?UTF-8?q?J=C3=A1nos=20Szathm=C3=A1ry?= <szathmary.janos89@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?J=C3=A1nos=20Szathm=C3=A1ry?= <szathmary.janos89@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] loop: only write back the backing file when direct I/O is used
Date: Fri, 27 Nov 2026 00:37:10 +0100
Message-ID: <20261126233710.42048-1-szathmary.janos89@gmail.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 86947bdc2889 ("loop: move vfs_fsync() out of loop_update_dio()")
moved the vfs_fsync() of the backing file out of loop_update_dio(), so
that it no longer runs with the queue frozen.  In loop_configure() the
call became unconditional: every loop device setup now writes back all
dirty data of the backing file, also for a device that uses buffered
I/O.

Before that commit the backing file was only written back when the
device started to use direct I/O.  A buffered loop device reads the
backing file through the page cache, where the dirty data is, so it has
no use for the write back.

With the unconditional call, setting up a loop device on a file that
was written just before waits for that file to reach the disk.  In VMs
running 6.18 with a rate limited virtio block device, mounting a
squashfs image through a loop device (LOOP_CONFIGURE, then mount(2))
right after the image was downloaded takes:

  image size   time for the mount
  0.4 GB       0.8 - 1.4 s
  1.1 GB       3.2 - 5.2 s
  2.1 GB       2.2 - 2.7 s  (larger VM with a higher rate limit)
  4.5 GB       6.1 - 11.0 s

The same mount takes 4 - 9 ms for a 0.3 - 0.4 GB image that was written
minutes earlier, and 4 - 7 ms for a 2.1 GB image that is fdatasync()ed
while it downloads.

Call vfs_fsync() after loop_update_dio() and only when the device ends
up with LO_FLAGS_DIRECT_IO set.  loop_update_dio() can only clear the
flag, so it is final at that point.  The device is not bound and the
queue is not frozen there, so the write back stays out of the frozen
section, which is what the commit above was about.

A device that is switched to direct I/O later with LOOP_SET_DIRECT_IO
is still covered: loop_set_dio() writes back the backing file before it
enables direct I/O.

Fixes: 86947bdc2889 ("loop: move vfs_fsync() out of loop_update_dio()")
Cc: stable@vger.kernel.org
Signed-off-by: János Szathmáry <szathmary.janos89@gmail.com>
---
Tested on arm64 under KVM (QEMU 8.2, 4 CPUs, 8 GiB), mainline at
9437ee8b6cf6 with and without this patch.  The backing file is 512 MiB,
written with dd just before on ext4 on a virtio disk whose writes are
throttled to 150 MB/s (QEMU throttling.bps-write), several runs each:

                                  before          after
  losetup (buffered)              3.42 - 3.65 s   0.04 - 0.08 s
  losetup --direct-io=on          3.40 - 3.56 s   3.40 - 3.68 s
  buffered, then --direct-io=on   -               3.53 s at the switch

Dirty in /proc/meminfo goes from 512 MiB to 0 in every case that takes
seconds, and stays at 512 MiB in the buffered case after the patch.  A
squashfs image written just before reads back identical through a
buffered loop device, before and after.

blktests loop group, same result before and after: 001-003, 005,
007-009 and 011 pass; 004 and 012 are not run (no scsi_debug module,
systemd older than 259); 010 and 013 fail in both, because the test VM
has no systemd or udev.

A W=1 build of drivers/block/loop.o is clean.

The times in the changelog are from VMs on 6.18 and cover the whole
mount as the caller sees it; LOOP_CONFIGURE was not timed on its own
there.

The cause was found and this patch was drafted with the help of an AI
coding assistant (Claude), from reading the loop driver at v6.12, v6.18
and mainline and from the timings in the changelog.  The tests above
were run with its help.

 drivers/block/loop.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a3325ce..0c84eb7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -986,14 +986,16 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	if (error)
 		goto out_unlock;
 
+	loop_update_dio(lo);
+
 	/*
-	 * We might switch to direct I/O mode for the loop device, write back
-	 * all dirty data the page cache now that so that the individual I/O
-	 * operations don't have to do that.
+	 * Direct I/O bypasses the page cache, so write back all dirty data of
+	 * the backing file before the device starts to use it.  With buffered
+	 * I/O the device reads that data from the page cache.
 	 */
-	vfs_fsync(file, 0);
+	if (lo->lo_flags & LO_FLAGS_DIRECT_IO)
+		vfs_fsync(file, 0);
 
-	loop_update_dio(lo);
 	loop_sysfs_init(lo);
 
 	size = lo_calculate_size(lo, file);

base-commit: 9437ee8b6cf607e883b36e44bd755968daaebd48
-- 
2.50.1 (Apple Git-155)

