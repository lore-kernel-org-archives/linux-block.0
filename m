Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DF32F6184
	for <linux-block@vger.kernel.org>; Sun,  5 Apr 2026 19:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775417404; cv=pass; b=k54LaJETTdJ5YZMEoOPpXuhDv+tl92k6M3QExax7293Rg2YGHSJOEHey8GY01s6/po9Qy1GPURtrJbnnq5OoXA26hCJTiMcQB+SwRTC41+OqebaK5JoWh7Cx06vC00RaGcbnciExLBFFOSWmoGryfzhlLpkEIEn1UR6bGR7sN5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775417404; c=relaxed/simple;
	bh=tF2TWpDhS6JNHMclno4d/CgtX1qUDK1fcIW7BQ+2mZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhmit1T/aaL5kz11yc5so2wbN2kTuaCuFqEt37QzQSvP85z+RzX6C5NhTMl91m2kCTH5mElDTH/aDraFfE+1aj1gVbkVu3Y75S4mceMtFu6z8iMbtfRfFp/IBSKO2LA7vxMqser3XwVmI67yWQafLLmWzhR27DWEHJqfj/C5gcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRfJiYT/; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRfJiYT/"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bd801b4078so360187eec.2
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2026 12:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775417402; cv=none;
        d=google.com; s=arc-20240605;
        b=XmCiZnER2WpauCQ7eOxr7tWX9On8sYNBkJOWhrftH7zDfgv1PvaE1cHdlctK+NAV7q
         PNeBT94dCbF6Y3vm3bG9zZpCVrnnelGU/XuC12lwY1QV0+1nt5KqiTHxcEzMdR7hqALb
         4QkvtN0msi1n1YIc+/NYLejz3Lx28fIMHluVfUJ5LoSCNFeJSpkzM4EPWSPMfyB0/rT4
         sCjZVnN2v+KCQLW+mtwYjcOyUhqrdmV8wyLVO10i4BMECEyq6lDFfwgk4URleEBUIQiX
         JlRRAw9hZwEgfTFrRjWY8pGER3SVQ3GUHeAcg6ux+SNLGoZ/4tTwWlF2MrN0uLqColrI
         76TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tF2TWpDhS6JNHMclno4d/CgtX1qUDK1fcIW7BQ+2mZI=;
        fh=a7CNdFQvWhpNze2ZSoieRpyzYFy3hFI9SPaLHaTEvC4=;
        b=Da38eIc9O4QvN5JxsSMhieHq45w8pzS1SBGNPcVosvhJW1wcpx4hQ4VqVtLqWmnctT
         9FhQ5Fcsj93uOqKzgej8WPszEFlWM4ysMHcmXSdVot5YZh3QgSvD4sgzzNeHImsvXHmy
         dJbGGB7+bKfik86rQrW8/Z+yXsBf3UMocvZ7cFhjg8fpnUin3qrjlmOjKdklXdMlHrzk
         OnXKmgQaq9tAiiNfvgVQ0NDUfAjS9eBQnLvRKEJG6GxQnQcK2wvCOg/7anb+d1fG+bF/
         UgqXCiEfK58nZq7wJouPXfEH1/c/mnSV2ukY/YY9WyD9Dtohb4ikRlMhPMftljkZsTIc
         IZPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775417402; x=1776022202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tF2TWpDhS6JNHMclno4d/CgtX1qUDK1fcIW7BQ+2mZI=;
        b=mRfJiYT/+olK1iMcCR1Eq5zd6EtYOTPK4JjL5RlYfH0hC+yPxbhFtfGeBKeOVVNDpP
         cAbjCbe9gDZQEEaEAYDH6wJGt2ogaBEK4SrH21K02nQOtwKHt5OloY88rxjSzHcEL2qj
         HA5oy1Q118CPqkIy7UOTuJzcKoulpGte/Msdgpp4i99bjOviHP+vaPuGXMxoYxCsvQIp
         rG1c/qF0ENmYdCWW5xxLhxtuCMsHH1A83FMtBtZIA+v6cJ18kxJ1G6f10aKzVCZ5AWnO
         etgmpMTc25U9ObytySL+cEJgB3u6MoPbEdD3KxUPbP4zHyviw7hMzRRL4HhsBuljW+PZ
         G/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775417402; x=1776022202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tF2TWpDhS6JNHMclno4d/CgtX1qUDK1fcIW7BQ+2mZI=;
        b=r+tF1olL8iSW3W7P5NkOEawvkzElF3m2+pmSUFk03Oe6gt7+PyLzlLWoHIepj01NDV
         yH9QFsj3qSFMGGTmD7Fs181lwLKRcIT01ECHOaxw9wrj+QtASWAr5w9BCHJrQv1+zBsW
         BF+kThbq1GTalZgbXIOCsrY3JyI8LCQYCX1Yhg94U4x5Es4WzdhFJzSMLFFFmd+86Dy8
         UVF5t+6MbWdysFzKrYeI2AphmXqyJ7ENV3bB18pjWrqWg9oujKoFzETt+uwD4y2zUeM5
         qIGYqYiAtlHynfRRXB8m3vUWIR2xXEWKpB8snsyZm0Uktyyus4VU9gkYjTB1OVSOOEr6
         2jFg==
X-Forwarded-Encrypted: i=1; AJvYcCX6f6go3jAZf9CRc8i9jRPp3lAfT7QEjYt/GInNL43tvH0MNkp3+8KmQUCuFbR0qPUQtMjWC1UZIcwO0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxawH4hnXSpjTDi/rGixw1TZwOQ5TaDdXI/rpbNgo9FeHBy9zvQ
	IoPY61VV9LwyyO06HTMdHcY4FvIuVdUj5Rkxe3RkVvx6zdaNRfuABNMwpKhVEOMZC+hKZ0fHfup
	cDnZEmJrr9z8X7A1Bti2/6wj+E3LMLOI=
X-Gm-Gg: AeBDievy3V7HMQXqdYpEIXueyRhIur0fJxDZTknfTcfv73nn9FG/hLUrnygHDoprtwk
	XYwPx9mTWu7r67n5EMeMt42QEPkH12e8QgkB6t34Y0pSr0bwP6EIWXdZup2toZD6/IaLVGT5IAo
	AuG3hAddpi494ofS2wxWli9Ir7JofgqrQu2i3v154cJhsCPFaaigrl86YEbUW7rfvWkX9KRjJDN
	GFtvEXWQb6aormmxtj3Xa407oodunfGTosU1QF2JJ4numjrkRDpUlbfQt/u1TIBpyDaf9vdNw0j
	K9wr2rLgA0S3u+Fvi4FmeCbaJ1C5+n9PMMeTsU2iINmKxR8sKuJC0DFmlQzlqYEvTT2421CpM7s
	eChsduwVhQB1vshvZEQOyGrA=
X-Received: by 2002:a05:7301:1688:b0:2c7:2cac:8149 with SMTP id
 5a478bee46e88-2cbfc95a78bmr1941319eec.7.1775417401965; Sun, 05 Apr 2026
 12:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org> <20260401114540.30108-11-ojeda@kernel.org>
 <177508434443.73816.5437391869400189147.b4-review@b4>
In-Reply-To: <177508434443.73816.5437391869400189147.b4-review@b4>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Apr 2026 21:29:47 +0200
X-Gm-Features: AQROBzCJ9cjSza_PQiGX42eHlVtWqYPN6hP4vKeYF-tVAvlxpiXLyawV-TKZkT8
Message-ID: <CANiq72=EL4pEagthmrQ=DTNe8-5jWMfgxxx+fsj=pFy3EX0zdw@mail.gmail.com>
Subject: Re: [PATCH 10/33] rust: transmute: simplify code with Rust 1.80.0 `split_at_*checked()`
To: Tamir Duberstein <tamird@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
	Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-riscv@lists.infradead.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 1:00=E2=80=AFAM Tamir Duberstein <tamird@kernel.org>=
 wrote:
>
> "beyond" is probably not the right word here?

I think you are right -- reworded.

Thanks!

Cheers,
Miguel
