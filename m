Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BEB17BB6;
	Sun, 17 Nov 2024 20:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731876576; cv=none; b=XDdh1nrCNoY4u0lhOzFwQ3n2hTM0RNqcCH3QZKmt6Bo8pZlhI+vl0faNDukijIKMm/MGoIroOLyfZcKwO87+JLDGBJq4uPwoMySYeYrfNUwoWMkzkLKz8ghwq6Z5tAJOdEb0TE1y1UvO1/919O/ZwMH3sZLdKD7kcUA3gxN3vXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731876576; c=relaxed/simple;
	bh=RUh5Z//qokD1EHed93XgS2G8TkaYHQNEYjVLmW0YjxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEWy1dFHdnSJBDow4OWOBHXvIlf4zqGl3XNNBDnHUfK3vRdb0VW+FRDtXIczSxcGIGX7RVG4jy5lbOyWazAu04lTKQiSo3VWC7Cjp5JGoKMG6pC0eF30caHMe+xBB9nI8v6RJHSx3uDfnJYfHsrIkJgOGwYTiqu9qK5jHb1l8eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7XEhU1l; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7XEhU1l"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea7e2204d1so701481a12.0;
        Sun, 17 Nov 2024 12:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731876574; x=1732481374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUh5Z//qokD1EHed93XgS2G8TkaYHQNEYjVLmW0YjxM=;
        b=Z7XEhU1lurFbpxD3J1NmXo1zQygGnI1sUIAPnSimYSj20g89N7HvHc9m4mquqMtoPn
         eIRwY0g8JQ68KXhq1+k0vLmyv8ypWI4z8siFtjx+FiveUivfiNqqHblbZEmpqJZ2CNTv
         wgzl9zddLjguUN+FayiMYKfr+lUNSWKlNOY/j5YEXAd0cN+mEiXi3YqHz2sbXhiOo4Kk
         HWM5StygeUKjW7uIgNRBnhO+vkwycOuV2rm4CzRAlAnd/fdkxytBXSq5JMt7GQxgWPhP
         LLeLfPeR/BTX/jOG6xKkGIQRDNHFU4o4+2WRCEfvM1Ll/E8tiYaU5HmxWYj7dlaf87eY
         JwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731876574; x=1732481374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUh5Z//qokD1EHed93XgS2G8TkaYHQNEYjVLmW0YjxM=;
        b=qyOs2VydB44nzpD74dKDN4ERZMW3aS2Fvy0ZrbYAFnXsq5N7aFXUmL8IkLXbgSBURH
         vTvx5vwpsvZxgA/TsUfJSvyDqcQnp7kM5/flXdFtYcz2L/0sgWUuW3Y/n4SMXZ8ZJqlK
         WjbrrwzUAtZqwe9ArKuZfBWJ9sjOaIUUvPHW2zDRxfsznSqas/rGfTh3TmJYn9ne5abi
         4oG+WBusa2t617CMEs0p+ZPqm3CvAYWDq8pX9uD7N21dzx0fFk+7xMIl0kGlalXl6XJg
         nY4qXi73TDomgvqmPKZIjosXpz+g0u1IWpa1+k9vXroj12tizylB8lkv6xnbjWPaXAAi
         mMhA==
X-Forwarded-Encrypted: i=1; AJvYcCVXeaK6tbpSdzF1PxMD52tMHMG/GYNlyLs+ToBzntLU1cfOV19fmE/D35cR0q/hSY4v7QyqY7dVlh1mnw==@vger.kernel.org, AJvYcCWW2CogxfEiCg2eDRZX3TgJE1BTXzXeyWOROHLSr6vChX0nrJHUeEII/3Z8PwtX41jOhiF/uLjq@vger.kernel.org, AJvYcCXAQQz0cJwJyjVGWmWmBStt+ErV3Lp8pGZnkJOIcUfQlpE8EQS+ZH7Mw4g2Tk8dALuwaIyOTPtQPZQ6xNneRkA=@vger.kernel.org, AJvYcCXEf1ASePbWuOk7KGze2gHRuytdZhZDBXXJuppcQYljDvoDyb//UKin8ibpi773vORMb+c261v7LDaCJzjv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6CVCoH8qjeZDdIe5MEYCN4WfJwBAb++Ko0grWoHVapi0mGozx
	XgeqaF5kCVQeB+r/yiNSHNiK6kH9ToaeKycCbKAQVBM4K2clGb2G5VDNeJ8wLb24e/jbyXhIidx
	0PRsnxb7SgGVAcUrasl9IdoyfMxY=
X-Google-Smtp-Source: AGHT+IG9vm4VgRwNRukE21UZzKhSxM8wQwmAjdt8NVMeFerxL1QCjKVJKSenujzwCjqlLkK4hlmk87d9BqlykZMHd7w=
X-Received: by 2002:a17:90a:e70c:b0:2ea:47f1:79d3 with SMTP id
 98e67ed59e1d1-2ea47f18194mr2098649a91.6.1731876574192; Sun, 17 Nov 2024
 12:49:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117-simplify-result-v1-1-5b01bd230a6b@iiitd.ac.in> <3721a7b2-4a8f-478c-bbeb-fdf22ded44c9@lunn.ch>
In-Reply-To: <3721a7b2-4a8f-478c-bbeb-fdf22ded44c9@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 17 Nov 2024 21:49:20 +0100
Message-ID: <CANiq72kk0gsC8gohDT9aqY6r4E+pxNC6=+v8hZqthbaqzrFhLg@mail.gmail.com>
Subject: Re: [PATCH] rust: simplify Result<()> uses
To: Andrew Lunn <andrew@lunn.ch>
Cc: manas18244@iiitd.ac.in, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Heiner Kallweit <hkallweit1@gmail.com>, 
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

On Sun, Nov 17, 2024 at 7:26=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> Please split these patches up per subsystem, and submit them
> individually to the appropriate subsystems.

That is good advice, although if you and block are Ok with an Acked-by
(assuming a good v2), we could do that too.

Manas: I forgot to mention in the issue that this could be a good case
for a `checkpatch.pl` check (I added it now). It would be great if you
could add that in a different (and possibly independent) patch.

Of course, it is not a requirement, but it would be a nice opportunity
to contribute something extra related to this :)

Thanks!

Cheers,
Miguel
