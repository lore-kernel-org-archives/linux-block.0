Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804852;
	b=u3Radugrgk2JnS8v96zGWIChf0lMpIgA+lSgXZYbuQiGv5AJhB2873yzUUU21F4pdgE8
	 0Sr9r1r7M+DHtOi4IOfLy4gNIt1XYvEQfDmY8TEEU/9jCCyM+jGlIqFtMjd2en6fCa1oX
	 mj7CpN+noafibq4BxpYsTPvn8yssX7PisYXTmY08H+N/sBxA2c3Ph4CQC1Ehwqb5LJQYp
	 1TZaMxm8mKutm9/wimXqLHCBCyoCw/vr7bbchwHwWATw5f5RB/X3cbPhBnRcyXfepf2zy
	 tx5jxD+k8wxmlZSIC8PAsdDULgd7gxrIrsEkHwHGoKPpIm4io4PQN3eN1n0l/GGPvJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=SRwwF7d6JKQ+7rZ7FwUD8U4JtRdsbauXUbAizZTDQkg=;
	b=d3eDnsmbwKJ8wG9r4R8HLpnaXJVEwvpKPyiWlSRr+9kQ2iLFui7v8MdBruZH3x9Y95k7
	 WIiMzPKaFiFsvVrG5A8Ex3w9QsnOsPRhusJgZCaJqr//bN/nyGe7l3o59J3+cdU0p75Ln
	 jzozi4aBiFWCS6Pgo2BQm6DpHFVcSnh4MH6SfDK70M+s5GWfeGAYT6ppQejTesiK5gRO3
	 6nKfmYCzO+XnzZaxqUjjeZyDuE7PZbNwEISFIzWbuC0faVgfHGqd5c08VjcQn0wrxm0IX
	 P/zEuNTVkfRsMjP2LF844LQIwqfm0ywWmcTtpJUyFkP4NZZnWWdeAcQgalruwlJiR6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6FB606D803
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 15:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA6FB606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-70b875f6f13so743575eaf.0
        for <linux-block@vger.kernel.org>; Wed, 04 Nov 2026 07:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793804850; x=1794409650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SRwwF7d6JKQ+7rZ7FwUD8U4JtRdsbauXUbAizZTDQkg=;
        b=iaPSO7ylhtk6kcT1szhbnRBx/7YenRZ2KsqsxdHayRL5Vz46gvSXYRaeg7gflqS6pu
         l11ScjSb8DAMDgP/ohO2M4OIGNXebt0EZL8kwwCzzvNFJbOkFBcA8SXIpF0WxV1s/way
         I5YO3i1tPWzqyR4Oy/2YxxEdtcn+o5sek0iIrFbhGuC+9qtiSM2A6a892R+N4dUE4MIr
         eMTLWEza1A/aNqm+XpJBr6XdL2MaALHkp9Avi4ptspwk20uHIgo7JCQRKZTHO9a1QKii
         MtYUcL2RtxZi3Zo2tedy2Gl9HULVFyt9nyW5u2/Qwovq+xhJC209skaa4pwwfA1F1V1e
         dWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804850; x=1794409650;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SRwwF7d6JKQ+7rZ7FwUD8U4JtRdsbauXUbAizZTDQkg=;
        b=i6n9VnRg+iQO37atMNX3q5dxiJLsapSnGrcOHg6p9SBYL1+9UIlMamCCQ0We9+/pf/
         vDSZOZh1NsP5oZkvSmjcyTqIea/sB9CuqAmAtiAQh9fYCx7f7f0H5dF3GggWBxs9zJ1O
         s+kOqrWWIoAPaaPiLTkNrASt4yKaYr5un4gW5OXEs0imWx04Rdo3Ay/FjT0aec01kNN5
         kkygYCsknCbLd35QQ/zCC0PqxufdH/PdF6zx4pdefkZEVZ6g39nFun3O/d6VVkjKo6Pc
         4CP9RvcSMLILTrXtp/BnGxMgcXmgFc84//lBiZ+HhbXT1HK1YRE65dFnsNufNqEo5/VG
         JOjQ==
X-Forwarded-Encrypted: i=1; AKwUvByuQlDGMWoJqoFx81bxl74RtlVMN2zsd1+FHxX05ZQCEOago8rQdFHRB+RRPf1r4wYlPDjg/oxqYEhX2A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/kVaaTMDh7zB/lGVD98p1B/tIPk4IOx+kWCZlGTF8s7Uzi4n7p
	LC7YT60u6q7aXX8rl6iOhnEpjP6qQc6Afz1oeoJauU5+wo2ZoZDs/0BWUude6xoWreIImRrJ1L4
	E7OgliW0=
X-Gm-Gg: AYBFou2K5nD7WNNipHtnk6WnbFPoSftdO9H0KUL7YOQxiPMkCI3JlG1tO6NjOcKFs/5
	Cvy1/lIia/IkukH4eNYo8h2DpEKzPK7L5VGUFNclwEGifwOGdTF8RV8Ihk5GkAyvM87cplRmt9y
	UYDyHsOi8hm83WrQP6pR3rBVMgaqaMvYFaUYTB0L1hW3dWsCCI5oNhZBTT7gePXzfIBZivmkA7D
	ux6xet3ypuIujW/ZhdMmi06sElEaBqpOHbStOyhOmFAg2rbXN+vygp7R2IXplheR+W7yPWHfiN1
	5pn/gRt9sCICaA0WwfLeLEbx0tRNxsZcQaQaZtK+ivL0M2SqRoLoIB+mVbYewS+q52jAgilQvtv
	+/DuBSS2nHIsncUU9OZoxog8wA163tuElDBmUZgB1tkfyH/nN7WL1Z+07BMLqwqJNK2YKV/QRtZ
	jF+VZG5d1Dmds6GW4JBQOs+/8myu8iiutnhVOJjDJC9CYQDL8mpH98d9M+ni8AGmjg7HXhTHRZD
	CtXGiPvaz0qa7q75jthpuJnpbMjCJV18vyt6o+VT+CiWMC0/smBKG1/kSk7kxmrpZ6uF7o4iPnS
	pQwZdYQSlcm2Eb1TggfpVtL4wpNrOYTmifZCcS1tSltnlkefGXI1uQCF2kFcW3bIlYgG4Mc=
X-Received: by 2002:a05:6820:169f:b0:6dd:4f30:258f with SMTP id 006d021491bc7-714f253a484mr9672440eaf.56.1793804849653;
        Wed, 04 Nov 2026 07:07:29 -0800 (PST)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716c0cdb22dsm1886033eaf.0.2026.11.04.07.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:07:29 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>, Sasha Levin <sashal@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261103163928.641519-1-sashal@kernel.org>
References: <20261103163928.641519-1-sashal@kernel.org>
Subject: Re: [PATCH] selftests: ublk: fix the build and file offsets on
 32-bit
Message-Id: <179380484851.4021488.1650834850006214841.b4-ty@b4>
Date: Wed, 04 Nov 2026 08:07:28 -0700
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


On Tue, 03 Nov 2026 11:39:28 -0500, Sasha Levin wrote:
> kublk puts pointers into 64-bit UAPI and SQE fields with a plain (__u64)
> cast. ublk builds with -Werror, so it fails to build on 32-bit
> architectures:
> 
>   batch.c:379:42: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
> 
> Cast through uintptr_t. kublk also passes 64-bit user copy offsets,
> which start at UBLKSRV_IO_BUF_OFFSET (2 GB), to pread() and pwrite(),
> and with glibc those are truncated to a 32-bit off_t there. Build with
> -D_FILE_OFFSET_BITS=64 as well.
> 
> [...]

Applied, thanks!

[1/1] selftests: ublk: fix the build and file offsets on 32-bit
      commit: 3197517875fdcfae1e9b5a4dcaf35cbbd66c413c

Best regards,
-- 
Jens Axboe



