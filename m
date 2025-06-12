Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD9B1DE2CC;
	Thu, 12 Jun 2025 06:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749708730; cv=none; b=lPLHXz1U3hCuCZ/bouyNL7eDjaQ0gEGO+8rQG3yiAsCPL9toASM8GqM711RsFau2bCZwPtjIt/B5NQZMcMF3q2YoNW33TcF6h91TTYmqwQZhLF6DomSDfPNtObcFuZhWiiftn8OgzEtcLXgwtQg0dzWdPSXaVkuxXVaXTq8DRfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749708730; c=relaxed/simple;
	bh=hgp8ddGIYHXFPm3g8X4vAL9Gn7HJm3ckr03Yw3f2l18=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h2IzWZSS0nZ6BaH1+PWvtwyZzUX8WRT6FakID+nq7m6nvU1nlSI2JsV7f2ghJATc2JT6GjfLoD38hwfV1XtUOAPdSTd/fFYf/l5+a6hIdm7Dc+5RrF+Si9U5a5vuttWJnk/Xe+0Wuupy4Ow8nK0wFQfjEndKG6r+5Mq8/pJtvaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ipd/oNAS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ipd/oNAS"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-73972a54919so605921b3a.3;
        Wed, 11 Jun 2025 23:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749708728; x=1750313528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TQ9qqpLYmxPOpnIwl79iRCmvXfUBKYDUG2VHDIH0aXs=;
        b=Ipd/oNASTlDLIFghVR4spH0AeYI3B3AZW5boKrVKJbHlWtM2wDZqTJ8YyxUBRHRTqv
         XCAdvn0TOuMVNzA7A3xyFXfUiHLgZgRPxBy0plrfbdXT/N70hTICVCRHlwBZWMiRmLkt
         tp/wikMZ6WF3uWIOxTYwHg6A3d1YSrIh0E48a1sdxrd3O2LyuikHBA6cC5eo6h6Uv8/Z
         mdlh4fT+mr6syNXaLgGsuKqPM6DSY9TCvswM6eSPRtXseXoYKvhCBshtUjqkCtTBcKK4
         +GLo4nlPhFR+1ZOh1BuJ7LSiWKK+eceTwOM3AUSm7IZjwZ6Yp3jNJ4YR5qeSN6U+C4B8
         pyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749708728; x=1750313528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQ9qqpLYmxPOpnIwl79iRCmvXfUBKYDUG2VHDIH0aXs=;
        b=X8cIoU1K3CDqH03dVPNwZ+yyhk4v3I5jfcJmujZRmaijxGiEmC7fh7vGuImNGdA+lq
         fuVW43N3VAsBe69qtyI7O82+n0hvBXcUpzzz5ZXJUP+4sBaFM58ZPWt9NTJyb4Oenm17
         DU09yiCjqd30awFI04b12FXOHjq8NS3X/EU8hJWLYVcEm0a1UqnBr8xUYnu38mv09ovV
         7tack14amLyjrSMIeiJ8S4aHBTvfw4zMTg2lNnYtcmXUhVgE02TwMh70nOYmtL3xwBG9
         BW4pP8ognk5iUvaq5aUTNKPBFSpIiwJum1Hkf8QtZ9vrXwMOTKwKdyip/dAXSRmqKTgn
         FcVg==
X-Forwarded-Encrypted: i=1; AJvYcCVHkjol/j1vMp87TnwY1ddXkw0L5KsKVuPgfrKolT3zE6OG/AyuCbgL1HjENYMQZFlQ3X9wELl06K5qRw==@vger.kernel.org, AJvYcCWWWTWrZ/zep6UQHbIBbHnwO0p7cmCLUxqbaSCiPM7mg2EP4CZdBcf5zRFSt56aYSdfmLSeOrAAcrz+xNpuPuvXKmQC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0blw1mUQ7gsjWFlgmtmDpzXIVxj8YsNLUMwSCscSuVo6hOP4Z
	KH+IZnCSPBpj6ZTtcVoct0pUfN/PdbmRp6Ck6zM10GpselqziJ6oRAM7
X-Gm-Gg: ASbGncvUqdTRU1mU9t7cOzp04shK9nrBkJrLmYRh8m+WjpcHXFXrr6NpH0Hsvs3nFCY
	2kvZj/QjNuaPfF2fmh2qGLxYRKZfFcVKb8UxOtaptCCOKm4Ej5sGcTCWESFx9tfz75IZs79Wiwd
	zPmLIoMxEwHejqjf8/FBhU7TmnZmSsbpG5MwUXcBHnbsGVXRevLU9ISVya0mZzRudMfuFjGTMVW
	/hFklkct66cVzVElFK9WiVFPTyV6GIAhs7nXRWbM6m0VlGLSvvZ3uCECOcLvB6rfPVuQUeZxAJt
	Ex/K5Ki28aNpAiJFMVHixpfNF9hEpeTtY9+uk6XIzqsMmDaR0PRIiTxJelMbhq2+aOsWwvqnrkp
	PdpcpW0jri9jOPR6ljJGoLt1Z
X-Google-Smtp-Source: AGHT+IFitfSlNOwC9rOVk5DZWmWQGyxV9pnn4ulbBwucoX5R9+3FLRP3oV+y3rVi1LnHpOV5ir9cwg==
X-Received: by 2002:a05:6a20:7354:b0:218:5954:128c with SMTP id adf61e73a8af0-21f9b8c1179mr2078458637.21.1749708728044;
        Wed, 11 Jun 2025 23:12:08 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.27.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488087a7e8sm631486b3a.25.2025.06.11.23.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 23:12:07 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH v5 0/5] relayfs: misc changes
Date: Thu, 12 Jun 2025 14:11:56 +0800
Message-Id: <20250612061201.34272-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The series mostly focuses on the error counters which helps every user
debug their own kernel module.

---
v5
Link: https://lore.kernel.org/all/20250610004844.66688-1-kerneljasonxing@gmail.com/
1. add Masami's reviewed-by in the first patch
2. fix the wrong printk format specifiers in patch [4/5]

v4
Link: https://lore.kernel.org/all/20250518025734.61479-1-kerneljasonxing@gmail.com/
1. add [1] as the firt/prep/clean-up commit in the series.
2. the rest four patches are not touched, compared to v4.
3. add Masami's reviewed-by tags for last four patches.
[1]: https://lore.kernel.org/all/20250507134225.63248-1-kerneljasonxing@gmail.com/


Jason Xing (5):
  relayfs: abolish prev_padding
  relayfs: support a counter tracking if per-cpu buffers is full
  relayfs: introduce getting relayfs statistics function
  blktrace: use rbuf->stats.full as a drop indicator in relayfs
  relayfs: support a counter tracking if data is too big to write

 drivers/gpu/drm/i915/gt/uc/intel_guc_log.c |  3 +-
 drivers/net/wwan/iosm/iosm_ipc_trace.c     |  3 +-
 drivers/net/wwan/t7xx/t7xx_port_trace.c    |  2 +-
 include/linux/relay.h                      | 24 ++++++--
 kernel/relay.c                             | 66 +++++++++++++++++-----
 kernel/trace/blktrace.c                    | 22 +-------
 6 files changed, 77 insertions(+), 43 deletions(-)

-- 
2.43.5

