Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D983126BF
	for <linux-block@vger.kernel.org>; Tue,  7 Jul 2026 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429501; cv=pass; b=uCHImZNqlqz2wnqHy1/uzmIo1Hb+h3Q2J1BLil2L6jhYlqO774xMlUrYFAV5gBoBOaVnC7hunWpvHRrb9aJaitkNuPld8lmE+/lDAm7ovWo/8w1leuSPlSxsCNrfo2QfquoYJlcusAitj9NWZG3d7YouNyhQHMZjKMrNihgYvdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429501; c=relaxed/simple;
	bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrrGfTVPqJHUz5nT4xCj+Eqxrx9XudmeaZ2mMk2Ut+KSl79D+CD7hK/+D9ZDhdjcexHVzaicNy68W9kAcABGZN7vx7iIQIF9abfW/kxzKsmt+pzOF4asdPY4M+BsQ5nguTcwIAZ2AD2RABQI1kUvV8Zy4904IN1kgFfFlqY0kyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nwFqpWQm; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nwFqpWQm"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493bfe9f886so22847165e9.0
        for <linux-block@vger.kernel.org>; Tue, 07 Jul 2026 06:04:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783429498; cv=none;
        d=google.com; s=arc-20260327;
        b=L4Zr38VaT0zyusTUw/nn5Y/q5v3+sqERinEICfBcPe2hoK6OaAp8jpHF/RcajdPmlG
         8UoczJIj1+1VhOeXv3PJDKvn88qUOugkIyIFi+R9fs69wCSNspPTTD9X+KtshdqpQmmB
         qBkwHrPAsi0fNv0gbWc++crhofFJraumeVhFx6py4tgnVMeihlQKjN35vllndz+Jbv5h
         LCyV/MQEtHTuoiXdXWEEC4wMt/bFX9B57VCXf1QXpi2Tlku3pCUrb9Ae2MCVkvEMaue5
         2+/OGDYai/nubBOl4/ZrzzrZmO1qR701eYUi5S/8KGQJpFS7H9S/KVJRvWJ4LYaZSuXv
         KQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
        fh=TeflV5m92fOQdkVKOlfFsZsQ5K87V+GlBIEpdNA0no8=;
        b=D0/f4ofWwQ9FXOi+446A2QKSo2FRdOspEAkVNlwqS0cSCBfbk2/7GJpnn37oE1mi6y
         NH6lHsmKP3hC/x3inNqXQU9RH7YNYB3BSIgW1uyYTw/UJTEV4xS5VRB0IF5LAIcQ1MvI
         DbAUFfPVj1GDLdFHDhgkSkzSEQ1yV6zL03gnrQPambhLy1kb2s8R0jo2rFfy1YqC5tco
         D2MTUWNwQuuYYMC0YWKhYwXr0qVUBUOgtwJ6/UcgX+Xk3wIvcnzGyOffUi21H1maexnY
         6RToXXCU9Scw5aDUdwIkdqONeJEosv1TUT8IEdFVkqATgkgz/Y9JzkwBSEKJnn4oEAJb
         hluw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783429498; x=1784034298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
        b=nwFqpWQmjpkhT5N166ROjlsHRUNBKTRpXMHaTMJhkX1rzisW+j8ZNBgqb0gt0uMyFK
         kJBGogIRdGOCv+IfwKTap7nCADTIGP8KSe2axCh/K7UPtN3Y/fPn4dG6mxglUfb5sjDe
         z9wuNw/bh4mOjkdHneFd2IGooWxjn53QI3Stm22mJIjhjpbdYFfbUmPDdJ+o5ujoCGZU
         Eb2D+u6aPJP/dPUUL3BCwxU8hiDgJqf3hxk/zmzS8CtdaNnPAk27A0y9mKwZuZGJ8UZk
         RsXJ0igYAos9Lsjb5CO7DSUU9QppF9kBmRG78Ibkhp9dKy3x75qDooky2A3617Q50Udn
         s5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429498; x=1784034298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
        b=XLkzjogOPpw6Zr1FBb/dW7dv0+VhHwDaGONU7CnBQV0OqsluMHfulVAGTCSopeJozy
         s/JHvBDvU9utcBWHfVYd1M6enzy7/aLwcgoG/wj2ht3hcS17ZdtacZVrdxf6CrCvtUu4
         OB06ikDj+1e+R6jF10DumssaipAT5PQ66JUFIhOWkrRYjDWiqXGvw7NNWw/kaQhVTvKG
         7IJPtl/saFO/2YM+7CTwdGrrho+8Yehr3TzNPk/zeMJuRQ3A/3grqMSsYiVyq/HMyZt3
         4fwI20HYbSWc7kx9Il7kqboTqtM0RH9qSwtgR0X6hV9wOwjJewsojDmkgIHySszIol40
         YNFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp3dpQawKMxKowQD4hQalBASfFWgAU5uKgWh5UMJDY8S0SH2y2jgxA5ajyd2xYYhvjicCoAGbrmuye2og==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXUSrY0oBJ0J03m57oB6012gUu1CkXv1OeFc7SNbT39Twueihg
	ZS5St2V7x+kPRNOa1WUu6q/o1hojZZgqB+VIn6qbJnNIjlBVa+MmePaFMzVj1UGse6jtOzK5ZIg
	4lfQk2rXJeyPB0illMgX4o/KpZ/IWt0TRn53nBFKd
X-Gm-Gg: AfdE7ckRO0R4cUSPsvlG6x97pOtkTL3BSQqYuY6wzf1s5KgJXDp4SMiDYG7zGLaeKmK
	CKtUeSEPzsz7BK/vDVQgUj/pCUPZtVvpxt4cT3vjPFKvu2PA8ioTHG78iIMzNsSkTLCyH48bocE
	bdF6vnj8LRZ5/PiHLHZr99XncKY34Iqg+WrVoRMG26XqGsqgjgkHIk2V5bTa1DQsG8qy83eRkyb
	tPjLEZDgAkcoC4FhrwdNHiq6bBqB8NuyYPsHSbS+odicBU9aWsUL+Z6gnerNleN5IapaoYensL0
	nhxwCrPd90GUfbvxBcF1NyTiJC4=
X-Received: by 2002:a05:600c:8b70:b0:493:b6e4:fb2b with SMTP id
 5b1f17b1804b1-493df06e943mr52096855e9.25.1783429497735; Tue, 07 Jul 2026
 06:04:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org> <20260626-unique-ref-v19-3-2607ca88dfdf@kernel.org>
In-Reply-To: <20260626-unique-ref-v19-3-2607ca88dfdf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 7 Jul 2026 15:04:45 +0200
X-Gm-Features: AVVi8Cd8GrEsrkEwxzhRkanTcpbMUA7MU6OpTudOnt7DIfIGqhosSlF_BI7LYTM
Message-ID: <CAH5fLggMeHUgXj7JGYSJejUrR2PdWymOOb+3E1VmHokzcox4hg@mail.gmail.com>
Subject: Re: [PATCH v19 3/8] rust: implement `ForeignOwnable` for `Owned`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 1:55=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` =
in
> places such as the `XArray`.
>
> Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` =
to
> implement `ForeignOwnable`.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
