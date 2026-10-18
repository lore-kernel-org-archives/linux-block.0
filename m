Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2635A3A3822
	for <linux-block@vger.kernel.org>; Sun, 18 Oct 2026 03:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792295507; cv=none; b=RQxL29jVuj7mJGecXvZ0PhWUAJ23JZute3VqdHlwJ+Ayopo2CNOB6LfYpCAahd1vmDdUXDqKb7oNh16ea7stozUAv0r6FIpQrvCETyolwSRXHrA12pY9XlyK2PzHnBNV9W0qlmpLVcwSzLRkesm/OTgUIPLclfvSUpIaCp+KPV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792295507; c=relaxed/simple;
	bh=AjrjMTpYbeAK4JI6FtEtzk9rlqw3yHKLbp/+E2qvah0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9L6JObfwV7Y7rGj/9sA5I3waJgbjs0zIgN5Q+DJsyvP4vt6HNvFmY7/Q35V8SWuEO6YKW9+P6xdl1QlX2j0oi1trke/Q8bY8yE+YPEKtmsyFNHCmTMlyKCILVGwwccUe5zQqmJ+rvYBaWQJ69F7Pa+t+N62J1wpg4GsrF7vXjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gug9Z7fY; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gug9Z7fY"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so517219a91.3
        for <linux-block@vger.kernel.org>; Sat, 17 Oct 2026 20:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792295504; x=1792900304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ekUzfSCWNq1Ng7vt6OtO+4tAJn/2muvIGZQLxicYOuQ=;
        b=Gug9Z7fYiSYFNRtfK7/NLd8PDq1jT2Ts9fntBs5WtxGFqx204injzyrJqMQUpkMtRZ
         90JeuuE6hiEDpU6b29n4zdMR9GVaJ/ytfTv6G0k5iHi7U4lxsRmoW9rOvhEEKR108u1w
         nFSUWI3a3IOKPewg6DvAlWA3Kg2rUBaDSg7HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792295504; x=1792900304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ekUzfSCWNq1Ng7vt6OtO+4tAJn/2muvIGZQLxicYOuQ=;
        b=EDWEDBjSpurWf69TEYFTRT3yr1NyfSIv5+4VvlOy07XAvc2aYHv4Fm9AbLuNg/BgBS
         u3/UDOmkZESId1yf1eaUP3rTcVSNBS8v4ZvX5ZcEMOvq58mrntbFe62b25Jbt7Zt4fmQ
         xTkrRBPZO3kavSF9ygTTHjpZyC2AGw8FLdlI24kixmb3v8aMLUKUsH2eaauu/WiZq35M
         7wUe9wtcYvSryIhaJhZzpROIRrmWzXDkbba6ME177hC2IHtdl6rV6p1pq6IDamLyFvr7
         A/og1+w04krgOrULM5dQqX4odFFqNC9Er8fe38iLmmtE0tKgqKUm06+pg/O+lHyBXwF+
         bdZA==
X-Forwarded-Encrypted: i=1; AKwUvBwWH83wIcph8p93pfphCX5F8nXazooslyqY0U0vuWzPRwUINBoFsrKM70OXQMvP/ADJbj5sHi4EN45LtA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJRc+2hVGScvg/OaCHmPywJDmnca5b61xCsKv1WUhsKcpKDPxwD
	61Ev6GNIF/SxPfnpy6UCwD3ppU21WN0hu8+aAwbr5Xv2BO8qUtH1gGbpIL6qYsLXLg==
X-Gm-Gg: AYBFou1cj9fsB2c71U5IXKopR9A8fsvrEcFrQcIJfLFUxaqeMJSqE3obpcr0cm2a+js
	tjZh05wg6CPyQB0qpVSXYFKjoCEc8+FkeRvsD/A4UedjWBFgwKG1nizwazZAyYKi0eNUuzGKoyL
	Ml4OILqxOXSfB9ON8ZxPkYw3b8l94LoDqow1UtwnSx+kxaOxKa/EQzLC4TKTvD74dTWFSzwqA+E
	nToG6UHRYdJRK0/0V0ffXBp2TZ4+O3gj2OcHR7EFblJWtqujR8yvs+vaGxoAPR6D+KVoIzQKqIH
	qHQ0Ip0vEGCookwyJmDbsthVvciPTKLfUulBAdf/0Zu7FjdViAAN2Wa+RlP95v+9hxaMZJY9J4X
	ryTIPOB/uvI0p49DI7FDArl64TWHqW/huacarWdeQ7cumfqFUP2C+AfPoERXXWUbzeakHIoi7NP
	6oApQmor4VKvWors0IbGZ81PWnQWnbyDcb/2ZSgPHxleNtTBCnlYVf9eIK6k5i4IpFfAMUKDp0D
	k+baCSwD9Y9EMkEkUuixJtFzqTomZL3E5KkQko0w8ds8v6nOxMM32pcByqHMMF3gJY8NuL7rbU=
X-Received: by 2002:a17:90b:50c4:b0:3ac:9ed8:f310 with SMTP id 98e67ed59e1d1-3acef5960fbmr4275858a91.49.1792295504422;
        Sat, 17 Oct 2026 20:51:44 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:4569:b311:f3ea:5f8d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad25d5d1b4sm253024a91.16.2026.10.17.20.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 20:51:44 -0700 (PDT)
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
Subject: [PATCH v5 03/13] zram: zstd: do not allocate empty C/D-dictionaries
Date: Sun, 18 Oct 2026 12:51:05 +0900
Message-ID: <20261018035125.3120704-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261018035125.3120704-1-senozhatsky@chromium.org>
References: <20261018035125.3120704-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not zstd_create_cdict_byreference() / zstd_create_ddict_byreference()
C/D dictionaries when no dictionary was provided in the first place,
because zstd still allocates internal memory for such calls (~96 KB at
default level 3, and ~160 KB at levels 9+ on x86_64).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 127976b5455b..b367049f131d 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -76,6 +76,9 @@ static int zstd_setup_params(struct zcomp_params *params)
 	prm = zstd_get_cparams(params->level, PAGE_SIZE,
 			       params->dict_sz);
 
+	if (!params->dict || !params->dict_sz)
+		return 0;
+
 	zp->cdict = zstd_create_cdict_byreference(params->dict,
 						  params->dict_sz,
 						  prm,
-- 
2.56.0.176.g3575e65682-goog

