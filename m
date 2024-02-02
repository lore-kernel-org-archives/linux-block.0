Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62649145B23
	for <linux-block@vger.kernel.org>; Fri,  2 Feb 2024 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886972; cv=none; b=tvnf+qfouPULciFHM06+WvB91O7X6P2jxHkSpwzIOiUN5CR2qdsnO4/unqoq2DmSa8ElUhht+ISFLr+1lMis7/jGxGYh1aRjWopebqz6zlOdDoZOn5uo/VDeKGztSwEMSIZwaQPjmFngtI5l4A1RpxewFNd6mIZx0sfNLIbbS1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886972; c=relaxed/simple;
	bh=8GEKKkMAfbADX/N4J6U8571cGjSlEdlc8qlZkO3jung=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=fzwIWLSzrW/0knB0zu6C9BrO9lM73Uk1FCEmRJni2MEJY/MQ/y5BsCKRpsAW+0OWdqcLwNqoDWZnlA16DD/84+3PLGAH+G9xdNMOwRuJgCNDtEkNuQxtGI6zNx/bxTaj4HIUamFFXXaLGwXn7i+IPxp9dv96789r8AoZCWuofzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Knn43eDD; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Knn43eDD"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bff2f6080aso20712239f.1
        for <linux-block@vger.kernel.org>; Fri, 02 Feb 2024 07:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706886964; x=1707491764; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTM56ZpUQc5dADuypwp/9xKD6sLY+QobBUucoFHu/To=;
        b=Knn43eDDkAhlcRVFwqf3xGYKVU15rRW7Yo4UvQSrnKy0ZJJReaw7vQmq+ce1UVoScx
         4dRzaXccs/JXcHcFuaTebZdip15Gi1nCJFddS+GaWkezsG9zT+KCZhq7QsyIYr9AQIXo
         WTo1UjcblctK9Mk3cu8QarkeM+/JiRHYrknhgF72BPTPmnEZ0PNjeLZxCJRZufIPzyNV
         pPl/gzdBGYWTmTNiGAjIqCbwKKL+TVphEiIG9O/pwGZjzA11C7vjxhH4IF/q58qI66BE
         uGXXJ9Z6VZPdzKO+g/NSq4UoZaazmjAgskWH9jQhuZBUIc3lkBHA4SP27zFCSdM5h5o3
         9hHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706886964; x=1707491764;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DTM56ZpUQc5dADuypwp/9xKD6sLY+QobBUucoFHu/To=;
        b=QJi3N6tc+et1l6XKvcBxT3AdT3K4Som1NhfNVinTAtCTZjU/Y0MJdCe6JKWv5SroHA
         8VP8HSaKMtP7epd96NwTSJq4D0shBOBa7WUKOwiSqeNHfhwdX2dDRCU/2a1PLgmuXfTs
         GZCuVj+9r7/4p3/SJw1DtG9wVPlMK1sZORTq/5wEUA2P2XXDHF9y737OpNFJkQS1dS1u
         4imQRP8O3s5kmFep2jSqoEktZ38Vf91Uk48u8ZmgQus//D915Nsgu1qPx+VvaE+utRrd
         uVJ37L93BmTX7XZWKbQfrMhfxfqcoy1RfnQ5dc0rLMt0g9ndluIaeBFGaefORCTGUZ3M
         2xQQ==
X-Gm-Message-State: AOJu0YyE0v37SFlfYM1+/9Ujup/gtfxRmvmUC5UJvMelrNnBxlX2tBz/
	bpRU/zrgkZ0CHIsWYxgNs8KMKSa2EuW5RccMDGIK1kjH1pcuMjJveN4cIAAwBt0GiKFatKO/LMk
	dzcU=
X-Google-Smtp-Source: AGHT+IFRO2464laxCkgYjMQnwOdbm3tO67wlQkCinEbMrhSRtD8NeNBkmZLxaWFcYE+ZU8Mprc1nfw==
X-Received: by 2002:a05:6e02:2188:b0:363:8fa8:1c69 with SMTP id j8-20020a056e02218800b003638fa81c69mr9542566ila.2.1706886963716;
        Fri, 02 Feb 2024 07:16:03 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v12-20020a056e0213cc00b0036391b3e282sm635956ilj.35.2024.02.02.07.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 07:16:03 -0800 (PST)
Message-ID: <7f20bc8d-bf11-4101-9fd3-844cd954d338@kernel.dk>
Date: Fri, 2 Feb 2024 08:16:02 -0700
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
Subject: [GIT PULL] Block fixes for 6.8-rc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Fixes for the block layer code that should go into the 6.8 release.
Mostly NVMe fixes, but also a single non-nvme fix. In detail:

- NVMe pull request via Keith:
	- Remove duplicated enums (Guixen)
	- Use appropriate controller state accessors (Keith)
	- Retryable authentication (Hannes)
	- Add missing module descriptions (Chaitanya)
	- Fibre-channel fixes for blktests (Daniel)
	- Various type correctness updates (Caleb)
	- Improve fabrics connection debugging prints (Nitin)
	- Passthrough command verbose error logging (Adam)

- Fix for where we set IO priority in the bio for drivers that use
  fops->submit_bio() to queue IO, like md/dm etc.

Please pull!


The following changes since commit 5af2c3f44e004b5618ebef34ac30bd3511babb27:

  Merge tag 'md-6.8-20240126' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.8 (2024-01-25 17:03:54 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.8-2024-02-01

for you to fetch changes up to f3c89983cb4fc00be64eb0d5cbcfcdf2cacb965e:

  block: Fix where bio IO priority gets set (2024-02-01 11:00:06 -0700)

----------------------------------------------------------------
block-6.8-2024-02-01

----------------------------------------------------------------
Alan Adamson (1):
      nvme: allow passthru cmd error logging

Caleb Sander (5):
      nvme: return string as char *, not unsigned char *
      nvme: remove redundant status mask
      nvme: take const cmd pointer in read-only helpers
      nvme: split out fabrics version of nvme_opcode_str()
      nvme-fc: log human-readable opcode on timeout

Chaitanya Kulkarni (3):
      nvme: add module description to stop warnings
      nvmet: add module description to stop warnings
      nvme-common: add module description

Daniel Wagner (12):
      nvme-fc: do not wait in vain when unloading module
      nvmet-fcloop: swap the list_add_tail arguments
      nvmet-fc: release reference on target port
      nvmet-fc: defer cleanup using RCU properly
      nvmet-fc: free queue and assoc directly
      nvmet-fc: hold reference on hostport match
      nvmet-fc: remove null hostport pointer check
      nvmet-fc: do not tack refs on tgtports from assoc
      nvmet-fc: abort command when there is no binding
      nvmet-fc: avoid deadlock on delete association path
      nvmet-fc: take ref count on tgtport before delete assoc
      nvmet-fc: use RCU list iterator for assoc_list

Guixin Liu (2):
      nvmet: unify aer type enum
      nvmet-tcp: fix nvme tcp ida memory leak

Hannes Reinecke (3):
      nvme-auth: open-code single-use macros
      nvme: change __nvme_submit_sync_cmd() calling conventions
      nvme: enable retries for authentication commands

Hongyu Jin (1):
      block: Fix where bio IO priority gets set

Israel Rukshin (1):
      nvme-rdma: Fix transfer length when write_generate/read_verify are 0

Jens Axboe (1):
      Merge tag 'nvme-6.8-2024-02-01' of git://git.infradead.org/nvme into block-6.8

Keith Busch (1):
      nvme: use ctrl state accessor

Nitin U. Yewale (3):
      nvme-tcp: show hostnqn when connecting to tcp target
      nvme-rdma: show hostnqn when connecting to rdma target
      nvme-fc: show hostnqn when connecting to fc target

 block/blk-core.c                |  10 +++
 block/blk-mq.c                  |  10 ---
 drivers/nvme/common/auth.c      |   1 +
 drivers/nvme/common/keyring.c   |   1 +
 drivers/nvme/host/apple.c       |  13 +--
 drivers/nvme/host/auth.c        |  19 ++--
 drivers/nvme/host/constants.c   |  10 +--
 drivers/nvme/host/core.c        |  85 ++++++++++++++----
 drivers/nvme/host/fabrics.c     |  19 ++--
 drivers/nvme/host/fabrics.h     |   8 +-
 drivers/nvme/host/fc.c          |  60 +++----------
 drivers/nvme/host/multipath.c   |  15 ++--
 drivers/nvme/host/nvme.h        |  62 ++++++++++----
 drivers/nvme/host/pci.c         |   3 +-
 drivers/nvme/host/rdma.c        |  23 +++--
 drivers/nvme/host/sysfs.c       |  64 +++++++++++++-
 drivers/nvme/host/tcp.c         |  11 +--
 drivers/nvme/target/core.c      |   5 +-
 drivers/nvme/target/discovery.c |   2 +-
 drivers/nvme/target/fc.c        | 186 ++++++++++++++++++++++------------------
 drivers/nvme/target/fcloop.c    |   7 +-
 drivers/nvme/target/loop.c      |   9 +-
 drivers/nvme/target/rdma.c      |   1 +
 drivers/nvme/target/tcp.c       |   2 +
 include/linux/nvme.h            |  10 +--
 25 files changed, 390 insertions(+), 246 deletions(-)

-- 
Jens Axboe

