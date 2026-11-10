Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794333462;
	b=u4O1BQnbt17HpC3KPOdVMtaQcE7x0gShMJG/34iOqnMuZbzklfOaU5G4QG9KMBFpEDC+
	 kJlAxdt6AZiDbmQz0R3HdGbJ5TYfdHyMH7JWLy3jnMlRatwiK+hxVu3wTSca7fJiB0ggE
	 sIqiOUvZZKBxgnVO8OsChOQtJIDhA8lINKx3tgXgua5hdCNdlzJU9HVsTrJbA2JYce6Y9
	 I+ae/vZ0RZdnOSCEelnd6RMpd/m1gs8IpZ3m/K1MmRFVUIWBiK3wu7abUG5PmSSgnihAv
	 yvu7a8uGZ0fEsA+b1U+s1d/hQwbRooBy4HVNW6HwmQKpeulZB/SKOLGKyFpEMqSXLGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=I9He/fnvIveKiIdStskM2jtFd2W+NnS+TFAR9JUlqKA=;
	b=MxWISfabDg8ltk6PWlvIjdx0+Y2LmtoeH+X7bKG6KLJKjXkkqnqD2sxoF5yqYcnOL4RB
	 EMThhkqLBQgSnzcXF0oToRDoAQfyXpHICp54XSDw75xkGc0f1QuMEoy00dxT3HtexWJJv
	 CTAj3kDnBY/H9xU+iSFf44wTSrxtK1iUu3WJhzI0tnSUYClwlN5rPrbRLrZu9iHd3nizL
	 xnfNrPb7yWWJ+cZ4Y2SeaLIWysLvsPidpPSa+q3fPAKL33Hiyz5aSIvtWmAo81gLFBFLS
	 zhLDjiEzyhEx5NwTBZ09Z9JIW4ckVUpY64DA4VxgUmhSHzFC7uQE/hNEqljCef4zd4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a1DLQpEY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B6B606A200
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 17:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2B6B606A200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a1DLQpEY
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3a49a022221so20572311fa.3
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 09:57:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794333460; cv=none;
        d=google.com; s=arc-20260327;
        b=PZKUmy5nwptPKttHAYj8RHxNGStRCjd+w831vnRjAHVquwEtSy2uNkHWFv8jCXAeEb
         UkmtSCqAWWbVU4/y8cW1oXiL8w+8PhPIZScEObFRBOO/5cMYY19EVGiST/UeGFzswNpp
         fUcP7lsxLDJPEFTa+smUbE3Sr1euWvE3zHahV43U8RD59gNAlaNZqFJLydCoi8kKJ2p3
         JX7fqKTkLVHweSqQN7QjnQ+/pw34vDMzwDCHyz91L+r9zfppl5BaRC1BiS/NoCD2Ob15
         eYpqTUkAcT69uii/nl7M7WCoxeDUUlzV036TMXZppVeKdyvuzo+/Nl7Bi+Inpt9Gtqax
         WhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I9He/fnvIveKiIdStskM2jtFd2W+NnS+TFAR9JUlqKA=;
        fh=IZrqddasDKmpl6CWJgQFHv2L/p/CxljQ8L7U+c3BASw=;
        b=koLk277gSdF6U6hE0RzRkJZ5iVM6Aq0S676zy9H9eoP6Kc1i/p5BTf1wWJmz+IM7TX
         3ZIIeRv3phNf1NqeVdRfwowCq3gVrgrkzEdNOT73idTwIECE4yu7DY8QelSeAkbtSmjP
         R59gDZ519Eoasug9vn/dmVfETBS0fB2varCICPc/67ByCPPLM5niFWWPKJkFTQUgjhFU
         zpt6IT0n0kENfpTDgy+vtkZP/x7i9f9DU35Dg4e0lttHjuZAUNhGZoE/cSA49adzfFnK
         o5e6FWwa+wwXkAEeT8xzWysC7CbBAdm+58R4Sh1PAU2tjrNd6xjQosP4o0rX/LYa/eYV
         aDzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794333460; x=1794938260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I9He/fnvIveKiIdStskM2jtFd2W+NnS+TFAR9JUlqKA=;
        b=a1DLQpEYFoQwvFxzStr8kdwy6qf6ubO+R4cGWipFwY1LSCjuZeLZX0j4Hn3KX7Bz06
         cQXQQ5CkDJDsJFfRBL6lDgVp5opOs35OQEuDlCrpXoIbJnZwBvF7Ak4jo3KudYguCLcb
         KFUyY4mpPT9JlsJ5c35tnwedbEuC7rsNtb5ERC4VQXTesDgGXghmwu9+Nv7CoMHHjlGn
         4uD47FX86dvCncx/zuPOLii0qUcCbm70Oh09O4/H2NBtTsKMYBrM4IOUl26LO6E/h0jN
         WXMJ7l01lr1NjXYBuaHNEG2XWlUpDTpcQw2AAL3lgZNqG1d2chaZo1S8WkKvnfmECGWp
         zZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333460; x=1794938260;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I9He/fnvIveKiIdStskM2jtFd2W+NnS+TFAR9JUlqKA=;
        b=A2wW7+a3VGFAVPMPGysRCaPrKcEK0YbXuUNYEEfJfZHE4P7OD+f6/9FzjMSSJdoBmk
         R1je3gIKq+kFPyTLTmCPJtP0cLQycJjLpCRTYhogxDwaXJ+CyPEmcIeb5RiTjz7r3j+M
         TcRDUTFEn48Q+PQsmJj8wNtcfYtjSmq+TOgAFbUILQKs2Z9FKKb/DbFuQ29v11Ii7F1S
         NaUurhNhaS6CUp2JtDfU+K2WqrCSq9QJmRiibgZ/oexYYhbDK4gi2e9F6PN/kenhXXEV
         NfRlVB/JwckzM90vEpe7iuQELbeY73hNO5B+FyO7JWUKsCMNOKWnpc/+3oLrsolYU8ff
         +MOg==
X-Forwarded-Encrypted: i=1; AL+hErE7g6OMvDM3MPzkJQXXBqIXKAyxLDq5akN+TYJ6Nlr/TZoRplKqeYBuhAlmPxESqGoWSS+aj7/UtR25ZQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/0xPxwerJfEXrRsOwwalQsWJ+VPVYCgKVQhA58GiC6gZTwgK3A
	EZYFAr9FtUSxelSghO1FTFXgbCSUpguPd/5Nsy6TYYJfx5Hv3rGIfT9aJv/Fi2CaExvVA/CB8NP
	E0L3y82BcS4Q9wx1B94X9KOcyFsVCtSU=
X-Gm-Gg: AYBFou2xIJdYjZFXNzWGWY7INMsi6AWwX1nZYyxsvg7/vHdocCULmLepz+j22b8TD8r
	2AbbHbX0O6aRAoE8EnyTcIay81pA6XgUYNkXqX76tzn0BZfCqouJSxAcrdFFf+NSY4/waJxAnPY
	6T3azLLhKrdDHyENH4zA2phe6hBf5useOlMDJ1gTMeNVRdMYbAMtuZsYpSoVb1YoQVYmwXtgjn6
	//7mPUPvktXsShXLxnfz9nmy7vsUKU5XpxjA9DT1CBVFyAXEe6+3aQDvLm7nJyJhyUmLsw32IsP
	3k/8Hey2lCkNSrxcgllgaQ7wlweK4HqZiEhA4y0Nvs5bzqiboK7BOFARHOsw5QV0TiB/m2XpJAx
	y2oFh5h2LNn3MFisnIXkwPHk8KBuwk8TEdyzxRc3K6OEnjvCoMxdoZk0J27ptE0cQy2jDEkz0pk
	Y/r0dT8LN6AkN6pIVmB1mUdIdskDfsoIyS1YnE/zX79IYXuG/yc4Wd
X-Received: by 2002:a05:651c:158e:b0:3ad:f0bb:344c with SMTP id
 38308e7fff4ca-3ae0961f342mr5818461fa.10.1794333460012; Tue, 10 Nov 2026
 09:57:40 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110054836.1515030-1-senozhatsky@chromium.org> <20261110054836.1515030-9-senozhatsky@chromium.org>
In-Reply-To: <20261110054836.1515030-9-senozhatsky@chromium.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 10 Nov 2026 10:57:27 -0700
X-Gm-Features: AclHuK8pPFE0hpuvuz_PzsjrrD8lcbAsp3pcgD0h8PmRUyeyRyhQq1XIFPx1444
Message-ID: <CAKEwX=OhvH80f-6emK0fBhbm2d4Er0rQ8oXX=FmfG0vrTdvZdA@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] zsmalloc: encode 1-based obj_idx so valid obj is
 never 0
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 10:49=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> The next patch embeds struct zs_handle into zram and zswap entries,
> and a handle is considered allocated when its obj is not 0.  But obj
> can be 0: object 0 of a zspage whose first page is PFN 0 encodes to
> 0, and some platforms do give PFN 0 to the page allocator.
>
> Store obj_idx + 1 in obj, so that a valid obj is never 0, and adjust
> ZS_MIN_ALLOC_SIZE so that the largest index still fits.  Unlike a
> separate tag bit, this doesn't take any bits from obj.  zsmalloc did
> the same before handles moved to handle_cachep, see
> commit 67296874eb1c ("staging: zsmalloc: Ensure handle is never 0 on
> success").
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Bit convoluted, I assume the this is so that we can use obj's 0 value
to mark unallocated state?

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
