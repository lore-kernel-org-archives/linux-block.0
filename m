Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9810196C67;
	Mon, 18 Nov 2024 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731938898; cv=none; b=lcUNzvarEWwtcegnqW1vFQ8FYE6Dd3nR88OS1FvdZWNXSYMq1GYCZivy1JkIeenpHIzGCjkldWs6gSn2t10N48H+RT+ypm+CU+ppTaCNEwr2dTNY+O9L7j54ZdK5M+llPyMXj1A18rL0vA/jpINaSn+Adlval3/7D2O7tb/wfFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731938898; c=relaxed/simple;
	bh=noEXu+HAE5F62nhuH2vjVRn7I7X3kce3M0rXhNmw/70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r41uXyxRJ1hsMeEVsZ/OKG1VRetD5Ms9RfRb1NPMkxguymYZsNGGBLpVnQW3D6QJqs09vgiiJ9HFqXfVvQKszELC1uUdxQ+2g6WXX8rVTZxJWGonvylwwMDThd+Anhu2eJznRVAcpkmZs5XU/zbzLOaKxU1areVObGRTeD9pXK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zj/IBhef; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zj/IBhef"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e74f35acaso260569b3a.2;
        Mon, 18 Nov 2024 06:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731938896; x=1732543696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noEXu+HAE5F62nhuH2vjVRn7I7X3kce3M0rXhNmw/70=;
        b=Zj/IBhefM2j89MX9RlHk1+MugFtOpydQpuLdJuCOO/io9l7btRqW1AbIHg4hteKVXC
         vVhIfG3cHzHrFhpDGtq6234hKTdHI2Tu0SNOtiyhoAJ9sakfEiRaE9dPQYv/A+Mqjfl5
         NKw1UYprPzV/9MmWGjf56xy4s8g0hUE23go4GVW9hq/wc9z4cZYiDcnLbmEdH6ajf/FV
         uvkqiBPNgzHw/ml6UD4LArywQmGni9COu7IkkhOgHidORJg8AXtO36DvZRuNha/+BsfB
         PKvHIPGxxr9ciQA/Xmkshr9kq3AfS4DN9wOzzFawUC5j8ayqldB1ZZ0aIhuhVxNmnRRc
         TlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731938896; x=1732543696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noEXu+HAE5F62nhuH2vjVRn7I7X3kce3M0rXhNmw/70=;
        b=ab2RXEpnq+CgvkgqavHc57bAJoVv5XX8vg4rF09H2As7EvLyoqkpDpYPxjzbUuvhiS
         1gmImI5KucifdeX+N6z9fpIcHhZKWfensbFnkJrRnl/B4zO8o4Hi1dEWGgD7oV2s4VOK
         FIofX4EhhBy9UWdRVH4C78Afx9p4Z02ihh9KYUWf2Ij/6v/dFII6+cczInrB/mbRFb0w
         6MnCtrV67pu+EIxNViFSqDDOi8OpJpVyvCtmAEL6AwLZsoTcNeixjDkBPjsoUn48n5Iz
         exanjap55aZUBqD4npYbErjTYrAFbum/ERueaTWVTeQ8fMO+SjtyCOhc/+sZiwGV2Swl
         hhQw==
X-Forwarded-Encrypted: i=1; AJvYcCUxHk6KbUMdmEPUe7ffcyI+0E4yEHfUVO4j3Ghmol4r3RHpWk823SdYSEFIAnInvVPeq4QzJuDj71ZNAQ==@vger.kernel.org, AJvYcCWFdFQvgO6u6pYJllY1OMNfXoPX4AuZ/esNbCj0x7iXBro1lHC8DxJgAL+6HoEzUKLuUJ7uWt+2@vger.kernel.org, AJvYcCWpPA+CU7L67etlgUegIjx9bFCtC2UpHTeV5h+BANbNj26BcMzZk4zSyIRUNfSX8DITxKjtvuWxim7afRZg@vger.kernel.org, AJvYcCX2iZJ5WjjRwZDGWRO7XAxrG4gxLcie3fNUUv8+HvDcIibPxS1cuWPCvypQx+cvtyTZWkhn3T3upM5sa6tSBI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLsizByE8uEmhKSbRmTLEUbKLjSLftDvAhTxTaqwKIspJbDbZl
	Z4VZou8pcd1/9r+rUrzzp7HMtpskNYqkuf4r96HjFvN3sdEovx/asNV6iU/jrEqD+WZKkk8XbXH
	FwlWl9ouhdwdIS/hOfoTlPmk2B2w=
X-Google-Smtp-Source: AGHT+IEtNzPQE0+FAlliCDqjK8iImkXC1+7tKdkigdZUUgNBkeySrk+kLThp64OB7VpHyppN5CWaQ2BEFiQqWSRTXu0=
X-Received: by 2002:a17:90b:3b82:b0:2ea:8aac:6aab with SMTP id
 98e67ed59e1d1-2ea8aac6be0mr1090780a91.1.1731938895959; Mon, 18 Nov 2024
 06:08:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-simplify-result-v2-0-9d280ada516d@iiitd.ac.in> <20241118-simplify-result-v2-1-9d280ada516d@iiitd.ac.in>
In-Reply-To: <20241118-simplify-result-v2-1-9d280ada516d@iiitd.ac.in>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 18 Nov 2024 15:08:03 +0100
Message-ID: <CANiq72=o56xxJLEo7VL=-wUfKa7jZ75Tg3rRHv+CHg9jaxqRQA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rust: block: simplify Result<()> in
 validate_block_size return
To: manas18244@iiitd.ac.in
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

On Mon, Nov 18, 2024 at 2:12=E2=80=AFPM Manas via B4 Relay
<devnull+manas18244.iiitd.ac.in@kernel.org> wrote:
>
> `Result` is used in place of `Result<()>` because the default type
> parameters are unit `()` and `Error` types, which are automatically
> inferred. This patch keeps the usage consistent throughout codebase.

The tags you had in v1 (Link, Suggested-by) seem to have been removed.

Nit: the usual style is to use the imperative tense when describing
the change that the patch performs, although that is not a hard rule,
e.g. you could say "Thus keep the usage consistent throughout the
codebase." in the last sentence.

> Signed-off-by: Manas <manas18244@iiitd.ac.in>

Same comment as in v1 about the "known identity".

(The notes above apply to the other patches too).

The change itself looks fine to me of course, so with those fixed,
please feel free to add in your next version:

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel
