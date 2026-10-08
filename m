Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836B53ACEF9
	for <linux-block@vger.kernel.org>; Thu,  8 Oct 2026 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459555; cv=none; b=tcXEF6KJUyCs7gu2cf4Yv3km2wGYFsl+0VC35lhuJTfKU9rnU8vLaLBFLWIHfLwV1dad9djUv7NhiWvsAD46xmHws9u391lnFsMIFLYWuh5asWAMcLrodbMj5H8aP05+mPbF25ZQzTnuC4wShucFIWBjpN8nR9Oa8HpCtB9Tw2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459555; c=relaxed/simple;
	bh=00zIsjE4J4ttF41oaj29C3OI0yt5UFtjUVwbdLuPXD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fGG2/1+1psX0anVW7LgcFNgHdC+k4CYyzSMJEKjiYYE7xixm9tk67YjvXXTjC3yR50RVfst2vaA3dO/7yOtZc70X7i+muI2h6g9f8lFSFKMCmTgWXosszMWpHPMfKlb6PGX+XsoNX/werJQyPThpItQ5+Iwul3w2StRksPk6RJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeuNXe+P; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeuNXe+P"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6b1afdf5196so1033216eaf.2
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2026 04:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791459553; x=1792064353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e+jf1Zq3TlOzm7GpkIjOSkYCcmwHr3sGspbkiRq0JY0=;
        b=VeuNXe+PPkYvCdAEmkqeiVYxxi9PgQXBMfH4ZPQQxmlw5aJZa5LXGHznNUXng8zGJc
         yMXIbSMH9FuSNnbJ7zws5R/QTy22nc+dZPpxgUCBPVoOl8Wb/Y2Q5BV0yFgdlYgz+Nkp
         F28jQAy8w8G/oKmDlYWkeqcJM4oChyMdhoFePvFHkZ6yPPGjSKKDjl+b8FsNyqRFzFZV
         gXesqyB4GEZdpx27+SlRTrL4f32dOwDXa9z+9XGX25vQ5ayJGfhUDdydO5Q59H/1sPyj
         tmqpH2kEGwDj1UMoYZQoXvJW4FcaRZrBIT1FLgU13F5H9cODdDXF9mCB3bqXo8hhQH2R
         +6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791459553; x=1792064353;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e+jf1Zq3TlOzm7GpkIjOSkYCcmwHr3sGspbkiRq0JY0=;
        b=260zExAbHMoYgX8VRM1ambYY7byanEBJOZSZ88UaP1ZOnuAN8YFBzSRGf3JM28fCmh
         40JQj4gIVfhJWKDjHy+CzAu/YE8LZkUXwo/ocSGHFBMXVCyspAmv8zhRKrXy7AVVmwFu
         xE0zCzbaHfun9qKpxzRPoSPb6HtwC7Fm0SpvNkShs7OsEbBJKBrp5bY7/VrQB4f5cYeq
         UTH7odGQB+VeOot+o9my47x9F3IQD1Y6t4KTm8Dv+5V/OsrRSLvYFJxkhGrm0r5HCX3l
         9apF4qGZ6+hcWVMiHaVVLo0CySF1vKxgXaLEuV2BWn8LfCOF/wnYThYBvyyTLdVoWdgT
         Jlaw==
X-Gm-Message-State: AFuF++kGpwv+ZRjC1zzfw+lLonnJFIowgcAgL3gy51Hw7mwOeVtxQYfy
	pZPPVZOPhOuqz09pwh0qghrgGaL4555Pz4LPCpGC7C8GHEFvPbZxQYzBn82jvxBv
X-Gm-Gg: AYBFou03zc1FcSUoRRkKUB83J4xE6Wyd4bMaZYkTvkQlXBy8WVTZ90awjWOYfbW5cBJ
	fNA7Wpu4AAJrjN1ZSiJabsYKUtObAuQOUjEMCv5hDzPy7SVQ9Lt4kKJ2WfPWb+6DRPkpKbDnvKk
	psJf8XOzGbFyb0aKCaNNMspZ8xj9THb/5sV9TMF+ZYxr7zIaSDyFhFpUzbk+DE9LDIDRbGTnkCh
	aJg4e/2b4kN2X1B1/LYUyKoWH3ZUORKyKr/F6zVYjeFuALSviYcQPOQc6k6woNkACeZM2DtriHE
	CWr9dyDzUCjewUcTUh+29vn/KYbBGQmvyJxaB3Q3ckei4lIXmD3sLv/JoBUseME5c4/vv7E+pOc
	WubYrzFhyjcgDm9alMAq0/D+pfkvGWRavn3oOo6r6wi1l2FtCf1lCiyQ9SpZLtWWiwUWI2q7Jar
	yc9zlYo7twQyIfUjZGy5C88VLja9n27oOq/TxdjglQDPfq+MG97NTpesfDlq1CZBJdecRaQ7ckn
	9WxYt1BpDl+c3lrfIitO6DdTvspRhMUZuXDoiTjwlqRm+qKmLYgv/2Bsw5OObKKcfc8CO3Dy7iP
	nDeAtJbZXg4NMbYjZeohMl4BQBE=
X-Received: by 2002:a05:6820:1515:b0:6d7:6a64:1787 with SMTP id 006d021491bc7-6e7a58841b3mr4343632eaf.2.1791459553276;
        Thu, 08 Oct 2026 04:39:13 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adcb187c8sm6045154a34.22.2026.10.08.04.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:39:12 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 00/11] ublk: don't dispatch to canceled io commands
Date: Thu,  8 Oct 2026 06:38:56 -0500
Message-ID: <20261008113907.4000838-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Josef reported three ways in which ublk dispatches a request to a
canceled io command, which oopses on the NULL io->cmd in
ublk_queue_cmd() [1]:

1) STOP_DEV, then START_DEV
2) partial FETCH: a task fetches some tags and exits, then another task
   fetches the rest
3) user recovery: one queue's task exits before all queues are ready

This series fixes them in a simpler way, without extra locking in the
I/O path:

- patch 1: a FETCH round which saw a cancel stays canceling until the
  server is gone (2, 3)
- patch 2-3: an io command is marked cancelable before it is published
- patch 4-5: the release resets the FETCH round, also without a disk
  and under ub->mutex
- patch 6: don't warn when the cancel callback finds io->cmd taken by a
  cancel from the control path
- patch 7: STOP_DEV holds a reference on /dev/ublkcN while it cancels,
  so no START_DEV, FETCH or new server can slip in (1)
- patch 8 (Josef): START_DEV and END_USER_RECOVERY refuse to go live
  after an io command was canceled (2, 3)
- patch 9-11: selftests

Tested with all ublk selftests under lockdep; v1 was also tested under
KASAN.

V2:
- add Josef's "ublk: refuse to go live after an io command was
  canceled", so routes 2 and 3 get -EBUSY instead of a live device
  failing every request
- split the cancel callback's WARN change out of the STOP_DEV patch
  (patch 6)
- document in ublk.rst what a server sees after STOP_DEV (Josef)
- kublk: stop a batch thread when PREP_IO_CMDS is aborted, instead of
  asserting and leaving `kublk add` waiting forever (Josef)
- selftest: partial_fetch and recovery expect -EBUSY; add a batch
  STOP_DEV race mode with kublk
- commit log fixes (patch 4, patch 7)
- add Josef's Tested-by

The release work deciding "no disk" before ub->mutex (Josef's point 4)
needs a START_DEV for a server which has already exited: no new server
can open /dev/ublkcN until that work is done, and patch 8 refuses such a
START_DEV with -EBUSY, so it gets no extra patch.

V1: https://lore.kernel.org/linux-block/20261001125422.1364260-1-tom.leiming@gmail.com/

[1] https://lore.kernel.org/linux-block/20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com/

Thanks,
Ming

Josef Bacik (1):
  ublk: refuse to go live after an io command was canceled

Ming Lei (10):
  ublk: keep a canceled FETCH round canceling until the server is gone
  ublk: mark the io command cancelable before publishing it
  ublk: mark the batch fetch command cancelable before linking it
  ublk: reset the FETCH round in release also without a disk
  ublk: reset the FETCH round under ub->mutex
  ublk: allow a NULL io->cmd in the cancel callback
  ublk: let STOP_DEV cancel the server's commands before its release
  selftests: ublk: move the control command helpers into ctrl.c
  selftests: ublk: stop a batch thread when PREP_IO_CMDS fails
  selftests: ublk: add test for going live over canceled io commands

 Documentation/block/ublk.rst                  |  17 +-
 drivers/block/ublk_drv.c                      | 244 ++++-
 tools/testing/selftests/ublk/.gitignore       |   1 +
 tools/testing/selftests/ublk/Makefile         |   6 +-
 tools/testing/selftests/ublk/batch.c          |  13 +-
 tools/testing/selftests/ublk/ctrl.c           | 268 +++++
 tools/testing/selftests/ublk/kublk.c          | 271 -----
 tools/testing/selftests/ublk/kublk.h          |  32 +
 .../testing/selftests/ublk/test_generic_18.sh |  69 ++
 .../selftests/ublk/ublk_cancel_ready.c        | 957 ++++++++++++++++++
 10 files changed, 1550 insertions(+), 328 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/ctrl.c
 create mode 100755 tools/testing/selftests/ublk/test_generic_18.sh
 create mode 100644 tools/testing/selftests/ublk/ublk_cancel_ready.c

-- 
2.55.0

