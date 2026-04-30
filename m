Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3952475D0
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 04:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777523313; cv=none; b=VNrrYAN/Urxx8cOj3OfpKLl9bYYIqoYUWud33Ubi3l/e8ob3tb4CgCQtRKsNbrvowusuTH4VAYOdyUwpr08AY/ehuFU2JpH4R9Y94kwJZZvir9DqNE8cYes6jzunBRdNsJfAnmxac2Vq6FLZdb9aPO4I8gU/x7HOChG5OmvCq/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777523313; c=relaxed/simple;
	bh=T5+gGKdSpuZhUfkSn7rO4bf4xdJPJqZzx0aVM2H2T7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BOyguhAI41Fcgh9lwbVgtmHj+WAAfU+ptYff0gfcUjPSHVsKZypmymEX0ZiNSUzaikPOKy8azn8qhvDLgSaox3siHDIcADVJz0J/uQRoCmI+/1WRbSuMoHrj/QFWer3vuVVflR/WU9K//e1Cw0f65dJFh4YF2b2XsGUOxUmWqfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZey0UJ9; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZey0UJ9"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3614826eca4so432218a91.1
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 21:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777523312; x=1778128112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uAr+aUBEOsJn73lAMWt8blqY6wZFQ8Uqh4fIytefAh8=;
        b=QZey0UJ99YK5IsBbTszKJ6+3E3KYEZqExKwFODhj4DXp0hAaJSgEMBXdckS5yV5Jpd
         sT5j0yzhmy3MUimQNO3L8UvyJ08KWG73e2RQJ6AHybvwL5xsdn1I9z7ReGU1bDpEhjFr
         Nb7hjN9y2wU1zqJkMptuEDHHuokUS7BNkYd0Nl+zM3GEB1amhZYVpTwDBxB9wiNnhb3R
         T3sjqQVJ9We3J/XzaPbvT4bH4jUXSiFywRKZg1FP5LNWivPCjqgwDrDEKQbe94n1h0cs
         Tvg9o4RiO6Vq+Tpdm5gCf3b9AczjcEFAvmNT5eLns8sjOD3uGku35hF4lFBD8e1uP2qM
         khzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777523312; x=1778128112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAr+aUBEOsJn73lAMWt8blqY6wZFQ8Uqh4fIytefAh8=;
        b=dbYttWPEBBzE3VaJ/Tf9jDDkFrvmCURF1IDTtRHekN/bA0OS6S+vDjh7XaGNr4cV2u
         /WQKdx5kVnNY2Hd++nUVQh8f/XxtckHTG7XflrgalZ0GLtUrzpMJkpc/qRB96EiItNOD
         hktWx753XmYAKv5yLz243V4zvHv/9cpIhHIjubIbcoewdRaU2uvYcY3Wzbvn+mOTYX+n
         WvCw16hA+Tur9sIRgHDAPBvxaiGdpCq2n8G+fGepcxIR1seZ7TQILrbX63Yn2TOEowg7
         Ew9iI78HsxHNaixxy3YORex5OwdH5r4wnXsdd5WZfgLoU7f5ZwLk6kxwnovTyxmj8nEo
         7QDQ==
X-Gm-Message-State: AOJu0Yxpa5w5+Ydbax9HQ9pswwT7dsGsA5hK/4ZAqbYuE0oLEnfhq7X6
	AqlbjhGVRFHS4f/2n2tYRUrg8O2Wer7uaLx1hEdtXwjvJwtX9RTR7lpe3W6LmB0ST/KI/d3HGqU
	=
X-Gm-Gg: AeBDieso5ZXXbV53Qn/Gll4zmcTRhHJ9WvY5N3eyn/uEu2/8Vlgbs4V2c6cliWWKam8
	rNBd2CKQyh8Sfg60XpCIFsR6Qcy2YZGCUKgCtIqqgBX9MqPVk1lWKUWW3nIsI+wsIgsEirqEr4c
	gdAp6dBaZqae2RXu5XpeBIBvCrjq/u0MbMTfqmRP4OnskZByY0T7YBoNy/NBCDHIG4AaS15yr3z
	v4JyOBkQg74P5Lt9C16f6Y05anwcfEnvmDOnZe3/Al1k1arlFvWn7tTrzUgHQxADjK/hryEGs4e
	E5ZR2OQtB1ckDvf2E7VXygsOYYcHP+wqtoDACPHO805kyaX8rp8SWthnTvR8vsDSRyvRShOJtty
	1kTUafJVciz+KTKkKuQLZ6UQHkIk0b2PGSHOLDC8Q/LoXy/4YXW8iCCGtytl2HXt5KwxiOkmvxB
	088VdThVT1SQEMjq5zMK2bE46cNrz2GP0NdaK05aoqYA6QH0/M7fbkdH8Y
X-Received: by 2002:a17:90b:224b:b0:364:6f27:43ea with SMTP id 98e67ed59e1d1-364c329dbb7mr1374939a91.21.1777523311979;
        Wed, 29 Apr 2026 21:28:31 -0700 (PDT)
Received: from LAPTOP-1HUHJV8R.localdomain ([2408:8642:893:d2da:950b:8595:5fb6:24f3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bd5d745csm691118a91.4.2026.04.29.21.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:28:31 -0700 (PDT)
From: l1za0.sec@gmail.com
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: blk-mq: fix UAF in blk_mq_tagset_busy_iter
Date: Thu, 30 Apr 2026 12:28:21 +0800
Message-ID: <20260430042821.29120-1-l1za0.sec@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haocheng Yu <l1za0.sec@gmail.com>

A KASAN: slab-use-after-free Read in blk_mq_tagset_busy_iter is
reported by a modified Syzkaller-based kernel fuzzing tool we
developed.

This problem is caused by a race condition between
block/blk-mq-tag.c/blk_mq_tagset_busy_iter() and
block/blk-mq.c/blk_mq_realloc_tag_set_tags(). In
blk_mq_realloc_tag_set_tags(), set->tags is first freed, and then
new_tags is assigned to set->tags. However, this process is not
protected by synchronization. Therefore, if another process reads
tagset->tags in blk_mq_tagset_busy_iter() between these two steps,
it will cause a use-after-free read problem.

To fix this vulnerability, first save the old set->tags. After
updating set->tags to new_tags, wait for the reading side to exit
before releasing it. This avoids the problem of tagset->tags being
directly released while blk_mq_tagset_busy_iter() is still iterating.

Signed-off-by: Haocheng Yu <l1za0.sec@gmail.com>
---
The full reproducer is attached here:

# {Threaded:true Repeat:true RepeatTimes:0 Procs:8 Slowdown:1 Sandbox:none SandboxArg:0 Leak:false NetInjection:true NetDevices:true NetReset:true Cgroups:true BinfmtMisc:true CloseFDs:true KCSAN:false DevlinkPCI:false NicVF:false USB:true VhciInjection:true Wifi:true IEEE802154:true Sysctl:true Swap:true UseTmpDir:true HandleSegv:true Trace:false CallComments:true LegacyOptions:{Collide:false Fault:false FaultCall:0 FaultNth:0}}
r0 = syz_open_dev$ndb(&(0x7f0000000000), 0x0, 0xc0400)
r1 = syz_open_dev$ndb(&(0x7f0000000000), 0x0, 0x80040)
ioctl$NBD_SET_FLAGS(r1, 0xab0a, 0x9ad)
socketpair$nbd(0x1, 0x1, 0x0, &(0x7f0000000080)={<r2=>0xffffffffffffffff})
r3 = syz_open_dev$dri(&(0x7f0000000100), 0xfffffffffffffffc, 0xc8503)
r4 = syz_open_dev$ndb(&(0x7f0000000000), 0x0, 0xc0400)
socketpair$nbd(0x1, 0x1, 0x0, &(0x7f0000000080)={<r5=>0xffffffffffffffff})
ioctl$NBD_SET_SOCK(r4, 0xab00, r5)
r6 = syz_open_dev$ndb(&(0x7f0000000240), 0x0, 0x12100)
ioctl$NBD_DO_IT(r6, 0xab03)
close_range(r3, 0xffffffffffffffff, 0x0)
ioctl$NBD_SET_SIZE_BLOCKS(0xffffffffffffffff, 0xab07, 0x1)
ioctl$NBD_SET_SOCK(r0, 0xab00, r2)
r7 = syz_open_dev$loop(&(0x7f0000000040), 0x1, 0x200)
ioctl$BLKPG(r7, 0x1269, &(0x7f00000001c0)={0x1, 0x0, 0x98, &(0x7f00000000c0)={0x5, 0x2, 0x10}})
close(0x5)
r8 = syz_open_dev$ndb(&(0x7f0000000000), 0x0, 0x100)
r9 = syz_open_dev$ndb(&(0x7f0000000000), 0x0, 0xc0400)
socketpair$nbd(0x1, 0x1, 0x0, &(0x7f0000000080)={<r10=>0xffffffffffffffff})
ioctl$NBD_SET_SOCK(r9, 0xab00, r10)
close(0x5)
r11 = syz_open_dev$ndb(&(0x7f0000000000), 0x0, 0x100)
ioctl$NBD_DO_IT(r11, 0xab03)
r12 = syz_open_dev$ndb(&(0x7f0000000040), 0x0, 0x0)
ioctl$NBD_CLEAR_SOCK(r12, 0xab04)
ioctl$NBD_DO_IT(r8, 0xab03)
socket$inet6_tcp(0xa, 0x1, 0x0)
syz_open_dev$ndb(&(0x7f0000000000), 0x0, 0xc0400)




 block/blk-mq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d626d32f6e57..4357625a512d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4738,6 +4738,7 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 				       int new_nr_hw_queues)
 {
 	struct blk_mq_tags **new_tags;
+	struct blk_mq_tags **old_tags;
 	int i;
 
 	if (set->nr_hw_queues >= new_nr_hw_queues)
@@ -4751,8 +4752,10 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 	if (set->tags)
 		memcpy(new_tags, set->tags, set->nr_hw_queues *
 		       sizeof(*set->tags));
-	kfree(set->tags);
+	old_tags = set->tags;
 	set->tags = new_tags;
+	synchronize_srcu(&set->tags_srcu);
+	kfree(old_tags);
 
 	for (i = set->nr_hw_queues; i < new_nr_hw_queues; i++) {
 		if (!__blk_mq_alloc_map_and_rqs(set, i)) {

base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
-- 
2.51.0

