Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24C1334695
	for <linux-block@vger.kernel.org>; Sun,  5 Apr 2026 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775417763; cv=pass; b=Lr+aPKDdLCBlPE50bpKznibJs191UoHF2GLyWk4/0P96siWS4njLMDd7hmti3CCijIMD1bYlC8R1g3KpQIJswls/nsAde/dGVBWTCiTqj8kgUcmYJVVtINpOK72Njk/fIFhIp5bXy+0vG65tuVWGKHjcJidr9aZr1Giij8towCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775417763; c=relaxed/simple;
	bh=BfjKSt6DEr7n25ZH5xS/6Npl1F2WZyz5JjVGM21RHvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOd054Yg7SoEJVlG+8MA9DCWeUBrVBb6Hqh6qQGZdJ8W6HlepivYSCk5HWgH3MDJfMVKuNQPwV4zwxUuxl46PNlrgyU9QhgMBpHvK77mLnB4QOqwuV+FZTAN0BuU5XvnulYU7Agvk0Jv3y1qI0yGgHf3oUTJ3tUfqPhspzLO2p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkjwnYb5; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkjwnYb5"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2cc175eec4dso117361eec.1
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2026 12:35:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775417758; cv=none;
        d=google.com; s=arc-20240605;
        b=ZcyZTWSeVVuqp5e9BvbjCVck/9dr2dDrFcBnfXeMzOCyVEM3qVNRCZ1hM7kEA1fAzh
         HfyIhmILz4gRJ+RDu027jgTOqjkv4M0T+2qb0G3aJmWGVqi3RdTK20bv/V0c1PGEBa1P
         fM2HvGU9k4ew2Ec1j3/IaRQLQgr/25OonBBqXUEyKPbCg2wpRCoAdcM+ZNhi3BuKsTQU
         +JuIyP15AjH+gBMF825JKJf1+D7HorbrN8x1KbGnYXDVubJ0KtZAbWogzPDSuEdzADPD
         KpkPJJInMg+uOvR9yTuZnD5sRDLZmPIKtmQsGkGvClbBTwYQkAbFhbyVP1H9tqRUDvOf
         gAwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BfjKSt6DEr7n25ZH5xS/6Npl1F2WZyz5JjVGM21RHvg=;
        fh=093V2TAjC4e/fVsFJW4nWzkY2cm+QgRhE9uM0L6nYUA=;
        b=L4ndsk1k6rBD42leb6GJ+pd8hZxhygCwgfnhb0NJ+OwBhPJoSDnnoS+jiFSE3epTHx
         AuMbKy7TFbwmSA9r9bVHZm6nNcAp+QOMQ+TELKWcufULG7F8sntMLwiaVRWvtV2pA+2f
         BJusvKYETH6Vkt7FB28r1IdOqT4cvqWbnsdR56koZlmC4xZDifAc3VCGOXKajrXWjvpB
         +UxK6C+JxCjyuwCw7eSfpBF5cFz52u1l/jjKyqdrLMlvIgWX1JrTQK9PbJgrldPz2MVX
         1wY0xqFQIglDJV4H3Rdc6DAHB7XwfUCpiVt+frDNAZBBoeRbnTfM/SpU+r5d3WdcfGwh
         pGHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775417758; x=1776022558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfjKSt6DEr7n25ZH5xS/6Npl1F2WZyz5JjVGM21RHvg=;
        b=dkjwnYb5y4irn3yDwTic9/zkksmlrGlrcEaDqFrgrrBW2e5KW968xLIRMImwXpMYQR
         ecd1jPK97TvMf6XLAIWhx//UcshQ+msJ11OhHDADc70LU0IvyPC4EIhswfxfuUEFj7qI
         hWDiTqqbU8wBneTz9NyHY1zo75vOqRbvAE/x7Of1tht2oUpm13uX0Oscy9CumKxtRD/9
         u/o04DvH05qA169PQZzzB8juPZXRVgfukM9JTCUj9f2+wlsXYVP7ceiu/B6ANv6bW1tU
         KzL0BCX4ELXxYzoT7TXNvopypQdjHof5W6W3JgDpUBUqBwpEhhcENd/OGF2CaddI+TWR
         HrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775417758; x=1776022558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BfjKSt6DEr7n25ZH5xS/6Npl1F2WZyz5JjVGM21RHvg=;
        b=GYtod/idSoe3XuC2pcTnJ7mQ7CRq2NRsE3WYuhESN82kip1xhh7lRZ58kc6yL0B/I4
         HfSZyyj4Z3dkobW3uFaUyKojG4wIt1C3NLVocxzoFQBkg1T7DicYXhm8z97N7+HdLSCz
         39klaJARHQ8jML3JYkp2WhG/cAYJhQ2k62BIQA7ePuWq57zaE0Oi+5ZS2P0Zk/ZA4peY
         5WWIiFIcFJpnck/Ah/1I2nmtPiwxfSB8xWlJFbvYqrb7YwDhtMZc/5qaeEmE7gfJC2SR
         Q4KyeD2SI12+b/j45qEjOGJwSPH9xF5c4w9Vn9vJR4MZwYBAbCHLeVhZYCfeqBqv9slb
         AwGw==
X-Forwarded-Encrypted: i=1; AJvYcCXCHg2vdni8tHZ/FhxltpoI4XZ59JWbVMN/UJ84wUPmkcv1VYTCDWlD0knU87xuR6HyERVH09XFQh/A0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzROrOiMdlEcFSCTpQOdDO8WhX4xTXGrWE7NPwcfU039ZNBUAy2
	PQ5p3CMnlbpti85CvUj2YgIqrexd2r7ScqgncXZV2NTXWbtmlLIHY3crI6rty6/0wknnHAKhtGL
	Aby10U85sxk4bVq8vrJLM5eQvdi4q3ko=
X-Gm-Gg: AeBDiesCggj40qNQLy581/yOqS7JMQzJwjEpbNDMt1c53idaf6lsaBt6ADYoGM5FbXW
	YN9Q4puMuPKS0CXbjdsoIVgDgOgTJe1YG++5lrQ+jjlJJob5sWBJwYwn9VL5zbPOUoQPdXpb+Bv
	oG9WDA6wvTocY1INv9PwbH6FYRofmKIyQQipY5uxAbF/QlxKl0vNnlYrc0ghqaVYRbmju67ek+i
	BE/feBcnNQV8SfYePutJVXW02/VVDfDnqH9jiDhyN/N5Bd5+02saHdPeUKFmARn8GbLcZNk176U
	2AlHWA/OdDkEzhY6BDPWNquohFuJ+x4fwv2HDJlLiM/0pCspfydi3M8rF7+5mByPOALeva6XvLo
	OWwMa4NtnQmvn2vXpPr9Ks/c=
X-Received: by 2002:a05:7300:dc88:b0:2c6:7f49:a862 with SMTP id
 5a478bee46e88-2cbf9afb2abmr2166610eec.2.1775417758303; Sun, 05 Apr 2026
 12:35:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org> <20260401114540.30108-24-ojeda@kernel.org>
 <177508434465.73816.4492182082440539007.b4-review@b4>
In-Reply-To: <177508434465.73816.4492182082440539007.b4-review@b4>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Apr 2026 21:35:45 +0200
X-Gm-Features: AQROBzAMmQ2fYtLyUeAFSvUDsVE_iEOg6GKNUQ48f6LlPWNoSXcMUKGWx0A_W0I
Message-ID: <CANiq72nqenC30r7QQAmdKxS8ehGU2SoSGr+LCnoTAGLegH-KnA@mail.gmail.com>
Subject: Re: [PATCH 23/33] docs: rust: quick-start: update Ubuntu versioned packages
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

On Thu, Apr 2, 2026 at 1:01=E2=80=AFAM Tamir Duberstein <tamird@kernel.org>=
 wrote:
>
> RUST_LIB_SRC is also mentioned in the nix section, do you know if it is
> still needed there?

Yeah, that would be nice to know.

I tried on my own, and it does seem still required (at least with
those packages mentioned in the example). But perhaps a Nix user knows
of a better way to do it, anyway.

So I kept it.

By the way, I think it would be nice to have a "standard",
well-maintained `shell.nix` (or a flake or whatever is best nowadays)
in the kernel tree somewhere, i.e. one that is known to work, that
covers most tooling used in the kernel, etc.

Cheers,
Miguel
