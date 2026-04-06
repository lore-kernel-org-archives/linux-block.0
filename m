Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F1FE56A
	for <linux-block@vger.kernel.org>; Mon,  6 Apr 2026 00:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775434455; cv=pass; b=F+dF/wkDRUhW74jr+CGDuaXFr+s2XWxEMMKj9IHowrmd+eIYCqqkPnTyL0LSNlhjAO/ttwEncYRiff5HZ3tZilv9zbg1nJ9OwogliRyCEon5CbPHp5TT6Bnb7+gi3oQ29ZvtaaSlNJYIPh6Gqz5l/aHyJ4qMY/iFIMPpBzmUevw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775434455; c=relaxed/simple;
	bh=wEpvz0SusfCyL05O+8XHZ5HBN7Vc6GU6ixNlE1n3otA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A37B4uG9wdDnUx+wGhGO9XUF7ebhmqoMc0CyHlZ9KAulMRvmWmHqO0Mzw1Os9IV/R+sqp1vi7QkvuihBYZcFuZtKhb+XzUHg3DPpjXsDsLePmdEMYt1J++Gptnr30hQOM0vtDnieF3Z1G08oGoWdSZBMyrjQnsO2HqlaSpZvk0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2EL+ypO; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2EL+ypO"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2cad171900dso197810eec.0
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2026 17:14:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775434453; cv=none;
        d=google.com; s=arc-20240605;
        b=TU89aIg+eZQt2Qfi8Uk+APDtn0GN2LcQSj2jzGjIFlJvV1oHR1t1llvHiIg1VOapSi
         n1CzWwy/gF6FzL6aK8qxYEMCoCrdb6fXZa2krmiAmAB+9Rqo8v9UQtj6pJss44l/PoVx
         4XGG06eDzGDdn4Zu1S1WSTIoXZtGBLwDD4OUwY83PVZSMW2fBATsmn7l6FtqhmtTcxZN
         WSRs2D3Yv350atP0q2LAgFQLEc/5GA3k5HsF2Hp1MEoVDgAHD0lxdx5ZsWN1Lo0L1Gu/
         4V3CJltcAXYsl+CfeT0GyhRGBVyW2NtOy/eV6obe4pNXeIm8hIYWn6g1V1VrQ08G7aWZ
         QX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wEpvz0SusfCyL05O+8XHZ5HBN7Vc6GU6ixNlE1n3otA=;
        fh=OLzcqArF4jf31UsE7c4ygo/jujxVNrbgfKpRtVRyIo0=;
        b=Oby1ZVHd9fY8jCbE1TBzaMmeeI3LU5DpBX1MJUuhWzwSO0+1ey+QOss3B3PhLdKbFb
         ULwq/kSmf5HSqtdmLpGojmuQ1+DO47a1ZNaig3I38oRCNJRNN/CAqGSHIrYw9tKW9HwZ
         c+cxO73T3Uw5EMpnNPxhykSh8Nhb2fVNzx4Fh8icxGx4plj20v1ZS6NWMfnjCta1OzPk
         WeN20iFCynxvbysg+La+owtjRM+j9a4YXYz2+UyIpZ7DNvPpUlVjTDCsV6EonJaLPnpp
         sQJstUS4iA7X4/jlqp51dy6bUyDhN2dr/mfWGKkrWbBGE1ezvSsptTfM218R8Dy7Z4Hp
         TlAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775434453; x=1776039253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEpvz0SusfCyL05O+8XHZ5HBN7Vc6GU6ixNlE1n3otA=;
        b=W2EL+ypOcsaqQ4DoOhrFDh+b+1lAXR2+PfuzgePaD3QyLeW9tXTGFiV3lS1LJThAeX
         NaxY/oEFMFD0Y3i01XsEDpIhm8gOXMv0koKcxOIKicMgMti/P335kHExMP467YZP+Yn4
         Yy6jC3XqkJvOPhp1FwbNbESJ2OFvctUAgwlzHRAqS/JEy5mUEC2TIcLLwoRD8IU5BXHI
         EyvU+eQL2oMhpSEi0gKa3v2+Yk9nWVoOpuiLpMemSm6bu1MU8SModMlqUbijJ15Z0Jjq
         EcINdtOvxyfb50KcfPS/u3a17tCbzMlIBmnJAh2YlYTp2SQTFwIRZOigAmxIK6ERVnZn
         bqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775434453; x=1776039253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wEpvz0SusfCyL05O+8XHZ5HBN7Vc6GU6ixNlE1n3otA=;
        b=PhVZZPUj0GArIq91b5Q81rD4BLsRc0cfKDdziKh6yA68hXOUJ4lgVM6i5CWoUM9BST
         9ux+Marne5jWG4sb6cANg9NGTiXzotd2SXg0Ft6pTEcrRl97/FCOdgkHzseXgw/nFhN0
         cFvhEn0gMQmqtoqTPLBjb4lQbtKBBzQnFb1ZsM8Dw33B6LvONcI06KQ/4n20x5kdNHm2
         jcJILxUc530W3m3QsfR3jy26K/X3xEZtOnl8f8lvuIyYRdwcMxl++ZnykjlV9dORBlJk
         LlseT5tFi0gLR/EF4lPTD9IvJJ/8wV1Aml7UxYTSqXzOkXjwrLsNKs1ZyVlNpvMRBj52
         EXBw==
X-Forwarded-Encrypted: i=1; AJvYcCVm836OvruksZbIw5gcSv1o7zREErPtle82mh5krwhjYup39Lvagn+L0ENhcqU0Gs1ryALDwGgyFu7qew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx52CPtmLZxTGI8UgdpWogaaL1oWJMqUwGkqWW6BSKhMYmkLhao
	rDL0Gru2kPbZi0cYVydtQ28/BJY+jzM/E1Yzpe3fBru/Cmth/dsZoKJ0BQhkEGPqZTcOOBxgGA8
	sVPN6i5owcwE/+GqDvR0Y0Tfl7Zqzbw0=
X-Gm-Gg: AeBDiet//b0A9Py7t8e43mjlZhdNlXG9r48f+fROPpvf7vZKw8oJP3UdIZKcQCRcIHN
	y8vFeat2cuRqkGm+LZ9e+veX9imxeynGMj5MSBlZqP0vS2wrZekcbvAqB96FbJRjNK2tyLtNVpE
	sI5PijxxaW3dNiu+GmAx8oi/uv25lDP55ehMDBz7xfQXq/n2sl/CpO8b6zoX4fDP1DSWhil2KZP
	5s1w7G3wOOthijyxMzObOrj4eiLH+q6Gxe1QQQ2rOgEP/7Pxra1kUQ1uTWvlMftz/fD9Bwusvp4
	UrAcRmx2GfsYCxdlssrU9EGReH+HpROTIcwjbKGADnExtjVrnDxYqgvc6edO3dQxa5Em8s+wWXn
	oe0veRgLGp7JZnue2O6Ys2Y4=
X-Received: by 2002:a05:7301:6784:b0:2c4:acef:291a with SMTP id
 5a478bee46e88-2cbfbc7dc06mr2181016eec.4.1775434453241; Sun, 05 Apr 2026
 17:14:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org> <20260401114540.30108-24-ojeda@kernel.org>
 <177508434465.73816.4492182082440539007.b4-review@b4> <CANiq72nqenC30r7QQAmdKxS8ehGU2SoSGr+LCnoTAGLegH-KnA@mail.gmail.com>
 <DHLMTLCY6U4N.3VOMQXRIT1RFY@garyguo.net>
In-Reply-To: <DHLMTLCY6U4N.3VOMQXRIT1RFY@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 Apr 2026 02:14:00 +0200
X-Gm-Features: AQROBzC0xKqhkvjW35MYEt1fkyhl47XKSCgdBG6b_PFaPBKsGPkzdO2Dex1iVhA
Message-ID: <CANiq72nPjz4FiYUDDV5Xw1=ychH0DrhVN88hjygBnawLf7oamw@mail.gmail.com>
Subject: Re: [PATCH 23/33] docs: rust: quick-start: update Ubuntu versioned packages
To: Gary Guo <gary@garyguo.net>, Fiona Behrens <me@kloenk.dev>
Cc: Tamir Duberstein <tamird@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Courbot <acourbot@nvidia.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
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
	linux-arm-kernel@lists.infradead.org, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-riscv@lists.infradead.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 2:06=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> It's still required.

Thanks for confirming!

> Perhaps having a repo in rust-for-linux GitHub org (or somewhere else in
> kernel.org SCM) where we can point people to?

...and for all these details :)

I agree that it doesn't fit perfectly within the kernel, but an update
every kernel cycle or so should be fine, I think, if you think that is
enough.

Otherwise, regarding the repository, that sounds great to me -- we
already had an old https://github.com/Rust-for-Linux/nix and
https://github.com/Rust-for-Linux/nixpkgs. Not sure if Fiona (Cc'd)
wants them, but perhaps you could reuse them (otherwise we should
archive them).

Cheers,
Miguel
