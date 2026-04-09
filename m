Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C3C332601
	for <linux-block@vger.kernel.org>; Thu,  9 Apr 2026 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741457; cv=none; b=fgzQh6FMzDdtiUsU9NNjYlIQREyW3z431FiF67FmdI37whbi25ygNsu1C3xF67Z5HndKrXm2sN3OHur56NtEekdvUnyrqaGJGpN6mEPT/9tnXTX9ZDfDpzGY+4vhtpMPLlqVOsjNXTn2YGo7idaLix5VqyERQdgIU5q1a/eZ2H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741457; c=relaxed/simple;
	bh=bLZ7nvU3srGPAY03hE2GPOwyVSNU6swjgIE3T4bIV2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bBufuL7T8OQ+bQadLo/p7DkISmEnG0TkPaLsYXTR/hCfOG9UvsJA6kaX39S1SFolHVN2ti2Rer4cZZrSvVujRnd3tVq5bMKgI6YRNL9ngSI1L9tuCpvf0B1yfBu2tSTxlW6T1Sx7uTZq3Vvee9Z9GuG3VJRdaLtBAPd8pcQtSt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzUaEn7l; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzUaEn7l"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c766a95a72dso648130a12.1
        for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 06:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775741455; x=1776346255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yNXaTDPa3SSoxM8NEwCREbqmQmrVjvVuq5mh5HT7mQ=;
        b=bzUaEn7llPNJOJxVqEjBvOi6Db1RIpsV44Z4OADN5griTvW61L9B82DZqAlK5KJz/E
         WVSitHQKGi98EkepOozGKyvMiyKqFGpzgDohXe2gpgkU0OqKabPEa3RxnHuDPzqQKpfS
         F9BKSpd3nyRDgvjInlHU8UYeg8mWegoTl80Ikc31cwhVOypSMvgV3zXXcJbbHhzpm6qQ
         dv/w/bMRvzuMo/L81ORoVL8Lx5CGzjYjs8YN7bY5YbgXu8ES1mdjBQ3Wc7j7Xb5y8GpR
         PfsI9FZdeBPLeZXjCEqkGipQumQzbfs9M/pNQtj2zXFqkndhQshbqTymARplChEdIMpM
         xUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775741455; x=1776346255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/yNXaTDPa3SSoxM8NEwCREbqmQmrVjvVuq5mh5HT7mQ=;
        b=njMrstPRI0+dC/5WZw3aSLGSqfTVEEw1HIKg7W3VxdYbdGzqyC7v7vo9XkaXdvgX0B
         2QVN1ChXsD/qnBsu18VV/ShobXMmRcqUFg/fZZ0SgF0KgceCtDuTdUJXPAa4VLn7otqy
         VyDcDxSTykwWwEF/O3iqO+Xm5R3aCq0aT2KgchDXiyHcwqWZI1dpJ79PEhrj3RlKkQh0
         WxmXVFY2km8tTkFxn2tmizfK3i5iJcuXRzvqgq4GSCdjc8eKAAO0G+w3PacrFZZHWuIz
         6tc8krFPOIheBR3tWGibmE1+WM/CRoJqmbSr1mDUoMgZetCnymRlqyHA2nslXcM7f7cw
         Nu1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqJGYn62qDdHWPl6HK9Emxyjenb+0SIm7S9D3klVnEgtdCVFBVI+5yerD+PkL+Zic5rRLDK0eC0TmRiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQFdYBX16Gp/PYlaxlIdSGVQZ0I9uIq4mAJ1mH2d+F/M/GH0Nj
	dLNVi6Z0O7wAokqJoWATrmP0zuhzPEYzpZYAhs0hdFg7XC05E3BP6nOB
X-Gm-Gg: AeBDiev9bZMZOegllzKJIKG/E/xTQrUKcLpYCJxc/x8zdOWq8G7zytt0DZ9SQYAujdb
	I9yOvC3nRkyxr0CDDg2BxXmZh2V1sY5WdqJpOqrhGMJXEoaLHT2NtTGB2gI5s26RJsuU4OVsc65
	Sl8zHxicgJJTrtf1BsRG7r2c4HBsu3GyR8/JOI8uhyxLEhRsspRYGT+xVnylbkjfGgMqUCrE8Pj
	FTVSbExJjN5aZLsqdD3FF69uNqXQtRiCk0HVkKPFroC/Tq1XnPAc3kcnn9v1BhamnwtjY9fp4bx
	uS+U37hQpmyUuAEz5MpHuYJQFfUUmh3ai60CBmHU+78aoQrPgHy3c8lYZjNfNSdg71Rw+LqkRqS
	mSNEESRv8l67uRAK1bU2vRMYVcMo4d1l/ulcaL3g2gZ8T/ssC44LbfdFs8p81Z2kVUc84SzOz85
	fPc0TypKxziDJy7YLXpzpzVywV9kdkVdvGk0OHFWKeVSUNraEl0pyE8xfSR0wsb8LMi2FZEQPqR
	cmq
X-Received: by 2002:a05:6a20:3952:b0:39f:29ab:b35a with SMTP id adf61e73a8af0-39f2edf4f56mr26708670637.16.1775741455202;
        Thu, 09 Apr 2026 06:30:55 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm21021166a12.24.2026.04.09.06.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:30:54 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 6/7] Documentation: ublk: address review comments for SHMEM_ZC docs
Date: Thu,  9 Apr 2026 21:30:18 +0800
Message-ID: <20260409133020.3780098-7-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409133020.3780098-1-tom.leiming@gmail.com>
References: <20260409133020.3780098-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

- Use "physical pages" instead of "page frame numbers (PFNs)" for
  clarity
- Remove "without any per-I/O overhead" claim from zero-copy
  description
- Add scatter/gather limitation: each I/O's data must be contiguous
  within a single registered buffer

Suggested-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 Documentation/block/ublk.rst | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index a818e09a4b66..c39d111af2d2 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -492,8 +492,8 @@ The ``UBLK_F_SHMEM_ZC`` feature provides an alternative zero-copy path
 that works by sharing physical memory pages between the client application
 and the ublk server. Unlike the io_uring fixed buffer approach above,
 shared memory zero copy does not require io_uring buffer registration
-per I/O — instead, it relies on the kernel matching page frame numbers
-(PFNs) at I/O time. This allows the ublk server to access the shared
+per I/O — instead, it relies on the kernel matching physical pages
+at I/O time. This allows the ublk server to access the shared
 buffer directly, which is unlikely for the io_uring fixed buffer
 approach.
 
@@ -507,8 +507,7 @@ tells the server where the data already lives.
 
 ``UBLK_F_SHMEM_ZC`` can be thought of as a supplement for optimized client
 applications — when the client is willing to allocate I/O buffers from
-shared memory, the entire data path becomes zero-copy without any per-I/O
-overhead.
+shared memory, the entire data path becomes zero-copy.
 
 Use Cases
 ~~~~~~~~~
@@ -584,6 +583,9 @@ Limitations
   the page cache, which allocates its own pages. These kernel-allocated
   pages will never match the registered shared buffer. Only ``O_DIRECT``
   puts the client's buffer pages directly into the block I/O.
+- **Contiguous data only**: each I/O request's data must be contiguous
+  within a single registered buffer. Scatter/gather I/O that spans
+  multiple non-adjacent registered buffers cannot use the zero-copy path.
 
 Control Commands
 ~~~~~~~~~~~~~~~~
-- 
2.53.0

