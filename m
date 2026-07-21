Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE9A30EF9A
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652086; cv=none; b=dqkBVew9ixRVBvQwnwEPc0RwiZZS9nAbDjvpLP76Bd8R1ELvNDYCrmkclIJlLkHMRH6lqt+jIoWK65gnqHpDOYQms2rKGROkX9q5HJ5hPLPfhPvS6kU2GOBhbsPcGMW0vYG+/aA6smMBfVX9+mk/S1wcc1vMZwWMi89wiP45/Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652086; c=relaxed/simple;
	bh=RtVC9ObLN/g3Wp5qytCN+fjJG3HJQkGff/4m8yZQ6Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOlWDwx58gFhooN5Y4yhL2SrqLOH16JJEKd1+InArNV7kpQFa+JCyTZA84XLiNzNTxAervQf+CPeKvOLXpZHHcWqeMr6wd5innQ/0Bhkf9qBDcx3t3lApEYs17Xe2zKIbOpKeXToZpO7jkGXA11gfpUsSkTtKkmrFKniYGanMoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+gFrMXC; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+gFrMXC"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so5251301a91.1
        for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 09:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784652084; x=1785256884; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EDg/svCPJeFyDo4IXuZRcJVazgPS2ZfjuCatuWZTKtI=;
        b=o+gFrMXCQeP6rUUIjGgpnGwY8Sng/+7jaV/GGYQ+iRY2IQp1qeBM2qefRSNfR36ko0
         cTSr0z1bXGHGohDFExw6xWXUVrr3SL0SuUQqNul6WVi/INugZrb2KB9PtCbzE0dHkgLD
         y0f90hP8Sy8G1Z24ADqgPR+ST5pBmFU/QWUwOoqNLUQQMRvx535KolpI2jY9iebJkq0l
         pGKBnR9sLwNq6kKVB423TTXATfg4hLZk9rYdVvLkbYfhPBxIHPqheznGs74s06B7JUG5
         3/7Cqr2wJmePOkdtRYZRTqYlUvIwQNGVz9jlLGUfJcAzvgSy6N2+bT+fSfpUeuyUSXrN
         IXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784652084; x=1785256884;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EDg/svCPJeFyDo4IXuZRcJVazgPS2ZfjuCatuWZTKtI=;
        b=Oh0GY161IV0K8kY2lZzYaEruucXY6diX3NxLHZ9fQi5FjlBRf/812+pHubJccT0du/
         I9y96uX0TM0w411EA8Isy5MVtK2OiUv6Hi6iKS45tgVNVFR9hWgHw4+OoHoDIZuYpdBL
         cEJ0Fg6ZpaC4UbZk1JoNXkM3o6vrFJc1pvtAo1VwBxwZ66kHjo+aeEvycMvNe2BFpno/
         TBaI5ajUdk3d2ru1kjMk4fknACBOTXGF7/4Claka1pKqWJaprt0k9tqmvTzYJAfMmoKG
         UjvzJVyjAenWcivOb3xJYFl0suOZ6uzaFPSmPj8nx6CDHVfN1YGSsUi8GXPpkqjyNbH4
         b8/g==
X-Forwarded-Encrypted: i=1; AHgh+RrzmOgeq/whDbw9edtMn6AME6B31i5ZukBFDl095aokU3t3LU5FnGPbAMryq6I4+uzpDOc9NbeG3YiIeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUOe0hHCgBJFEbD9iWhYWgH762xJRj2lMykUZf0xiT7QnTVr7d
	ovOP/nqZ6AJeNwqRpjXa3F8RTOsjmkR/1yXXwOlOCZ8Fvvu36UcnyOI=
X-Gm-Gg: AfdE7cmlR6vs1uW6oM96usE1yjdahAuc10PZ035Ta0YrDzbGDGgob6S/PvPGiLpb4JB
	yiSvGVSzUHoQO4Tze9J9o0fDB12AelrAz1f/nwJiMeOYvsJiyuVVJSMEcDfYwFWzQkIu1CB/i0W
	y8OxkXo2/0ncSZRxKY/7jLI4oSBRIew0Gc7QvQKvVkJqPRFRPljx1ZFybmrAzjiIrJ0AspPnzXn
	LMaPSKvoHcbf9wmOiJCoopGMdo4rbxwcBgzd/3vjgelCynjtAVmwyPgkmzgCPsGUZqLXLltByg8
	nxPP9rEUk9YkkF5D2JG8QWlPpKSYmEr03icP8/rJAHYl0c3ZYTye7swOgfnkMIDH63HrZY9RYVt
	pKJikTGfSPcFAqH9JcwQIhtI+1ZAai7k4Uu7OJtjuByexO+Ctcfey1emblUr3YWphaMcE6Fghpd
	3kuThmRwYGN/K8YAQNiU+nMjj13qEW6ery+XTtyoOWQpXY5AR22b8Yjg==
X-Received: by 2002:a05:6a20:244c:b0:3bf:6237:4d4a with SMTP id adf61e73a8af0-3c3ad80d53amr19459946637.24.1784652083866;
        Tue, 21 Jul 2026 09:41:23 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([125.19.217.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1c7ff4sm447487eec.27.2026.07.21.09.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 09:41:23 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: colyli@fygo.io
Cc: axboe@kernel.dk,
	gregkh@linuxfoundation.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH v7 0/2] badblocks: fix rounding bug and validate input range
Date: Tue, 21 Jul 2026 22:10:22 +0530
Message-ID: <20260721164027.637078-1-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709131904.596684-3-adhikari.resume@gmail.com>
References: <20260709131904.596684-3-adhikari.resume@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Two related fixes to block/badblocks.c:

Patch 1/2 fixes the actual reported bug: round_up()/round_down() don't
modify their argument in place, they return the rounded value, and the
callers in _badblocks_set()/_badblocks_clear()/badblocks_check() were
discarding that return value. Depending on caller alignment this could
leave sectors unrounded or, in the reported case, stall the CPU with a
non-advancing cursor when reached via the nvdimm ioctl path. It also
fixes a 32-bit build breakage reported by kernel test robot, since the
old rounddown()/roundup() macros pull in 64-bit division helpers not
linked on 32-bit builds. Unchanged since v6.

Patch 2/2 hardens the same three functions against the input-range and
shift edge cases the round_up/round_down fix exposed: s + sectors
overflow, and rounding itself wrapping past ULLONG_MAX. Revised in v7
per Coly's review of v6 — see the changelog in that patch for details.
The remaining open item, bounding bb->shift where it's populated from
the on-disk MD superblock in drivers/md/md.c, is being sent separately
since it's a different file and a different root cause (missing input
validation, not a rounding bug).

Ramesh Adhikari (2):
  badblocks: fix in-place round_up/round_down usage bug
  badblocks: validate sector range and shift before rounding

 block/badblocks.c         | 40 ++++++++++++++++++++++++++++++++-------
 include/linux/badblocks.h |  6 +++++-
 2 files changed, 38 insertions(+), 8 deletions(-)

-- 
2.43.0

