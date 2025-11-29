Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AF92F85B
	for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764406898; cv=none; b=u50j5rnbPoDceOxXjrUPJSdmcgUEiz1JI/qkXTq2PqNFfkI5YvxrfZFCSBiuQfw4V/5GS2a+yFhBSMbz4H8huTs9nuJSGW3SgQvg3vh2IxbY+HW/UTTZyZtHXesrtx5RrgDdg8mFDBppMAxNUiLkaZGaeFWQkG2qrX5zQ2/HNbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764406898; c=relaxed/simple;
	bh=udx+3WBqGc/iZ7as5xnrvfqI/p1WkcIHAta6MoMWPi4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tc2ezy81CzTOHvMM6ow/oFSSMuTbZke9UhpWN/AoPhzS6bJ+jNAnF/4pqzPf08oe5nKMUJnd43E1MlmmbjRHhXRXCftRUbd2vBC0Vum68SZYq5nTzonyLQsT59I9GBXFNKbDUKngMwQbF7/KwQd4b+v7Qw4Lp25+IfqMSQcu6Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEfz5RUn; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEfz5RUn"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3434700be69so3595722a91.1
        for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 01:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764406895; x=1765011695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zmb+ZHVry5p28b7GMkq+CDhLkRiYxaAasQNxk151Gb4=;
        b=IEfz5RUnOLgSibGxGwecAyJKnizPidfBwFepBIaje+zlu5Gf6SfBiBhcDw8nhINvZm
         b3BZEWJ4E1I0WIjJTEe41GJWpricLQFrbPHAixKQZANBVSa5IEZwM4ADiCNygUMNLalM
         FBcFomhGlKEpQy2ClD4rJ68c/SbhWkIAZSezAa70CIJ8hm49MOmxlJN6Z6ha3SlJu6ht
         tw9su/3D0F6ewdQjO32iy1J1Q9FRfriZvkcaJeTb7WaXGbZdoJjS2a6KIxe62rutvPqf
         ZqXSiDFQLODQhOttqRAX/M+uQEcOvelrY74gwcl7bXstpuJUNMafStRmql00t1RGOoF4
         C1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764406895; x=1765011695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmb+ZHVry5p28b7GMkq+CDhLkRiYxaAasQNxk151Gb4=;
        b=xN/WUhWTTnUNNlkAdhaYaIB0pSYsO8WT+ds2KPrvvhNmY0M5IoDbsJvPbx4IF8COLx
         Om+H2zlCkkYlvG5t3CHdEQxsyYIDkJfdX0UfOjIybPvRqnZtV1OexyLla0jXUQKkD4Nc
         5tFGD/V4hPGmXYa2JvMB2hnDUW4PlRvOM/d6pnO0t74CZepUQuTmMC1g50m9JFP6jFJb
         ETDre4bLzyxA52qBr/1YS8qIS8WKj2rQWKUvBMS1LHEjSXWjMdI86tTk3ZUHP1/R9zEx
         dOm4i+tF+lNvN3kVsyrResTsf6gZyVCf5Ya8NKu9TynJF46LEsUFXEgE7Z+q2LOiFF0B
         9JTg==
X-Gm-Message-State: AOJu0Yw2i7K5QLikIlqPRh5ZISR/V9pmeyp1zI6qddSt+lpWky4gectG
	0vGPxjcNs2ucnaxvwUN6uiC9Oq0QN0Ub/6qBl+0csdwNW+8AKAnjWhSf
X-Gm-Gg: ASbGnct6zFaGEVAp/oNwFsOantAr6ZbqA+OqWtDgTaiknhVVt6ssh3hxEt5BKiV1OHh
	TIp6UruuwTm6xTqPDjq8PGUhSpntMGEdoZhpORRAWdMxAnd3aVe2eIZnQEt4cBcifbWrRE9xv1r
	tXw/VaeFbqwKMAA2GexI5ao3Hh2jMQpN8Gh5vwpEOKj2aeNqZEiIIGlQVimtwkjNB/ksAwbmSJc
	pK7gS7RqonqQfytRXz0xewamb3GbMpuMS89/sm8530ggQ8A9tOAHB5s/IONKF8LWy/0S2xmPA+z
	M0iOyDtt7nH3BVB+tJbKJjn+JgqH6ZWz3oZn5mrTV3ktGdaLBX6WJ7ZjJLEgk5EtcHfbd8fxa6a
	2nJnCoGmtlFo3C34lKDWeVH+o7PUdCK9rbuSLOaaFkggo7g+kzpfvx71TnjLSzUcz6Y5jwgvf3v
	OCrPUJnu00BDp1jB333RB7eHazsQ==
X-Google-Smtp-Source: AGHT+IE+fzqDQu1/Vmc8yqQsUeHiqyOOoex9+WFx6oQ8MiOIB4Rr8lIb32V7wQkpFMTkrQakUPAF2A==
X-Received: by 2002:a05:7022:ba9:b0:11a:49bd:be28 with SMTP id a92af1059eb24-11cb3ec36cdmr14203629c88.4.1764406895410;
        Sat, 29 Nov 2025 01:01:35 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm28114394c88.0.2025.11.29.01.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:01:35 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	agruenba@redhat.com,
	ming.lei@redhat.com,
	hsiangkao@linux.alibaba.com,
	csander@purestorage.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v3 0/9] Fix bio chain related issues
Date: Sat, 29 Nov 2025 17:01:13 +0800
Message-Id: <20251129090122.2457896-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Hi all,

While investigating another problem [mentioned in v1], we identified
some buggy code in the bio chain handling logic. This series addresses
those issues and performs related code cleanup.

Patches 1-3 fix incorrect usage of bio_chain_endio().
Patches 4-9 clean up repetitive code patterns in bio chain handling.

v3:
- Remove the dead code in bio_chain_endio and drop patch 1 in v2 
- Refined the __bio_chain_endio changes with minor modifications (was
  patch 02 in v2).
- Dropped cleanup patches 06 and 12 from v2 due to an incorrect 'prev'
  and 'new' order.

v2:
- Added fix for bcache.
- Added BUG_ON() in bio_chain_endio().
- Enhanced commit messages for each patch
https://lore.kernel.org/all/20251128083219.2332407-1-zhangshida@kylinos.cn/

v1:
https://lore.kernel.org/all/20251121081748.1443507-1-zhangshida@kylinos.cn/

Shida Zhang (9):
  md: bcache: fix improper use of bi_end_io
  block: prohibit calls to bio_chain_endio
  block: prevent race condition on bi_status in __bio_chain_endio
  block: export bio_chain_and_submit
  xfs: Replace the repetitive bio chaining code patterns
  block: Replace the repetitive bio chaining code patterns
  fs/ntfs3: Replace the repetitive bio chaining code patterns
  zram: Replace the repetitive bio chaining code patterns
  nvdimm: Replace the repetitive bio chaining code patterns

 block/bio.c                   | 12 +++++++++---
 drivers/block/zram/zram_drv.c |  3 +--
 drivers/md/bcache/request.c   |  6 +++---
 drivers/nvdimm/nd_virtio.c    |  3 +--
 fs/ntfs3/fsntfs.c             | 12 ++----------
 fs/squashfs/block.c           |  3 +--
 fs/xfs/xfs_bio_io.c           |  3 +--
 fs/xfs/xfs_buf.c              |  3 +--
 fs/xfs/xfs_log.c              |  3 +--
 9 files changed, 20 insertions(+), 28 deletions(-)

-- 
2.34.1

