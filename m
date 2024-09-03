Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E1E1D7E4E;
	Tue,  3 Sep 2024 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391868; cv=none; b=XDsfKiiQ8nNRIatNQS/8epYwSQKj4kBEF7cuf4LYPvzDg5MI6n1CJnzNzs5jeOt5fPZWS3aO2No1+toCVN6ihfbQzB2tZIlb22X588mC7C6sxbVFmqUFO9+N4SeD9Y+M2Hn7gpdXd50q33XFeq67jsBBMc6WW7SwxtK6fzhtRzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391868; c=relaxed/simple;
	bh=PFADzAobtGQyxswhtGzm7oHP5BEdBKmeVvXdsDuxHu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unSRvpwn0G2Ikc0iCfrPyQJG2gBHDO9FRV50NQucjI2yJIwJR//opTpEgni9g9OzXRraVzN584b0kxXJOqz3SOadN6L0GRp9D4IiPuQh6spL5R2Mfu0KBpB0YVy8xXQRp6p7cocHm9A/a5NbZ7O00tc3Y9hWpkfcvOYFaSgkv70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcS+yIkM; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcS+yIkM"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71420e66ecfso465674b3a.0;
        Tue, 03 Sep 2024 12:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725391866; x=1725996666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFADzAobtGQyxswhtGzm7oHP5BEdBKmeVvXdsDuxHu0=;
        b=CcS+yIkMmnXnv/7MT99+PRqvo9iZAVo+CLtZuwusFiXs+BZRI6fOwNs1uG30LjXw99
         l3yw0bqwvCKdBAeh9gk3GpyKnABEaq2Oexxd8funle/SgCNta6wnwvZvL4Kan+uzfDls
         h1MoyYWPqubA0qhpb6k79irPQ0+6OQyNZhovhpLJf4VZQxbWOS6AC1jqZL7UtNRZ404B
         ZAuN9poQUGX3LlONpdLOjTgo6NLs3iCXMmZPoSWsaUefPonjjSqrspbGQ5MYSWDKf8Kd
         VkIAbzEI0ZV4TgsUfLQQmYIGh7bCAkSFfaw8qQMUql2pU7zfPcwSY/JiHEJusLrZxZQR
         u3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725391866; x=1725996666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFADzAobtGQyxswhtGzm7oHP5BEdBKmeVvXdsDuxHu0=;
        b=LlTPoRkk294A0TMY4B2x+b5cd9MgR0Gxe/kj++P4FNZPdFKMf/XB7P0taCmxntRoku
         UoDUjei17Um+IweYSw7Znjk7aDPXNecSVt1lGUB/6TYc6VdYqRnT5wCMQ1GQvV68HhCu
         YtnLY8S4fdKQqoIzKkMgGfjuU9zJxZbw9Pvn7DXmOZFb5SOqD/vjwRLuilZ3s+utz/IE
         rSR/Djh2wFEwOuEjwzam26fTjU+E/bzrDOb0tBzq++NjxFMHWzqbPa8Wto8ryK/x+Qnj
         UXz+3QGGkeU7PFpMzrlZJJ1LCKf2ULxoHysGj6VIJhrJ3ViP7SBDkFMKymXW+28wEGkW
         n2cQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4uTFCEgzs5HDVEwWEmPKD28DGEkT4ZiJwo/1h5Qbu3SQSQ/OxAIXp58o9WViNEyuaBuWvOaYeyMcOAm42TMA=@vger.kernel.org, AJvYcCVzfOzqTSuNTbKm94p+6GbspXSYnFPmR3hVDPSHJk/z2owZ0y1idL9PMUe7jGZNGtz6kaI323eyAzetSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCTdo680KgyZdZTXBhIBudELNJrEzzq6SDiMJ/yhsoEY9zcFAU
	agK6dpheUfboFT/KxXKw98htYIqQ+Cp4PT0u+ojI7qPkw3tybIy5nhrTwq4BLrj5PLm3gERxhX8
	eZsJOnCpHpSfXZHKJwVzJKZSq3BU=
X-Google-Smtp-Source: AGHT+IHh9CsY4yVhRJ2qs32WZGWKKUWUaDj0SQS4dc0CkDdmN5IqxpmTZiY2wvIddjXFFSwhepjIXKkf8xKyLf+wV08=
X-Received: by 2002:a05:6a00:2e82:b0:70d:1048:d4eb with SMTP id
 d2e1a72fcca58-71730730585mr8731761b3a.3.1725391866135; Tue, 03 Sep 2024
 12:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878qwaxtsd.fsf@metaspace.dk> <Ztdctd0mbsJOBtJV@google.com>
In-Reply-To: <Ztdctd0mbsJOBtJV@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 3 Sep 2024 21:30:53 +0200
Message-ID: <CANiq72=GRbxY=3-NP6RutcJjCqRxRftafVZqDD73tureOh20Ew@mail.gmail.com>
Subject: Re: [PATCH RESEND] block, rust: simplify validate_block_size() function
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andreas Hindborg <nmi@metaspace.dk>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Jens Axboe <axboe@kernel.dk>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 9:00=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> If you want to keep dividing into Rust-land and C-land I'm afraid you
> will have 2 islands that do not talk to each other. I really want to be

We are not trying to divide the Rust and C side, quite the opposite.
That should be obvious since dividing both sides only hurts the
project to begin with.

> able to parse the things quickly and not constantly think if my Rust is
> idiomatic enough or I could write the code in a more idiomatic way with
> something brand new that just got off the nightly list and moved into
> stable.

If a feature is in the minimum support version we have for Rust in the
kernel, and it improves the way we write code, then we should consider
taking advantage of it.

Now, that particular function call would have compiled since Rust 1.35
and ranges were already a concept back in Rust 1.0. So I am not sure
why you mention recently stabilized features here.

For this particular case, I don't think it matters too much, and I can
see arguments both ways (and we could introduce other ways to avoid
the reference or swap the order, e.g. `n.within(a..b)`).

> This is a private function and an implementation detail. Why does it
> need to be exposed in documentation at all?

That is a different question -- but even if it should be a private
function, it does not mean documentation should be removed (even if
currently we do not require documentation for private items).

Cheers,
Miguel
