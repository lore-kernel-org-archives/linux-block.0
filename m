Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550565;
	b=deqGUZDlkWl4cjeNqKaELkgAVdTlW2dW7j3Vzt/HN8NPelh6InvuiaAWhQWluumk/Cb1
	 Y9VYjGtYtO/UKqYVf41hrTaFpV4lViPzmsir7xhy9T4ntoFQ9dJACiRMkUquiek8qh3Ck
	 3niGYbgzV3iGm7KVtzapBCrGcPRlBfuv9BsdOH7Or9OUZhdJjZLlBtWJ3XoJAQiQvtnyQ
	 UleZ+pie0Vg8HDSSKa+ZevznzHlbpdpFOG6yqrN1aJCZRzaqtV5w4vRHDuRWNq4evt9AH
	 WghF4eZMtfID49CbhtJr+ofAVjwQ/Qn5qfGtlhzi4yHOY2D47lurlSIYwlXqKowwlWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1qRBobvsLUCIbGsbEwiV9kaRSV7ZvIaGMjGH4r35+uk=;
	b=fCuGT/+lIu6E6VS4diKlDKr/JnfjT0EwBxsjPS14Lp827DLUlEawugSBBiFqe/Rm8taT
	 1jBuYp1GdUbisdJSh5TFSdWIq9G975l3vPTyl4eO733/gajycGnnvoQdKG9pTVZLytgpG
	 kkqbmjHcyMhEZUZfuRt+swQyFW1+3RkjC4Z9ciTt/XgX1U74FMqust9eHKUoE5O4s1Jca
	 1t//3W9kUpRFj1WPPlLGwRMuFfb9SYsfPpltsmQxPiB7Gc38adz+5/H3SvIeiEF5Xpuqh
	 DPRRnADQ5V6CRl2U0oa80RSICphHhNU+jGTlFfbyPrzE2wd3JBweZLAWszc621fPT3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lF2SU6RU;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0E8606A31C
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 02:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD0E8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lF2SU6RU
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15354aa70e8so777736c88.1
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 19:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792550564; x=1793155364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1qRBobvsLUCIbGsbEwiV9kaRSV7ZvIaGMjGH4r35+uk=;
        b=lF2SU6RUDeIN/zII/sLfo9V9Ft4emmbvAofzcFB0yvHttYqlxXaVii9pZXix90BC6u
         zLsruxoFsjiQF1o4VZAizSXAch6QwIx+4fTPhTTa2IyZwgZha8adZsz1m1wkl7/ujpzC
         KMqEusvEwG2rTFi+2Ar+HKVchepRk83WH5lRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550564; x=1793155364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1qRBobvsLUCIbGsbEwiV9kaRSV7ZvIaGMjGH4r35+uk=;
        b=g67iA9N0eYQTMWxrU8VAJW6n7ltVJsHnfQWN5UrfZy1qUuTNSneVEOuMQZNrYahJkd
         B8Z1hwDkYwkLpXetvmMo5pfj7VWuQIfaAHTqCXIsYndxxKxEppY4zxzSAmvUcZirabi4
         mbM3MfTO1g0cNmnwev06BcP+Y68sjeYqgCveOZw96kLQKtItzwSPh8qYPWrvVwzZ3fXn
         4JWAPcu08dOx5Fve1TtGZGj7btCf1lm6CrXPG8uBY6+HUjZPO63L4xSChdF+q/UVJ5NV
         InYt5LknNC+4gAvzLZC25pSJMEsqig95oMyXUYYEhd0pIebHDBviqq9Jr7NZ3EuGbCMN
         r8SQ==
X-Forwarded-Encrypted: i=1; AKwUvBxAvNy0JmT9oywaChYu8OGW4fwAC0Pa1CRctpCNupS5qA4Y8t7XQlb5yIjCNlH19mohFNWcjSIZwyzN7A==@vger.kernel.org
X-Gm-Message-State: AFq9FYKCIAoH443XVk+lzHQHTAxEOOBbBxPL8cZSUul9lb0bZcRxYiMf
	Qs69eGeYtWkRls470zVyvbo3e925VhHgHY0EaL+zi21g0e8qX2IZam47qdYv5HCQtA==
X-Gm-Gg: AYBFou1Iju0m1vtjep9cBRHus+7F0r/Svvg1juWgS912AaKuk7n88eJs3kbA22iVSWL
	dtYVK/GuDrMGJ3epM/sBv5G1Wm2jSOQsV6HhmLKc1wlLtUOs/tRiHnE1P93Hcmm38cNfyHlmAiO
	fbS7F4P75u3YX+bEAgaGUVX17xaeWIWldbcUnn5OIkrlJ8HABzZ0X0cQV3WdTSPPqRLOyp54t76
	4g9IAFdvZDROwhcxyLaR58cC6UFo1lBJhZ1C8bE4O5QsBWSe70Z71QG5HhPQsHllUWEKjKMP+yO
	Fv/qlOWL96SBueXWfyE7F1SUuKkEhrxJbB/0iQM3HZHJ6Z04nNvKh62D/f5OKR+khqWRowmmi0r
	ZKMLjh3FbxhCWbIiNVD7idjmip/HjAcQwSatzsWUQHMczEu7SL1MoiNDlsaw85/g/FTcYdEOpsb
	tNruoTVAeWEz+Jccxqk3yErmJkxBi0OLLVpMXes9pIV3pPOPNixedMFHOAeDrLiDhOOu8UCwkga
	7A5hMA82K7mYpSl1cmqLNWZZYPwCSORgfhA1QLghyj47m4qY7QinZLN+fUI4lF0Whb2oytsvF+O
	8oCNih52F+yt7+LE8VQ6sGnCJncJZ5Q6UJKQtRyCXMAX
X-Received: by 2002:a05:701a:c90a:b0:152:92c6:8b58 with SMTP id a92af1059eb24-190a6adaa1emr781617c88.35.1792550563732;
        Tue, 20 Oct 2026 19:42:43 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:97d1:a8be:236d:bf79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035c0c9a6sm2392047c88.3.2026.10.20.19.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:42:43 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Barry Song <baohua@kernel.org>,
	Bo Zhang <zhangbo0325@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 00/13] zram: redesign zcomp and rework backends
Date: Wed, 21 Oct 2026 11:42:10 +0900
Message-ID: <20261021024236.1787884-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series has a number of memory usage optimisations and fixes
that result in savings from double digits KB to triple digits
KB per-context/per-CPU, depending on backend and its configuration.
More details are in the corresponding commit messages.

The zcomp redesign and backend rework happen in the final three
patches.  zcomp part, basically, attempts to address the priority
inversion problem, that is seen on some setups.  In zcomp, we have
always kept Read and Write contexts together in per-CPU streams.
With preemptible zram this becomes a bit of a problem, as a higher
priority Reader can preempt a Writer, which may hold a stream
lock, but since the compression stream is locked by the preempted
Writer, the Reader gets blocked on the very same stream lock.
However, we don't have any reasons to have Read and Write contexts
share and compete for the stream, because Read (decompression) and
Write (compression) paths are completely independent, they never
touch each other's buffers.  Thus, we can split compression streams
into per-CPU Read streams and per-CPU Write streams (Barry Song),
so that Readers and Writers don't block each other anymore.
Decoupling Reads and Writes results in noticeable performance
improvements on synthetic tests.  The Reader vs Reader priority
inversion is still possible.  To attack this problem we introduce
shared decompression stream (Brian Geffon) which can be used when
decompression is stateless.  There, however, stateful backends (zstd,
deflate) that cannot have shared decompression contexts.  For those
backends, we introduce a remote CPU borrowing of idle exclusive
decompression contexts, if an exclusive Reader get preempted on
current CPU.  We also now allocate a per-request (Read) bounce
buffer for linearisation of spanning zsmalloc objects, so stateless
decompression contexts do not block each other.

Reader vs Reader priority inversion tests:

  exclusive zstd (fg reader, average of 3 runs):
  Metric           Base               Patched
  ----------------------------------------------------------
  Read IOPS        391k               1,064k        (+2.7x)
  Read clat avg    49.07 us           9.68 us       (-5.1x)
  Read clat stdev  7,179.16 us        30.64 us      (-234x)
  Read clat max    3,208,867 us       5,880.87 us   (-546x)

  shared lz4 (fg reader, average of 3 runs):
  Metric           Base               Patched
  ----------------------------------------------------------
  Read IOPS        972k               1,466k        (+50.9%)
  Read clat avg    11.56 us           3.29 us       (-3.5x)
  Read clat stdev  2,738.84 us        16.57 us      (-165x)
  Read clat max    2,204,467 us       6,442.50 us   (-342x)

Writer vs Reader priority inversion tests:

  lz4 (fg reader, average of 3 runs):
  Metric           Base               Patched
  ----------------------------------------------------------
  Read IOPS        642k               1,472k        (+2.3x)
  Read clat avg    23.97 us           3.28 us       (-7.3x)
  Read clat stdev  4,303.64 us        14.85 us      (-290x)
  Read clat max    2,393,767 us       5,710.53 us   (-419x)

The final patch builds atop of decoupled Read and Write streams and
reworks the way secondary streams are handled.  Secondary compression
streams are only used from recompression, which is serialized by
device lock, IOW it's single-threaded.  However, we still allocated
secondary streams per-CPU (we needed to permit concurrent Reads
of recompressed objects).  Because we now have dedicated R/W
streams, we can allocate a singleton compression context (for
recompression) yet still have per-CPU decompression contexts.
This saves a notable amount of memory with some backends and
configurations (e.g. zstd, deflate, lz4hc).

v5 -> v6:
- fixed for_each_online_cpu_wrap() argument evaluation bug (Sashiko)
- moved the "reset writeback state" patch up
- updates some commit messages

Sergey Senozhatsky (13):
  zram: prefix backends printk-s
  zram: remove debugfs entry on init failure
  zram: reset writeback state in zram_reset_device()
  zram: zstd: do not allocate empty C/D-dictionaries
  zram: lz4hc: pre-initialize dictionary stream in setup_params
  zram: lz4: use LZ4_decompress_safe_usingDict()
  zram: lz4hc: use LZ4_decompress_safe_usingDict()
  zram: zstd: do not use kvzalloc() for zstd allocations
  zram: split zcomp into separate R/W streams
  zram: introduce shared decompression streams
  zram: allocate bounce buffer for spanning objects
  zram: borrow idle decompression streams in exclusive mode
  zram: use a singleton compression context for recompression

 drivers/block/zram/backend_842.c     |   6 +-
 drivers/block/zram/backend_deflate.c |  98 +++++----
 drivers/block/zram/backend_lz4.c     |  85 ++------
 drivers/block/zram/backend_lz4hc.c   | 105 ++++------
 drivers/block/zram/backend_lzo.c     |   6 +-
 drivers/block/zram/backend_lzorle.c  |   6 +-
 drivers/block/zram/backend_zstd.c    | 133 +++++++-----
 drivers/block/zram/zcomp.c           | 298 +++++++++++++++++++++++----
 drivers/block/zram/zcomp.h           |  53 ++++-
 drivers/block/zram/zram_drv.c        |  55 +++--
 10 files changed, 542 insertions(+), 303 deletions(-)

--
2.56.0.212.g129ede20d9-goog

