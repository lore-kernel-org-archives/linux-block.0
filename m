Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C7E280A5B
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669747; cv=pass; b=RSRx85PimW5eu4RyxztyyFfI9sjt8db87j2nsOge6XWg3MwnHJlXzhXMkeiDM6jPSECvigIpF8ZRLl7ElIRod6nBSwOzpflteE6mhxIEIWwSBkXJS3kFoclEEmri3XKG/ex9J96zcmuhjPEzNhgJGsRITXSHRaIirtgVcYskeQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669747; c=relaxed/simple;
	bh=cyyiNDptl98k8pZAyExFSCW/9thFIw3OK7mbtDKcMP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKEJHPJy0LYlNr6OlYh9AOECz/3phxRY2+8wzsy8Aa7Jvx74FaybaErZZMxSC5pCcLmumj2SpGVL4l1LLgdMwgkB10IGXhiITS8+nnDP+yPSDWRaT/NtKmWK2bkG8XzUN0aVlFsFD6OQgssRqmT+CrPuTGXIsN3StWIMJLe7PPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0bfrDHf; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0bfrDHf"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2be9ffbcf9aso171167eec.3
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 07:02:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773669745; cv=none;
        d=google.com; s=arc-20240605;
        b=hCpkloagSmnSrdgDcVEkYB2CkLt2mLyPV3SxBbmI86VS/NiiCUbk08nmecO02RgJV9
         UJCq01QHrsRkKSmo0OxCtgK5gnRqtYgi3iCrOf+RhL6vrN83Ns2QGxQjwkAXx/xz3c0X
         svzwouRyOdu+FeGhKpPGXQA+jsHBKRzX205yTIZtXgo2inXI6tzHUWHDFDaEWHtLK9SS
         y8USqIM5LqkJDQbStFlyeyp9OMQ/d3BFJ17kZGbGstkbb6b0X5iKdm/P3j1fFhVmcFeD
         7lZNWjOFtsTF3r8aUV0W8ENRMMdUjQl3/SpxjO1t5Pxb6SzUeZHYJp2hCc5XSwEdi/I1
         dvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cyyiNDptl98k8pZAyExFSCW/9thFIw3OK7mbtDKcMP4=;
        fh=QaU59PzlknHQRBQ7NTbmKfIzkm6ki0xbtLYkrseH+HM=;
        b=MM2Afa7Miz9FwCl5xxpZ1CrKoUc0hcX+1boSYo3gM34AovKFYwPzYJjh6JCYz98st6
         jDAg0eLWuW6FAfjQ8udJh6CMAWZ0dbLI2Ha81utdiNiFeGvbqGvBx51MDgJj5TZLMh3D
         SZJc0OB5fVWzmFpflYI6T35MAV3uCYjg/5bZ3dK7WyAALV//JcPAjP/btKySac1/JUJz
         hPRUue9Xxc7rjMF0lOuUZ6k5asH/vAwxypVibJHxKCyo4lGEIkaLJWj26/h60UdGnpMm
         M/17hWDcH7lH7qMD45BNKRPRCi4nvpyGHHLH1F3pRxBUV2SnXpKyR7f2JlTaZhQVVIc2
         JftA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773669745; x=1774274545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyyiNDptl98k8pZAyExFSCW/9thFIw3OK7mbtDKcMP4=;
        b=l0bfrDHfHAXXtUL+rDOmHg+DhwsPpTwlBjNaKxI/dIaYK5PeeMpg5LzpvUFq6Y02HJ
         dumIKzyptFniUBwwMdjyPuXf3iIfu4rCGRCe89a2mpVgIgAJyp3tFq3jxilucc8s78S0
         7eBi5ECTHe5/7AD+LWirdzzE1oLGNN0YGwbMnhL0ZXcerPe9PZBLPw1DScdVD/R0Atqr
         OGdMGTqfb0tyFdeUpiwcabZgeVYNjG3Jq+YQ5Bz/79InUWzgUBvGDLZclFb4UVECthjr
         Yf8FViLvNAV8wTJuezCZ9gsveQ/2FITPDTV31uJJ6wFz5/cVjj6Xxg/n3e1oTcFZr+YY
         4r0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773669745; x=1774274545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyyiNDptl98k8pZAyExFSCW/9thFIw3OK7mbtDKcMP4=;
        b=oCgNcr5QP1jYyxfvRhW3g0LDqTZrMlhN0oReDn6UJPYOZpzs2gN75KtGOwa2KhuCx2
         gvRZlbNSibQu3iCgSl63p2I/FzRqcmhwHMEBcoJ2alzo8h5aA355oJnmMtPsDinEtPP5
         1DS1oqpLslvRUdyDF5Adv7Ktb+aJqjnbmEa4wQ1PtHkGNdy+VcrNgoIuIy+H9F8/tjd0
         WbCcvW5eDLGL2hOMTeJSikzZxMvTCuEdEpGEXWxXPaT4VNgVht/3zxCQbUB9yf02XqNy
         LYeW2rE7mXyWMAzxJXS0mV7EB7tFxOuKh2Ag37DrsB3GS7xuTubbCA2U2C1SdbD7so5E
         MD4A==
X-Forwarded-Encrypted: i=1; AJvYcCWbKW6dLVzBPlZLBM8rKQxURdUtl7rY5YnQoGwPAMVgTpzgIrrDDK15lUug6kHTJZN/2b0ebIeNyJFYiA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd5MzCVwkQdWBJ/AZAOQ8IMhoncz3m7luc59hMfXzGPC8QhmWp
	MtaStKCEV0X5WjPAlFnGtieLIxBMjJifPlLLZsAXbG7ALBskxS4lkTsXPY0rrAe4EL6VqPkxfCp
	ERZWyZkuIj69b0Tby1NlcWZy34bUtLk4=
X-Gm-Gg: ATEYQzwVMmrRKtTHpVs37YnJTMxaAcNV9YFJiNcEXccjqnbwYVmodx1zFB8JJD6NuwJ
	e0MGGYwsZinNHHvTwiSugKa7DkQuEo6IydVt7Y3YyinZlClfXHpwxBWC1U3YQDOtpTV81Rx5ysV
	PhBl7vg6TkBHP/JAtH0st8YyDm9T3VXitS2RDNIKwkbk64sIuJ1xD88MmqSHtvGcYbeiPwpgwM3
	Te9gweeB/EgubMMQj2yw/Xi+T+W1aWr6JJCm2SJnYonjju/DmQRWxa/4U255cMjCLo3ClKSX8ut
	N9x8xtvxA96g6/cJlMBkJdFHhxexpFC0F0siX8N/6NTZI0yypgmPRhFWw/hosLKTzpnqy5VqlU4
	HKoZi+S4ZlH/R20FGpLbOe6iYb4z/J32IHg==
X-Received: by 2002:a05:7301:19ad:b0:2be:687:5dbc with SMTP id
 5a478bee46e88-2bea559164cmr2813360eec.6.1773669745095; Mon, 16 Mar 2026
 07:02:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
 <20260216-rnull-v6-19-rc5-send-v1-15-de9a7af4b469@kernel.org>
 <Y7WTRL6v0WsR-DWju2vumM1EBu4KZgQzE0VJul7mK3pUwD6ba0UuQO8sclDzOaeLGGh9u3WG5iSKq9T3kQqH-Q==@protonmail.internalid>
 <abfe2LbhLzXiGCkA@google.com> <87cy13swpw.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87cy13swpw.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 16 Mar 2026 15:02:12 +0100
X-Gm-Features: AaiRm52qARL449c2NWg6ctU1DYpJKWGFTyzYGuap71EBsFi63NYUf31noEiyOu8
Message-ID: <CANiq72n5+JadJUW-GO0cwQrq9eJW7cB3ZK7zx4J484RzjxmYEA@mail.gmail.com>
Subject: Re: [PATCH 15/79] block: rnull: add `use_per_node_hctx` config option
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 2:58=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> This is intentional. The line gets too long if I pull it up, and I don't

Do you mean you don't want to go over the limit or, otherwise, that
something else complains?

i.e. the limit is not a hard requirement -- exceptions can be made
where reasonable (as long as `rustfmt` is clean), and moving the line
to an odd position doesn't sound worth it.

Cheers,
Miguel
