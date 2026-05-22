Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4368D2D1914
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779465213; cv=none; b=Ep5J/GCphqX8lrQfF992hGlpsJjv1GTs4nU90HLVtTtaFrjhW8CuzScIIT6cPcL3H/0IM7Q8w6r3Suftrz12Tx8X2jGjLsWPO0aSyrMhCIQ4XpFeCEbvPYu80qfkS/MDnuWQmKyGnTqsNJkQTBIr3pKX+ygPEeMRDs69Gpr1HCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779465213; c=relaxed/simple;
	bh=FmwhS36bE4Rgbs027o2OxLZ3rYxYXUXurRspGu0xcps=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=sp7PNIV5fQUtHAuh4CYYVm1wsnW0B8ZfYSu1pm+AntU+vfq6bY3/hf9AcfJwyPoFXg6sIrd3gCmDj4rB6iCoQkLMdSwbsKGDjihNth5h2UfRW8N03BwNm3R+WgM818czRqmTTOGCHbsIZrP1L6qiOSHI6R+fsusRRxDrSIXmV9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=QCg7pYgD; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="QCg7pYgD"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7de46b8e432so7176417a34.1
        for <linux-block@vger.kernel.org>; Fri, 22 May 2026 08:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779465210; x=1780070010; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ELvCznNtgDO9IK+vBmF5+BTVOK73rLy3UTLMmyf0uI=;
        b=QCg7pYgD6OZ+xygmvQ6rH7tqLlPjoYSt8kcJ7lf9GF44k/bIqjPB3M6YVHU3qoqkLT
         50N+9YqITY5esuF43w/l9q2aELcaLemjBYgisbTzn9fEIhjAEukWmFFvSBwBBKZbgBVi
         tgP5lJA38xNix01sNL+kQi+0enOY6jWBl7LHwejz3hJhGvJ3ym6t+btjo2GybaqGusp5
         pgJqDdM4cUmzVVqu5bFWybjg63AyfYF9HwfiA1lPuvZgSP8AXPTaTct0MQIl2UH9Bwhz
         6LsatyWb73fWSQ+pTWLWXHVmhCFctbNRjYskGYjCG2KUGrPvcDt0VezekaBcwdguQMWL
         WXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779465210; x=1780070010;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ELvCznNtgDO9IK+vBmF5+BTVOK73rLy3UTLMmyf0uI=;
        b=kEVjxN3TdrZkyLeGOzPtzYmA06a7PGYsVYIGADP77vvwgAK4QfCnvCBoU88soKglAY
         Dd53M0AlHfKndVwE6mlBYuyZxECBpEfZhhs54NcvSgJMMfKGb+1Q61yPw4P9lt9sUH1P
         DIFdl0/17fHx+9T0DsOXmYwySu8RXjHeDHklVGAO68dlVAQs5PlEUd3nE6UMFUUQ1a1Z
         Jjp77X8ELBnvrLgOgwvpWG7/PwErUllisLJPfJeJQCOemGdUOl5ATkubeHwZQNO2dAOW
         y5iV3WmZTEPKtvWxPcWtQXtCLvaNLUEC8nBfBsjF6Xm6VFtofChWIzZwC2LKfScjsmiE
         5TCA==
X-Gm-Message-State: AOJu0Yxfnj7+OBqjW005bFLY8xwaJcr8RgW1DOVQR3QqDgebz7hraGH1
	9C0asjzf6W9TaixcC9NYsvULJ3F86rqK4uXwkl7q4q6Ak6vru0TIa33qD9eNNQPf6zzPunK3HD9
	nO5E7
X-Gm-Gg: Acq92OHC+GeYY1btd8oDNiurKgFDrUmiJeMGxe70CfF3pG317mZd56+ANs+ObwuIUjU
	+OumvBKomjfmJ5Vx5pIfyg6Fy5baqz9z+6XIgm/vcvML64JEhZ5WUnKHDfKMqT+L9vGyRsK6Smk
	zjRvWA0r5he4Upepms247Ius1R5dAI+KOdL/TvhKyIyjhWMxiyANQEeetKBfmJwmT2tdfn1zgLD
	8QzuzPOy7vTImLxXL6Bmuy5eUKqzSLfAQfKzIFvooDknRsFcVCbuQmrPUs9UO/k/EGr8ftbKwEH
	n89+YHd98bhTVWC7Hel63wuh+wam0ju+Q5eTHxrd4jy7Rd083pCf8xJRTgQl5etQwR+TzXRGfB+
	vj52Bs2oGGG/wbDy/R5n+2nCZyCis9oo/ureLayN2mdhq8dnJpT6ZpJkALfORxAJCcwWMHlPwKu
	OY7hfYT3cxpg0qLTdWm9indQPXLIpmJF96xuaAWxymuIBfR+gC2VqwdwdNbXJ0qJzVma8Bw1zRV
	K3V7Il8
X-Received: by 2002:a05:6830:3887:b0:7dc:c338:d23d with SMTP id 46e09a7af769-7e5fee9bb75mr2676181a34.14.1779465210302;
        Fri, 22 May 2026 08:53:30 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e60645a84dsm1225120a34.2.2026.05.22.08.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 08:53:29 -0700 (PDT)
Message-ID: <a050fd86-b9dc-4a39-a274-57bbe1931d42@kernel.dk>
Date: Fri, 22 May 2026 09:53:29 -0600
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
Subject: [GIT PULL] Block fixes for 7.1-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A few fixes for block that should go into the 7.1 kernel release. This
pull request contains:

- NVMe pull request via Keith
	- Fix memory leak for peer-to-peer addresses
	- Fix dma map leaks on resource errors"

- Another bio integrity fix, fixing a recent regression.

- Fix for an issue with the request pre-allocation and caching when IO
  is queued, where if a bio split occurred and ended up blocking, the
  list could be corrupted.

Please pull!


The following changes since commit 4141f46daa4cf1f8caa14129f8b6db86f17452f5:

  Merge tag 'nvme-7.1-2026-05-14' of git://git.infradead.org/nvme into block-7.1 (2026-05-14 19:14:33 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.1-20260522

for you to fetch changes up to f6982769910ecddabdb5b8b9afdab0bb8b6668ac:

  block: avoid use-after-free in disk_free_zone_resources() (2026-05-22 08:01:52 -0600)

----------------------------------------------------------------
block-7.1-20260522

----------------------------------------------------------------
Caleb Sander Mateos (1):
      bio-integrity-fs: pass data iter to bio_integrity_verify()

Damien Le Moal (1):
      block: avoid use-after-free in disk_free_zone_resources()

Jens Axboe (1):
      Merge tag 'nvme-7.1-2026-05-21' of git://git.infradead.org/nvme into block-7.1

Keith Busch (3):
      nvme-pci: fix dma_vecs leak on p2p memory
      nvme-pci: fix dma mapping leak on data setup error
      blk-mq: pop cached request if it is usable

 block/bio-integrity-fs.c |  6 +++++-
 block/blk-mq.c           | 34 +++++++++-------------------------
 block/blk-zoned.c        |  7 +++----
 drivers/nvme/host/pci.c  | 34 ++++++++++++++++++++++++++++++----
 4 files changed, 47 insertions(+), 34 deletions(-)

-- 
Jens Axboe

