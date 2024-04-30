Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C2179B2
	for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714512064; cv=none; b=QcfnaMd4DOc/IGsRccPAn5k4CuQSz0Dmk18g9dU7eUEwdn4dQucBbnyDfUCVBjrY+ImSq4nhgkgnsT5i7TcJcTBhVyfEQMPMCexHV7NDRB31DMN34Qs83bHDL4WCa3J+Ef+UHmA6edSeixZbpBAY+C7MGdjwnoDFeINpcQxylPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714512064; c=relaxed/simple;
	bh=D1ETNbTNZVA2VSTnpmNri1tFRFsYJXy9VdJe4S3rmP8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IhNXZFQZpPFG/2wFupOpLDaRjqv8di5vTisef8xFi7bi33rI+YlGq1pHIr5K/gyDar5NlGr1osVva6g+118VsXxIVX5HEpFY4qJpPf2liZL0lG4TvuVzhgdLOvt7CxF/AYWQehwnuEZvR5olrAZ8/xXr0vfnFey0MSUpbRj9eFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DtMTY+HK; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DtMTY+HK"
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-7da41c6aa37so306175439f.2
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 14:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1714512061; x=1715116861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xUh7ew0KedMZ7KVfaNtg1GbmQejEf8XRDHGgZZEnFEw=;
        b=DtMTY+HKSaFT9h6lzZa9VbFiABngGG8Zn7ZP2PAlSLKWE7cAoywvpCS6vwRk7ZxFLN
         LuTMq5Z/3K81llG0RFzkwWK8ThQW8iVHYsPU3Xxck+fvLKlaLJ8TO8KGcD08dO+xQ6SV
         8XBN6paiYDSOggGbG04Bu1pcsCXDl8BTiR1YJ4P4MJ0Ol7LdvjnKntpwRxe+XW0iYjQP
         DaKNJNFsZYncE0rI9RryhnVU1t1Ye461VBxVgnKMp/Lo2BkSNulI/KgAZ7U3LoMTGr1j
         p6DoeeE62L9F6sL05Unw3ugm8bYID7Kq5VamCplhdXMk0lWsSZC0alp+6EztU9SMl5Zj
         XKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714512061; x=1715116861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUh7ew0KedMZ7KVfaNtg1GbmQejEf8XRDHGgZZEnFEw=;
        b=ShzTcQTPGcO/l10sXL3d+m/gY6lQfFhKKaHoWRTLaXdqsGeH0Nwa2WXwEVfQs3u3E9
         VGOTcJtwKeRkTYDiUTzoKU3GG1LDp+MXO+VKO9R0gKuXod2BgsA7riNpqLbQUUFBElQo
         IMWw3ZQC1wjF8J3Fry9HtTXu/kJjeMV8nuX7BsTi1ibod/1MfzTefpDOawaLZu4lGbVn
         SPbg2Fz5sktfsSSRl3OxjGcrfmPhgTU//b5CxIS+Ptj9Hg/NSsEEZfeVqr3nEsvtiw1+
         xa4cTyi1ttXWFOB2izwuShGsEzM4WmyUmLUqMJWzBZWKd6zBS+br1mogtCc05Oa09aM0
         6pUA==
X-Gm-Message-State: AOJu0YwV+I7QPQgyi45wg9GBLRFIhu7u7UOUvG33WsM+6aqqj6ND4AD6
	a9FUGdB7ucrU1nlTVD8HTrGAqmct5SCKwCX65+KZqfLqUXcLh4soBmUfM58YuKToCvqjqG+/jkK
	u/LFPaFqrKUa1z2mkAsubgT/C0MVQsQKL
X-Google-Smtp-Source: AGHT+IHyuud90qKjOuo3J/bfwfNnmOeRCnWoKDvgQ8WnJNQ1Zsqw+Mx5k87eUY/V6bsQVQX1eqqXAhLcb+NS
X-Received: by 2002:a05:6602:358:b0:7de:b218:58a4 with SMTP id w24-20020a056602035800b007deb21858a4mr1363628iou.3.1714512061624;
        Tue, 30 Apr 2024 14:21:01 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id g19-20020a056602151300b007dee1b32d4bsm135503iow.21.2024.04.30.14.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 14:21:01 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DC2F63400B9;
	Tue, 30 Apr 2024 15:21:00 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id D16F5E4356A; Tue, 30 Apr 2024 15:21:00 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Riley Thomasson <riley@purestorage.com>
Subject: [PATCH v2] ublk: remove segment count and size limits
Date: Tue, 30 Apr 2024 15:16:24 -0600
Message-Id: <20240430211623.2802036-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_drv currently creates block devices with the default max_segments
and max_segment_size limits of BLK_MAX_SEGMENTS (128) and
BLK_MAX_SEGMENT_SIZE (65536) respectively. These defaults can
artificially constrain the I/O size seen by the ublk server - for
example, suppose that the ublk server has configured itself to accept
I/Os up to 1M and the application is also issuing 1M sized I/Os. If the
I/O buffer used by the application is backed by 4K pages, the buffer
could consist of up to 1M / 4K = 256 physically discontiguous segments
(even if the buffer is virtually contiguous). As such, the I/O could
exceed the default max_segments limit and get split. This can cause
unnecessary performance issues if the ublk server is optimized to handle
1M I/Os. The block layer's segment count/size limits exist to model
hardware constraints which don't exist in ublk_drv's case, so just
remove those limits for the block devices created by ublk_drv.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Riley Thomasson <riley@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
Changes since v1 (https://lore.kernel.org/linux-block/20240430005330.2786014-1-ushankar@purestorage.com/):
- Moved max_segments and max_segment_size into the designated
  initializer

 drivers/block/ublk_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index bea3d5cf8a83..374e4efa8759 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2177,7 +2177,8 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 		.max_hw_sectors		= p->max_sectors,
 		.chunk_sectors		= p->chunk_sectors,
 		.virt_boundary_mask	= p->virt_boundary_mask,
-
+		.max_segments		= USHRT_MAX,
+		.max_segment_size	= UINT_MAX,
 	};
 	struct gendisk *disk;
 	int ret = -EINVAL;
-- 
2.34.1

