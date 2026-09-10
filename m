Received: from mail-oo2-f34.google.com (mail-oo2-f34.google.com [74.125.231.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C1E3C3C08
	for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073731; cv=none; b=UFnBzyUS9G5+0vx+fyQFjmRhs9LVJv+mMcyV6IUZDIsOn2CTDEm0olzs5M7BsnF4Bdsj8mvWDluFjvsqQ1Nb8qjZbbHpb0y/9DmnvCloKjKFeo1Ri/NS1qOHfonJaGKR1Ucjr5qRJLGJz8DW1oL9dVNnwS7OUegypoc6qpHNQO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073731; c=relaxed/simple;
	bh=Fv3RXwZqn495cmiP5raleJQljDMbicO0SAG8ncGK+vE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=juoBEEes9BWYpORiZfhKsvYC5f9VBW11ndW4KDEzvEgdpA7ZZeCJmm0ssT3wjPvd+chdCuwGs/qwwFb/ysh86+SlFn4zCJH8TD+OgeSbs84xCbowsCPaUHRy68P2Bvcg4h4QDjSyRPc1awj4yQKNPk/pOsRwTdIYhFcPrvOUheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=A8NUqVSN; arc=none smtp.client-ip=74.125.231.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="A8NUqVSN"
Received: by mail-oo2-f34.google.com with SMTP id 46e09a7af769-80032c08611so173403a34.3
        for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 13:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789073727; x=1789678527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ByTA2lPgAWA1USbCn0cljtTYE5VkX9SiQfJb08kxXuo=;
        b=A8NUqVSNyCFkg1me5LtwdgVXWPC4Vi+Bj5Q7ilEHrvaL+3qa/Q3m4l3DQ+pWbQgYq5
         C++tCPxe2VgSxnRA+A7FfBH/fkOGZLqq0v0X7T+X+KB198mdoAdiQKZaMslOAEqIDGLy
         DyfnGhvQ0ndVxJGXhSIunSMNrNjF1n7zUoi8bgRuDaMn+sBrCnMy8f9+c12ZcVxfYRJW
         k29zF8x4TxpVqKFw3JOyNVaUO/N8UzaQKOrzcaK2TuT62WXU6j+geFd3K+G85GreBIt/
         bVxhfudPgDXC5IE7QMUomMyJcYa8qhjl98LFp5wjbLVq6QzIap8cT0kcIJHRazZPRpSb
         Qe5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073727; x=1789678527;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ByTA2lPgAWA1USbCn0cljtTYE5VkX9SiQfJb08kxXuo=;
        b=tM4Aw4OTJjlnIa9xTH3fbTcsioTuHNPJ+7CmLQHU+Bj/7jhQN/HErWYlKGguMNwrDi
         N9wM8UDQ7NOSU+8BLLgVyHq2OqdcJI3+KWUp3Thhqxqdb4j50YV2ah/ZSBLaVCNfvI17
         /OuWXayEAK/iheO6JJpitfeInDrCsVUZ/kV772zyLfHmxoxyTiWmxpDWeu962yW2Nht5
         f6Ag+b/g+iiS4w6SiRSxZaUv5E3ESJGOvDKqCKktrRCZ1DtL5yTkxaK+XgZN4pv/WR+9
         utlFts7/iycO8Fflsnew8R59eFdmUgOxJSmaI54VtPQNWl9gaOEVutgAAJojdOMCLkHk
         vyWQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPZDcU5ztyO6mqttzwKtWGMsDwBmHJxP8Sx/+UDUIv9qpI5BDAOcfuaKa9Kr/6vMcEV5/zQ5y9n8BLAQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kmnRn/SQIbQ3LmpOkpgWuSe6PZ/2Eyqwt4eye9S7xxyHiPBjB+
	azx6bNkhESsr8lI0YN6Npplo4OtbdQK9EsuPtewhKtNFnT6VmQQxrvoxbEFsATRpkKYkheZL7jr
	1nR0U03s=
X-Gm-Gg: AYBFou1k9MOTHJFGyF8iS52nHn8lebe3cBXPr4Gm88ZsWIrfvyqb3bZxjkA9PN5fgjf
	0ur7+MHMJ3NPuadx8pynWsfCB5f30Lb/KJaikA/Ms/wzsq9OvfawJ8hxyGTTd8wVcPEgQSvJdWf
	r5mfG/+woNC/Sn+CwkftOMb5KGhTkNMCGgdQvJhOuoo+kkBrySr72t7ruAjgV0wf6fAujvFkh+Z
	55VpubVVJq9SoaIHHFI48s4WkvDn4Ej4h2HCcAI2LgujQet/uYYWtDsOw/9jMAI6it16M6YMiAO
	ZjY09GRc/SPXoISzuJwgVuJLcO4OmysYUnVfQfWUHeHQawCoudxyBVZ5NrpuBQrPUkIlajQXPw1
	+C6DXxOVyPdaysnVupG8FAGBiAd9VOKWEcGGxRzzH4z0QwwLuDc888D/umPzOOJJs4GUgGJSI40
	S4uCk7auWN5IksqG0CZ8gXDF5FjfhAUThoN+o2eCTywxZgA3aq4MzWxq7pCaTE8lZ1riPwqxfU9
	WyfIc4ja+Lkv2dGgBhm9sYYsdrGc78j37x5MT/WM9DEa6PD190=
X-Received: by 2002:a05:6830:3746:b0:7f4:d16e:45f9 with SMTP id 46e09a7af769-803fd138783mr996256a34.7.1789073726792;
        Thu, 10 Sep 2026 13:55:26 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f60fe54asm635779a34.15.2026.09.10.13.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:55:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kselftest@vger.kernel.org, Mahmoud Nagy Adam <mngyadam@amazon.de>
Cc: Ming Lei <tom.leiming@gmail.com>, Shuah Khan <shuah@kernel.org>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260909132602.68852-2-mngyadam@amazon.de>
References: <20260909132602.68852-2-mngyadam@amazon.de>
Subject: Re: [PATCH] selftests: ublk: install test_common.sh and trace/
 scripts
Message-Id: <178907372584.484803.15302806925021302928.b4-ty@b4>
Date: Thu, 10 Sep 2026 14:55:25 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 09 Sep 2026 15:26:03 +0200, Mahmoud Nagy Adam wrote:
> Every ublk test script sources test_common.sh from its own directory:
> 
>     . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> 
> and test_generic_02/12 additionally run bpftrace against the scripts in
> trace/. Neither test_common.sh nor trace/ is listed in TEST_FILES, so
> "make install" does not copy them into the install directory and every
> ublk test fails when run from there:
> 
> [...]

Applied, thanks!

[1/1] selftests: ublk: install test_common.sh and trace/ scripts
      commit: c4fa55f85c47cd5d54d717fb8170746edb10292e

Best regards,
-- 
Jens Axboe



