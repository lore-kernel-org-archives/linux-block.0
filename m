Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2FE18BC3B
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 02:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786846002; cv=none; b=SLZuMH9oQ5jSjqh7046RfXZGU5AsAPmF/trSsLWajqvynzWcnuBeM2Ql6AmGa1P83XHQastwcmWBTCeOHm5n8q4hW9j1xpTpQvUhqP5m9GHVpmii6f1n16GuZ4jFk+QgwwjtTcjkzBvpGC2yuMloWriJYMFGYU4gZNcyJlGA0IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786846002; c=relaxed/simple;
	bh=lZfxHpFBdWa1iLbzHA25AIy2MET5BfNuJPZ9Tl9kvWc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m28Dj6YpPN+HvwfDbW16fYWVpZk7Gp24PK71kf37/g8yzeU3rN+6p2p68B9q4P9C/PVVMyg4ExFMKjdzBRn4F9L412HykcGcx9wyr+Ycn0+iEZ2kY7//XOJhoskMoo76HnnarACxptAgewcYmb2Pqt/7EiwMLrGDKB4kNQP9y7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=HvJ/xxa4; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="HvJ/xxa4"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-451a49abd8aso1503223fac.3
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 19:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786845999; x=1787450799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I9P8vip1vNBFbupp9TxQonKy9AWwrPAT4+ukh9ygonw=;
        b=HvJ/xxa4qCLjeP2rmXBa/I9DaFrhByPi4R+jtSgsr5dWfcjjYnaw89D+l4NtBw2/Dz
         1z24XbOOfpEFB8XEuyZSDtDcIYTa5uyKr/YpvVNRY2DBDargP5CrV3+aUH63ymvlUoO4
         S10D7FJSiaMs6k2XaMS2wE2RQkjmf0Lr3IU57943PEEWKAOSodrJyE9hqxHms3hFeOJN
         akgIDfSyBoI6YAXANxSGftdflnTkKSquC9nnJDefnEbADAPY1zcedqP6xsXVe66cWYrU
         IArnlJ+hwBXBsmmXhJtLOg1qVzGLK1UobockBfPVlcxWSey0xjH/zEChxXJzSw9FWaEi
         SodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786845999; x=1787450799;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I9P8vip1vNBFbupp9TxQonKy9AWwrPAT4+ukh9ygonw=;
        b=PfyTMvqJL8/Pq5n2BAyECm7wEOaujUbsIKd9Q0yHWHrniWIT/xTsjSoy0GjyAmOhVl
         1AD81uTdT27K/mvFDPAWWqYj2EUdDV5ltZ8uiVzD+UzEH6zArK68k8vwFAqi0VzpyOsJ
         TB3bfsIzLQfEYUYeZDA4tYJcNu+suseOuT1XzTv2Cy/UTactoMb2B+JOtlRITJ/CdEa/
         RoxilpeZ41FCZ9m5UXIRGV3K0rqQe32sQg9tFfg9wsULs0D6Jn8oTHAijYousmJFy3Oo
         S9Y3kZMu9TGKLPTHmg5HKRN8k4Q4ipuQ3n8gt8vNGP9q2aQVd4FzaYCmvGG+CIc6S8U/
         BCAA==
X-Gm-Message-State: AOJu0YwuDKoX7EOoyyUFli+XM+ikx5b9MbrvZIDc+Cc6NQVph1nrAvzc
	rwh7NaSJQXyb1SSmcA+leOfgtKKt/84Yh6CytZoN368agTj7u9Rlf3yewlfaOoz2M/A=
X-Gm-Gg: AR+sD13qru0aZ7lNPbGnqDl9m0NekAWx5vMqYHHLIwL8Vutd5QlKqJd4C36wWsjaZp+
	L2gDe3+QhDBXjW9B9DeMpvl9vSWa56TPff1c9ag0LB4ews4PV1ov3LBSAPWG6wXK6wMWjIcDanC
	QSFJWpXCTt4RXwT6IlyCyPGW6UAYikglHfj37z+4euiiqQ4UPTaZ6gwu/Cu/QBqWegpp1FwoiTn
	Aj65py22+wkrEdHOAGXiyB+79Aikn2J4b36tvxNPaG5w01rqmKpa5hzShaInmMbJgK58Is66QTL
	SvYE+rl8ncA0Id+jKYB6N7xqiASDesPFv0Ywpw+Ox0wvWZ2aS3wsqvJKUsjUUe641T47D2hrzHG
	eKlvCCAoYqHBTX0k0wKjiVb8kdr6mN44SYwJ7yulhh3fezQTCIJ24dOQl/fQVnhNepMi8Ey9rC0
	3Q0SxB0J7A05DT09xE4/plDEc7hieSRexj/3KMMNz+LSBPH4fqS2rrXFfhUxWJUVTFKPw5w1fex
	h1yBaM0ItptD5od+Ria3cp7Sn6AE4DNRSNieKNk6A==
X-Received: by 2002:a05:6820:1614:b0:6b0:ab1f:ec0c with SMTP id 006d021491bc7-6b0d6959804mr14536936eaf.34.1786845998981;
        Sat, 15 Aug 2026 19:06:38 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0db1e9f89sm5686279eaf.9.2026.08.15.19.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 19:06:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Zqiang <qiang.zhang@linux.dev>, 
 "Paul E . McKenney" <paulmck@kernel.org>
In-Reply-To: <20260812060510.3220294-1-m.szyprowski@samsung.com>
References: <20260812060510.3220294-1-m.szyprowski@samsung.com>
Subject: Re: [PATCH] blk-mq: add missing call to srcu_barrier() in
 blk_mq_free_tag_set()
Message-Id: <178684599676.2049660.7519009311232353360.b4-ty@b4>
Date: Sat, 15 Aug 2026 20:06:36 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 12 Aug 2026 08:05:08 +0200, Marek Szyprowski wrote:
> Commit 05c3e88488ed ("srcu: Queue sdp->work when the delay timer is
> successfully deleted") added a check in cleanup_srcu_struct() if the
> call to srcu_barrier() has been made before calling it, which
> revealed a missing call to srcu_barrier() before calling
> cleanup_srcu_struct(set->srcu). Fix this.
> 
> 
> [...]

Applied, thanks!

[1/1] blk-mq: add missing call to srcu_barrier() in blk_mq_free_tag_set()
      commit: 1207dbb91c111e2422e94b2e75091367369e6476

Best regards,
-- 
Jens Axboe



