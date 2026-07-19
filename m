Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A6425B09D
	for <linux-block@vger.kernel.org>; Sun, 19 Jul 2026 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784472088; cv=none; b=ZWdvWC+peFr+mO9BIu6puR45sSgGqI1jsiaaAT3C0lAxXEzovQcDBm23jsDuUbyF3st9BGJeptJtQwr5xOm9o2+eZ8M11pwRzfstDnR2zx9WWMO++CcRDKa/wm0tbJyNBTyoKklJ+DaSQ9AXqpANu/YqEaBJz7hDF+Unrlrvt5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784472088; c=relaxed/simple;
	bh=aLH1SZ1c8ztdgdpHR3mIRxeUrFQZOR/9bN8xp1rWKu0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=TME4KjMJqbTjX4/QIu/ZQY4CtAvTB5FDbTaPO2Mtqx0YbFwSvcO3LgMfDDLG4HCfNgfAFjhZmzQSKHYDtMSPWA87L8L7xbG1H1ZNas39MsC2L0jOoj4eChUwrFAYxrTPzx7vRwrQ7CPpcDczUT4owcgaOTs14dYhCSHIedUYsOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=HmHmjVhP; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="HmHmjVhP"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e9ecb1e13bso3438173a34.2
        for <linux-block@vger.kernel.org>; Sun, 19 Jul 2026 07:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1784472085; x=1785076885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/6Ajzvl8oy3aeU3dbW5OCm8OuQi0CC2qF81AmIAyuyM=;
        b=HmHmjVhPH6AsfMBX8MoFFDdA142MomgZI91x0qOV8xAH8FM/ARESQ1e9WzMw7wtfpt
         yJSML3RUbwOYeG7q3BUDmUMt68HR7hXqdLg3RDGdoischn9/OanJc76AfYvBnpcNCXVa
         ZNeU6RrLu+wlKr+VAfLk6hczx8EkynxjFFiRU4WfR3t370B4BD/9UUCstjbXiN55U7Wj
         akfDKPSYxXkOnvQvuIOHAFbL+bSHzuMjVVFbc5AsWFJ14ckxCqVtfWSoqzpNVW2Puib5
         gRK4ysp3Io/yt3tKWEUGmXlWK7oAkocl0hehlmovNEgxIUi+Qn2HeBki3DiP8zN/0QnX
         IzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784472085; x=1785076885;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/6Ajzvl8oy3aeU3dbW5OCm8OuQi0CC2qF81AmIAyuyM=;
        b=o3Gd4gI+7pncWUx4xnYkx5mJigFdvMv6eaaCZ4di50etSlaVI5UOFsJHla07L4kW0f
         WUwsPmkCb/W1GQhOp8/QtHOic0DsFdr/qbPrCyuoM2dUJWZmeq06tFhW58lsfWWCUtoJ
         vVpZBuI6ek6YT4IPUC1kenVnLXB9Tcnix7EGVgVNGhv9tbB8opAs9p8jpqD8KBgXxM2X
         vnGCi6kNs17VCyl25eV5p+1rC64ReXB3q2kjt0miLzY7wutIR9XB46eh0uAbOqOzDr8F
         2Xd4E+h+noxourTJstucqhurAzjP/zVX1he+zoY98aERlrSnIpaNcJVdmTUi+iX3b1O3
         WPag==
X-Gm-Message-State: AOJu0YyGYWPrWY2p93nLERhZDev6oHQCMbWNcNqFKh+qHGx+hDIuoQto
	NUl5SBZ9bcoMj1l5JTg+q1Mm83gwiEIdZgf+OIf4+bzTLHjzBc/f9WAjspAOBcrQB803iCN3rY+
	GFvQQLE4=
X-Gm-Gg: AfdE7cmNSJxv/vIYlmVKhmqbDSmn9rP5Z7Pte5AiTROKXM5RmPcPMWG4zzal5n/yjeL
	E+yp5wiPI90H6jtLJK7Z0qEb01MpXdpxENPDckbRLWv8IoyEUsLD2DrNup0S1zoufYPzHD+yvZ5
	Lh9umo5SXbD6TpTrY5S8YPAw1Szi+M8ZBgHfP1Rcdec0ZyvL7S2yZkrxOUsMdPAfQghp9X1nt7M
	l0ZjDYbHl+9JxfqnjCR7705+9Eu24qwqsyA2TYLaQq8udiYjn8J/AUpH2VbJb+IwBdzvKDbUCuZ
	yRS97SFvyd5LfTFfYwFUK3olIR/xJEcrmHojnuQCijeTRqgufP3C3O0W7ar/2OvD6VzJYP3imJl
	6pUAFcV/FFXSFAboo0o5d2V65WStuSIOrmFQE5AkM3AstHBks9PBLm6MOoW4Im9aSpLGcfdeObp
	RvfzrOEM6oh+mxGY0pl0wYPQPaheOpTTnkcqda0/H86lyUYDdr9mB3BUyJnizbY04G+o0hOg==
X-Received: by 2002:a05:6830:3499:b0:7e9:e0be:583b with SMTP id 46e09a7af769-7eda073ca12mr5430061a34.9.1784472084797;
        Sun, 19 Jul 2026 07:41:24 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edaac40bc1sm5957799a34.0.2026.07.19.07.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2026 07:41:23 -0700 (PDT)
Message-ID: <5edc8456-eac9-4c74-bf29-48a9ee333bad@kernel.dk>
Date: Sun, 19 Jul 2026 08:41:23 -0600
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
Subject: [GIT PULL] block fixes for 7.2-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Fixes for block that should go into this release. This pull request
contains:

- Fixes for the dio bounce buffer helpers: correct the alignment of
  bounced dio read bios to avoid a double unpin, handle huge zero
  folios in bio_free_folios(), and don't warn on the larger-order
  folio attempts in the greedy allocation path.

- Try a slab allocation in bio_alloc_bioset() before falling back to
  the mempool, restoring the previous behavior for non-sleeping
  allocations from a cache-enabled bioset.

- Serialize elevator changes for the same queue using the writer lock.

- Fix a race in blk_time_get_ns() where a task preempted between
  setting PF_BLOCK_TS and the cached-timestamp reload could return 0.

- blk-cgroup fix for leaks and the online flag on a radix_tree_insert()
  failure in blkg_create().

- Free the copied pages when blk_rq_map_kern() fails after
  blk_rq_append_bio() rejects the bio.

- Remove manually added partitions on loop device detach, fixing dead
  partition devices left behind and a subsequent LOOP_CONFIGURE -EBUSY

- Bound the AIX partition lvd scan to the sector that was actually
  read.

- Show the block operation in error injection rules (Jackie)

Please pull!


The following changes since commit 181bb9c9eae4f69fe510a62a42c2932d0314a800:

  block: remove redundant GD_NEED_PART_SCAN in add_disk_final() (2026-07-10 09:08:50 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.2-20260717

for you to fetch changes up to df308a14585649f7683a560f5c94978ab4f8224d:

  block: fix aligning of bounced dio read bios (2026-07-16 06:11:37 -0600)

----------------------------------------------------------------
Christoph Hellwig (2):
      block: handle huge zero folios in bio_free_folios
      block: fix aligning of bounced dio read bios

Daan De Meyer (1):
      loop: remove manually added partitions on detach

Jackie Liu (2):
      block: free copied pages when blk_rq_map_kern() fails
      block: show operation in error injection rules

Joseph Qi (1):
      block: try slab allocation in bio_alloc_bioset() before mempool

Michael Bommarito (1):
      partitions: aix: bound the lvd scan to one sector

Mike Waychison (1):
      block: fix race in blk_time_get_ns() returning 0

Qu Wenruo (1):
      block: do not warn when doing greedy allocation in folio_alloc_greedy()

Shin'ichiro Kawasaki (1):
      block: serialize elevator changes for the same queue using a writer lock

Tao Cui (1):
      blk-cgroup: fix leaks and online flag on radix_tree_insert failure

 block/bio.c             | 64 ++++++++++++++++++++++++++++++-------------------
 block/blk-cgroup.c      |  4 ++--
 block/blk-map.c         |  9 +++++--
 block/blk.h             | 13 +++++++---
 block/elevator.c        |  9 +++++--
 block/error-injection.c |  7 +++---
 block/partitions/aix.c  |  9 ++++++-
 drivers/block/loop.c    | 32 +++++++++++--------------
 8 files changed, 91 insertions(+), 56 deletions(-)

-- 
Jens Axboe

