Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586891;
	b=17lOlxMFwEmBz57Uwy9k5zVNoqNHGSkI90yh1gc/RuAFwEFvKaxkMWHQJGDssOIxb/X2
	 lqMuJHh6qwUSHHVFts8NCOv5aHG3WT2L3auT5Cx9EFk/KluteLvqlLvEILMYRR3rfbDr+
	 Jqh2CywJtZZoiSk0QP29Ew98hO8r8MyP623LBcHRJ3+uY2NbkLCGmhdlZ8eWHCeFDXSP1
	 hzgXW/RxZIn4kwHAbCxBzN3T6aSNWBHh6sYaiZYnqoRA77o2uWUpGy46GkRbE6s9R9NBE
	 /B/MxkOQgkG+NzLZtY/c7706kuzJsf/50zQBt1plnnCUl38Ye4jjMQdDx5A0vqu/GYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JLImEMh2jmdTGmR3AppLWOEEmaJkCk/wux66wL5OuA8=;
	b=TSLQPe3riBjYJfd/Rgo3lcPK1z7WNZqwVPIdyo1jGdrvbwZRsFRiY/PCQGKcA2D+5paO
	 JnCoG/KK2S9CGdsdyVtcr7NrVOXeUmXIPQG9ErRSM9ZJu0tSSQTy+DrnIX856fc/Jk4IV
	 Dqb2XT3VBi2sgwwfpTuzMPlmKZjNd9EGh0Ql3kywe27NjkASjearypT0wQrlGn89tvS3i
	 85bFa36Q2O2KdcX5yO37NrLcfAafiu5P476Vs/dzlEAVRuflLaRJXUZO7jOahOWIDmhmi
	 Ihu5+0GYCkwGauCMc9QZBI2V9cia5hQUjjnTckYBuAOjRQvo18PwpVakj19ZKEO3fCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TWzLynu6;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E159606A319
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 12:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E159606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TWzLynu6
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b0d126f631so6122407b3.2
        for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792586890; x=1793191690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JLImEMh2jmdTGmR3AppLWOEEmaJkCk/wux66wL5OuA8=;
        b=TWzLynu6MErm73XYM/fyyYTkuBYizVmnQTQ1/4Eg/N+/eEfmudKGYVVzdou76HCti0
         4SjydKA/3KabhH0uUdjh0i2pFwewrla1n9iWv5OunRcU3F/O0dIMD57IqRIqFBfk0pqR
         v8Oy8G6v93SOKKfPYlOsuBEOgvbjAZhvEqVjrM/Oseral/eoEOR+1U0ufPhePTI3fw2G
         ufAOpEuH0FOdNQQfmk35wQvRQMrup8StMaQKEMxNG3qAq8RSJqdA1R9IEhduCAMUL89/
         0g6PDGdI5RYNH5yqPxvw0xKYtU3RdDSyL4v/h9EZ1MmQjw+Xx2+zKQJDtWsm2VepHohD
         yQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792586890; x=1793191690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JLImEMh2jmdTGmR3AppLWOEEmaJkCk/wux66wL5OuA8=;
        b=DC+KXqKdCjfxVS3vGwz+HWFOgn0RDz5TH2k5VlCih0tNHEsIAKsGEKL+ukUN8+KSbs
         tGbu+yGP7SO+8X3EqZcJN5gxfr0Wuwh9VaQb8vfSdbYoQyrQUa0M8btq1vVnEsl7+ay1
         Dxz6Qvv/oNz88oiYnaB0uvFpThhALeTtMoo2EQzQVA/YDfabvfqECpW01NWm+krfT5FT
         OMFZZ0C7DtlsdJhvORGkZCjufL3uRr1t07badxtIdfj/gHrn8rMLJTPKsvQBy66SVdwx
         ekwU6Y5GFVLE+O4g2iA8rIG0mgUQK+8ohp/t1fWuHqMO2jEXqahELEue8GqBE4Osa8Hb
         AANg==
X-Forwarded-Encrypted: i=1; AKwUvByRG3AsXVyH+O3PuKQKzbcFJqyWe0s9PhW9ae6czhnxqjSIUccF1Z8kz0KizhOViFtOpU7mW7i9xn/5eA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKSNIPSL8TmZ4CC/srNZuZ+zqclPOZxDDXQZxSTr67PJbGN07s4
	hIZ0N8fm4Zewx/FsWvOJK5l23mNLrIfxQmGJEXmK74O1VZ73GkjaZwDl
X-Gm-Gg: AYBFou1a3iNOs31qWHx33V3K+uyOuPY2of+HYPm7WVuaazsuVhMATvV6J5eUz3QUpFl
	jIzqgxn/bPiqh8DljBmBu/2dqT6XtTHf564l/cMCMOyId/ydRQEYeYgcCn6FtgT1FM6ptwQMMFN
	/eNS87Mw/gR/cZk6yVU9tWdc13JI+gOQ/Ho8Hr5A3zvH6ZJJ6oQ1jkR76+SwQqvh1FEq+xbMZZW
	ScHkFzpIKsukUNm96eHbgcovQU4Eka5+fG3aU5hyC+PhALh1bIDSO7ZGQsfJhEkdTkQC+g3lSkb
	kKtTlHwQaqQNw6lJL2y0QeCqK09B7Ptwh5I2xRI5eTiSmWXRPCh79dVOIVEgrUj82b8vKoR621o
	uiyo51Rk4QKL1RUBfB2uvN3FlN+Cm1Bh/M4rXcymQZlaMVPy/EB/ciw+9hA7aPzqZsQ3GprujTr
	S1ZEIonO5ENqX9N9iaJZ8WdQkuyelWKnL2JtVfr2EphvDwoTe3MDX9sf/0WhL0NXUZxyIk9Mdf0
	V3LU4DMr8/bLSeVDaHLQccHaO+ke/NpsTuWjOwG4kTI/OwxlsaMyA==
X-Received: by 2002:a05:690c:f83:b0:8a5:b046:e00 with SMTP id 00721157ae682-8b133d190damr9916487b3.27.1792586890066;
        Wed, 21 Oct 2026 05:48:10 -0700 (PDT)
Received: from debian.lan ([172.245.89.240])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b1300e85a3sm10089387b3.25.2026.10.21.05.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:48:09 -0700 (PDT)
From: Maks Ivanov <mi9992828@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: Question about asynchronous blk-mq tag waiting for io_uring
Date: Wed, 21 Oct 2026 15:46:50 +0300
Message-ID: <20261021124651.17398-1-mi9992828@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <956e10db-bcc1-4e6d-a0ce-b5f5fe25354e@kernel.dk>
References: <956e10db-bcc1-4e6d-a0ce-b5f5fe25354e@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thank you for the detailed answers. I'll continue investigating this proble=
m.=0D
=0D
--=0D
Maks Ivanov=0D
