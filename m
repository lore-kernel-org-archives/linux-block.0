Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CAF3CD8A8
	for <linux-block@vger.kernel.org>; Mon, 18 May 2026 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090184; cv=none; b=eQPi3GG4++3eW7y30Zs0EvGB1yGUsKPndoicPpt2wUqlhwpNIGZEVvd2k6g+Z7W2vxjPXgH58FPDxlyei+UEdavIXWLOB7OgTaAJpOAL1Q8tu/+m3K9OIcTHju5vcC1GUOn78krnye5QVpHh0B7gHFuWfCyUF5w3M3JnVmdAHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090184; c=relaxed/simple;
	bh=eSueVGjl9kpfrC/9O9pfTUZGg3av7Bo0jfk9t85JoS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bwbZ/jlhcPVIxxmG20c58eXMuOnwgag6vvH35g41I71m1UWqkiv4UhQPPA6HguLlRa7dIv+0d1vbL6ly6lKHBVjHiyM23MQdSMb0GGjzK0yi6aBJEArPw/H/J80wjR47JjhhA9ToUjzTHywzOVkS25Q79Cseu4sYkCeXfyhzxDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pIdOD8Se; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIdOD8Se"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-365f4329725so138280a91.2
        for <linux-block@vger.kernel.org>; Mon, 18 May 2026 00:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779090182; x=1779694982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k8yME935TMtR1RQ2fzR/XnTzQNsnJA37aJzNpTqM9xk=;
        b=pIdOD8SeVbL7F/gl0FTHJs5dVrgwzJK2nMb96IgsgXYxy+BonXYiRNcJPV5MuiEhYF
         REIlnS150rd2ZuRcRh8belDH5Fh0z+XCOGdKzLCkQjS28MCOaS54DRYEC3B/6CnnaOvI
         2GACY3w+88Z2c+hHlhklHrOMf++a0jEXBJKy5OVcd6iNplokTX/nDHfs+nTEV/KydS4I
         uXvQc4grdSZ6e6JtMEPzAp3miQaQjfdfxZJLwwQj0FZGwjqGo0bX2iFLTmmbtL+30TO3
         oN4TPZ8+Zd0NTENU7WLVu7HEXvzdwC9JaGNBEEtQ1Wi6Z87PLvwSggoQY5XQr2W025Eu
         rW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779090182; x=1779694982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8yME935TMtR1RQ2fzR/XnTzQNsnJA37aJzNpTqM9xk=;
        b=UKk0FTPBZMU4xdW2d3gKTe6wt6kzrXinWxJf0jjBZ+HXUDaN0gUCwsNtFkTxVusc4t
         10H1jx8ocu8HfcNbk91HLjQddEf0tYR+dP9ktZIxDj5w7ZLFxdikKWMBOHfqME02Gbrf
         KYIP7HfVNTm1zsx4iwjlblmn/b1SVk60ajzi0+ApwkyRp0WAxYcI1HVlaxxRVpsEc7k/
         SF4r3kwlwjXk9JNL6iHMo/a3016z/g/Z61Zq373/+1cqz+oFooI0j3HGxCARFJRA1YPZ
         T1IZY7b6Dv9mjjprDK4eQ8gFVRYd7NmS66Z7X8OYHRg+Sz6ywYEbs7yi7pm7dM1e7TJP
         RDzA==
X-Gm-Message-State: AOJu0Yyf8Wd5iUTJmgMOvRKBseSZbqAWM/kron90NV5qBQiv0rKyGOMX
	louu8cxFd4IfAV2WLym/0Z6R32iBo7nkPF3nS+0WSamKXoJ9kX6HeStipP5ccG/6jbY=
X-Gm-Gg: Acq92OHau8MEKz4CaWI6BE1zV1X9lIAHdXV5kjFl4Va8kIGDOu04YQegHawpMRrP/FQ
	pTpC/juNyAqkvu+e/cHSX+VryMudQYPURMPXUBd4JjqNfIw1QabMvOmVpdqlFI09fpRp21S5L3w
	Aelf9fX5Yyw3ax7qxkPvTiyzt6f0ReKTiUgT6pK6dmejI0J2YvI56pfeJBjoZu1sihdFyFypBui
	YZOH/rvx9rUAsp0iQR7+Ts7bom0NMuR8C6uqBWP8DDmVnd4hzhizML6fIteMe2VCWLYJWGD43kI
	3NAgaaE+qc1URozfBrUX0/i2XJj2AEtLmyjYlREzn7xZYayTZpDnX3thi1HlpOzmdm1syzmbDfU
	SccjTcZvs3P62vDJK1pdpcnZiFb6VTdK5aldkG4rMusP2B/60BQTWWTtOIjKV/xi0hBUZXy5p1r
	WSPxyg8mQxv+NcCGaa3Pa0jl3Kdnf2QEIei8jLbHhMrgi6zKj4C8kZmU8sEy89Zu0sp1lwiIMg1
	GSQlNFCNR+MywuKKSNPAOZUHZpZXPFLnw==
X-Received: by 2002:a17:90b:4d0d:b0:368:44d:bbac with SMTP id 98e67ed59e1d1-36951ca93d8mr7586429a91.6.1779090181689;
        Mon, 18 May 2026 00:43:01 -0700 (PDT)
Received: from localhost ([240d:f:a5c:fb00:b9d0:5976:9793:153b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517a8612sm10167726a91.12.2026.05.18.00.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 00:43:01 -0700 (PDT)
From: Aaron Esau <aaron1esau@gmail.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aaron Esau <aaron1esau@gmail.com>
Subject: [PATCH] block: fix dio leak on integrity metadata mapping failure
Date: Mon, 18 May 2026 16:42:58 +0900
Message-ID: <20260518074258.1600307-1-aaron1esau@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __blkdev_direct_IO(), when bio_integrity_map_iter() fails on a bio
after earlier bios have already been submitted, the goto fail path frees
only the current bio and returns the error directly to the caller.

This is incorrect because the fail label does not decrement dio->ref for
the current bio, and does not return -EIOCBQUEUED. The in-flight bios
each hold a reference via dio->ref, which was incremented before their
submission. When they eventually complete, blkdev_bio_end_io() decrements
dio->ref but it will never reach zero since the failing bio did not
participate in the completion mechanism. This permanently leaks the
embedded dio/bio structure from blkdev_dio_pool.

The trigger is deterministic: a multi-segment direct IO with integrity
metadata where the user-provided metadata buffer is too small for all
segments causes bio_integrity_map_iter() to return -EINVAL on a later
bio after earlier bios are already in flight.

Fix this by handling the integrity mapping failure the same way
blkdev_iov_iter_get_pages() failure is handled: set bi_status and call
bio_endio() to enter the normal completion path, then break out of the
loop so the function returns -EIOCBQUEUED for async IO.

Fixes: 3d8b5a22d404 ("block: add support to pass user meta buffer")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Esau <aaron1esau@gmail.com>
---
 block/fops.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index bb6642b459..39280d761c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -239,8 +239,11 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		}
 		if (iocb->ki_flags & IOCB_HAS_METADATA) {
 			ret = bio_integrity_map_iter(bio, iocb->private);
-			if (unlikely(ret))
-				goto fail;
+			if (unlikely(ret)) {
+				bio->bi_status = BLK_STS_IOERR;
+				bio_endio(bio);
+				break;
+			}
 		}
 
 		if (is_read) {
-- 
2.54.0

