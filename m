Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43AC32E121
	for <linux-block@vger.kernel.org>; Tue,  3 Mar 2026 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772538844; cv=none; b=azWsP2Bz9Fm3PQLAggYgz0LHsuhE3nLAnaIQ7abW9VA/wofvB/OOK4Y47P59/f5D9CFvaKqhv3aXSzNowkRZ01zqPQX+DG3DOJA45eTbIJ9d8USI2rNlX+1+t/NsxsMJhc6eOjApnJkcdSpDrmT+WdrUw4lpdP5JUDXrazCM15s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772538844; c=relaxed/simple;
	bh=qipa6ILRGS5cHACDxG5GUAIJUHNI19uAtI+n7ShwrEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mbMA+hOex4wuxuwVWLQBTG4y5iKzIp5UwCGncdOqZJN+US/6CeU03MacRyoFgBETqgdHhSWb8S7JQXGfmhXGHtGX2rrqfDpQKuo2EaWjQHXKYpY4wBhMzYfQozwM84A0xHGslFJTq4a9wZUJNqTEi9XCiVR3vBTHvPp6u1HN+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=t+0qZYd7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="t+0qZYd7"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso59541265e9.0
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2026 03:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1772538841; x=1773143641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VSbAaFhMKYH/6sDptBm4izzjlxKhysV1aVqA/IFmMak=;
        b=t+0qZYd7IkNiw5B8jFLkt2GnfHd4jDjfJG5WjdNDPSwMgFxkvRWlizAq0sP2h2/aUo
         JxsytFPjaYE+CRNn7AOO8RbKHNP5i17K04ueXbuiHdmashTbx49w7gvmKKUTGf3FOM2t
         05RJ7wv/BMlRmGqW0vQ8eiEdiVneofmptx0nzWfAC7KtqHWFTLdpBRXmX7qQ48m6GLwP
         2nq2lICGL0ccHRv08CXE7QjKNyOuaW3W1Euxdhfs/vi856QxaGG6hwHbsZnneUli5Pm/
         AOEoM6SCzIfjZXR9aHTZrfElwyz8kJ3zMugYFISz8hLNBO5gcbLvAFblQ22GUqk9oxlG
         Rd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772538841; x=1773143641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSbAaFhMKYH/6sDptBm4izzjlxKhysV1aVqA/IFmMak=;
        b=qnBZIGlE8gNyIXoELsZHQFXnH44oFWCReOfUl6ZQrMVunH3jdssA57TkWuWId2MF2u
         qDRMwkvHmA2WB3rjLqGJQ1pv6hafUxQ0IXiPMq+yzXoNpuWqEljnpoKxJK59fM77w69u
         8uy9d9HbIsM+Svb/fRkeMsSgSlVNTx7KhHx3XQc/3oMErHqnj6REB0yLnPBtOiTT7AOr
         Uu3HuAL3nxbqOelsOZLERsGQz/DH+ZpRBC9EZP9520HvyntGDE0s392ajEf8+wrKFJDJ
         RZY17+4b7H78MwggcZx+Z++OXRrzvuNO/LeJH2TPHlm/zv+pWUf/ZuMkMB3+yN1IPElB
         vE7w==
X-Forwarded-Encrypted: i=1; AJvYcCXjZ2UrDL3NLcIYPrguTrtVDYtNnTmiZc2PzAkfJ+HvNDJYJWiN4DIpkJ2+zpJefANvjQPPC366rNH9lA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz82qL/Xr3U49lYBDkXd25jZ+klb6re+FmCF2TPPpObRDMV7cuY
	8CNHxkdaehwKQpbjzHk0mMvdgOrmaHjf55dmYGG3geN/qpvUn93uB8ZMdlIkclfSGZM=
X-Gm-Gg: ATEYQzznaqqq2e3ct/HvBkvXaOwzXDh5hdE5u2yiDJXtWELfcNJlCvsQ6e7iYO1G51o
	A0bsPuEpLJfKNuuIOw72XURGTimrW7hI5OzIpobcbJv2ygP7Ors9rnJDkZaQJkJuZ/VFMG885LU
	HmpxgK4SYZHcBryvd78jaRUZZsFQfEKRrfylr6V+sIHArHnYVhR0kR98OGUqZL9N5ctJkVY2IkU
	qucdwYYYIXuBar4I4ITT3tf/oTY47Gz8p1yJfR/uApjd06/f+GiYECYZngciGYrs9F+3acZHbg+
	h4mCV97XZ6bpG4wCIFqqVF2T//7y+qxfWiRa0RxfNgaj1BCNzvpQbAP8m2mFaqYmzM4jqAx2Oq4
	vAxRwNxyBDjoitMDOV3lzFFE6AEJ726VDsRI76QKdTkyOj21bm4u393WLEUyWlLeEQ7RCW7QAl8
	tjo2+Uexkq3T2Ukg82h6BEvCQ=
X-Received: by 2002:a05:600c:a4b:b0:483:71f7:2797 with SMTP id 5b1f17b1804b1-483c9ba3785mr295878295e9.14.1772538840803;
        Tue, 03 Mar 2026 03:54:00 -0800 (PST)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::15:430])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b3cc2e65sm18598717f8f.2.2026.03.03.03.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 03:54:00 -0800 (PST)
From: Matt Fleming <matt@readmodwrite.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [RFC PATCH 0/1] mm: Reduce direct reclaim stalls with RAM-backed swap
Date: Tue,  3 Mar 2026 11:53:57 +0000
Message-ID: <20260303115358.1323188-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

Hi,

Systems with zram-only swap can spin in direct reclaim for 20-30
minutes without ever invoking the OOM killer. We've hit this repeatedly
in production on machines with 377 GiB RAM and a 377 GiB zram device.

The problem
-----------

should_reclaim_retry() calls zone_reclaimable_pages() to estimate how
much memory is still reclaimable. That estimate includes anonymous
pages, on the assumption that swapping them out frees physical pages.

With disk-backed swap, that's true -- writing a page to disk frees a
page of RAM, and SwapFree accurately reflects how many more pages can
be written. With zram, the free slot count is inaccurate. A 377 GiB
zram device with 10% used reports ~340 GiB of free swap slots, but
filling those slots requires physical RAM that the system doesn't have
-- that's why it's in direct reclaim in the first place.

The reclaimable estimate is off by orders of magnitude.

The fix
-------

This patch introduces two new flags: BLK_FEAT_RAM_BACKED at the block
layer (set by zram and brd) and SWP_RAM_BACKED at the swap layer. When
all active swap devices are RAM-backed, should_reclaim_retry() excludes
anonymous pages from the reclaimable estimate and counts only
file-backed pages. Once file pages are exhausted the watermark check
fails and the kernel falls through to OOM.

Opting to OOM kill something over spinning in direct reclaim optimises
for Mean Time To Recovery (MTTR) and prevents "brownout" situations
where performance is degraded for prolonged periods (we've seen 20-30
minutes degraded system performance).

Design choices and known limitations
-------------------------------------

Why not fix zone_reclaimable_pages() globally?

  Other callers (e.g. balance_pgdat() in kswapd) use the anon-inclusive
  count for different purposes. Changing it globally risks breaking
  kswapd's reclaim decisions in ways that are hard to test. Limiting
  the change to should_reclaim_retry() keeps the blast radius small and
  squarely in the direct reclaim path.

What about mixed swap configurations (zram + disk)?

  When at least one disk-backed swap device is active,
  swap_all_ram_backed is false and the current behaviour is preserved.
  Per-device reclaimable accounting is possible but it's a much larger
  change, and mixed zram+disk configurations are uncommon in practice
  AFAIK.

Can we make zram free space accounting more accurate?

  This is possible but probably the most complicated solution. Swap
  device drivers could provide a callback which RAM-backed drivers
  would use to estimate how much physical memory they could store given
  some average compression ratio (either historic or projected given a
  list of anon pages to swap) and the amount of free physical memory.
  Plus, this wouldn't be constant and would change on every invocation
  of the callback inline with the current compression ratio and the
  amount of free memory.

Build-testing
-------------

Built with defconfig, allnoconfig, allmodconfig, and multiple
randconfig iterations on x86_64 / 7.0-rc2.

Matt Fleming (1):
  mm: Reduce direct reclaim stalls with RAM-backed swap

 drivers/block/brd.c           |  3 ++-
 drivers/block/zram/zram_drv.c |  3 ++-
 include/linux/blkdev.h        |  8 ++++++
 include/linux/swap.h          |  9 +++++++
 mm/page_alloc.c               | 23 ++++++++++++++++-
 mm/swapfile.c                 | 47 ++++++++++++++++++++++++++++++++++-
 6 files changed, 89 insertions(+), 4 deletions(-)

-- 
2.43.0
