Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEA73090CC
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065562; cv=pass; b=sSQjqesB4tjQldoJN//XRvicTR1YRXmb82WG/LPJa5FgAzvC79ZK25/ydrXCqqfGFvo1wr0lGu6jJMWLj3QNuxQdUgxZLAB/f7k0nffGvKafqcXjKS9eKh1V+j2X8VJiiCTKdXLkSZc7dlrau1k95brwBK85QE2HAhKQCxP/Hz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065562; c=relaxed/simple;
	bh=QI4ZvYmbpYFMS5F4DxWr2Qtcv3EtByJoEsfGF8Isxow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfnnQ6Uol8OxGeUg+ifuHBqc2Gfp5RaFouwkmfOsCYj7av9jYwuiKvtQlz0QcoOZmBdoiZeB4fUgKmwDiwsGFzGXP0CYTkusVBhXxpr+tFxz6aeCwiXMS/pWJBzTddlUO3pznEFZlvUPQDaYiGzhGBz2Lk7eOw7wvw+CnFlOkq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuSB1yrt; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuSB1yrt"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c645e399ffso2847eec.3
        for <linux-block@vger.kernel.org>; Wed, 01 Apr 2026 10:46:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775065560; cv=none;
        d=google.com; s=arc-20240605;
        b=KCHgNoNsddOFP0P50k3yb6zsN24PGa9d3ygAS+aRWqbv+bDOQTXrOz7U0VhUwF8ZYy
         jnBnzq2MMGOCh1SG4hExAmol3AjlY+GienvyIJ4/IFhWdjQJtd7U8PLRdCzZ75N1Gjr3
         QtMigARPrI2ldrR8494VgozdUt4fLZRWgjFf30dajw/bLgTLETtP9B/0jaRI3au5dOvH
         HXvYGoCpZDrD3/1/1ry9rAFa+slzeUKNaZvov+kzondHru0MOOeONNuhc2fi3AOjNOmz
         Br8dmM0aRhkUx3yrQDKF+6iPaVSvjumfqlMyu6mF3ccoAwB1SVAGtwi/eFnNihNrdmNT
         dhiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QI4ZvYmbpYFMS5F4DxWr2Qtcv3EtByJoEsfGF8Isxow=;
        fh=FbSCmcRuIbe8FfBfJXjVSzx52yyBR+S+D7zyXLbmLrk=;
        b=kHW4SJ2/0Y/+53gdFbrgR8oFbbbG0nogBD+j6uONOpwS4wH4B8Xj39F2DwvdXzRfcK
         pr5Xy2KLeAX+EfSjJzDR2LOe95FEgcoVvNihXIR/3hPIeyxlRSMN2LAL6LmZxzir5X8J
         q26qoNK8xm8NBhk1XzdpQCpCnPVAyJ2ZC8TkbLQYHXC4BGooF1AVOVPQJLV88eU/vdu6
         RxqVQmcjj1H5uDBkhIi1hnoJPqomrBS52QosmiP2I3xW/QbpaauU7MWl/7r3x8exNSgC
         o/O8tA3VnIw2G/1b4GKeki195kdBy0t3N5El+S2j41Z2uid2mYsKfF576EnPlAEsFtLy
         vpLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775065560; x=1775670360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QI4ZvYmbpYFMS5F4DxWr2Qtcv3EtByJoEsfGF8Isxow=;
        b=KuSB1yrtfd8BjsI6YjeWCq5wxXfLwBoKXUpCsrVo6QhIUPYZyH8YZscFQf+sEFQGSa
         TZa26pVuuui5NNTB3TMLCTlNQdZUd5bNv5ckyZGKLMzmdHhcy7khKoBsPqwALzvfTqMx
         Tx4YahpYBU96LprRTqv163LXmagSQ2UWTUI5fXIc45fHuZJGblCH1AeRl57i/ejTj5Mm
         qxEZ/P7i0pLCCFWwjWNVkYKtF4Ldade03b80tf2gtS6iOo6Vr4UtiKUQABYe6b0oT8sT
         YwPzJUkCLIYKqge/KqQi71RrOh4/b3n6UY1Gp9QJ2fd5NIK8vlg3P30n21TqlTrKxzN/
         SiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775065560; x=1775670360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QI4ZvYmbpYFMS5F4DxWr2Qtcv3EtByJoEsfGF8Isxow=;
        b=VhdkTK7enagfpe+g3Hiz2rz6pdee7wgLENoB+v/6K8KvpSmrMKDRL5OK/6AjJw1QpR
         nM6+n9xnu35nPY+P2Mb7pqeumtGXk7gZ63wqVgDPPTZfvMPwhImEtR+WspfBnf1zM9uQ
         9w9q4J9BMCXGHxbqStLSLcuhOR9U7Sxa+DTdGEC2MCLYC0M+kg1A7A4uFrrVeTC7e2I8
         MH2N8ZZ2TqmuUNF/DS9TEBm0SGsTAS+MAMvjsE2E8rGzNI0N9ouvpAmtmr7gIJTAVd8E
         0iLCqftxYKvXX7dgyiVsLECYrFwr58P1QJNo/jfXVujMt2ImYSvG0MnwJGLNP3N9bxqo
         ZW8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCCnr3+k0In1aIPiDMChBB5N8HAeGul9GlqLUvFe3oPbkYmnT82cn1FSmi0LDvgJA9BETTU8j5pFX+xA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1+Af1NF9OAo+rPbMJInRmY+MZzdfqfb5uZvWsJGhletMqG5eJ
	GMcCwHOfHiKdevamXA9nj+i0CL3mbyPlKi+CzBTUcVTHahAEnrZ1k34FRXSZ7SXeJjh8Ge7j76F
	5KD+S9gt5ma2qpikejBc/THt2xuRB2H0=
X-Gm-Gg: ATEYQzxbyX6M15QSPrxFsDz1RIKzrgbqF1hra05Cv7YT/pssk+/AwHiCvRXd2iM8Gu9
	PY+akr3hI7CAQ3nbM6ITMXN2nndKNauHuBTo5n26wfNLv+UK7DkaWN65nU9nahr6nhdlqHfvL3X
	ocJYw/mW7FDHScZuxiPXofgj/mRmFkyTuLbMRA+l9XFfvuv3cO63Wz+sv3QGfQHWsMX4etPr73L
	aa2f1iKd23EBYw19Z0y17xMYaEFRGY6AxjYTGEaqc6aJOctoaeM5mLi0M1L6hvsHoXF9BMwgPUQ
	1vs0tgOMZEMaynByYd3XKqsjvejeq6/m4qagkhKJMD8UMdvBvIGpHh9+ibPzFce8iH3dxoMNhhp
	JOwGVV2RXusSHcOb+D+URnXdqNG/donr17A==
X-Received: by 2002:a05:7301:2c05:b0:2c6:7f49:a840 with SMTP id
 5a478bee46e88-2c930798a4dmr1033595eec.1.1775065559731; Wed, 01 Apr 2026
 10:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org> <20260401114540.30108-13-ojeda@kernel.org>
 <DHHVSX66206Y.3E7I9QUNTCJ8I@garyguo.net>
In-Reply-To: <DHHVSX66206Y.3E7I9QUNTCJ8I@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 1 Apr 2026 19:45:44 +0200
X-Gm-Features: AQROBzDasvNfwm3irNcxLclKgLrVzocIHNQudR_c4deB-93-CSbalwIa-aYY_TU
Message-ID: <CANiq72=8eVKk0gqyvgWM_-VSsRZY1s2e7gx9AbAg+q0dRRYO=Q@mail.gmail.com>
Subject: Re: [PATCH 12/33] rust: macros: update `extract_if` MSRV TODO comment
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

On Wed, Apr 1, 2026 at 4:18=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> When I write the comment the intention is to enable the unstable feature =
and
> switch.

Yeah, that is what I meant as the alternative in the commit message.

I am OK with either.

(By the way, I wondered why you mentioned 1.85 in the comment, I guess
it was supposed to be 1.86 instead originally, i.e. "above" as in >
1.86)

Cheers,
Miguel
