Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCE33630AC
	for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 06:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791700564; cv=none; b=d/DK6ndfJBCG4YAXQKkaJOUc3xJxFp2uRJUWH/P6eC+4e6HKe2saZfg/jwh2DWhWzC2hZEIdBg/e8KB1LuS3ZIoDIEiua2UolM031uxFwgcLiJMZwqNXtkw75m7vvNKs+KXCfWjNfQ5RWb1RfC4S0AOFDaXqkxx6sOUtZRLW9aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791700564; c=relaxed/simple;
	bh=1Q4qeWy4qd0cnjFY7nawZJlgtPT2M3Nk+RyDLv9U4YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KYddrQhuQcfkN2oV1uYPse0MmrgzZMLdAp9Lxkm0pH3i5kf1yqKaJRYZ8SS/VvC8fbIbxb9+zQOx/Rku71/ML8lvW7KX8YHrTgLsZ++g8npfMCf/CEtSK0bO+iOKZaMhW/GPskU3Oqc8VGKYpvfBm8DqMsjys0qTRYA0GXrihqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rcdvd4l9; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcdvd4l9"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-82621039b6bso802483a34.1
        for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 23:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791700562; x=1792305362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VzB/xbVrWXPnhzi8fN1n0zSFPqKWlYdtQ0LhgkfR6x4=;
        b=rcdvd4l9xlzP2XD2/Bea/VcrNShmcPOBLa+JJNqr4/S8x4vEy0JKbSbD3MDqTz5F3q
         N8B3SAJX3SyMEPRbJeGljvtliWAzkFpE8zLoOzSlJclFQp3stn58TYI5ghvHjW9n6+O8
         5mmvTwLw6ktVsz/KjC4fd6v3urzKWikSP16eTPvr93vFZnyPV7g923IPpCvM5cDHvWSx
         Lw+m/Jdp4As8zWCCaO5nuNfTQ6x/ASr1ukhHSQiNKbnr3TtuP6Ei8yRINXBMqfA1Ryat
         S3/IAR0EIrgFxX0YBREp1KX5gXCR63uXgLlS0tgir43Ldk5RPgnsfmp02JCY47inJv4z
         1OaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791700562; x=1792305362;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VzB/xbVrWXPnhzi8fN1n0zSFPqKWlYdtQ0LhgkfR6x4=;
        b=hmwGQTAzVrcvcn2AMe+2LGcDewLSI9Cw0LXP1CuKsIzK9/9NJ5atQ2EItlcbnAuWON
         eragO5Rhg0AqKnwnIj5bAIuuVFO115UhI19SDRmH/R4yYWj0W/gV5OLjgGMZ+8EyFW68
         05fovMSq0Z4R9PY+Pn4FQ2c4bUdfDE5KCvshr/+0Z3j+VlqmhtwvCUtlOCgLL+dIpUnh
         mnQkMRDoXFvuY0AG2Fqt8HvfgGH96Eo66lCMox+5HWrkr6x6JUQ4yMGoS12y5tgTicwl
         K/kD233q4wvmjn3cx4Dm0+6iGFsA2918aw6qThK+T4hbESPNxginolnauAZp02UIObCZ
         uK0w==
X-Gm-Message-State: AFq9FYK5xNPMX6FEAgl+8EFGNwra3UuTVRDDZIRat14UuH0+rbW0okYt
	fDnoFWs2SOZms7qKFvtlflwCQBiTB/O3tTx9PJShx3T1uBcM2PRKUAPPck/pOUH4
X-Gm-Gg: AYBFou2ne/kloVXwh9Iy+lcfkpU37/EXmKkLAi+sorLgcMhgWl/oRheYXDM7BSweFyD
	6vdJQkq7h1xk8iJshpwQx/AJ1OknB5dBVJoIJHVDeoDefWrvLTcS7TP7yC8d543KHhbo2/N+EHO
	kvgCU06qFAhS/WwlmFdQG8m9OTtb2lWrbRwPpLG3u7c4wkDM2eOQBY/5EZBnsF4m5TzZfaDyh8n
	yIj1XtO83swZrBG8XkAkZSM4a4jZE1qrVBW1mIbXpxYmQUUHtnchaQj+yzDvPN1ssSYkk/9Bcnj
	gEy+kCXAr2LFKDpRLI6NYsRapytgQr+egOCRM9x3x6/A7wylAUvzhCl1BiuCv2JIb8XRsR9prGK
	8687LbIJrLcscrcUAepVsZBN6SSsP9V1ikLqFjf5RspAnhSknutokjNjYvDqlm4qWHvrtjUcDFZ
	udOlOnhpI+MwjjW+ERHPgCbvK9O9WoqF2cqDBoreMQfvtyAzIU52tjfIT9tDfVQIAdP6/1fINmG
	z0+0GfSIjAbwrH4UWe94+/NYWWQTnnb+aLTenkCfJt3gdwXjS7rg9iPnActnenUQh4WeIZ+bBFX
	CGS8rzCEnyZnExXYJAIZG+nZk0U=
X-Received: by 2002:a05:6820:151b:b0:6dd:c5d0:4e51 with SMTP id 006d021491bc7-6ef0d22d2d3mr4723619eaf.24.1791700562138;
        Sat, 10 Oct 2026 23:36:02 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a515aa9sm6593164a34.25.2026.10.10.23.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:36:01 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v3 00/12] ublk: don't dispatch to canceled io commands
Date: Sun, 11 Oct 2026 01:35:43 -0500
Message-ID: <20261011063555.1142277-1-tom.leiming@gmail.com>
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
- patch 12 (Li RongQing): ublk_report_zones() passes a per-chunk index
  to disk_report_zone(); use the index in the whole report

Tested with all ublk selftests under lockdep on for-7.4/block; v1 was
also tested under KASAN.

V3:
- rebase on for-7.4/block
- add Li RongQing's "ublk: use global index for reported zones"
  (patch 12)

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

V2: https://lore.kernel.org/linux-block/20261008113907.4000838-1-tom.leiming@gmail.com/
V1: https://lore.kernel.org/linux-block/20261001125422.1364260-1-tom.leiming@gmail.com/

[1] https://lore.kernel.org/linux-block/20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com/

Thanks,
Ming

Josef Bacik (1):
  ublk: refuse to go live after an io command was canceled

Li RongQing (1):
  ublk: use global index for reported zones

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
 drivers/block/ublk_drv.c                      | 246 ++++-
 tools/testing/selftests/ublk/.gitignore       |   1 +
 tools/testing/selftests/ublk/Makefile         |   6 +-
 tools/testing/selftests/ublk/batch.c          |  13 +-
 tools/testing/selftests/ublk/ctrl.c           | 268 +++++
 tools/testing/selftests/ublk/kublk.c          | 271 -----
 tools/testing/selftests/ublk/kublk.h          |  32 +
 .../testing/selftests/ublk/test_generic_18.sh |  69 ++
 .../selftests/ublk/ublk_cancel_ready.c        | 957 ++++++++++++++++++
 10 files changed, 1551 insertions(+), 329 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/ctrl.c
 create mode 100755 tools/testing/selftests/ublk/test_generic_18.sh
 create mode 100644 tools/testing/selftests/ublk/ublk_cancel_ready.c


base-commit: 69ae59173a5668d015ab2733c8628ed542f00ccc
-- 
2.55.0

