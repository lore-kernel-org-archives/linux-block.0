Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B14F4570C2
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849722; cv=none; b=sW4e335YJOikWpzRtiWChMkKo6Y87dcR5+rc8YgXG2m61yIwKm+3OgecPqYzfdHkUfUdReRtYWW6PoZnFONTQqBGDBqRegtnzbvURafKXOmkdiHrOI1P1yQGT8YhM3EDtOb30og+ZftqQEY6ocHeqYYwezjaQcwwQtJ5AvRIH0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849722; c=relaxed/simple;
	bh=F1Ns0YPbju+5JU6TaXtv4zBd5RxYGzvG2uXQRqInw8A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MgQdn235cIIJoX5J74sm0J0AxgC8qyrE7MiQdQxVcAqSzrIpq2rOAcEXPtZsn+V0/cktN2eprBPZgu2BJ12r6PWWUfSY7hOwge0H6bIxqEPFTf789h9uQPYS550WQVLRZ5Iq2XJfFUd7FeSNtLlQCwARgzDp3MrlBhDiT19tQxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=CIv1N6Tz; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="CIv1N6Tz"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6ae409c12f1so2119191eaf.1
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 06:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785849719; x=1786454519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tKaJVZUyE8L3YDu9jVIaa21DRhvEs53FJAhqoPHjpPQ=;
        b=CIv1N6TzY1RjDCYKzZREb1qHFJo3RNAlX6y6md0JsIgnej9aPbOEKkKluC19WwHhgO
         iNgDKS4zHLhTOK3+tQ6qKxuhx0v/a70dRjtWiejopNUIM5HEetwEDKmkUUj1QQpiwRTF
         vJ3NSx8V4+jDG7Fy/uMNAsm+tkKXoQXyJd90BvcEAUjEkaLF11B57lp0PfVavOvJu8XS
         PPq8U89Ban06nlavzIYfzo+fZLMaVGOoB1KtakmPIsr+LuMENPrKwwlQ2Qg5oQbEAmfx
         mlbIOmiH0O+8h+qUmUCa2ESzS/JZVKQQ2pv+YGFdn8n1+KXSQCtSdZfv4YGq4SnRX5fs
         k0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785849719; x=1786454519;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tKaJVZUyE8L3YDu9jVIaa21DRhvEs53FJAhqoPHjpPQ=;
        b=OLo94nGtPz1d3Sj7uLjT07vpy9jEpkunncPAB06F9bHiUm7VQ/JzcrEZAUVdd7XyON
         Z9He4x7WLwpXydzgDbztA6loEbHmrRLw9fbBmxsiAgB8f63HG9ttGvdoGUnLrIbnTdL6
         Td+DwOuXiq1lR+4fG2Dq2lR3LkKvqrG79O+g4x2H4x7ZDMPhCxTEtlJsnRJlUmDoNF+U
         z31sOMzyYHbVUO/iSo+Fnz5hRSCue65MkMnb1KvBnsPUmzBS+SnA5Klwv8pFMJu/sBX/
         Fhd5Tu5xBklpjQoCf3Wls70xYFfIW3xLeaU3AqbkpwYDRAdrGOr/edzwFLg5wMlG3DdB
         76jg==
X-Forwarded-Encrypted: i=1; AHgh+Rrstj+JYb831gEqt/Qpdm/yFXxcgMnRVmlI941ZnCMR14c2z0wiC65JUhNr+iSyCaqrl8U2bIQRPya/uA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyL7nHSwsS4almP5DHxLpgQv52D4J+93Vcq4hieIZfQo1LCfVcL
	nP8fgjZBvV/lvs0zZxHIdGmu/bSXNkzzR/6Ncg1oowjBsDUtEW8FHiJ1Fj1Ma46DEBo=
X-Gm-Gg: AR+sD10vAjNQoJqH89y8Vb6wlrVRDN5PTb4BFLjFesLMihP4HaT+095Teopz7wVNMPy
	2ihvmD3HTbVM/PKjesHe7A4eVIQu1q4G7HTX+QhNI6L/gigMjp0hhMiPU+YA+wrgnJf+fKYjqsP
	WQugGpViGA436A+9ShfKEML5cxiFdVXao54d3ldODsFSP7wm69u1epDFlSPDoUJwkZu7jls8tqu
	xtYRdKVvMW40K958o38CXLHMHny509cpAidnnFKEUiD3rfxrpNPS8krfQTkez4b5LgdkZBlwMRV
	AlIbFl7kHggdZfctirbqNeNeEnIefxyVBoidzOnAJCIL4lDqRjXHo3gAhlhLHd2RkRYoDkFyIth
	t1OGcCYmOUanXkujr4bNa9V9R6sXYyYxdM19pvjLPFHINWBkxs9d0nTJ/DkUwQIU62v2NYpbNjL
	ziJ9v4nxDYFaaaAA+iak74XLqNgjylf3FczUrbX1XRxOrcreQeluWzNIzfPGcCg3z80D6ChwU1/
	bnh3qnYOgUUNwnyXTYsUDCl2bJNAdgjbqxQh2SvVg==
X-Received: by 2002:a05:6820:61a:b0:6a3:da23:505f with SMTP id 006d021491bc7-6ae432ee256mr17769203eaf.23.1785849718728;
        Tue, 04 Aug 2026 06:21:58 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f6764087sm11957112fac.17.2026.08.04.06.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 06:21:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: dlemoal@kernel.org, raoxu <raoxu@uniontech.com>
Cc: hch@lst.de, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <4659F8F0C6C328EA+20260804052942.1186727-1-raoxu@uniontech.com>
References: <4659F8F0C6C328EA+20260804052942.1186727-1-raoxu@uniontech.com>
Subject: Re: [PATCH v3] Documentation: block: zloop: clarify capacity
 alignment
Message-Id: <178584971685.948879.5527639409751781985.b4-ty@b4>
Date: Tue, 04 Aug 2026 07:21:56 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 04 Aug 2026 13:29:41 +0800, raoxu wrote:
> zloop divides the requested capacity by the zone size to determine the
> number of zones. Since it uses one zone size for all zones, a smaller last
> zone is not supported and an unaligned capacity is rounded down.
> 
> The capacity_mb description incorrectly states that the capacity is rounded
> up. Correct it to document the actual behavior.
> 
> [...]

Applied, thanks!

[1/1] Documentation: block: zloop: clarify capacity alignment
      commit: d73b5b0690e36b2a9e6022f6712e9fa7fd338632

Best regards,
-- 
Jens Axboe



