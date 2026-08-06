Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0598C314D18
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 03:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785986582; cv=none; b=iRrSAVVHAOZK2WR1/iFgDHBOivN01b1ihQds41d1C4Q/ugz45PUs2j1Ee4nYKFxEY3GrvbWxoXBcacTVFYB0cIL23tV70huzCOhWZxxL49MWdmPNZI4Ppt5NRSBFS2xK35H/2BAsGDHoj96B6ZlbgVCmkmK4De4gjtME5YlEZnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785986582; c=relaxed/simple;
	bh=lONY8w2fmvTBw5LlswnRi5d1jrGIBDffmxXTe7DfvEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJ/tKjoM6YiFRQiF7dzzF7yMypeMBb6p7D3PHG7YAAUk376hemqej6K8LAlA3nte1Vicy6ajyZPPUPV36hHoStdMVlUEhhEHZHXQBldNI/v8ijWeqhFQTbaKv7vnbP7IDDUMlFFDIoWsczONMK61mxDMzCo2QbcDbuAFixjaydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MTjbk7an; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MTjbk7an"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso2077544b3a.2
        for <linux-block@vger.kernel.org>; Wed, 05 Aug 2026 20:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785986580; x=1786591380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LK229z3Oli/D7ny26DNtak6xHVe6My0e7uPt/sOAXlA=;
        b=MTjbk7anTY/ZLQbF//CrU1L0DanXLrgOJIWh2ipSf2jBEn19M5+2Cv03VB/hUiV8H5
         q7CJ/DGnPGo93IBLiEZzFOt1eYPjJzmLWvRaPk0Ih/iXaYeCVabMDS1P6EZpjOX6PHpC
         pSj2cDtkcRV7AbOkYGe7DlOLhaYg1F0c5yews=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785986580; x=1786591380;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LK229z3Oli/D7ny26DNtak6xHVe6My0e7uPt/sOAXlA=;
        b=DkHv7ljnyCRt+4BnnGA5dz2vfsbjrHQgVTtMzaEyi0AnfFTaSM2zkOcPs/I7lkx1sr
         +S+UBlpyl0SQaHWXN+vArREtZBtSOtZ2fQppIIGJAARL/9qnO3xgJa+aZXzlFwNzV00H
         L84EyCA9oqWm5uEe2U4HOD7WHcD0BZlFEAiPVqQTMYVyt06VZWC3K24ecc62lw4XAgua
         QXtO+15ETPYB9+TQs+pzharr7JINB07W+uVGuYNbugH3BO/7fbK3xnmlgV/l3HBH6GBj
         n6oxmrDwI4CC2bihS6G5RdLvmhXZ+nlE0bPrdt//vKyLaf0ZEOuy36WlI0FyS8qbWQIA
         y2NQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJEm8z6tizKat22/EG1yffKSV5+73RYIyI11Qa2KDBinfRXMhfvCvbAdQSQuN/qjB69Srt6ijJTvgIgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyA8nHUNh1RdeI6lHOSpTWbBx/MIeF67dJyaJTMHFZdUk1rNEdi
	1TE52PadI9NdQok7b1PUtntJEfznEpTgdC5b+aBKZocKLN7ghe3iEWtmwNsjjSDjFw==
X-Gm-Gg: AR+sD12X2c6QijAGkUVKEsQc1vh37ppbYzq9OjVP2piaqFe/SAPG80BD8dIW1lKjI3c
	RaNQWnws6yfKih4CaK81PnzLJTzicwKxxvLUCnGekHjbAHVoB23SfU1uuJiXD1Ta42kitMCdvUT
	lfaMghpr//YAkdfd38P6N1zI8vaYRFe3NfJI52WfmvpUAqme7SQMw8bODFhZdbFAMZpSDErRFPI
	IY1ZhtPCl6QfJTuRJnbXF4AMj/9jn3lPv9jJFKwo2O2tGrlJ4ee/jh+b5wA+MHnAWWfY15SvV+S
	X1dvU+xtfDA8WqaR+0/LLLawIT8NZ4+VKo4fPpzCx8DVtMERNRO13TP2tGIHQtNcn3BCKPAvIfB
	cf3OY0mtfbTG79IGG3OS5biiyfFoduQd/nL5ZmnlAZcyrty+c3wiSogsRPIM3lLM+MCv0qrrgRK
	fiPfb7ibZHB6Q+aEj/Jj7OlLnAz5s5x2C76ydsYfrT9QW/gYGIzkKfKc/brd28z4n2htJDu4yoj
	ytGAbFNizGk1j8c9HXb9qPxClsj
X-Received: by 2002:a05:6a00:2e19:b0:845:4928:8655 with SMTP id d2e1a72fcca58-84f2e0edaddmr10872408b3a.39.1785986580270;
        Wed, 05 Aug 2026 20:23:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:8002:2a47:a704:5a58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f4538bb3bsm397524b3a.12.2026.08.05.20.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 20:22:59 -0700 (PDT)
Date: Thu, 6 Aug 2026 12:22:55 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Longlong Xia <xialonglong2025@163.com>, Minchan Kim <minchan@kernel.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zram: switch to unsigned long indexing
Message-ID: <anP9rQB1EgHkLC4J@google.com>
References: <20260806031640.536615-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806031640.536615-1-senozhatsky@chromium.org>

On (26/08/06 12:16), Sergey Senozhatsky wrote:
> Date: Thu,  6 Aug 2026 12:16:32 +0900
> From: Sergey Senozhatsky <senozhatsky@chromium.org>
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: Longlong Xia <xialonglong2025@163.com>,  Minchan Kim
>  <minchan@kernel.org>, linux-block@vger.kernel.org,
>  linux-kernel@vger.kernel.org,  linux-mm@vger.kernel.org

Ugh, linux-mm@vger.kernel.org is not a thing...  apparently it's
linux-mm@kvack.org.
