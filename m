Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4368A3DDDBC
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776802154; cv=none; b=f9ZG4D+c461lupLddm6D+dY5zEaS4LO4XOQtCkSqHk2IDnIExxRnu3Vr0i7AazGf/P/OlYYOSEzTloINJbjypfixIpEoiSjYzIegGQtJVRGE0r8IbfNSiWsMlS6sgdZvWbpz55aOfv+ic9Q1/+pkXv7w7njEHLNVkSVO2dMg5dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776802154; c=relaxed/simple;
	bh=I84hhzCB7BlZbfybuMejt9oRBi1g5/XrghmhSook/ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fqef5mda5GiD+dc1Edhi6SR14zkB7Jl5SCaFA1WAaZxPSLyRWDJgff3xoYf1YjAE2iw2ZgTB/VN04N7beUrxRUkdNmRm8a3s7bDi59s/f8F+FRIdWQ3ZW62Cuf+yz39yidccA+SRzFrpIocmBpRJxn19wNzICRBh5jOSZ5VgMWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=guWuGW4y; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="guWuGW4y"
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-42c0b8878aaso236957fac.0
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 13:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776802145; x=1777406945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yGFnkXYasLnwRZMKRjucMuAGGbIPRmvJkBqEc/Wzb04=;
        b=guWuGW4y4q1HidR+vJzl3U4zXxe4vr4J5mSeDCMz6cI7gOU4vBh6P1Hpm63PdJEgKH
         y+isMiihBRZgbd5bTvNyTRCPRbP24UUipC1xSsMZbqu/5Wn016KK3LbHKtJQrl52h3Hu
         6OppVImQ9SxFeDL2XhSbUTFlJux3xRXu12oY65B5g2p/0XkWy4Img/zbfCdzlL0U7/3y
         0O1nacaCisUYOgna7cWCpTm9MK0xouPSfLpcs592UKFioPWUPouneE4ws8PbS32a6V4C
         LVn21G6SJoVLOgC0WXKcKXP2jEWK9apKClNCv0vDm4J7MOBJSLIIT2v3EirwwLC4paRJ
         VPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776802145; x=1777406945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGFnkXYasLnwRZMKRjucMuAGGbIPRmvJkBqEc/Wzb04=;
        b=ngZoxLM8xZLugY97eRPGylR8xTvUm+4YTvLC+wIfhKs+KWoTL/J/sAz/+6V0Gk+anN
         D025dmS/Nqy3R+AE8Oc5W175VSCLDOgiEacFY94D7l7DJklMBPJNKM2ZFaCjW6oFclqF
         FwmvVy3v0n9wyQgELfuSiXMe47bHZ6dj4GlMhgNKdGyz4sHIhcLPl1snw5vwq/35vyMs
         GDtAajG9ChJhj/k/5I/xE8M9ZwUP/uwhK3PMug8xW3mZJXphaWPEb3noacmRHx09bJnK
         Y66L51PirATYC1mxoaMlJn85HpHieE2Rlsu2qKca+7rKlAQZqfFVzRdCjX/fT/idS8VQ
         /A/g==
X-Forwarded-Encrypted: i=1; AFNElJ8Cn6L/k4k50sX8xXHOLlDFx0LtJSgUz9I5h8FllwMyp5l6Eh9Uw+rZHXC+0mmnXROjhUNYzUgD0mU/qw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY2mDx+pplbHAsvW4UfVBpu7TphG20VLIlBKySo1IyMm51ocw9
	1vLOmE6r/W4VQhyi3viyrMYPT3r+iuz840isYdT3n/OyocPh+4bd4fw+l63Mf4i86yjy3Tke59W
	HuSVmPH3YAqVTH4Fdsdq9IB7xN5TtB4Sy3s90
X-Gm-Gg: AeBDieumlp1jZA6sXCYnvRV6eEzAUtZwrjYglaXRCbicAUY+dM6Smdsekt14Wciy1hu
	IUcnYaNMK9dnBVgFeqMe6S6G4dOdKp3HEo5MDEaDXCc1Weqz4wA3RpA5dPNXqb1CDursC39GuEs
	RyToe4gsYqnuwHp6A5tKMIYRrfPtDzyTQew0VBZoMqJ9UDRe3EMiXQbfPtotjVysSfWJzogpmvX
	RiOiTgCCFypxSdELqkUYUIXWYf37jsrjoK2rh6KMjASsNGonHioz5aoo+fNpT/ix0wA2T2HeFLP
	3H5+T14gM1Tb6tKJGm0+vZKi3vCIYFOv3M0fqxKC+iYfYbox8Fg392Ob+Yn2ytGNvC2QQNfREAa
	kw9AJxlNjFa7oFC453866uXZ8XaHNn6EiSwJLceiXDBK+2bG8fJRvKRWZGIs/rbWt
X-Received: by 2002:a05:6830:921:b0:7dc:d8ab:49c0 with SMTP id 46e09a7af769-7dcd8ab4bc3mr1748317a34.3.1776802145405;
        Tue, 21 Apr 2026 13:09:05 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-69464e60a0fsm692757eaf.10.2026.04.21.13.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:09:05 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 08233340576;
	Tue, 21 Apr 2026 14:09:05 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id EC90DE41A9F; Tue, 21 Apr 2026 14:09:04 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/3] selftests: ublk: integrity test cleanups
Date: Tue, 21 Apr 2026 14:08:58 -0600
Message-ID: <20260421200901.1528842-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update test_integrity_02 to allow fio-3.42 now that it's been released.
Add a modified version test_integrity_03 that uses auto integrity and
avoids the newer fio requirement.

Also clean up the callers of _cleanup passing an unnecessary argument.

Caleb Sander Mateos (3):
  selftests: ublk: remove unused argument to _cleanup
  selftests: ublk: enable test_integrity_02.sh on fio 3.42
  selftests: ublk: add ublk auto integrity test

 tools/testing/selftests/ublk/Makefile         |   1 +
 tools/testing/selftests/ublk/test_batch_01.sh |   4 +-
 tools/testing/selftests/ublk/test_batch_02.sh |   2 +-
 tools/testing/selftests/ublk/test_batch_03.sh |   2 +-
 .../testing/selftests/ublk/test_generic_02.sh |   4 +-
 .../testing/selftests/ublk/test_generic_03.sh |   2 +-
 .../testing/selftests/ublk/test_generic_06.sh |   2 +-
 .../testing/selftests/ublk/test_generic_07.sh |   2 +-
 .../testing/selftests/ublk/test_generic_08.sh |   4 +-
 .../testing/selftests/ublk/test_generic_09.sh |   2 +-
 .../testing/selftests/ublk/test_generic_10.sh |   2 +-
 .../testing/selftests/ublk/test_generic_12.sh |   4 +-
 .../testing/selftests/ublk/test_generic_13.sh |   2 +-
 .../testing/selftests/ublk/test_generic_16.sh |   4 +-
 .../testing/selftests/ublk/test_generic_17.sh |   2 +-
 .../selftests/ublk/test_integrity_02.sh       |   5 +-
 .../selftests/ublk/test_integrity_03.sh       | 103 ++++++++++++++++++
 tools/testing/selftests/ublk/test_loop_01.sh  |   2 +-
 tools/testing/selftests/ublk/test_loop_02.sh  |   2 +-
 tools/testing/selftests/ublk/test_loop_03.sh  |   2 +-
 tools/testing/selftests/ublk/test_loop_04.sh  |   2 +-
 tools/testing/selftests/ublk/test_loop_05.sh  |   2 +-
 tools/testing/selftests/ublk/test_loop_06.sh  |   2 +-
 tools/testing/selftests/ublk/test_loop_07.sh  |   2 +-
 tools/testing/selftests/ublk/test_null_01.sh  |   2 +-
 tools/testing/selftests/ublk/test_null_02.sh  |   2 +-
 tools/testing/selftests/ublk/test_null_03.sh  |   2 +-
 tools/testing/selftests/ublk/test_part_01.sh  |   4 +-
 tools/testing/selftests/ublk/test_part_02.sh  |   2 +-
 .../testing/selftests/ublk/test_recover_01.sh |   2 +-
 .../testing/selftests/ublk/test_recover_02.sh |   2 +-
 .../testing/selftests/ublk/test_recover_03.sh |   2 +-
 .../testing/selftests/ublk/test_recover_04.sh |   2 +-
 .../testing/selftests/ublk/test_shmemzc_01.sh |   2 +-
 .../testing/selftests/ublk/test_shmemzc_02.sh |   2 +-
 .../testing/selftests/ublk/test_shmemzc_03.sh |   2 +-
 .../testing/selftests/ublk/test_shmemzc_04.sh |   2 +-
 .../testing/selftests/ublk/test_stress_01.sh  |   2 +-
 .../testing/selftests/ublk/test_stress_02.sh  |   2 +-
 .../testing/selftests/ublk/test_stress_03.sh  |   2 +-
 .../testing/selftests/ublk/test_stress_04.sh  |   2 +-
 .../testing/selftests/ublk/test_stress_05.sh  |   2 +-
 .../testing/selftests/ublk/test_stress_06.sh  |   2 +-
 .../testing/selftests/ublk/test_stress_07.sh  |   2 +-
 .../testing/selftests/ublk/test_stress_08.sh  |   2 +-
 .../testing/selftests/ublk/test_stress_09.sh  |   2 +-
 .../testing/selftests/ublk/test_stripe_01.sh  |   2 +-
 .../testing/selftests/ublk/test_stripe_02.sh  |   2 +-
 .../testing/selftests/ublk/test_stripe_03.sh  |   2 +-
 .../testing/selftests/ublk/test_stripe_04.sh  |   2 +-
 .../testing/selftests/ublk/test_stripe_05.sh  |   2 +-
 .../testing/selftests/ublk/test_stripe_06.sh  |   2 +-
 52 files changed, 162 insertions(+), 57 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_integrity_03.sh

-- 
2.45.2

