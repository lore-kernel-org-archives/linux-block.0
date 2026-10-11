Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7852DF128
	for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791724432; cv=none; b=e6Ltvxv6MwHuUklK+KFPqJn4TkShRq519U6OeprwzjdPmPbKVmFhX1ffxCU3HZzhNxInvyz+3C/GZbBuHr5p5xEf2XYR65Q2F3lNAE61Pj1RBVG7krJxB1fNNSkjV8OjVnUi/J5fWHWcRFmQR2wRUhHhQsWDuUsQLDSTT7nDAOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791724432; c=relaxed/simple;
	bh=GxZZ+OsF9+7O4mF5jiRbT4IgcwTzNCMBor1OFRt1jeE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=WCYAlShokQLJJnNOk6/aXKnI2iqLwcHmf7wSoLmO5oHPpELFTK4qN4Vg5Z8GpqC95b/oauhpZq/IyA6zQgiUMWbMjGRmVQKef+Rj7olMZ8y8UFAq07XySS/H89yu2iD+ggntZ0cpbjuUHNTvTunPuuqz9+gjW9mZ7Qg0GG4/c9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=ABgXx9M8; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="ABgXx9M8"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-16ad92569b5so964187c88.1
        for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 06:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791724430; x=1792329230; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mGjUmhiwF6oiBGk9x9oXFbdVhxwnAl2b2IlIZ+Qcd4I=;
        b=ABgXx9M8XRlNYTFO3qvRznBiZ4GsS2jKcSjpjHF8KfmWJH8HUbO63vqHyk/bDBoZ1Y
         hdJBQPMlkUrVBQMC3yw7SZnI2lOtE/Dpw/UF+6OZ1bs/hWMPOWh9po2eg00EPjJEilUR
         nVVutYJtN/rLG5bNqpfktpYn13JCSjEeMQhkdow+cUemYKnFr5bMawUWLwGI0h6TDsAa
         Ax29VnqDcOm7lpInttZl8qNsplVZ6hOPoiqjJ7kYotN7RaGzXYAeg/5bFTYE7HmeXw1x
         ZfkCHiO0L83Otm14ww+OkZm4ZOfClDzG0F8xVvaMQJkc/bpFB17gbUfW7wLjqlqheqkK
         ZDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791724430; x=1792329230;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mGjUmhiwF6oiBGk9x9oXFbdVhxwnAl2b2IlIZ+Qcd4I=;
        b=zcVv7AELiVyiCBajFdRcitv+4fENqzFHjPCelJ0pCndLmJgXiBaAstMcm6w3074txV
         /FSG3RglBlXWkcePU9zjZDDUMVm0LfK83pzU8Yje/wS/ndC7jawRh1OU+5sMy08MYGda
         7L/cvUedK0fO1OfeoO/enQBZicM3yreZWIAABQljCAND8OicPm64K4WIyZFBkwUiqZYj
         DoxA2ThEALD7e/bgIn/mek1RXoxG8rI0jXlIwCiNDyMkCykHhQv/BXv98KTp7qnnr0a0
         l62Zux6dKFC63t/NYiER7hr/puaF6h7zBtTSI3bvzkPASFKLbu+CJXzhLOU3telK5QPO
         PzUQ==
X-Gm-Message-State: AFq9FYKEQbaA4yx3wjW0w7o3HHGIElB4ItEGyl2RTxAzet5VRQZiZFOg
	vptDj0x/YaGeWO6inRkjAXA5jap8dRs/NUtXH17UN5DCLaaM4AWqWu3d0hMZb6Xf0YvpBebn31E
	6OUK4ja0=
X-Gm-Gg: AYBFou2uI+79bijDDj/ug99x/XH3vD03XJb0sqPbDpVIdld7WSQTVrtvg6Dbau7GLE5
	eqrudFi2bjBMh/wYhmZHbyXbLPgwt1JN63Sra4rCEemrNDWp8xH5JRxvDaNElX3mmsPNnxERIIC
	wJCMpjTGgqlo1Px7gSwjLXqC2Pl160fXL9vWcPgo+HWw1Y74s+aPUQN9DlXQKdr8yt3uAXfBWKm
	NzjlB7txgTd5qB7hphJHANh+JBhnIcOKWojXO0RPXgEqry4lVdRdkcEQEQbFqrrQ9E29rChhmT3
	b5jY7pFz0X0cgnY4KjEfPDJpA8W9EM9sq9zRg8G+xNGU1UJLK+sh7BlJ8fkF2bhHsxS2fT8miTi
	7xUVMScExnoWICcX7hGAkLew+KDmdgTborckuAQZGoRnsZh59Y2KzqH/QcoEkAPphqtsBpulJar
	csp6374LkWJJ8Om8lnV1I+vGLsQ/Ufb48l7/bQQKMzkk9BA1TWZVhfHommEur7Ad8OngouZPU4r
	OYfxtcKSQxikSNeQOcT3M6s/F3uG08FHjhfsBK070T03iMFTxur1j7JvZUFxH4eh6h2+Q==
X-Received: by 2002:a05:701b:454a:20b0:128:d4be:7428 with SMTP id a92af1059eb24-16a5bf3f3fdmr9347464c88.19.1791724429935;
        Sun, 11 Oct 2026 06:13:49 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a6021e49sm21604093c88.20.2026.10.11.06.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2026 06:13:49 -0700 (PDT)
Message-ID: <130f6944-5862-4c10-ba2c-48ccd1b2088f@kernel.dk>
Date: Sun, 11 Oct 2026 07:13:48 -0600
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
Subject: [GIT PULL] Block fixes for 7.3-rc7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A few block fixes for this week, mostly NVMe via a pull from Keith:

- NVMe fixes via Keith:
	- Fix swapped ZRASF zone state values for full and read only
	- nvme-multipath revalidate head zones after unfreezing the head
	  queue
	- Revert "nvme: do not reset controllers in NVME_CTRL_NEW state",
	  which broke things
	- nvmet fixes for invalid NSIDs on feature 82h and using the
	  local P2P device on metadata allocation failure

- zloop: zero out only the unread tail of a short read

Please pull!


The following changes since commit 684b413b5483f57c890c171b9400076a0143b918:

  virtio_blk: set the zone write granularity (2026-09-29 12:54:47 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.3-20261010

for you to fetch changes up to 41cab3a71dc7be62114d91cc849424879062d324:

  Merge tag 'nvme-7.3-2026-10-05' of git://git.infradead.org/nvme into block-7.3 (2026-10-05 08:41:38 -0600)

----------------------------------------------------------------
block-7.3-20261010

----------------------------------------------------------------
Guixin Liu (1):
      nvmet: return Invalid Field for invalid NSIDs feature 82h

Jens Axboe (1):
      Merge tag 'nvme-7.3-2026-10-05' of git://git.infradead.org/nvme into block-7.3

Karl Bonde Torp (1):
      nvme: fix swapped ZRASF zone state values for full and read only

Keith Busch (1):
      Revert "nvme: do not reset controllers in NVME_CTRL_NEW state"

Palla Raghunath (1):
      nvme-multipath: revalidate head zones after unfreezing the head queue

Sang-Hoon Choi (1):
      nvmet: use the local P2P device on metadata allocation failure

Shin'ichiro Kawasaki (1):
      zloop: zero out only the unread tail of short reads

 drivers/block/zloop.c      | 31 ++++++++++++++++++++++++-------
 drivers/nvme/host/core.c   | 12 +++++++++++-
 drivers/nvme/target/core.c |  2 +-
 drivers/nvme/target/pr.c   |  4 ++++
 include/linux/nvme.h       |  4 ++--
 5 files changed, 42 insertions(+), 11 deletions(-)

-- 
Jens Axboe

