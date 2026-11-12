Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505696;
	b=oHiDQTbQTf8kUaI1j8sHYWVJRiRV8REgGZoq+lhxGHOUxWLCZJPowBNfRHnwMgodpN+r
	 xt8m0R6XIK2H4g3Dcws78H0CU7gxqqROxYmcDnmM1BucrZGo4VDbEdxwZtmgUQcb9nvcm
	 Z5Innh3rFdAfjAjR9aq1L9vLdgCK6/g3I5clw7/UsxDKLnFCwSzyjGO+1pWIXNql3hwNB
	 6iZqWZkmdLKytKbsFQFAH2hTj9fyFUTpD4JAkFXoQqiupfdDwaLKaGVYQtljwU+kWF7z4
	 1MORE5g5UIJ1Gs3uPZ8nT55yhSK9VrSg2rKJ7BKN8AsC95GlY1vXrKlY8ZBdBVRtHcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505696;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wUuadG0Yw2Izwr3UTyTfSeRMzW9ur52zaG54mUGgnbs=;
	b=D2WrllgF/CTzraU2CdicRoZ67Zxyz2gTeqXigP9UR5ZWaX2t7LXu0q3K06Mu2vD79LNT
	 +EXwS9AgsuRtPudd5YbJ0B3Nu9ohTo5SEE315jscOQ9MWYi1fBnBX93ykKG8xglY+Vwwq
	 Wrm/Tb+E7LiEgLSUAJoEcB9YsOOOXF9kvotKdt0CAeIS3B26lqyNhuVooKM8WyPcQQNQJ
	 a9Kjpl25QlIToLIkQH3HXlTdIuFt2qhGiFFtXdhb/K7TFRvwg8I7zjom9ENfQbhzbMQhc
	 9rjy5nSGiDmGWiOp8zxS7D+OUMXhHmjaIjaASG4C2KrqTGpjEXJAWdc53bZjrrKswaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=WcZiU7dq;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4AF606A32E
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 17:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF4AF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=WcZiU7dq
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53664b4860bso44258571cf.1
        for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 09:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1794505695; x=1795110495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wUuadG0Yw2Izwr3UTyTfSeRMzW9ur52zaG54mUGgnbs=;
        b=WcZiU7dqYkVn3XbOr7LnVDUkgYhzKfqKV+4wtU9Ll/aqiDDEMIJM8j2AheQt4peZbR
         5YglCi/0y31gAuQm99zSTUGraQofwuVsLVeoM0lIYCvP/X7IFeU8zjfduNXaeKM9CZD7
         x9jW8WUySgUi4NRi/HAeWE+dMhhATm9Brnihy5/G6T5xujc8r6UtLDPo9JNb8yBD4UBQ
         e+bCaRqtCn/FU9d13zcEmTSjcxr4WW5EUHPMf+Wd04NbR8Qz8qi7oat2638a63hhfr+R
         PGt2GoUCzwuLjtBXMDNULtkV+m6sPwUsg0P4UWEpu1ioMfb1SDW2SIh8h+QtmXo06LCl
         F3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794505695; x=1795110495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wUuadG0Yw2Izwr3UTyTfSeRMzW9ur52zaG54mUGgnbs=;
        b=CPXP/RtNZWfd7dzD3soLezJDKLfbyeTWlAEpb1cDOXR2EhvhnC4oDa0QEAq2Px+1Jh
         J3LsTd56cE1HUIXrFveYpEOjRBWlYdgCtQhbuffWkM/vREtzbUPhkW4YN3dPWpEUUaD/
         /4tHmp8dM/2GaGs3coZ+uPRbDpPNxBwTq14m3M1SqD+7acwWuSiMtOBC2xG3ZuJn0zp2
         09smV2M5EZwPuV5eLmjvWbj6mm7g1+QSP72Us7wp/SCnItnI54JuFozP7LMg1R2haFzj
         mNT1u2VaaUm8cQe72ZPTGS/07ULQDJ6Z4dy+cgG6g0tC3sOl4mMCftgCOnQRduee9Pk6
         RSZQ==
X-Forwarded-Encrypted: i=1; AL+hErHDLxiz8bkU7HljQjuyOt8/DPkV/CV3/uf0JeLKGQ47iYpFHwkrhd1AzWwT3pnL1o3ff66jdvgk3EblBg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+a4Zf0IMsqnveW2ySJaIKvLqEHC7+xMwcbEKMxgruhfcmDBxMU
	J2pPyxFjuwWKbtUTRBEB/KCImRmqvNYqWJAib4sscD1+hnFumXcRZfdUY2ELRqkS/w==
X-Gm-Gg: AYBFou12pIN4UQ4HU8o7NtB+n3lOJHdPSaf8MUGI2koa4aeY74mGXM2i/USz01SMn2Y
	XargEx8X/6QZCd0ksrkHBHtY0nwGqeQSRCyzgLHvYeka91ed1pas55sg5hR3msRqqEpW02JxgxA
	ufirZ97kvt0teilrNOdpSK+/+Qco9hlP1Iauz1hW9wBdMZrAiut9N2IzcmspcPXmDvFlmA+TyOE
	OBZ4RXD+pRskTe4dg+wUuErYOxCL07RYx57aVLl6yAbuqVpypMl9fMEEmhfoQOkXEbahdZ6sl0I
	nWpcz4Yr7MSAQ+BnUD1rJQtC1emBecioiiO8QTZlYDpYXIwX14P66bXEVERyLw6qHmeLdZfouY+
	44sxtIW+LTeXmMvjKeuL55TNSoXcW/0RWzlO+FIwcih4MyQEFqLIdOzw26b41reQUwwuaRiPBSg
	w6XJhfaSSAIkPs8SCGaBpqu5OiFZr0IncQUgwGnEkNz7TLzE2bfv3uYn+N2q1loTleDmBqcvK6Q
	zZMc0ASUCMFCOyVX08GVDdlQGvhllFsP3P/LStY71AdwIYNKQpWvDZx7vloN7lqbukwPQZ7wcGh
	sOsB/g1QMybb9CUPl4z+UYh+7qCWQUX8g+Da/zjlvXDcotc7cXmO
X-Received: by 2002:a05:622a:17c7:b0:535:a5f9:7526 with SMTP id d75a77b69052e-55ac9089440mr1514941cf.69.1794505694735;
        Thu, 12 Nov 2026 09:48:14 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad0ffeba0sm70521cf.17.2026.11.12.09.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:48:14 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Jens Axboe <axboe@kernel.dk>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.garry@linux.dev>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bdev: do not report a statx block size below the block size
Date: Thu, 12 Nov 2026 12:48:05 -0500
Message-ID: <20261112174805.1200379-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 425fbcd62d2e ("bdev: use bdev_io_min() for statx block size")
made stat() report the minimum I/O size of a block device as
st_blksize, so that devices with a large minimum I/O size get large
enough I/O. Commit 777d0961ff95 ("fs: move the bdex_statx call to
vfs_getattr_nosec") did the same for fstat().

However, the minimum I/O size of most disks is 512 bytes, and
st_blksize was 4096 for them before. As of now, programs that size
their buffer by st_blksize, such as stdio, write to these disks 512
bytes at a time. Each write that covers only part of a block makes the
kernel read the block from the disk first.

The issue can be reproduced on a disk with 512-byte sectors with:

    stat -c %o /dev/vda

Before commit 425fbcd62d2e ("bdev: use bdev_io_min() for statx block
size"), the result is:

    4096

After that commit, the result is:

    512

This patch will report the block size of the block device when it is
larger than the minimum I/O size.

Fixes: 425fbcd62d2e ("bdev: use bdev_io_min() for statx block size")
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Application impact (Ubuntu 26.04 user space): "bzcat sd.img.bz2 >
/dev/vda" (bzip2 1.0.8, 64 MiB image, disk with 512-byte sectors). On
v6.14, it reads at most 688 sectors from the disk. On v6.15, it reads
about 108,000 sectors (53 MiB) while writing the image.

Tested on block-7.4: with this patch, stat reports 4096 again and bzcat
reads at most 2,104 sectors.

 block/bdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index f20f91b3176e..c9a3d7832c42 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1430,7 +1430,11 @@ void bdev_statx(const struct path *path, struct kstat *stat, u32 request_mask)
 			0);
 	}
 
-	stat->blksize = bdev_io_min(bdev);
+	/*
+	 * A buffered write that covers only part of a block has to read the
+	 * block first, so do not report less than the block size.
+	 */
+	stat->blksize = max(bdev_io_min(bdev), block_size(bdev));
 
 	blkdev_put_no_open(bdev);
 }

base-commit: 8067050e7226844fb32062b5cea947e5897d3d7e
-- 
2.53.0

