Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D58515966
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061725; cv=none; b=AaIP7PKBpb9RwZ37V2/30xs4YGtSkUDpet8p45zVTGQFkNW8X+vhI2Sx0QaBtjnEUnOA/BZp3lFLXHkR+GzrOaHShOIN7UEZXoj80Kb1s3bOZFxxEXEUm8ndY9BEbpu+v2amPc8GJxxlzDVOip56hr2WX8zpeqFLDz58BtMqk+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061725; c=relaxed/simple;
	bh=MnwjxHsRvv6B7ebV4jOBaeSUOdh4EX9DSXNEM3ODyYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ic5+laSnP2fJpgcO3f57TK5gVC8pu6Dqv4WvGcvFwUv7kpTuLvjDPg9HAN6Xtb/VOjoD0Q1THmL2+h1VyvDtXh99Xbrla3fFTw+npDriVQcRUk/pAJiRSXarAQ6oGXS24/v/mPSooGM7nHK0BrKY0wUlnQOx0iXCq9oOxKQzxQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cX9JLXY9; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cX9JLXY9"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469a3490bso3990731b3a.3
        for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 00:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790061723; x=1790666523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YwywWDLrZalzz03FLTpDP9g/tBAvW+/0SJTZpW2eZ4M=;
        b=cX9JLXY9ZzuzueGaBeNkOosGlWrBoNQ51gqgemit1k96eNxTZ7FNlFC9joRbJA+43Y
         jDZ0gf/RN9hg3NZUrjaSQg5KPCRV9bnbNMikkZQShOMz4kh7FOUZmHASy1XqLHSi+/f3
         zBuI+/q8xDZNPoC4gV2UIJWa39H6CIjUYwY4xggHJq+HGi8TQ6h7iYkt+V6s5sMSkKMu
         D9UYMFFZTaotJLC7rVJwfoy+PU/uIx8i3rMqs4xvanTo+Q9BzW9JNtgaj8ztdMu2MMDK
         H4wZnm7LyAhmc7Ys59ohClY9YRU6VHFLyoHHcllU8qjmqVkxj4O4ma+TDPUx/KJBNYnh
         dUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790061723; x=1790666523;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YwywWDLrZalzz03FLTpDP9g/tBAvW+/0SJTZpW2eZ4M=;
        b=j9qnzfC0o9b0zU+XTLeMMct0LIxTjSuN0w5kyltixySuRMnFYcZH6yZdHkqWvHzdY3
         JxO6HhiS3l5YKFfwP7CSd/1MSvkJUg36Qge6CEov75blRM9Ga8kbIua9VTUK+H5fvMcC
         2hweCjQ1a2jrGjOl+8zF8hL7nrfTiIR61KIGJzBGJf9dh4KHzL58Nm/LaokUEHasStQz
         9GdEVYynwqhxyrv1RQy6bPFrrt9QieqQ85Y7ZgJ11wLoJ93C3qU1lWr0i/syQe2IoW7w
         CDd232GyJOIsf2y4UWeeYIhs7g5PVBDnc5v3Bwjc2PyCV5chd62ncwbfDj7XvMWcB2yN
         twBg==
X-Forwarded-Encrypted: i=1; AKwUvBzEJzJzHqD6nTSpFmvlY39MOZfUfFxB/DDUQsxaMxnNpB0oTKDjZlrr3qANv9Te9BdOR+kkAM6/qRjQCw==@vger.kernel.org
X-Gm-Message-State: AFuF++m3xMmlGZ0BLDBCSdjEz2xNzv9K6ADhgQklWkCXoMBg6Ctrry3q
	GerbMkrK6Shna2KhI/y/R/h1jMahhkJBTnHMQ8iVYo5UIN8VuaYE7Ogf
X-Gm-Gg: AYBFou3qXBj3bM+n9zP7zSkR6LtNEIPJFYWU8sZBsuG1+wKuDwmjW3Hdba4vSVAPx1M
	VAewbRoxwWZu9HalaPADgYu77lJOm1UYE1FRrHhArHD/RvtJMbXmtUTKU0GnBevoTEai742G6XH
	ptqgOgeUDCTNSAU/96q2bkNm+G1GdvMOweRdkdTTTVsL8rjqQIV+OqENil0ujt4H0ln/zG+9wbb
	xKYYBkoxnOq04TQr51zyYHDX0oA0Me+GzSRtQQ+rAxR6vWTqsyG/f0rkj8vNavpW7iLICFfZLPU
	of3nDqHe3DM12t3CBHsVoYlGdqQazNB6rqSkAqHXBEggZa7T5R5jGtabCyFdigMUVz85uUwMEbY
	hiEQzR7g7DCJ6ptqVf8n+eeORNMGrwZYcCAPv12Sr6KLiJz8hya+K0kPGTWG4O9+HFVlgRPOQRj
	fTLBr1Htu3ba66MtdzgmR4rCb+SZS97/OEoh/Bjm+UfoPCHeeWp29+xOs5oyppaVspLCkLDemFF
	YSSsuBBXzoiMO/dN2KdQqIjSasCfHU6FTKMIpU=
X-Received: by 2002:a05:6a20:734f:b0:3dd:a007:cb35 with SMTP id adf61e73a8af0-3ddec82175emr329149637.49.1790061722924;
        Tue, 22 Sep 2026 00:22:02 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:b94b:d1b8:4cbd:b7e1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc756a317ccsm443117a12.14.2026.09.22.00.22.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 00:22:02 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH v2] xen-blkfront: unbind irq before tearing down ring and shadow requests
Date: Tue, 22 Sep 2026 15:21:55 +0800
Message-ID: <20260922072155.34625-1-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <arD7FHmbqJlLHmyE@macbook.local>
References: <arD7FHmbqJlLHmyE@macbook.local>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In blkif_free_ring(), the driver tears down the ring's persistent grants,
shadow request arrays, and shared ring structure (xenbus_teardown_ring),
and only calls unbind_from_irqhandler() at the very end.

While blkif_free_ring() is freeing persistent grants and clearing the
shadow array, the event channel interrupt (blkif_interrupt) is still
registered and active.  If an interrupt arrives from the backend during
this teardown window, blkif_interrupt() reads rinfo->ring.sring and,
via blkif_completion(), accesses rinfo->shadow[id].grants_used and
rinfo->shadow[id].sg.  blkif_free_ring() tears these structures down
without holding rinfo->ring_lock, and the handler only checks
info->connected at entry, so this is a real race resulting in a
use-after-free or NULL pointer dereference.

Fix this by moving unbind_from_irqhandler() to the beginning of
blkif_free_ring().  Calling unbind_from_irqhandler() first frees the
IRQ and synchronizes with any in-flight interrupt handlers on other CPUs
before ring memory and shadow request structures are deallocated,
matching the teardown order in drivers/net/xen-netfront.c.

Fixes: 11659569f720 ("xen/blkfront: split per device io_lock")
Cc: stable@vger.kernel.org
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
---
v2:
 - Update Fixes tag to 11659569f720 ("xen/blkfront: split per device io_lock")
   per Roger Pau Monné.
 - Add comment in blkif_free_ring() noting that interrupt teardown must precede
   freeing queue-related data.

 drivers/block/xen-blkfront.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 8dad7bf5f664..86f5dd3aced1 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1210,6 +1210,14 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 	struct blkfront_info *info = rinfo->dev_info;
 	int i, j, segs;
 
+	/*
+	 * Interrupt teardown must be done ahead of freeing queue-related
+	 * data, otherwise the interrupt handler can race with the cleanup.
+	 */
+	if (rinfo->irq)
+		unbind_from_irqhandler(rinfo->irq, rinfo);
+	rinfo->evtchn = rinfo->irq = 0;
+
 	/*
 	 * Remove indirect pages, this only happens when using indirect
 	 * descriptors but not persistent grants
@@ -1292,10 +1300,6 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 	/* Free resources associated with old device channel. */
 	xenbus_teardown_ring((void **)&rinfo->ring.sring, info->nr_ring_pages,
 			     rinfo->ring_ref);
-
-	if (rinfo->irq)
-		unbind_from_irqhandler(rinfo->irq, rinfo);
-	rinfo->evtchn = rinfo->irq = 0;
 }
 
 static void blkif_free(struct blkfront_info *info, int suspend)
-- 
2.53.0

