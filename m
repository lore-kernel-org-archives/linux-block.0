Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAE44C6F1D
	for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006884; cv=none; b=TzlyF/GTG7DK/4wOctfPWActEXVeMRhqvLIz828n6bCVrsdFKrM+kCPEp6xTHEnJ9u76afg/l0/WvLxPmQTaF0lnB/nH7feGzEwBhFB0DkYlGrnSCpYRiBPXHX7cROfBI9S67l4cn+W790Qqa9mqy56qhfwzrzbwFs/p7bBj3wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006884; c=relaxed/simple;
	bh=mZE8Hk7PfGvF8HALLlgjtJ7b6zqMNmnUFjMAdt+vOZ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Oifxs+e/dZ+lbRJBNuIQdrkrzggZwgEpd+ufEdZTlLzBE2Exu92EmIB4sqrsVYt8XB/KdxepNlaC0fnBTucPxrYWCGE7atUSlNNDcVy5wGn+8W12jAbKYmCgcrR08Q/xM5hr5MUhgUKl5dxGNLQRWCSNq03BZY2Q0FvBD1Z+0UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=r+PTncNg; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="r+PTncNg"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45c8984fac8so2018165b6e.3
        for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 06:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769006882; x=1769611682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTUuP97slCqRp8vpSo1t9EhLn96fGsRPJRFZTMxF6oc=;
        b=r+PTncNg2hwexJwPK71QQY6++1tmMbUeZzwoMN2XippzMul6ZsItCXDjf7rXlLIe3q
         tQTQcK314XvUgWmsK1NyeLoBbDIGJWQH/0I5TIYMhRxluLt3YqEyBMCBy0gDwECqfR1M
         aImytNuMfuVZKDR1MxfMJ4P/19pCUGh4peSWeOjg9TUxnQlT3stkOa+nKshzhooiayHr
         jZWkXbpzneHaQrODDIBJHNVtqiBUWR3BRZKvWl4hhY+f8gRfYoTjAfw70UuFCE7Ps496
         wLX3hobm7btcv5rvyHsIrz8I1NeBaIViiCel/eGqc4iB9MfZ58NXMQuLaUsJrUwxcbH2
         7Suw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769006882; x=1769611682;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iTUuP97slCqRp8vpSo1t9EhLn96fGsRPJRFZTMxF6oc=;
        b=ZV+9sL6GSRixrWUYo8Zbf7GhwsdFsgh/C3szTsA3AJqhK8FcKK0rqkqCHmZZtbZWRh
         kE7Nha3yAKO0LcIC/42wxSKtVHR2+s27W+zqyntoQUputwVQiJzFUkDPWOa6vPix//yi
         gQhCnuJFXP+CQ2nlbJyP0p53gk2ONlQQMGWG10XMC0tvH+G/iHNwxgMziBnuPngxPIiO
         ly2VCg5tYWIfNUNunVjmlYfpwkfIWos50iFiiNPo30ESnWoHXjmPMRwoEZU/yL8Df8L6
         z2iPyzs5xMP3GvpuD62uTLZf8Fy8J1hZOGlr5YbYAMl/g8RKSDBzouDvbtmp7CrDyFqf
         YnvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdJA0maXwj4bDJoK0iAQyJ0xVC0gEFqQ9BfvGuwYjQQCJGJT9n62CoR9bZVu4XZ4fN0/nWzRDOckTS5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxIMxJngwqKnw9KZ6rshOt/EKqkB9ETqBmE1g13y8pcaHGI/2m
	BJHjHmNv+fs82Raok2M2tMK9qecbBy03kDEoAeOuqLl61uQ/r/6u8XmcP8J3ONeQcCs=
X-Gm-Gg: AZuq6aKM+BgaK42g02sbEvOZ7wbVylr6r/O8W2haYSv3RHfCrAYWbXf+e+2bYQ560d+
	5bwxvqDL1pCk/UY9SzatEJIIxGtGF7IDAo4rnIXpHUkg0O3Q3TLZfsY+KyaE8j6lPJx0L4k7FZF
	w+GuM3fRvamMrXHi0m34oFGv57P6P8vDX4PUzr8C2Z4BHgjzKLcoBzEZPh4icqyGvHmp8wpG0fT
	r/lFvC3Yt4GHns0ry5OaYtyPT2ret+VE0zzBNr0ccfKdz5FgjkJFA0lnit3qOsn1NOQHoKzJS8E
	xrGoUWskiPDDsenJ9CIS+e2beCDIuzFRE6sPQvYf/dPT9njMGMJcoUhdO69nZZnnmpNR4k3pOFn
	67bpRfwvU3ZoCdVyBJ86tZa+aMllxLI4mp0Ukw5P5kNk8WdTV6zdpsba4z/P0ypsIJRMJlemW2D
	qApRxD02cqwV9b36/5SpY4XWGCghyaLYS/VkQv+sqjqqJPX0yz6nkNf8E4AOoic+g=
X-Received: by 2002:a05:6808:1207:b0:45c:8c9a:44eb with SMTP id 5614622812f47-45c9c14fd52mr6878378b6e.36.1769006881780;
        Wed, 21 Jan 2026 06:48:01 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9e03e82esm8760513b6e.15.2026.01.21.06.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:48:00 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
 Seamus Connor <sconnor@purestorage.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>
In-Reply-To: <20260115025952.2321238-1-sconnor@purestorage.com>
References: <CAB5MrP5YbxdUe0378VfKBMb_n9=6G-C=TPixYoMaV48trgtWBg@mail.gmail.com>
 <20260115025952.2321238-1-sconnor@purestorage.com>
Subject: Re: [PATCH v4] ublk: fix ublksrv pid handling for pid namespaces
Message-Id: <176900688050.9724.9395276335790217400.b4-ty@kernel.dk>
Date: Wed, 21 Jan 2026 07:48:00 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3


On Wed, 14 Jan 2026 18:59:52 -0800, Seamus Connor wrote:
> When ublksrv runs inside a pid namespace, START/END_RECOVERY compared
> the stored init-ns tgid against the userspace pid (getpid vnr), so the
> check failed and control ops could not proceed. Compare against the
> caller’s init-ns tgid and store that value, then translate it back to
> the caller’s pid namespace when reporting GET_DEV_INFO so ublk list
> shows a sensible pid.
> 
> [...]

Applied, thanks!

[1/1] ublk: fix ublksrv pid handling for pid namespaces
      commit: 47bdf1d29caec7207b7f112230055db36602dfc0

Best regards,
-- 
Jens Axboe



