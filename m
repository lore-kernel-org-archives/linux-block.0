Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018067;
	b=zC22PPeSx2GIonrPSXMArHT1RW6wh+LSuJnlgrX2HBpI+/6g86PUrzJu7PASPBr1pQnt
	 lYF0BF4zw5rVn8lLn5t3/XoJ3F2wNrOrgaP+SkXnQ/dcuaKHnPhMbFELchiQldawF/ya/
	 JbBZc4WLALJJB9Rx4bz/y0ZLE5vMXrosmgcPzWfcLWl4Pp4X8S8lNpH7ZY+xMEtl/5KcK
	 iruCgP/oSI5HK+HeaDaRTuFahcYSR3l1EWO7080UJV4rFFaJcsHGPtpjiJ1tUaL3+yAXz
	 Rz0Tqh1A4pP4ltJcd6EgdfgP4WBaanTdcr1MeV+6McPQwwTPr5ACJfj0dHSGITVPukg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=miZOpsXXWqTDg4brI3XNa3nMkTf1a4j0jITu5ECiOM0=;
	b=4uWgrKzspiL+uLOcVs39oOSPYIh3vFxmKETknBl+pli2q96757uFzlYejCvbqlRxRz8e
	 bMfPNmoZhdnJ4tQe29OMRMKnOjHq8foaphA+v7Ew3Z+b5GH9D+pJv3GSXUbzPeNDrtNI8
	 m3oSCUI+D4vA+uWzujG5GiC+RscCuH2xOpWJBcgjdiyP2cq1riRuOuiZvRS/dF4gN/z4W
	 CeT56Ig/nHE8L7wH0zKJK0JQfgYtU2Tad/bWegePLjuoKbFu9od+zzuiofGRvq9F8uP8g
	 yInQ5ctpwkMlc8TaPPQiLLLj+wKy4WwG4XJL1m3DnzeEbiB39ApOSQDXGo09+EdQx6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rfERdRut;
	arc=none smtp.remote-ip=209.85.160.47
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E87860A3821
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 16:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E87860A3821
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rfERdRut
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4ad4072943dso450152fac.3
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 08:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795018066; x=1795622866; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=miZOpsXXWqTDg4brI3XNa3nMkTf1a4j0jITu5ECiOM0=;
        b=rfERdRutCiY1Lz5trk/rT3JitdkQbyeRpy92SAEBTr0SmwHHW7GjbVlsL6xi4GLvlA
         eIy6I8HWFFPJEAko7lPdUqZJ0ASfQs39uGsb2kxFW41b1JV5vmuNw7JyeQ7RyefPZ0K/
         9xQMAXHoHzpNH4wuyizF2fSFPUA4p28V42dt2F4Kqw0BLpetMDyzdYPIEpOPJPmRoJPR
         CA0R4B7acExX6CwARQsZdifC0Die7wBlG1RRQSCl2BNtFRelYwu0NbJSKXPCQplp7vXG
         14ey5H5NU8zd6o0RiLfoiNrrbcb/neM2Pssr4bC/1VTI7DlntKS58QKULJCOW7HRil/c
         C9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018066; x=1795622866;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=miZOpsXXWqTDg4brI3XNa3nMkTf1a4j0jITu5ECiOM0=;
        b=Yddl/8Oan27F9wGPq5XFxqLC0VMZ86VMfiz+jjLU13aJSCchiYErxtllMIvkCcHiSq
         m3Yr/2smYChKNVbs4RPlF/AS5aEXZClRAJkyBT+FjQiSE7RwrDEJn7Am6z/hMwcgApRZ
         TMOJO7+XS62QxFsz52Ze3tderGYSSYSjhXnx2pl28wgJprxhpYYj8viTlhp8eukRLmOQ
         VdQ37mCk6jc+qtqbX5qhFsT41hroWXzppMVWbzZIhwYirSC2Bp0XBOWQkTaYOGmd0UTs
         rcUVJYyj+cvbB/eyKAoOx4Voi7p7bfapoxJAlGlsoZySiemL5jipi2LJr0/Tk02bxGXi
         lfAw==
X-Forwarded-Encrypted: i=1; AL+hErEpB4Low6EHf7QpNr/DJC3zE0Z34JEB8KUgKexOZWHSy5nXP1lepkBTSudPiqCjGJyPwvoakgJ/nrJAKQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/cDX1NPnG0YJbcrtv6Y2OoaC+tqPYfeke4SSeuDfQ+tpnVM0Jt
	nJaBm+fz/QhojxbT/LgnUT0UsRrdLHhMIB1g2hnsTszCxJ0yUr90msDgL7/OZoOuG+0=
X-Gm-Gg: AYBFou2q532vuK7l1JRJlMemrq/wp2BQfX7RQdsi0qCQrow+G+bcQHCeDWcrztXlvkJ
	WT5Y0oj7Zbk+6ol5uXnotGjpegHP7cQfbH5q9AbDdTA34wLQQzo0bmvO3+GJIkRgri8juTVnnGi
	fSWLLRkWsah815i+0ENalgMUtxwWr8BgX6sGyi6aPC2JI2cYwI7ZulSN3Ru/bGM9u+JnHqtA0Nz
	nwPePIYtTO6PAfQJYjRzXllduAz4FUXwVMruiUqyn3QTTFx6zTDBojdxYVVyKpaJErG+87KYaWP
	Ea4WW9vy2BWM2Irnnmo3+WnW36ChX6qiZgs228tHheNnQnItDJMlmheoZTMjp179UvTE/0jhg64
	L2goY2CICj8B4b9qXXkYAsT6iG+ef6+we/zk4jGD6Q/Sk5+rDWJ4AuXgYxMnAm0W1g9vf7MKnKO
	Z1LNIibHdpgMmroSVbmEbRTZnd8ckFZXZmdGC8WpYM6/Er0dzBZRaIFfUXNYfuL7NGDo2Svngok
	dzfmx/BVUvK1GEseiE16Ap7Nqlv61pjwAxDXhX1VjMLBRBcyH2iN1ABli4F2LP1tShwGBEVLyTN
	lGbv2ZVg5yywHbbjnbL6xYE5B8C89EzmuEZocWYDDfmWgSlRhWO6DGIrlxenzLKE2Yer5NpleQk
	fPAsE1TgVJbWQTWOCEI+DD69i4RORjX+reHPFeXlyIfZwrV48jsxwr+7DmVxpsTSpifj58NJF
X-Received: by 2002:a05:6870:8920:b0:49d:c8ab:967b with SMTP id 586e51a60fabf-4b7620acf02mr2521246fac.47.1795018065606;
        Wed, 18 Nov 2026 08:07:45 -0800 (PST)
Received: from [192.168.11.112] ([96.43.243.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b743721fe9sm2624231fac.6.2026.11.18.08.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:07:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Stanley Jhu <stanleyjhu@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, 
 Brian Norris <briannorris@chromium.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Praveen Talari <praveen.talari@oss.qualcomm.com>, 
 Alan Stern <stern@rowland.harvard.edu>, linux-block@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261104112744.1630864-1-stanleyjhu@google.com>
References: <20261104112744.1630864-1-stanleyjhu@google.com>
Subject: Re: [PATCH v2] block: Keep RPM_ACTIVE in blk_pre_runtime_resume()
 when already active
Message-Id: <179501806424.17649.9429091372346585775.b4-ty@b4>
Date: Wed, 18 Nov 2026 09:07:44 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 04 Nov 2026 19:27:44 +0800, Stanley Jhu wrote:
> Since commit eef1d74bf88f ("PM: runtime: Only set runtime_error on
> suspend callback failures"), a failed runtime resume leaves
> dev->power.runtime_error at 0 with runtime_status set to RPM_SUSPENDED,
> so later runtime resume requests run sdev_runtime_resume() again:
> 
> 1. A runtime suspend increments q->pm_only from 0 to 1 and sets
>    q->rpm_status to RPM_SUSPENDED.
> 2. The first runtime resume fails in the driver callback, and
>    blk_post_runtime_resume() sets q->rpm_status to RPM_ACTIVE and calls
>    blk_clear_pm_only(), decrementing q->pm_only from 1 to 0 so recovery
>    commands can enter the queue (intended since
>    commit 6e1fcab00a23 ("scsi: block: pm: Always set request queue
>    runtime active in blk_post_runtime_resume()")).
> 3. A retried runtime resume calls blk_pre_runtime_resume(), which
>    overwrites q->rpm_status from RPM_ACTIVE to RPM_RESUMING, so
>    blk_post_runtime_resume() sees old_status != RPM_ACTIVE and calls
>    blk_clear_pm_only() a second time without a matching
>    blk_set_pm_only().
> 4. q->pm_only underflows from 0 to -1 (triggering WARN_ON_ONCE in
>    blk_clear_pm_only()), blocking non-PM requests in blk_queue_enter()
>    and __bio_queue_enter() while the device is RPM_ACTIVE, and the next
>    runtime suspend increments q->pm_only from -1 to 0, letting non-PM
>    requests dispatch while RPM_SUSPENDED. This hits the UFS device
>    well-known LUN by default and SCSI disks with
>    manage_runtime_start_stop enabled (ATA and FireWire sbp2 defaults).
> 
> [...]

Applied, thanks!

[1/1] block: Keep RPM_ACTIVE in blk_pre_runtime_resume() when already active
      commit: 657d7c48b84f2ef0bf885b47cf2318823bc72970

Best regards,
-- 
Jens Axboe



