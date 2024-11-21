Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DDA1ABEB0
	for <linux-block@vger.kernel.org>; Thu, 21 Nov 2024 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732227951; cv=none; b=oDU/aSmsC8LhkKW7MDhatE5nmDkVwFF0mnAdB+/wkKjCAnspMdItd7qQErl/LWT5fsdjjJL4t3Y4NlGpCE6uyWyJwyz1LsFF84NdLRwNhn2vQHdynGIzseSiFtZ/7GjMPUIfB9L00OUmicZs79vIJUcGfgp1KnfmdQAV54c03LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732227951; c=relaxed/simple;
	bh=miwvqFUN+kc6HfohTzsQg1F3qVCySdl318ieY/OmB3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M5lBIeTZSisHjJf1buyiZL8GskcCrDUD6MV6CCbSBetqEIDlcUHr27MIIgjrvLkPBjyMKd6JnsYMOJxpAooZxZTBhsEqSga2KchHXygdJT3dsdfTxBO/5MQX8L9VcHqFsNghMbLh28r7WfEjdPtarAyfmjv2DpM8fA7OYv1zVVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZ7qk6vG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZ7qk6vG"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-720c286bcd6so1340985b3a.3
        for <linux-block@vger.kernel.org>; Thu, 21 Nov 2024 14:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732227949; x=1732832749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Guh7Yn9Hc4d+8Fk3RwLTIYPaNCb6Z7W95umc9lFaHl0=;
        b=EZ7qk6vGCCzxsKwD1jaKJtH2UCAB39XTp9QVICyRFxiBt39vr3x0cLuPcouyXq3epc
         zYSpfXJK+uu+J5qYnHbJ6xEY9R6Lmnjw4J8EbKAChvg83inaSWCuKpbRJG12Z2HtFh+i
         rlcjQA84a8o1gdoIhiHlfAxFaQwNM6lwdq06XgzANc5aIIKC8iJXsjVoXqFTTZOcp24C
         9GxPfa3OQLFsVWz2OrLZohFkV/4Tptg47y8ZSOmYzC64rxhYuPtFEukiTvXAxSX7muUY
         5RxxUZX+Xo7iFQjpWnZuGX7/KmlzzZRiDwETYC06sopJYp/r4s3OG9BJg6HG9Lx1dCLL
         muaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732227949; x=1732832749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Guh7Yn9Hc4d+8Fk3RwLTIYPaNCb6Z7W95umc9lFaHl0=;
        b=vms7RWepqd9+4qY1xpvPr1AJUM73dhMXDLIvkW8skE7DNyXyVJHMCJk+eDTZf+GFBW
         VdJ8waxFAp/AtDEQsUcaWyaOZF5jtCuaqs3PMylAy63WIU/bQQXvsVqn2wE13z1LHeaW
         87U4Ma5SPI5sAhlOH9zmXt1/pqz77teAZUAFWbFip8OlEQ4PWcMOBpqEIY5dP/QXteNn
         9xaVN3fo3mH49aveGidnl/Rd9j8q4MuTffpld5xrI68W1H6P6kbK9LKroBi0z45VBRuY
         GdnwC52CxtcruRWYie/GEn4CMJrvEk25IhZzsT+9nkoYGZ8oFbY7TMqzxvtvQzuAL4Ty
         Fw1w==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1R+z5N9+9sx4ov/XAeVldSPAZXYxBdyp2lGe3+3aC7Vakg82dBo20tjxODyD1eCKC9Mo5DnDNkOMFw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj41lLQOryTgTdKTrfjZUU/g+lW5P02xbKnyqXikPjWkfgCrGA
	b/qQjQhaXxGdK0IBxXw27aBM+jeYY9vBtv6G2TR9EZAVD/IyA+ou
X-Gm-Gg: ASbGncvbucN7tFI8SW4xl5WVDnUeb1ajzv/lLWjEvUqgD9t/pgG9ruREPjBcrvbZQ1D
	wsyldri6f3Q6tTW7o3+4Rimbm1j15848YNUD6S+gQs1JjRSglfq0k51GM3hespAN1lhQdI6PXku
	jeMrH3Ntq8s9de6zoGpfs2yCDC8BMBdlvGNGkyHc1TwIY/th2dU56iB6Uuwd8kOSeNPzPW/DCVf
	r5oPb6GGjuLd3LH5sEsBuPYIuGhtNlHzxw7h6CdOyF/+AgY2VaTsJfqed3JE3jCOcYazd0P
X-Google-Smtp-Source: AGHT+IETA4wpw+VnntD97h/Hb+AphNIR21B0ZEPJo5fYxt7LbjH5bsj0mzFINEemUwE3VvHhaOk8Nw==
X-Received: by 2002:a17:902:f686:b0:20c:e1f5:48c7 with SMTP id d9443c01a7336-2129f830574mr5131335ad.55.1732227948865;
        Thu, 21 Nov 2024 14:25:48 -0800 (PST)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:9d64:b0ba:faf2:680e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba22f4sm3334745ad.100.2024.11.21.14.25.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 21 Nov 2024 14:25:48 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: axboe@kernel.dk,
	bala.seshasayee@linux.intel.com,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	kanchana.p.sridhar@intel.com,
	kasong@tencent.com,
	linux-block@vger.kernel.org,
	minchan@kernel.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	senozhatsky@chromium.org,
	surenb@google.com,
	terrelln@fb.com,
	usamaarif642@gmail.com,
	v-songbaohua@oppo.com,
	wajdi.k.feghali@intel.com,
	willy@infradead.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	zhengtangquan@oppo.com,
	zhouchengming@bytedance.com
Subject: [PATCH RFC v3 0/4] mTHP-friendly compression in zsmalloc and zram based on multi-pages
Date: Fri, 22 Nov 2024 11:25:17 +1300
Message-Id: <20241121222521.83458-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

When large folios are compressed at a larger granularity, we observe
a notable reduction in CPU usage and a significant improvement in
compression ratios.

mTHP's ability to be swapped out without splitting and swapped back in
as a whole allows compression and decompression at larger granularities.

This patchset enhances zsmalloc and zram by adding support for dividing
large folios into multi-page blocks, typically configured with a
2-order granularity. Without this patchset, a large folio is always
divided into `nr_pages` 4KiB blocks.

The granularity can be set using the `ZSMALLOC_MULTI_PAGES_ORDER`
setting, where the default of 2 allows all anonymous THP to benefit.

Examples include:
* A 16KiB large folio will be compressed and stored as a single 16KiB
  block.
* A 64KiB large folio will be compressed and stored as four 16KiB
  blocks.

For example, swapping out and swapping in 100MiB of typical anonymous
data 100 times (with 16KB mTHP enabled) using zstd yields the following
results:

                        w/o patches        w/ patches
swap-out time(ms)       68711              49908
swap-in time(ms)        30687              20685
compression ratio       20.49%             16.9%

I deliberately created a test case with intense swap thrashing. On my
Intel i9 10-core, 20-thread PC, I imposed a 1GB memory limit on a memcg
to compile the Linux kernel, intending to amplify swap activity and
analyze its impact on system time. Using the ZSTD algorithm, my test
script, which builds the kernel for five rounds, is as follows:

#!/bin/bash

echo never > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enabled
echo never > /sys/kernel/mm/transparent_hugepage/hugepages-32kB/enabled
echo always > /sys/kernel/mm/transparent_hugepage/hugepages-16kB/enabled
echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled

vmstat_path="/proc/vmstat"
thp_base_path="/sys/kernel/mm/transparent_hugepage"

read_values() {
    pswpin=$(grep "pswpin" $vmstat_path | awk '{print $2}')
    pswpout=$(grep "pswpout" $vmstat_path | awk '{print $2}')
    pgpgin=$(grep "pgpgin" $vmstat_path | awk '{print $2}')
    pgpgout=$(grep "pgpgout" $vmstat_path | awk '{print $2}')
    swpout_64k=$(cat $thp_base_path/hugepages-64kB/stats/swpout 2>/dev/null || echo 0)
    swpout_32k=$(cat $thp_base_path/hugepages-32kB/stats/swpout 2>/dev/null || echo 0)
    swpout_16k=$(cat $thp_base_path/hugepages-16kB/stats/swpout 2>/dev/null || echo 0)

    swpin_64k=$(cat $thp_base_path/hugepages-64kB/stats/swpin 2>/dev/null || echo 0)
    swpin_32k=$(cat $thp_base_path/hugepages-32kB/stats/swpin 2>/dev/null || echo 0)
    swpin_16k=$(cat $thp_base_path/hugepages-16kB/stats/swpin 2>/dev/null || echo 0)

    echo "$pswpin $pswpout $swpout_64k $swpout_32k $swpout_16k $swpin_64k $swpin_32k $swpin_16k $pgpgin $pgpgout"
}

for ((i=1; i<=5; i++))
do
  echo
  echo "*** Executing round $i ***"
  make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- clean 1>/dev/null 2>/dev/null
  echo 3 > /proc/sys/vm/drop_caches

  #kernel build
  initial_values=($(read_values))
  time systemd-run --scope -p MemoryMax=1G make ARCH=arm64 \
        CROSS_COMPILE=aarch64-linux-gnu- vmlinux -j20 1>/dev/null 2>/dev/null
  final_values=($(read_values))

  echo "pswpin: $((final_values[0] - initial_values[0]))"
  echo "pswpout: $((final_values[1] - initial_values[1]))"
  echo "64kB-swpout: $((final_values[2] - initial_values[2]))"
  echo "32kB-swpout: $((final_values[3] - initial_values[3]))"
  echo "16kB-swpout: $((final_values[4] - initial_values[4]))"
  echo "64kB-swpin: $((final_values[5] - initial_values[5]))"
  echo "32kB-swpin: $((final_values[6] - initial_values[6]))"
  echo "pgpgin: $((final_values[8] - initial_values[8]))"
  echo "pgpgout: $((final_values[9] - initial_values[9]))"
done

******************  Test results

******* Without the patchset:

*** Executing round 1 ***

real	7m56.173s
user	81m29.401s
sys	42m57.470s
pswpin: 29815871
pswpout: 50548760
64kB-swpout: 0
32kB-swpout: 0
16kB-swpout: 11206086
64kB-swpin: 0
32kB-swpin: 0
16kB-swpin: 6596517
pgpgin: 146093656
pgpgout: 211024708

*** Executing round 2 ***

real	7m48.227s
user	81m20.558s
sys	43m0.940s
pswpin: 29798189
pswpout: 50882005
64kB-swpout: 0
32kB-swpout: 0
16kB-swpout: 11286587
64kB-swpin: 0
32kB-swpin: 0
16kB-swpin: 6596103
pgpgin: 146841468
pgpgout: 212374760

*** Executing round 3 ***

real	7m56.664s
user	81m10.936s
sys	43m5.991s
pswpin: 29760702
pswpout: 51230330
64kB-swpout: 0
32kB-swpout: 0
16kB-swpout: 11363346
64kB-swpin: 0
32kB-swpin: 0
16kB-swpin: 6586263
pgpgin: 145374744
pgpgout: 213355600

*** Executing round 4 ***

real	8m29.115s
user	81m18.955s
sys	42m49.050s
pswpin: 29651724
pswpout: 50631678
64kB-swpout: 0
32kB-swpout: 0
16kB-swpout: 11249036
64kB-swpin: 0
32kB-swpin: 0
16kB-swpin: 6583515
pgpgin: 145819060
pgpgout: 211373768

*** Executing round 5 ***

real	7m46.124s
user	80m29.780s
sys	41m37.005s
pswpin: 28805646
pswpout: 49570858
64kB-swpout: 0
32kB-swpout: 0
16kB-swpout: 11010873
64kB-swpin: 0
32kB-swpin: 0
16kB-swpin: 6391598
pgpgin: 142354376
pgpgout: 20713566


******* With the patchset:

*** Executing round 1 ***

real	7m43.760s
user	80m35.185s
sys	35m50.685s
pswpin: 29870407
pswpout: 50101263
64kB-swpout: 0
32kB-swpout: 0
16kB-swpout: 11140509
64kB-swpin: 0
32kB-swpin: 0
16kB-swpin: 6838090
pgpgin: 146500224
pgpgout: 209218896

*** Executing round 2 ***

real	7m31.820s
user	81m39.787s
sys	37m24.341s
pswpin: 31100304
pswpout: 51666202
64kB-swpout: 0
32kB-swpout: 0
16kB-swpout: 11471841
64kB-swpin: 0
32kB-swpin: 0
16kB-swpin: 7106112
pgpgin: 151763112
pgpgout: 215526464

*** Executing round 3 ***

real	7m35.732s
user	79m36.028s
sys	34m4.190s
pswpin: 28357528
pswpout: 47716236
64kB-swpout: 0
32kB-swpout: 0
16kB-swpout: 10619547
64kB-swpin: 0
32kB-swpin: 0
16kB-swpin: 6500899
pgpgin: 139903688
pgpgout: 199715908

*** Executing round 4 ***

real	7m38.242s
user	80m50.768s
sys	35m54.201s
pswpin: 29752937
pswpout: 49977585
64kB-swpout: 0
32kB-swpout: 0
16kB-swpout: 11117552
64kB-swpin: 0
32kB-swpin: 0
16kB-swpin: 6815571
pgpgin: 146293900
pgpgout: 208755500

*** Executing round 5 ***

real	8m2.692s
user	81m40.159s
sys	37m11.361s
pswpin: 30813683
pswpout: 51687672
64kB-swpout: 0
32kB-swpout: 0
16kB-swpout: 11481684
64kB-swpin: 0
32kB-swpin: 0
16kB-swpin: 7044988
pgpgin: 150231840
pgpgout: 215616760

Although the real time fluctuated significantly on my PC, the
sys time has clearly decreased from over 40 minutes to just
over 30 minutes across all five rounds.

-v3:
 * Added a patch to fall back to four smaller folios to avoid partial reads.
   discussed this option with Usama, Ying, and Nhat in v2. Not entirely sure
   it will be well-received, but I've done my best to minimize the complexity
   added to do_swap_page().
 * Add a patch to adjust zstd backend estimated_src_size;
 * Addressed one VM_WARN_ON in patch 1 for PageMovable();

-v2:
 https://lore.kernel.org/linux-mm/20241107101005.69121-1-21cnbao@gmail.com/

 While it is not mature yet, I know some people are waiting for
 an update :-)
 * Fixed some stability issues.
 * rebase againest the latest mm-unstable.
 * Set default order to 2 which benefits all anon mTHP.
 * multipages ZsPageMovable is not supported yet.

Barry Song (2):
  zram: backend_zstd: Adjust estimated_src_size to accommodate
    multi-page compression
  mm: fall back to four small folios if mTHP allocation fails

Tangquan Zheng (2):
  mm: zsmalloc: support objects compressed based on multiple pages
  zram: support compression at the granularity of multi-pages

 drivers/block/zram/Kconfig        |   9 +
 drivers/block/zram/backend_zstd.c |   6 +-
 drivers/block/zram/zcomp.c        |  17 +-
 drivers/block/zram/zcomp.h        |  12 +-
 drivers/block/zram/zram_drv.c     | 450 ++++++++++++++++++++++++++++--
 drivers/block/zram/zram_drv.h     |  45 +++
 include/linux/zsmalloc.h          |  10 +-
 mm/Kconfig                        |  18 ++
 mm/memory.c                       | 203 +++++++++++++-
 mm/zsmalloc.c                     | 235 ++++++++++++----
 10 files changed, 896 insertions(+), 109 deletions(-)

-- 
2.39.3 (Apple Git-146)

