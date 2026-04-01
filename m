Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C56B2C11EF
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775050312; cv=pass; b=oPnn/K4Qfz2eC686zFbpIEQRosZf71zDw5bLQ6OUlmQynS1DwpuEQmEUfc/zrLhXxB//jLg5EnuiKY/O7Ks2NbVEeB+BXe7iG7lf7S0A+Ua0NGhvDn92pssJkEMWs9Q/8HI06gu20oHRkE3OP4CgoXOu2pjh4xJV4gplcBPyTcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775050312; c=relaxed/simple;
	bh=Pxwyobpuf86TQi+f2j4+wIWXBQigp/e8eZSaPuRG5TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJyLW62d1N539xjN6P9Sv1F9W65ceWEY6ub+kTUmbWfcvJeebwa7/6iINDDR4Tm44MjMKKCjoNn9VzoyLjJzCoSWWRhk7GLixtpvoLTb2qE94FAeuBUS5E9SfsrTvSg4Yj5/8FkJlTOFnF+SZXfK2uwhPzJe51QnagFRtBstfNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iheeSOM/; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iheeSOM/"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2c5cf871adcso173655eec.1
        for <linux-block@vger.kernel.org>; Wed, 01 Apr 2026 06:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775050310; cv=none;
        d=google.com; s=arc-20240605;
        b=WrbNSaYTn+hXrNpLfIWzYXmi0USuaWisD5WDoyt3fQ9C1cksUoH3zZInnYE45SnlI8
         YPUWPgsY0966wBG+2xI2TTErbVQ0vcR4IuPDGzaxEn8IOJ89FDQ0GSL70yHVnLOWG0VK
         lhVybcSKsVNY6m437V5QhuONWLEl9kUn5RfvmwAF4wt3+dOVYA0yMnrq5rtB2MlGi3Ck
         fNxC5F013Dvv8HU3X0EAiZBnH/jzY+nIr/vUNUreNqJKdOR4qyysnUN5sNFF03qWdLag
         napFMaH1O+qY8wtYGiF4aFOAKNbUByqlL2kv6dJ/GqEdmVjgU/6iCp8UI65pY9VdRJKD
         vTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pxwyobpuf86TQi+f2j4+wIWXBQigp/e8eZSaPuRG5TU=;
        fh=yG6QePLyQmrQ150reEBZxQpbzs5JNkGgRnKCdZrL8PU=;
        b=HkOgilHdyYlgHsAUO8uWnrb/Rg3fhiCZTGnN3vH0O6/xBYpKybYFRM47VAzUII3jUK
         XejKI7CLbRssm/2/yHU9CR/Fis9G0qHAlv1deCqSeqHb+SldeQYWHT/p7F0uIM16AP4f
         7PN99puhqeiEIoFM2Pc3DztSpgFav96qeUfv1hcpcSnsIjZEaQ2CBViRWdZhT0jfRLh6
         9nqDBYIYtGKuu323Zk/qf1NQtmEO2L8EHd08+etqTPmKUiuUQyaK6D8ytGvgRmNf/92k
         7qmgR5FjYCOYvxugNaZANtLKNreXpi2VgWMTOsk1sjn201r4cKhCSfGJYaPHMvxF/h2U
         JV7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775050310; x=1775655110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pxwyobpuf86TQi+f2j4+wIWXBQigp/e8eZSaPuRG5TU=;
        b=iheeSOM/qlwTqLbVsiJefeHkwYJF69vrE0fo5V1kfgUbcsb7yyWjVh+FtzsiFxYiB2
         Yn3EwIwdZP+mACB9dZIA7vmKuA1Tcg9dv/f3cjoFxkJYVO9azMYPXgpyaMmaM4e4tBvO
         RDxhhh7h6nJ0A/BWEimRwqTrxCGYPHq4vNd97ByVCZWz8s+jXyAPuLqczLW+IQLFINvG
         ztceSgS4vwjmS7nMFkpjeeEWlaF6zj6d0u1J9WU4s2F8p9gGYdA55JoJpDLa39r4g15R
         k7k2jhHIWMp1fXuk2bWDz1caK4xkHT/kWjRb2JGQmGLRXECgWUmFL+30Iry6wfepfAIq
         tI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775050310; x=1775655110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pxwyobpuf86TQi+f2j4+wIWXBQigp/e8eZSaPuRG5TU=;
        b=HW+Upn5S+oQNHmp0fqmyE3niH+VkLWNcudcOxpb2qD82blKD2PSotSwEeYL0w7ctFy
         cIQn0qFuZRqvmnRjaFp+xPPLnisPtvtz1SCFUAqM/EjX58b+lPG3osS4TRkj1F2Wln9R
         bIITsJnlOYqgpVgWN0R9pEnhLFZ0FVUQIguIF4p2m+ZOjg7IZ7AUyfBHLnJ1IlTexr0N
         F0rou5y44TcnyojxO4cX36krQivzTlhBQ/R1duGMK6NDsbVXe5487BPTmYBmwhr1Ay5l
         XmQpryDbEC1YihmhaIEYToFTkUgjAGu0jroAtwsNtf6wbQ8FAAL6/YllkJegGnBh2RVN
         XSkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNNlF1SUg6BmucGwplpeIcMYbKvuhCU5rfJ0VFURb9CBmM2K2ByAL/22s5vfBZ0cwiaE1Xg15W+5uNXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFrQMwI47g2Ds9wIS+f5mAcvXyMJPH5rFYZxoAZvIUDkBcF8mk
	eqRlbYJJ2H9O1h7Yip7cUEIlGUdGD1juqC7VYLM56v3CBl4amNwCXJq+FoVxf+2/2xR8dWS/w90
	eu5lPz6aElL0qVQnxVpfEVhvW6ZnF2YE=
X-Gm-Gg: ATEYQzzuCmi9y6WrZPGRn3Ab1XgoY5Lsk9h8C+DZgci+Nb66z/O5QVe2VbB/Qvt8p2f
	73cfjc7Rj35+W6EJLAmD/qPNcM43DUszUqT45sM4/69EdVKpMIQ1kv5HQZ9iX4anWzGRgA1KTW4
	u5gYUF2UyO5Q5EfnKOmZdGLmjHgiL+QtmGrRT7+7K/hvZXjtVt9DiiiQ3jg/JzDWIu3cwDgE+i1
	/jeDDOI/wKs88nNHPh3xLxwfLQT/UDbXZbiji4ob+MMZQryAD0wgBElEtnFWYQ3lB5Q47EVBUuR
	9hpwCHNz9uxQXAlWqtD4TcJwNVojZvrCabPm9c+8w67tjIQsnPgpUm7f1J3YpT82b+cHw87E182
	nxUFSe6FRV4fTcWGbqW6cPWiPSmXTp6XU0Q==
X-Received: by 2002:a05:7300:fd16:b0:2c4:6ec:141e with SMTP id
 5a478bee46e88-2c932bab66bmr849425eec.7.1775050310241; Wed, 01 Apr 2026
 06:31:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org> <20260401114540.30108-2-ojeda@kernel.org>
 <DHHUQRB9ZL54.VQZ7OUZNSYDS@garyguo.net>
In-Reply-To: <DHHUQRB9ZL54.VQZ7OUZNSYDS@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 1 Apr 2026 15:31:36 +0200
X-Gm-Features: AQROBzD4KmXruNHpjUyy0X5nLhLhXQUuTTY9eP3fb4LBTyRyQ4wVkUjvlUGGI0w
Message-ID: <CANiq72=FBbJ--jrzYyKe3T56YqT5eU+0DXzPG3Ho7a+D9rfu=Q@mail.gmail.com>
Subject: Re: [PATCH 01/33] rust: bump Rust minimum supported version to 1.85.0
 (Debian Trixie)
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

On Wed, Apr 1, 2026 at 3:28=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> This diff fails to apply on linux-next, due to conflict with ece7e57afd51
> ("docs: changes.rst and ver_linux: sort the lists").

Yeah, sorry, I should have added `--base-commit` -- it is `rust-next`,
i.e. 3a2486cc1da5 ("kbuild: rust: provide an option to inline C
helpers into Rust").

There will be other conflicts too, e.g. in the list of features in
`scripts/Makefile.build`.

Cheers,
Miguel
