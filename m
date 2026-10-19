Received: from mta1.migadu.com (out-35.mta1.migadu.com [95.215.58.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B171948A2D7
	for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399365; cv=none; b=NYV2bz5AztBLwRT116GfUNHUMlLry1gCq3RsZSUO+eximz3RtKTf0aXv8USo5KAVoBWa83YCbZo9Jy9UTIHruPW1Wpo3FW345YBzREihpe5Nd2G/QIJ6ywkCK6Fhb7P4ww+nwfbTBqpHyb8xYIZN/aBV9Tpl/DilueUh6BMBxOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399365; c=relaxed/simple;
	bh=odjfn2izfAo2w5tQ6HYI0YZ1UDfPhsVNP6KZIXl9HQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jnD4QGcNigb2bM6YJEhGKHg+aTYxF1EANjiMkV6PVsD3sWfbISCNkc8R2+HY14S3fjmYD0UnMEIV6XAqylEslu21Psxte2GLg042IWML5DWpoQ83vqwhhVUvFx0cJ9I/g9W/7eJzc141akbSHViLowK0W83gTQCZF8xUFh/w3E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xoIyzvTp; arc=none smtp.client-ip=95.215.58.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xoIyzvTp"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=odjfn2izfAo2w5tQ6HYI0YZ1UDfPhsVNP6KZIXl9HQ4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792399361; v=1; x=1793004161;
 b=xoIyzvTpDfR0NNkEMhH2EiB2H33aFwL3zG2qtXwRJX3rnnkMjqhL2wtxyoauExJ0SwMalrYk
 qi2K4xfe344RBX1dHLNb7wc+gpuIiR382Hm/kzwNa2jqXLfP/wVYjfC2Krq+3H9ZvAlgivHNQma
 jMC5WbqwDpJkG0BN2Kz7a/Sw=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 757c9eb6770649ca;
	Mon, 19 Oct 2026 08:42:41 +0000
X-Mizu-Trace-ID: 757c9eb6770649ca
X-Migadu-Flow: FLOW_OUT
From: Jackie Liu <liu.yun@linux.dev>
To: josef@toxicpanda.com
Cc: axboe@kernel.dk,
	shuah@kernel.org,
	tom.leiming@gmail.com,
	yukuai@fygo.io,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/4] nbd: revalidate startup state after queue updates
Date: Mon, 19 Oct 2026 16:42:23 +0800
Message-ID: <cover.1792399225.git.liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jackie Liu <liuyun01@kylinos.cn>

Hi,

Commit 8b428f42f3ed ("nbd: fix lockdep deadlock warning") drops
config_lock around blk_mq_update_nr_hw_queues(). The initial checks for a
running device and NBD_FLAG_CAN_MULTI_CONN can become stale while the
lock is dropped.

Two NBD_DO_IT callers can both pass the PID check. After the first caller
starts the device, the loser overwrites nbd->pid before failing to create
the existing sysfs pid attribute. Concurrent NBD_SET_SOCK or NBD_SET_FLAGS
can also leave multiple connections without NBD_FLAG_CAN_MULTI_CONN,
which the queue-count retry does not validate.

Recheck both conditions after reacquiring config_lock. Reject an already
started device with EBUSY, and reject unsupported multiple connections
with EINVAL before retrying the queue update or starting receive workers.

Each fix is followed by its regression test. The tests prime the hardware
queue count before each attempt and use socket pairs, so no external NBD
server is needed. They require CAP_SYS_ADMIN, at least two online CPUs
and unused NBD devices. To build and run them:

  modprobe nbd nbds_max=4 max_part=0
  make -C tools/testing/selftests TARGETS=nbd
  make -C tools/testing/selftests TARGETS=nbd run_tests

For longer runs with a reproducible random seed:

  tools/testing/selftests/nbd/nbd_pid_race --rounds 100 --seed 123
  tools/testing/selftests/nbd/nbd_multi_conn --rounds 100 --seed 123

These tests use scheduling stress rather than kernel instrumentation. A
passing run means that no regression was observed during that run; it
does not guarantee that every interleaving was exercised. The flags test
excludes changes observed after PID publication.

Testing on the v7.3 base below:

  - ARM64 kernel Image and modules built with GCC.
  - Both selftests built with GCC and Clang; kselftest installation passed.
  - In QEMU TCG with two CPUs, all three cases passed 100 rounds with seed
    123, with no reported regressions or test errors.
  - Both tests passed through the standard kselftest runner.
  - Removing both fixes made all three cases detect their regression.
    With only the PID fix, the PID case passed and both multi-connection
    cases still detected their regression.
  - The fixed-kernel run had no WARN/BUG/Oops reports and remained
    untainted. Missing-device skips emitted one TAP plan per test.
  - Fault injection checked PID-read error propagation, EINTR retry and
    attribute disappearance handling in the test helper.
  - In-tree checkpatch --strict reported no errors or checks. The generic
    new-file MAINTAINERS warning on patch 4 was reviewed: patch 2 already
    registers the entire NBD selftest directory.

Both driver fixes carry the upstream Fixes tag and a stable Cc for
v6.17 and later. The selftest patches do not request stable backports.

Thanks,
Jackie

Jackie Liu (4):
  nbd: reject concurrent device starts
  selftests: nbd: test concurrent device starts
  nbd: recheck multi-connection support on startup
  selftests: nbd: test multi-connection startup races

 MAINTAINERS                                  |   1 +
 drivers/block/nbd.c                          |   7 +
 tools/testing/selftests/Makefile             |   1 +
 tools/testing/selftests/nbd/.gitignore       |   2 +
 tools/testing/selftests/nbd/Makefile         |   8 +
 tools/testing/selftests/nbd/config           |   7 +
 tools/testing/selftests/nbd/nbd_common.c     | 465 +++++++++++++++++++
 tools/testing/selftests/nbd/nbd_common.h     |  53 +++
 tools/testing/selftests/nbd/nbd_multi_conn.c | 147 ++++++
 tools/testing/selftests/nbd/nbd_pid_race.c   |  86 ++++
 10 files changed, 777 insertions(+)
 create mode 100644 tools/testing/selftests/nbd/.gitignore
 create mode 100644 tools/testing/selftests/nbd/Makefile
 create mode 100644 tools/testing/selftests/nbd/config
 create mode 100644 tools/testing/selftests/nbd/nbd_common.c
 create mode 100644 tools/testing/selftests/nbd/nbd_common.h
 create mode 100644 tools/testing/selftests/nbd/nbd_multi_conn.c
 create mode 100644 tools/testing/selftests/nbd/nbd_pid_race.c


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
