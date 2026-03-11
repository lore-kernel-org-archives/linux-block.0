Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3B0332EBD
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 01:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773192314; cv=none; b=Ix/LO6iHUotPbITyXNZC26rajo6wX0Gg1HWLPi/DlKZDGK8HFzdxrhQAY16ek4xSqhy+uAPOrHyZmN1lI0Z3qYl+Zn55BYkGVVmUkKCO/ngUkbnXg3F8KFJ40iYiS//Kc7FCnmwKuFFmSvXZF+2DLkEMLsPSkjEAuWQ2DcZqr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773192314; c=relaxed/simple;
	bh=s7vvQBUsvhQDKZR1yzVSBXRRnAb/ClEMIBAxhtwxY3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZ1feSltMI2Gxl2SzVee/miOAu0OSOecnaAVrpPP7PsASCA7hgMvPUaEsitRvr011aEDO7roHGkQAsI1dsgUPrVO49/zsgb+yKh9IjlLa/KwtjCiCd5gzEbLsKi9NNUhRfN769Z60p7zkztfsSbTGgEgOYkNNYQxOJ+4D5wsRoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ktz2jFC9; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ktz2jFC9"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c2af7d09533so8691343a12.1
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 18:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773192312; x=1773797112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bBQTuANcApuDFazoxltcoqNmYct2WzFF44sVelc7tdU=;
        b=ktz2jFC9xJMwkuuSYa0UXZR+CaWMJQKSqIzCO85q1D2lg1TTr9QcYkFeEA4yupKXy7
         zyPIbZgKfU17uMmvXkRrwW6moww0uYNYwPhu8XDoBp2K0DHdOnNGcWrvadrE4A/tW2m2
         IDvpH1dQtZLi/45cziBd2TAwGXcjj0r+gMwd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773192312; x=1773797112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBQTuANcApuDFazoxltcoqNmYct2WzFF44sVelc7tdU=;
        b=MA006FS1oBCrHMnw0/sRhxppffAz+rsYZYkwIsmoF/Fc29dnqhOV5FIAGv0iFCDVRc
         okvu9UxV2p3shY+b/ZyVFeAe1NEzedDXmeqsp6pEKP3K4jJ0ZB0zy4G8uOgCsJasytph
         rkbhI+NmlUzfKu3c7SWfR4AEYH9KyUthtHVM7WVKi9l+pbp/jCmDEVIBILYmjPmO2nzo
         bl+9SFd2vgJre/4Jrzoelxjt6OQiarSvIXsDKU3zx62vj9p2FuouTFE7RweYt3KH/eTM
         J10+tcf3ZBJb9Z5a1D4WGS8gzamN5JkX1Ov3HQvQNVhEAp4pppB3InuQaRUQgWgKLLNH
         7oew==
X-Forwarded-Encrypted: i=1; AJvYcCWYOFyOVUOAKOj8yX5iImH4VYvSmIQ1MSRFnJicH5jtshFVO3iZWo8NXvj4rRFjQRQYzlT/+gq8iKkZVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyofotukTRXnsQXQLYgis/IDrb4JrBsk1uohiQFq1MPBC3SQVu8
	R4bEWQXloqvL6LoLbW5ACWEdUDKgRtV6BhIpw1j197WZZ0p5iv9qIbIo7ePhUR394A==
X-Gm-Gg: ATEYQzzS9IV4y6KdFGXKheUBPcta5mGg12gC05pk7r/lhUNVwy2Ri6/owiWHjuOAPhF
	+krceMSruJ5RMeHXtjVmni3nYjRMeAOaH2CIwqHwP/nkq+iKT/U59H3I//+i0JirRt4WqIC+SFd
	l6ee457ZTJ9OA4e7kExwUp39OMlRk8f0bkP0Sb7fYUlNWjIba+YjZCxRt3ze+jKgml2LSJRD+xG
	gPpQbCirc4t7dQaO82STUw0g+UyPGX0xfcG2F/IUyWAOY0+GsfQ568kfWOTkf7YunixPQ52S12b
	XDJK41ia6L8EyDgdXkkknVbD6wy4dz3gLJM8OQccFFVq5x2PHmvefk4v8wPQvGSpYFusJ/msi+4
	Kyjld/yhC93cVK2UaxIWSkjNbS1h4S3vky8YlfJ0zKzLpKdphnOhBc4XwIZCxC3OL3SluP68vHh
	bQhP05dVN3jrHgIYll5fDKNZCOZis96M3N75fLGT99bvDWl5kvkhgmZdlx6C1ozgw=
X-Received: by 2002:a05:6a21:a393:b0:398:6fd3:7696 with SMTP id adf61e73a8af0-398c612d5f2mr542619637.59.1773192312444;
        Tue, 10 Mar 2026 18:25:12 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:93a4:8281:fe98:426a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf9f037sm416557a12.23.2026.03.10.18.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 18:25:11 -0700 (PDT)
Date: Wed, 11 Mar 2026 10:25:08 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: gao xu <gaoxu2@honor.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "surenb@google.com" <surenb@google.com>, 
	zhouxiaolong <zhouxiaolong9@honor.com>
Subject: Re: zram: Optimize LZ4 dictionary compression performance
Message-ID: <abDEHBAYV7F7jX2n@google.com>
References: <ae51966c3cb445e9983230243bb6a5b2@honor.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae51966c3cb445e9983230243bb6a5b2@honor.com>

On (26/03/10 02:54), gao xu wrote:
> 
> This optimization improves LZ4 dictionary compression performance by
> over 50% in Zram I/O tests.

Can you also add a little more details here?  What type of
a test, actual IO numbers maybe, etc.
