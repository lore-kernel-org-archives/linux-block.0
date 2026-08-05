Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9483F42252A
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927141; cv=none; b=usC7mQ/dYpyuWrNGq681KYBAyVdU1ruBDX7lRtBZLmG9pBU0f00G2Pt+NBZHHN9AWQCYb5Z3EU7faNJkj5gYIAT1JVovA14Z+YkKYEgXVv0LsGXSEMYOE6KBexWIROu7ct/VqRaDRN6wZ6LuUtWeCu5MBy6j/TDcwTPH3B1VFQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927141; c=relaxed/simple;
	bh=eP5zT19otmavZYh5jnGMqz0ktdAeVJgmyjcd+gz8ImY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvm4JWxkGqmGrJABBeyqUsFAwq/N165uEDX9dXnaUXoTKrg7NBCvW7FfbdjQdX95WvcZTbiM/aovY0nMled1na62F5CiN9ly9PqT2I7tQmtmPSp9nfOnRIhujPvAajFqZ5TMhHEERHx42+QE5AxnBUFkvyPoKso+cRmETLOrF0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V0u4IeNp; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V0u4IeNp"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca7c1176317so700394a12.1
        for <linux-block@vger.kernel.org>; Wed, 05 Aug 2026 03:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785927138; x=1786531938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=41H3P09sKw8wwkKnWV642RHA7jFSxWcxJqByp/NmDs0=;
        b=V0u4IeNpm0UBpYa8FDO0F7/a5R1KA1+Wpn44fLWP5imSktgLrFafUz1pXukG5ttxWk
         GHqaKugXaJ4P1Jl6HLJztnU/JpxaghXo59+7I5THv0zLn8Y7ZPTkT2yhpMmdoCxmM/0d
         8l5uUACRbbpoNAzbMoSEZcYrsjh8HTLLRLIxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785927138; x=1786531938;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=41H3P09sKw8wwkKnWV642RHA7jFSxWcxJqByp/NmDs0=;
        b=qBhaRicdPzTEC0N3qDBblznm5hWg4VBSwHmIaDSSy84wNSooimwG3o5jGQ9diFEOtM
         97jdSQISmPzzb6Ce3HR4Z5f4/Q8N4Sf/wVKul2slWhs/AovmJ8jii9x6eOu3WOOCpI6t
         89bKukTsPvQ1a7o10Nk3y+NfQ6Nj9DYFfuTZ4epBX8W5nLc4GHS0i2kfgX0OPt/wKAr8
         VYq8uxOqS28nnFzJz10iGGrJ3Dgvjm2rH/wgSBq3yDN/RttAefEvkVsiVRlpdrzky8sf
         srUFtu+dvzxOp2ZiPMvXbWCARqz54x5CVArUUuNHqKb3SDkkvSZQsvbKVYBPORCpYdiK
         ndRg==
X-Forwarded-Encrypted: i=1; AHgh+Rp4r7IQTBqyfr5bV4WG0O2r/wpv/yRoVi2FkEQVJ5DutCc0UDvOjAek4wHMPUgQ0lGbGQclvGAJ5qUuzw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6epw2u9reYrbfuc34vDOdZi7AEJb6ZAdUnzpgffHzWfMSOj7z
	XSOASgLoMBNDKS9QZgI6s2/NzkdBJfA+4zzyTGj4sM+GqRpW/xjwpBV1W0BWqsSBkQ==
X-Gm-Gg: AR+sD12jWdWg8nRuJrd7mPUriIAR0Hd2IpxNKMQXKtrrQgH1xBWiAHCgjTaF+QasHr1
	PHoz0LwLrLOBursQblJsHv6SPhsZ4wJ7frGDaBUO0Wl3RNcS8xxQpNAvcWGOb+DtfJnAIsnv3CA
	YFg72RnrGkishYrwIcuj0dkn0qMNlzNmXPykpeoapudCRB7qQGHCqJ2tHIwqeBXlzGOZSKw/00S
	zkYr2SGLuY49u236OcUXt8DFhoKANvUtyfv5gq/y1Q/BNSGfRjUurcMEVkGdfoDHBg84gYy/2HG
	qSg40oa6SnaXGUOGm9pmPFw7uJr3wDVV2aZwAGg492mA8anATGiLyzNxlSQJ1q2ToLfNlSWG0HX
	nTbiy6ywEd2yUG25jiMT6WpBzzJdsWg8xeAP0beqCenujIMkuNzjdoZquPF5yZ8sA/jft/15b7I
	WI7V5W9Lncm16C++N8WyyktC81RWNpi16h5nYyjxAY8GBl2w2sKhOYH4nJHskOGpxXb5V/ubKF7
	pRpDXLGrvgkQuJdsN5eI1M5qzY8edB4JgmSiVE=
X-Received: by 2002:a05:6a21:4685:b0:3c4:3321:4fe8 with SMTP id adf61e73a8af0-3cb85dbd1ffmr7117853637.14.1785927137918;
        Wed, 05 Aug 2026 03:52:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:8002:2a47:a704:5a58])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe708c0e7fsm1281577a12.21.2026.08.05.03.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 03:52:17 -0700 (PDT)
Date: Wed, 5 Aug 2026 19:52:13 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Longlong Xia <xialonglong@kylinos.cn>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] zram: freeze device queue before device reset
Message-ID: <anMVoqIwmubZj3wY@google.com>
References: <20260805021854.1057715-1-senozhatsky@chromium.org>
 <anMQTJeiBZUHX2Y_@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anMQTJeiBZUHX2Y_@google.com>

On (26/08/05 19:29), Sergey Senozhatsky wrote:
> On (26/08/05 11:18), Sergey Senozhatsky wrote:
> > Device reset does not take into account in-flight async IO
> > requests so we can free meta table and reset device concurrently
> > with those requests being executed. The block layer guidelines
> > indicate that queue state should be protected by blk_mq_freeze_queue()
> > during teardown.  Freeze zram queue before device reset.
> > 
> > Fixes: cd67e10ac699 ("zram: promote zram from staging")
> > Link: https://sashiko.dev/#/patchset/20260804065919.3970386-1-xialonglong2025@163.com
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> lockdep doesn't seem to be happy...
> Let me look into it.

Actually I need to look at the report again.  I suspect that we
maybe don't even need any patches for that "async IO vs reset"
sashiko report.
