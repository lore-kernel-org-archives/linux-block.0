Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921C93112B2
	for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 02:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610931; cv=none; b=MoL/tm9E0yMdy1J4AyNPM7sPL0/RpCdfKsXeP7u1F7bxfsRU0o8mLHZLwZ8LZcUAa3B8y5I55puoV4qn9u3AQD7R1A3WpmqpUHbBvynhzor4FOyLPU3UNH9BHToo5eemokdNNaDcaAJLnfNmOFXEPBBvcCmv/AmS6YmzK2j9VpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610931; c=relaxed/simple;
	bh=tREBFssnjTJDBsdx7Bh7LikjJNSm8QhhFmgJ6Tr4AcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rHRYP3Y87rhlc+vsTrt12+ieikOHA/v7YEHSplvuuro4dzzFok5Wymj6J8OxTYh63rWSMYX4NmD52fJHAcz8v/ACMnE+c/rP41fpCvisOW87TLFQKCDP/M3Pd9BpLumhVcXmCcMhk4N4L9eVAHYg/8uigiRiCz5XSgtRrWYUYts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EJIQJvgE; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EJIQJvgE"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-80a4e050a12so239756a34.3
        for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 19:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789610927; x=1790215727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y6ADbqR0e7yeHKOzmjJ3sEobIekLZTtqNlsLmAvzUso=;
        b=EJIQJvgEHRGJZmm8MUj5Pyl+ORCC+PYV5BqcvPV/tblF5UgWakrG+eUbw7SGW1MLGh
         UV3lTGTqhkZCz7vwkyY/QL7/f+Y0jeWdq9ll7FC4Hhdpjw3Pg2feC5V+6NX5WuFfS8tl
         Xtg2nndW8YeR2yZGbsZ8kHVRL1IRp1IWew/nRa1ThcxsbZGlxDDFtoDaYJIpwbqBmhCt
         /Wm6OxLRaERuXuTfOpqG7G88JFu4d65U/zO34gB99mlJKgHEsvu/ensK4zA2GPR+DLsE
         A0qUkq3yW+vgmFFbpebE0mYvV5aUV144bdFbpseNVHeniclS4GU9IYRYEhhN1R+NtcnM
         X1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789610927; x=1790215727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y6ADbqR0e7yeHKOzmjJ3sEobIekLZTtqNlsLmAvzUso=;
        b=eA9+++hvxbdUitmlWbu22EcLXsqgrcfF4l/Rdl9pRKVvYqKxJI8d8Wr5yaBKs6IMBY
         3epUlXx7oAy/1rl3N0aJgaDk2vQXqenRJxMHeRFyxX5f1KfU7veTFJ5bs9yGizK9XQfY
         pEnN3exeU22WL+G4q8c1mRnDvkItkMghfvLegSxlhlUC1xVclfpsSGJJhvhz08yDDv3T
         IZJURnv4Mja/4lAHrO2zsZnJQIftARR+2VKdHRUkZHe1w72PUHbN/W1PhRo1ZfLJZQfv
         sHpgYbdrXGXdGktz58Tu4QaxmfubLyWIUbxf8U0g+sTzx5W6TnBLz0qth6Fou3KBrJ0a
         cg/w==
X-Gm-Message-State: AFuF++lVOqkDsgIOyMzhz4ZrgsglQSdxLbiKhNdzVh2ovFqGwCoV5Nry
	Koy0UKZkWlt+a7S76Wa63jpkILeJoSAJ2QWxZcCECP8IChQGo9y0YSxrTMUFLhDRXmbZ9DWazAe
	UmNR4A2Sd6uTVsIks4+l+ETDW0zBxs7zAkPHbCRljp2WScHciEwnJ423jLB0tDtuAtZIORUkTHj
	mXjmwSJO7SrP8RJZ0QY1YOztmOdXdEQ8xE4fnnDblROE02tApdYYWtjdxdrw==
X-Gm-Gg: AYBFou3Xq+GiaefdTPfERfBz3xSwvi5V9ACPmg++vZCUVrHEoHfZI1S2Yb69r6l9nky
	fUpUhoBaRe1bI4nbDqDRFnfdkgN7xyovRq5RK1EuAaEfjFhcz96bXPnqzjrM1iUmORlXOBhpbzF
	z1bhaMhtyk7KBnYLyVhzFcYDNGvdgh3zyiwqNsYxJUvNuo/DmKN1ME7oSDySqTSnjAlnct5oWF1
	dfNU2nSF0PSnrzI5JW/dnMJOBWWNLDwPb0fN3mdqnkpcCCjG7RukLrateO4iwhhXdSdaowbzTYK
	dTFtnWO+kLr9KxP0/mE1ZV/1MfTKy1njIkEJ3jF2XGGtdHV4bvh9jQEamUJLQfl9y8pCLWi2LhG
	gBP0NjeXgw4OVUEVjneNoo+3rXijDjeTpIY0L6Gqx6i/nwvZSohBwnpmiDzwW0cYjJG7At3kDeo
	rDfJSBKeN+dzNFT0kEcUR/kZxor0Gh6Ihmx5hKgdbvL1wlWk7dEvldbez6q1gJ1ZUBoyGsseLTx
	DVzEo9/O/8dtiumF3qUppCzk/u3a5k7UeS39cw=
X-Received: by 2002:a05:6830:90c:b0:7df:5fc:3fd5 with SMTP id 46e09a7af769-80b2cfc4bc5mr5380455a34.1.1789610927134;
        Wed, 16 Sep 2026 19:08:47 -0700 (PDT)
Received: from dev-mkhalfella.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-80c46cb6675sm1862569a34.16.2026.09.16.19.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 19:08:45 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Jesse Taube <jtaubepe@redhat.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH blktests 0/5] nvme: detect ABA ghost writes on multipath fabrics
Date: Wed, 16 Sep 2026 20:06:20 -0600
Message-ID: <20260917020752.1672578-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a write times out on an NVMe target today, the initiator resets the
path and retries the write on another one right away. Nothing has told
it the original command is dead. The command was never acknowledged, and
the reset is a local action that does not reach into the fabric to
retire it. So the retry lands, a later write to the same LBA lands after
it, and the original command finally arrives at the controller and
overwrites the newer data. A read now returns a write the host gave up
on. This is the ABA ghost write: the block holds X, then Y, then X
again, and no layer above notices.

The host side of that window is visible in dmesg. The write times out,
error recovery starts, and the controller is torn down and scheduled for
reconnect, all while the command is still outstanding at the target. The
retry has already gone out on the other path by this point:

  [  240.598176] nvme nvme4: I/O tag 113 (0071) type 4 opcode 0x1 (Write) QID 5 timeout
  [  240.600233] nvme nvme4: starting error recovery
  [  240.619821] nvme nvme4: Reconnecting in 10 seconds...
  [  245.677026] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
  [  245.973568] nvme nvme4: Removing ctrl: NQN "blktests-subsystem-1"
  [  246.328666] nvme nvme4: Property Set error: 880, offset 0x14

Nothing here waits for tag 113 to be retired, because there is no
mechanism that would let it.

It is silent data corruption. Both writes were reported as successful,
the host has no error to act on, and the block now holds data that was
superseded. Anything layered above, a filesystem or a database, has
already committed on the strength of the acknowledgement it received for
Y and has no reason to read the block back.

NVMe defines two mechanisms to close this window. CQT (Command Quiesce
Time) tells the host how long after a timeout it must wait before a
command is guaranteed to be retired, and CCR (Cross Controller Reset)
lets a host reset a controller through another controller in the
subsystem, fencing off the commands still outstanding on the path that
went away. Linux implements neither today, on the host or the target
side, so there is no bound on the lifetime of a timed out command and
nothing prevents the retry from being overtaken by the original.

These patches therefore add a test that fails. nvme/070 fails on tcp,
rdma and fc as of today, and that failure is the point: it is the
missing CCR/CQT support made visible and reproducible. It passes on loop
only because nvme-loop defines no timeout callback, so the write is
never timed out and never retried. The test should start passing on the
remaining transports once CCR/CQT support lands.

This is what the failure looks like on tcp, tested on commit
fd9beb887073 ("nvme-tcp.h: drop kernel-doc comments, fix a few
descriptions"), tag nvme-7.3-2026-09-03. The detector reads the block
back and finds a pattern other than the one written last, so validation
fails on the first iteration and the corruption is caught directly, in
results/nodev_tr_tcp/nvme/070.out.bad:

  Running nvme/070
  Target ports: 2
  starting nvme-ghost-write-detector test program
  iteration number 0, writing data
  validating written data
  validation failed
  finished nvme-ghost-write-detector test program
  Test complete

Reproducing the race needs an IO that can be held at the target for
longer than the host's io_timeout without being failed. The first three
patches give miniublk that ability, since there was previously no way to
talk to a running ublk server at all:

  1/5  adds a loopback UDP control channel to the daemon, served by a
       detached thread, one reply datagram per request
  2/5  adds an INJECT_DELAY command which delays a given number of reads
       or writes as an io_uring timeout on the queue's own ring
  3/5  exposes it as "miniublk inject", which returns only once the
       daemon has armed the delay, so a test can start IO immediately
       without racing it

  4/5  adds nvme-ghost-write-detector, which writes distinct byte
       patterns to a single LBA and reads the block back, so a
       resurfaced write is identifiable by the pattern that comes back
  5/5  adds nvme/070, which exports a ublk-backed nvmet namespace
       through two ports, connects the host to both, drops io_timeout to
       2 seconds, holds one write in the backstore for 4, and runs the
       detector

Mohamed Khalfella (5):
  src/miniublk: add a control channel to the daemon
  src/miniublk: add IO delay injection
  src/miniublk: add the inject command
  src/nvme-ghost-write-detector: add an ABA ghost write detector
  nvme/070: test for ABA ghost writes on a multipath fabrics namespace

 src/.gitignore                  |   1 +
 src/Makefile                    |   1 +
 src/miniublk.c                  | 376 +++++++++++++++++++++++++++++++-
 src/nvme-ghost-write-detector.c |  86 ++++++++
 tests/nvme/070                  |  98 +++++++++
 tests/nvme/070.out              |  35 +++
 6 files changed, 594 insertions(+), 3 deletions(-)
 create mode 100644 src/nvme-ghost-write-detector.c
 create mode 100755 tests/nvme/070
 create mode 100644 tests/nvme/070.out

-- 
2.55.0

