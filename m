Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504ED299931
	for <linux-block@vger.kernel.org>; Sat,  6 Jun 2026 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780765648; cv=none; b=SRRpUMV8sI2h/AhuU70LE2VXjHuGvLagCh8X4789NWvhex7FYeQbFIkh8ORyf8HBeAZr/RpKxNETrHqa9xb4xbvoY5QF0/ggbxp86b6ir66R/124Lu1EXYjSrLxy51hr69UubCmCv9ECOFUqodvWVx7/4+WIIrea/LqhXwulGd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780765648; c=relaxed/simple;
	bh=R0YMzvYxYQr3sOqAegDmCBFMN7Q/gO2TST48W2S5s4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jO3p9Db/cgBju5iZkVQwtRuPvg/z+pGVizGGsg+JOXFfEmprEov8uW/5IxQO5SM6gHaZt839yxJiZSRdf0V66S7GMW3VAujNYQUQEdtjr1LF73dl3obnwzW9ZW9MwQsS9Wu8q0jt+9NxdIRNl8hqvZQN9g7vK5OzuZzdUATyhHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPAQVUAE; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPAQVUAE"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5176465a4a4so40976661cf.2
        for <linux-block@vger.kernel.org>; Sat, 06 Jun 2026 10:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780765646; x=1781370446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o80LmnK0uzkX+1KFSI8PVtao/YEOY0eT+m27hFPkzZk=;
        b=WPAQVUAEhoXFRDw+oiwX+Ltr/x+oT4gtZEeleU77TcDCthaB97T7lQxpPxZn+FL1JO
         r5GAa2WHgha5zoXwzJ4plMeX+qfQ2kDLSMqAiVZMrnWNvGqAkncbcaYitIYJsi6FHXow
         +pReRCYX0tP9nRDIP/nY7b3Qpk84PoC5BiiRnTtmChXOMK0yoEV8Xfz8IKYt+v+X2QnE
         pwpJLsRy9u8uYnkBBSUBnwRpy97+dHkrPCZksh1bk37jy9Hbx0kRfIcmJ+3mSbPDtwkF
         ARsFiz85oVSycw0F5x2V6dGO5pXMWt0s5bmj2kRbhWyqZ71h9J3BazJKyGPZHr2fEUxg
         TF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780765646; x=1781370446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o80LmnK0uzkX+1KFSI8PVtao/YEOY0eT+m27hFPkzZk=;
        b=G8TF/BCIl8Ki2GQQS0Ft1EVTMw2KWpw2KDDUTOLCDDvH1PWiBM4RLrEQ6XHW89zKKP
         L5oeXIy04/y6M9CJ+5DBRQZ5/Sgd7V8/36UBJNFFd8LMrACcyNDkFYOO8eX864m+hSzP
         wQ1nSkTgsMbIdW4nWorav7XkMHjxXjKxs5soF3uUSWKiof5GSjv5TAeKEcRkNonF0/bc
         ImIVPs33SNiUX8hR2xjooVRjSq0E/pEBVq62PDhB/Z153lDM+hO8RhDe2QPLnWIhMxlv
         qVJVOy9ihyo2EfPnnTvQ6GDl1JZ9RtFPCPGW8n9gvslhq2hSJiaeGjBCAPk42ONk5itI
         Pz0w==
X-Forwarded-Encrypted: i=1; AFNElJ/yNipNkWeWHzj4MlL19NLzrWFXeFfb+ApFfmD5haYnIRSWUrqCNHpxkYGdULvp7/4NQgDjbhaJZTL2EQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1fmcQguPxCqq1PSUCXxm7NqOu43JDEOfaytWeVZ89z5QqwhDx
	Z0W2NqgPsVxHTGdowqylA+cEcal5p2z7yFtJOXFog+b0Iv5Zg7NYS4JPVVUYfSBL
X-Gm-Gg: Acq92OHzazAJGv69IxInez70AgSvwVdUWf4Ps6REIfNTJ/0K5eXpcgIy8T9+pHXxpD7
	ZmXve8z+PnGQ0XL4I+NPtZja+HOvv7niD/fPcgfZAiVJCBCGt8qgnDcbtTNJ6XiuY4QBXgadbQ4
	sTRll7+MRtsF4s9uNorSAL7NeQ0kkIYuTf3bJdUctIHbXzgcNWaoBnJol+4M8R9M5x/UbWA5oU1
	zm7QuKvKl6Ji7R3hPqQ5jOUFWbQP+DnhLc/k4PmtCi3kpSwxQZqk9bKPC5NsPsY5wXXR1pNi7yx
	ajVcrg5VZRd/fkcBN5NOquO8wQ49myRz34n2B5tCW5bTiT2XKGcsrqnz4GC0RX+UCMWZ+HCKD/k
	St8+krPVOAc9r2HjqABqDFpCJDlU5wRHtY21UGvOoaKKD7/Ll8bjCJ418gU+M0CUwkukERTxuD6
	/0IDqE6GM1juCdMdQ/8cxxNRsWp8usHT+fSbGCDYecc7FTevWvPn4s0irT4gaRKzv4NrM7Er61R
	K8zXxqXQOO4aianXA7LR3qxlnaYMlA=
X-Received: by 2002:a05:622a:1808:b0:517:96f0:5658 with SMTP id d75a77b69052e-51796f06eadmr119777501cf.14.1780765646160;
        Sat, 06 Jun 2026 10:07:26 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd0556c0sm112907536d6.25.2026.06.06.10.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 10:07:25 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kees Cook <kees@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] partitions: aix: bound the lvd scan to one sector
Date: Sat,  6 Jun 2026 13:07:21 -0400
Message-ID: <20260606170721.1530005-1-michael.bommarito@gmail.com>
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
		for (i = 0; foundlvs < numlvs && i < state->limit; i += 1) {
			lvip[i].pps_per_lv = be16_to_cpu(p[i].num_lps);

p points at a single 512-byte sector, which holds 512 / sizeof(struct
lvd) = 16 entries, but the loop runs until foundlvs reaches the on-disk
numlvs or i reaches state->limit (DISK_MAX_PARTS, 256). numlvs is an
on-disk __be16 read straight from the volume group descriptor and is not
validated, so a crafted AIX image with numlvs larger than 16 and lvd
entries whose num_lps fields are zero (so foundlvs never advances) drives
the loop to read p[i] well past the end of the read sector buffer.

The 2014 off-by-one fix d97a86c170b4 hardened the matching write of
lvip[lv_ix] but left this read loop unbounded.

Bound the scan to the number of struct lvd entries that fit in the
sector that was actually read.

Fixes: 6ceea22bbbc8 ("partitions: add aix lvm partition support files")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 block/partitions/aix.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/partitions/aix.c b/block/partitions/aix.c
index 29b8f4cebb63d..6679e825ba329 100644
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
+				    i < 512 / (int)sizeof(struct lvd); i += 1) {
 				lvip[i].pps_per_lv = be16_to_cpu(p[i].num_lps);
 				if (lvip[i].pps_per_lv)
 					foundlvs += 1;

base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.53.0

