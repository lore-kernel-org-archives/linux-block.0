Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0136369D6F
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139112; cv=none; b=VQvb3BbJENOmGti5ES2lzkCx+kSiOEgVyYSbLapQ3EyTpzWg9Rk4CMYwSZ0EEOilBRg1WOrwDZ++6bnVqv7pJW4rYFGq8xb7R1HbIWs8CN1tzRn7OpMeE7fj14cNZu4QbIaNQBHuG4GKbbMSvypmDQhuZCarsxn8xmvTteL5q6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139112; c=relaxed/simple;
	bh=6/BdbYqdcZY9dIig5OcHM3ZIkVv9X9lZQVPrP0wQUIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVgiJ5t0D9Uq5B33rXtTCzvdb8Jw2PsgNvJNO2bMHBdrEh0DDJTPFjsSzgOPeNCzVKW+JRIY7LDpALKBfHUWtvjqumJpyluzw4dARLHA6A/iSHolPkGAd5HSTiqPrxKHR/YH0R7DIAqeJdZ8g62y+ZxUgYfmLiTYFszYevN4F2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E3yKSxif; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E3yKSxif"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4834977ae75so578565f8f.3
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 08:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789139109; x=1789743909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KmDwdyq9Q0uxbSq8SDMOz/Ug4vndqaUQy+VL3xEV3E0=;
        b=E3yKSxifi0pvQfRdRgC/conJLhso6/AJHcMTItLsGdSMskSELM5uK2fYz9e6exQVKf
         MWft8Xeo02GFKwFF1J20S9wMB7aoIfSvbf2fLR2xFMx+SWAgWo6uiymrZLkNaSKHGQG7
         r15l414Bow79sjZNDiDrUjENxonicH3bQf7ox83uGmtNt7FijjI3UsyCX0bGe+Z+quEU
         Xmp3SGFCgwatniq/9zav6LmQq+OUiGsl7Vsc88cEUAM27e4mZZ4Aj2BF5km1Pqy8SeGN
         ibSoc2lO21+eMvLhgqVmDiC3iN0b+l4XndHd/9DStRXuRxcJAqUbnM6O1Xu76+wYIHgp
         BovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789139109; x=1789743909;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KmDwdyq9Q0uxbSq8SDMOz/Ug4vndqaUQy+VL3xEV3E0=;
        b=QU0RjeHfGTePWUFgK+1WxpdZeG+Amgv8zxN0TdQNUaw0aGXwOAGlnDVV9vyixIFgaJ
         pp+pZhZ9p4S6p86m19ArEaG5lApbZKkQ2hbY7JdmRhFYSKnhHr3Ra8w3L22yy6czV6vc
         zag1K9jDSlFmNG/lkifJNMeyHabfRi9Kz8CfEdnJmiHs2I9oIRg2u/uKWZCEYuzLczWQ
         /wmXtWmMvVzYjFFJpzBV20XEgpOKRR6Fxr4CxkjBqrrKwQvquMLDpn3vgdVUlUGEI8NY
         pzg320BLeTfWmTNoMapRm+cLlIWj3EW0PzHXuh54hV2xcTY1oysXvFy0HqF6KXvBnV/p
         1Edw==
X-Forwarded-Encrypted: i=1; AKwUvBzsICfjq/dEP32KXDPJiQ1ylUeCJIyzU8h1H9Vv1ByQewi6Ev1DOOWnUi+zV2JvESpx8Eqc5de2rimY3w==@vger.kernel.org
X-Gm-Message-State: AFuF++nmPh7KPFQRET5GWVf1OCTNyGWnUaGXzLA3rrg3XFK3+vfpP7/3
	/ImZrYGlHNFA9vfwQmm4L5EougFzMePFmZfWuZwHQsGFJ17gBeYqSssPQ4APsNwITBU=
X-Gm-Gg: AYBFou3oce7SDjJSn7aNgJtfMg5veI3OIR0idu3nqKJNOAjxod3WCQ757kk5RWpkUny
	E9dIqCSXaO2A+dqtpfncTMcblq1mkxv888mPWBQnfE0RGg2gRB1wx2C3ejQq7iuTSRpFx5LPKZm
	cpzh8EaoCuSWLP3SlM6PV9iSEUz59E3dyTokptvOyeGmdtBNy+OFIwxm1rGELiR3QNprksSl8wy
	2ll4KSZv56QpKm8fnujSkuighJKQGVld8xuEe9Q64XCoNoJ1K/evnm4QiR1n5rfNBJ0XyR0582j
	XyvsN/h5yFOoEmY1F4Z5oJk2TmfTsx3BQDWB/iB5HId54ywppM1jKSjbSljHw74dBMOyGfYXrs3
	MQzUpa032fgGObwLpvvrliLM0a7rG6yyBrSTG72FCo/SWFfqWY8MAugB4iD40m6fvcHBkzXv/gy
	mndkA+37U3WujGKAbUd679ndb9AFXv/snR+Bj++97/Mv+FZ4Xo7XxDbShtTHNmILScGMgoXCNUW
	8DLCA==
X-Received: by 2002:a05:6000:29d8:b0:486:f4b1:8c4a with SMTP id ffacd0b85a97d-486f4b18d31mr887113f8f.10.1789139109105;
        Fri, 11 Sep 2026 08:05:09 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb350686sm6853579f8f.27.2026.09.11.08.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:05:08 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Simon Horman <horms@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Francois Dugast <francois.dugast@intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-block@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-api@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] block: Include error-injection.h for ALLOW_ERROR_INJECTION()
Date: Fri, 11 Sep 2026 17:04:01 +0200
Message-ID: <20260911-module-include-error_injection-v1-1-5da895d8c84d@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911-module-include-error_injection-v1-0-5da895d8c84d@suse.com>
References: <20260911-module-include-error_injection-v1-0-5da895d8c84d@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

block/blk-core.c uses ALLOW_ERROR_INJECTION(), which is defined in
asm-generic/error-injection.h. It currently relies on this header being
included indirectly through linux/module.h -> linux/error-injection.h.

Add the missing include in preparation for removing the
linux/error-injection.h include from linux/module.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 block/blk-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 196bccf27f58..324a2d1bb727 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -40,6 +40,7 @@
 #include <linux/part_stat.h>
 #include <linux/sched/sysctl.h>
 #include <linux/blk-crypto.h>
+#include <linux/error-injection.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/block.h>

-- 
2.55.0
