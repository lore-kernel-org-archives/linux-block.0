Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3106A19E99A;
	Mon, 18 Nov 2024 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947390; cv=none; b=Jka5ZkdOBuLcBkJDpTe2+RE7nelBx0tt+XlH7BLXPoiASCkIpk6CD6RVsP5Cw60wuLSwpX9hIWkmKa/0QOn1LHzjkVQzUY38oViz74v8NEs2ap/LB06cC3DwQm/PjOmm+l330QgjvR1xORXS3ABP+3JliKd392/++mKZPN2EDoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947390; c=relaxed/simple;
	bh=/IuGvX934B9ntktwpmpQf50Bvp9bujrEwlob8aX4gFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSM5uINSumO2DhINdYKYS0mOoE2ec3Facuot3nQ2Hgmxt2wOe+tsjZ0Eqqe1ZLdo3nQMlEz4xfUKZ4t+4wiGrzzZ+JXU4q/lTLHsO0exalf/gOaY2cXdwexSK2IepCsi+CW2oF/doR1vLmIrbvQ6mXvW9kWROQIHEm10tFqMprQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mu3PI/GH; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu3PI/GH"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7f4424576a2so428486a12.3;
        Mon, 18 Nov 2024 08:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731947388; x=1732552188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IuGvX934B9ntktwpmpQf50Bvp9bujrEwlob8aX4gFk=;
        b=mu3PI/GHduKRrUG83xZv6WMiMGuOFDzWwp4Y946odoa4xMfXzSmD52eZbnUBzhMfEv
         peHAFnmf63nPX7m8upJb3M+md3PlTA0QEszRN8gZ9o2wT7RcPJTPqWGYJxh/KQciXmBd
         +Jga10DVYrBpeAIYzSNFPeVkf8WkOxUI17pO/H9MSvpbTSIO9tw+QGvKvCG6pfBkRXru
         Zt5abm5P5SHLnTPVPEtKUHqdJguLltmyKrpO5KLAMuigTxGfQFrVRkLOtFweFM6UU7lc
         pNbm/67fUZa1mJBXC7nXGsI8UXGTIYPkZq/VeNXaTL5cgyOssqQB9fn2rjUoDwR3f5bH
         wjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731947388; x=1732552188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IuGvX934B9ntktwpmpQf50Bvp9bujrEwlob8aX4gFk=;
        b=hWX5VI4Weq3T9YF4p1rcvcvt/3P3eEKthyAqzauzUbEPnJFKSc4xUIuIe3PaUUqlaE
         5IiMQokfbRdJTY2uxegxAKry/qrQS1TkBOAa8grraBNpAyqlnR7PySi8rIah16lW6YrJ
         OR6akeUsoOWwXHiM20sqZVZUptSoINXySHSK/nnI0lFkmQsc2L0jXK3wSULsskoMMXUN
         Im0VGI0Yo6RKCOUYzV6iO9nO6uRDpmxIWWzpmeFgiCu/fYIqT9TpRKW7fZVbMGpfApIa
         zuesDf0IWkdwaQ50OPJLQ86gSEFZPtiwUrQsJwgBA12oYCwqRLesBvODklFEDzPr8qQm
         j1EA==
X-Forwarded-Encrypted: i=1; AJvYcCUQEUl/lqTbO2dWgeVojKZXI1Ot8W5wkco7+eciboFSftAR49h1s4GvFlYJFYzwjcpvLO32ic25liFT2YW++YE=@vger.kernel.org, AJvYcCVahdkMtH1a2x0s8BowzImiFOT8DESShoZFu3mlERrjgSOLxEtcxM62SyrKTYt4U00VfXhnkOM0+9InCqiN@vger.kernel.org, AJvYcCVjdSyFJ6rmyBRT+4AKU+1jJzcg2aM4jH2g1irYNUbaaA/pxojJq/Yv629aKeFXuP/r2G5PJrJg14Y63g==@vger.kernel.org, AJvYcCXHXW2+kpbynqn8OOlDvUCp0YwK08Gm6AfWkSYhhyqL4kkACDZLRfBBv3wcbCCLYjDC8XaqKo5H@vger.kernel.org
X-Gm-Message-State: AOJu0YydCS75opMktsJSlavEL84zbq5drKv1hzFK/G/KZh1LisAm4zPm
	l3ObNiYx4oPXP7PkgDPIHwoVSN8HszYdWEvui2ryYoLrrj59oj9hEnmcTF5eq4fg+UCwrUfOx3t
	bv6sD2HhVdLLyKyBbGa+cUiaUQ4Q=
X-Gm-Gg: ASbGncuo8fyqZLGXoIcjvyRGHz/GCy9em7gwriv9//hhIz2TFRxvi40l6OIpFztppY4
	DF7wAP7OmeeS/wHXx4LJBmpcCr59Y9g==
X-Google-Smtp-Source: AGHT+IFFrt+Sl9eXEXIzQhYlIVxSnSAKPMA48uxmhAI0AXrK3LjIIBiLv3RqJUM/lxOmAB4vBLH5ZUVQrEteSlCnbT0=
X-Received: by 2002:a17:90b:2d90:b0:2ea:580f:6c0c with SMTP id
 98e67ed59e1d1-2ea580f6cb9mr2939503a91.1.1731947388186; Mon, 18 Nov 2024
 08:29:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-simplify-result-v2-0-9d280ada516d@iiitd.ac.in>
 <20241118-simplify-result-v2-1-9d280ada516d@iiitd.ac.in> <CANiq72=o56xxJLEo7VL=-wUfKa7jZ75Tg3rRHv+CHg9jaxqRQA@mail.gmail.com>
 <oc2pslg33lfkwpjeho2trjltrg6nw2plxizvb7dq3gvlzkme6t@eauzzfnizzqu>
In-Reply-To: <oc2pslg33lfkwpjeho2trjltrg6nw2plxizvb7dq3gvlzkme6t@eauzzfnizzqu>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 18 Nov 2024 17:29:36 +0100
Message-ID: <CANiq72mcGs61PPDi2FHiqDtdNc7R8-G7R4R35zK=CVCRTQdWwQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rust: block: simplify Result<()> in
 validate_block_size return
To: Manas <manas18244@iiitd.ac.in>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Anup Sharma <anupnewsmail@gmail.com>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 3:22=E2=80=AFPM Manas <manas18244@iiitd.ac.in> wrot=
e:
>
> Actually, "Manas" is my __official__ name.

I didn't say otherwise (nor I meant to offend, I apologize if that is the c=
ase).

I worded my comment that way because a "known identity" does not need
to be an official/legal/birth name, e.g. some contributors prefer to
use a nickname, and that is perfectly fine too.

Cheers,
Miguel
