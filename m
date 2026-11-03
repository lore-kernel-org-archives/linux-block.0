Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716266;
	b=vwH2UeWZ68++ee2+FGGbfZ2ixOnJV+E+wRgunZ6cODfWzJT5SUucOihIWqmTK8u54i/J
	 zqJ1bSzL3wVs4q/fLoC+45xR931Jv7A48JISEwJwTWdWGUykZClwXo8D69PfuCUR4NnZ8
	 G4nkcCd+aF7htav1T00AS93pt7umEr0dY2admTSeKsUvUE1pE1YaQM8CPKKsexaeJw4o0
	 IoAt5Lxf48Wwpj1AFeCKyR4e9a7YOqrYKKPdUo+DdmebubF6ZqezbJsVGsXvxYMPFXUNa
	 NOPJuxCECrujJkrOHZKrXZo5apEi9tFa9cFrULRXdseZjV6vSiiuZvbPrpr5M4cBAoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=SYduxspSDTHUtiOUros2j7XWp+mQ+wFfNDgsc26Ob+s=;
	b=nYDeOon29yA0r7SkUeUbudBNLpvuYTKlYzvjihgdes3OMSa5bc9JunzTBEJbCYsKxLzE
	 uVAY7ZiBepmaVHOmSVCX1wuV9NKrWzsqWfOREXMWjVs0cJJy+BvFl3N3fu8CwjQVZ9/C1
	 CsFAoh9FRYBO2mCl25YrsuB05/4wx/li4I18GFVZKX8QGDF+dd41et/y2XEPhbyyGEpvi
	 A1/9nVkayjwSMeCltt7ideZ5JaV6Op2sw5uQLtNt/c7BQX2Z7+g0Niu5oRaTfR1p3XH//
	 IdoHK2ZQUqFNtRdp83wgzv/QvVR6pWYuxfe8Cl+gIZonnwE2ghP4WjQrgskp0E0K5rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=R3DlMsAS;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C92606D804
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 14:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7C92606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=R3DlMsAS
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a2af4c8d00so6270309c88.0
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 06:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716265; x=1794321065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SYduxspSDTHUtiOUros2j7XWp+mQ+wFfNDgsc26Ob+s=;
        b=R3DlMsASMzn4n6kieUFPygn7aJzjGIYKUpPFx6AKyb9gYPJ1fL/75rH3zUJXir9lQc
         ksD0u4d7+9i8torBcbqGgzwTfMNiNJw41Io25DYGqkJIbbIpcHXpWQnjW3JVshGL3Nhl
         vomuTJpqL+dCtrTlphtyEI1/OLBjySgSb3sM3VzDFGeECi6lvfhloLw3w0YgLQ3k9kIm
         r3LjCNFr4N84xBhiT1HE9NnsRO3/8I/ltD1IoY26UOII8JAOtR00xWuGj9ob3bR76Vmd
         IwXK4MCdlARs0YwY3y0mjF9CXnJaMkNVqvvxQuTdAvMlrhtKXKS4NhbVsE0Mch7zxP6a
         xW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716265; x=1794321065;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SYduxspSDTHUtiOUros2j7XWp+mQ+wFfNDgsc26Ob+s=;
        b=JA0loAHczQsp4zAmLwT+W8sqHfVBau2q8U/DhOKcRPurprssWkh29frkdtJyofu1U5
         xBeRnsZLWj5ZKX08dpk32tYBJ4ccUyjIRRzVJrgzHDU6l1vY0e/ZWf1sA+h0b0rdlUxe
         KAjzz2ZFMlL2Dq8D/O7j5CoyIletIfGj538VuXxxWyZ+c6gi9X0FfZXORUH8YEQRk7cm
         YXBluZYgLionIpt1PVwq1CNUvvMN0VJICn/I+LUVhjg2JGAowEw9MvrL+qtCsteFVzqh
         uHVgqxdyxykmnCYhCGa/eqfqy006ILptJ56VTK26HhBvVat/LuU18dJOJlZPqpOKjLES
         DC0g==
X-Gm-Message-State: APuU4Z9wln8KGsZfylL2ZsYk8lO9TCUdJKZXoGBZM3z7fg878pwZ4+QV
	VEJg7RGb5yaF+NcZLFdDtMlyiLe/rGRUG9VcFfPtZ+iilCcCLDCqXJtHGXJzuVzByos=
X-Gm-Gg: AYBFou1x1k0Qg5pAqaPm82eUV1D8QcEsReEbiJ/GvFAxn+YuCkKyyxe9cpe+yKcglD1
	uOelovAdcdoZvVj9GcRJrzLFwYaS9a9GtEGN4ss2QWlcAOYA7wWoLpPmsoCgbJtaKwic1tqePky
	hg7P8bJ/WhM7RFlbpvipnvAt2o4SEZEpCZZyw9yWrhzT+ziHxid9pnTURbzS9fNVXka7npCNz3J
	aR6jeZDf/IVvSS80JU8vAN6zC1/uazqy8x87jW+6DvEvtnnyXWdgrmDiKcbIsSOSd9VB9FY9Lir
	pTAJ5SrjfD+eRBvOSLRGv9/rKMir1QcQ/S4Pf1JNSaWlkF5NBC1wzRkuYBuNTicmjoxGJVbU2EA
	2bpMoQloH/Jwe/7mygOgTKv+qta6uIkLsa9sLDuXYjxLOOINqWhL5iZ9diNGo2pQfP+fjBAISq7
	opAmzMxcEf1HKcWJMJq8QEIDfiktj8DWiUQc4R2TWMHrb6ZmZkKCUppyFg5onNPyMEdX+r7S8Uq
	z8YQdTZFGo6p6AvyJchWZogQo0LJGdYwGRoV3Bsssj57ch6nzPOaiMbxhk+rC7Vx+43qNgsjpPm
	AjpqaNmnKXQ2sIcIhUagosWGKJA82B54PPYkU6gdFK/Lk4oNzmgncSobhEUYeU/6ZkLQWW1OkRm
	D8YNMNz2nXATn
X-Received: by 2002:a05:701b:42d2:20b0:1aa:6c3f:2f7b with SMTP id a92af1059eb24-1ac5b3fdef6mr21331910c88.24.1793716264489;
        Tue, 03 Nov 2026 06:31:04 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:03 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261025161133.59344-1-pocj8ur4in@gmail.com>
References: <20261025161133.59344-1-pocj8ur4in@gmail.com>
Subject: Re: [PATCH] null_blk: reset cache state before device setup
Message-Id: <179371626229.3691261.9776195588952863415.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:02 -0700
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


On Mon, 26 Oct 2026 01:11:33 +0900, Baek Kyu, Kim wrote:
> The CACHE flag belongs to nullb_device, which outlives each powered-on
> nullb instance. Power-off discards the runtime cache but leaves the flag
> set. If cache_size changes from 1 to 0 before the next power-on, the
> queue advertises write-through while new page writes still go into the
> cache tree. A completed write can then disappear at the next power-off.
> 
> Clear CACHE before creating the new instance. The existing cache_size
> setup sets it again when the new instance needs a cache.
> 
> [...]

Applied, thanks!

[1/1] null_blk: reset cache state before device setup
      commit: 5a4236bf22622c291a96c139bfe54117f4cf1af6

Best regards,
-- 
Jens Axboe



