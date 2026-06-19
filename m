Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC392F8EAF
	for <linux-block@vger.kernel.org>; Fri, 19 Jun 2026 06:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781850579; cv=pass; b=W3Gw3HYDTOAMkc6YijRHwHmT+JB7JywXc2tm36udbTLT1dekYFgLJEPpXk4D8wbY4kAf95RSolRMnSAFPXWoLUrhAXyrNUGW5mAySeEFcJnPzVRmsAqWei5OKFCVDzBZ8AHE5oane+JJSxb9wlRxISZCtFK/QghnMx7gAflz5uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781850579; c=relaxed/simple;
	bh=9Ck+PMMEdFk1gTxZ5WgLeVfcpym7nrzhjISCvrnSO3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPNEej9Hz16biCFL5DaxXYv5krym2rDQpYHzxAHMqt51mhp7dXk/b7xix5fGCNrrMOw6icnHyCAcrqZNBtsNfYc5GAsTDVdhMZR51PFWkn6bwpAeh8fVtkrZ9FnU0ywRJ8r5FvmGQIE2aS7VUFgBm90TekZhiWxGWwGq/mnwYig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvV3qNyw; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvV3qNyw"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30bc5fa5a2aso234718eec.0
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2026 23:29:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781850577; cv=none;
        d=google.com; s=arc-20240605;
        b=Ma57xnyqgnnUeOV7tIzjBAyduS/gnQtoaI4JVM0oREJFXHb4fWjsSbggBpjad0BNpy
         Kwgnv9vN4Y2lvBJXuE5ynp0oZ12S2wmOPcHI1cA0nOUbSeP7Jeoj0nq4pBEMD5cv92As
         WXhdtPrLz1JMCMuwCDUWKwG74WBeShmmg2ue1BRDN8pA9jl9ixK2MHttxghskl8dKubA
         AbzXXUtt1xrsn5Bk+OnioxplH0SFUlgIzbzSvdrQOxtoWJ5Jdf/OIRsnUel2gVLh8LpX
         tO8of4Z2NjIT/cRI2uGpH/f4S1doZxc1RnOqp2FXbVT0jQrrx/Fy9QHYwxo7w4jHCecf
         xznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GIni3623zTBJu/3eQjf3ErdK1/+Vy3yt/K0LQSvsCE4=;
        fh=eUTpWV6ydz7mJFCrksC3J6nJfTlGERTWH6ftNOf3oZ8=;
        b=FFZf3tP1hQQvJD/2S8X8Q+Fs1NxHOtjpzjAOSgKwbHxrD7Bxnqo+ik5/riTvWhiMNH
         SiqeNViklhfS3mfKa6jCjADEE0bvqmyNA17FJLnSZNR4wy+uMMJK5r06HLq8PhLMN00I
         JXM+C9uL7rF0ZzQ2cnJZpoobwaWJ6hn49Tx5Xp0+oKHIOXS4ElMNEMrVKcCwc5lgS+Be
         CV8q6WufEjVgcbOYhAp+VnuBwEKCry98XtOrMfXhQrPfAwbwJquPEWzECZOvZ29Q1rVl
         hegLl5wPOvhSsvzHohxH8FdkYsK/Nqq2mQ0kG7tSZxJsFiXR/QD8ClOxB/XORFPvH2i2
         s6jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781850577; x=1782455377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIni3623zTBJu/3eQjf3ErdK1/+Vy3yt/K0LQSvsCE4=;
        b=VvV3qNywIPbjADsiyCTli/XqLgZH4UiY6D5a/88zUd078i6p3YTNZxE+71qfy2yMgy
         QDmt6HYFTxKeXJxOPP40QmeSU1R3Kw9jfD2NrUvCJz3oeOE4/038IBW7tP8Ej3eqOzvV
         xsjHvPVn6PJdRHvvvq/zzVpRoh10s7X/yxV0cNtbeePqSRmU/4OEa2LLoy3P/Z3DOfnO
         O59UgLlTmKEle2BDT2Bu7yd0EvxXXijpuprJRYw9+X9xNNUI8QbUGbBqd6Y3aGjhYquG
         NvduSndqb0bupx0r7uISBJOKDnQjiOJ0rqVaCihcqwpcSgDCEaW3oCpVo1GjbF5Gzmd0
         ZSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781850577; x=1782455377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GIni3623zTBJu/3eQjf3ErdK1/+Vy3yt/K0LQSvsCE4=;
        b=tBCbm6JMFYmQgHbrFTZYnB11sf2An8kWoFdC76rwKvpA9zXgbA8QjDdIFa8IseICRH
         /kjrVxQHouMyw+sHqMPaDCnyMltFfbWmB5sWebfrs/ZlXH4Va+/UvjAoYAtBFKIVffZ1
         eYDssWRMbXg5dKuVKy4foSAF4L7p7B+bJbzMhyfsBs12/hJJsIhQTvjIHx3RJQpjJ/ZN
         KKyPMR2P3tuJpby52VhQBatkuGZeuo3YXaeE9y/aOQy2FND5F6CuhLFE6b9314dNxnoN
         pmNp5Zi6GcCz93Xs9GkWSIrZhb6snR7EXzW+GlUCEUPdwntV0Isd8/BKFYHGMgJeN2JS
         65Og==
X-Forwarded-Encrypted: i=1; AFNElJ8/5uBQdXIuQezCcbqL0OjBeUBvzjbQVFjwRnYYktpaRkyFLPowQVkOUNuXCtqStfZE+/k1wIbjOSQ3NA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTxpY71xswvWiD6OOUPjZVMPBsvCEdbwZgqcKWSgStQRnRbTJX
	oRimPdbxFlOLn+E+4lnKO3B+wJq0n58utSLNbV5txDPjsAYNgG/Zxr9WLMI+0kxi4cwBWS9uHIx
	pqJ5syeGIsVI9rp5TYQVG3m4sK/nr3aI=
X-Gm-Gg: AfdE7cm4kdab/GNeDtlirvZ7lzsEn3MLmsAzJ8QocfFJN+lUSVqYkZWM738rFbujCdm
	ixcBOANPMlEG5xsQL8SP6qaLka701Sdgtl2tQW0MqbeX9jQxfEXKaxeBoG4yi9gd82SMhkWXH2S
	iZCiXEXBtfo2HD6s8l/kGNUaG00tu/4JKnfjmPSurkSDRg6iQeolIt1PbaseYdKX4ua58Qj61ll
	RwqIJHjCPwNTCkQMYnwj68Mg1HJnADXU3b5rZqRU57vQHa5kV3fk93jRIGOTKul7aT6qu/4LC8A
	ZEQIf5aDsgVly0ZwGMoTYfXaDaVwAdgta0ih2IBio9c5xvFIKalrFLQDAg44pCgOJdpOapLuPVS
	bvt5dGYYVIX/P
X-Received: by 2002:a05:7300:e619:b0:30b:d2f5:d503 with SMTP id
 5a478bee46e88-30c0750d8fdmr696077eec.7.1781850577337; Thu, 18 Jun 2026
 23:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520-miscdev-use-format-v2-0-64dc48fc1345@linux.dev>
 <_FgQUCxXpugLyjMMqjxl9574cGo5dirs0Z56uf8wKnoy8aMjc5Df-xtNCJtnb8DLYca2o0VVi2WUOWL-gsc3Yg==@protonmail.internalid>
 <20260520-miscdev-use-format-v2-4-64dc48fc1345@linux.dev> <87v7bgf8f3.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87v7bgf8f3.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 19 Jun 2026 08:29:24 +0200
X-Gm-Features: AVVi8CcBf7vBssE6ifFv_yy7Zzd6EAkMZfAkWEJRcLN15V2aWR2K38cRxR0A1YM
Message-ID: <CANiq72=e-qgJhHOauqqx_+FzQCUQY8yFg8TCQWCG1eyk5VXbTQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] rust: block: mq: use vertical import style
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Alvin Sun <alvin.sun@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 12:32=E2=80=AFPM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> Cc: Jens Axboe <axboe@kernel.dk>

There is a v3 (may be exactly the same):

  https://lore.kernel.org/rust-for-linux/20260521-miscdev-use-format-v3-4-5=
6240ca70d0c@linux.dev/

Cheers,
Miguel
