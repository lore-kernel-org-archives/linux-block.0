Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF341E529
	for <linux-block@vger.kernel.org>; Sat,  7 Dec 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733584486; cv=none; b=OZImkygbg+QrUw5iH8B6NDHKsRlsZxFcLR5lzeeF+62KA6RvNbG2v7iL3dEKLsO8j4IbBHTuEwJiAzoWgcAjVH+QJapMLHdhmwn6SV4vGRz4VF5coph7Ec+IwDYujYhdEOfWenTvmw7m3KTEC4KcBCgW9a+ns7Rg3yY1LOlt6XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733584486; c=relaxed/simple;
	bh=hyLDHtFyadyxEYKl5Gzrk4BukppY6IgnDP91au76S50=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ZLV+vnKKZfrC4qgvMIvBqRfC/501UVR1+kW2g4FGiKVVNwN3p7KxYbMNtJgpV57KKhH4anAv1PP9MiW/qikqEcx8xa8hucS8Tu89kOADCdj3Xnfp8blVWifKUzvyDqlhV8699QhEBm4wpM9fqoW/Uk8a0jvlWmEu0kruuK7G5Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HF8aAdrp; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HF8aAdrp"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee6dd1dd5eso2374325a91.3
        for <linux-block@vger.kernel.org>; Sat, 07 Dec 2024 07:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733584481; x=1734189281; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYMIPzsscydLbXOn9xsy2FRLIZ5CrUp8TAHDh78fluY=;
        b=HF8aAdrpNZkQCUe5HESUfu2Our0Rez1NXDNgZj0oFnneBL+oFiFFwpVVql8ATbOTVH
         IH3NKLO3SDFe3XqCOIwjgi1c3Ni26owWZD3EPvGbVDM9FSdJmNRlOmFykLpKFbn7ougw
         smx3NVbL9Z9KAJvNw2hduLUaI85O4nXXiaGoWkOwSShXh3DDd7XybE7jHSH3luCoyib+
         7CKPse13UrFEwSEXkybWjFiTthOsKNa3lINY8quTvFifMjaGhvV6jC6Q+25s6wj4LjbN
         cHBmWg3Zm6t7ODkNOADwyju1rb7Aiu2q+Tx1Lr75vD0x+mXVZrhe3r3Ln8RMSFRREkIG
         ZQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733584481; x=1734189281;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dYMIPzsscydLbXOn9xsy2FRLIZ5CrUp8TAHDh78fluY=;
        b=OMptVcR2CPpkI+fJ6Xga7PLG0wALws+R/3TpPRCaNlMt3MdWfcSglIYjsIZGsxeyAc
         pJg45MsWc2XGc1acc5/g3yOXfXiqxysH0HYl30UiTCLqknq6DiIdvJCxupJoWdgfFKMv
         dVYxISP/0Hbd54fPmknAzAfr0+y1GOXmCKb4YtdlA3i7AqXgyXTF81UXVG6vuLV/K+nP
         CdUO4Ljo44XoREw4O8wM73gPsSXd31S6fqhe4OBYopZTtgnZbChon9Tvs09Mq2v63T+z
         ltfb5wV9KBgJlOFivGqjO6tsv77qIh0ixL+AglsZmsUORaUIiu+DkH4tERMx4Q48TSbi
         GgnA==
X-Gm-Message-State: AOJu0Yx6V4HenbYl6GNMxpV3QLX4bpiQvmPoTNqUe6htSy3VuhB7DK1Z
	d7faQ0yVqsgIJNT4gcoCu2SizKVEOjuJ/GJ9hIY69Qtt2dG8lqQ1cWssDXQtMipUyNyYAYB7t9h
	i
X-Gm-Gg: ASbGnctWY2UhXsj4rZC0an/l9tl4BTh6Zfz1rpOwjQZgKTO+SvygEbLe0v59RhQ7YxU
	tUQYklh69c5/psnBfn6sigXGyfxeB/MNu6G2p3CaL9rZQs6jH6W2D+sS/pRwf4YgxLDhh0J61vv
	UI8WThejs0Hyii7oOENBgLhDL5JT8yTeShbp35RlMOH6W7ONVrTGQeiUp6kjh2nxy9CvCrnF+Mv
	XCULVyeiQxrqpbAbORbaFfdiIQhU6fpVwcZ+kA++3qKmdc=
X-Google-Smtp-Source: AGHT+IF91TOaCUoV8XygZ+5BicPaDti1OavN8rRhm1NVafGIyp39O9TFSaVu0lZ0GIgMsDyO9a6w3g==
X-Received: by 2002:a17:90a:d450:b0:2ee:cd83:8fe7 with SMTP id 98e67ed59e1d1-2ef6ab24fcdmr10889264a91.35.1733584481242;
        Sat, 07 Dec 2024 07:14:41 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef7a74efc5sm1966950a91.6.2024.12.07.07.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 07:14:40 -0800 (PST)
Message-ID: <84108c76-7be5-481a-be44-4aede8f6fab2@kernel.dk>
Date: Sat, 7 Dec 2024 08:14:39 -0700
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
Subject: [GIT PULL] Block fixes for 6.13-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A few fixes for block that should go into the 6.13-rc2 release. This
pull request contains:

- NVMe pull request via Keith
	- Target fix using incorrect zero buffer (Nilay)
	- Device specifc deallocate quirk fixes (Christoph, Keith)
	- Fabrics fix for handling max command target bugs (Maurizio)
	- Cocci fix usage for kzalloc (Yu-Chen)
	- DMA size fix for host memory buffer feature (Christoph)
	- Fabrics queue cleanup fixes (Chunguang)

- CPU hotplug ordering fixes

- Add missing MODULE_DESCRIPTION for rnull

- bcache error value fix

- virtio-blk queue freeze fix

Please pull!


The following changes since commit cdd30ebb1b9f36159d66f088b61aee264e649d7a:

  module: Convert symbol namespace to string literal (2024-12-02 11:34:44 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.13-20241207

for you to fetch changes up to 22465bbac53c821319089016f268a2437de9b00a:

  blk-mq: move cpuhp callback registering out of q->sysfs_lock (2024-12-06 09:48:46 -0700)

----------------------------------------------------------------
block-6.13-20241207

----------------------------------------------------------------
Christoph Hellwig (2):
      nvme: don't apply NVME_QUIRK_DEALLOCATE_ZEROES when DSM is not supported
      nvme-pci: don't use dma_alloc_noncontiguous with 0 merge boundary

Chunguang.xu (4):
      nvme-tcp: fix the memleak while create new ctrl failed
      nvme-rdma: unquiesce admin_q before destroy it
      nvme-tcp: no need to quiesce admin_q in nvme_tcp_teardown_io_queues()
      nvme-tcp: simplify nvme_tcp_teardown_io_queues()

FUJITA Tomonori (1):
      block: rnull: add missing MODULE_DESCRIPTION

Jens Axboe (1):
      Merge tag 'nvme-6.13-2024-12-05' of git://git.infradead.org/nvme into block-6.13

Keith Busch (1):
      nvme-pci: remove two deallocate zeroes quirks

Liequan Che (1):
      bcache: revert replacing IS_ERR_OR_NULL with IS_ERR again

Maurizio Lombardi (1):
      nvme-fabrics: handle zero MAXCMD without closing the connection

Ming Lei (3):
      virtio-blk: don't keep queue frozen during system suspend
      blk-mq: register cpuhp callback after hctx is added to xarray table
      blk-mq: move cpuhp callback registering out of q->sysfs_lock

Nilay Shroff (1):
      nvmet: use kzalloc instead of ZERO_PAGE in nvme_execute_identify_ns_nvm()

Yu-Chun Lin (1):
      nvmet: replace kmalloc + memset with kzalloc for data allocation

 block/blk-mq.c                  | 108 ++++++++++++++++++++++++++++++++++------
 drivers/block/rnull.rs          |   1 +
 drivers/block/virtio_blk.c      |   7 ++-
 drivers/md/bcache/super.c       |   2 +-
 drivers/nvme/host/core.c        |   8 +--
 drivers/nvme/host/pci.c         |   7 ++-
 drivers/nvme/host/rdma.c        |   8 +--
 drivers/nvme/host/tcp.c         |  17 ++-----
 drivers/nvme/target/admin-cmd.c |   9 +++-
 drivers/nvme/target/pr.c        |   3 +-
 10 files changed, 123 insertions(+), 47 deletions(-)

-- 
Jens Axboe

