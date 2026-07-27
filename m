Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524A524A074
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 04:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785125275; cv=none; b=fMPALX9a1/GQoBl5+Jmcn+gfEdCZSariYNZ0G2TavnwKziG4Ag6rtqszQJE+7nd6RXoGpfu+7ldLgcfpjFM1A1b49Vrb6tNQzCo0Gh7+fwrdw3wuzLBXXbsnAp/wyqypAC6cOdQs2YLz2vqGRX2HkS+RJSQe5a6hrFZWy3sNavM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785125275; c=relaxed/simple;
	bh=Gxp3Un4AZGgro1b7wJhIj9cUYRY3ZZI3yEbM0aXczz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pUOYe6ht+OsFD4K5wSq5/U3hcqxSz4GqS0nY4WaQb5lhfXZ4IkliQedggD/QMTkebcmOSmPATkpKEcUiHvAj5S5IrvMuc+crRkP+uV75ZXgJxWZSW/qfbs0C3A3VhrhGAmAhEHIqDWcYNG9GS6hYRnhKMaDHTMRT0OYx7D7bq/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=En+3+cYH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En+3+cYH"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cf50c6f235so26855205ad.0
        for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 21:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785125273; x=1785730073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=86uk4Z2sGa/3sM3sJKSYmohCJPc9h2SJlL31GgQy+No=;
        b=En+3+cYHN4RCisczuYSD8uDNcyN6CRfIWxFRSXzGxnQwuIJFcqHjaCxgT6HI8GvkeK
         xeProrRxw42d/B+pqnBf3um0kd2GPwn7TrflTaiVty5D4B55KwHCbdZiKJcQcsu8L4uC
         EvsZmL7cHJlrTjrlMt5sD8fyy3u4tlRVRRldUlfxfGjaYmHi0sgJV16himEYyz3QW+VD
         4U92cgpqJOQgd4Krim85VAWqWL/cTzRFppYhQrKLeCDTHW32vSguylDxOYMLZ9qABoaK
         nGAOa9p8Dkq9nabU3pm/Z4TqcsGkyZqYNdUvDc8IhBSkpljw+YAaaQopzR9tOslTMrnv
         42eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785125273; x=1785730073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=86uk4Z2sGa/3sM3sJKSYmohCJPc9h2SJlL31GgQy+No=;
        b=LPlnwyKryTGe0O9n8Mi1BsNdLBqz3yf0DF/0xib3qhVEnYiloj/PyGa+Myq1e6i5hv
         npQpY9IyVz8hwMJoIjf30lv7wggxCclx4Lwufy24i3nD3Q/Za/jDjIwUmTwiK8bYVGKG
         8jgGL3+NmhMj732K31MpKTO2ksfUIQqliceHQ5225rtisS4/xy0RRS65jtkN3M0hVPdw
         Q7yUS4LiMcuGT40kWC1O2NSvRHesY1lvU2tfrcMkIvMzdOH5i3a0tV7F83Q1UpixMyj/
         q11NvWTBoULfGVHDduKKMVTRjvbJNHDUtZWNyVabUJtewWwMqLwYhRNKzKMvXCNbDVxO
         dx7A==
X-Forwarded-Encrypted: i=1; AHgh+RrFPkEhvUpl09fQhGZQHKk/Ww93mHdKNvJlJ7tNrm/oRvRJ1P6udLx+t9dqG4izDc/TvmuYGPwpxpjprg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwS8U458A7qDiWq/CpE1zPNuVm12FPE0ossgh1L05V47CrmoFhZ
	hCDCdK0lU7SFZ1Flunjg2Vne329eZuc7v/NMfpoTbH9AZYpjMHwzdzMf
X-Gm-Gg: AR+sD12ieFng40fDpPplP5yJyw7h4BcusQBB+UazfSE2XFbuKYCSSQO9ivbueL36OLi
	7eWU0p6C4VQ5VqvyBcQTQeOCvKHob9jdLhWQvDQhw04Mz/BDwEi6YgzDkOv3dNhQA8zFhl7nFfv
	F9djQMrp0K9fSkDOfEsriMA17xAnKQpJQ/yZxaZ3BvpRnbItRzvq8Xyt09XJ94ttsJPwZgJCWv5
	Z5gQebGlAeCbmw23CgdHc2TvTca8RVDANVpkP9/Tzd5DHY/kE2M6JPD8ZS0+9rnGsai5h1degAb
	cs98iV6MmSqFCNDmTJyZJpqy6Ok0vLvYeplp0e8WDLCTd+SnQbmTLQTsTY1df7nksYPgTcAUAo2
	dXMGd6Ctsce00b4/RZr6khyXzS9cG7SHgJMZleFMr1MBDwWZD5j15K4Q+sP03iz97pdbpzbTumY
	3sUuo=
X-Received: by 2002:a17:902:c40a:b0:2cc:61e8:5fba with SMTP id d9443c01a7336-2cfde866e46mr72199415ad.32.1785125273513;
        Sun, 26 Jul 2026 21:07:53 -0700 (PDT)
Received: from kali ([58.187.6.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cffa9243fcsm5645825ad.64.2026.07.26.21.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 21:07:53 -0700 (PDT)
From: Nguyen Le Thanh Tung <nguyenlethanhtung555@gmail.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-efi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Le Thanh Tung <nguyenlethanhtung555@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] partitions/efi: reject GPT entries with starting_lba > ending_lba
Date: Mon, 27 Jul 2026 00:07:27 -0400
Message-ID: <20260727040727.1910700-1-nguyenlethanhtung555@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

is_pte_valid() checks that both LBAs of a GPT partition entry are within
the device, but never that the entry describes a forward range:

	if ((!efi_guidcmp(pte->partition_type_guid, NULL_GUID)) ||
	    le64_to_cpu(pte->starting_lba) > lastlba         ||
	    le64_to_cpu(pte->ending_lba)   > lastlba)
		return 0;

EndingLBA is defined as the last LBA of the partition, so a conforming
entry always has StartingLBA <= EndingLBA.  A crafted table can invert
the two while keeping both within the device, and efi_partition() then
computes the length as

	u64 size = le64_to_cpu(ptes[i].ending_lba) -
		   le64_to_cpu(ptes[i].starting_lba) + 1ULL;

which underflows to a value close to U64_MAX.

The "extends beyond EOD" clamp in blk_add_partition() does not contain
this, because it tests

	if (from + size > get_capacity(disk))

and from + size wraps for a size of that magnitude, so the sum comes out
small, the clamp is skipped and the partition is registered with the
underflowed length.  From then on bio_check_eod() is evaluated against
bdev_nr_sectors() of that partition, i.e. against the bogus length, so
I/O submitted through the partition device is no longer confined to the
partition and reaches sectors owned by other partitions of the same
disk.

This was verified on 6.8.12 with a crafted two partition image: the
inverted entry is registered as a partition of nearly 2^64 sectors
with no "extends beyond EOD" warning, and BLKZEROOUT issued on
that partition overwrote known marker data belonging to the other,
unrelated partition on the same disk.  No privileged step is
needed on the victim side beyond getting the table parsed, which happens
automatically for removable media on a typical desktop.

Reject the inverted range in is_pte_valid(), the single place every GPT
entry is gated on.  The code has been this way since the beginning of
git history.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Le Thanh Tung <nguyenlethanhtung555@gmail.com>
---
Compile tested on 6.8.12: `make W=1 block/partitions/efi.o` produces no
new warnings.  The behaviour described above was reproduced on that same
kernel with a crafted image.  is_pte_valid() is byte identical in 6.8,
current mainline and linux-next.

 block/partitions/efi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 9865d59..000219a 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -461,7 +461,8 @@ is_pte_valid(const gpt_entry *pte, const u64 lastlba)
 {
 	if ((!efi_guidcmp(pte->partition_type_guid, NULL_GUID)) ||
 	    le64_to_cpu(pte->starting_lba) > lastlba         ||
-	    le64_to_cpu(pte->ending_lba)   > lastlba)
+	    le64_to_cpu(pte->ending_lba)   > lastlba         ||
+	    le64_to_cpu(pte->starting_lba) > le64_to_cpu(pte->ending_lba))
 		return 0;
 	return 1;
 }
-- 
2.53.0

