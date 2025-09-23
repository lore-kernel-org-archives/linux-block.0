Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EE41922F5
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 00:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587644; cv=none; b=DbBZZhP+qFhbz5/BIpebOlo9xzMYFf7S1QsYeGh3qRd8R5iWP0LYOL/k4YKivlg2e8CYQHdRKL8H6j7fPHsFXoWUinAPnNPjIH5sNqRf6Wf9+y0NykRRk0OpzWoigfD3RMfZ5hlBfi2hQULZLZ/FOfceELYgfhamAw+NrNehggs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587644; c=relaxed/simple;
	bh=s6mhJfy1wLr9wwae+98XWped88EO8RR6Rj9hVh2fPUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taAbmSs7O2ET5EVV8uBY00Y8IHBIHpfAV8XS2HoGTAOkpmtWR/JP/UnTxF32DpeAly4T2ujtTKrvPXhQ7TN9W/DovuKf733lXk9NDE5Y6NQXDPyf72cexgrRArRW9Xp+xdhyVPLgQRuAtk/A5vfyXkX/rTcUVli45ZzRra9ai9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WN7ChBlc; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WN7ChBlc"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b5512bffbfaso4543351a12.3
        for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 17:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587640; x=1759192440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+b5voxvHVAQ9evPBAMJkr0K4640egjfoU7iv7FHQ8OE=;
        b=WN7ChBlcUcvD/CuQRoDxSCYlalJJ0DWmeKGqx3nWwxcEPN5o0l1AokBao54AosjfRq
         pUxz5TGfwIjDQR5z79NA+rf78aoBYW413W1trtClWZhZQ1NS4JlZfjwPApjo1O49Mc0f
         3ppRXqdrRYAbwGRA8o6qUrou+9LK7Wj9jhPGqpCnkR/JWtl4HKr5mjkix6upWxacvkL+
         jiXjX1INuAlVoF4l8F9moRa+uALWv4UnUeFjSMdSl09YyyQgQuuH9V8x+8VVt3/JC3Mi
         wdWinT1jC+EKoPCy+/x22/H6yNDU19r+sGI81Of9LeqsLuEmJrT1zFyDY2BVd7uhHFNS
         9pDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587640; x=1759192440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+b5voxvHVAQ9evPBAMJkr0K4640egjfoU7iv7FHQ8OE=;
        b=TcKo/mfY/jhUTp+J+sChgnI1GPsOl3y3/voFqRDdJ8aQHwv/gsgiUO/dfAu3rxBNlx
         3Y4QmQRJoZZuie3Tyred0cK8aTbxh2jtli+jtxIwINqCPbAGpLeqVEEm08W1O+abM4s8
         7imZrJV4oNdaRTWoxuE7anAjMCshiXc7BtXKTcAV0EV6GmX04229HwtMRvjS/KUww3H6
         tQjwJt2N9tsmx6o4uVxQT9Ti6EVVkOGwR7pwN6E0K108FK7ZqSeLShSj5OJ1pAbmWn+S
         lKrNL/hncUFV3dUv/xC8xhy6rM30vdKnsqu0rj8CE6mYQdMpDd14rX8rs8YnysckpGmQ
         +VEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIIFul64WonKIHeelF9EYqBKseRJ/EB6anXaeCK+v+ASiIuargCYr1Ps6d5UJ9FrrGNWH/Hy6kvtU9bA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Ud4FgEBufB/xhvbwsac+EhclbSJukZ0TpSHzXXFeOObVmopI
	hflLE2kMwU2NbyGa3rCFXb1zyKF0rYPhsKCFWig2+wzX+t4NTPsdTGVD
X-Gm-Gg: ASbGncvszgkitX/3BNxb61heAoE/PwmCwAUBx+jhbMudRTfTdap2+H1U6LC1bMifl5V
	M2wFD6lDN7fXMvWq0EXs9bEmF2mnipVc0VWA9oXVhPkbjTtd0griLuPEjg+1jG1mv0/Z0iWV/al
	FhX3A0iQw8U40R0Sw6Xhlr/o9tpauELh3ihLooMlgq1sNYhhb+eWwvykDMwYATBdNTVy0hxzGef
	IneoSk+4GqABQeoFG06y0NjCxqOwcXZlXjn0x2tO4o2rLhJsg8ysYphqGI3hWC73rWGv3sd/ggF
	RuKC9YX6fXJqzyiVY4gzXviBZtbZboIVG00CIO6EhzkNQsnhK4m74KvhbBVI8iQL1B6A5ks9/b0
	bTiYB0znW2hgWtEn+cNN2BpqaPSOeGE2kTkml3My3nQgUwSoJ
X-Google-Smtp-Source: AGHT+IE09TVUGqvhRnJ0j5/kebD7MODetqdlA1rNkjmRk63jDyjVyF8TO49tFsaKOOBbleAow9Cquw==
X-Received: by 2002:a17:903:1209:b0:24f:dbe7:73a2 with SMTP id d9443c01a7336-27cc580deebmr7891545ad.31.1758587639758;
        Mon, 22 Sep 2025 17:33:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980180bdesm143588125ad.56.2025.09.22.17.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:33:59 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	hsiangkao@linux.alibaba.com,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 05/15] iomap: rename iomap_readpage_iter() to iomap_read_folio_iter()
Date: Mon, 22 Sep 2025 17:23:43 -0700
Message-ID: <20250923002353.2961514-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923002353.2961514-1-joannelkoong@gmail.com>
References: <20250923002353.2961514-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

->readpage was deprecated and reads are now on folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index dbe5783ee68c..23601373573e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -422,7 +422,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 	}
 }
 
-static int iomap_readpage_iter(struct iomap_iter *iter,
+static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -487,7 +487,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_readpage_iter(&iter, &ctx);
+		iter.status = iomap_read_folio_iter(&iter, &ctx);
 
 	iomap_bio_submit_read(&ctx);
 
@@ -521,7 +521,7 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 				return -EINVAL;
 			ctx->cur_folio_in_bio = false;
 		}
-		ret = iomap_readpage_iter(iter, ctx);
+		ret = iomap_read_folio_iter(iter, ctx);
 		if (ret)
 			return ret;
 	}
-- 
2.47.3

