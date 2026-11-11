Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794372296;
	b=qqdoClDejO+vT2iwwyyJd+EdfVpJ5UxteVX197YLlNLALI7P/OD6/QoE/UEIRvbd9mVr
	 KtiBwM/dE1l0XqyshUgSc9TNlbncYZBv1MTnQVktFj7+IPsxhy3UqWfSgsX2kggcfkSXx
	 69jZ28O+QsVAZo0l1BHnrinDG2V8y+rfPx7O5E1fzn947eZdv1JNBiFMoQ3zIe6LYjoHo
	 ChM+pycuxWMP34mkI/Vg3QeV81AfOh2Mdd16I0IhHkr6O7Zypk6x3mlMEa4vCde6MKbVH
	 grR0zQoTKPDwjpq4NVoWzeltgPAGxuKaeLTkbL06V66LV1WeOSaEcBRe8wWuXBN2jFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=KoYYrzQCypT7hiVPNIFQ9/YTWNz1K37xLoWsOPOqb/g=;
	b=zEiwU0gInKVYK9wzoCplzJY3hmjTcN/GYChd6+F4JnAL96XAInrTmWXsT95Nl1Mn9cba
	 /wJH3oET0uctyKZa+2fvQKFH2AMbeEkn3q3cV8TOCabXZb+x5DiBeSjDNdbmgItwUbLBj
	 yA6SWnmnA0YNubq+3RS1M20obisSyOGpqztWLae+oCpoP/5CFrayKfm2fzXKEB2HdBcrm
	 OjsCgJcX+AKT3bkS2uM8UxwgNxkI1pt1gzo6+o4QzwVmHXM6ummoRIj6U1qnonKbQ0Cjm
	 KQsQUtcFMLwKEvf/NC1ToG0OUaRjgCcr8Px6msLIXlZ7j97EHLBgX35VQdFxSNs3QZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=clUU+nVL;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D8360A260B
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 04:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45D8360A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=clUU+nVL
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so2256953a91.3
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 20:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794372295; x=1794977095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KoYYrzQCypT7hiVPNIFQ9/YTWNz1K37xLoWsOPOqb/g=;
        b=clUU+nVLi3g78VSHR4IbHtS+EX2/WopjzD4YtK9dLlnxn8DhvsIvLE/rPMCtgiZPAD
         RMVEsb8O5AGRKTbCix4KZOgzMhE7VT/HxN2bm3cXHMtzxsj2gcadmfF12cFJrARTs8hJ
         9QD+WAU6tcuJSIQ8qOeMV0hIAmxhVD5kMKybc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794372295; x=1794977095;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KoYYrzQCypT7hiVPNIFQ9/YTWNz1K37xLoWsOPOqb/g=;
        b=EOWb1v7OLYb+iqY41fImrN1YiusOIx3snlw4jjouQGI/cSx9uPLh6Ii2kYCeLsUo9j
         ViRW5j7Au4YiteVA8mNjSfrWb6H626RuiRli9vVZaGRQZSG8eE/jz7BM1gBD7C8uPixR
         2CkmfNe6v8CrOdNbx8GKTqIlgPDQSvpgnh2pr5Ls4WHeypepukT3Y/0jRzvbcNIR50Za
         9H5vMFnJJlsLMFVy10oFFe2Llke2BQ0dMQ6j3czj9SiE95BaLMPxE8e11sd1/gG1Nddr
         4glEfKP6cnQxl+AxydScwf+6Lwyu63NQ0IKpoSn6kai3Oc+l3azK71saFnPnONYQ8ZJ3
         p8cg==
X-Forwarded-Encrypted: i=1; AL+hErGNVa27ms5zqCvtYlda0tj1WAjxMYSUeH6BH0tJuZiSlc8JmDTcDbr14driRPy25SnalqFTSkmLjxIG5Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z/YhUawLA5ohlDTJJCFrFQ4dFRFkqvok+iYtlQ4bu3nEZKRAor8
	kanw58YZ920zuTnEHYwmNGtbzxjei+QY1EA5Epwzmp1IwwIVvUoK+kTue0BzETSBJQ==
X-Gm-Gg: AYBFou00h3MqpcCuxpybTkJ3I0wdWRwtrxCr6yXiDHJw+4H9PyaEEMuSpWLIa+UmX8N
	j5etAChI250wqfi4KweSj4pvlbwM90K0wjCm+HyvTaKFjVt7QVIvTpcJAk0+fUI4+ZfgTHN7Fkn
	ywGHoDc2Ur7hDopR/t0QvHvjiqSP3+QXE7VHid3FX1144QR52qqD2dQOwbULo2s0Hx+OKUhgXz9
	KzHDqN+/ySrEUsT9FZK97eBj8roJMgPUrdu1FfrJ96LL0CL9XIFLL1VWgVT066QVyLGTpOdu0Xa
	hJ2SmIJU6pqtRvZPx72iA81DGcpsg486YuR/9l+owcveccAbwqmwqLaa1ClDuTjGQ4vFCA+N4Aa
	yn75ZTeyKh5IErfDb9UeUZXQ+ki8oacVwCgG9MecmqtqTdSlx/loPBsnJ8dgpbXJO9mHmJivhDs
	MyQKvw8pgUIUD5PwYmDPrNveHvvk766R6j9KZrAfZmwma3RZg1cm8xRph//YHDfj3Rg2vMG0niY
	uFHTu3NKmYmM82RvJJ0yRAxBUIdbpjL7e4isSGmkLVmBwVdAYSJeirvUeKVBd6xlRrNTB1vQYeh
	ZgskKJwX73bvBjec4SJ+fgOi0onW7+I2F1c0s+g0OKlLSSqwkZ+TMnhXgNKRdAQqE6Q9Pg==
X-Received: by 2002:a17:90b:17c8:b0:3ac:a521:95c with SMTP id 98e67ed59e1d1-3b182f1b3bamr1359541a91.58.1794372294543;
        Tue, 10 Nov 2026 20:44:54 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:ad6a:b446:df00:78dc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db5cc73sm2535622a91.10.2026.11.10.20.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 20:44:53 -0800 (PST)
Date: Wed, 11 Nov 2026 13:44:49 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
	Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v2 08/11] zsmalloc: encode 1-based obj_idx so valid obj
 is never 0
Message-ID: <avPyH5Dbb0MI-JXQ@google.com>
References: <20261110054836.1515030-1-senozhatsky@chromium.org>
 <20261110054836.1515030-9-senozhatsky@chromium.org>
 <avNJ0p1v6FZ-wnQE@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avNJ0p1v6FZ-wnQE@google.com>

On (26/11/10 16:44), Yosry Ahmed wrote:
[..]
> > Store obj_idx + 1 in obj, so that a valid obj is never 0, and adjust
> > ZS_MIN_ALLOC_SIZE so that the largest index still fits.  Unlike a
> > separate tag bit, this doesn't take any bits from obj.  zsmalloc did
> > the same before handles moved to handle_cachep, see
> > commit 67296874eb1c ("staging: zsmalloc: Ensure handle is never 0 on
> > success").
> > 
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > ---
> >  mm/zsmalloc.c | 19 +++++++++++++------
> >  1 file changed, 13 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > index 3a6a7253fd01..aa436df0cc4d 100644
> > --- a/mm/zsmalloc.c
> > +++ b/mm/zsmalloc.c
> > @@ -61,7 +61,8 @@
> >   * Object location (<PFN>, <obj_idx>) is encoded as
> >   * a single (unsigned long) handle value.
> >   *
> > - * Note that object index <obj_idx> starts from 0.
> > + * Note that object index <obj_idx> starts from 0, and is encoded as
> > + * <obj_idx> + 1 so that a valid encoded obj value is never 0.
> 
> Well, this may be a stupid question, but why not make obj_idx start at
> 1?

I didn't write that code!  I just resurrected 67296874eb1c! Just joking.

We use idx to calculate offset, we need it to start from 0:
	off = offset_in_page(class->size * obj_idx)
