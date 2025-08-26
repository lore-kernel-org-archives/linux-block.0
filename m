Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C22E9EA3;
	Tue, 26 Aug 2025 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756239165; cv=none; b=Eav6M+cryHA+wsgJjlW8FZQFDjkM4o26w4lKLyXzw4/UHzsHm+OUSjqaOoJqVLv997GqKwv/sdOoXpGN7juLhf14thHCFSXaH8/9h7FB8BEPgOKQga4pwHA8WPW0yw+nA8BzTldRqUemyir596dOU1WqNyXJ0zA9ds50ErDk6Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756239165; c=relaxed/simple;
	bh=RmglgdKiaAkIymyJEKmEXRq/SpFzkirOA/7MNlgJTcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLOvEOPNSb4oR1gmXoxdh8ROdqg5PZXbAsWasZ2r18cHBULN1GvVZ/1uJtgxWxn8zuDlDX5+BNbnVATgGIl8hQBEkFECtuBrSI4USADxe5H+M8dtYeTldUb+29pFZzHOfHKpAscvJIkGFry5YnWXU1N4o2xMoJLvJrsl7DmmEl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwnRZW/U; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwnRZW/U"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so5681296b3a.0;
        Tue, 26 Aug 2025 13:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756239163; x=1756843963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yZUUI0yFjx4Drp/i9QRBY6PhrGAJcR8oUaxxKphl128=;
        b=LwnRZW/UIRjEJvaM2D+NMLMrrjftQtym2R6JXLc1Bg4X5Oz4NMzKzGj0tUGrb9iFL7
         VyvBGDSqIeARz5unZCI3MzGqytf2bYdEC1GkuGCDGHTMOUFU9QJ41WNju412W0PmtQMw
         /cBENRgH8chb57gLgaOEO7JGhmc2IYCN9uXF6LwrXmBtlncbRZ6njtr/6RtjXRtJo+bl
         X0H6p9t9pRA6Xh+Tlq/GCgfsZG2bxroqpTivRzvG0/K0RWvI2uqvgp5/O0VoQKH+7jM8
         TEhjLZGGBbBFjWlPhiwLYWeNLoVwOkW6i5mQBeuAZ45pDvJqeCsk+sRkiRq2IBl5j7Uv
         LZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756239163; x=1756843963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZUUI0yFjx4Drp/i9QRBY6PhrGAJcR8oUaxxKphl128=;
        b=XcZ8XhZVDtG90Y8SjFKxAedW3THdYTEkNrISbA6OPDevQwqQ+4vW6yCJlPxW9G0d3N
         Wf7OOlu8HsD/fxzCtcGqLzSpRLdA6MUe697vLMIXvE9MoueGLDwmoUNNp4imciWr5D8O
         Xj8vTOs4LAeudFi4wIfjtLH0FqVjzTi9rtWHvEjA8/fLZuA+phYXUGx3vAeEPjt7t+Hk
         EO8+9E1x2NlGzexAuBE/qX9KjwvH5b0jiI7XYzpzr7CuEcFrYOZ/u0PQC69AODcHjN74
         FlfLLLRdfPXsOyxHUm2K+Bw/78dNzJ3OBgtqAJ1C6Z2+DE9PhC46BKc4s5Zp9IVqiy4A
         Lwrg==
X-Forwarded-Encrypted: i=1; AJvYcCUjIQ2ah2hjTNWO7R0YNLSL9746DpbL3IOn2iQz/+B6HDKcrh/tDY+uNtgUBXntrkwpBw15cFosluup4Q==@vger.kernel.org, AJvYcCXXahg7f86qGXS+VyCnRI62fvE3ckFT6CLwUl1RiEv67pNW/4Ac/Fe/o4N2ZUTbavTKj09prEbnn7IvRG/z@vger.kernel.org
X-Gm-Message-State: AOJu0YzMsEGbJDU4KZwA8VXfKnwnk4O9zJWVg189EatfvEgQCxwp8rv8
	KadgJgb90T2JZ2klAhJ1kEvbtSrSdNoagdWcPDn4pshnbNGGqHCwRYFR
X-Gm-Gg: ASbGncv8ZK9H4MLNIRULyNTKl6yRXUz4THHJHs7is2RwYq0FXgrTN3WVJalxZuMXlC8
	Z/LMteYlD6cyAOzzofXjD6cxWjNk29RofCelq6tQDAkRhBVftR76nuUOpPmckRkidNhdMrUezHC
	cFTMgQ06XXO6YY0Qo0VKG5WnU0Mp3acSQu0vlrPoqV58D4qcdGQfNweFEGtCzFmqHvtITr9Q9EB
	9NfG8VG+2jB97i5BuoMEqdjcu8a6EgwjhXFC49LNmVvHWlsLHjzcjsnk8lSU6c7HxW8GcyKMJMY
	klU4/nGJylC9Lt0Ex05L//TSqSrPGK3wGtFRR5iZfRMRBR9fe9WGbnYGsLgBINZ9NSq0JQfaO3C
	GpREZFkMnJzjdUxsLR1y1CctMUTCT8AOyo2Z4FovSGIbCAYJSBMn31Q==
X-Google-Smtp-Source: AGHT+IHfG0QyP6TwtbmIGZnRuYGpxFBNC/drydOrZo6w1M6mkbJLwel6gq+DtmZVLKNj9XvXZbR9Og==
X-Received: by 2002:a05:6a00:194e:b0:769:9f87:1dfa with SMTP id d2e1a72fcca58-7702fae1e6emr18957401b3a.23.1756239163520;
        Tue, 26 Aug 2025 13:12:43 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771f4072ac4sm3631172b3a.34.2025.08.26.13.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 13:12:43 -0700 (PDT)
Date: Tue, 26 Aug 2025 13:12:40 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/7] aoe: Stop calling page_address() in free_page()
Message-ID: <aK4VOIlc19qb6_DQ@fedora>
References: <20250826193258.902608-1-vishal.moola@gmail.com>
 <20250826193258.902608-3-vishal.moola@gmail.com>
 <aK4NzxmGZjKvsGz8@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK4NzxmGZjKvsGz8@casper.infradead.org>

On Tue, Aug 26, 2025 at 08:41:03PM +0100, Matthew Wilcox wrote:
> On Tue, Aug 26, 2025 at 12:32:53PM -0700, Vishal Moola (Oracle) wrote:
> > free_page() should be used when we only have a virtual address. We
> > should call __free_page() directly on our page instead.
> > 
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Probably should have run ./scripts/get_maintainer.pl drivers/block/aoe/aoecmd.c
> Adding ccs.

Ah I thought I did that... seems I messed up some formatting and none of
the ccs got added :/. I'll send out a v2 later today with all the ccs
added.

> >  drivers/block/aoe/aoecmd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
> > index 6298f8e271e3..a9affb7c264d 100644
> > --- a/drivers/block/aoe/aoecmd.c
> > +++ b/drivers/block/aoe/aoecmd.c
> > @@ -1761,6 +1761,6 @@ aoecmd_exit(void)
> >  	kfree(kts);
> >  	kfree(ktiowq);
> >  
> > -	free_page((unsigned long) page_address(empty_page));
> > +	__free_page(empty_page);
> >  	empty_page = NULL;
> >  }
> > -- 
> > 2.51.0
> > 
> > 
