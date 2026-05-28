Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5C82E2DDD
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 02:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779936538; cv=none; b=NETztN+CWaXmW5HebTajYr9CGSihVY0+aAmQ39z3/5gU18Utm1s884HZKrpNRAhNWk1oy3Cj5Q5hIvbpyehZdu+StGU9CykEcaNqxJbYs19eU7SFgBFqjXsWx1U95444AeKav64Ot9rJJCnnSobbAGgeQ7a3UoZqB0AehVrWijk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779936538; c=relaxed/simple;
	bh=4ILmcE2UVRvUA5w/bCMsuoZ6029LYusklIg66JvviMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DUY0+IISAPQ6eonJ53k3y8h10smJKv6QkkPlQ7qdJcdUV/oxu7CIbZ6n6HHBKWG5zGC2fTJZYWuvTry83OUiQg5eH/88bacaHvLnfDvcR79DYNuTngnviORBGLgEPXPlhjrsuvlzFu4fz9Cbv36J5QTfyGcKaA4S48E6tBZmpAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5U7ChHy; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5U7ChHy"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c796163fac5so9544603a12.1
        for <linux-block@vger.kernel.org>; Wed, 27 May 2026 19:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779936536; x=1780541336; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdZHIVC8VqdiF0LxnTx3Ka4A/RjNztw5bpRG2RMXPPI=;
        b=T5U7ChHyEZhxolxb0MDGheEdL2EnsmL94QT1nbR4/jfJv3CfiyzggSxIVzszeOVtdw
         IL9/fhUf1pHx2ZfARCbIRcw1fYW/smBXRp/1hqvNZ/2YbrDSjjXi2r1O+OYfsX3iE+lj
         Q7FdHlLkao4e6kEHZ9kKBrQzHXZMtu2BH3jJAWFgv+OzeSBY/PP1UZTJYNRJq1gMtxhk
         pNFk7Ytfe0lZMoI1RdZ+HUWf1PBFDDDwCdcjrsS1xGNo6XFbH82ZiGH7kpm/ri1wPUmY
         25TWRxYM3Csw+e/YrVkc2UYMmH7NTNiKCkpHbQbrDUHfsmwIohUb1lomLhje3CgO4pP3
         hIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779936536; x=1780541336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UdZHIVC8VqdiF0LxnTx3Ka4A/RjNztw5bpRG2RMXPPI=;
        b=VmrFXjhToHOa7+KRQ7YHNRlT4XSAdX3hQOteAfPVtcGJGxiWrz/rfYnRTrIrXBqanY
         /FhilfFkAkN/w3rKGH5ROng8HBFlMtEexfN9jkv06BxQmchMpiGob1IXtU6GtKxPgtDh
         bwfSo++QG8iNaDHINk/8CukTv5v5C2TH/h3LLqmvtEt/6VbsYIWR/WNPjHXRygK+m7bh
         77djcTNQ5PuFbA2kxLEfRPP7wmCdslCFYiE2+v2Av+41TGRv8e8lGW1BjC9fqoN5QdRw
         Gw4xNSQfzIQVgd4iC9GVM9Kf1YAclXXKueIV/qvX0oXsQyozr93r1GC/QtJ0lbtQIHAN
         ZtlA==
X-Forwarded-Encrypted: i=1; AFNElJ9BH49F9n+MypCyuloufBD5Jo2adGNfq66k3QhToO8kECh/5BKRlJ+xjfUBWRnzI/qhktPwgJHyDn7cxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4JDM2eFA/t3cD23Zw1RnSt4kRhhvUNh/hL4VqA7PAIblncM2y
	6mOnxWLD7+cKrUx6aMhRktc9IKbg4V8Anis8YIxLCpjv1Z1CIWKi3Xh8
X-Gm-Gg: Acq92OGGszjrckrbjSB9HBg/12Iwz/UAeTdXxeaLsVt0LCUU8Ab0mF7Bzr/8hszYTAC
	Y33ZFlLK9cWYx1W7LS+dyRIHrDU/BW2id7DL8RlvDcWV49rFKJePeYqv2Owgl509MW5fae7PM+U
	LA4Vh2AG2J1ldBjzS+re/LdgM+yen5EVqpLGmt5fefC0xZeDoqgk7TCs3JcSx5ElohHnOaMlqOr
	thCTHQNjUNvfzdn8/3ov8ElWnaSS7FE3/7bbqTCw3/pjSyErGPUp+x8GfZlNO5YZx5McZdJebwT
	5MvVLCb97OQPtc3Ao48XktQBtUTwjTtddKPKUWfHUjwX6nfqpcnj08G4KS8S9GCffmvv+DWMvPS
	AWJu4fIjqcFtzUxP8OP8cj1IIkSjFz4GA0YIOossFfFUeIuWXeZq1uVwT8Hb+cDuAdYJwRI44Ei
	3iZJanD7TqC/xDTl9u10uJEruohvCjBtotGg==
X-Received: by 2002:a05:6a00:238b:b0:835:5aa3:2dab with SMTP id d2e1a72fcca58-8415f1236aemr26567785b3a.6.1779936536313;
        Wed, 27 May 2026 19:48:56 -0700 (PDT)
Received: from [127.0.0.1] ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841f3cbcddbsm366877b3a.4.2026.05.27.19.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 19:48:56 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
Date: Thu, 28 May 2026 10:48:44 +0800
Subject: [PATCH v3 1/2] zram: fix use-after-free in
 zram_bvec_write_partial()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-zram-v3-1-cab86eef8764@gmail.com>
References: <20260528-zram-v3-0-cab86eef8764@gmail.com>
In-Reply-To: <20260528-zram-v3-0-cab86eef8764@gmail.com>
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Yisheng Xie <xieyisheng1@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Cunlong Li <shenxiaogll@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779936530; l=1542;
 i=shenxiaogll@gmail.com; s=20260517; h=from:subject:message-id;
 bh=4ILmcE2UVRvUA5w/bCMsuoZ6029LYusklIg66JvviMc=;
 b=KynYLGaGfZewjfo8RGU3mhyIy/vlwWxgy9oFeOCxoXHK2kYgK2sfLrwnBPEM449prqRHxV4Ff
 gobRxeZpMNpCc9MhH6mBms/BlpM1EFCtEHdF4CNUFQvLFVvO0SNxIr4
X-Developer-Key: i=shenxiaogll@gmail.com; a=ed25519;
 pk=SKFifnqPdsvsjuhUiq+Y9vtCdhyZ/LrRcfYn8eRq6AE=

zram_read_page() picks the sync or async backing device read path
based on whether the parent bio is NULL.  zram_bvec_write_partial()
passes its parent bio down, so for ZRAM_WB slots the read is
dispatched asynchronously and zram_read_page() returns 0 while the
bio is still in flight.  The caller then runs memcpy_from_bvec(),
zram_write_page() and __free_page() on the buffer, leaving the
async read to write into a freed page.

zram_bvec_read_partial() was switched to NULL in commit 4e3c87b9421d
("zram: fix synchronous reads") for the same reason; the
write_partial counterpart was missed.

Fixes: 8e654f8fbff5 ("zram: read page from backing device")
Cc: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aebc710f0d6a..b23a8bbb687c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2333,7 +2333,7 @@ static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
 	if (!page)
 		return -ENOMEM;
 
-	ret = zram_read_page(zram, page, index, bio);
+	ret = zram_read_page(zram, page, index, NULL);
 	if (!ret) {
 		memcpy_from_bvec(page_address(page) + offset, bvec);
 		ret = zram_write_page(zram, page, index);

-- 
2.30.2

