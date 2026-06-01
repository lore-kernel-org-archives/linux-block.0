Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB409379C23
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323842; cv=none; b=TXeMuRKYeSlUYVdkoW7wrOVJWp7MqgzovNxCtql2pCIM8TmuIEkMWbXvUYJErDB6ctaes92yVqr9S1X8gyxac0l8c+X9BAI8GSS2D5ZMzaORCHhB2XMN7XZfEpXqnPG3wTe70xJ+yOOCSvj3wC79YmCQsHHgHVlzXgm7CaMbSAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323842; c=relaxed/simple;
	bh=qOimUxJ53KcSLGVbxV1DywR5xcf/0MPygEdvcHcIyII=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=htiZjZ97QAmjB4yrJg3X1o9Ayr3FieKQRkD8XSbP47lmaGEBLqKjLknxXoUb2G96GlXtLDjfwKZBd5zZeVYrL2PZu/oS6M5WQJKPpkk1nkjeeSeFBeaFc44Fk4fz3P07Qlw1Gr+d0FO+FdOEUMymfmNOoyf+GLgL8svjEP4j5ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=yhiLnibX; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="yhiLnibX"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-43acb9730f4so11038267fac.1
        for <linux-block@vger.kernel.org>; Mon, 01 Jun 2026 07:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780323839; x=1780928639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZ21QY8dl+1eznQFP7IkNssuFzjReRTu6OvtZmgp4rE=;
        b=yhiLnibX1nSPbld0HFESsD/xtJuNE/5u16VlO55NOcfbegeBpRTDsEwJhzGHgoEmmf
         t0pki+IlIgrRCC8RCqtZcLlm7S5sqFoPStwno8oTLR4uvKE4DWnPqGQnclKf5tOrhoZz
         8NuTShHTiKSRK4+a+emXdNozrzymKRnqwlIPQLKIvy9SX4JMJHlMZ7hFIFAHAx5SNzj8
         je2PK/+2yKQ34BXUujCu880uGBMrHaG0cqojSlJnvF44kLwneKSCvdxkTT2P2VFzaf42
         kYcHK19KrEP85OZzL703GLMQ49k/PIU7eI/h3jRRpfy0nTqo8w3IuSUgrA+bh/CrmV9+
         WGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780323839; x=1780928639;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nZ21QY8dl+1eznQFP7IkNssuFzjReRTu6OvtZmgp4rE=;
        b=IY+/OUNQ6eESzDRFfeSXmv0FIDgzZJaY7oahgHgeXTDaLft/Q+E0GhXPr3wL2Ahoxe
         kscGxaPpOse8SqAt27PwSJLJVTYlnrzjBpbkRNS9AuElc55+nR6B7pQd8io/XyTszn7Z
         5ShgSPqdBmmguyoSgr2VuymHWSgkRUf+gAq0T0vBTv0BdCYk22QDuMd4JjfU8WirYXse
         1XNdfvUuU0WnN1TVdGZnGb9QMXtTMxP/XgD5qADsSfqtc+2HplGWrnD/4LTU6E1Z5OVn
         kWF6CIPmxavnpO0o5Ubxjv6+HImf3sxe7PaRmvgJuc9CE3cNt1sQIV7Wzu+0ofP1AoA2
         QjJg==
X-Gm-Message-State: AOJu0YwgK0WBBiW+mgYymITgQMwcXkwWph58M9myfwnrXH2xYiZm7e0E
	moW/xHwC336/cNJuHtcNXi+5FdB+PNI8krPfHd7HBFPC8+lu8syhOb3VAD0q4s4NxxY=
X-Gm-Gg: Acq92OGIJFIHlFlSb3QvfrkzPuE6OoqWIB/4So+IFX5trvNDzJYAdMkDEkLF+4K30my
	8a4Nb3pEv4LUXJfnGpG98QyYcfBor7XkJxp/tC06X0FCujPlsyxyf6l/4BH74sDcRj+EZyX1Ytp
	asGhfGEUcmZOBqO4f9QT0zJdvjHeBzzWuckZEI31P8jgd1edoQIf27kJtqNuP6+YNsVctOygpHS
	/rsdXGBaYuZ6Kt5OjGTKMffJBQXTow+nUN3rxzPpLVrIgj75TVo3OaKe/LhB4laYjQd48/132hq
	lo5wd16j6+mgsTgqaJIawZOZAy8LVZ0m3Td/874WRnuxjI0+aS/WM1U6s98pY3sLJiQzlx637V8
	mDMGgKu5gjpK7hPalKISvsFqtujqIz9irPdqs5ou3SdXBbF3w9hvE8w+i+c3GQWeOCKGaYFLGNN
	RQkQo0Nmln7AvpzOhW7Tl+R59M6NgIqD2YPzFwHRoDQ/771+C+aZDsX8Vz4t6CyXjqENwvO7yCe
	F5aegiJQnLL1w==
X-Received: by 2002:a05:6870:9a93:b0:435:9a81:f35f with SMTP id 586e51a60fabf-43ca421d3c5mr6646133fac.21.1780323839410;
        Mon, 01 Jun 2026 07:23:59 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43c93ae5342sm7818948fac.7.2026.06.01.07.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 07:23:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, 
 Dongsheng Yang <dongsheng.yang@linux.dev>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev
In-Reply-To: <20260530011255.52916-1-rosenp@gmail.com>
References: <20260530011255.52916-1-rosenp@gmail.com>
Subject: Re: [PATCH] rbd: check snap_count against RBD_MAX_SNAP_COUNT
Message-Id: <178032383731.395085.5307833564708936991.b4-ty@b4>
Date: Mon, 01 Jun 2026 08:23:57 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 29 May 2026 18:12:55 -0700, Rosen Penev wrote:
> snap_count is u32 but the comparison is against a SIZE_MAX-derived value
> (~2^61 on 64-bit), which clang flags as always false with
> -Wtautological-constant-out-of-range-compare.
> 
> The proper check here should be that snap_count does not go over
> RBD_MAX_SNAP_COUNT.
> 
> [...]

Applied, thanks!

[1/1] rbd: check snap_count against RBD_MAX_SNAP_COUNT
      commit: 2e1b3f4c51ace14f67201bd2a92ca6312a3c3724

Best regards,
-- 
Jens Axboe



