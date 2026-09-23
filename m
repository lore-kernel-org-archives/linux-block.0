Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A45383ED
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172405; cv=none; b=EIGR8kXlWltjDmJ6YEHOxZJtzsdnl5Kzm0hWR466OOJ2zKcYVfGlm2nBHw9sPUKH+Mm99AAgcxB1e/F9kHrrddzHoC7owj+yE7g14H3I9HlecMor+DUxEJEpGXr6u5T86Ru9Aqtd7Uu4+5JD7SW5QKoN8wuMGFbfN/HWrOJDm9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172405; c=relaxed/simple;
	bh=7u/4OZ1/l/ZMeEzMXgKr3J6dGgbI5M81i34WvI+iInE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jvBm/+3sLeSuFVRXOOXPiKwewWceY4sJVy2gG1WssFPUuNx1Dz5zZFLFLyLSTIxWKGgng7dQU+ZjD+N8Iz4vdcW35lL6kRVd4jrHJB6vJsEGEroXpYLlbHIa3uoh+fDS+Kw4/5IUEntGvKLj2leerXzaBxZID0Zc1G2HxV+JyLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=coS0Tmg2; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="coS0Tmg2"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso7620895e9.3
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1790172401; x=1790777201; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aPV2CdE/Dht4I+/gbqIepOjn1d13cJdz8dQIBlNjv9g=;
        b=coS0Tmg2ocMg9PfUnAceDPm3ZsMcgHIOsFCftSPuF9UVUwoCVvFVNFDy5GDGLlmPfK
         Jh5EzA2xCqvEr9NCVk6pg3QanMEZkU+aOvOFUra2IYGkxV4jxq7t2GyKjPCiAlzVZWzl
         PjCq7HATdWrHCWYi5/D44zpnP2gFMj2ScdLnHCZqRqekMwNLAMmiUdfimjXOoPV/QOYG
         3BDcnNvHCgYUf+esu1KVkzdEprjDVsw3EzFL6z3N4bNxTu4/oasJT3eLmFbwqU0h4n22
         nZxcwJiwLa6ImcHloQyfX2/RGrODDSvmqC3kYX1eFy7UiPkcp5Rji/E86K2Jlzq+C+f7
         FoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172401; x=1790777201;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aPV2CdE/Dht4I+/gbqIepOjn1d13cJdz8dQIBlNjv9g=;
        b=Eiz7RjNhpwkLdZNwYbFo8wh3lxb5F8dLkcKogdVV1i8g0h+IImONDBojC+gPdmM700
         osTEkHyfUXRQh5KUhqWighUy0XhvtCpXwIU/sg9rwLjJHiGiA5In5C3yD85tWXuWoXOn
         /LtEZorxZeyvRzSMpKFFGo1Ny3lyk95dA6igejuUP/jrmSjm9IoFLDstaB0CBAuG1sQu
         BeqB0q7b3wsNVrK2jgMSnugUlAwQ/QILXjEZwubIk/99lNyxvsReWeYZlIo5haff5HKs
         lc7EUMuD0rJC76jRO6741QSH7E74uHrkeWzmnkptg2V5mXtF1k2XU5BOj8GAx9mAx9+F
         Aw0A==
X-Forwarded-Encrypted: i=1; AKwUvBy1Z79v636aVCCN+ThNljl6MPiVCRKt4HhMehqtoCeedm6N3TFvV4H5rOFgv8Hv8/7Ry8072oBT3JLRrw==@vger.kernel.org
X-Gm-Message-State: AFuF++noCNhitw7lNVhit4h4jPxkDfmqS/OZHjuuAszmK9ZmNsMWEfc4
	xd+SIpryZWSxNBPfheyFcpfBSGVtgu8g1y5JyagAbGkNinXMAcphDKP93F0qgeb/xUk=
X-Gm-Gg: AYBFou1N8eEOEBf1Ln0+zu3xTGFxevtt88fgl0x+Uq/rnoIz+b5AfPgeaOX/jIpNmeX
	YPrpuPMAKLXob5DmbkhXnZQtVVHm7gtrIigdh+ojtuniXDX5BJJpCCHWbfyZ7uAIUCdtDANOXLA
	q/9wkv+4i5cn7sgCbFln8OtJk/WjaBasXTPEZ6T1R3G1Eqg3OsgJQjDGuaecZOu8oxdkP7fQikU
	yzN3jy+KgH9uUHUnow0V0iWR6J0GG9dgqvfxBHRgd9jQreOCRJIuQesQWaNOHXHFU31fivnpdxQ
	zco3gvZ1L4I5qgREFw/6TQVUMrdKk02kxF8soh0OnU9mFXsm8a++Dc+4esNkXG32n5kTTiHsmp5
	xUHzo5S8Ef3FZLob3QIXPjEhtgQjw5nZ0GrbEEUzxMWb0wz0dngQNeiHXsW6EF77v8mLSFhnsA7
	khlm9kXRQmDp/rSZx2GY6dc5Awzu2ShQHyi9TqAEedotTORhOdqjW0j+sbT1PLGXPSj05V3R8Jm
	Pp265hHGCAbH0BPJhZ8i5UkUjxGzKI75x2w9elsQQ==
X-Received: by 2002:a05:600c:35c5:b0:49e:7d69:83b7 with SMTP id 5b1f17b1804b1-49fdeffff85mr48917285e9.13.1790172401441;
        Wed, 23 Sep 2026 07:06:41 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b01f:2334:39d8:9506:1776:f780])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde18a8a0sm78087455e9.5.2026.09.23.07.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:06:40 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [PATCH 3/7] drbd: raise the socket buffer size limits to 128 MiB
Date: Wed, 23 Sep 2026 16:06:04 +0200
Message-ID: <20260923140608.1116713-4-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>
References: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

sndbuf-size and rcvbuf-size are capped at 10 MiB, with a comment that a
larger TCP buffer is not useful. That was written for the networks of
2008. On today's long-haul 25G+ links the bandwidth-delay product of a
single DRBD connection easily exceeds 10 MiB, and the cap then limits
replication throughput regardless of how the rest of the stack is tuned.

Raise both limits to 128 MiB, the value DRBD 9 has used for years. The
defaults are unchanged: 0 keeps the kernel's auto-tuning.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 include/uapi/linux/drbd_limits.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/drbd_limits.h b/include/uapi/linux/drbd_limits.h
index 65d3ebf2437b..4132b619376c 100644
--- a/include/uapi/linux/drbd_limits.h
+++ b/include/uapi/linux/drbd_limits.h
@@ -87,14 +87,13 @@
 #define DRBD_MAX_EPOCH_SIZE_DEF 2048U
 #define DRBD_MAX_EPOCH_SIZE_SCALE '1'
 
-  /* I don't think that a tcp send buffer of more than 10M is useful */
 #define DRBD_SNDBUF_SIZE_MIN  0U
-#define DRBD_SNDBUF_SIZE_MAX  (10U<<20)
+#define DRBD_SNDBUF_SIZE_MAX  (128U << 20)
 #define DRBD_SNDBUF_SIZE_DEF  0U
 #define DRBD_SNDBUF_SIZE_SCALE '1'
 
 #define DRBD_RCVBUF_SIZE_MIN  0U
-#define DRBD_RCVBUF_SIZE_MAX  (10U<<20)
+#define DRBD_RCVBUF_SIZE_MAX  (128U << 20)
 #define DRBD_RCVBUF_SIZE_DEF  0U
 #define DRBD_RCVBUF_SIZE_SCALE '1'
 
-- 
2.55.0

