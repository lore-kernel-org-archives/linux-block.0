Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9914229A9FE;
	Tue,  2 Sep 2025 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816792; cv=none; b=jznNXwX0xUmTEB2DoZWQzw8X/cotHNPQRgo40X33xVlZfr2rc0OKqdVWWUcZEcUFjilQIZWlI5Q/VPwV7m2fvfE48HktVGQiDSRooLy4/9fjinN0rAzOuDWLC5o0IP2jnwpOKD7DGwuV4U/+ocx0SQnOKmGnifDwXwRdQmP+8H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816792; c=relaxed/simple;
	bh=60160ZMeQ4Snti2+fYThbkKZXQg2sw13t3seEmEuNLI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=VPUqLvlNINYGuFBod4bMtro8POukNLSuc8eRYpzrlFxoy0RripXmgRST3hq7xk2djNnMXrozQ0r/Sz3Rc0UXEHEHnYxA8JjsbYWfHU8Zxz6o4DjC6s/8xuxzXNwq2zfVPPssAje9gIuE8BWiHJ8b1VvD9BFiukSIfZb28NHXUuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=zKbLt9hn; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="zKbLt9hn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756816784;
	bh=UMVGkCSvy6khHMWXG0E9TSxl0qFXWOuW3mLWRkGeFPI=;
	h=From:To:Cc:Subject:Date;
	b=zKbLt9hnUleVmJcD1Fq9ijWOX6gFDCZhWauw9ZIK39t8eOgVBihc8ccycgbB75a/a
	 0qKhVh7QT8R2G2bJhwqJ3k/UQ5lrv6hs3At4FyzuMwIr++Ydz6krwLiHCEO/oHZiNX
	 SEcIdPMzkeSEOd5CdzfHJZVss22nGgDM3zWqFRRU=
Received: from SSOC3-SH.company.local ([58.33.109.195])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 9DD970A9; Tue, 02 Sep 2025 20:39:29 +0800
X-QQ-mid: xmsmtpt1756816769td5u3ns8m
Message-ID: <tencent_E4C0C41415118E05F82833A1453A097DD10A@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JuKAL4gsmG+KZNdlsX8GYrLNwDW8A1faojRRVMJFfukZFhqqSaxw
	 a+UqpvdzGYhgGRQhCKIyt/toKyFHdPLHjVSjpz8cnKs0bnAvAS8FiRn58ZgGsCDv6N0x47BXhCPQ
	 Hjg2ChhWpO7+usGMqFpu8Kb0pqvVvGfiu6FvkzEr2VeOuFpbOCijyDhOoM9a9n+4+KUrghFnsSxb
	 HXkGyfAb5cSN976UCqdy64LZ9vhwtxX4Hrm9CrEpPY+g6v4WkYXFWY+1M47R8dUqfaMoopgpAlnk
	 mJlgBd+j49CBJGtdkMFGSyE42csgDv6tYXgZ7iZv95HMlMuvF7eC3QpcRqu/pTN6ZiXKxRhnjmb+
	 sOyJOX5BYY5n02vEgdUSUWBCBQbWDqtMatElK6Pymi/3jTs2V87IRAv4jmnmdEpA7tucQdFTay5m
	 l1fJQ42ubU6LsziT7JFoyzU9ot/GDjPq8Kdhpog1bKXT/MLlxsNui1cgt5CLCLq9WeuPD0cXESmS
	 vBCWPdC5w01BcLtxfFOg9dfhXf1PYqVLaFENj9nKp0MUbY6phC1GoZRo3CL1HkxQSfTcTprDzT+h
	 5qsagS6dKvij3NTIh+2K7p2vi+gNnxr42Z/jlGKDx7z5TNwMY/GIC8Zz5yCE1bo6Pagy2rXkcETX
	 +4MfSEQv/WsN9cCroMSYkldoEuKksZ5xQoBdk9rPjzYZn7woE428qCiJVcRpbuYoEhdGpgsb2WmI
	 dhwQqKT9nx0hhf05+9XVqy6kJk6Tl9uhNKHJzsdXO965e1QcDID9YRdqf1oAnVNshqqfvjP9P3Rr
	 68ng1IPfSiAV1AF+CUGd+Sk6Ufiz3TX9xgabHP+380BzUAJfkhRC74lvjlPGTbG2tNGSiZYDk/g1
	 YKirYvi2CVAdCSoeKNpDoiqvgcphmcyOdYa0S7EbEDnMMA52VPzkTTW29+Do7rrOkmoHA+DSoz/P
	 qehwKtrk45nFa9BCZ179T553/9EbYwHezG9LHeNVJWd89nTo5DdV8f0XNPOIIUOPwmsOV4Xx2dYT
	 EElA5apNQq8Fc5oBUSCnQqaSxBeJaOtUJISjXmEmRafCjfckX+14eQKaI87rbbDdrAnfqvsQ==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: gj.han@foxmail.com
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-kernel@vger.kernel.org (open list)
Cc: hanguangjiang@lixiang.com,
	fanggeng@lixiang.com,
	yangchen11@lixiang.com,
	liangjie@lixiang.com
Subject: [PATCH] blk-throttle: check policy bit in blk_throtl_activated()
Date: Tue,  2 Sep 2025 20:39:24 +0800
X-OQ-MSGID: <20250902123926.3674323-1-gj.han@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Han Guangjiang <hanguangjiang@lixiang.com>

On repeated cold boots we occasionally hit a NULL pointer crash in
blk_should_throtl() when throttling is consulted before the throttle
policy is fully enabled for the queue. Checking only q->td != NULL is
insufficient during early initialization, so blkg_to_pd() for the
throttle policy can still return NULL and blkg_to_tg() becomes NULL,
which later gets dereferenced.

 Unable to handle kernel NULL pointer dereference
 at virtual address 0000000000000156
 ...
 pc : submit_bio_noacct+0x14c/0x4c8
 lr : submit_bio_noacct+0x48/0x4c8
 sp : ffff800087f0b690
 x29: ffff800087f0b690 x28: 0000000000005f90 x27: ffff00068af393c0
 x26: 0000000000080000 x25: 000000000002fbc0 x24: ffff000684ddcc70
 x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
 x20: 0000000000080000 x19: ffff000684ddcd08 x18: ffffffffffffffff
 x17: 0000000000000000 x16: ffff80008132a550 x15: 0000ffff98020fff
 x14: 0000000000000000 x13: 1fffe000d11d7021 x12: ffff000688eb810c
 x11: ffff00077ec4bb80 x10: ffff000688dcb720 x9 : ffff80008068ef60
 x8 : 00000a6fb8a86e85 x7 : 000000000000111e x6 : 0000000000000002
 x5 : 0000000000000246 x4 : 0000000000015cff x3 : 0000000000394500
 x2 : ffff000682e35e40 x1 : 0000000000364940 x0 : 000000000000001a
 Call trace:
  submit_bio_noacct+0x14c/0x4c8
  verity_map+0x178/0x2c8
  __map_bio+0x228/0x250
  dm_submit_bio+0x1c4/0x678
  __submit_bio+0x170/0x230
  submit_bio_noacct_nocheck+0x16c/0x388
  submit_bio_noacct+0x16c/0x4c8
  submit_bio+0xb4/0x210
  f2fs_submit_read_bio+0x4c/0xf0
  f2fs_mpage_readpages+0x3b0/0x5f0
  f2fs_readahead+0x90/0xe8

Tighten blk_throtl_activated() to also require that the throttle policy
bit is set on the queue:

  return q->td != NULL &&
         test_bit(blkcg_policy_throtl.plid, q->blkcg_pols);

This prevents blk_should_throtl() from accessing throttle group state
until policy data has been attached to blkgs.

Fixes: a3166c51702b ("blk-throttle: delay initialization until configuration")
Co-developed-by: Liang Jie <liangjie@lixiang.com>
Signed-off-by: Liang Jie <liangjie@lixiang.com>
Signed-off-by: Han Guangjiang <hanguangjiang@lixiang.com>
---
 block/blk-throttle.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 3b27755bfbff..9ca43dc56eda 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -156,7 +156,7 @@ void blk_throtl_cancel_bios(struct gendisk *disk);
 
 static inline bool blk_throtl_activated(struct request_queue *q)
 {
-	return q->td != NULL;
+	return q->td != NULL && test_bit(blkcg_policy_throtl.plid, q->blkcg_pols);
 }
 
 static inline bool blk_should_throtl(struct bio *bio)
-- 
2.25.1

