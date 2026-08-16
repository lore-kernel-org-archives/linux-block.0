Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF4A54774
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 00:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838507; cv=none; b=az4w7p++UD393FAja+lBG41RSu0bgPNPqv7o3GaG2MmETRpTCidOe+7u4ctp+FwTmFdVb4RUxNTpsO/Tf6yyhDEoy856Gow/WMRJGtTKLWjxB3tuke8RlOEWkXEEoUW+LE8637s7wQQ4NuZSRdFdxM8SBhuNZ7+qJTSXrJ8qLdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838507; c=relaxed/simple;
	bh=ZMJ1+68wbKrjJZqdm+Tc6hf6PpZPjLKau/aKXS2cYys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pHPIyzWOCnqNGqGdHYR9BhOT3q/7P2kxwDwUs9qDWOH0V2TwIn1garjnbZj0MbRcUFhgMcEGzM9h9+P6ecpZr/9lwC/jMdOjT4P6qTGaV5Dw7wKq5jVHWEcpoB5u/YK/wssBCz95BmNLiEU3VAsKkrl9g78K6wsBJzAhBw7huLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=boC06EBQ; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="boC06EBQ"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so2249501a34.2
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 17:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786838501; x=1787443301; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1zpQMtou9gDQfuLgk1ookjAIng27usUhF03dSfDiBN8=;
        b=boC06EBQuGPfoCIrBiXsj53lImm2/ycRkqProDkVudAonpbVfHELAWkTzH8hd9LX06
         9B/INsfeYduLrPaEIX58yc6wAih2MrnKBSXLwL4G4+9qkSS7eoYr/76D9v52mWt6CKEw
         Uf2hss2pniWcHVwPwcUAkBA2BmsoXcqNmX5RyguuMA4J+KXpKdP5NRm0XLGIFegvtsnO
         Ow7v2PINXtycRNTAhwXqWYiMmJ6oC5t1iaIuUC+/m9KlMosPYcPYi4I81DT2AJbh5sTq
         VpjWTJr0UzHeH9edkrwAl2tocTtG2Wkk/7vfuEWGv1voNTblFoi8ZqqX1o7JqTTj8s3y
         CV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786838501; x=1787443301;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1zpQMtou9gDQfuLgk1ookjAIng27usUhF03dSfDiBN8=;
        b=q8O8FcBmgF/yHlMroFx5af5/F8lQEqmMCiSCVDfuSpkELGXuuKtdrz+thIJ0b4597F
         V/DFEbtaKdJ4tEXjPDJLji+Je6rzv0ktjjVNxyMLUAbRZGVTfARlFCYmtPo4dRuupQuL
         2Deg5EkChELPQ3JtMAxkDb/uKambnGDUdWJtBMYEFaknFFLVxFnFLTc1QIV4jWWlSwuN
         SicdDSHXWgXvjq2TZy/aBhYu0T18PbCo8D/BXVGpe7iMYrF5iI3ErvnOqX/fz0BN4lbp
         7eZhWlAYEQhyZs5M5hqP4LZ1YtDFznDnIoEqmL4ZUkA8n1uQEjvHgM7CfLItdIq0agYf
         ybSA==
X-Forwarded-Encrypted: i=1; AHgh+RoRSGoXfXnzjVewK8AL9I8tAsw7MXx91ByexT4Z95pQ9QS7l2A4tLQLdIbyzs98WiODh5GAADlWYJDHQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzluwvrCkOqYLpLBnXkpj6OR1JmPflPhZHtR3GslPSs/4CnSJyO
	eTMOFWTf9UA1HbpRXQJn+34AYKH+8u8Dt9p0HUvAV1tAO5g2uhO3LeZg6aEeL54OBlI=
X-Gm-Gg: AR+sD10FhO4AOnSP0b9C9DmiNUeWRxlwKxqG/3T5h9FcVyDnU4b2tq482N/jNToQKjo
	UZ7NbQ3Ee6aOmcipL9ZleyE7d5cVqL2l+AgGTyPkAEOEaZMdMyhGrqRKwBeiUPwjR9Z67AyKydD
	OK/bhyGch3H/D7PEeAYGYivBc832uMp7ETe7RDKZfwAaaNmr/N9rQdUyGO2b4UPpaKxpfoUciIC
	Bipjpia5/HSYwqJhRGluh33F+krN47MOMR383o/hnCvxElVzcDqroFWD0EXgrSzLx5f5glrQNDW
	qdMbWaT7l3YecP+1WS58ZhE9hYjheFTAnEs9b4UJiYfXA9F106c+ipWe38ztO1GJF+PSvefnKMH
	e7fcL0e2hgel20sC2oxF0lLy8o7XY7sR9QxbIheSKWM5FxdTgrWGfrPInpHGwawcGkdg++qvLKT
	vS2GkIQk86imlZRrWxrXtNZYZREb1dRtdnXP2OGxKUA9f0towYkdtpHHwp0HB4erke+EymUSZc5
	jsDP/Upns5RUldWQFomJByNyWKoHXnaSvDK5G1hVA==
X-Received: by 2002:a05:6808:10d4:b0:4ab:3210:b31a with SMTP id 5614622812f47-4b241e0af7cmr12462291b6e.14.1786838501278;
        Sat, 15 Aug 2026 17:01:41 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b24d92462dsm4347729b6e.5.2026.08.15.17.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 17:01:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Shaohua Li <shli@fb.com>, Kyungchan Koh <kkc6196@fb.com>, 
 Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, 
 syzbot+643a6dd130546afdf1fb@syzkaller.appspotmail.com, 
 linux-block@vger.kernel.org
In-Reply-To: <20260813141456.1625857-2-cassel@kernel.org>
References: <20260813141456.1625857-2-cassel@kernel.org>
Subject: Re: [PATCH] null_blk: serialize configfs attribute updates with
 device setup
Message-Id: <178683849649.1984298.6504743788893693717.b4-ty@b4>
Date: Sat, 15 Aug 2026 18:01:36 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 13 Aug 2026 16:14:56 +0200, Niklas Cassel wrote:
> The attribute store methods generated with NULLB_DEVICE_ATTR() refuse to
> change the configuration of a live device by testing
> NULLB_DEV_FL_CONFIGURED, but that flag is only set by
> nullb_device_power_store() after null_add_dev() has returned, and the
> store methods take no lock at all. configfs only serializes writes to
> the same open file (buffer->mutex), so a write to any attribute can run
> concurrently with null_add_dev() and change the device configuration
> while it is being used.
> 
> [...]

Applied, thanks!

[1/1] null_blk: serialize configfs attribute updates with device setup
      commit: 4e1f23f9c33c156be7e313b40695af5a3a834739

Best regards,
-- 
Jens Axboe



