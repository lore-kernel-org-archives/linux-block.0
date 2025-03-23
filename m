Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE25C202992;
	Sun, 23 Mar 2025 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742732737; cv=none; b=uzqlE/nH/apa08zYsT1BytKFCC09FaZaqRv32AY5AzVy2fJTEGedRqjQOuJf3xPugcHUdBTJLgeaKV0TbYusTKoLZtQv8OmJdU0jlrBWzHl5M2fa0sCYth24FjHZ8/FvsqfEOVXrccUnMaCBMuGZcrALBpaqSXcWxuH9Nf1ESHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742732737; c=relaxed/simple;
	bh=ZsLVdQia4PRfAFfDVFC8r0FOyWDwLv5qBfF6zd75NWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hL9bUyINqyEuwPfakUIYpgA0qJ7eLocKsHbTv8Vi0vwudCkFdjORJM8VO4qDQ5JU0XknMPd71HwrFborcf8tt9ATOt2Irvmvgf8E++il1v4E3oxWPgnNQbeYTyWDBWpAwf01orRLsBBzUE7fQ5DPjvre2glPsjabTYSg2dhOXbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlzZOZ5j; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlzZOZ5j"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff73032ac0so957028a91.3;
        Sun, 23 Mar 2025 05:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742732735; x=1743337535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsLVdQia4PRfAFfDVFC8r0FOyWDwLv5qBfF6zd75NWk=;
        b=jlzZOZ5jxkbodVAdRp+emCWCvuyGjK+BMrys92JFmiakLu9UTCz8YJKxMbn02KBsye
         qtgRBMPkV7CsS7aUwUu5oRy9EKO5rnYKkX4glcT2yxDnicKgvw/vgpOnXD6J+/OCnV07
         +P0eVLuMv+CSmH1GiAK3AqzfO5xqiNyywC4HjuphPTEO/X4KCVTU4Xtwvkv963l2iO54
         4ux0fEjM4aE1DFAvg0uQVmzwj2oHEnSLqet2n9ZSNTrHkALwOSrovsGX2Xm9oNP2Sj2S
         vx1qlDBagwpL5sI/Ix4P3vlb5rQ3BIvyE/t1irW92GOySCXWdXclfrmvHf4nm/eYPTOA
         5e3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742732735; x=1743337535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZsLVdQia4PRfAFfDVFC8r0FOyWDwLv5qBfF6zd75NWk=;
        b=JXmZK5sRKTtahtnADsmTJ/BAIfVMYKDQR/0x2VrVa8zLgMfiu74MlRB7a2M+rWYSx3
         pn99/peKwBmlowpl40qqwbVX8SNWZSqB0WUm71dJXCnvypA9875lz86rxRIDFT+4Qra6
         zkiFyR6R7nNDSnEiBXac8GQDtF4E4E97BxvYNieMFL1UvT2EMm7VfE5nEsoF90q18LOy
         Wor1iieQqqmZjaQpKYGwhjg2ymdmvIzo5kjMc3/f68/pKH75qQ5Cr6b4YcIbu5lgtNdj
         7xm9zt+HMhXdvUb8n8upCbwKAvRiCbm+ZeAFibQ3eCjKEKy6y3fvSYo5Tn985dGErmaA
         6izQ==
X-Forwarded-Encrypted: i=1; AJvYcCULET92Q4dJUJYqf4hfkyiu7YmHNEgkYE6sxHuJn2YQ5Rrn6fKyXB/q8huNJIT1Y+6KJEavHkF8nTac3WdSM5U=@vger.kernel.org, AJvYcCXLMIjc9BSasRNRzyS+Pw1Bb3GG90pGpUuuYIqsldbEJlH9+n7jcpOEm32JDu++pMdccAwYitSxhP0y07c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbEMs9AYSzd5Y4B8wjFa0Sx7Y7vslwtbR8rQ1CXCTezgNDts/J
	TYfM2xmLYmSFgF6sceLRcWYMOis5NtlHFbkeqFXARrFWP0B8u0HVK2hlcxoY+8IsnpQCTQn587F
	/6DsjLYvvRlf/1FFNQCsA4X0FDk8=
X-Gm-Gg: ASbGncvpg5Z9XmYeJqVflM5szQ0FV9etaBoNpjL+y2AvJ/vhmS4G/qTcpcn64ci6fZO
	twG8BtHcxcpmF4uVLrEmVLArRYRdVOBkG5oBKSNg/Un6YaAZxKuDrs/ihzfNcgREoGG03OxCgAm
	3wSn5/qBo00KFOH23/yWrN/autuGkECOWrzWNI
X-Google-Smtp-Source: AGHT+IHPD753f5VBkPqAF+VO2sGBlGLhWGOj//xEGRdUaWeHUvgPZWulc/YqXgzkVxghIF+xdw/feJYSU2BnClKiHDk=
X-Received: by 2002:a17:902:d543:b0:223:4b53:7349 with SMTP id
 d9443c01a7336-22780df1736mr55698685ad.11.1742732734841; Sun, 23 Mar 2025
 05:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z9z3gCdqa+GN91SA@OneApple>
In-Reply-To: <Z9z3gCdqa+GN91SA@OneApple>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 23 Mar 2025 13:25:21 +0100
X-Gm-Features: AQ5f1JomVUIXwQfWJi52_r2WqKR4LUuavrrtflutFMg3el_5K0cE_M3GGkOV9Ho
Message-ID: <CANiq72kWrC=YXbBf_=P8_nYLtvQF-XnJPxp85N60NiySCDEc8Q@mail.gmail.com>
Subject: Re: [PATCH v2] rust: block: Remove unnecessary comma in introduction
To: a.hindborg@kernel.org, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	chentao325@qq.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Cc: "linux-block @ vger . kernel . org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 6:22=E2=80=AFAM Taotao Chen <chentaotao@didiglobal.=
com> wrote:
>
> The comma before "methods" was not needed and has been removed
> for better readability and correctness.
>
> Signed-off-by: Taotao Chen <chentaotao@didiglobal.com>

This should be Cc'd to the block list too (please see the
`MAINTAINERS` entry) -- done here :)

Thanks!

Cheers,
Miguel
