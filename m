Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10654D0CD1
	for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651600; cv=none; b=XGbF25N9lVNbIUcSHifLm9VeytDeW3nRC6Eof7U23ZQmvPJaFbFNT3juKwrr/cRZ86GDMuSARK5O6pbovJnMrIurlUKJ9WkwRIHoVHxxvd3I6kh3ArmI3ft43GpSyk46PoOcZc+2xd7yw1FlIurPEk1myguuQz+bQwBxR4a+Hco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651600; c=relaxed/simple;
	bh=j9N1F68A+nbLgU/fzy1bw73Kajt5DcRURg/vv1A5UtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NZQJxzg0i/zxJSy3HVZCUB1X4/LfaUZn5WQt88IV2WKXmx+plPe0nORw27sVvzTVL0PfqBgtayxcGtbT3FvvoJMALG4UUJ50ozRk2JzM2bVvqDBQtwdHOJLnhTYVoAP4dvrUjx2MRR8Sr0GGoDxkMGwGzST2jRQ3rGbELwYDwUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=ot84PXGb; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="ot84PXGb"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48439feca17so709888f8f.1
        for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1789651595; x=1790256395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FTWU3z7oT+AmhRKIBpIuUxW3EDym90iXyKLvYlGNFT4=;
        b=ot84PXGbGERRNYmGqx8gP9RP9W94E9HW7SL5axmELPDA/r/NaR6tHWfdg/I1Hfj746
         T5dhFmF8pLP0tKQERVtuDVAaS1fQUpDYzGc06AcCb7yZ8BTXxXGjjAxrJD01Gmy/Q3fZ
         BqKpAOS2QZLnBkVoeZtrsVRdoEsDliTdLtc4QralDY9YYDuxV+euPG8L0pCVfaO48rUj
         VM/sO2BHO6n2oBnWDSDFjo8mlDddfRTiVBCMRrAiNHQKjd+dl+SCz5JgEahz10vchm3y
         rdbMvMUlJ4atgMUhv6P0X9BZu88AsnYzvSDkkNO2VpmBeCnnEPNz2KA/ftN5Ybzlw8Qd
         Zliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789651595; x=1790256395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FTWU3z7oT+AmhRKIBpIuUxW3EDym90iXyKLvYlGNFT4=;
        b=VUt97K6mrAd5WZoB3IuzEG/Pq4XIBNQjI+fLKshg1hIXFlTNMnvZ0+KiKWTXdzZI5K
         tPn7cYIABsMmeE2OYoCecjMKWi2hcRvMrbRYTTHU2Lg5wy6tzo/1ppzq/Noc7YRda/w1
         yEyLCImxapG+LffNFibHidmmj6Nsx5IdhbqDP4wfxtug2qOzvXwLThWONirzGOB/iAQd
         hy5454jRJXfqvNmJWdsNJFHFjEYeSIMXW2Q05tyst6n7MEFd+WLeVS351mhzEZaTVfwn
         ujhvmsnFdEmV3x9nON4p0eReSZHnSquTCxERDJGmj+5MblBFuL17w8gywzLXs6rNpoHX
         9Qhg==
X-Forwarded-Encrypted: i=1; AKwUvBzEgbsraaxMDQdKQUNONes0P+dHjL0RK6JnmUzBfFtbnvOr1X7m5LHzdY5QZhcRAk3IQczN4IIeJ3CFLw==@vger.kernel.org
X-Gm-Message-State: AFuF++mlOt6y2FHdBOWreGrzMifZzsRTE2tHjtPMTGErxXFTDLFMS/pw
	ahnigwlGndkcxftbepNvFd7K4kNP9qakTf7dylo/m/kNZLRWdacD7XOR1wxVcUbaJA==
X-Gm-Gg: AYBFou1jJerdnIEr/vyco/vsqT8Nq0jiCTYiYLkRT5pXrQR6Yyzb0pnrN+49Qq6AvMO
	iXYKCAhhK0GJ278M2mlMWbg32v6UU152VybglZ/XVHXgQkuTH5csamfyuKGqSo0DW79AacwXNi8
	dxXTKnrtiLz34jXL1uh2loK95aZakt5t52vzPYVRpIzD1xJpJ7/o7mxNKaKfzFZCGEYm6bzbcDp
	EsmXaKyPNNKjP4Bj01j43d5I50UVwNSqRcf85Xpf4LAQiE5yo9adrityPx5pOqqs1nNQxVfARlD
	p9MtjRq8qGzGYQCOGQcHhyXtFqzp3gS6InXc78VhseZc1rsyUAlz5dobxjdu3eEQ6tjVQGgZGeF
	b8NBawl4f/WENUODmN1hgAaE5HJyF/xlQ/+ywyAZu73nhgpLiKZKGnVCQLo11HUE36g/WtpsAl7
	AsuLP3CDC1sy3/YWcsDIv8RQaIF2U9kjNHclcz4Ox5293pT7DD60OYK2FRTfF3UNTf+JxheWuQ1
	8cebtdkA3/NGueHOY2Y1K3el0Q=
X-Received: by 2002:a05:6000:4697:b0:486:e6cf:96e7 with SMTP id ffacd0b85a97d-4870d067865mr6063193f8f.37.1789651594673;
        Thu, 17 Sep 2026 06:26:34 -0700 (PDT)
Received: from fighter ([216.128.28.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1f6cfsm15879947f8f.13.2026.09.17.06.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:26:34 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sean Rhodes <sean@starlabs.systems>,
	Evan Green <evgreen@chromium.org>,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Xueqin Luo <luoxueqin@kylinos.cn>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Subject: [PATCH v3 0/4] PM: hibernate: encrypted snapshots under lockdown
Date: Thu, 17 Sep 2026 14:26:27 +0100
Message-ID: <cover.1789651581.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PM: hibernate: encrypted snapshots under lockdown

This is v3 of the encrypted userspace hibernation series. It protects
userspace-driven hibernation images against modification before resume,
including when the kernel is locked down.

The kernel encrypts and authenticates snapshot data and wraps the randomly
generated image key using a seed supplied by trusted early userspace. TPM
policy remains outside the kernel PM code: early userspace is responsible for
unsealing the seed under the intended PCR policy and writing it to the
write-only snapshot_seed interface. The series therefore provides the kernel
mechanism needed by a TPM-backed design; it does not itself configure or
enforce TPM policy.

The kernel accepts the first valid seed written after boot and does not
authenticate its writer or enforce image freshness. Trusted early userspace
must provision the seed before untrusted privileged code can run and must
provide the required TPM policy, rollback protection and recovery handling.

Patch 2 confines direct block-device write() calls to the active swap backend
to the process which owns the encrypted snapshot, its allocated swap extents,
the recorded swap-header page and the number of pages allocated through the
snapshot API. The userspace writer must use synchronous buffered I/O.

On a StarFighter MTL with Secure Boot disabled and integrity lockdown selected
manually, the encrypted userspace snapshot path completed full S4 and resume
cycles both without and with an additional user key. In each case the original
process and boot ID resumed and the swap header was restored. Corrupted wrapped
data, invalid wrapped-data magic, a corrupted complete-chunk authentication
tag and an incorrect user key were rejected.

The late user-key transition exercised by those tests is retained. This
revision also validates that a userspace-supplied encrypted metadata boundary
matches the authenticated image header; that mismatch rejection has not been
exercised on hardware. The encrypted S4 paths were tested on the prior
candidate; the revised allocated-page accounting and active-backend handling
have not been rerun on hardware.

The deliberately corrupted complete on-disk image case was not run because
the test system did not have a reviewed pre-root recovery mechanism for
restoring its swap header.

Previous version:
https://lore.kernel.org/all/cover.1785838445.git.sean@starlabs.systems/

Changes in v3:
- Rebase on current upstream master.
- Complete both keyless and user-key hardware S4/resume cycles.
- Exercise rejection of corrupted wrapped data, invalid blob magic, a
  corrupted complete-chunk tag and an incorrect user key.
- Preserve and validate the saved encrypted metadata boundary on resume.
- Drain buffered metadata before a late user-key transition.
- Reserve enough encrypted image space if userspace adds a user key after
  querying the image size.
- Apply swap-write confinement before enabling the lockdown exception, while
  preserving the ordinary availability check which routes lockdown writes to
  the confined path.
- Account the pages actually allocated through the snapshot API instead of
  assuming a userspace swap-map format.
- Document the first-writer, anti-replay and userspace I/O requirements.
- Remove an unused swap reverse-mapping helper and tighten local naming.

Changes in v2:
- Keep raw writes to active swap blocked under lockdown.
- Track encrypted snapshot bytes and header writes before allowing
  lockdown-time image writes.
- Split the encrypted stream at the metadata boundary only when a user-key
  transition is used.
- Return -EFAULT for userspace copy failures.
- Document resume meta_size handling.

Evan Green (1):
  PM: hibernate: add seed-wrapped encrypted snapshots

Sean Rhodes (3):
  PM: hibernate: confine encrypted snapshot writes
  PM: hibernate: permit encrypted snapshot device under lockdown
  PM: hibernate: document encrypted snapshot seed ABI

 Documentation/ABI/testing/sysfs-power   |  18 +
 Documentation/power/userland-swsusp.rst |  33 +
 block/fops.c                            |  58 +-
 include/linux/suspend.h                 |  24 +
 include/linux/swap.h                    |   9 +
 include/uapi/linux/suspend_ioctls.h     |  31 +-
 kernel/power/Kconfig                    |  15 +
 kernel/power/Makefile                   |   1 +
 kernel/power/hibernate.c                |  32 +
 kernel/power/power.h                    |   3 +
 kernel/power/snapenc.c                  | 952 ++++++++++++++++++++++++
 kernel/power/snapshot.c                 |   5 +
 kernel/power/swap.c                     |  87 +++
 kernel/power/user.c                     | 272 ++++++-
 kernel/power/user.h                     | 150 ++++
 mm/swapfile.c                           |  25 +
 16 files changed, 1683 insertions(+), 32 deletions(-)
 create mode 100644 kernel/power/snapenc.c
 create mode 100644 kernel/power/user.h

