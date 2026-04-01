Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1C135E92B
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065189; cv=pass; b=TpBGS+7A534IFDTD3NLHSqNa3+TvNj6NU4vUBsMkjXfR+t9jt3hmTb56vAUxk2EZytXG0TRYgmFPRkgWPVVeEjoEFBOS7TfNYlwSUfHzIVbzydj+2up7NgmdzBu4eyDBWz5ooppDUdvwuWXA8D4m+3F+QK+LBOY0X5o96ndfWbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065189; c=relaxed/simple;
	bh=jYUaVSUk5Sb3SOTuQeoUN5R4tL+13WiT/Hvm7LoUgnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQatiFqGqR0v8yqDcglC7TCRGLcs/4JUXshQMmp9PXluAxrHgwKc5quK8MrPDXxg33McrTori6Lc0QlSDjSxMODLcHJ7cfMF2mDONI0haIp3iEdBc2zlh5F/CRvw8n6//NWlFLUkRZkPQ2XLiyE/Nr821GBvYY/eVBrNRNomMI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLIFWkhN; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLIFWkhN"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c98928e4bfso4500eec.2
        for <linux-block@vger.kernel.org>; Wed, 01 Apr 2026 10:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775065187; cv=none;
        d=google.com; s=arc-20240605;
        b=BiYDB0xPX9tHWtGxEtce/d07J6hDOv+jf4iAOsXR7v2XN3YxxyGvklKodnMitBL1IA
         E65NhOSIWy7dWburDjLjKeATjZp5Dx2gux8nFbGk4gJMxbsPABmS6mxOwMwdKpc1ZwUi
         GChBIpacmU6XuFw6AjtZa4jFJ8UYBR+wi8Scq0GnD7UjYm1in3VCiUaAB3X1TQYM5roF
         4HjOjN9hN7+joKx9RKuq9+JzaEHDzYS9sJheryEHL4dL2ET5NbuVxpiRQAR+VRKeQY83
         jXLvbckCvvoKr3y3/J0gA+1+6h6wbZO1q9P5+TtQEPf1wQWTf1GTw7kFs1Ug2g4+w1lH
         lcOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jYUaVSUk5Sb3SOTuQeoUN5R4tL+13WiT/Hvm7LoUgnk=;
        fh=t3U9JoMXhoFFcMPsKrKQwpyjLuQ3wxfbvMAqqOHxa58=;
        b=Yg5IdQLned3sDnPSXF7vAp7Yx3F+haNL9eDiEHzhcgFG0W04tJMZM/3Hej7N1rk/Cv
         8PFOVSCMh6HIb3YDI1CMbfSyGhTsPL3lF4cmmWp12PQnjgNKKlUEwJwLxkyArQxrhdHR
         a+2MSjdMcYURdj0NPntgDWiL/+FS9YXAS7j+FqRaIgjiR1ZArNauVi26IqiUnf/Pcdzl
         7AC6dIGbKfnbKFatvXgXlSbj9BFMCpdEKndeN4Y/WUxeILtn7AO93pOEVl5E2biaX8y+
         SKoz7aVbnyJ1Mi2ii2qCIWSOVkhjpaRbfpArNStvTHGTFSrGhTyPhoNsDIqqFvNSvSgU
         VwiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775065187; x=1775669987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYUaVSUk5Sb3SOTuQeoUN5R4tL+13WiT/Hvm7LoUgnk=;
        b=iLIFWkhNhk2zFA69YpzwAULQXbWvF7ohNGaq94wT2RsrbuSSkLnK+cksQhSRRYzhK6
         wihpu5wvu0NAkb5yqMpPtzgZySKLadIEgQCsvkRTHkJOxdxPoRf+zq+A+TwMbp9j+U/Y
         zy488yPasQ1kGjlBBCn8r3kgkac6jUr8PS5zP/lkflUw3G8Iz+uCkc/4YjxjK5nvs95S
         IS/95BLAmQQdsvC/I9uPl8AUlISlPK7qmzo0vJ2NPqHTtPSpPC5/SkJ7X1XFbQJKhJ0g
         JqdBxVr0FbufR80FR0YkvsF3WbQvMKpmcTk6F9D7gUEH3zRUicIoxA/Z2XLwtQgH6TMT
         fiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775065187; x=1775669987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jYUaVSUk5Sb3SOTuQeoUN5R4tL+13WiT/Hvm7LoUgnk=;
        b=OGa7tXXi5VYCPHWY5DUAITivIM/82dKjWkKL2dy5w3Gp/0inffm7LFbZ9yuc2oYJwH
         9cCB4YMIB4yh6F4e0PBaSNWkarvLIaTCyv2h3g1PZha/rI5U3L9CFUhf+/EATtz/p9GN
         7ZSLLXphSltN4VHz7Pt/KL3THhYAhv+t19z7aD9A5v19ffdpEKEz4P8iEiiHpm4z+8nA
         DaREcTypZc58nmH2ULr6Ujg/S6auu4rezMtKnjsebPewvy3wHTyxh3UtZuW++l/o0F0W
         4bTpl1+lCeS84pNyPuVI/JMhVi9OLnDW6lZEZ2Lh1JRQMqkl8lV3HJY+uasSruvE2IT5
         32Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXu097QZxC0OK4r0xax0pDQlIdBxte7IL/G05QPg2y93oh6/YfWaCE6i9kOI+n+ZQHhMR1Gd182bps19A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhVgTUMyRS9j3BhsoZvUTb+vCIZAA224UcGbx+ucGKBS+AB5OU
	lWb5WuuJ31pRSE8yuzJx8XGFxijf4SbJhLBx9CTLmQSk+8xgb70SSTwVNTFwYlfS89PkVVSz3Ds
	0jrZ+j1xOZUn1cCzASMxo+FJTvf9q46A=
X-Gm-Gg: ATEYQzya4cEHkfuz1igSCxZS85FxR/wyP/BW1XIvKIOypYj0qwscxPC0zmo+bUk7v+l
	+18jNu/5CujkJdSRAgqHK+te2O9ZKQnDIB1uwBgC6iEGi0o9idywVSJugbZQCfS0XSyxdYLENz8
	NzwR1pDGzt9mRqQEIRy6uAoV+O59xgL3eOBQsYNWgT6v6ijix0Oghp4MxKEBwFPW+W3Los5djlE
	BqEhE7tdFfCZPXHJvMtKC6pG1//WXgGZrGwG9kZtVwI8vSHagiNIYDCFstVYvT1v5fwz6Pjc3JL
	TE/4Cmkknlv+jcrit30za/Vhyahh4OTT0KJmsgiDYAiV8xOnsCEqQ5K1BGoJpzFRSehjiFy8CvC
	gMg1+DYc0tc+J+0Z7Ml4yh35SdKO7m5nuFg==
X-Received: by 2002:a05:7301:4586:b0:2c7:2cac:8147 with SMTP id
 5a478bee46e88-2c932cb3abamr970192eec.5.1775065186457; Wed, 01 Apr 2026
 10:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org> <20260401114540.30108-10-ojeda@kernel.org>
 <DHHVLQAOMLWB.3FHHSYKNM5TNP@garyguo.net>
In-Reply-To: <DHHVLQAOMLWB.3FHHSYKNM5TNP@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 1 Apr 2026 19:39:33 +0200
X-Gm-Features: AQROBzBO7Aafw_pbzha_JEZl4Ht2QE7dpytXYa0WjnL8RQv-FxGnezpSMqEOLn0
Message-ID: <CANiq72kSYFiS6zN+VLs2URhAeHy8_-aEXki1pyR0qoj7jO-qSQ@mail.gmail.com>
Subject: Re: [PATCH 09/33] rust: kbuild: make `--remap-path-prefix` workaround conditional
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
	Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org, 
	moderated for non-subscribers <linux-arm-kernel@lists.infradead.org>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-riscv@lists.infradead.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 4:08=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Okay, I see what the comments mean now. Perhaps squash this to the previo=
us
> commit?

This one was mostly to ensure the workaround was not needed anymore,
i.e. it is more "optional" than the other.

In fact, we may want to just not have neither of the patches, i.e. we
could just remove the workaround given the timelines of the branches
-- please see my reply on the previous one on this.

Cheers,
Miguel
