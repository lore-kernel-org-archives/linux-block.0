Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39423D5663
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154887; cv=none; b=FinmDxcJ6sb2WE5fTf0m2V8zgx107zcStU9vgIDG+kcgPqGbZHbZSPgVrXt3Cm/cDFgF9+zVwQnag4MdFRZK7cEAjG+Nz6wKDV8KBljVBPc33Laldn33LP/ROqPquEJPSbcH0FTYSId30yUBfbaRqN1ndkY5fdw2m9Xw1MUW6aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154887; c=relaxed/simple;
	bh=IIKZNdA3ToABAV5rv4ZMI3BNGIEBhesy6+I5AdnAp2g=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cbwDgXSffWPQa0QmGukoAHgER2gPib5aDuub5Gnk7RPcQL304dBbrY/SDOKaFPA095yGPI+RZtg3IcFiWx531+txVYI1cJ6YCKcgeSnu+8IpBZOigp8kV2jYy4G7/UAck8XMd/xXdnJ7itL/z2qbJ1hY0tjlYzB/v0cNiTShKTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=jdcJa7Xd; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="jdcJa7Xd"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e6128bd9b3so3075143a34.1
        for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 15:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1784154881; x=1784759681; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ohQn2DG5ji2OSGvbMyf+yo50k/BurXM2ZXuuP4gtoXo=;
        b=jdcJa7Xd5ln9BgGwvoU2YzV1PFLUEzN9PjGtaQ3tFa2G/wdAuGMgDO9pR+BV9mro/Q
         4EFMryGH3hR2mzqKrdA4sDhgPXOsRvCrj8A2eZsiBf8YfK0YPz7oRzztQCfwBpW9ASGs
         u7zuEyfELSXUXWOxdkW7PZ09cLmfb8EAebkhsf0loQ6YxGGLnGswok0JOFmmeIk4UUzK
         jslgc8m8clL9uFfYSSPJYjIVPzpfxLTpSTv3pMPFgr3GwDrfblQEDcg6oQ5k5k/VExqF
         +LWmJk2pvITEUF8RzPrj0+u/TMELDXTYwoo8+h7lbQzt3D2mRUuCWBoZ4Hdyscaft1I0
         fu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154881; x=1784759681;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ohQn2DG5ji2OSGvbMyf+yo50k/BurXM2ZXuuP4gtoXo=;
        b=UtE3n2J1VrMme14vIf3qzjmF8gjU+8OfCoo2Gt+gH0LynEdYhFmlXeLae9CV4NMLaZ
         dYnSw4RqS0qMNsUf8wqPS164coQyVPCNTs8chNM70BPksAe3n50a6jP6XA5esGZUUq53
         kC+PVNY8hNwU8dgZFvhqNwl5JYaxX4SFIM1nMBcyXj7CEqrGpqaEIDb6xWPYi4QljY6K
         CkmRSTayS+QsI8kgLFuyzNFwDH7JsC+c3m73y2u4CG4rdA36JB4fkm74EPTF3OVG29xh
         uMLVM2OZHbyyP/ljlorYOH7/uXVE6Tlgp6vQZpXXD8h/tZmGL7VO8QyB4UZj2+9N0tPR
         WCdg==
X-Forwarded-Encrypted: i=1; AHgh+RoI5OpTVYlzo9+jBD6NCYLZVvjn1OloYF1Oii8QPm3kk4WQqGtYrnQlMMSRCSqZi3aT7k5OazoaaBafMw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo3Sd9/75vC+/aUrxQ3GfN4unFs0ri1j/OUMmNUYqHHOgRl31u
	ZANxe2WCg7FIPpldghzGRvBeeJNCLXYxShZLjz2fbte/qipO6fM2pxdINR1GbzpFWgw5QzMhYaI
	osq8WdUM=
X-Gm-Gg: AfdE7cn265QsMAvsOJ/YJ+TiRyZtPafJUWS5Z5Iq9Aw6SumuuHSS3Bzt0rMb802WN3e
	hoy6kAgXDmRj3aIMnpbg+SDxBiN6T6UJPRyBm1a8wZ+Fs9XGVge21ZeWKrOqYI78hvKjvGRb0i3
	5hIvQ3Nn2Q8Ocg0KRSggfwBzD5COlk34ah59UE4AQVY54JsjK6Vp1l6yeiuzCDZoc9U8bPGcnSE
	E1QKXYmYn1olpSgG6s/bOZYT97StPIlJgOANRdnIavabuRnGeXvlOLsqf/KQCqaXpUYiALiK3KN
	d5d40wGqU+kXmPg8jF9wpWlliCLtO1SC9nXirBo3I4FDKWH3jMdV14YGUKf6vCClwIECwXS1D+Z
	a1UA231kXq+Scmm0tSp+tknflpCSEbBwp0aup4Wl6qAdEXh91ZoRtS3OYP3VlGf68HmMBwRk/7v
	0ZihH9avqfIwoqaBYW+2zoNSL4kjkwJ3NDBbYR67t9CL1ELFYKvYy1fws=
X-Received: by 2002:a05:6820:80c5:b0:694:9ea7:7aa1 with SMTP id 006d021491bc7-6a3d9e70d85mr3125716eaf.5.1784154881501;
        Wed, 15 Jul 2026 15:34:41 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45200b7b4c5sm14362722fac.10.2026.07.15.15.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:34:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org, 
 Qu Wenruo <wqu@suse.com>
In-Reply-To: <d10571445ee505d95ba6eaad7558fc1f556d2921.1784020005.git.wqu@suse.com>
References: <d10571445ee505d95ba6eaad7558fc1f556d2921.1784020005.git.wqu@suse.com>
Subject: Re: [PATCH] block: do not warn when doing greedy allocation in
 folio_alloc_greedy()
Message-Id: <178415488025.159585.4896334325664056033.b4-ty@b4>
Date: Wed, 15 Jul 2026 16:34:40 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 14 Jul 2026 18:37:39 +0930, Qu Wenruo wrote:
> [WARNING]
> During one of my local btrfs fstests runs, folio_alloc() inside
> folio_alloc_greedy() triggered an allocation failure report when trying
> to allocate an order-4 folio.
> 
> The kernel is from the latest development branch, which is utilizing
> the IOMAP_DIO_BOUNCE flag for direct writes when the inode requires
> checksum.
> 
> [...]

Applied, thanks!

[1/1] block: do not warn when doing greedy allocation in folio_alloc_greedy()
      commit: daff723f2d4c618d5f9186a990f47bf75878abeb

Best regards,
-- 
Jens Axboe



