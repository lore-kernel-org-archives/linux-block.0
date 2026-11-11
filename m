Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379636;
	b=PCz7Dad1URA+xCt1+xDwmZNIJY+RaGkNX0vEkF+WIUXMqNokoJqoj4UfX5E1UkHyriEM
	 MzTDNPsFsgD/w9F5SYteVXbgH/plNG7dLW+Rl4bKuk9Dt9AKcJsAFxtiRKf5Dzt6aVktX
	 sDm6GylrqGJ6Ga3izFC/oEs4/3bB2zLt2mUEh+FrZhmCFMFHm1vmFVj5fMznFm5IwMrx4
	 hBVK+qpfyb1S7ckyQq0oacB12j/gnJDS1hkWfHZpmjck49VFfkTG42av3cKJQ08uGe9RN
	 bOYBaLCuU8Sfe+vZWWeL4QDdCZzUKrU+bXnr0bEgw1dUpX2y+bA9rJu6X2/xrKFzCNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4EiG4ohiaJ+2VhSrJi2s5uqPv+5cYMcFL4w9Bign1CU=;
	b=Muo2QIX3o4GvsvNf/M8Mid6Ty+1Ukzj13UH6X7pIVQloiyL9t1/bSrKfFG1joMDULdEp
	 NeLSf4+3iL+f5NoPj8/sq6kGswyoR0YwriskIML7WUoBMKEUReZN0ZJhogvY4lXdAjuIF
	 Tehf4LTL6U7s9+RZUICneH0GQy9XAhMOhwypz95tXUsMxkJd8s9bBFkZjYRHA5TfsBJvl
	 MjcVkMmWY0twIVxh8gngkmX4DZeAOiSrPhxLfaub7+jDRDQBosdCVWBc0DGF2GkHcQbdL
	 2u4bwPAxfHcEihc/nuBtUGYgM6pODP9HXG2L5Zi4/MN/Tl58QiyqV6/l4z3XPSkDbDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=knniPS1e;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A0D606A320
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 06:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97A0D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=knniPS1e
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b15e46698aso1382351a91.3
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 22:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794379635; x=1794984435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4EiG4ohiaJ+2VhSrJi2s5uqPv+5cYMcFL4w9Bign1CU=;
        b=knniPS1e72GntIsVk/zyaULRK+Nk4LLiHalU4UClNzfKUJK+jc58jcK1VWFaKflT8e
         Dro9Due/Q3ItEaAipvKKjmnciBiQROiPTN9U5xGeCtyxMqYACfRTlA2rv+eGQWIAw+CX
         BHkYkCQznjd8NrvbqzmfM0nnyA8G5yLofyLsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794379635; x=1794984435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4EiG4ohiaJ+2VhSrJi2s5uqPv+5cYMcFL4w9Bign1CU=;
        b=e+dYkrISWOOkv/PNQsA2zjd7nORbTq8rx2s6dY6p32VPwM0cnkrohZ/IrneEO+isUq
         c3PZAgXOt6N4e1mPcibrdLaOqA+GSCBZBxpI/ogS2E5wf3tddM+TIqjSat6l+eo77FAO
         VjILliKFMVf1J3DXnGwbWqoAPfSK4oXp648lzwydUDotK81mxiXvOVz3He3zRPA2Iwhv
         GTifLejTg8swX9CQovjO62zw2JCXbhx7jgGJEUfuIOXQN/S8xVK7z5bRibDoXrh4RUXX
         WAjOBKMH7bgetkmP1BeqtzSOAgM9hz3T+2afYWTEyMl3baeDi46uetefXCsEnA2ZVNGp
         H9gA==
X-Forwarded-Encrypted: i=1; AL+hErGR8eAxRsBjDlNUshYYOMHbtLELm2weLVxvJgJhtOFJo+/1bkXChKiUjAq57VRRKJbVQzbpU0EZj67VVg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+EcVNbG7YMYqoLojjyIWar4InfXEqxJgKyOvL50XUI3YdTYAVI
	AQGbcdTYapNCEt0q5zXBH/qE4n3e30m9tGhCIiV3LZb5dfOZRDZe/YU1EG51YjyuxA==
X-Gm-Gg: AYBFou0DFKImnJmNY0QXvaQo8uPt4n/yiSf78/K7c18VAzL7lpofR5281h6sqC0cwOy
	JKxWxejdQCVENkqNkjWR0CUCMHiEf9WoXF+KFzL1D1NLZui4DFC1O2SBwg0W55IXMS6DXx01TR1
	g4K4UV+oH6JVNbk56DGDHmnGtUWqxvNBjO1bIFnbH1NwaV0l/A68XgJFkqQ/QWcRropeBVV5/zh
	YbVoIEHAKr65E7oiYlXPPaxb3ocCM08Vte5AlwJdzWRQFP7jglYHKg53ATN0Kj82mw7owokaiWF
	0SqVlu+zy0atjxYSu7UejXH0vtQkTEx+RgiwWmgLcMKQEiKQ0FTmnEN77cMqaJbGPFUnobz8ARz
	+UfUEK8yNMAOeFCFb6VNzGgDkQDkD/7gX/zuRN5mL52OSrXNzobdcdKZFJdlZu3KOoqd4vMnNKt
	s704PYtsVmLBIJuTd+M0w262GlIE5SBvE4J6l2wpc+MDsvCnHjY/FgWzuT8UeDD9G/DInc1CwOa
	DD6PwjuMHuJeHM1kqnXZPy3xQl2kzZRvCzPBrn0qIA166PQN+i1mhehYychelJWOMEmrDCfpiHe
	IDVdQT72exunnrFykqC7fXkYXVoEu4CWokg8a/n7TMwvNQ9QEHsDicYesHEgv2BUtHryDTK0Ucp
	UcvEZBBMaAAXeQY8DgynZYZPWlmOGtPgXsBuD9+Y=
X-Received: by 2002:a17:90b:37c3:b0:3ab:413:49bc with SMTP id 98e67ed59e1d1-3b182ee2462mr1689014a91.37.1794379634902;
        Tue, 10 Nov 2026 22:47:14 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:ad6a:b446:df00:78dc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db85a9bsm3268666a91.14.2026.11.10.22.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:47:14 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v3 00/11] zsmalloc: redesign object alloc API
Date: Wed, 11 Nov 2026 15:46:23 +0900
Message-ID: <20261111064707.2568433-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both zram and zswap already have per-entry structures that store zsmalloc
handles, so allocating a separate handle_cachep object per stored page is
redundant.  This series embeds struct zs_handle directly into zram and
zswap entries and drops handle_cachep, saving 8 bytes and a slab
alloc/free per stored object (2MB per 1GB of swapped out 4K pages).

It also folds zs_malloc() and zs_obj_write() into zs_store() so we don't
take pool->lock and look up object location again right after allocation.

A simple zram test on a 24-vCPU VM
==================================
165 fewer kernel instructions and 0.7-1.8% fewer kernel cycles per write;
lz4 single writer +2.3% IOPS / -2.6% average latency;
24 writers +0.9-+1.0% IOPS; no regressions.
Memory: 8 bytes less per stored page.

v2 -> v3:
- addressed Sashiko review: alignment and READ/WRITE_ONCE mem_limit
- picked up review tags from Yosry and Nhat
- added handle validation helper
- change definition of ZS_HANDLE_SIZE

Sergey Senozhatsky (11):
  zram: drop stale comment in write_incompressible_page()
  zram: drop get_slot_handle() and set_slot_handle()
  zsmalloc: return handle from obj_allocated()
  zsmalloc: switch handle type to struct zs_handle
  zram: check mem_limit before allocating zsmalloc object
  zram: allocate zsmalloc object under slot lock
  zswap: do not free the entry if its pool is NULL
  zsmalloc: encode 1-based obj_idx so valid obj is never 0
  zsmalloc: embed struct zs_handle into zram and zswap entries
  zsmalloc: fold zs_obj_write() into zs_store()
  zsmalloc: populate new zspage outside class->lock in zs_store()

 Documentation/admin-guide/blockdev/zram.rst  |   4 +-
 Documentation/admin-guide/mm/slab.rst        |   2 +-
 Documentation/core-api/memory-allocation.rst |   2 +-
 Documentation/mm/zsmalloc.rst                |  22 +-
 drivers/block/zram/zram_drv.c                | 148 ++++------
 drivers/block/zram/zram_drv.h                |  10 +-
 include/linux/zsmalloc.h                     |  36 ++-
 mm/zsmalloc.c                                | 288 +++++++++++--------
 mm/zswap.c                                   |  28 +-
 9 files changed, 297 insertions(+), 243 deletions(-)

-- 
2.56.0.542.g3ef89b7020-goog

