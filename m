Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BED7389460
	for <linux-block@vger.kernel.org>; Tue, 14 Jul 2026 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029693; cv=none; b=e7zS0zZQgRnWZEDxkkS/3+h7lpK9o+PlCc0uz7mjIdKASka9j8QXpMbBoHgG91FiGo8SZd6mYGvAEyB+XXS/HHMMA2+qTKhsHwFOmNM35hUNBSOMpPi6ojdcGHVeUmukmtlsAxyvkiBBM1IpQm0A7nK9LId5edX76UCkUhYo3wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029693; c=relaxed/simple;
	bh=NcZZI6DLOn8WnqVj7lun8kCkdomtlBs0wkD14C1RB2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oh8JMpPu+yljUF/sC158GS1iKwtuwnhNzBqIKvo4ykFz28Lpy+h7SQONNlhfu9Tt4l2mcFu7yHX6b9QHzvXCMYwedjOyo1jwBUFwpGRbQE1PJwPMgIKIVhiJUZet/pQC0gUVnN9/PZqbzpeza6KEtLVd23U947no+yRI65UopDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLe/QcBv; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLe/QcBv"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e5b048375so264271485a.1
        for <linux-block@vger.kernel.org>; Tue, 14 Jul 2026 04:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029691; x=1784634491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CeV9RSdVOzkds4wZ0hwKnF9OcSJyOgbgPYS5NxtvfX8=;
        b=CLe/QcBvaB7rwm8JAH9vOKiUwWT2qj0ESDCXqE1QfRU5KMooP5sAmt39ObKPomyGi6
         iYS2OwqAoEPV7t0BblBEDWCgujq2B5y0IEaDAMBGrtVg/zSykjo5XGWisKAgsurcQQLG
         L0Hi4xKh7K9x5t62btxlGsS5Mz7dzZD/k+/+UgPmXYXGu7CgWeTiIKpV2jYQCuT9Fye5
         YqbDUrJ8uocBZ1FgruQUJnZJfU4GoxKigheOZTF/7vwy9Zq+Ze02z+Wi+RnwHm70Ujb1
         WuZfpGSBJwwA6xI7jbelC3R2MPjuuDOCsgJXqhjTcEy6TI2SQWZwMm/FAtIRaqZukbkZ
         1+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029691; x=1784634491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CeV9RSdVOzkds4wZ0hwKnF9OcSJyOgbgPYS5NxtvfX8=;
        b=QSHFlhRONHzKCCGXsl8Ax41dMC/Ypn5GsEVO9RkJUP7eENN4XtEAjG3vxXQQFIXEri
         eb4OaDor7Zal01vL/c+U3Nn+W/KKgNhxXnA4HKsazV1L1NPLGyrp9UQXiJG7NHyHXEax
         3wril4PLY06TonfLtN6Uocvee6/lXX9GQCmH5JutCveYu0IQXWnJqcYogUppF6AJzaGu
         L+COu9z7bdMQs2Z+/+zUUn1gXmeJeU5pbMpV++rPndaK/u3bPUmswwYQ/byRrvDuQ4hZ
         BvQzQbWAqJqPLCamIJFDbDNS5AsKmM+EfrUNDkuTzF6bvDKgyqfJ2uUbrRBvW4wvjknN
         ukAA==
X-Forwarded-Encrypted: i=1; AHgh+Rr4ohptHtm/jZI5bGlsfKCURl/ZueNJGkDdeHsC565RcEZE5xgBa1HrlpdjuupjsvErvAm1ueb+iiX2tg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0aVfm4v1NZgnPmQJAETPPkSk9ROKzXeejefxEtk5UDjnu9F2Z
	Mt6bQTcYtwocWG4Y4fjRf3O4cXEADQr/+42YKsbV+phNDbSSnjpRgCe8
X-Gm-Gg: AfdE7cnzw1HHgdLht2da2OqtJL2KUmAZnQbYmLIKYgsdShrJzeAG6to+X9s+31LC6dF
	4wlnSM33K8N7qe+cgYNGOIU4B3vSM9NiJNzRLgTpIHxXHdSoQhdNjT+U185kC93AjMUwzEqJ83Z
	YxJZ9KnqtjlDv71c1v786cZ4uTFSNFQ/MjgkS0EwLM4DJbqQLnTHsKd2xHEYFb8CqUA9/VVAbTt
	NC70HTZ7JNqFdkx0JuLrHZXeJwo+4PrBye9NjgO3oAxae2jLhjKwqEZsw/eI2fTHHjU4x1jiYB6
	jhRjGeILmWCyCuYPjt1gwESDFGdasYbmfU/BW3SR5hQCzabftMjQPN6ghP+0BCWuMGyZi7TrQMz
	gjXQuDOLEJqeCKq0zzemFeEevWEy+MG/RH1jICmkEyzP2IKa+Tb9mjyHo2o12Z3atNpSvAwvSBK
	3fMHydAvTFOud8NSKKvz/96wDVIG7VkoMnqnvjoDQ9yoLvD/XbxWmv7RvU7Lig6+nYLu+mSx03c
	fKGSxTjR18dQPXgzfBZ
X-Received: by 2002:a05:620a:bce:b0:92e:76cd:9594 with SMTP id af79cd13be357-9308683d96amr165376585a.19.1784029690749;
        Tue, 14 Jul 2026 04:48:10 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e082csm183996216d6.5.2026.07.14.04.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:48:10 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Hannes Reinecke <hare@suse.de>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Philippe De Muyter <phdm@macqel.be>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] partitions: aix: bound the lvd scan to one sector
Date: Tue, 14 Jul 2026 07:48:06 -0400
Message-ID: <20260714114806.3761553-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

aix_partition() reads the logical-volume descriptor array as a single
sector and then scans it:

	if (numlvs && (d = read_part_sector(state, vgda_sector + 1, &sect))) {
		struct lvd *p = (struct lvd *)d;
		...
		for (i = 0; foundlvs < numlvs && i < state->limit; i++) {
			lvip[i].pps_per_lv = be16_to_cpu(p[i].num_lps);

p points at a single 512-byte sector, which holds SECTOR_SIZE /
sizeof(struct lvd) = 16 entries, but the loop runs until foundlvs reaches
the on-disk numlvs or i reaches state->limit (DISK_MAX_PARTS, 256).
numlvs is an on-disk __be16 read straight from the volume group
descriptor and is not validated, so a crafted AIX image with numlvs
larger than 16 and lvd entries whose num_lps fields are zero (so foundlvs
never advances) drives the loop to read p[i] well past the end of the
read sector buffer.

Commit d97a86c170b4 ("partitions: aix.c: off by one bug") hardened the
matching write of lvip[lv_ix] in 2014 but left this read loop unbounded.

Bound the scan to the number of struct lvd entries that fit in the
sector that was actually read.

Fixes: 6ceea22bbbc8 ("partitions: add aix lvm partition support files")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2: use SECTOR_SIZE instead of the literal 512 and i++ instead of
    i += 1 in the bounded loop, per Hannes Reinecke's review.
v1: https://lore.kernel.org/linux-block/20260606170721.1530005-1-michael.bommarito@gmail.com/

Evidence: reproduced behaviorally on UML+KASAN (v7.1-rc4,
CONFIG_AIX_PARTITION): a crafted AIX LVM image with numlvs > 16 and lvd
entries whose num_lps are zero drives p[i] to read past the single
512-byte sector read for the descriptor array.  The read lands on a
page-cache folio (not slab), so KASAN-generic does not splat; the
instrumented run shows the index walking to state->limit (256) instead of
stopping at the 16 entries that fit the sector, and the patched build
stops at 16.  Built clean, no new warnings.

 block/partitions/aix.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/partitions/aix.c b/block/partitions/aix.c
index f3c4174e003e9..689837deba279 100644
--- a/block/partitions/aix.c
+++ b/block/partitions/aix.c
@@ -208,7 +208,14 @@ int aix_partition(struct parsed_partitions *state)
 		if (n) {
 			int foundlvs = 0;
 
-			for (i = 0; foundlvs < numlvs && i < state->limit; i += 1) {
+			/*
+			 * The lvd array was read as a single sector; only the
+			 * struct lvd entries that fit in it are valid.  Bound the
+			 * scan so an on-disk numlvs larger than that cannot walk
+			 * the read buffer out of bounds.
+			 */
+			for (i = 0; foundlvs < numlvs && i < state->limit &&
+				    i < SECTOR_SIZE / (int)sizeof(struct lvd); i++) {
 				lvip[i].pps_per_lv = be16_to_cpu(p[i].num_lps);
 				if (lvip[i].pps_per_lv)
 					foundlvs += 1;
-- 
2.53.0

