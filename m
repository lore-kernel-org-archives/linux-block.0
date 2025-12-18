Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A27A3469E0
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070645; cv=none; b=oWQghMCg8dvqk1N9KKn8ZMjncm/NCdlWUVJGjPM+tK2XkouYp5k3xxwsLvSaOkcGEc/iVd0t0Pz9PekGh7jYxFZpU9UaJf2andtGMRGfFhTrGTCiHCqv7bFXMUkEvSfXktVvlBy0KzQf06yXrGdGLt8xXCj8AMX0PEsH7Av1I24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070645; c=relaxed/simple;
	bh=S/QIGpPu9C3+NnksBwVmku6soVmRP/JN1rvbrtdehso=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tR9hcAV4PkuULlbu5GPp1jrOOW3EM9nSq4UMeEVtGxV+J0BPklpPNhyoyugzDgmdhBGp4S7sHHjHOGYOcONK5OSDactquJqMvPnnNJ++VZT591Dwk6Jzs6KZue8rH9HA57zX0njCWe4C/XPVmxVM+x2k4M+23dqkNOwekpUhah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rDssmU7C; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rDssmU7C"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3e80c483a13so452660fac.2
        for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 07:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766070642; x=1766675442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYpV9joBnrWptuU+JqoPkcaViF92PnszrAgFL84I3Qo=;
        b=rDssmU7COvDddbgaaKWN4+nDjoueH/89Ybf8KzAQPsNdIwlX/GOdyC/e8mGfhsP0/a
         90NLM65Iszpspo9+/76HSmDHDPsRtCbGAp4by+7uxP7lGzWAevlD3aiej4mSufzzvJnG
         Xch1SVQwYy4ovAXEu+RKDvky2Sg+bGyLWe9V6Z+xT3gSLgrNIvlPHQ8wuxtGk1MVG/9w
         EgdqQnSAfjpQf4nORJcJvEZi6AajP8OfXJWtVKORI6Unscd+aHN+ITTWXCV+ktVfKEqu
         XlXyy2bAD8kDHImd3PZiQWlQusN5VwIxPr/OJLjzxF3dFzKZ1UUbvrAMSWUDjsC3TvZ/
         nr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766070642; x=1766675442;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WYpV9joBnrWptuU+JqoPkcaViF92PnszrAgFL84I3Qo=;
        b=qGIwJJ2CjKFxu61WOrV8KxayVGGcJAKwn+qRae+fSg3L0PqjMtOvskRsCsu19W/SGD
         XK/L/QbeUGyNc4bm+cRrjnQ2KJnGxX7S9F/WmrP68GehloY9o9lMHkZs5Uec6hRbnr8i
         ZJNkrTD/43rF9b2AyWmL6Cz7X9+XbQ7cWNSeeOA2OAggUUed3IbfC2uNrZgaZeIcP9Lz
         nNmstoqtFZdHvHnZsspJ18H9a5Y6huGeGBfnycQ8DnjXsunjZgOSss81EFVcFNe4UR8x
         cwds1+BYnADX1poNi+VLZRhNc8M9mAfsfkHYMWiFvl/jVaqmcxBT4CT5fhsfzdQLDYMp
         o8mw==
X-Forwarded-Encrypted: i=1; AJvYcCUJSnDg8oE0cCF1HOVqNLkyZGbPlk+JVJpOQO18WFzVgXO6/1oP6XB89thI/3eqewmHLE7iXnDChr4BVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZgFaJGwIfyaFEzCS3/qnJsdmel20s7b0+oke+MiQoTIcC3Zq2
	g3tDRWa+qceVz1WYtFhF2F/8vWnmIKY4AfDWxgsn0QlQiv+oJZ5I0jvINjbAS1uNiHs=
X-Gm-Gg: AY/fxX594vWmfqfRCeuelFfbKvF96E0/S4l5iVESr/0s1GWUCdhMsItHJxJNsT/db3e
	ZE33s+jOFNU3OLOpG6hnQe0Ay4WqE1mhFLOsta6MAs4BkqWnaT7v/dlyTmZPJhOT4vsvzzJywTo
	pr59UNS5W1ZocPl03Hx8krVXQEm5CZ53GEMYpFh7EjeiYaCGjUsSL/qhHUvCjPcgYNrbcT7YuA4
	PHrVyqKhODTeJBBW6ERWVocCEzJA32GXOkLU/jmFX+k341eXIOClV2ilBnsspaXLR66XFBv0wON
	bliZnOYdhQMhzcXIm/MHbfzbwVjIUT3fOQIIjfYAKIS7ew2TexHcCDZ6mtqg3naWCVzuqEbw5Nx
	/8++oi1gvHl0FoEHjN2LE5zdFyKltnNCk2rQ/EklskKw3BpKHmivZnFBtVUaTh72/ngtt1zIYVY
	zKZA==
X-Google-Smtp-Source: AGHT+IHqscQ8/U5wzi9OX4vEKXhLkkHWPOWkX2TpFVzTbXsE0SzIWqk3KFbD0pAONmEtoFfYsTXeMw==
X-Received: by 2002:a05:6871:152:b0:3ec:50d6:4461 with SMTP id 586e51a60fabf-3f5f890eefemr10687875fac.39.1766070642478;
        Thu, 18 Dec 2025 07:10:42 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fa17fc418fsm1769192fac.19.2025.12.18.07.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:10:41 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
 Jack Wang <jinpu.wang@ionos.com>, 
 Md Haris Iqbal <haris.iqbal@cloud.ionos.com>, 
 Lutz Pogrell <lutz.pogrell@cloud.ionos.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251217093648.15938-2-fourier.thomas@gmail.com>
References: <20251217093648.15938-2-fourier.thomas@gmail.com>
Subject: Re: [PATCH v2] block: rnbd-clt: Fix leaked ID in init_dev()
Message-Id: <176607064127.251590.3100959244352916450.b4-ty@kernel.dk>
Date: Thu, 18 Dec 2025 08:10:41 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 17 Dec 2025 10:36:48 +0100, Thomas Fourier wrote:
> If kstrdup() fails in init_dev(), then the newly allocated ID is lost.
> 
> 

Applied, thanks!

[1/1] block: rnbd-clt: Fix leaked ID in init_dev()
      commit: c9b5645fd8ca10f310e41b07540f98e6a9720f40

Best regards,
-- 
Jens Axboe



