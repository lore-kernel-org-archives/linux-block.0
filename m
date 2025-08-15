Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3943C28BAA2
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755270583; cv=none; b=eASBxmuMoE1l4r07puRD9O6OHbgaBt+7+cj0XZjw7gwNFRGxEAKmORuFpPJdBCl3jLKCsUS22CCzcLYhTXiOKYDf3JEf5VCwCBhFsMC7Yeed4ahck82BfwunYtCbR5veWJ8ebWHZbdKVZZJKY8B3ikTTkvhCJfLBGV6uhqAeZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755270583; c=relaxed/simple;
	bh=+GWurHVUwBTCCMymSfpLXwoSzy9ypnEJMh8ousVWsCk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=piJMK5jzkmDi1RrSVB04hgQaza8fD+0XA9+KwCMzVd+8f+PEbKc0WjCcp31SGn/loFCHfffgvQf+ZbIwLHGSMZMJhVmBTfmvTZgUiqRBwKcU0m7PtFitOdVUZtiRgdM4HtIfQPaXeig4+j/If62BMV3NbvM9pw47FDYZr9I5kac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NxBDF3aG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NxBDF3aG"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2e8e2d2dso1266167b3a.1
        for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 08:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755270579; x=1755875379; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0l44b8E8wnwuX41DUPzB9DqSt+kmdvQHc7LcBNG2JQs=;
        b=NxBDF3aGG8q1O1mlpD5UGrzL5m8PGYRdKdekRkuQTzYb8uMnbt+oPgAOzeSIUDy0ZH
         wpNEeaK9VA1Ut8ouV6c+rLG4iupxSgATY7eiy7kveHpLUABLZZ1PbLw77wZu257fAWdM
         bau++a5C/DgHYALOGpWvCJETG7MhgiuKvhmwMMi1lwR5X6RLlYzQDIJxwNELhM2YPtro
         ADlr17rHmrbiYVhN6ooyCwpdoVZbqeKwH+9xgoxP1Tizp/5vu8KUC3MAGppFe736Tt/+
         QKwzHbDkpAFwL5m85prch7YFdGVpBNQ3XkJlCoxtGuMjoUxhOn+EsxH8q2yYtG1GmvpT
         4EJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755270579; x=1755875379;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0l44b8E8wnwuX41DUPzB9DqSt+kmdvQHc7LcBNG2JQs=;
        b=lkgyl7WGsofiYJQLqm2cXskPa7I+ag46igkSNROJFG6HB0TNqyTHJCFuSNaHqOWXFq
         N+Amf2VLZNs7+uFgz8mSw6St/WOxH7IobkZDcz/dxD9jHT2sldbMQuK+4Ba8y+lbIOsg
         uzH/oGki4d+x5jQYXmYrnod17EpBJR9Kxu1fUFr03aAy4EgwXqHD2Y1EnaNE1sgjDg+t
         mIIpra0O1gey5KDg7Pw0XBijeBir9xVL3Giyd7gkFQFkMM5Vha1A9/lRXGWiGT51emTm
         d8Qq0sbor6OaVAZl9q8ifn2pqxXXxT4ylrHN92X9vbOEfGD7lZDVFxFBjtZkm3cRtreZ
         74ww==
X-Gm-Message-State: AOJu0YxnR88FaWMcm5wFfYnTwpJv1B155a5J/4U98QuaBvUxz8EtTP++
	ptMXZJKAvvNHpH3tkHa7Ek/zBirvUHawIvtd9Wuiqkp1gtH7f80Vb0937oFpe+tRolj4QaJvm9Q
	JTLMf
X-Gm-Gg: ASbGnctmmoSzXUYl19eT2kNp9llUiqYY0o16SJ86NwhLEfis3YaJz14Rpw988/6U0Yv
	1i4a+0doQMesy53Lc6qLzN2OcG8K7ix29V7xO0ykvhVb8oHCces8j5iwHpFkXdihsGHtB98RdtG
	sMnf9wiThaqHbDF0jddVnYSgzHKeQrAX+4dWOddtC3/LFTzLxAIkAMMZapHNhOX8aDnnys9oq77
	9dSi1UVLC6htwZjRCfFCxfo7aoe/Agusv+FJInGj1wf7DO3R+Y5n5pTXIgUrrS+CS5UPdIM173r
	dG8WtKzzQW9FO5or6OM3QbEbL9aR0sf5KVQVKz80pY/UX1j2vtyIsd5lzO6Pn2HxE4S+C28xqyS
	tjbZsyo8fVl9gruNJ2yFvm2RJjUffZRO/EMwnUF4G
X-Google-Smtp-Source: AGHT+IHsZv1isCloPi/o0K302ZSL59y1Axhsb6OK2KvgfA3YjZJRGfiou3IhF2nINIsotPR5mnRgqg==
X-Received: by 2002:a05:6a20:9151:b0:240:1e97:7a15 with SMTP id adf61e73a8af0-240d2e9f1e4mr4117111637.27.1755270579289;
        Fri, 15 Aug 2025 08:09:39 -0700 (PDT)
Received: from [10.2.2.247] ([50.196.182.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d777360sm1534950a12.49.2025.08.15.08.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 08:09:38 -0700 (PDT)
Message-ID: <7dde5580-bc75-4418-800b-c4d58bc600ed@kernel.dk>
Date: Fri, 15 Aug 2025 09:09:37 -0600
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
Subject: [GIT PULL] Block fixes for 6.17-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of fixes that should go into the 6.17-rc2 kernel release. This pull
request contains:

- Fix for unprivileged daemons in ublk.

- Speedup ublk release by removing unnecessary quiesce.

- Fix for blk-wbt, where a regression caused it to not be possible to
  enable at runtime.

- blk-wbt cleanups.

- Kill the page pool from drbd.

- Remove redundant __GFP_NOWARN uses in a few spots.

- Fix for a kobject double initialization issues.

Please pull!


The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.17-20250815

for you to fetch changes up to 8f5845e0743bf3512b71b3cb8afe06c192d6acc4:

  block: restore default wbt enablement (2025-08-13 05:33:48 -0600)

----------------------------------------------------------------
block-6.17-20250815

----------------------------------------------------------------
Caleb Sander Mateos (1):
      ublk: check for unprivileged daemon on each I/O fetch

Erick Karanja (1):
      Docs: admin-guide: Correct spelling mistake

Julian Sun (1):
      block: restore default wbt enablement

Philipp Reisner (1):
      drbd: Remove the open-coded page pool

Qianfeng Rong (2):
      block, bfq: remove redundant __GFP_NOWARN
      blk-cgroup: remove redundant __GFP_NOWARN

Tang Yizhou (3):
      blk-wbt: Optimize wbt_done() for non-throttled writes
      blk-wbt: Eliminate ambiguity in the comments of struct rq_wb
      blk-wbt: doc: Update the doc of the wbt_lat_usec interface

Uday Shankar (1):
      ublk: don't quiesce in ublk_ch_release

Zheng Qixing (1):
      block: fix kobject double initialization in add_disk

 Documentation/ABI/stable/sysfs-block              |   2 +-
 Documentation/admin-guide/blockdev/zoned_loop.rst |   2 +-
 block/bfq-iosched.c                               |   3 +-
 block/blk-cgroup.c                                |   6 +-
 block/blk-sysfs.c                                 |  14 +-
 block/blk-wbt.c                                   |  15 +-
 block/blk.h                                       |   1 +
 block/genhd.c                                     |   2 +
 drivers/block/drbd/drbd_int.h                     |  39 +---
 drivers/block/drbd/drbd_main.c                    |  59 ++---
 drivers/block/drbd/drbd_receiver.c                | 264 +++-------------------
 drivers/block/drbd/drbd_worker.c                  |  56 ++---
 drivers/block/ublk_drv.c                          |  28 +--
 13 files changed, 106 insertions(+), 385 deletions(-)

-- 
Jens Axboe

