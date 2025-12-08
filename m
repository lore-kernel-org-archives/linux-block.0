Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDB1214813
	for <linux-block@vger.kernel.org>; Mon,  8 Dec 2025 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765225794; cv=none; b=S3LrC0pKV4guPQQ50EQbRycCAon1lhHhpUtApaoWgdV1a7D26jQ6tGo/W57aBl/+EVSryAwK4au8MA3GAbq0Ixm/RZRZRLPVMg3S81wP7yy6H5HJmr7IoWH3P4QlSvT4TeLUYMVH7FFOVkYO497ifZ+VTmmJJhXLJ/3el+ON/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765225794; c=relaxed/simple;
	bh=W27Dgxi6+K08jq+FbG6mEvmtSoPV1I5/ECX/oBAc+rM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=VUF8bh8EEI/RQ4cQpdAllZXgwOl5GiCys6OvTlbY3dDAs8CZZRZaRbfQ+8uW0fZS3AzaXDdmjvgEuc1Bg8OxClRBqZLt6e0A+2Brjb6dgPjrARJDUpQQVkkd0gyaKQyE0wqFZH9/O/TiWmIqrVzFJEaHqt7meJ/6z1FvQ3d8Pmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q8DZdwYJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q8DZdwYJ"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so3590233b3a.1
        for <linux-block@vger.kernel.org>; Mon, 08 Dec 2025 12:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765225790; x=1765830590; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKx3nA48r5FIPTwFA5MAiW0YP9PNTZEtL1AbQMhVfn8=;
        b=Q8DZdwYJ+56X+sDU4qMl5IOAarrSWLfCz0lEBU4cXGCQ/x+Q+FUCVKn12AvNWxb5gN
         JCZkBBuFvoI7mcHMfrdBmONKynipZq9eOboWwMDy85OAcGMtObePKlxQyKUieqoJpsOq
         t1qymnaC8cT+z9c95RYEP5ThoN3RY9+63bWFkX8ox0HSYip3X0WI6860PJF5kI7ZFuIm
         qmZyiM89235aXpx46Ub8yV8P4jRoVEnJP2sCku/DjGLnTRDX8wSOhj9GHa9cRDYI8O2q
         WRYb4B5R3TJ2EcTIsGi+Okkusne11w0ByNIMTmow9QXo1mi1RLaeGS30/fe13tfVz4i7
         N/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765225790; x=1765830590;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TKx3nA48r5FIPTwFA5MAiW0YP9PNTZEtL1AbQMhVfn8=;
        b=LwJrPx4N7NNnyMekXAcogP8wCLX9LR10m1jqAro2uXXADwq5irobgBxnQ34jZjn1J3
         7nXwZ3PAggZC013V2UMkgavejuo3pc+DVFfdP1buuVS2JysvLk/rV6w1irEwFhwpJpQN
         PEAfZuem4ddcSc+VUPn+8b4AqWtkI9GsKEpEeOG5wkRgdfDIIP1cdE3SbbLGCY8UEDzA
         RBt1ZQEDTqD+Nxoey/ea/2eC0ngnn2Z2IqVRn/cOG1s3vPvDD7uus4J0fLA6/b2NnKq4
         OE8UWvpp60JML9CVo4nMUDzDvJTRI+8ECugwKFZF7nu0tuNkT7KAVRg5+Tz34TiLzmdA
         bR/g==
X-Gm-Message-State: AOJu0YzFdwx9JvPno2VGoZvHkiPsnlw2s4RkeBqvoMaLpaM2SQqWP1UK
	THwmRGy9EYwmU+FGwH1wlDU9j+beTvxyQkHE6CzUg+nOByoZy1Ect1k8QtEJnDCWK4nVyxz7DZ9
	Tp1GV
X-Gm-Gg: ASbGnctxTcabedsJkFtLnxTvfSaKaESCVJ0mTmL1JSlN+k9gVGXD6nt28D+cyqqyb8U
	t/CZw9w6pmzNbJF/+7SxQ7SwC1sDGOK4hi912+X6eQL/DkTFI/T5cduLKebSv2UpSkacIrHsfwp
	krgQNotKPWLkSnqMu0BdBX341urkeoBdahTCeVeyBv2eDxvSncJQ3xlVKDqvvBjEdiBmXcrvUVB
	f7ck6uej4wBY0CWNrI/l9HDoxkwlraMoKX7p9Fjm4OIsQzGN5GGvr4CVXk1hJY0heiJZxj7SHOo
	dgtADjbmb91FvsSPY14bpRcJ54T/jC1/heridtgXOnyjCzfSW4oIKrTPNgSFfW2rkSJbBBKCpe/
	ldukXlTrp8ycOlgo9ZvGTPF3fLsQ0bYXbyKL4FWBVdUmwp5qc3VaaPl0DS6L0dBn8RDfSAmkwip
	TQC7h6CsEYwapEyOCts2LTfPGFLPYP8JffAh0=
X-Google-Smtp-Source: AGHT+IFx2/0gr34rk5sIhWFl8Z6fbjYX/9qKd4YeFpFQjcleGF6aRxxtIq55iGQuUyev22sm3orhng==
X-Received: by 2002:a05:6a20:7288:b0:366:14b2:30c with SMTP id adf61e73a8af0-36618021d33mr9072892637.63.1765225789686;
        Mon, 08 Dec 2025 12:29:49 -0800 (PST)
Received: from [172.19.130.138] ([164.86.9.138])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf686b3e683sm12867375a12.8.2025.12.08.12.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 12:29:49 -0800 (PST)
Message-ID: <34687025-4ddd-4d54-a910-557eb9090566@kernel.dk>
Date: Mon, 8 Dec 2025 13:29:37 -0700
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
Subject: [GIT PULL] Followup block changes for 6.19-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Followup set of fixes and updates for block for the 6.19 merge window.
NVMe had some late minute debates which lead to dropping some patches
from that tree, which is why the initial PR didn't have NVMe included.
It's here now. This pull request contains:

- NVMe pull request via Keith
	- Subsystem usage cleanups (Max)
	- Endpoint device fixes (Shin'ichiro)
	- Debug statements (Gerd)
	- FC fabrics cleanups and fixes (Daniel)
	- Consistent alloc API usages (Israel)
	- Code comment updates (Chu)
	- Authentication retry fix (Justin)

- Fix a memory leak in the discard ioctl code, if the task is being
  interrupted by a signal at just the wrong time.

- Zoned write plugging fixes.

- Add ioctls for for persistent reservations.

- Enable per-cpu bio caching by default.

- Various little fixes and tweaks.

Please pull!


The following changes since commit 559e608c46553c107dbba19dae0854af7b219400:

  Merge tag 'ntfs3_for_6.19' of https://github.com/Paragon-Software-Group/linux-ntfs3 (2025-12-03 20:45:43 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20251208

for you to fetch changes up to 0f45353dd48037af61f70df3468d25ca46afe909:

  Merge tag 'nvme-6.19-2025-12-04' of git://git.infradead.org/nvme into block-6.19 (2025-12-04 20:58:19 -0700)

----------------------------------------------------------------
block-6.19-20251208

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      blk-mq: add blk_rq_nr_bvec() helper

Chu Guangqing (1):
      nvme: fix typo error in nvme target

Cong Zhang (1):
      blk-mq: Abort suspend when wakeup events are pending

Damien Le Moal (1):
      block: Clear BLK_ZONE_WPLUG_PLUGGED when aborting plugged BIOs

Daniel Wagner (5):
      nvme-fc: don't hold rport lock when putting ctrl
      nvme-fc: check all request and response have been processed
      nvmet-fcloop: check all request and response have been processed
      nvmet-fcloop: remove unused lsdir member.
      nvmet-fc: use pr_* print macros instead of dev_*

Fengnan Chang (2):
      block: use bio_alloc_bioset for passthru IO by default
      block: enable per-cpu bio cache by default

Gerd Bayer (2):
      nvme-pci: print error message on failure in nvme_probe
      nvme-pci: add debug message on fail to read CSTS

Israel Rukshin (3):
      nvmet-rdma: use kvcalloc for commands and responses arrays
      nvmet-tcp: use kvcalloc for commands array
      nvme-auth: use kvfree() for memory allocated with kvcalloc()

Jens Axboe (1):
      Merge tag 'nvme-6.19-2025-12-04' of git://git.infradead.org/nvme into block-6.19

Justin Tee (1):
      nvme-fabrics: add ENOKEY to no retry criteria for authentication failures

Max Gurtovoy (2):
      nvmet: add sanity checks when freeing subsystem
      nvmet: remove redundant subsysnqn field from ctrl

Shaurya Rane (1):
      block: fix memory leak in __blkdev_issue_zero_pages

Shin'ichiro Kawasaki (2):
      nvmet: pci-epf: move DMA initialization to EPC init callback
      nvmet: pci-epf: fix DMA channel debug print

Stefan Hajnoczi (4):
      scsi: sd: reject invalid pr_read_keys() num_keys values
      nvme: reject invalid pr_read_keys() num_keys values
      block: add IOC_PR_READ_KEYS ioctl
      block: add IOC_PR_READ_RESERVATION ioctl

shechenglong (1):
      block: fix comment for op_is_zone_mgmt() to include RESET_ALL

 block/bio.c                     | 26 ++++++------
 block/blk-lib.c                 |  6 +--
 block/blk-map.c                 | 90 +++++++++++++++++------------------------
 block/blk-mq.c                  | 18 ++++++++-
 block/blk-zoned.c               |  4 ++
 block/fops.c                    |  4 --
 block/ioctl.c                   | 84 ++++++++++++++++++++++++++++++++++++++
 drivers/block/loop.c            |  5 +--
 drivers/block/zloop.c           |  5 +--
 drivers/nvme/host/auth.c        |  2 +-
 drivers/nvme/host/fabrics.c     |  2 +-
 drivers/nvme/host/fc.c          |  8 +++-
 drivers/nvme/host/ioctl.c       |  2 +-
 drivers/nvme/host/pci.c         |  2 +
 drivers/nvme/host/pr.c          |  6 ++-
 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/auth.c      | 18 +++++----
 drivers/nvme/target/core.c      |  5 ++-
 drivers/nvme/target/fc.c        | 48 ++++++++++------------
 drivers/nvme/target/fcloop.c    |  9 +++--
 drivers/nvme/target/nvmet.h     |  1 -
 drivers/nvme/target/passthru.c  |  2 +-
 drivers/nvme/target/pci-epf.c   | 14 ++++---
 drivers/nvme/target/rdma.c      | 12 +++---
 drivers/nvme/target/tcp.c       |  6 +--
 drivers/scsi/sd.c               | 12 +++++-
 include/linux/blk-mq.h          | 18 +++++++++
 include/linux/blk_types.h       |  5 +--
 include/uapi/linux/pr.h         | 14 +++++++
 io_uring/rw.c                   |  1 -
 30 files changed, 278 insertions(+), 153 deletions(-)

-- 
Jens Axboe

