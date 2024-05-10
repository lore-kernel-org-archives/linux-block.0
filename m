Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181041A2C0F
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330441; cv=none; b=PdCc+db4/kbSBklI9WW3gRFn5LaxWHQHXwocZRWaRJy/IKyEz9MpOelLljJVKP91e9h2oGTeBbwpBw1UcxfW+m6JdT9hdfSi+4mugHQLiUrF9k5tDN+RA/HgmTJfv5c1/S3NJ2DEwGKu+X6FVmoBy1/u/PoG32ZTYZwjxCloyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330441; c=relaxed/simple;
	bh=JPMH+mm4lMiMXt4zL+tM57v/I78L4rUVEq6LC3xXP64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpvYdBbe6W/AyGKIVUGHT/P9lPdFbGRxYGqOYuGvJogv4DHh+UPgDdR31S5uyuclFHHZBxBS3UuR2mwjnzj6gnJd/qr+VrQWhHLKor91HyLb+tSFkwN/KubPe11Cyw4iHh0gaANAxpEJxkwo+bhwIAyvxi/M4Uv3zdL017U+BMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JE8i56y+; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JE8i56y+"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f0e4212d5aso908649a34.3
        for <linux-block@vger.kernel.org>; Fri, 10 May 2024 01:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715330439; x=1715935239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZomfWJD3t0+7BUAA8nVU6dC0xByk+g2aWDPY0LtdD8=;
        b=JE8i56y+DZ10s4THXa5PQB0cDoyvDghUg7b1x+vH0Itq9Ai29ECFF6JtnTxl0btbk/
         S/MIaEEYG+Pwxqflk+LmkQ6s91lDuXshHa+f/SsrgTU0FVU2ukYiZUYVPuJZyg6mBRcX
         aJiHY49RKJsw8/JWy/BMCzFn2oJJ8Qcu1liug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715330439; x=1715935239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZomfWJD3t0+7BUAA8nVU6dC0xByk+g2aWDPY0LtdD8=;
        b=YmryOTR0JkP89WSg236/apfFNeMlggKGP8XtIgZDby2P38+1QaV9+4rFuSbMnlF1MR
         NCwGxIX7V9mMJ/lhIsYsz7h/TvftHyawdul4Tn5xVWKWGDY9aLFjg5bLvvbRm+HuV1ik
         UdGhOErWnuEJP5IHBNtszzSvdC7GqlP7UfXiKpkWMKArKWHIa9jGmceO4xOD4W+a4k7I
         2F22g6Y3Ghu2Hygj6JunvJudOf+sWqh72tKfBEG7K1azIRtuvVudoItcSnJXHGixpcgP
         p99+nhYPs+O2Z9xAWVgAhs93SlvGg1Tedcuy4LAYZ2OWK1kp+nphiIg+d0dc0PBBxViL
         honA==
X-Forwarded-Encrypted: i=1; AJvYcCXkjRKSTtEVqDIHpMxHuEc46o+WsJiY6TGA0re7fcJF8C7INjSl+Ungc5ER78ox+j0g2abPHbTJBC0kpGznCef1rnsimQuaY3T61uo=
X-Gm-Message-State: AOJu0YzSddVyCzf2JkzZ+JxGWRAaGi7UCfFIjAovOzatDjx6tACnSgFy
	mdY8BmLjjIjxGcWUYjaeuJ0MtilTBwSr6eKsxudiE2qnzujXhx9R0Qon5X80dw==
X-Google-Smtp-Source: AGHT+IGjXZlYHqz/IqO+Uf2rD0hKlsdFl0CNwe7KKovq2KKzmPdZdYnhVD45lL16TlHcC/EZJvrPMA==
X-Received: by 2002:a05:6870:730d:b0:23e:6f11:85f9 with SMTP id 586e51a60fabf-24172c2fac6mr2287281fac.33.1715330439147;
        Fri, 10 May 2024 01:40:39 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:de58:3aa6:b644:b8e9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a66600sm2556666b3a.11.2024.05.10.01.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 01:40:38 -0700 (PDT)
Date: Fri, 10 May 2024 17:40:34 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCHv3 00/19] zram: convert to custom compression API and
 allow algorithms tuning
Message-ID: <20240510084034.GD950946@google.com>
References: <20240508074223.652784-1-senozhatsky@chromium.org>
 <ZjzFB2CzCh1NKlfw@infradead.org>
 <20240510051509.GI8623@google.com>
 <Zj3PXKcpqUPuFJRu@gondor.apana.org.au>
 <20240510080827.GB950946@google.com>
 <Zj3W7OK9kDpneKXR@gondor.apana.org.au>
 <20240510082850.GC950946@google.com>
 <Zj3bFngCxSbO2I4a@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj3bFngCxSbO2I4a@gondor.apana.org.au>

On (24/05/10 16:30), Herbert Xu wrote:
> On Fri, May 10, 2024 at 05:28:50PM +0900, Sergey Senozhatsky wrote:
> >
> > OK.  I guess for drivers' params support (dictionaries handling etc.)
> > we take take some code from this series.  You mentioned acomp, does this
> > mean setparam is for async compression only?
> 
> It would be for both acomp and scomp.  I have no intention to
> add it to the legacy comp interface.

Alright, I'll wait for the patches and then will take a look
at how to use them in zram and how I can help with the drivers
(if needed).
