Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3734C3CB570
	for <linux-block@vger.kernel.org>; Thu,  8 Oct 2026 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791495836; cv=none; b=c8I38ShZUu37Q8u5IVEXqiriGiD5UUPlcPifZhH2xj4X/r53/sbtxoGy/sjPWDlHy+FpIK06ZZlnsQDOsyO+CjqY4rLE9X9IXFPNWpHIsmiGWEm4Jnjfm04GS+aRgP8YxxsUNP4DCfGNdOC/hgyK1pOuVHtw5PRnftYyThn87KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791495836; c=relaxed/simple;
	bh=rjfDai8SpMWRSvJXTYPEduLGynEZhxYgh3aoDjNLf14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H0c86tmBOuhUeBmzoM+cbCNIafKC3/A+0+v6YVD+0oPBPFZYfsbMbxHcO+dt4zNvx6UxepFjOfCWzmgrxe0a5pL1h1ECFBKZwCDXpd/sDK8u8Jo9NjEqF+k2ISoZXQxcNyydlJoHABYmAbeFyMuGen+S4suaJjrex7c9i2HY+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMxHwNAT; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMxHwNAT"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-917a4b69a79so37379156d6.1
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2026 14:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791495834; x=1792100634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sI8Tp1gxu2k4vbKe+if+9VifCpYJLR1GitVkoGAT3O4=;
        b=jMxHwNATWXoNff+SLe7yuHIsOHvSLZRPdJKcL+HQCvNvLDc5jTuMRb6pTGJBs9m6dJ
         oVM65p6gkfySJLVbKjk2SaewvkF2un7RzPUW5RxmA7hYJ+4FjtBfjybqViDi9U4XrMLf
         PbDzqLp1dtN5Tp9wxprS1gOiFWawPgYlpmu4SCZUBVOwShESEgighDmfKlHpHsaIFikl
         N8YuBkUJSo+4jykpyLGl64Q/EI4C5+RGjESQY+04VmdH0vtDG8810Bh6UWoSJ0kURASM
         v1+/3aM/oVZyrUN5pNNZCfyBGVnf06NQK40b5XYOCo/Ox6NNobTBT4s1V+Hjx0e6q0VJ
         3SZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791495834; x=1792100634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sI8Tp1gxu2k4vbKe+if+9VifCpYJLR1GitVkoGAT3O4=;
        b=Gox+UngzMgd3iAcwZDiZ68deezD/uzn2g7jz7zT4kjkIYpD1AUGenklBO6oVpDT5kQ
         GMc9aDdrSUKvJovugtrhXLOYFkcoBLFAh3Hl8yUWbSXHRgkBaU+dk84yLm6R+56FMf17
         tTKsnB98dh/TbV897gC8aNHNQweDedOwTQ78q2bi3qo7COmuv9HeZMW6HXRhNpA28BZ8
         uefC4VFzay5wvobpd3w1sdVJ/47T5UQHtxMqIcdTQXqxuoazSrxWflxUfut8qVQnEDTq
         lE8javeBrT7IqL2yMIjjvM/ki5Th8kISyOQI5XjbcMErIRIB+O8rbTXTvS6Aqiv7iZyK
         Sxsg==
X-Forwarded-Encrypted: i=1; AKwUvBzckXGICkj825yfKE9z0ZGY8ZedffGMaT5b/h6zFOR3OiHynYcyX1ppSa3r7sDNwGgyc34O9XLyMF5CYA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL6LQAC+wqZ2nrVK6UZcMyV91hVbl9ma1FHpK9XD5xtVUkY0zsc
	r7JeYEGgIxbJt5LdnWf3xlck7HTjPOPXnbdzx4MT8mKwlO4WZIrN9CldABlP3/w6BP0=
X-Gm-Gg: AYBFou3WZX8X68apqG0CPLxjrM1wTVrIdMgYiWloJ2OA37UrjEFhkGSEJQOQEMxuKOI
	HGEpbhCQpVML87u2LTF8zhjzeXc1klxQT8z9ToYii67O4wFoAzFdwXI17lIfR5G/dzQMcYAWg32
	/Tuixr3J5bF/uaA4bmyt2xwvQNeSXDyagscZqs4azV6EpLynJ1s5crxhnhqGSy98efgtk87HhTE
	7Y5bQz5YePIAbT7q9DwWKNGvRubL4iJxFgvLJ03ebYoJ+uaaB05hYRGHTPqCWIj3iALe0u0tIHJ
	5i86ZvtwBnt/ux07FdRtSmX5cRcu5chS7GKuOY2ZAnkeCQu7+v7GzKqh0G/08V2r5611KN44E+P
	0RFvCBp+nVd4MYyubfeNtY81omAfH+r2I+Fe0Q7zx9dcszEIIvScTGwe7gcNU2hGVbJgLhV/Khp
	GoR4VqATdgkkTSq3Qdc0hs1djHqNMz792n+9+hQptIxOmDgVHyrg6H5z8A4qNdX9IsvIsavIz2k
	QO1viw=
X-Received: by 2002:a05:6214:4505:b0:917:bfa7:2598 with SMTP id 6a1803df08f44-91b55578a45mr802446d6.18.1791495834104;
        Thu, 08 Oct 2026 14:43:54 -0700 (PDT)
Received: from debian.lan ([172.245.89.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b5507646fsm903406d6.28.2026.10.08.14.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 14:43:53 -0700 (PDT)
From: Maks <mi9992828@gmail.com>
To: axboe@kernel.dk
Cc: Maks Ivanov <mi9992828@gmail.com>,
	io-uring@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Question about asynchronous blk-mq tag waiting for io_uring
Date: Fri,  9 Oct 2026 00:41:37 +0300
Message-ID: <20261008214137.1267424-1-mi9992828@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Maks Ivanov <mi9992828@gmail.com>=0D

Hi,=0D
=0D
I read your comment in liburing issue #1492 about callback-based retry=0D
when storage tags are exhausted:=0D
=0D
https://github.com/axboe/liburing/issues/1492#issuecomment-4696489936=0D
=0D
I'm considering this direction for my bachelor's thesis and would like=0D
to clarify its scope and design.=0D
=0D
The initial scope would be io_uring direct reads on raw block devices.=0D
For requests without explicit RWF_NOWAIT, the mechanism would register=0D
a continuation when tag allocation cannot complete immediately, then=0D
retry submission when a tag becomes available.=0D
Explicit RWF_NOWAIT requests would retain their existing=0D
behaviour when tag allocation would require waiting.=0D
=0D
Could you clarify a few points?=0D
=0D
- Is this still an open direction worth investigating?=0D
- Is there related work or an existing approach I should look at first?=0D
- Which layer should own the continuation: io_uring, the block submission=0D
  path, or blk-mq?=0D
- What lifetime and cancellation constraints would such a mechanism need=0D
  to satisfy?=0D
=0D
I would also appreciate pointers to other open problems in io_uring or=0D
the block layer that could suit a focused implementation and validation=0D
project. Existing bug reports, design discussions, or TODOs would be=0D
very helpful.=0D
=0D
Thanks,=0D
Maks Ivanov=0D
