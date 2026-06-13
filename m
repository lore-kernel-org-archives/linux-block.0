Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EB1378806
	for <linux-block@vger.kernel.org>; Sat, 13 Jun 2026 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781364578; cv=none; b=C16Hfv+p9YvxjT16NirSNdorikHw1daz9rzerooF+dpPrH2LD7bUNhxBWUDkuxwPx8RnRcdNYzK/opIhj5KYi3mP7RKFczo8tG8sVpH5fsX9t/yZQnk64o7Kl8KSHGznQCC/G4PlTXDuvrxg1zcZDqwzzeiv01H32pz8j3lHKGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781364578; c=relaxed/simple;
	bh=fFIRwCWA8q3dej1RdrEStjRSns+yvMUX5NiRkJaQ+hM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hu1NIkCN2gQX+sJilHyPgqQTLOiQit3hmzoP1UNk+2B/0U2mv7GNwCfkjTjiKHxF2HlMItyGVvSn6qKe6A0J/cvpbw8FpeFycFez4ZhZ83yJz2PWzgbai8MUC3zEtaMUYCQE+rKAmjDX4z05YEyaVQbHDM99rtbJ0Ir9rwaqKy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=LzbG9FMC; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="LzbG9FMC"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e6fa36a1b6so1669581a34.1
        for <linux-block@vger.kernel.org>; Sat, 13 Jun 2026 08:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781364569; x=1781969369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qCxWSvvu3zunkbXkGJtZHkiWrjdF/DdrDjNA4zR0mU=;
        b=LzbG9FMC5kR5AE0X2yyLaTPCeH85hw3JhPbCMlpy/I+g2r1CSBvmBTS8GuU88wIgBt
         DLnQMfA6ttGM4uQUHJIRLVY0vhx/kNu6lYsKLEkbF59CqeA+30ltIlrODGEbY9V2aE35
         STClc446mxMZ1BnpXvpdT+ODB+PRwEphVLP8gYMTZHxFL43MLhA7E4y3xyCqe9dtJ1cv
         fCxWV+V9y54NRnHiePCK7pL4GkXHWvLYvho4xSYPMWkdY4I5krV5C798BKWE0o1HbZVb
         X6aE43sGH1YQjG8cFLRpIdUkOtElnw5DmcnaIfQFovbd+uva8E844XIFM5wkI45IMOR9
         L84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781364569; x=1781969369;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2qCxWSvvu3zunkbXkGJtZHkiWrjdF/DdrDjNA4zR0mU=;
        b=Fy4oMqU911UM+1HEbYfhkWq8oH1Jiy1n6TsYi6TgA1asC6r7Z71cz4hB6eZnOjbThi
         o4aAKOtiqd46Ag0MZLTjHPq3zxAujq1WB0cHJTLLRW+2BBqEk4sBkeWCMhGRwudEcL4O
         emPHa9ElOyVevnWatjGLPrVD38blkp70VuUJBjOUGWV5Azc1A1pPBU0Dx1x39G2hADmO
         VG3jtW5hk6zsPoEsBFRxQEkYMzY6K8OPfS/gRCG7Cn5/rZB4TdnJkqwr99zzM5p9Oc2r
         chwjWO8ThOeId/Jj7ECdo1mvai7G4sIbL7MkJIuiUWXOqSqKlNniwiFCylMakxnaVY5l
         Cw1A==
X-Forwarded-Encrypted: i=1; AFNElJ9zPq7aGeaEWOBDUgS6em3Zh5yBbrltEaJ2ok1ZfB3KjG2tgREZFMh0VghWtqQ5jf56mk1GCEXR0dek+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdxB7w3dSuHGd1eA2eNqHg/bjm4TL8Ep0y7TSNjUFlwZFpUf4N
	MN9uh3l6Hoy2LDmW98TFUXynJbJQvfk9DyeLvkYkpB9HkZZACUsPuY33ESPTcmVRsBY=
X-Gm-Gg: Acq92OGg0qtagJLJd3fciD31o1aOLfCf4j8+/CJPUXNVFD2M9RHsz4IuXGzU919/vqd
	KPUhBhRpOCB5DnFmZRgcJJIIX42H0cgglHNgndlfV4Q3+MllSWhT49e81Xi4I0gllkFUjqPgtyJ
	WurOuMsNNI1VOoUAJpuqJoofDCTJfPetAJua2fjRL+JropB3+NPPCpeqF2EYplLeBkLoA2TQpM1
	bYGDd3N7UcAjn3prySABekMQuqZJaRZYtJEQ3gsrcNikxDL5Ju6lwN6MozOwZ2Z2IKl4BV/mQIY
	5ffUtHrmWLkn9GJLOc+UDYjyJtF6y8GExGS0xybv+phq8SFSKoO421eDSKM73wKinxY7BZpZ0Tx
	PYJCCLxvvKQw17Ckw5ppeXO8hQzqrIbvx/+zvx3DoXWFuwTKkkQt6IENFPKdKHNcKh75/yy1rlE
	6753tN/nvdnuI8UEnaghdyLBL09ND16XXDIxXRTCqU8zs9Ir1RjRH9MBWOQzulh1JBfEhry/yMq
	GY9o29Y2e7nPcc=
X-Received: by 2002:a05:6808:170f:b0:485:4815:de29 with SMTP id 5614622812f47-4872f38e113mr4990697b6e.6.1781364569575;
        Sat, 13 Jun 2026 08:29:29 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48758491556sm125203b6e.9.2026.06.13.08.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 08:29:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: colyli@fygo.io
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260613150458.682707-1-colyli@fygo.io>
References: <20260613150458.682707-1-colyli@fygo.io>
Subject: Re: [PATCH Resend] MAINTAINERS: Update Coly Li's email address
Message-Id: <178136456783.1954753.8358889895275169463.b4-ty@b4>
Date: Sat, 13 Jun 2026 09:29:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 13 Jun 2026 23:04:58 +0800, colyli@fygo.io wrote:
> I switch to colyli@fygo.io as my current email address.

Applied, thanks!

[1/1] MAINTAINERS: Update Coly Li's email address
      commit: c7c76f9232bd34835d821f14abdc5fafc17bc938

Best regards,
-- 
Jens Axboe



