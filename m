Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793456187;
	b=Q7hUeMcGcf/4kC2d7D/6X89BogPjYVvdCK3ZCvlSzRGGu+B3TrpIvo6u/dEC+W8ETk9u
	 vak9MYkWitM83kvdtB+oTQ0emI8RXY7NM6ePQVjHZPCCnH05vyw3dBjhEiIj6d+r9Tg6o
	 jhpG36bEsDsMeO1IXDujhZumcrf27ome8mfBDvfeMfxARB6KkPgCoHUFn03lDmEGd/DFs
	 0uNfq4THW3sA8XZqsjGGZTvzrjjuXPdroKZfs8yqOZ0ia22ZI93TaFlsPytwW93K0lxlO
	 OMbtb6KVyHHR5/N4+9tv/VMgvd9U8oe9QBKJnK8lIVT1Wja/AFsnBn5ojMGX8iivJQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793456187;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=sDuG9VR8eyd2kiw/0gQU4/VEsS9FGxuDDjbhAy8dj8E=;
	b=shUDte3mC3n3St3j1sq5slK+1Wl/4mXLmDXO/RBLkYtdSvC18eckqY8mW2fYaWjb6XlL
	 8FvJZUzR+x6aahZIanomgmPDU5ErJtr/wqhamDy3PXHxN2+xa8xCowr9RB4/ysmtLfhbT
	 IdC2MIHzXsuxhKK22W11Yw59PCNtIvlnt7GX/4QzdXI6QppjLvCJ6J+jCSkpZbqEfZvUb
	 /WKtm+wCzxxQoEKqNbjf3M9vOSEW5I9Tf4/GbwcIyr7x1a97j2JOOyAdsuIOZDITM3kk7
	 LJftuLIE6j90Ub66yMFjNbEYeTDCDdFGRXyZIFji6qaQHOERW5HPV0wol1dvWuZBOPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125E1606A31D;
	Sat, 31 Oct 2026 14:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 125E1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jH0Ps0LpZz4yjjB;
	Sat, 31 Oct 2026 22:16:17 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 69VEG9Fv046667;
	Sat, 31 Oct 2026 22:16:09 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 31 Oct 2026 22:16:10 +0800 (CST)
X-Zmail-TransId: 2afa6ae5f82a342-03d44
X-Mailer: Zmail v1.0
Message-ID: <20261031221610676B5VoVcwMgkoDNVZH2bVDO@zte.com.cn>
Date: Sat, 31 Oct 2026 22:16:10 +0800 (CST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dlemoal@kernel.org>, <hch@lst.de>, <linux-block@vger.kernel.org>
Cc: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSB6bG9vcDogcmVqZWN0IG1pc21hdGNoZWQgY29udmVudGlvbmFsIHpvbmUgZmlsZXMgb24gcmVzdG9yZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 69VEG9Fv046667
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 31 Oct 2026 22:16:17 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE5F831.000/4jH0Ps0LpZz4yjjB

From: Shao Mingyin <shao.mingyin@zte.com.cn>

When restoring a zloop device, zloop_init_zone() checks that the size of
each conventional zone file matches the configured zone size.  The check
prints an error and then jumps to out_fput, which releases the zone file
and returns the value left in "ret" by the preceding vfs_getattr() call,
that is, zero.  zloop_ctl_add() therefore treats the zone as initialized
and continues with a zone->file pointer that was already released; any
I/O to that zone then dereferences it.

Return -EINVAL, like the sequential zone path does for the same kind of
inconsistency.

While at it, print the zone size that is actually compared instead of the
zone capacity, which may be smaller and only made the message confusing.

Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 65634a39b0bf..fb541969a47c 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -1161,7 +1161,8 @@ static int zloop_init_zone(struct zloop_device *zlo, struct zloop_options *opts,

 		if (restore && file_sectors != zlo->zone_size) {
 			pr_err("Invalid conventional zone %u file size (%llu sectors != %llu)\n",
-			       zone_no, file_sectors, zlo->zone_capacity);
+			       zone_no, file_sectors, zlo->zone_size);
+			ret = -EINVAL;
 			goto out_fput;
 		}
