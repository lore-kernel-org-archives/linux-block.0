Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A351930BF59
	for <linux-block@vger.kernel.org>; Mon,  8 Sep 2025 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340441; cv=none; b=jHqYoAXKI6XXxh3tu5NQ3E6BOUX0kFGcUmzxEwS715HaWT0xAYnIyWo6AgrjcFgGwN8Qmqo/dZwHv7bUCVW2PgpUQbEqIpJy51r/H3jpVKr+xAkBjkX7dCGsVteWVYxJfyvOnDRidNMbuH+68qFFLsVzhJqsnqyUbzf9K4xNISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340441; c=relaxed/simple;
	bh=aYfXtDS9nTGzq1iLtLPltpzgzJrU4XNIpK/2iOHPR8k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a5ndL81Pimt8CWfbVw50GB57td3WePtZc6AEgxbOilI5j0eWixFg1++edlxo6yl9mJMgvXlwSMQJaJYqTgdv/iYxsCD2+zllSVBZIfD2Nq4xrr9up661lBFJlOHrTfxaklo1An9LIf0rs59C6yQD/ayuNPTgYlwzWqcTEMVK2XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DXKYmbX2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DXKYmbX2"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445824dc27so43827425ad.3
        for <linux-block@vger.kernel.org>; Mon, 08 Sep 2025 07:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757340439; x=1757945239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTXnmGqVzM+KWf5lbuMCIdLr1YvWgFnaAhFpjEUGxu4=;
        b=DXKYmbX2sMxccmQgp68DwexLk24qF5Cjumxno8U9HQ+F7F4mjkfd6tAS3Iwrk+8nhK
         62vTt78cFb4R7uRduTlJSntXn3lRUlweRqW71B7eFn0VgwPzbJuq9PLeQz6fm3cy4WhS
         tGwtUhZQSwTW6upWk9liYdeQmX46nrws5H5PArckigSSmI150/G0t+R9tTBILbb+ttB+
         BRHmto0hI/THGx6l4H5TIgZn1c8qrf8PAvinOyNaYeR+5zuROPTyeXVFp2rT0z1BZDM7
         LCCw3oE3JAB4oHUV5CypkbQccHwE6TE3DdOY94gNzU8rb9ITUEn6R8/OK9adjFldUOco
         Ud8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757340439; x=1757945239;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTXnmGqVzM+KWf5lbuMCIdLr1YvWgFnaAhFpjEUGxu4=;
        b=rvVD4Ae6pHYfEudjTg2XRM4JlhTNeemCJebnPB0ppHRDl/7vQYqyyA8tQoTxo9TkNT
         yVqLNUs9xUAlqNpnlM/zLigy7nDqU5/BB4Yrk43hYfHoNoueuRYjzviRBAMYqAICsvGH
         Iei6rtusIq/IbZrfbHMMCowjw2qCx6NqE+Ua/1nmnjipBTp7zkE7sBpbC+AG+Rk5x/so
         gcPetTno/SS0w1ht4JaTMB4xL62Wd4m3W/V9Ga40haIefkwJO7QQa9WX1MgikmIT8vcZ
         +xWzrNFpOHvg/WceT3shiJXOF4HWJ6+HJJkI8mnfjKVQHXt/Tvq4LphdyGTrxYlN8lPv
         YYoA==
X-Gm-Message-State: AOJu0YwgZxl/+sRhqgjUn7pFuUSR8I0/RW101pxRitCKsmCJCGbK/5od
	7fnJiFuewpqx2NSn3MnXe4uOgm5Ydx+9+Qej6aCwrywsR466swDCWZh1YLLRSmzQfL4=
X-Gm-Gg: ASbGncuJ3K4cPje/aYb0xj+bo0+i7gs7nksKW+IAFQ6NMNI+ArAQOVwmO6WXFsHA22X
	gk7f9WggC8jmVF4kZS/G80g9vMPhV85CHMYyakdX+VlEJgr5WBKu6IgCtVPE1lLtpRaZ3ZgWYAI
	hT4QCmGVJi0eU5LDHSqvXCDcvrlQ16leLHRrsQICrq7xTVO28bp5z9fNa/vfDFifGlTH5SPfMAw
	pI4cCACP9JIUB6+m/1Pb5ALHpc0pSNV+3JaeUXU3rSqwc3oz59WlnkuA97XYBB1I9HyNDPF/r+a
	hVWA0yMH62q7U5K1aizdJxTxssq3D8q+8nbfsHK0HtL6o2BAny4+wXzmrFF0oyCGEjx38idEbkF
	FZTe9KgW44J0VUqp0zLNdTLRNYQ==
X-Google-Smtp-Source: AGHT+IEml+sIqWPnOXtVuJ9P9UFE/5M1k7fHXlQGs35EvdbJZOrAOZfeow0XgRPZlzYuNO/4srpyeQ==
X-Received: by 2002:a17:902:f550:b0:24c:be1f:c204 with SMTP id d9443c01a7336-2516f04e1a7mr102871665ad.22.1757340438598;
        Mon, 08 Sep 2025 07:07:18 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c7ecd9cafsm154811625ad.83.2025.09.08.07.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 07:07:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: dlemoal@kernel.org, shinichiro.kawasaki@wdc.com, 
 johannes.thumshirn@wdc.com, kch@nvidia.com, zhengqixing@huawei.com, 
 willy@infradead.org, namcao@linutronix.de, vincent.fu@samsung.com, 
 Genjian <zhanggenjian@126.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Genjian Zhang <zhanggenjian@kylinos.cn>
In-Reply-To: <20250815090732.1813343-1-zhanggenjian@126.com>
References: <20250815090732.1813343-1-zhanggenjian@126.com>
Subject: Re: [PATCH v2] null_blk: Fix the description of the cache_size
 module argument
Message-Id: <175734043756.530489.9271318781482423583.b4-ty@kernel.dk>
Date: Mon, 08 Sep 2025 08:07:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 15 Aug 2025 17:07:32 +0800, Genjian wrote:
> When executing modinfo null_blk, there is an error in the description
> of module parameter mbps, and the output information of cache_size is
> incomplete.The output of modinfo before and after applying this patch
> is as follows:
> 
> Before:
> [...]
> parm:           cache_size:ulong
> [...]
> parm:           mbps:Cache size in MiB for memory-backed device.
> 		Default: 0 (none) (uint)
> [...]
> 
> [...]

Applied, thanks!

[1/1] null_blk: Fix the description of the cache_size module argument
      commit: 7942b226e6b84df13b46b76c01d3b6e07a1b349e

Best regards,
-- 
Jens Axboe



