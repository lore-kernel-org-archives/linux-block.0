Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEC4153587
	for <linux-block@vger.kernel.org>; Wed, 27 Mar 2024 21:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711576128; cv=none; b=PA7ZxHKIcX5aELwZ9Pf8i/PHbULW5xpEmTqv6Wkx6Z6lLcq3EQ/Q9tna09JlStBOW/M5oUgB/24LXiMZWqusGWcRCLrHOjWOd+x2Z7UWRwn9t7wlwRj4RdL7kkaQ+LuPDmzWvUs+jBYcGJ53M/Lqtu0gXiP9RNiWAlEacd3jlRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711576128; c=relaxed/simple;
	bh=QOUh10q482cTGWggeKHccxNHiSKhKIC7kyl5JulsUkE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JVM1+ewcU7jXy4FMyxYt6Rwx3C5+khX17N5topek22dIdSc73rSXqPTZD/uPgqLdcGmZTcACgHsIpV2c3aqfP+pSFspqRw7v7Y/oFu5Bct72hHV4fRIH38JaDU/MaZxKSBjmQfgCzTcnDivgkKz+GDboLHxAPR79HE2T7m2FsB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QE9zti0+; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QE9zti0+"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce2aada130so166451a12.1
        for <linux-block@vger.kernel.org>; Wed, 27 Mar 2024 14:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711576125; x=1712180925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vZaxMQiAGaEDi7iy8b++0zsxGuLEpum0CyOAPkS1+08=;
        b=QE9zti0+0s5XE62i5RTIyQSvBwKCQ0lfyWce91GmRX+rZD4xx8X1dVhOSFOOjB4Tli
         bbjnBS7/aGoGB2hC2w/lJ+RhM2p0yj2Pf3mbOxxc58G4db3sa+176xlGWKP0qWB7/26f
         M+sx9EG0bUsfWuLzIW9ArXlTaOh22RPYhNVyLu7wHtUgQ6APa2j5dAxx76WK87VcdYqH
         NVKrIGQsGH74W9wbnkwHe8PGDp1NxwWg6hQJUAgprYxu+iBsNVN/THw7RJ9lN7UtxZSH
         K/NViUz5aFUGmP0e2i6g4bIh80hjLEBOeweUlNlzG8+xeA/YfSD5tlrAE222YZQOQjha
         ManA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711576125; x=1712180925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZaxMQiAGaEDi7iy8b++0zsxGuLEpum0CyOAPkS1+08=;
        b=fv/BIo8NclG+0WBi2TdbEQGVRRBnv4y5ILjIQBeb1dxSv4DnfC4udVCY1iUV8+E0v7
         W2u+gEuE5hpr8OIuoYTh/ZquQUFYNZnEe5vMN5tKncjEvfI674nvE6uXZy1HXvu7wDQh
         BwphM4uKRzFk7DfuQHZmHdr6Y5HbD2W8nKq4mv0JmwqpBhUpscjB98ZkVCxkn0yrP6nU
         gvRE4ROz0zt/0wZU/RMAo056/85avK2NQ5K9ObIpnjPBlmPs2eUqn14Pu4vvQw+3iZcO
         yhYYSQxN6KKl+uNzmW5FMiIzT9b7q4O5dU14v9knnfJG8EY9sKG1OIiGm9wEEZRUGiwU
         TO3g==
X-Forwarded-Encrypted: i=1; AJvYcCWtQjfcUVBvDu23lH1e+UquJ5gzO67V0ym20oPu6u7Wk4Y+xFBpBulqOGLATn+yz2ghmdiy0n2CuZy7AQuQ+G3kDzcAWw15jXGjsd8=
X-Gm-Message-State: AOJu0YxQ4uYbZIf/FUyKJ+1FSaC1q0KdFdX96Nz0s/iEwnLrsVCuwSQu
	tbEvFjfly2YWvg1bY0luOXAviJ01wXH7USnsqG3ecLZj9Oww3cyA
X-Google-Smtp-Source: AGHT+IHWA6uU7NteAwJrmRovkygIk+95z4A0P/yAbn8K9xfXZsQCwqxrb6K5SOcmAijoHkEy31OF5A==
X-Received: by 2002:a05:6a20:324e:b0:1a3:68bb:89d3 with SMTP id hm14-20020a056a20324e00b001a368bb89d3mr989970pzc.17.1711576125333;
        Wed, 27 Mar 2024 14:48:45 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id z25-20020aa785d9000000b006ea9a54dfabsm18633pfn.52.2024.03.27.14.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 14:48:45 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	minchan@kernel.org,
	senozhatsky@chromium.org,
	linux-block@vger.kernel.org,
	axboe@kernel.dk,
	linux-mm@kvack.org
Cc: terrelln@fb.com,
	chrisl@kernel.org,
	david@redhat.com,
	kasong@tencent.com,
	yuzhao@google.com,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	willy@infradead.org,
	hannes@cmpxchg.org,
	ying.huang@intel.com,
	surenb@google.com,
	wajdi.k.feghali@intel.com,
	kanchana.p.sridhar@intel.com,
	corbet@lwn.net,
	zhouchengming@bytedance.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH RFC 0/2] mTHP-friendly compression in zsmalloc and zram based on multi-pages
Date: Thu, 28 Mar 2024 10:48:14 +1300
Message-Id: <20240327214816.31191-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

mTHP is generally considered to potentially waste memory due to fragmentation,
but it may also serve as a source of memory savings.
When large folios are compressed at a larger granularity, we observe a remarkable
decrease in CPU utilization and a significant improvement in compression ratios.

The following data illustrates the time and compressed data for typical anonymous
pages gathered from Android phones.

granularity   orig_data_size   compr_data_size   time(us)
4KiB-zstd      1048576000       246876055        50259962
64KiB-zstd     1048576000       199763892        18330605

Due to mTHP's ability to be swapped out without splitting[1] and swapped in as a
whole[2], it enables compression and decompression to be performed at larger
granularities.

This patchset enhances zsmalloc and zram by introducing support for dividing large
folios into multi-pages, typically configured with a 4-order granularity. Here are
concrete examples:

* If a large folio's size is 32KiB, it will still be compressed and stored at a 4KiB
  granularity.
* If a large folio's size is 64KiB, it will be compressed and stored as a single 64KiB
  block.
* If a large folio's size is 128KiB, it will be compressed and stored as two 64KiB
  multi-pages.

Without the patchset, a large folio is always divided into nr_pages 4KiB blocks.

The granularity can be configured using the ZSMALLOC_MULTI_PAGES_ORDER setting.

[1] https://lore.kernel.org/linux-mm/20240327144537.4165578-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-mm/20240304081348.197341-1-21cnbao@gmail.com/

Tangquan Zheng (2):
  mm: zsmalloc: support objects compressed based on multiple pages
  zram: support compression at the granularity of multi-pages

 drivers/block/zram/Kconfig    |   9 +
 drivers/block/zram/zcomp.c    |  23 ++-
 drivers/block/zram/zcomp.h    |  12 +-
 drivers/block/zram/zram_drv.c | 372 +++++++++++++++++++++++++++++++---
 drivers/block/zram/zram_drv.h |  21 ++
 include/linux/zsmalloc.h      |  10 +-
 mm/Kconfig                    |  18 ++
 mm/zsmalloc.c                 | 215 +++++++++++++++-----
 8 files changed, 586 insertions(+), 94 deletions(-)

-- 
2.34.1

