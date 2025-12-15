Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575D828643C
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817798; cv=none; b=aH01GqKA45XeuAVYMXSyEWAgHsn2MPkZVQyLgxyS+Kr9zrhemXMi0DOd7qMAIhEcA7TUP70yP5lzOlrs557jFah+FFnnmtDwYNhM6r7J+0iVUQP3nZws0BZ2KRCYf6dOrDU4o7d/PRJezmGMwk/eEi40jU56g89loRuYFV2Xju0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817798; c=relaxed/simple;
	bh=ulywS1nVNur5F7RNiNozdKiu9bhS+RQCcBW93vOmXT8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LoUGTCBj0XTFKH1Hk0tIF0Gd7FSdgygSqQ+g9F2DMncgiEvB0FiePb9JR632blN9GJQh2CSvgorJ7Nib6xyM8flDe00h47iURlKEJ/suspZqhpd2HUV0oFAzl/1IEGK1qqRkuStkeddeTrIzp1PX3ktJSqXRQiwDp2YXeymGacg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xqJM4FW4; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xqJM4FW4"
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-4557f0e5ed2so2152066b6e.1
        for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 08:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765817794; x=1766422594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2M3a7+ReJJ3D78a4qK0RZ6Htl361+LOZhI5rTqOV+OE=;
        b=xqJM4FW4pzKxTZLUG06CDDG67FkP2LY/gTqychYQNoXXhBRxxpQf9b1bgiNe9oaVnh
         j8OrtZUBKYLKFwCoe13EFpSBxSVJxXIYy67db4DPZ9RD3rNMVRAINT6WtR2Cjpiw59xo
         duR2Djeyj5TD4Fay6DE1Tu7PIFq2S2LDz9JFUvLLzZzpr6jPIOSrVFg5KM+Dky7fUI8B
         wqf32+kN6rwYJ5r377pfoKBL0eERTOj+TJs/Snv32Bljm1FCjmaOX5P57ENNk7V1h+bd
         8KYU2wulS15HAh7nn0sfA5reqXzWYnXD5ePe7pxHdXJiIQnjqkQav7wqsRXEg3TvLcpu
         y8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765817794; x=1766422594;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2M3a7+ReJJ3D78a4qK0RZ6Htl361+LOZhI5rTqOV+OE=;
        b=qF5TNyQ/THoXxC/tVCfWUUbgZlH21EwwkTQyFEfYbjrWs6fNu5U+9SfXIb4kvs2nXZ
         WnN0hpiRei4KMUf9WlAPxaoc8wdQXoyZw28czsainiz+aUYh4h1XZsBPlPt9/ruahuiK
         hgEmOlFnrgS9hKOiU/YgoBkr+GxeZS6NaSB3lmxmBMszWNvnRJaRmGeLFXxStyRb4qYz
         6jEofvo1a2gdJGodd2A6jGVa9WZSiWFJUq5UmlpCPLuMujORYy0vIxJrGA3i3MTYhxYr
         68Tgbrv2OYTUW5Qy1N62Yq6rpl7JF6+kbhVAQAYhZCdaZf9t+eORzRvvjzHu8bGFgJj0
         45UA==
X-Gm-Message-State: AOJu0Yyk4EyS3P7fzCv69tbUp6K6tZtUwB79DGJyH7vP4dR7I+C0QF62
	NSb86rX7eEws4cvtljxQ7tobv+jaXEhBuplU6Ff76DZPscJv6fDpjKsI/Rt6CO7W53s=
X-Gm-Gg: AY/fxX6OMuqkKLLsOWKYapOVdxPQmV8ERLVQe7p8gVMqTI4XmlvECRY18V3STsvk2lM
	9U7gXTxKfA6dGxMFPoIqjMrpLyDZDU5AGhgHixhKZLVlLNZCqQWDwRXwzNlt/rrgerC8uK3FtE2
	8zilx6n5+wwia0Jmg9FdQtfBIwEXJhNQg0DrM+B5xhfm+L006tYcE5WKBj24olteh1oIW4FVFH5
	v2++AG6fUGQHVKPUhbsjBM3refOKlHt3EriBIE1y9MK19rPv6E/O3ktcgQW0APdx/ewE0ZHTBgM
	Blhi8fhrTKZitLEowRKrZYfqQM6XGXFapT5/XfVhCCh9COmnp3Epl2ToEC8o0E6lWOL0vbkAGXt
	eOqCGzZAp/hDRb9ZrFzElRe/fs4W7dGTLiI5Ks3zPKOjsh4KfzGgmVQjyvLBsABtn+TNxFl6yoC
	vKyA==
X-Google-Smtp-Source: AGHT+IH29+34z8e2aGHfAfFfrbcphokNJodhrKwKQkwo7FiW/yC73PruZYFQUOvBIlcTHfkT1lfHpA==
X-Received: by 2002:a05:6808:30a9:b0:43b:7b80:5cf2 with SMTP id 5614622812f47-4559a58d733mr8251657b6e.11.1765817794370;
        Mon, 15 Dec 2025 08:56:34 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45598cf2becsm6693806b6e.13.2025.12.15.08.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:56:33 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: linux-block@vger.kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>, 
 Yongpeng Yang <yangyongpeng.storage@outlook.com>
In-Reply-To: <20251215095816.1495942-2-yangyongpeng.storage@gmail.com>
References: <20251215095816.1495942-2-yangyongpeng.storage@gmail.com>
Subject: Re: [RESEND PATCH 1/1] Documentation: admin-guide: blockdev:
 replace zone_capacity with zone_capacity_mb when creating devices
Message-Id: <176581779301.11354.768588972196922513.b4-ty@kernel.dk>
Date: Mon, 15 Dec 2025 09:56:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 15 Dec 2025 17:58:17 +0800, Yongpeng Yang wrote:
> The "zone_capacity=%umb" option is no longer used. The effective option
> is now "zone_capacity_mb=%u", so update the documentation accordingly.
> 
> 

Applied, thanks!

[1/1] Documentation: admin-guide: blockdev: replace zone_capacity with zone_capacity_mb when creating devices
      commit: 67d85b062dcb49af9c903a58842a4ed7281f57b8

Best regards,
-- 
Jens Axboe



