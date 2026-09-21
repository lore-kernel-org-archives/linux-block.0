Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1749B47F
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790008369; cv=none; b=eVQWdjUwq31W6IPm4oL1qriQyxNE3Z3k+/IuI9jDd3Dsylo30/eu+9wK97asK777jbtUM1lIqqDVidduWtpd7GGZ0BhfSBgk0fgbxmgEiDVi4Q/igd+DEp7Gn/rfh5eBEyVq3tpoBCjdakzVUyuztLxzUZOlJW+ErRDeOjAEBHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790008369; c=relaxed/simple;
	bh=N9Nz05Be5ukSvo8DN5d10l8stTAeb9nFpPYkm8hLyIc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aWlVOVo1xGyCnAFuQGtaPHHZpPTOKXnHpms8Tnk2TmmH4Cf266Q7UFh4EIIVbWPX6Y/VIAZLDQl+z3UjtIPkTI/Uc9fEZy81IhkWP24gJECtLrsDWQU9D78Xa5s41tQnkcNFUs6QYhaGoeLB9pEIKa7u+enSIJEdU5AUn8JiVX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=fX7QOJqE; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="fX7QOJqE"
Received: by mail-oo2-f40.google.com with SMTP id 006d021491bc7-6b1ae7089c0so1537491eaf.0
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 09:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790008366; x=1790613166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rvp+JFs7UGjn1/fZUHqD5pglAyJFEHKXVcUO8JhHKd8=;
        b=fX7QOJqEz9e7QVh9ZHKlZcnJlk3AeNnZP8NYZ4oL6FAJ4Ntgq19yo/fDGBKbMt1c3+
         N1GNvKPtE+JLRN1SzPOJmCvMbuBTeYW/AH5xB+uETSS3x7zOepRDwftvcfHpCilaN/FN
         A6tdf8TnCdVb0rckfQKXm8v6vk/uzQ7Lm2vOLQvPI0rWkxLO+YSzr/dXQuGozSVC7fr6
         nM69HC13Jr411L6LosawzE+YhcftLlDOnsY2ZsW8ClR3vSdwKB/Of6G2HulKpbk+1liB
         wzqyzfaavBbYdFlXkjlZOIJDw6UpU9Z56CymXfaxkVe2/cSZrOc+VRmEszk3bAhezGG/
         1q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790008366; x=1790613166;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rvp+JFs7UGjn1/fZUHqD5pglAyJFEHKXVcUO8JhHKd8=;
        b=h3+UFnuV0tHTl4QIMxFmUToUj2PEEPeJAguhuDc083jnsJq59kpqfA0j8VRtrQLi3+
         fI6BdxJ3nXtuM0AVVN+7bnsXl99OBnWut57J88G8lqvpiuaVPKQc/WRaYcSy64vSgz14
         OmAWCW5zhrItxmVL5Qjp/rXs8nARuhKVKGSWyapcXbeiK6HA18pU6dz+FfxgmnXkKK8R
         c2iCWZ3N0eiG0JZI6tSz0WwobEAOwJJ0WICXE8w3jmKZdiP+3X62Pa/5IBjKF8qSadz2
         JjZMtu19zRwoxT6NXldlYISPJLtNJvJEOpkqbAb8ZINrOMCXMwZDxi8ap84KvJTFD/Ao
         3/3A==
X-Forwarded-Encrypted: i=1; AKwUvBxUUYwkrJHaAQqLyoqmcT77GE1O1XBFhdFugRzT2JoEpHA983CE+nA1oM5Evoj8px5Mc87KuUiAcCx9NA==@vger.kernel.org
X-Gm-Message-State: AFuF++nl7rB5Iz5kFvBrE8MWizASdimDve9wuVZyA52As2PrqVwmvMOp
	SCAqnp7cSMBDdL18gp+0t8+Jxv83bb+P51H2W9XgStmG2H+/F6pP6Bpbsu8ADmgGPIA=
X-Gm-Gg: AYBFou0mUidxwZEDFUh+8T3/ev5hqtoIsfP8mBapqVWDj3yXwnGrEqQ7na6Pur66vrv
	DWXM7UTuND7qv0m0ZG8eYP+X5w+dIcddZaTT1BrDAddK80vCbqUkbK/i7oLADzwDxlsMTMWiBCp
	z7M1KxoahSKu/ceX2tfmypp09GagFVXIZw564cZuxr39vPNwUDZoPebsLQauL2YhodzlrB3A4ny
	o998eU0rdNv2GkbfYNxqu9OYnjxK3h5j07hPWSiTjp242MyopHu6Njcu7jOOeFXl+TgnbPbk4R6
	2iiUWWdKHQl8xskUTZYybehf1OowtXoUGeDyL6tlImAdP2w6QJLM+9AUwFsxNy+XnDoTEbQUUVz
	KtwygqCp85dNmZATn+SsHaQCqtHY0KN/SveRdQ44IXoLepvXqSFvx+zp/EQyGrrRxFBLhUFYyLF
	uaNRU450+uGwjlfXuofNL3m3nH4FED/+UxSXtB2hE/glzZGivEXk6i/lhpQxHC/gfrNnxaRPx9Q
	3KamTValPd6+UXCxtLN3S8=
X-Received: by 2002:a05:6820:f010:b0:6c2:21ab:ec92 with SMTP id 006d021491bc7-6ca9ae3eb40mr10131077eaf.30.1790008366114;
        Mon, 21 Sep 2026 09:32:46 -0700 (PDT)
Received: from [127.0.0.1] ([99.196.129.128])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d142be4e98sm445928eaf.2.2026.09.21.09.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 09:32:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Shuah Khan <shuah@kernel.org>, Dirk Gouders <dirk@gouders.net>
Cc: Ming Lei <ming.lei@redhat.com>, 
 Linux Kernel <linux-kernel@vger.kernel.org>, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20260914110145.41627-2-dirk@gouders.net>
References: <20260914110145.41627-2-dirk@gouders.net>
Subject: Re: [PATCH] selftests: ublk: fix unused_result error
Message-Id: <179000835839.1960768.1435257617416448183.b4-ty@b4>
Date: Mon, 21 Sep 2026 10:32:38 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 14 Sep 2026 13:01:09 +0200, Dirk Gouders wrote:
> Commit 166b476b8dee (selftests/ublk: add shared memory zero-copy
> support in kublk, 2026-03-31) introduced a write(2), ignoring its
> return value and thus causing an error, when building.
> 
> Fix this by using the common workaround "(void)!" to trick the
> compiler the result is being used.
> 
> [...]

Applied, thanks!

[1/1] selftests: ublk: fix unused_result error
      commit: 687cb38c4330d52d58dbf426a3eb523850052d10

Best regards,
-- 
Jens Axboe



