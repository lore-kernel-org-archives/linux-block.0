Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F102727FD
	for <linux-block@vger.kernel.org>; Thu,  9 Jul 2026 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603154; cv=none; b=i1t80PMPM9BF8XKPnT/HwfKchkb2g7f49z6vqTNV3HJIe22eyCw87BByIIytBqAtneXkj8j6sNqbWDdrweqyE08xmDvTZ6/GVqSoCoOFz6Tx5BHSf0PGxU4b2y/oyO3G2hpuPRWbNZmBHcovAG7OhvGPPbTer3GoicJ/mcuVr94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603154; c=relaxed/simple;
	bh=L3tVVf0AI+vZH2xeekSOCR1AqlvFzrrEBc8HeZ2OXR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPYbEazY5ZiiynvbJMssSLjjgxXNgtxsntTD6X6XGMBpBvznTSsXb6IBiDauiQr0dpD6ODPn35Apce2fsoAdYASl2zHYoVAaJhLn71d2suzUEvZ8nfnBmU5teBnYnimJ+8U0m2eeO3RDMaCO5ctghuYk112l0SCXHufBNPCKFzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rZnsLOCf; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZnsLOCf"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso1938685a91.2
        for <linux-block@vger.kernel.org>; Thu, 09 Jul 2026 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783603153; x=1784207953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CUlFlzpXFW4Tu4Nj2yptSBR0grcherDl48iid+RrU3k=;
        b=rZnsLOCf/cnaQEBH228qTO26hWF3dx3z5cp8+JMd4nlgi9ljLAVMs7vMI2Mxo3uDgP
         duguG/ggIzO9Ze22BCD0ikg4AjJrzydNsBMvvr1Q3ciRPnV5kJPbl7FG+AxUT+V6HCYk
         IqJ/f1tONAvlUEgbExpmsaxmnic19N+QY7y//kNS+qx0XnJ57KDt3JbPA/wiKrkX3n42
         sc0RLQ0PTQtsagg1LMSjeb08mTS0Xq54QpLYg38ayZF9gmYWWttrWZcUqYznEj33Y0TX
         hE0FqQuy3x2nqZnKbZIg9o+bpzHrNCDzUr7dIQ85VRhAQ4bm2bCFethMnQEzbQ+zujxV
         25vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783603153; x=1784207953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CUlFlzpXFW4Tu4Nj2yptSBR0grcherDl48iid+RrU3k=;
        b=II/kHBpjhvHtCM0cSx6YKpxGQMDiMYHCJzJMD9518izddviOKOOBqI5nc8NrKyksBe
         ZDqSoVBaPJtfAAazagYEEEQn7fcTMMdewVeXdddDq+s0Px33VQQ478TjvLxQsWHmKFaP
         LheAEYTnFIL5OpiaxzJPFjfKWHzMXiXwrWbvQWYXu2Ba0J07GHV+B3EMzE02CN5dq6/S
         Ile8957pmKPUg6IVyMsk28o89C73J/Sqmw7/4q1gmdAtogYfUhr6z73rUcSOfJerIxV7
         5BrPZDNLTvRvyXIbHIYpJCOq1eRgZclZm5XFxqnl/8pvHEXje2cSj3W+zq0Sf2s8hJZZ
         GR4Q==
X-Forwarded-Encrypted: i=1; AHgh+RqIZMnnW1oT3Fv893OJhSy7/wQ9+MciK/+aE4AakOIKGysKrUdYDXgyH5vDkY+21doixSypaSkBIWTxOg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3L9PYtpUuWbt8S5G/upNjIpaocMNl0SwXOeyThXOqKJ/MX4Kx
	OQbE2J5NPSCHzXQ1tkoa3CI0jVOj7N0BEb7vpsd/eCCAY/vtvdbJokk=
X-Gm-Gg: AfdE7ckocBfX/dQbipVgWqZ0uRzfCEw/8im0ySwSTxnObi4huc/f1QZ6YbQfX6U89ES
	jw9aAezsFagESe5YYRJkPvDqN6fjovRO3UfWs3YbOA9Vh+jOKCt6Y9etWpir6uzoun0EWcwQS4P
	8KPisPPgtOnM6VhqZZbHM52Gqc1IHjDiOPKPeMOJUNkileYelTmUP/zs8C6LSPiCEuB43KNOAm0
	ZIWJLV9xYq4ot4b2+3Xkt76NXeiXEsIlsBJyCOdy+Ocx0VT3oLWgNgRoXmhne+PV5P4H+M0mfxC
	n3cGVV1s0eJn24+POTq+qLg253R+9PWSYOuvIU5B7zKy2zLcpzdES3bNdRi3T7j9FDJL5XEZwfB
	JS8f3Uee2vWMwZO5RWQLbHc6ZCA1yiuq8q4D1wKH/Gfii4ej9tCT8fw9PHUFfDFgWwDGn2MOlqZ
	TYcVF20k5fl4DRJB6WmAo99cXT9WQdSkPY24q/+zjnwXgnFieFcjsTKm/R2QxEhFFnp4qW+zaH7
	sg=
X-Received: by 2002:a17:90b:5384:b0:381:c500:b0d1 with SMTP id 98e67ed59e1d1-389421ae13emr7846863a91.20.1783603152578;
        Thu, 09 Jul 2026 06:19:12 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([58.146.106.120])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ae6cd9sm33960852eec.31.2026.07.09.06.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 06:19:12 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: colyli@fygo.io,
	axboe@kernel.dk
Cc: gregkh@linuxfoundation.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v6 1/2] badblocks: fix in-place round_up/round_down usage bug
Date: Thu,  9 Jul 2026 18:49:03 +0530
Message-ID: <20260709131904.596684-2-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709131904.596684-1-adhikari.resume@gmail.com>
References: <ak9CC591ivuQ4BP1@studio.local>
 <20260709131904.596684-1-adhikari.resume@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rounddown() and roundup() do not modify their first argument in
place; they return the rounded value. _badblocks_set(),
_badblocks_clear() and badblocks_check() were calling them as
bare statements and discarding the result, so 's' (and 'next'/
'target') were never actually rounded. Depending on the caller's
alignment this can leave 'sectors' unchanged or, in the reported
case, produce a range whose end never advances, causing
_badblocks_check()/badblocks_check() to loop with a non-advancing
cursor and stall the CPU (RCU stall) when called through the
nvdimm ioctl path via nvdimm_clear_badblocks_region().

rounddown()/roundup() also do division/modulo on the sector_t
(u64) operand, which requires libgcc helpers (__aeabi_uldivmod,
__umoddi3) that are not linked into the kernel on 32-bit builds,
breaking the build on arm/i386 (reported by kernel test robot).

Switch to round_down()/round_up() (include/linux/math.h), which
are mask-based, assign their result back to the variable being
rounded, and require no 64-bit division, fixing both the
non-rounding bug and the 32-bit build breakage.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604301231.IpPh4AiH-lkp@intel.com/
Fixes: aa511ff8218b ("badblocks: switch to the improved badblock handling code")
Cc: stable@vger.kernel.org
Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
---
 block/badblocks.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index ece64e76fe8..1f786b193fb 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -857,8 +857,8 @@ static bool _badblocks_set(struct badblocks *bb, sector_t s, sector_t sectors,
 		/* round the start down, and the end up */
 		sector_t next = s + sectors;
 
-		rounddown(s, 1 << bb->shift);
-		roundup(next, 1 << bb->shift);
+		s = round_down(s, 1 << bb->shift);
+		next = round_up(next, 1 << bb->shift);
 		sectors = next - s;
 	}
 
@@ -1071,8 +1071,8 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
 		 * isn't than to think a block is not bad when it is.
 		 */
 		target = s + sectors;
-		roundup(s, 1 << bb->shift);
-		rounddown(target, 1 << bb->shift);
+		s = round_up(s, 1 << bb->shift);
+		target = round_down(target, 1 << bb->shift);
 		sectors = target - s;
 	}
 
@@ -1307,8 +1307,8 @@ int badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
 		/* round the start down, and the end up */
 		sector_t target = s + sectors;
 
-		rounddown(s, 1 << bb->shift);
-		roundup(target, 1 << bb->shift);
+		s = round_down(s, 1 << bb->shift);
+		target = round_up(target, 1 << bb->shift);
 		sectors = target - s;
 	}
 
-- 
2.43.0

