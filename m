Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914F6188907;
	Mon, 25 Nov 2024 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526633; cv=none; b=R48m8K3XUPbkEbK3WtUKmggqZG9LM9iRvNsWykYk04Druw5tHqUNdCllzaH7sZ0+7/CCthMqu2YDUD4YHA6HYFwcVZ6vTA9BX+U323ZOxr1OgQoxqQ3symSBojW1gBsFoQqGj7Klx7b1Hhg065CxhYj7jiYxcW/hxurah2hgpcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526633; c=relaxed/simple;
	bh=qcemhaF6dxBYnXBRHVDjb/MTiKC/YiHKVVAIRb06Rdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0fh5QyWLeCsmnYN7x0dww+lIUznJwxjzrY8UajsL3v8AkHvs52EfqImIZI/6lE9ijaenhiJbMQHBOvWMJ+mT6s7RgyxillSNcFFh0fqT2w9brp/byQcimT/qcbpt09XuLpxQ1XFCOGQ3VChRdkdbfH6Mk9hGM+PGdA9LEGjQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DT7XsLXZ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DT7XsLXZ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ea704b1c2bso714573a91.1;
        Mon, 25 Nov 2024 01:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732526631; x=1733131431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcemhaF6dxBYnXBRHVDjb/MTiKC/YiHKVVAIRb06Rdk=;
        b=DT7XsLXZJXxsI0qn5/G4zIhJeUB+AtKDS/acX9/moX23GaCb0BnMI5lAXT5u9wt2e4
         QC1k+thNz6UiB7kawhQk7joue8ZkXbbIUUtAIZWOxc//znIz5R/FiYoXM/nV7qCoCfR8
         7kt7mor4lB8FVwHpAlxF/2DSQ+eNn11UxPzgZ+PcVVI33N4VpdjbDI0O/nm/hpkFynrN
         JHy0s96DQeD2xtJDEehO46Nj+jvXS9gfKwiaY54DIFqz4DWzd1Anne0rTa3cExElrKg2
         C5Z8D9VSCBY5gqbMUWoJ1/a+ABAUtBzuVMpkxsfF0SMgXTxFnEaYOsVgvRtsz0i3s4SL
         StIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732526631; x=1733131431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcemhaF6dxBYnXBRHVDjb/MTiKC/YiHKVVAIRb06Rdk=;
        b=l6OC2MHmjLjTQsKF5bZt96y5FubfigPJGQ+MawH9hMdT2irm6pS9bPgNs5UZ1cJSb1
         STrqM256WhhsBTmIQ2E/fXEFGMYAzjjAuWOYaXnEmoJ65R0qaMoYcQ+H7OsBOun72My3
         xnnfYtP4kjfh8VM9xtH4fQI5w06oXsUKTat52tOdOM9E7IW8qqNO+MOrrCqgHRPJX6Qn
         e3KG2bPBBtZq+JPSENkLq8FCg81jD5s8fsf5mDzV2psU8UeLAOZW40As/oD/9rNrJLNx
         TVH6VA9QprCeQw8B9rmmHSBIxAcBeOnjtbK2QMAwJO1LlDJeIHCsVaXIM+mA4plUlxMu
         /IGA==
X-Forwarded-Encrypted: i=1; AJvYcCV5xPVlH81THMUiP6xfYKnJ4Gez2U/KAxrqlnjmLyKVJWmGdrQlotX9CLd1OnPVlQgvXIOn13cAK40O9GG0kuw=@vger.kernel.org, AJvYcCVCMDUkKr+nIkkOYc0WD3+eGoa63xUXKcO7SV0qCgXvPBpWuTA3Agrhtbv/z30z7X86hI5tRfJMAbxeHg==@vger.kernel.org, AJvYcCVK4cQ5LYIwy5n5eFT8NyKFh+eEWkmm6QyWA6Es8AplxqJq1J52XIzhwhwYBO82WhG5NEYAgbWKbeswHsFm@vger.kernel.org, AJvYcCVzyMzuTlhgZoHLJrwbhC526Ud4MhobXwntllHiGwBiH70EK51SF55u+TRu6lNfnz0bGnSMld53@vger.kernel.org
X-Gm-Message-State: AOJu0YxtMhApN359VtqZj7cZaG8ivL+qSCZvKZtqk0DzfOsjpeH85hg1
	uhd8l359c1pJu/zX/u3XJdiWadWN3/+tH075ITx+FxVGAJWsZf7psC5L9uUSGJTpFNFcORMxhn0
	bqWG7yLiUgmiJJz+yL83s4Wb4wUQ=
X-Gm-Gg: ASbGncslEjmmue9y+Yll1O5EuspSC8G6VU8GJlw3iPsfVcROCruDoYqZUCjADa+CtE/
	cz5D9OvrvI6XDWTS+WLriTtmBiT2v7KI=
X-Google-Smtp-Source: AGHT+IGOTgELQN8uyP5ueJTT51+ZqKtyOCk3LQ405zrt1L/Z+emvAyfINoiT8DvRuIQBC07HGWjHnB5guv16ACCxbfc=
X-Received: by 2002:a17:90b:1b51:b0:2ea:580f:6c0c with SMTP id
 98e67ed59e1d1-2eb0e024be7mr6689199a91.1.1732526630792; Mon, 25 Nov 2024
 01:23:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123222849.350287-1-ojeda@kernel.org> <20241123222849.350287-2-ojeda@kernel.org>
 <CAH5fLggK_uL0izyDogqdxqp+UEiDbMW555zgS6jk=gw3n07f6A@mail.gmail.com>
In-Reply-To: <CAH5fLggK_uL0izyDogqdxqp+UEiDbMW555zgS6jk=gw3n07f6A@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 25 Nov 2024 10:23:38 +0100
Message-ID: <CANiq72nKgj0n84Q76FSsPSeaupwgEKBT0GQbO8m-KHKZb103gg@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: kernel: move `build_error` hidden function to
 prevent mistakes
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 10:14=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> You could also put #![doc(hidden)] at the top of build_assert.rs to
> simplify the lib.rs list. Not sure what is best.

Yeah, not sure. We used outer attributes for the rest of
`doc(hidden)`s, including in the same file, so it is probably best to
keep it consistent, unless we decide to move all to inner ones.

Thanks!

Cheers,
Miguel
