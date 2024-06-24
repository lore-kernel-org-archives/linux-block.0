Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DD113665F
	for <linux-block@vger.kernel.org>; Mon, 24 Jun 2024 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227097; cv=none; b=njKE9Kul2BErv7eIaIpTIU7OyfiRvGvmHcecj4d6fysMyA2QRuK+EIjVlZxHYYlD7w7sDCJi1V3gAp2KddBorG5D6sOsn7KzxcEmYYCeXF8LYsTlnIouEDS2DX3pyS6ugw386ieqetM1Q82BHehdrAOWJMNcYJpiQjkY0XgZAWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227097; c=relaxed/simple;
	bh=Ybu1fiG+TyEyq+dwsSQn71urH1cpmuRYgZa07osCrh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1V7C/fDxxXK4+82lRZBUM1xeMrPrb4M+3N2EyRKu6KxDGOOaUtOz+kiG9WEm5llSdB6JyYNYOUUXdK0L7G30qLuLsaSh7rfJYYuXDusqZmAeBRO29pThHg2MhMeAPjnmGB8LuHXPn5cpzd55hCOmMr3Sf5/Vr3LQ4+3Leb4/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JibFOj/L; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JibFOj/L"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec50d4e47bso26225211fa.2
        for <linux-block@vger.kernel.org>; Mon, 24 Jun 2024 04:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719227094; x=1719831894; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYoZj8gmX+2MOD2HSKn5qCjtY2YgKMlL370OvGOubpc=;
        b=JibFOj/LDVCZv2S+oIGPxsF2V9L+QshbdzeiRjjDnz4okOUvHKJ2nL8TNq1AlqFs7P
         HdSUjB+cXA6F+ijX65eBmKWs0Rcy3lCHYxNoeFzT3lhvXLtc3HRsdimghRRWTV4x06Co
         FPH3a5oQkcAyhz2rhjbBL18W0nGcjmOVuC61pjodee3sk2DCh6YhN0bIm/urKcVRXWKh
         vuDr7GC09KaJN80bF/92WX5dvVlt8X1oq0LO4i/taqZLL7AC/mxpIfiXZDNPClJb7yG+
         nnWMPKPTNp4YPQOCKNV2Il0NQushG4b4tWspwrsIpCJFgxYph8ZvmtzEnK7NzeLKH8ml
         kSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719227094; x=1719831894;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYoZj8gmX+2MOD2HSKn5qCjtY2YgKMlL370OvGOubpc=;
        b=Pdxu/z+gpczCEMnZ8bLQk+lIOFVhrOw2QfKcx1QPM+xh/nvngnm73h/mvEz7bcmy/e
         BTs1znKvLhGaY2cRM+7580qgyI9gYblHxANtHdF2oz8J9fp5NUgX6LhD0PnSGcU3bLIW
         OTI30DwaMKYpDwdOcvQ3x0aDAZroYnuwDprm9EEIgUpklllV/77dMkGEUyKS3wlw7HW5
         NwvT4wjpak9n4KrHA3Ke4wlUe61bGlO4LotuonTOIZ7KclIUdgIWblwXUftVAnbdrjNx
         u2s6+anrf6f3hgfjoqQx3za3tApi8T8t8idqAuunq9+mlKCqWQsx1JwsztDPXSC722AY
         gEIg==
X-Gm-Message-State: AOJu0Yx6O5hjkkz+sQUx2BN1w9rFvJV1BIHgkCba+ulaMBfLyxtwYcMK
	6PZejXK/7YKKNnJr1wr5lh/lZyJxe1BLqDsV/7j/SWc7Nk9cdcfABbWuNf2Zc7M=
X-Google-Smtp-Source: AGHT+IHAmz0r8altnY0a3NkkBlG1CahkQJGOD5f56GIJJWvP4Z2vt+jffZttlqaNpZyipTheXyJczg==
X-Received: by 2002:a05:651c:2cc:b0:2ec:5b8f:c792 with SMTP id 38308e7fff4ca-2ec5b8fcc29mr22669201fa.43.1719227093672;
        Mon, 24 Jun 2024 04:04:53 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb9c1a93sm60022755ad.239.2024.06.24.04.04.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2024 04:04:53 -0700 (PDT)
Date: Mon, 24 Jun 2024 19:04:49 +0800
From: joeyli <jlee@suse.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-block@vger.kernel.org, Justin Sanders <justin@coraid.com>,
	Chun-Yi Lee <joeyli.kernel@gmail.com>, stable@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jens Axboe <axboe@kernel.dk>, Kirill Korotaev <dev@openvz.org>,
	Nicolai Stange <nstange@suse.com>,
	Pavel Emelianov <xemul@openvz.org>
Subject: Re: [PATCH v2] aoe: fix the potential use-after-free problem in more
 places
Message-ID: <20240624110449.GJ7611@linux-l9pv.suse>
References: <20240624064418.27043-1-jlee@suse.com>
 <e44297c0-f45a-4753-8316-c6b74190a440@web.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e44297c0-f45a-4753-8316-c6b74190a440@web.de>
User-Agent: Mutt/1.11.4 (2019-03-13)

On Mon, Jun 24, 2024 at 11:27:53AM +0200, Markus Elfring wrote:
> Please reconsider the version identification in this patch subject once more.
> 
> 
> …
> > ---
> >
> > v2:
> > - Improve patch description
> …
> 
> How many patch variations were discussed and reviewed in the meantime?
>

Only v2. I sent v2 patch again because nobody response my code in patch.
But I still want to grap comments for my code.

Thanks
Joey Lee
