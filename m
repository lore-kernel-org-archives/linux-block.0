Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B1153B322
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172408; cv=none; b=uLM+BC6Bnz/q2ftc3yCQjy+OfFZpnlHkR7lH2RcZW9usou2022qXsGYtoQ5zLudbXtWAqu5OHhEBJIo1kZ7Dc2E3PY86ndEPWXysqmeEzW9W3Q1L7ALo1EVJm08Us1BbaRgxbYiSucs8T+CxdmWztJfzvwBb4navZ5zcoTUpR/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172408; c=relaxed/simple;
	bh=oQMVU8CpkA9s5kiL5H6wuFFn6MAbCEqOUv5Twc3UmE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnaUdyMiB1Z1WQHEgHiHOtEKqM9nmG58ppkf2uOXMucZ0NJ0PeQf9+9v3b25sE45ahwjy3wdd71eeZsPEqsbBaJCSRYroSPtLxmclhLQaEO9RnWFX/0XXpJC+CHq26Ptlbeyo0pJuql+reBEl0ZSoMk9XSogYiUcC8qP/KEJ3Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=RhKC+9ML; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="RhKC+9ML"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so5952945e9.3
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 07:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1790172403; x=1790777203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R4doGn8NmMxWa1rKrQkSd1esBv7W7hOO/WeyOJxuxR8=;
        b=RhKC+9ML2XEh05Hq4asmq2tSoLVZYM7hMZiUmHPeca8AsAlLVRlf09cNIfDXxJv8k9
         /k+wmoEKqcqg/+LcZtyg0jc+ip00oCnaSwIc2fqrqZ6vhcVzVeNnZyCCW6DRfCHYI+dR
         McoReN4Xu3ShiEXZ42GoiFZGxrfX46XuqMsmFEnF89giGqbMANKvp+LjxYYLUVwqngAn
         QSlHa0nB5vnIKsXvffiLQdOc/0maopwotBOEXhi2kFF0xHG8eWO3pJvs0kq5QsPdD5vT
         a8bCsa5DoKKo0GKCt2lUfI0Y//hcScwc2aLas6kw1/FQKj6WXcTbtdMDAAkjmGWdv73E
         9PmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172403; x=1790777203;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R4doGn8NmMxWa1rKrQkSd1esBv7W7hOO/WeyOJxuxR8=;
        b=FmB4bIMQ6YWAJh72MogDT+Jx1MJv8ax8gYxdVr37wXqEY17kcIzXq2Kc1WZ9pvpgH8
         YTjDrRd8PgsaSfXAaS1S2Mxo1h5FFDBBZqdPWd4IziWzublfQ3fCx/z7FhjCHfEpLXrh
         +5GivjO+dlO4a9VKDAsBT6OxkBIvsNk8YdIRN1802yZ0SqncoHQB05zHnO1+I3obB+lL
         DO3tKVknNnw4k9GcaC0MPTKX5aT69Z2frvspa6aIhdH3uWoFfU+auLEiZqE97BqZqDE7
         ONqY4sv0tN7DgEyyZAIXFPv+imGzpcFAJ0E9F3muml5pjIep3hImtK62ij/NVq/anRbx
         GmZA==
X-Forwarded-Encrypted: i=1; AKwUvBzFNVohJIP7DLK0z6Ucq/3w3WrqziV6+5g6KvPgyEsNnBvSq9cYfM/azNAK0yuT4SgSoOWGLRuzFpYrBA==@vger.kernel.org
X-Gm-Message-State: AFuF++kg917eb3vfbgIwCA7xCHmFfdo85lYDyb+qdnClCUmkT2B2BUg8
	T+cy+Sc+r6Nr9LjzB3hXq/ZWaap7d6n2kT9yk08TmE9BHeTlZflD+o8PVKyOWOby7jYUgd0J5vX
	d9AXwQCE=
X-Gm-Gg: AYBFou19baeLwlmkKmEpy4dxLCsWukDsigbXBuEoZFc4JrlWQIJ3H1IWr5aN+Z24x0J
	3rlddpDZrCK1nUiA7pU/6W0/O+qTAUzwywS72sxhsd7NcXrdqbPmcXUJljYjTGclh1KVNNxV9Q3
	J5/W8pz+bGEvlZbYL3ytVpWPSskLLuPMVGYrNGq+b+KiwQiqEVKvC/461ui8ok9nonxjVskzCSQ
	frTa3G48NAr9kPUVFX8jTLr3Qj7PwYVEYMOxTxei5imBLiv9fCT/Xntin6MiJi6xmCBUJe646s3
	Kl1Do/7gW4mG3kGhTfRQHYH1YzqPk3d1ZkEiw385F1SdT1BfGOEWTBHcOey98V66NYJCJa/WPIa
	stQH8fGWEwpvd5VkyhC5RJVJsoWPhfEV0qbLzdCxdmvYtKs+0MX7K4+QQHG1lJxB/VwfX2yEFTs
	QBYTSvrrfUyEVRMeCX9iHrgCVfag3DEAjtPpGx9OqjZPj6YWTJDUbIo3ONj9hn45UT8js7pdG63
	euj0gVRajUt2JLZAxF8Dp07EqmPqEs=
X-Received: by 2002:a05:600c:46d1:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-49fdefffe1fmr40005835e9.10.1790172403175;
        Wed, 23 Sep 2026 07:06:43 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b01f:2334:39d8:9506:1776:f780])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde18a8a0sm78087455e9.5.2026.09.23.07.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:06:42 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [PATCH 4/7] drbd: raise the maximum resync rate to 8 GiB/s
Date: Wed, 23 Sep 2026 16:06:05 +0200
Message-ID: <20260923140608.1116713-5-christoph.boehmwalder@linbit.com>
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

The resync-rate limit tops out at 4 GiB/s, which was chosen for bonded
10 GbE. Current hardware exceeds that with a single link. Double the
limit to 8 GiB/s, matching DRBD 9, and make the constant unsigned like
its neighbours.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 include/uapi/linux/drbd_limits.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/drbd_limits.h b/include/uapi/linux/drbd_limits.h
index 4132b619376c..bba0a0aa8792 100644
--- a/include/uapi/linux/drbd_limits.h
+++ b/include/uapi/linux/drbd_limits.h
@@ -121,7 +121,7 @@
   /* FIXME allow rate to be zero? */
 #define DRBD_RESYNC_RATE_MIN 1U
 /* channel bonding 10 GbE, or other hardware */
-#define DRBD_RESYNC_RATE_MAX (4 << 20)
+#define DRBD_RESYNC_RATE_MAX (8U << 20)
 #define DRBD_RESYNC_RATE_DEF 250U
 #define DRBD_RESYNC_RATE_SCALE 'k'  /* kilobytes */
 
-- 
2.55.0

