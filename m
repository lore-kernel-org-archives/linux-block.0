Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEB03128D4
	for <linux-block@vger.kernel.org>; Mon,  8 Jun 2026 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929270; cv=none; b=EXMynAR5llyXx0N010d0c4jugqxR97/ERQa51x1e0Ospwc0imILL83P6tx0zf2nOg5d2TkuxD6ve1x6quk3nQEVAISAeDSNR2tki2cLqF8/GZyt8WtE/+w6UfrfdISNDenKrcnzJKsSGc/5zDTLuxLVhjlu9pYO71c1Gyu3HRO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929270; c=relaxed/simple;
	bh=2DiM6PFrPZzoOX3Txr45CahtPR9yAKKQFjvEf1Rg/0o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EWikDhB7iZ/ZGdG2l+OqWlUfOnO+PAipU/ZwSc9b97Co1WPeTMc86ZaKjEvDDEtQ3LqKPtVu+Xm0doSpmmq2F4JVLHS31HEq045qXGOf5F7HAKBWbZYWfrro8F/mDuwVJDKxbqrw6VGpxGw9Zfk0yLYLAgOFQZVROxxHAW3MRWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=l/HTe1ie; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="l/HTe1ie"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-69d7cdd3b8eso1648896eaf.2
        for <linux-block@vger.kernel.org>; Mon, 08 Jun 2026 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780929268; x=1781534068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/M/vbl7ihKt4hB2QPk1iXol4u8SiMgbyxK1Z7CwC08=;
        b=l/HTe1ie4YJiYPZOuEE26ccKoBxrF8bdcepOCEQo4CE1xjTujvlVGJUf+BzxJ9XoDl
         YHGQLFzgOvkitqdfccA1jDm5ypp6ahRXT7yOXavHPPLp6CrN0HaM03vA9ezuLc8wMTv7
         9lqfHgbl7qpupJhLfuCHpQRAlaeqt9zCOfsxo79n3hcNvGA+28PDuY3DY790IZ6Qjgok
         Uz5zeZXPCFGBYxMylz0eQkkwW8ds/7gwX0V3iSrvzmyWXPUW8eGvl97sSzootlyQ1AQE
         9gAiODy8ptUUEU4tb1XENh6IHWCWAXEqPx8KiD8/d3zOxyfUz5Q/q1M6cGL/webkFbJ1
         HD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780929268; x=1781534068;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A/M/vbl7ihKt4hB2QPk1iXol4u8SiMgbyxK1Z7CwC08=;
        b=rrB7dTgKJOIKZp/E0tBQMCVlct76RphSDS8LobMMcKNpuXlGF95jMTXRI/pJv1CngC
         TaO/mPzAK/YWX8Qq/Pbs5a1TUqT3Njql7U/Kg3wDwBVDYcjknlQjpu2JhzvlXh0tZXgD
         o8mWht8nFTIrCb489G6v8I7bVc/HVytrp3bLq9zPzj/QD+6yMLhqhr4q+ReVbYNR3To4
         gMRaqkoes1vRFaT0io/VuOK+0BxjIOKconBj6ogPF4ySjIGakPdgUJWXqJD1r7aEXjSE
         MFP1ahyykAdHK9DPOx7yiz1GeIWc+VM0NPzaO2+g5j1Te3J3elF9oe1IXX5eCpMzf5Wh
         dWdA==
X-Forwarded-Encrypted: i=1; AFNElJ9bJQVvSqQrKyt/EKtjQKSoTihn3I65EN3VgNSRdF5W8Ze12ff7dYsnzhsHgjI4Ih0VpEoeOrfI2KZ0+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCXrdf1OKKhfbhZTQYWlVcJrGF/im1lXEJaGM/wE61S6beV3JQ
	wg2CzBzkRLMpGBjQlSqXoyyPV/Zk8n9NYaL+59XL9Prk8FNyitecbJ86rArjfQnkfBo=
X-Gm-Gg: Acq92OFQN9VaRZWqeQ2BTwOC2WrTbHi0VzL5sFmnfB2NkOKy5wfey0F7pFHfX2Xy+9n
	sW7T7p8B4WY88aZKYCXS1TSeybWKpM6yobxBYCPQM9fxhINzyj9VpDsh9TQE61E+rv+LqrPvQHW
	5aBsiYBniseQEIJWYW30/p5qPnbYmYKVfc2K0X/zMH6NTlETAG2ywkOo9VPY4aj3h9Bjmh3o45+
	KE7t0HpD2YeFeIurv2EkP/LuRSMuwf6krQpmq9UPQKA8ulypdLwPIgZd8hEE3G8GXD3zC6vVxPr
	IqgKOeIdPaG0eEorlcEU6MN2XOxtD62M7AJo9LdhzCFykLTKS0il8zfigH21mP8XlyL6fImYUzH
	/dVLJzUjUVvhaD8kmvMyny8sDtilzgvVVZo0A5dWUuWX7VJkhus2HsLmpm5puqg4gnbnlR33qRa
	Tz+0VwzAvGFcXjPycuGOHmX4IZuIG9jpN4/7KmyRSoMKKmEaj+dx6+LtSwh5fXJhhVZ0EWoimcb
	do4yCjNazCdshk=
X-Received: by 2002:a05:6820:4b8a:b0:69d:521d:a4fc with SMTP id 006d021491bc7-69e68b1b38dmr7672050eaf.8.1780929267965;
        Mon, 08 Jun 2026 07:34:27 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e464050fasm9622409eaf.9.2026.06.08.07.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:34:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, 
 Arnd Bergmann <arnd@kernel.org>, ceph-devel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 david.laight.linux@gmail.com
Cc: Ilya Dryomov <idryomov@gmail.com>
In-Reply-To: <20260606202744.5113-5-david.laight.linux@gmail.com>
References: <20260606202744.5113-5-david.laight.linux@gmail.com>
Subject: Re: [PATCH next] drivers/block/rbd: Use strscpy() to copy strings
 into arrays
Message-Id: <178092926613.1038952.2298978254798273245.b4-ty@b4>
Date: Mon, 08 Jun 2026 08:34:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 06 Jun 2026 21:27:44 +0100, david.laight.linux@gmail.com wrote:
> Replacing strcpy() with strscpy() ensures than overflow of the target
> buffer cannot happen.

Applied, thanks!

[1/1] drivers/block/rbd: Use strscpy() to copy strings into arrays
      commit: 5ef1b0194b382fafe5023b5b014e4db3b948ee15

Best regards,
-- 
Jens Axboe



