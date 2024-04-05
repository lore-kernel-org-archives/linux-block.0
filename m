Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A975174EDF
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712350028; cv=none; b=Ok283FmiWIQPyNMzE7pHauSWTPnLYTwYilLdnbd5ZoThnSBxL5AcUShX09E+zrmBcOngqgfI09gEUzq3JAi/JB6wA54c2aRfh7rCJtqt5C1/jPgk7inIxa47Dn4r90DP/DXSyVi8nip3TKinsw052Nhh4Q7juLDfsy5oagCuMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712350028; c=relaxed/simple;
	bh=Dxk9J99fPNN1HvHxdsa1ZGsLoGkREeDshYRW4RvSnyQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=q0F/5X1yIsmHa6OVpX2cGGjac1qWlsI2nX9pG6HndAEF2kYRcNOKFSL6YEuJQoPOab5lFdsVm9LH6VmAftGH7G5Cw3ozTGnueG8fvESemjUTW0OWO1KNI3PmogSEUY1X/wEpst9m1OR8EqgKh70QJ6V8Zo9Ml8VUUw+eOQ9RcoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=M6DmylrA; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="M6DmylrA"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-479e0a14464so154343137.1
        for <linux-block@vger.kernel.org>; Fri, 05 Apr 2024 13:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712350024; x=1712954824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oC2T1JOqldmuASLofTfn4PyLCHG+OnD0sH6etOVSHog=;
        b=M6DmylrA8bX6F2rKO4VUf1M9wr9NdVTtIA5t66VbQ0NVKvTb9dmD/tjlnVGPCZVyEL
         O3P3cacKt8AzcmL4AuqrMSk+ohNE6b0lkozESbMPHfsn2eunCClUbt4rwwHBQhVA4Uk9
         rgVLOeikyNQR52VJTQWA0adA8S28RGE/T3AlpeU2CCPIRsackT5og8w4Q3jD9/MnUYYq
         7JGN2pjhIba/sEMnc0Wj4T7sgGsUnSHk8QRocCB6w0mhvu3tQ+BcCRaVHIQ6D0Rd7aKo
         WYTxJD6AID6+6JCQcd9mX4pUWNvm/hJi+AmbHqb+SUc2hYy4KLiQbizGUYKdp092yomV
         qxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712350024; x=1712954824;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oC2T1JOqldmuASLofTfn4PyLCHG+OnD0sH6etOVSHog=;
        b=OmOqjg81RU+qeOrCZ8hCLrLLnUxliltzb6XSA7gT1wlbXz5PtviqH65LFp34CCjRMw
         j6LLRw2rTJZot6vek/bmTcExUkHnogaCGkmG5UYIuxaLaLvv4FSM+XdEgRLRYmY2C3Im
         lxCxxSN08O8ZO//lQlkGysaanZ2feGUgOFQAjysW2Z3eDp3wdbvRg567ydL/KOnn8O8r
         W2/ZHBJvXZgXMadvYrBVR1KanR8JTWdUKgpKfhrzpeBsOl/2N/e+FwMiEWUDzknp/AP6
         NaKsiaD6SkzmOh+FigRhC9Y9A3z2ZiMQIjKbO4yCQWsEzBN0cjdxorILb6AQec90J1Hq
         C0CA==
X-Gm-Message-State: AOJu0Yz9kGBSDyz1E+rlLm1318Ysrrk60ZIqaBQX/C9rvOiQdLX+Ctry
	PtNLzMJWgnziKQIJJxEjSJa7Nj5uQNwvEuYGzA48AdtkiPIgU3hyyv17CHOK2ijf0DQzG9fQh+w
	/
X-Google-Smtp-Source: AGHT+IFdMR2bzQFQTTvSbbxhRQ9E05hgOFENUVmCMAycgeiYWdl6/9GsCsL9ksCGpG3voGzxkmzHeg==
X-Received: by 2002:a05:6102:464e:b0:479:ce5c:213d with SMTP id jt14-20020a056102464e00b00479ce5c213dmr2669761vsb.1.1712350024098;
        Fri, 05 Apr 2024 13:47:04 -0700 (PDT)
Received: from [172.16.25.96] ([12.168.1.234])
        by smtp.gmail.com with ESMTPSA id do18-20020a056214097200b0069942d4cc06sm587601qvb.115.2024.04.05.13.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 13:47:03 -0700 (PDT)
Message-ID: <8b66a441-b45f-4b86-a8f1-5b6afb61cf92@kernel.dk>
Date: Fri, 5 Apr 2024 14:47:03 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.9-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Block related fixes that should go into the 6.9 kernel release:

- NVMe pull request via Keith:
	- Atomic queue limits fixes (Christoph)
	- Fabrics fixes (Hannes, Daniel)

- Discard overflow fix (Li)

- Cleanup fix for null_blk (Damien) 

Please pull!


The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.9-20240405

for you to fetch changes up to 9d0e8524204484702234e972a7e9f3015080987c:

  Merge tag 'nvme-6.9-2024-04-04' of git://git.infradead.org/nvme into block-6.9 (2024-04-04 13:23:21 -0600)

----------------------------------------------------------------
block-6.9-20240405

----------------------------------------------------------------
Christoph Hellwig (3):
      nvme-multipath: don't inherit LBA-related fields for the multipath node
      nvme: split nvme_update_zone_info
      nvme: don't create a multipath node for zero capacity devices

Damien Le Moal (1):
      nullblk: Fix cleanup order in null_add_dev() error path

Daniel Wagner (2):
      nvmet-fc: move RCU read lock to nvmet_fc_assoc_exists
      nvme-fc: rename free_ctrl callback to match name pattern

Hannes Reinecke (1):
      nvmet: implement unique discovery NQN

Jens Axboe (1):
      Merge tag 'nvme-6.9-2024-04-04' of git://git.infradead.org/nvme into block-6.9

Li Nan (1):
      block: fix overflow in blk_ioctl_discard()

 block/ioctl.c                  |  5 +++--
 drivers/block/null_blk/main.c  |  4 ++--
 drivers/nvme/host/core.c       | 41 ++++++++++++++++++++++++++++--------
 drivers/nvme/host/fc.c         |  4 ++--
 drivers/nvme/host/nvme.h       | 12 +++++++++--
 drivers/nvme/host/zns.c        | 33 +++++++++++++++++------------
 drivers/nvme/target/configfs.c | 47 ++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     |  7 +++++++
 drivers/nvme/target/fc.c       | 17 ++++++++-------
 9 files changed, 133 insertions(+), 37 deletions(-)

-- 
Jens Axboe

