Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B220F43C7B2
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786449859; cv=pass; b=R7aboEDp/O323EZo9QdJqM3O/xwd187TA9zxJyaeXWc7FQxug+xT9TFFX67qb+e85PUwaa1K/kuafCct18VnvlX9qB0/289LVuLduc1SosCoEg6j6eyQ/aoVk92swCXaDUyH5e7Du7qANOc9OQQrtSneoFfQZNz70ZOgxEQH84k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786449859; c=relaxed/simple;
	bh=n5XJVxyjKKrvU5Tf2BH3DhTGCWaD7m72/K/SFjbzLoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBwYD2s2AgB37DTMG6cYEetC+F8BHH5/3RpKocjJdHW1nkhEYnBDiY1zZgaeDGza0yhMZb+HztXaZRlxDeKMPitnZ7iK/iKWMZ3zFjxxOMniP33qFmi6+dzNBYN2vj2eMR7e6IJG6mDVoXalkFAGt6G5V/1gdG+wUonIjXD2vyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxozYGlr; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxozYGlr"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d027b7c8easo7405815ad.3
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 05:04:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786449857; cv=none;
        d=google.com; s=arc-20260327;
        b=DX0NF+qCOOC244x0nE2YqHJXPcVWdACPeqK5SnMlt7aSN2MI5VXSt24ORmpy3S7Jk+
         TFvaVIxAX1WmaHgkBhKSKGZ9HyJqHnQJp3ERv8RFOuBWEEBrmDIqgf1M1VJE3cRb1pKj
         T294APrkmZkCKpPyRSGAGWk+EncQCodt9Vca6V7//04ubmkClc3yNk9rJC/F+jbt1uqz
         eG2n+Zf0MtPHlIMpvAS+oPuFu79eNqGHPAKmxZyJNLoNoOJ2/D5TYq5AWbYs9juXGWRs
         vcpNElu4tqj1FCyeU6IO6f3DPoABCScu3Wo4khQ9aJEoRH1MnHzjL3PGgqeK7aq2O4jJ
         aMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wUDPKIt4JBK1aml5H9p9mMv/VAzBV2eGmvqYyRcgH2M=;
        fh=5Rrko3A9n6zYbz2VHTMNEekSmou60UUgLiri3zTAf0E=;
        b=iAhpmJ3HjpsYZss5xgva+sIjYOsxYytdKCQdJh6Cri+fdW8GAbWk+U+8H3IHfyg54H
         i0bujjTU6TMpGFljUPNysySOwXBbl82Y0sSmPpAZkaA21mkHVHM0Y/neCey+r/CRpWf/
         6rwkbN55pAqrj2e5m9PyT180jzcWwIuTeWhsjnOIpJvdP/TU0AiK7XRcJJ+zLoAwtIBd
         hAR0VoQVA4imk6JWHqLB062zUvrF22GKCpnLNxXWNY4y9wVp6vHVIsAqu3L/MJJ4up2l
         b6NmFuztoHh4FWHrYoFn7Ge7qecjOF4vOQKmS5ZA5OhGzUbLtQk8s2cEEIzoxrhONMrD
         URrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786449857; x=1787054657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wUDPKIt4JBK1aml5H9p9mMv/VAzBV2eGmvqYyRcgH2M=;
        b=cxozYGlrlGsWOlB+YPoNpI6et8KnODitU3xhoSllVmTaoRIdF1Gtfg/qlTM2rzZHl+
         ynKQtfUwzRtFvFG7HlrSRsRETzCkdkuyKFF3EhCx1mbnYCUDnhXwyrdnVVYx/xaRyjMb
         RnWD4ubdndgVjnzjOttthDARj9phkw3XrduiK/PAu9BSOpAbRuy2T7Elec/m8L4N6a23
         SrDfQoJ2edMXVnD4G5zAaZ9NLIpJuG1DLH5KSGS0LG0Fe5pu3Zmz5vUG4pG8lkk7YegX
         mwyMh2hI9JB4Q5GEeP1srSDT1Rq2xBgqBiUzk9l5xU69KiD6D+IosZv4hexfebVxSqm2
         oEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786449857; x=1787054657;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wUDPKIt4JBK1aml5H9p9mMv/VAzBV2eGmvqYyRcgH2M=;
        b=pmyYtzRqJpbjWXpmK8U84GtjsVGfsGwVHPu1semEB2f11ppWXP/Nv6A1SQnsTFjPL6
         Xs9C2gt+D8a26ryFfl1FbyKGPE3H1uL2mE1fNaNpOOKQDmwz5GhfsJXHioiO2zqwR8pc
         xBoH635tLtggJhFteKUrfXyYaN9kHyHA45q0F17ULWxkqpo/iJqY0Gtp4LE/RMat6Qom
         /+vPuR58mqYgmqPqkidOu3lZOFnNZ1ZIzBVgKtXbYpRO2KNbngwHV8AoZBQRGAF/szta
         AAdviUAtvaVrz9yfCE6muccEYaDJXAe4XU0J0UUPEtIiUDR90qUsVjfeq/JtJsLViugR
         S8fg==
X-Forwarded-Encrypted: i=1; AHgh+RqAGRRu1ZJKrnj0irqhKgrnberH6a7accFr72+2mUhN1n3U1cX2bfFzpQO+bw1p9iINZ6Uh5jiLwRKzFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfJ5K+hfiCmYdXtORiAuldgueVWF2yUFPdfS5HuUKhWb/ke2nU
	VIAlYVAKc9PaaWam6GFKuETpWlN+l7d6rxRHvbehwWX7E0Rl7ULnfCx2dZaHdAMxaeoqyr//rIK
	YYaXj0eNy7kWafnjQkmk3s6oxc9aSQyI=
X-Gm-Gg: AR+sD1225PiLmInWNcT/f1hodb+drbMwSvPbfMtWC/TNkr8TyZEw7MJj23dYAKOthzp
	7D81Iz8AxE7DyM5Nrcup870tNMKiJdfZSG0ut8W9dxl1a7egqKoODC6IPZs4TT+Aky0WjdED9tj
	3cKzEDJO6QlaiUb9gfUEcBfii+hwryeiKtfEuCDmQ741wSQimJKRrRQDwk+A4AimTZdk7Aneyiv
	Y56oV4qQhAw3CTUIbO+vyFxjvb2Grq0hNy/V0uqYnwdoxH7FAcy09SQtGQU2rEPmsgtnN4CiAmy
	25D/Vwb63zN+y3jOKfQ9r4q64tS6L1dSsTWa08bsqoX9fRGjLSQehbQkOafPNCbhRuD5l5kfkpi
	nEgaznRABAJG6X2//6qNwvO703YNy5aJn78Rpf54WBL/X2aYoOHYP/OOZj7Cm
X-Received: by 2002:a17:902:f791:b0:2ca:d803:5c8f with SMTP id
 d9443c01a7336-2d31776844emr24387845ad.1.1786449856837; Tue, 11 Aug 2026
 05:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-miscdev-use-format-v3-0-56240ca70d0c@linux.dev>
In-Reply-To: <20260521-miscdev-use-format-v3-0-56240ca70d0c@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Aug 2026 14:04:03 +0200
X-Gm-Features: AUfX_mzOxCPBjocWw0ax4auF6rYqKD0_LaTTX8RHaI1gQQL1Hg_Az3mrgi7m2gE
Message-ID: <CANiq72=sfSc3_cS6Z+JvjyYLmXjc8pr5CcEzOe0Awa3u0JvEfQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] rust: use vertical import style and remove
 redundant imports
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 8:57=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wro=
te:
>
>       rust: doctest: use vertical import style

Applied (this one only) to `rust-next` -- thanks everyone!

Cheers,
Miguel
