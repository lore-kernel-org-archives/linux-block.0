Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2DD1109
	for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 02:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705631273; cv=none; b=hv5WxM2pFpA4ivNxq1jUOfbOHVpejSjNC6SaBNiYSasNpe2ZHHt64VrrIkSh5JY09rngZfOKGWNXCVaxYf7dVKTkPIeYijPrSBATw0KkEOHF7pllq6JaKCiFh7bUjf6prwcvho4wH4AwCb0eV0EvzqLkl2X/NmT2D7RiDLqbjoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705631273; c=relaxed/simple;
	bh=edvetmp62ZZxosTVvvpudn8YlxRguP+yP4LfPmqaj/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxQP0g5+5P4ip9b97tzFU1/WAiQpKRpC5AdzbN0oLh9dIr7iGpU9ZYuo6L8fXhKMV70krVAmJuJtkfZWObcHpai3Ot+ru83gObQZKmKEXEEifxcPbwzh61EHiD1ypi1HmEznikPMobFJlEluVyurjyuJ0e1ktkL6qMoYHb5KPV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TA5GZT3f; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TA5GZT3f"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e87d07c07so3495585e9.1
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 18:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705631269; x=1706236069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QQMpEh4LvE69eda9uIzfnkERGeyOwbwYAU7yhuC08lw=;
        b=TA5GZT3fY0FWuOhulHE5N8lbuk90aERZqfnF0LzV0QfmFhRKAByRMLx/PPVXYcHg77
         FtCge6mc00uRy4ok/KY/IaoQ+G6SXoRDvSftOarLnex7RIof0lMEFyGRTO+HPp4REj8s
         Y1VWdIh0Bx1MNr612sBWS6BnyyAVHf4kIwrXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705631269; x=1706236069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQMpEh4LvE69eda9uIzfnkERGeyOwbwYAU7yhuC08lw=;
        b=qp57GZD2Ry1AuQP2yZXX0D0jyqknU13/OcyXnR8B98d8zjYLSxTue7pU3w0+SI4c+9
         8inZ/Q+HS3W4lQpmKl+bb2nLM4nRLBiJomOfiU5VOWNvvAI6npxIiDu0k3x2EC99+WKN
         m48OjjaquHDudb5yeLPkwHumblXUjsvqJGJcptprbM9sf2wfrPyTtSgv+U2QSpp5EpZK
         n/l/x0PnhSaGXRRyNpQIgaE7Kwv1UwR3sQ261LWC3YkZWRLFL9Kos7PuTYDIhntrtDXm
         zjY0cplO32maGS9p9NLesxUeVI+FNwSWdHgaCkF1gyPuTLrJk7bInHuPlpLJHaWoC/c0
         ETDA==
X-Gm-Message-State: AOJu0YwX+d0YJMwox5VMn9uqUwupedZTq79Fv1nZ93QSidn93gGYV4Vr
	f+nh9+EiPSaz+WvBMSf42SYx2mIPIfN43uIFpuc0R5KaHMzR1X0mR0kFHs/tk2/6E8j/R1/h7/8
	T4z+wyQ==
X-Google-Smtp-Source: AGHT+IFiT5StLrUM6EIrHqhpQO36Bfm40V6hx60NDHj9XJGPQNlO6BpDODNqCGC+YksnzVl1/FNE9Q==
X-Received: by 2002:a05:600c:178a:b0:40e:73fb:17 with SMTP id x10-20020a05600c178a00b0040e73fb0017mr1308259wmo.154.1705631268908;
        Thu, 18 Jan 2024 18:27:48 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906301300b00a26a93731c5sm9702226ejz.111.2024.01.18.18.27.48
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 18:27:48 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a2821884a09so18335866b.2
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 18:27:48 -0800 (PST)
X-Received: by 2002:aa7:df8a:0:b0:558:857a:fe0 with SMTP id
 b10-20020aa7df8a000000b00558857a0fe0mr1057835edy.70.1705631268125; Thu, 18
 Jan 2024 18:27:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <78f34b79-cdf9-4240-a25b-90a948490e36@kernel.dk>
In-Reply-To: <78f34b79-cdf9-4240-a25b-90a948490e36@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Jan 2024 18:27:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgHpR8ezS5F_Gx0JwjVMq6oCPz=ybJxf2amFp3XvT6c_Q@mail.gmail.com>
Message-ID: <CAHk-=wgHpR8ezS5F_Gx0JwjVMq6oCPz=ybJxf2amFp3XvT6c_Q@mail.gmail.com>
Subject: Re: [GIT PULL] Followup block fixes for 6.8-rc1
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jan 2024 at 14:12, Jens Axboe <axboe@kernel.dk> wrote:
>
> https://www.wikihow.com/Live-off-the-Grid
> https://www.bobvila.com/articles/best-generator-brand/

I "appreciate" the "helpful" pointers.

             Linus
