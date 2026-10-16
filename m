Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93033822B1
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792176480; cv=none; b=I2UmSus8eRrjdsObJuvMW7GmhPrmXjKVa+Hv9sooZrEBLYvAMSTqy1DG4SpjMhRm6UzhVj/9/8foOOhTa1lqO+l02fleDiDnmbXVcQ4WdUAXIrQ9CAxKBkA5mc+kAeuVcC5La8VMLJNAV1tcaDUgcV+S+AIt9lCPGrevGprzdUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792176480; c=relaxed/simple;
	bh=9HaWzOKfnpaXCLuhegUHtmuWqks+3jlaF1gMhEmsKRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fM9fmHjZeC+fBYAqLXLSQNNOFFt6ZgI2op6JcGqKIEzcKlXis0uKgMqIRgToxTP1cLIC0eLq5mDSL41TThTxaqztSs/BVD4+Ujw5fMrOgylR1DM+6kC2Oxbv3BfXXXSysisvQfbJ4OqP7KmU+QPDFSGkuiCDcR5WqoI7cdP174g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=cWiGq7hH; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="cWiGq7hH"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3535a54bed9so251920eec.1
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 11:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792176478; x=1792781278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ic61/wqBGtfRXKsiAxz/tXXdVrm+pW2y1wsldll1w/I=;
        b=cWiGq7hHOnIm3ZX+xWXvn1LLHgSwL29Xd8Ej38K7tW+XFEWvPMBt8bSedxyBPDhbGn
         tisAQVd2r/5sXBgmzgVnMEhRB3GqCcLrJxQQejVt8gVehlKNcB5IFHqREwBli4DFX3J/
         a3X8NPtVFz6YTbaXOKu9RHCcZIo4ajWIjZM1rTZb8lwGi7cUjeci3SYwdYYBR/f/Cf0T
         eeOk6ap+0Ldgc4OTRg6m9zfoDAd7521NrH/3tNwT96ZvzOl+/piScRqRFNpe631wfG+8
         kbDjRHsRLSKjSYlfaVafg1xM1y32bflyCrD9VMZEpNzABGZ4rjllp8TgqSCQ7VN2czXZ
         PQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792176478; x=1792781278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ic61/wqBGtfRXKsiAxz/tXXdVrm+pW2y1wsldll1w/I=;
        b=c4tEVjyIpbMe1AZSyJHCHojH6dRthnGlAEkvbDrSly9tfNGcqvX9hKvSrdk6nLVne5
         wA6jmL7Jt1/ZdRYYfVsdEA3ZvNa4gA6dQOVKYUW4eEWaWFiUlFFEA4bUct2u5jEOLgbJ
         9MvW+Pbg0yHOYaLcJFzTToF2m0KSEwjwNEtDj++d6is5om8V6WH3HRckB6rJre2sHqHD
         CqJOO35UVsTDyUef3m5cce7L0ylt2aom6tf3cE102hVIw5TLZpNpSHwXftWAisdsXylQ
         za7yvA44rRmO31nm9QkdrxuEP7SfxV7NU96lCc8Ce8uOWk8twfjqqSincdHd9BMxdcO0
         4Xcg==
X-Forwarded-Encrypted: i=1; AKwUvBzx6ZwmgNnL7KxX55BWCVJB9f1y6sR6uTh+wPJsDfXOPmIfRKqbfLl4SnvFEfoEWYYvWPLGannLAnuUvQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKjTK7FN1HDIOIdwDmFiswwUSd090aFacEiceDcKtvGL9XCTR3o
	3a2uKDEm/J1Xk6ARKJnwbJuw4QiFO51p79a8GdNDJ0/isMtnB0G/qRMeLWHX17ml25k=
X-Gm-Gg: AYBFou2hRmiiDhpUnoKKvn/8h5wU6SUEgRAUFWJ6tKCz8O4gsclBBk1/bJwXS7Llq5n
	jI7VoM8cdaR/UDnl4ThzpYFBUioFX9v+8TakcYTSfxRNT2D6Q83U9lI8rmrt7qGy9GfI+O5oHTS
	STWJODXT+zs84dopiwISNplSMrXwYRu9xExElsTlNXZhqJ5oe+akQ4xghd1RUUQr/geO8Q1wY3i
	zqkxzhedyLGAXlKTdMx0FNBAm6Hj0+oeqKPEH7t0ByAG92tCEraieD+VRm1I5v4rFBKn2lzpyN8
	yD35tuWcGVH/sdwoGzzlDz3tNvacEwgPqx2S/uMjiARiQBy9VUfpqItpKDAlYR42D1IHzik9474
	W67q/8WTRkIY42D9exRz80xOcbGYkyOJ9KJU2newNsdBjVGo2b61pcGVDLkPXubJczIo+XClQpR
	/ZoTK/6+4JxC4DALWaE9hlvkD1dM3h4K6PctuKC7Nki3EGvnoOWtughXt7+W2LeVb6dbMvzNpRO
	z/hOtEK6jkWSN5nv7FTugoR9SE3F7twwQkicq5D94gmbGQP9u6HhEjPdUJMD+zqfKSwhQFOmQ0K
	tsN3Tg==
X-Received: by 2002:a05:693c:62d4:b0:35f:2349:a570 with SMTP id 5a478bee46e88-361a2a3832amr578015eec.35.1792176477713;
        Fri, 16 Oct 2026 11:47:57 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:85ee:eb9a:5637:424d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082784ec8sm8004502eec.22.2026.10.16.11.47.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 11:47:57 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	kbusch@kernel.org,
	kch@nvidia.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y 0/2] CVE-2026-64017: backport fix series
Date: Fri, 16 Oct 2026 14:47:51 -0400
Message-ID: <20261016184753.27189-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please consider this backport series for CVE-2026-64017 to 6.6.y.

Apply the patches in this order:
1. blk-mq: pop cached request if it is usable (fix)
2. blk-mq: reinsert cached request to the list (correction)

Patch 1 removes a compatible request from the older cached_rq list before
preparation and QoS throttling, then initializes it after preparation. A
plug flush can therefore no longer reuse the request while submission is
in progress.

Patch 2 returns that request to the single cached_rq list with
rq_list_add() on each of the target's three preparation or merge exits,
replacing upstream's shared-exit handling.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y).

This backport is considerably more involved than usual. 
We performed runtime testing to check validity and stability,
but would still greatly apprciate another set of eyes on it.

It was runtime-tested on v6.6.158 in a QEMU/KVM guest (KASAN, lockdep,
hung-task detection) against an unpatched baseline: blktests block
group and fio on null_blk (none, mq-deadline, bfq), virtio-blk and
ext4. No new blktests failures and no kernel warnings on the patched
kernel; no small sequential write throughput drop over 5%.

An LLM assisted with preparing these backports.

Thanks,
Artem Dinaburg
