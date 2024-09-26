Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C743D520
	for <linux-block@vger.kernel.org>; Thu, 26 Sep 2024 04:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727325246; cv=none; b=L9Af/K9uECUQtNNfzr5+ze8hIX8UDVOU7tfHFEksgy5qm0FHrn9pbnmmRpXMui1wMfX5WYfVYYaKImEGt38CiNKAjEkMAoQ1Tnl7odSrs0v6n/ItqQnKJv4TlBfUtk0UBoMqFweNz1GvRuMD6jlWQ7gZt+2Pq8C/2hMItveS9bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727325246; c=relaxed/simple;
	bh=5QaxRtO+rvsOKCMKZhiVUHkG5EXV12pJLC3tOZSTRq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4qk3a2KsAoxDFVw1pUxELUtaCDABvzaZFF9veDtKWhcd2Fi5VLs7kXcnqpb+FAGYbUj5p5I7I/i4CC2f7+lZuDsbfu65wD+nrNs8/QKzlgFmafP38EW3CdODSoecygOKQ74klLCoQeVWs55SBIZDLQ70Xeu9SW7EqpqwsiEFJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IxMvyYAk; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IxMvyYAk"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2055a3f80a4so3103335ad.2
        for <linux-block@vger.kernel.org>; Wed, 25 Sep 2024 21:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727325245; x=1727930045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a8wKFA6z0EGqLgUDfi7jAr3CSIIRzG58X2FAI944fjM=;
        b=IxMvyYAkAyhfym2xFmffE9V3DMaGF0TzkM/agyXqItpn5+YfHnfOXj4hGFtwi/wZLc
         ZgYV7ViNgoEmgu8Fb6v1Qxc8vmEXqex8ipdBT3dN43Pe/dOrY4EbOhYO6clXAuNSd0Jf
         9cxCx9qssgeVDKMSsOL6JbMdhkAoo1qUYnwtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727325245; x=1727930045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8wKFA6z0EGqLgUDfi7jAr3CSIIRzG58X2FAI944fjM=;
        b=Pud18sf6Tw8abydYozbW0xYDnAKLvIeRt6CJaoTZzHKDICc9by/zrr9vgvoDTJ3H+b
         UUWULHQlZfz3bmqtS4wKS4SvtgF1fKn4nEDOVldJIrIRZt8qg+4zR+4fCtbvvnzCeBSA
         WMNRuJQ9KGGn0cgCW+uwYH0cs8U1olw+h10gFJhmqGk3pAoDCj458ykLYnTGmnC5xh4O
         i2mFNFKEKt+WJyW/oGe4aNwXGJxJczMFe82OWLWi63NMtJCDT+lbeJoaI1GsCfBKWWVJ
         QbGK61Qp30ShFr8Kk/PG6sJ6X5F25iBBvD6W9PS5R4x78o6xGo9+Cw31EZAf4wD6nuKs
         Fc/A==
X-Forwarded-Encrypted: i=1; AJvYcCV8q/cra+2+NpELyshdShbhhGdtNdfRGPFGLNm1Rb17n6eIrW4IMAMhmyvj7DS475Xu2yzA7+9MI4QAqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKG8tdYm4ImlcqscWkpcBReQeq+GEysTF2aduxtpdunR6X1NLI
	nUj69ixJtAiwsekyOt/nsDmO/KjVzfGlNM+oUflBnhCfkUhV+aK5wD0XgZrSOQ==
X-Google-Smtp-Source: AGHT+IGbEwOBfZ5TByxl82LaGD3iOlIihFjX79877NArTr0fFnqTtlSPCRwVaJBJ74ui3K9S5JMocQ==
X-Received: by 2002:a17:902:f54e:b0:206:c911:9d86 with SMTP id d9443c01a7336-20afc42ac6fmr76804585ad.3.1727325244833;
        Wed, 25 Sep 2024 21:34:04 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:1560:84f:e0c8:d5d6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17dffdasm30812165ad.176.2024.09.25.21.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 21:34:04 -0700 (PDT)
Date: Thu, 26 Sep 2024 13:33:58 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: senozhatsky@chromium.org, axboe@kernel.dk, gost.dev@samsung.com,
	kernel@pankajraghav.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, minchan@kernel.org,
	p.raghav@samsung.com
Subject: Re: [PATCH 0/5] Improve zram writeback performance
Message-ID: <20240926043358.GD11458@google.com>
References: <20230919003338.GA3748@google.com>
 <20240925155314.107632-1-jassisinghbrar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925155314.107632-1-jassisinghbrar@gmail.com>

On (24/09/25 10:53), Jassi Brar wrote:
> Hi Sergey, Hi Minchan,
> 
> >> Gentle ping Minchan and Sergey.
> >
> May I please know where we are with the rework? Is there somewhere I
> could look up the compressed-writeback work-in-progress code?

There is no code for that nor any progress that can be shared,
as far as I'm concerned.

The most recent writeback-related patch series (WIP) reworks
how writeback and re-compression select target slots for
post-processing [1]

[1] https://lore.kernel.org/linux-kernel/20240917021020.883356-1-senozhatsky@chromium.org
