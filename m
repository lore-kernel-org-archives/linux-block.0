Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8279349AE1
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982189; cv=none; b=RHbNMUSvKD9SO47nrWP48m90O2/ZUglij6iJz0veVmvgDysurecmyd+IHlbGQ+MOl4ZOEl6TLrIBcWjZpxjIKycpGZTLeyLXdSzhlYMxl1oHQZbiJVMtC9KiOPU5ZYM1Ompo9u5gfOvefNJv7jxCf/8hiah+9LGWYdtv0C6wBqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982189; c=relaxed/simple;
	bh=94ycW3lgyjdSORnztV6EHe59jRLi4KhAVL3am8BaQ+0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Md2pfgqGAwOwpggDfm7Mn9D/NZucPZOMbUP3MtUNkmTjXULGVBpxHRDP5Sv1moB2hM4MCyuMmiKGNznwTwQmLRgeitJUDX/7hDDTvrwn210t6N6igt7nn0howLF6lPHwm8bweOLhyaZ4UJCULuGIOm9luHApMqVZlhasZR5z0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Eckikt03; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Eckikt03"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3e12fd71984so4369769fac.2
        for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 06:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765982181; x=1766586981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ld6T8UtWouDR3xKdn1TrtGxRAlGZmoqNloVepqhEues=;
        b=Eckikt03DpREGa7a2kyvI0Gr8Ynn1TZERqKAHFlkmDP3gRwvszuVwLoM2G2P+dae3G
         vCnnoUFwVmjp0fMEasy0JVdIxQ6IYlgBbvTgYlw2c8XtUdgH4cN4yzfghoGne4Yt5cHV
         Ev+n6ic9eIMRvNKcggHxXAZ0P97B+sE0NSPBhcl7q+1EvZfBAD5ANCkSbsQB9UdQ4afO
         7vuWLoJ6cHmFxW6FRutyOUgXCFDoyq6D+aAfb+kGklk/2KM4UfAxtWk9s3mxMz8XhzcM
         XytPgySzVzFaQ1Sn84nXs5BV/MZGZtdN1QUUqSA7fwjrXMYxVCqVzoVcenCq8f83+atB
         Ty9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765982181; x=1766586981;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ld6T8UtWouDR3xKdn1TrtGxRAlGZmoqNloVepqhEues=;
        b=nwY0JUtMhFDUN1dB5WleG3QW7WO7TF2GyeCYoeX2xrMVuF6zqg58spTJgYPaTQ6/Zu
         PDaudrXU3gBy4hsw9y07/vTdAQ2Cc7yAx1RyKb7I8rNh3MjYsk9DLlXRjohxU3kedS9I
         wlnwQap/PtuUsjol8g6ZNU0Ic46mXlBpguZT3dU2Jdl9cc0ApFmwrMdZ5v0cF8wW2wFe
         6HxvXGnPrYyvzecDGOO67zU9bXE++8E0NhOPqqF8r8toWcbQiDlQzOonOgXtkuL/oYSA
         wNstK4AxVBYO+DyET836a1nBXDv+kl3BlC4PBUyD8YPehGLZuVq6rjsc/Lv0JGfLBDfN
         NRVg==
X-Forwarded-Encrypted: i=1; AJvYcCWBun7iQmTlLUc0Enko4sw3oIbzPEc1tL8vmKYT7AV4FO8WFaFexX+wHAyq42/Tq8iNqnsJ8SABq09SoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTbNtiLU4JWZNHBhEWg6otJ0zPuHSv5ABK7pWVX2037thpeCHb
	MpWvxl7kJsVTmL5oBHy10jWtNl3mI2SAMxAN0JlssmkaMgS9V3EGuc1vFVunJ0d1W4U=
X-Gm-Gg: AY/fxX6fOHEEaRN1OzbPOHkGFokF7uqJxkQR6lVDEalhGcQmDoDMzGvKOA7i/8WHiec
	Rs64f9x3EcN1509KHU97Lv5LdsvY7qKjMUQSLyoXoxdIdnoBcB5XsTCaF20I3cKzbtIzuw1OdkR
	LUCYvUmM7NoxWKK5TFDRQ7hclStN2Yv6m1B6z8T6r9sarSOgxSEMzxrwxtvu32WoBxFnvM28iYV
	vBbvm9KqvkUPDrbzzrZ9LljqVWEw9i7W6TTtnSnPoQoCArkUJfdfTQhexmBRn9u9PSEKl2KaFau
	VI5Q1I/PVO9dDFu1rlnzGG0WuLr9vxjQwWd6V/rD1YdkE2f625fRBxpUmrMdfS+/U0ceica+pVo
	V8Us+OIu1AMaBhOt00xjW/c8zXYr+HSq38V91FEIKELo6SfStDMZtkrlchHSOPIsJ2U3oMA+Dpe
	l6LWk=
X-Google-Smtp-Source: AGHT+IFYryRICuUu40ewcf2L22LVn1aCV+6k+Edu2uvw+mN9u3Yo7M43WfwfxSDL8NCOVtBigpLq5g==
X-Received: by 2002:a05:6820:1b07:b0:659:9a49:901a with SMTP id 006d021491bc7-65b4529c619mr7323246eaf.71.1765982181125;
        Wed, 17 Dec 2025 06:36:21 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b867ae255sm2141700eaf.1.2025.12.17.06.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:36:17 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: csander@purestorage.com, huang-jl <huang-jl@deepseek.com>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ming.lei@redhat.com
In-Reply-To: <20251217062632.113983-1-huang-jl@deepseek.com>
References: <CADUfDZo4Kbkodz3w-BRsSOEwTGeEQeb-yppmMNY5-ipG33B2qg@mail.gmail.com>
 <20251217062632.113983-1-huang-jl@deepseek.com>
Subject: Re: [PATCH v2] io_uring: fix nr_segs calculation in io_import_kbuf
Message-Id: <176598217718.7122.7321090942996172863.b4-ty@kernel.dk>
Date: Wed, 17 Dec 2025 07:36:17 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 17 Dec 2025 14:26:32 +0800, huang-jl wrote:
> io_import_kbuf() calculates nr_segs incorrectly when iov_offset is
> non-zero after iov_iter_advance(). It doesn't account for the partial
> consumption of the first bvec.
> 
> The problem comes when meet the following conditions:
> 1. Use UBLK_F_AUTO_BUF_REG feature of ublk.
> 2. The kernel will help to register the buffer, into the io uring.
> 3. Later, the ublk server try to send IO request using the registered
>    buffer in the io uring, to read/write to fuse-based filesystem, with
> O_DIRECT.
> 
> [...]

Applied, thanks!

[1/1] io_uring: fix nr_segs calculation in io_import_kbuf
      commit: 114ea9bbaf7681c4d363e13b7916e6fef6a4963a

Best regards,
-- 
Jens Axboe



