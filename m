Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205861;
	b=t34WwY+th/rLJNThfQdZdGndAoNrGkc12AQskjRgOTsnA7LE7NyU5bG/Q1ujANGoDPdl
	 DXsx++NcahslIafeIq3+6tCpceldmtfG+eYlqk0Znk448DoBR/1166ZGJa4AfK42boCWG
	 hZCOKXTFhS9pPU6ekrN7zk2L8B6RxvG7vUvePUcw94UoGm1evcR6qH4GyY1azRL98/Olb
	 Wvg+CKxknI/Rs9qKO78J8Vv3YsrFie+m7TzVBCtMnsgf3IbYqSNECy6VBDSzuNM1L2LiQ
	 4w2RKNTiypFT/s1zovUDEQ6INEV5KxXq64tzqyTkmU8odIrO2K0S8Asvai/CFS0ibIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jcfT8yuOQkfG5cX8hP61MHKOQ6WhKCR1vIxW21dI2Ws=;
	b=rlv3tWOHSlsULwDFkJAhUW8cmkUxLsYxvd78RXoAv3zVz2fXvnTvdm81TpvPwdYyAMDf
	 tpg/naaAYxrYfQjZCtzeb9z8Na31AMg2S0eVV/kTivhkg7NXhyB1AjqE1V1+v2WS2YCnI
	 Gvy6mzKpxh4/5SS33xCDoXPxVsa6hQBGazE2YWBldCEWAUshvhGGpuPCmq/rpvodP3+MI
	 hhWXg3YjJRVqtgHlps0qj59qzlp9QL08wBgAnIwLUKqYRemQy2dTHbyx3uEDmsLdaxV+p
	 2GFSOl3i+J8GHJI3C8KAbE39y1gpyR8byHDD7CNxi8XVjysu5aiKNOQnTF/cn6fapqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="i5luQ/JY";
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45BC606A31A
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D45BC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=i5luQ/JY
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-843cf077f10so1345560a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205859; x=1793810659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jcfT8yuOQkfG5cX8hP61MHKOQ6WhKCR1vIxW21dI2Ws=;
        b=i5luQ/JYGbF5XsdFxeXr8dO1vojZHQAXtBPecRI4kwfX/TFvtN1YY1WdDRlWHu9LME
         bujhWL+6zzJDwo83a3tTz2VvlBg2JqmYJ/iZwFW4V748kBkAe/nSdOs92V1UjJy87EDi
         RJc0fF8UaJ9GsYp4Efz+WcncdyWXkW8mgRI/vKDu/8p+dIbxr+oBm074UEGwpCUbIg3W
         idE/mD6Jx87oo3kP9oH763o0CcSfaIl3rnJzSz7O3xKjHyVg7lQFkzmqle8zk/T+nDy+
         jrvCmGZjI+4jc5pKvhGJ8Ni59pThfVtYk3B69T4ZSDeQS5B7vow+z276wApbz2TwiS5Y
         ORxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205859; x=1793810659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jcfT8yuOQkfG5cX8hP61MHKOQ6WhKCR1vIxW21dI2Ws=;
        b=f0cUCFN++9fZ8o3UbPl0HZR67B1KBuM3OPQfIV6trCGYEN6XvCJueJE2jymz9prTsQ
         SmjYWSq3idkwNHOuK9hvgINfyNScOZ+4RTa5bbxSwDMk4FKg6zqRGiGjxUhrR5EyB9D9
         54hGGsTeDmX9PerSuK8hb9Vie3z7+hKQ2EURSHC+1xJI2ezex1RBahCGDCu0cIIQBY08
         jiIGByKiFRr84/VlwSVlGjpIbdBubS2yqg3CobZqMINWicZxorFcI1kXOoPgYAU43HN6
         i9BxBS5YziD54bZA+bmBYhKMmCRsj0EWD2Kmusk2beiumdfOTkBE2h9DmzsKDl7DHQ9D
         lTUw==
X-Gm-Message-State: AFq9FYJk52uoeN0RY1BqQEnvrQl1dam+RbZhATwJE0rSLB7HIp0Awzt8
	mXPSZhLl60WD7Itk6lx7ByoRPEfB9hj023DvFsfu/ztVAr8EHE1RYlWklF0BVtVm02u4r7i1CtK
	PH7LwbXE=
X-Gm-Gg: AYBFou0ZAqVNvTUNQ3akxSl2X+zAHbff0xLsIKgOg6HWphdPEZq8if+rq7aoJbW9weM
	eTwKjMVAEm13p1FJjBbcl9wblRoE8kWUZWNzeeDrKjyw4R26/VBkvWy/vK+gY+cM9tq2ed5DxjE
	fj/W7yqVj2z6OyEnwb6onGqj+Ziqb83R1aMcZaoGdN6n5T0KhpHaZDn/lvpPDrsXejaNE0X7geh
	Fj69U3huk7CCorZoGhEfxCWeveeLzyCrySe8ljLltbPFfcrtRdLBT2wdfl0ZdAyqhKooxKK9bFF
	jQnv3ndAAKZJpnFJjwkyVZvYNBSbay7GIYr99tbuwpytGshMIygN906QHbdIT00MlY2rkVJBkvR
	WXTGukrgK3MElsJ5QTV1j9z7fV0+LRvtQDJGGtI9nHoJWVjKpbKkVKqdkp6g6Ua1tvz67ANs82g
	85s/27fPqFBdzK6WZH6qiA7XN+LdwLPs6zAZGaU+QA1yqyc8xwpbh6xJCqxY25vUxJvu7rNQnSe
	96v3ynry6cUFSkI5Y9MlHHR1mmfwfM/eKJjXHt7OmcN5DYcUlxqumwim34MzHr55srNu1hjmmJ5
	KR6DGFZPldBiR6EfYVioTCPeKacnUkVIU4I/Vu2BKZLTgJ+DAT1hvSnbSUmOTWKbitvB1teeyw=
	=
X-Received: by 2002:a05:6830:44aa:b0:81c:37e2:2008 with SMTP id 46e09a7af769-85abff435b2mr2884756a34.14.1793205858809;
        Wed, 28 Oct 2026 09:44:18 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.17
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Subject: [PATCHSET 0/98] Various block related fixes
Date: Wed, 28 Oct 2026 10:41:03 -0600
Message-ID: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Got a giant pile of stuff dumped on me, and went through and did some
vetting and, particularly, commit message rewriting to get it to a
somewhat comprehensible shape. If you're CC'ed on a patch, please
review it. Feel free to queue it up, or reply back why the particular
patch is garbage, if it is garbage.

Thanks!

-- 
Jens Axboe

