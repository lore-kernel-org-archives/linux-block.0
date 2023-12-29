Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94346125B5
	for <linux-block@vger.kernel.org>; Fri, 29 Dec 2023 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PFRiW16s"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d48a8ed85bso4238125ad.0
        for <linux-block@vger.kernel.org>; Fri, 29 Dec 2023 07:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703865439; x=1704470239; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Be72KkDVCIIDTFwt9sz6alSufM7NA5Er9iysI7Bzf0c=;
        b=PFRiW16s88Sb3m5O8sq8BPBUChMVY6h8bm/2We5JkntUROY35o9kbDyUYYAJcC4rvR
         9rqm6LE6k/aa7/fZApUb3OUCFNtb/hz1WrK4tEYe24rLu+T+jfDQ+4OHWzydKoHmg/4j
         nl2Sz4Ixdu18wTMNYmFxTe0JjT0ZhZpeE2VesktQVnU8pjhmEmkx8nY1x0yHAKuw9YoM
         veEAUjtfXW15f39ExONGNLZsAO9Sk/KmypsSkmvhvd3uho0Luwwi8BFIlXCmBGkFLDjB
         0YHI085Yo9IRT5tl+tJHSzNnTHNywixMa/p3l7m1HKw9ukyHRyU1cHX1qWOYj61FoYD+
         BXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703865439; x=1704470239;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Be72KkDVCIIDTFwt9sz6alSufM7NA5Er9iysI7Bzf0c=;
        b=AzuQcm/O3OJcNJ6TA9pf67tBlYeLU67CYowEsiJKnBHJJlk4cAS/CWnmbBkbYVM5+P
         rORvMscOJPuZcslLFREiZLi0iEIKnJgQY6gF2bgQZuSRvCuXYQMo+1NqPI3zzz97R1jA
         5TtizS7OXPMh0jNQF3Cfld8pyBDPJlX2gE126rXW+omoNwvg61qUAGoEry/05McAS/fA
         QfxsZj4geycVHPQRA1wR2fYdetDR67sD2J7/WfvlQtbDt1dpmtHqb3nDGus1E+kvNcvs
         76utdV2QoR7pUEF1l7vBoohrxlXV7FKAwWzHLrd58ilXk/EXcgFHdTR0vYLOqL2fSLgs
         2uEw==
X-Gm-Message-State: AOJu0YyLZ+AsYABS0AETyVXZa+8WjmJ2xKcbzLAGsoZzRGM/uY0L6+PJ
	F39unZArHLNJqLTMOWuOgb3Wy3io5mGkODNpCoCmFHIlzbP/zw==
X-Google-Smtp-Source: AGHT+IEGBwnvW5ke5kJrQ8NVGWcyIJIL7ZjCVIoeVUgzAZMbaHf72w/PviPs+FFngBdW9M/dd42H0w==
X-Received: by 2002:a17:902:f68e:b0:1d3:e001:5953 with SMTP id l14-20020a170902f68e00b001d3e0015953mr22391936plg.5.1703865438885;
        Fri, 29 Dec 2023 07:57:18 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902ec8700b001d08e08003esm15881510plg.174.2023.12.29.07.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 07:57:18 -0800 (PST)
Message-ID: <7ecffd8c-8fc0-424d-9936-b02a5957e0a3@kernel.dk>
Date: Fri, 29 Dec 2023 08:57:17 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.7-rc8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Fix for a badly numbered flag, and a regression fix for the badblocks
updates from this merge window. Please pull!


The following changes since commit 13d822bf1cba78612b22a65b91cd6d4d443b6254:

  Merge tag 'nvme-6.7-2023-12-21' of git://git.infradead.org/nvme into block-6.7 (2023-12-21 14:32:35 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.7-2023-12-29

for you to fetch changes up to 02d374f3418df577c850f0cd45c3da9245ead547:

  block: renumber QUEUE_FLAG_HW_WC (2023-12-26 09:25:58 -0700)

----------------------------------------------------------------
block-6.7-2023-12-29

----------------------------------------------------------------
Christoph Hellwig (1):
      block: renumber QUEUE_FLAG_HW_WC

Coly Li (1):
      badblocks: avoid checking invalid range in badblocks_check()

 block/badblocks.c      | 6 ++++--
 include/linux/blkdev.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
Jens Axboe

