Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018064;
	b=1p3g3ISqdh74uutXAcmxSfrpGOFgcO8kglZniN/83i1YtteqVakv8UBbYZ9LIKLYpiyh
	 j0qHAnNI+Rj56JgxTRWVMoyC8sOq8rJfZqawYVQof41pbS74xdC6/4vMqbNO1HtjyIQng
	 Da0VZV1s1klsFzYynhB6eMYz9n8Bl0IKlhBrRgrvC3+4wdcJUpS70H13rBTI+nvuZtTIU
	 C338EiCWuo6eUOTPr24MCRzXC20lLtOO+BElcx0UGUNYDESzmJHdb0tUDj3yoj7i48c0N
	 KY/oceJfaR5ktFfeGlsewUgAzBiMtBkblaPuT+aiikCUBT2cTBA6xSTC49C0gwt6QRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=Daq83ZrmsgMu0hFMnqIG7pmefbD4GjLgNHcMc6rgY7Q=;
	b=KFnEsb5NmZvoO0vB0RYj1kxLbVglb+EvYGtNPXtjc6pSorXxWWv9/K5S6GsN9xRcNQzU
	 pa8xtRkkmbRL0NFiAOA4E1EM2cSiFCMzRcYQANKiTkSU1dC/TkacDUz9hYN1QOhFpTB+I
	 TrzVRtEkvSGKXODpdptbt/WTwsZgzJVqxlvQcga8DRJxb5W5Kwy21OxM5Gpv1wdDRwwuZ
	 89Io/i8YIVlBrPTZ+se57GUPxen75n9OY5R8is/BCZxeHfM3Q6wgE/JLHn/M7+g9a/7FN
	 X3jggAP3Z5Vu2ZroHlJ7GlTvleL5BRsGNMGSFa3dyhtea7Ma+8LCbr7V2S1uy3OP52Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=D2PdDMAP;
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E130260A262D
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 16:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E130260A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=D2PdDMAP
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-499f20c7054so639758fac.0
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 08:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795018063; x=1795622863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Daq83ZrmsgMu0hFMnqIG7pmefbD4GjLgNHcMc6rgY7Q=;
        b=D2PdDMAPMDy8UNJuMaPlzqLIFFNb7Ja/2WtNZH2stvVdL0+MsOYWG33s8IMzKVzdXL
         iq6Gb2+/achS+nqScVdDn+xTrPTybI97E+ZAI16eoLeS8xXrIAZLAYgpvaBpgOpQ9e4c
         AlwqlaJKHuj62lF6haPfdjua6nI3KGr7pCUsDM/bNYNuw/Fobp8O/tVyL8zjHzU3RiPR
         0ur2t+i2Gla48dnssTsOWpMjQPw49CCymhgj0GdtsvXFEyFdk5TdUllnhHD8Q+y9qsb0
         vdP4ffyyAjJRh2zfAyX070/Pa2PMxMHH3LePxvykBYHTzs73zIEr3rP5hMUnFxvw4z0s
         oU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018063; x=1795622863;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Daq83ZrmsgMu0hFMnqIG7pmefbD4GjLgNHcMc6rgY7Q=;
        b=Ea4Z+7qDQZceyW21pCnUqT16AD9NjGHiXUqKnvt3DYjXTJo0O0poV8GGLoXrXmjOgm
         9ce8HWJyVbDgQGxweMAngAtwUolIML31pdiUbWCz4hmvzghQV+AgeZSsJ28s5F19mMCa
         0+UY9zoJf/z4PJRReGCJN6Ku5I+BZQsOQz5AgajPywbkIVRjiNf2O7qY5b3rF1ol2wxL
         pqHeEaSwbntz8VrGYOi1iq+GO1kpHNjXFuVCz1IEvBEk3pvh7y12AmEH8jW3fmLwKliF
         En1YVh0kTmXes666ew//qar1w3bP51uqFGdQOVxYIHlwh9xYPMAUve5YBU1hxWz/r1XJ
         Lb6Q==
X-Gm-Message-State: APuU4Z/OUR6mqWFeL4Vd1tN6cZBs8/xiBPlxJ6skJqtQhb9qyEVP8tNE
	i6Voi0oEQ8Ze5pEDBv7KcMcweVikV7oFOu0jJWXhCKsBaRpTfaWEf2R8p91iKQXWtm0=
X-Gm-Gg: AYBFou0KoYevNJ+q/idJ8bsAyzbON6KFfb0rZUnbcN6iGSurVpeu8iKSBTGvxpnI7rc
	sfy7zwGIRm0kzY55HT82SKuXExm7v8A/Krt5FB0FQ0Mh0Uc3Mj7PN+LyOk+pA8Sjgi1Q/STmWMT
	3ZzP6evSB0BbOzzKjuSHe7yg3IRPbeJ4Xjdn2GtOABXg2fY0LSEf1HuzgGLgKRZtLiQf4eisuHm
	q85ODDPXpqyy2DRN2cd8yDbrVrGlFOHx9xMotJvXRgA4iSoCdVZ1sxCFw5G28UfVpSSBau5gQpX
	gXqakLYk+Qa2kKm5TY1a5NUknbD3ljOwSUeQPfw+GH3xbtWyhe5zcjYRGptEbhouIfBnWT5s+/t
	wkAsyHR+Yy9m9XTt0ISX84+QfBEffIULaR4l2aDikLS+aFWJRcC9Lukzv9zNOuMQ/fIAOsQ4zmd
	fUpldCSeVQRownGJItea6SeRcAl57jQ63eSBA256nJrl0weqMmno75S7FBksXoZvCKK5z7658At
	riON2JKXTp8vv5kzziDtRHJ904KTr0Ucjra4VeUb9RwkuwzHuZBgJ6q9kHwUdXH51te9z/J+Zmk
	kpzKCjIXUn7TcTfsw6Qs6qTTQWqUWkQG2gBElQIywRQZPuDZ21L0KoSIBA0PKTDlxx8knghDlpx
	RjFsqNY1KjjpDODkjA+z/AuHKx0QQRhjbp0lKp9zQddtttssTurY=
X-Received: by 2002:a05:6870:aa89:b0:4b5:65d9:5bbf with SMTP id 586e51a60fabf-4b75fd1764fmr2554172fac.29.1795018062902;
        Wed, 18 Nov 2026 08:07:42 -0800 (PST)
Received: from [192.168.11.112] ([96.43.243.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b743721fe9sm2624231fac.6.2026.11.18.08.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:07:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, shao.mingyin@zte.com.cn
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261115003347468yvY7EkDVXpRQABqNYceKf@zte.com.cn>
References: <20261115003347468yvY7EkDVXpRQABqNYceKf@zte.com.cn>
Subject: Re: [PATCH] partitions: sun: calculate partition starts in
 sector_t
Message-Id: <179501806201.17649.16236946055978931642.b4-ty@b4>
Date: Wed, 18 Nov 2026 09:07:42 -0700
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


On Sun, 15 Nov 2026 00:33:47 +0800, shao.mingyin@zte.com.cn wrote:
> The Sun label parser calculates sectors per cylinder and partition
> starts in unsigned long. On 32-bit systems a start above UINT_MAX
> sectors wraps before put_partition() receives it, potentially exposing
> a partition at the wrong location. The same label is parsed differently
> on a 64-bit system.
> 
> Keep both values in sector_t and promote the first geometry operand
> before multiplication. This also prevents the two 16-bit geometry
> fields from being multiplied as signed int when their product exceeds
> INT_MAX.
> 
> [...]

Applied, thanks!

[1/1] partitions: sun: calculate partition starts in sector_t
      commit: a5be44a8243fd7f7875f54ce1c5df3df713257a9

Best regards,
-- 
Jens Axboe



