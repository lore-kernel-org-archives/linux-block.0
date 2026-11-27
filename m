Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795740641;
	b=nV5ZVX9h9TCpUB5pTnJAbdbzRUoXXWUU2obm1V+fU2wHuNgsNWaGRIb8SiJVYagYJypu
	 U0FDZGWoTiI3MgH3RDzqlLjUTABNomrgQgfFLLNowAWlvmymtSxxfaGIrouKp2R9JBsP3
	 QPowQhQfQpOamqFGJtBhNQxichZWU9no2XFK+kciHpT47IExeNKOQN7DwHpApo1rb7wFi
	 UtHKA4yb6LffBx0f/CCVQHNVbz1A7gbhUBQZBYiyTZz4MopuubacQ1q8Hl9qP2jO/Y/g8
	 xRx0UHpccLwqEYucbpwYKAVpZiOsgtsR3AHxwoQXdZBJdJU+F8D/tW1IY4aBld2Ohvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795740641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References;
	bh=x0Mp5Txn9dhWnd7kNaeyrGhDTXOo7utFqS5hhFOq2io=;
	b=W8HvTL5iesJJSfY9m7XUavEiOl4M+jBdy93fvlRVC7+TlV/GIgE22MfX1WDeoqto2siQ
	 Zwp2YGUnM9Et1DS2okhL/WQps1omoRFzIk5Bb+sOgjnyAHVzINuuRhFmmim88LzfL4ib8
	 c2N2KoVO+/J1Z3k7gTR/2kborxcA7S9hdB2we5OFOlvliuJ9uNPLKVO44h3QxhALkm87s
	 Y6n+i5+bXh6nHS27OLHklTy5qPUXlJT8tfaoSc99dwOfGBIMfe5Agl7rljeNlfuMQvIqS
	 INAbaI1nRrpml5qufcM79yBhPSbR/BgsUVyEfOKnvR/m5OVKpipgY949ccc9A1EZNVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K1tEEi0C;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5226E606A323
	for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 00:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5226E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K1tEEi0C
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9495e8ae239so828169285a.2
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 16:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795740640; x=1796345440; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=x0Mp5Txn9dhWnd7kNaeyrGhDTXOo7utFqS5hhFOq2io=;
        b=K1tEEi0CKdL//6rYPHcqQGCm7O0J2ly60eWlW+M9HTfuVDK6FL91RNDcDxOxAxtiTp
         oI7sUzz6QMfcVvFq4csJ6S083G2fdGSO+96r+9wFfux6cu46po3ovanEv6MSYhrNRPuh
         IQRkruV5OXzzvS8TSq91jU/dMUZz4WKqyxCeQSHwpqqP2n004NI2x8HjUvKRpMdohSJp
         LKJFj1bPEwjjKwdlmGJ5cwFR20a2FvFJ29hffy5GBV619FNLpZmc+rU9hunaxkLwu96q
         tJfPopPK/Hbxyq1qO4pmcgcT6uFv67XSRGyn7viNKf9DaddfZHEz+68SomD6h69VsuMX
         axBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795740640; x=1796345440;
        h=references:in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x0Mp5Txn9dhWnd7kNaeyrGhDTXOo7utFqS5hhFOq2io=;
        b=yxOS3fzpBQ/8d6ZK+5wDzKgyE6GGeSx545chyBjg011VurYZpTNqm9zInEt4ldIxjb
         /xH44098QkRW4roqbUJVuQJthA8iPmGL4aCFUaBfaBS8yzV6zvX2wF1R7lHd8OtUMCEw
         cb8GUpD4YWA9GDI5p70iOJZcAWSGyfgdhln2WcEvmJaC3jd5fHVDb1VJcsDE/TWs1d23
         E7WoSYhJuJzwJ6Vd8uvL7WE6GEV4xikTwiyopUqTPl+zdKy8/XOYvupw872jmUK75I4Y
         6EKBOmUZ0Vjxu3omUcfonutzeS0q1bXjEP7Zf7crw6jPOqyqV4Zi0XsVpK3sbMRy8A9g
         5oBA==
X-Forwarded-Encrypted: i=1; AL+hErHgMvRlCADu2Ls0IHFA2q6Mm+IS2+wYEI9JqbM1DZAuDrH2V1ngYn/t0XoqDVqn5tdIEDE4d6Piywe+xg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+HVyrclcuECy6AbE2lw5LaGIC4gQwnsOCuYPV8SwQ+mk+LHcTw
	6mFRduSgUEfo/pdY71Cbj8geUGAy0oMEFKCTHw50wOtPRl39vv6ZFqmy
X-Gm-Gg: AZFdTZf9BGj9+Abv/5lqbVpKrYqQyOsr5QE6oy1mDyhSJT5HufD4x7eD1VS1SAGP29E
	HPnAb/W9x6G8bohxOJEL+4gbIPTIlVJz8LE3XqmAPxCKkrSVK1GzxvmSlzzsLDuIhxHBN2JWl9G
	w5Wd2fgLpaighaD03yMMvgSQGhsB79bofcL75pCXW2l/5RtOo7o2kqy9J/SjJowQ7Uv+m1RGWg9
	szKYLrvgAV4H4LUN7/HaKX2OqZu+RhF1PYNNXUpuKZMR+ItKAOZ8fLBFHz2dO+PjNNQTfYIZMT6
	tzBulvys7+seVA+UocVwTTgcH/kqTNBIxKypDCT9/a9Dg2SxxCE/z0zTOjXUHcKlJm42JGUqcta
	ey363A9aq9Zbr0XYjDYIh0V/ZY2xGk+weuy58mjPU8v9otclg9eBaew7bsztAkJYRNUrUpZelvo
	3A90uqohEh5Aasv+Ybshu/DQ/VoSw7v/MREC0w0Z2wtkJ72uMa9C3kEWcrU0IneJtNxJPcJ1qXY
	aeAgX1Iq23VnximKAe/TT1wcoxyjquhbLJ5CZ0swRasq7SPtUpE2CWRwE52RLBreK2XRzflP39i
	KQNsxLaWmRaKYH5NC0GK2l9Dj0CVCraDQ+7zRQJRBoha49mqubYAHHfQUTCu74JY+aq23sgeRzM
	hJsvxGCpcFe3RhNA1CRe4mIKjgQ==
X-Received: by 2002:a05:620a:2907:b0:949:72c3:dee6 with SMTP id af79cd13be357-949ba99cbf7mr4043850085a.19.1795740640134;
        Thu, 26 Nov 2026 16:50:40 -0800 (PST)
Received: from localhost ([138.197.109.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb34ac11sm1703987985a.14.2026.11.26.16.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 16:50:39 -0800 (PST)
Date: Fri, 27 Nov 2026 03:50:37 +0300
Message-ID: <a424da14ad9f0fcda6988f558432d10e.ndokutovich@gmail.com>
From: Nikolai Dokutovich <ndokutovich@gmail.com>
To: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH] fs: tolerate an unfrozen superblock in the
 block-layer thaw
In-Reply-To: <20261127003902.48-1-ndokutovich@gmail.com>
References: <20261127003902.48-1-ndokutovich@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list

Please disregard this patch.  The same issue is already fixed by the
"super: fixes for freezing, reconfiguration and error reporting" series
([PATCH 09/15] fs: don't keep a device frozen when its freeze is already
gone), which I missed when preparing this.  Sorry for the noise.

Thanks,
Nikolai Dokutovich
