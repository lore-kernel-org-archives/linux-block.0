Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779684B0497
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 00:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838516; cv=none; b=HJNjxOO10qbQZuiEz0MejayZkBxOGMs4CadjW0zahH3cZI49p541XjO1qBJtPpi1GeCIpmYj19E3a5RBxHM2vqRe0GH0bBS2MhjyIM4hwOhFWdxnEIgDlTCJydmy77Jlodj2FkoUAsLlJCD3C7ugbfBVxkIvUd6lyluMiTmliQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838516; c=relaxed/simple;
	bh=KkIIh3Gy06ZWmcGkGDPpWGEZAmptUeswpqMjODNUuwI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nEU0+83gzj9yfE+VpKh680ujQ4a72cwvYSk1icB1eERVGQK02pTMS5JMvCWIqApptNnyO552FonIfz7lz52nhyiHiMEKztc7Un21WKbxat3o1wl6XpcWZVr7t2Zyfp+ShtIv8dAw5jaAM270wJoCDIx7YcLSrf4MG2pcdozXRYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=opKuAMqR; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="opKuAMqR"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-459281bc13bso1278044fac.2
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 17:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786838513; x=1787443313; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h0FexaWUBsDw3cNB0e21gRGoa4vKhJmVeg6SJqupLj8=;
        b=opKuAMqRYJ6lt/LYmHduBVzPo9MCiyPlY8CwjluhR24VplxunxDw7M1GqHoMvROQpe
         C6f3uKjHozcmiIQfpGZd1dT3iqaZXrtsHw6wW8hoJolCG9UteGPN2f7anKe3eyJYDJRx
         6UgIOKeqzadcjudeDlmrShoTxVq6m0OgqB2SuVXFrzUkYjwBhWj+y0utU1zprUP3c8vs
         yMOmAzG7xtSS8aUGfqT8YfLYzcAJAk+bRAilFOVN9zQ8XbRewi8tZ7AUwB8RkaW0b5gz
         Aoxmsbtz9jjGiQ/7ub0DOxYMzSn5RNkQ7QOxoOzqhBg1P+kmr3Uhkun6+CZXmY48u1Ro
         iAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786838513; x=1787443313;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h0FexaWUBsDw3cNB0e21gRGoa4vKhJmVeg6SJqupLj8=;
        b=sXFmOg953NTm+MUSgkZv5DkQdF4IjYCJi8G6XljUUWqd0ZmRdXKNpXfwOgCRIYMzR5
         f/WWiXCEyemSJ15nSYqLAUPnKJk9yqoi2oPdWcJK+OhFBy6UfobsYE4/uH7dr1k6j66t
         2meS1d62aGBGy6skjCwBLJhPXYWrNQs8RTHMHnCwRZSqWYtQAxMnaW0qgqY9E0j3Ex8a
         b6VBxNSP9KLtToql5zaVFxTWfgqUvkET28LXdZWT3su2suLIzfyd60ZtOVyavUUhERzh
         dLDX8CgCNTjTivcVi93lptaY2ZkDuloPLvVbzUAUZ3LAPg4jIXUlAPAWeqxZtTUolUZ7
         JZXQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYN+w9OfNVxwUwIqtteEv43Yv74ynKOhDME4Wo7+iAa5iYUQzsQ2/TkdnasiLwGoSHiPclq70eLKEDCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmqBNZj1xykPzD7cf1RL/FrCP8OZ6HGbDPXHorCXm/NJz8htay
	DO+5xKgv2JmgRgEQGvDKCFnUr6fMEmih6aqrRSDoT9ok9o/q/uogC7ArycmFnKVJszM=
X-Gm-Gg: AR+sD11vDV5TLAXmtn3Ha934mWEcLTfyp0ntGFAQ49waa1kuJZItfB1zUeHk/n0D7Ou
	1b3TNNCcg5BFJSBrTPkcsY5WmLBkXCmo3ddgmhAI5ymKYuwkuVyO2wuI/Ta+FGFXhshl5AON9CO
	LWQhq1s6WSKVI4E3cg4bLNJNhMkn/zzb6citXVTCnwAu0eXauJ0dArIZlKSA8hUMKy17v3CUt4u
	mQMld+/ZNxF9lhopmNKTOiDP8KHaXg+tjarRYL2s2x9kmZsr79Bc8mtgKS4lVwgqFNtC+aSWSmJ
	dwwQjMQo2r5ZR1rMW/zhIT31J8QnJ73cQZcmcBYyhPHuKFsuhU3zyl982lnQHzmcdS8feRfixsB
	MO5l0X8beafQnpFVhhnxPUBcEuQvaTa3blhcQN70A3WJRsSVSklhEGZTRkaIE+bH0L6P4zIE/gi
	FpVPUu+9z/bC5XSAvWCGg6zO9PzOGySWUa53N6x+EdpKHxmz9q4XHIonrL54Snngmi66LbzcxiW
	ZefrG5PmH5ehsoRo5visMo54iaapptPdDNF6+pdVQ==
X-Received: by 2002:a05:6808:1a0e:b0:4a4:88ab:126f with SMTP id 5614622812f47-4b241e719c5mr13542789b6e.21.1786838513428;
        Sat, 15 Aug 2026 17:01:53 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b24d92462dsm4347729b6e.5.2026.08.15.17.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 17:01:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>, Yao Sang <sangyao@kylinos.cn>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org
In-Reply-To: <20260814023226.354288-1-sangyao@kylinos.cn>
References: <20260814023226.354288-1-sangyao@kylinos.cn>
Subject: Re: [PATCH 0/3] ublk: validate zoned SET_PARAMS earlier
Message-Id: <178683850862.1984298.8753344739278946673.b4-ty@b4>
Date: Sat, 15 Aug 2026 18:01:48 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 14 Aug 2026 10:32:23 +0800, Yao Sang wrote:
> UBLK_F_ZONED uses params.basic.chunk_sectors as zone size. ublk also
> uses it to calculate number of zones with ilog2().
> 
> Before this series, SET_PARAMS can accept non-power-of-2 zone size.
> Then the device fails later when it is started. Reject it in SET_PARAMS
> and add one selftest for this kind of parameter checks.
> 
> [...]

Applied, thanks!

[1/3] ublk: reject non-power-of-2 zone sizes in SET_PARAMS
      commit: 2707acf1856da266139986c9398ad722fd4f48c0
[2/3] selftests: ublk: add helper for SET_PARAMS
      commit: 176f02a86c0384df4ba175e319321b07089a8016
[3/3] selftests: ublk: add SET_PARAMS validation test
      commit: 007af5e5cc822aed3a0909534ffb810f7816ed1f

Best regards,
-- 
Jens Axboe



