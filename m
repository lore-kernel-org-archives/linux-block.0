Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8C713AD05
	for <linux-block@vger.kernel.org>; Tue, 12 May 2026 05:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778562646; cv=none; b=ncQRKDczKiEEA21M2W2ebWiBxNVKkKs2+8WySB9YdvGY3/Kxp8I4aRzyHGzHzlwtSGFcWn0AlyRn+kVAJ2iSphj6V/4FG+Cg8kRuoywvmLKZVGm2vRmyRFHlR+OEC4/K4ksBdYxC8erheGW2JAnyhbD1cv6lBFdTtqISPi0/br8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778562646; c=relaxed/simple;
	bh=dcEmVjoKdHpiPTjQ1tFHqV8QJTHDEZBuy1AIrj3Rq3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bp812H77r7egkXG0oy3fAbUKXd6Sirer+z5scftexJJaCM/cgIKbcIot3o05kE4hv2Em1MH20K10s0QOJN5174CDgDAfe8EQ4fC9kYcYpA4UOgYNAXyf5xuMOcGGFtn2DaZN0cik8dKxSeONqyMprE/b6DtRYT4REMrMwm8XH24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6587cee8b57so5425793d50.2
        for <linux-block@vger.kernel.org>; Mon, 11 May 2026 22:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778562644; x=1779167444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+6QzfD1TPj/UYCxT/pRvXekIh5WoFE0MUpGbazQu3A=;
        b=qTdGMAaEWnySqgvynNlq+shLJ1vaqap8bh5vdGG//6oG+KnnKgyHk4v3XEQE+cwo5L
         86smxKgDValA7bD7AZQ1Gos0FaNFm0HYX32O/yx/LIt+Ck8Id1/Rnyj15gJkiBimi/uO
         Yi7yQecqLul2YMPhFS8v0vR8tkFdTkILwcVloVIY2GJvXt8L9W2OOu++P7N2ADmNSemF
         L8wJ0pRBlz1XZldmBbUca9MlTlTNVKe1W1wYVCPDsfM8wu8ceoI0iohrrIFOybagJjOW
         n8fSzFLp077Lg/EGNyu2sxOUq4TMgz/ltcTkg7yZsHrP4dU/zEkhtkH4MwDerk2ujQ6w
         vf5A==
X-Forwarded-Encrypted: i=1; AFNElJ9RbGc2lp/r+kU7lrXy+b0ju2dIcLo+//Enja72WkDMdkmr9BQubuFpMK/5tNuSI4ptHNb/rEFN3IDhwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yza0ANw1nJHV7VOYx8+AsLcE6WJxmcOEEsr/OA+Hczs41zDSDPr
	MC7NYW4tytrewSJlpfwOzXIXJVCxYFenOIWZLQTZkSPD1Tc7S6X4fCG4
X-Gm-Gg: Acq92OHIpFtdmJu1aRNzfSLbueoAeTolpuM0KcXSn000ESuYKt2Mp+h32DQ3HfQ6nDk
	9WHrMgbvmB1u28J6AKFHnEms1yg9NA2j7rfSPA6mBF+WZTEHwkvOfqB5hDddi2jeBbla520g7J1
	hm5AlIpBUnlFWSwpp8d2c0sTmeXNtaZ4SyyH7Ugdx3TvB7gFTrOzEs2cmVAZgQA6inMUalfOGdm
	3q5+fMfhGJJun1XHw9GuCJZoE4qK0MLt+7Y6kyt7Wn1JtNRhmyEvrsPPflO1v1QfnCJCV6IZ6fZ
	dt8J4yuD4hgCgky9+eMQ+8NDSVyXde+O3wfQibej5/x2dHaAyl5WsD++BRJCBq/8nhzAvAIUxjz
	NbLI8m9+rOIlJDqjsp0yWcC0ne+ttZhyR6nXCTbNJBGmL9P9Nt+7Zh7div6MfrGd88MCdVS5Jy5
	4hsQpn/y1vGQ==
X-Received: by 2002:a05:690e:4087:b0:65c:65ae:be23 with SMTP id 956f58d0204a3-65de128085fmr1332746d50.45.1778562644054;
        Mon, 11 May 2026 22:10:44 -0700 (PDT)
Received: from tofu.. ([128.210.0.165])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-7bd6685bfd4sm159239347b3.33.2026.05.11.22.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 22:10:42 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Sungwoo Kim <iam@sung-woo.kim>,
	Chao Shi <cshi008@fiu.edu>,
	Weidong Zhu <weizhu@fiu.edu>,
	Dave Tian <daveti@purdue.edu>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] block: bio-integrity: Fix null-ptr-deref in bio_integrity_map_user()
Date: Tue, 12 May 2026 01:09:29 -0400
Message-ID: <20260512050929.541397-2-iam@sung-woo.kim>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pin_user_pages_fast() can partially succeed and return the number of
pages that were actually pinned. However, the bio_integrity_map_user()
does not handle this partial pinning. This leads to a general protection
fault since bvec_from_pages() dereferences an unpinned page address,
which is 0.

To fix this, add a check to verify that all requested memory is pinned.
If partial pinning occurs, unpin the memory and return -EFAULT.

Reproducer in blktest: https://github.com/linux-blktests/blktests/pull/244
Tested by Shin'ichiro:
https://lore.kernel.org/linux-block/20260427040926.987166-3-iam@sung-woo.kim/T/#me17b14f2b2de12cf012b04d297e24cae667a6bd9

Kernel Oops:

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 UID: 0 PID: 1061 Comm: nvme-passthroug Not tainted 7.0.0-11783-g90957f9314e8-dirty #16 PREEMPT(lazy)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
RIP: 0010:bio_integrity_map_user.cold+0x1b0/0x9d6

Fixes: 492c5d455969 ("block: bio-integrity: directly map user buffers")
Acked-by: Chao Shi <cshi008@fiu.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Acked-by: Dave Tian <daveti@purdue.edu>
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
V4: https://lore.kernel.org/linux-block/20260427040926.987166-3-iam@sung-woo.kim/T/#ma69d880eb4dba82bc55cad882d42f2b674c473b6

V4->V5
- Fixed a coding style issue, addressing a Jens's comments.

Thank you Shin'ichiro for testing V4. It'd be great if you could test V5 as
well. V5 is the same as V4 except for the coding style fix, thus I don't
expect any functional change.

 block/bio-integrity.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index e54c6e06e1cb..856a5f16155e 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -403,6 +403,24 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 	if (unlikely(ret < 0))
 		goto free_bvec;
 
+	/*
+	 * Handle partial pinning. This can happen when pin_user_pages_fast()
+	 * returns fewer pages than requested.
+	 */
+	if (user_backed_iter(iter) && unlikely(ret != bytes)) {
+		if (ret > 0) {
+			int npinned = DIV_ROUND_UP(offset + ret, PAGE_SIZE);
+			int i;
+
+			for (i = 0; i < npinned; i++)
+				unpin_user_page(pages[i]);
+		}
+		if (pages != stack_pages)
+			kvfree(pages);
+		ret = -EFAULT;
+		goto free_bvec;
+	}
+
 	nr_bvecs = bvec_from_pages(bvec, pages, nr_vecs, bytes, offset,
 				   &is_p2p);
 	if (pages != stack_pages)
-- 
2.47.3

