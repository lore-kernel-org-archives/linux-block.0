Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0B9217F24
	for <linux-block@vger.kernel.org>; Thu, 27 Nov 2025 01:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764207559; cv=none; b=RksZoxWB96VtHc3FrKCzLofho4oGy3Uamk6WB+/LBWxGHwlHneSKWsIiUiunbPsgAyJzQMlvvtm9rKlu7HfB8iicLlt0/tb0NQCU6sGHLWdlM0gyGDC57yKc7Zfb3Q+UJroB2K4jGQP2vrOY4ItHUu0XLTop/p61+I6dqW00T9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764207559; c=relaxed/simple;
	bh=bJ9HiDBPUwBaMJQclgBWO5wdkiPelY80UVWQeIsC01Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=svFR3c7D7nanJIfAEqVOJrNQAMeznzGoUyMgnaG5jjgQOTBgwlVfrAaNmulxJXAUDGWuUXw2pwvBhyGwQu5uMIvjNNqf2voYSPqvfsiFvWMZ6H2TA3xOL1nmLpGM25qD1RCOrFnAeWpyxtEazue+RAk032YQvrbNdl5RYW2tb0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kub6fWoG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kub6fWoG"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297dc3e299bso3592575ad.1
        for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 17:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764207557; x=1764812357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OcUOZJMFbmvct+2rc0kf2MpUvY7Rm9JZKzksiGf/aoA=;
        b=Kub6fWoGZmJTWx41j+BeC/wGEOveXjPnpidIIe2hAYi9TWtabddoex1KPY6/EuiRx9
         AkppQzRNUi8RhoM39gQXakjxRwqZZboeApoLDd43/vsTJJwH8SCyix0TwGpEv/zeSAPu
         yCv6uqm0VjlrW0cmUws6Bvx8m409vZ5PKW+5k59kzps3DG6Q3yDMSaZg/Qc9KKy4Mutb
         yr/ERfkDShLYoSn5mBY7pOZHqoufFvNjEZiHKnZOTEyA5T50zEWfFHMS8un8kRxo9v6j
         w2SDsUR77dKdXh0UEn+SVkVF2DNAN6pfPwyazI2rksEX1G8LzUs+llunTtCH40EfZuTz
         BafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764207557; x=1764812357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcUOZJMFbmvct+2rc0kf2MpUvY7Rm9JZKzksiGf/aoA=;
        b=cRf21e9wxJ7I0CpgyNH4702cow1aY8ZfT5fTwXUpR4wntwyy9B6jstdHM5n38CdF7o
         X2MpK89g/a3llk6EijHNuVzNcEuC19EPG67Ewn4lFJvbyKiHYYpXRHAqPJwbf7i7pIQA
         bjx11KWk6EARg0Faw2fZfD53E2jF2+dkToTPvzvdvqgY3keRV756Up/lgoxAyIfwDOhF
         x0Ftl3jqrIPljeZruAeZLdSl68ftHFWyng9jJ7nhnDfUnkXhYCsAk/4XH96G7p+1lwkZ
         vW8cG76mZ1zUVnIltbJFrUA/VHLajmAcpH04QhV9TV6+jDv57E3veWxntHbOXYs4PzFH
         uS9g==
X-Forwarded-Encrypted: i=1; AJvYcCUPXod0xw8sJnkHQ11prOiZDZeEivAuIvI+ZmTww+74miVdvdX/a4d/P49HIeqwO9f5bKsTKY8oRXYMQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5GIYyxyg5WCJoLyfUR4Ieu1nun6MTmpDsPl+KfrRYJq5r/PMB
	oFO4XeelFkI1lCLA0GjyuWKZj1+OmRuI3GmhtR0hcSA6uNHr83+AUwSwo1yl8g==
X-Gm-Gg: ASbGncsVuBfcts5iEu/1y0RVM4WJqXhsHwwg2PMBO2pxlkBsvJdFM7cbEuCRjyM5WT4
	JiuqYpgtiAGxFnu5rWWaqmAE0GPa41FWnpy+822BoRltEBTfzpgoUJ1Vfqf7Np5RJkhcrjgZ5l7
	plWP1mcSVst7UaxDpXBzkHe/s80DBL8XcgzCCy2O9R70MQgOArApM0DqimbOIN1LIVdz8Q720HK
	S4ob0ZP2iKcjGq6osZ6f5wytfz/nBusH2y19st/FbWFCneJupzP6DO951ef1/fEp6O64vm5Or8X
	BquEkb/6VoHe2N2EZk60bSqI8Cp4vBu6Wj2i/h2tmQpk78ZBkK6ZA5wFnxBkbGSFsjZTsOHEug9
	HaPuNf34zktGmlDYnrRdbg7Ew1DaA/8TMDnMtyI0Rcv1LUoj3h3F901pqnOwNiP/w+Pi7NYS0WO
	RSNhgEalM866Yw5lxSNqHHUqEZqlC4kQIfo7xjTQ==
X-Google-Smtp-Source: AGHT+IFk98XWHAUGr65cVN7wtb0vMquhdnfPdlUn2g07hFesnnCjyEN+j4z7OoOuD8FzSa+xROuG/Q==
X-Received: by 2002:a17:903:2412:b0:297:f0a8:e84c with SMTP id d9443c01a7336-29bab1d73ebmr96072805ad.52.1764207556658;
        Wed, 26 Nov 2025 17:39:16 -0800 (PST)
Received: from localhost.localdomain ([101.71.133.196])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29b5b107cc2sm212427815ad.16.2025.11.26.17.39.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Nov 2025 17:39:16 -0800 (PST)
From: Fengnan Chang <fengnanchang@gmail.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	hare@suse.de,
	hch@lst.de,
	yukuai3@huawei.com
Cc: Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH v2 0/2] blk-mq: use array manage hctx map instead of xarray
Date: Thu, 27 Nov 2025 09:39:06 +0800
Message-Id: <20251127013908.66118-1-fengnanchang@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fengnan Chang <changfengnan@bytedance.com>

After commit 4e5cc99e1e48 ("blk-mq: manage hctx map via xarray"), we use
an xarray instead of array to store hctx, but in poll mode, each time
in blk_mq_poll, we need use xa_load to find corresponding hctx, this
introduce some costs. In my test, xa_load may cost 3.8% cpu.

After revert previous change, eliminates the overhead of xa_load and can
result in a 3% performance improvement.

potentital use-after-free on q->queue_hw_ctx can be fixed by use rcu to
avoid, same as Yu Kuai did in [1].

[1] https://lore.kernel.org/all/20220225072053.2472431-1-yukuai3@huawei.com/

Fengnan Chang (2):
  blk-mq: use array manage hctx map instead of xarray
  blk-mq: fix potential uaf for 'queue_hw_ctx'

 block/blk-mq-tag.c     |  2 +-
 block/blk-mq.c         | 63 ++++++++++++++++++++++++++++--------------
 block/blk-mq.h         | 13 ++++++++-
 include/linux/blk-mq.h |  3 +-
 include/linux/blkdev.h |  2 +-
 5 files changed, 58 insertions(+), 25 deletions(-)


base-commit: 4941a17751c99e17422be743c02c923ad706f888
-- 
2.39.5 (Apple Git-154)

