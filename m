Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15EE161320
	for <linux-block@vger.kernel.org>; Fri,  7 Feb 2025 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738947034; cv=none; b=Ceo4UVmxX2gFqcb6zlOrqZUVKabedjo1nK3KVpCB4fBjfhMyWR8KcofqCC6m3XdhLwHQJ2hr0WiHEirJOGh4JPaPgMxDljwCgG//KGmE4L1P64gZWX6NV2tqbJJiJXnySeDyd7ihev224sJ2zRB1wF58waMswTwrF5MpIhLPRks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738947034; c=relaxed/simple;
	bh=MB/beSe+1IjpgprWpSQS858gfi2yu4f4YLuEqeyHYHI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qpo4olfKbW7RbSDIuT1cgBAKK1sujQ3GIQq0HGUTwrqxiP9IVWtES5xYniXhbrBEWcqXbC5LbifLX+O/3XZykFgtD32iro7lnwd6bq/v3ugJWo0nZucs1k1LJaDXkqtA5UWoAtfxn5bkwcrX5/ZBWjaoph4IwZNGIl6cmyFiL/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HBk3dI8L; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HBk3dI8L"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844e7bc6d84so71809839f.0
        for <linux-block@vger.kernel.org>; Fri, 07 Feb 2025 08:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738947031; x=1739551831; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZcAoGvteKYNahIOBBHOqLUlnzalvic6fO+6tu7n2II=;
        b=HBk3dI8L056OSm5zI2JjwcO4hq+wjCFYwQvHF+4pVV4xZfpcIh9qJjCa1DOHZPWdyp
         stnWtt+lMSNf7qlXzaS95WEqNKOwNne+Sdkuht7sZw4EiMwpPHEaefgm5Zf/9B8oxOO/
         KmdLZK3trBizbvx1XKWZjrxpeiw1oD/PbHtqH11uFKwcRi53spmbP3WTiO5kQDRXy0g7
         c1AE7jnRZaIDz0EDVlz0ySsHAQnn6MNdSWqZyulkulQLC7MHNAK5EtMJzo7mXHEelsrn
         jXhH3Uby4PnE7mDONaEmml3jR04ojBiV+eHvM/DWoCaJ8tcNiBcAe5JD0d8xFzE3eDeT
         CqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738947031; x=1739551831;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FZcAoGvteKYNahIOBBHOqLUlnzalvic6fO+6tu7n2II=;
        b=vO4zVssQshYMvc5Ns50yEZFEsQLbEO014YX+6ZO5WQazkmU8f4JpZRrSW3v0yjXVvt
         IVc6mwJkMKNpm3V8YeXCrdPT0uxW8UbNPmE07HZAN6tEVBWJzRy0hoZHIyY3CgkrjM43
         XB07bMHeCXR8gqTzcI0h8N9rYzewecujyD3TEICqZhGn/6RND5hczbpo1qG3eUuOdDy2
         aUVT0pT9ebdNe2YIfu3bJCLvCH4iIlR4B2zyPjNgdQBILW3VcHsVSOJ/je9K4cnkR7FZ
         MoPkp9QXMDwZpJ9xVVlP/q7SVkyLjQTweqJLCfBpIT00ONkMRz65mJYqETtNFvdIw+HC
         PU6g==
X-Gm-Message-State: AOJu0YwIKsDGSbmNw+BC1mpO5QmdT8G/iyHitL0G1J0tJfpZD0ynK3Ya
	maEiRgqZ/+C9B/GFC8ImmmPNoifWknlVPlpyqt757TFgZWbIRqou7LnBrGCRUDosmQVXvMKaWOc
	L
X-Gm-Gg: ASbGncsfccUGf3Czg92A8KMU/FGnoKvjYop9mjPjz18k7QvPGUe7S/ewcfMZXo6d+wb
	nJ2BauxJOhvFVU7Yg4DxN1YqDgbiRPXtqMw842HtYAa97JqwKZR0kTBjxp06vGKFvToefpgdXUw
	DvEAIXAeBPzAUec/AFGuHxnqp7avivVXCTBjXYtDW4CYexQmBzUbI4wyqBxPZWPShRer57JD+Bq
	jtftuO1u+slquPAM1dRHPciDznRF7clx7F5nW9ig9KnYdpUPztZdM94p+iuWEfYVwtETVYN+AvL
	4DEnxenoQfI=
X-Google-Smtp-Source: AGHT+IEKtH3p0iZWvc4wvI4zaSl3ZCdVDJ4IvQh/wzRHlhk03vJGSzcy0GuY/PrLDGigIjdRABZanA==
X-Received: by 2002:a05:6602:4a05:b0:84a:51e2:9fa5 with SMTP id ca18e2360f4ac-854fe4c17femr248352239f.3.1738947027199;
        Fri, 07 Feb 2025 08:50:27 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854f666c96csm77498739f.19.2025.02.07.08.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 08:50:26 -0800 (PST)
Message-ID: <1abded6e-1d80-4876-ae7d-7e575959ba25@kernel.dk>
Date: Fri, 7 Feb 2025 09:50:25 -0700
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
Subject: [GIT PULL] Block fixes for 6.14-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A small set of fixes that should go into the 6.14-rc2 kernel release.
This pull request contains:

- MD pull request via Song
	- fix an error handling path for md-linear

- NVMe pull request via Keith
	- Connection fixes for fibre channel transport (Daniel)
	- Endian fixes (Keith, Christoph)
	- Cleanup fix for host memory buffer (Francis)
	- Platform specific power quirks (Georg)
	- Target memory leak (Sagi)
	- Use appropriate controller state accessor (Daniel)

- Fixup for a regression introduced last week, where sunvdc wasn't
  updated for an API change, causing compilation failures on sparc64.

Please pull!


The following changes since commit 1e1a9cecfab3f22ebef0a976f849c87be8d03c1c:

  block: force noio scope in blk_mq_freeze_queue (2025-01-31 07:20:08 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.14-20250207

for you to fetch changes up to 96b531f9bb0da924299d1850bb9b2911f5c0c50a:

  Merge tag 'md-6.14-20250206' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into block-6.14 (2025-02-07 07:23:03 -0700)

----------------------------------------------------------------
block-6.14-20250207

----------------------------------------------------------------
Bart Van Assche (1):
      md: Fix linear_set_limits()

Christoph Hellwig (2):
      nvmet: the result field in nvmet_alloc_ctrl_args is little endian
      nvmet: add a missing endianess conversion in nvmet_execute_admin_connect

Daniel Wagner (4):
      nvme-fc: go straight to connecting state when initializing
      nvme: handle connectivity loss in nvme_set_queue_count
      nvme-fc: do not ignore connectivity loss during connecting
      nvme-fc: use ctrl state getter

Francis Pravin (1):
      nvme-pci: remove redundant dma frees in hmb

Georg Gottleuber (2):
      nvme-pci: Add TUXEDO InfinityFlex to Samsung sleep quirk
      nvme-pci: Add TUXEDO IBP Gen9 to Samsung sleep quirk

Jens Axboe (2):
      Merge tag 'nvme-6.14-2025-01-31' of git://git.infradead.org/nvme into block-6.14
      Merge tag 'md-6.14-20250206' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into block-6.14

Keith Busch (2):
      nvmet: fix rw control endian access
      nvme: make nvme_tls_attrs_group static

Sagi Grimberg (1):
      nvmet: fix a memory leak in controller identify

Stephen Rothwell (1):
      drivers/block/sunvdc.c: update the correct AIP call

 drivers/block/sunvdc.c            |  4 ++--
 drivers/md/md-linear.c            |  4 +---
 drivers/nvme/host/core.c          |  8 +++++++-
 drivers/nvme/host/fc.c            | 35 +++++++++++++++++++++++++----------
 drivers/nvme/host/pci.c           | 12 +++---------
 drivers/nvme/host/sysfs.c         |  2 +-
 drivers/nvme/target/admin-cmd.c   |  1 +
 drivers/nvme/target/fabrics-cmd.c |  2 +-
 drivers/nvme/target/io-cmd-bdev.c |  2 +-
 drivers/nvme/target/nvmet.h       |  2 +-
 10 files changed, 43 insertions(+), 29 deletions(-)

-- 
Jens Axboe

