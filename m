Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE1F3644A1
	for <linux-block@vger.kernel.org>; Sat, 11 Jul 2026 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783775382; cv=pass; b=qWoQNxTlqRcS9FrzOGKl0Ws9Ke5qT2QjixEtZBlYnBKBo+F5ocR3jAZxVNtFetLHjvgXP2HKzi3eRnsOg1r4LZ430+I3KniEWTHQxbq6SmPgkuS1A9ts7IT8XLfabvkK/jOf1oymX4x1Q0aMxeG+2UlNMLCgJXJmrUZhAsYnRT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783775382; c=relaxed/simple;
	bh=/2UfdN5Nqu4lM7RXRcLv27MNGfJkbs9IexWElOspdQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAqyU2xw3R8putDB46T2QTkBJmoKtpRewt7wfFQlpkppHadUN83bkTgjZXPrYPMvDVYMuYNphxgjPGAgGU/d/ZZAnN4yNmMpB6Q+8f4kNb53/gmGiq4tEU6vuetx/03BW/imA4vSMbEhKcabOdrCIy50K+HC2psg0HEMzjgkwQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n5M1L7Rl; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5M1L7Rl"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-384caf7b168so283118a91.1
        for <linux-block@vger.kernel.org>; Sat, 11 Jul 2026 06:09:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783775381; cv=none;
        d=google.com; s=arc-20260327;
        b=KGxsMjjZqdzeBabx1ff1Q5M5fJiAHJ2vV53fWeC6aghW1ib3dD2EEnMM8lzc69n/a/
         BJscMRckisLfuPahMK0Znc7fwqdlGlDLiHEQGITx1feQK870bvdZZ7CnGCR3sGlFeZZ6
         VoxJ3pif0hwEagkLsrdn1oxMPj8LRr0vyVLupyEn2V7riSQ3WsfBYnSqYWj4WeZsL6IP
         RGnH4KSM+mWKb6lAq+iGvsv3LnQnitMRGt0c5/sK8ntbIdjZpwGPLLT3HEGrkdO2kYlG
         1BSS3+BX+/PNavqvTaUUVnKBKcyVAGnIfk5e36AyebUocZkJ3t5PD5lwyXNBatR3R3Lq
         ak/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/2UfdN5Nqu4lM7RXRcLv27MNGfJkbs9IexWElOspdQA=;
        fh=eN2hYWXFuqlIZyjdZcWDklEcsfb8xaEtBLVkCYKh60I=;
        b=IYVXovi+TYXVNc8Az4ciA1Z+5D9u8XIBW/Nwi4E5hMWuL3+nn9ruCtz3onk/tUvZ8D
         GxJ/Jd492f9boHnQ6hI7XCHIjUbKh3+MkTxI2XU8f8w5F6h9HGVX6WvtdCz7R55RjJI/
         4xASN1nDWoF53kzRKMlDXPVM4H5wGxNwP2feyv+bBKUA+pcGZgGJxOZXxldrw3j3vi8S
         4uJM7DIQhgfhSBGRUrJgX9WNEfGS3Uf6qJKnfd/TN+N/OhjGdHquZ/EBF155LNi/fAEi
         ZL8k/7Al78eR9JOBpfDM9UOGIkJBSJ3IDpacND1j+ff9PL+chk+z+yWyAW+XKf1xmKkD
         hKQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783775381; x=1784380181; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/2UfdN5Nqu4lM7RXRcLv27MNGfJkbs9IexWElOspdQA=;
        b=n5M1L7RlsQ/ynbaU5jyg367CtZXLJcD7sTEfqnBk5D5kMI3/kDtOEJjevpbTj9XpOk
         0H8PTtkA6/J1Q1FEG++IoH/9z4LtNt4yyRFpByi54FdROQxwSqADGgWXB9/ysJ2M+nnV
         soVl4764AD8lXCUPezk80W5L6ubH1HK0wRcT/0/v0ccY7eLKPXd9ODj+ICH44kl75hWs
         Stb7HNfI/D+Uu4uhr012mT5ovBQkkQoo5NfGogp3jK0d3c8qVuQhzWvlbFhhXTXc3XUO
         meanXp2EkLcHETN0ASOqvNTccTx+Cmu20cxcuCAsyXs34A7tzcD/3SAIrIPNkJ5mgJDs
         165g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783775381; x=1784380181;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/2UfdN5Nqu4lM7RXRcLv27MNGfJkbs9IexWElOspdQA=;
        b=oChfZ8KGV/nlSzNjc3+M3bHeNZYRnjml8xim2KGF4lFJN89v/Xo+3wl005/xEqYfn+
         a1+4SVaugDjc0FdJl9KTL0M0GT+7U3D8BH3zVM8ZzRQil18D0pAfgnaH1JpQ09JxxVd/
         Ht/t1Y0wM99T63F3kP0BOw3xsY5hyDhxE7Gsqb3R+nF8vsAYGPooPBHFwcN4+Db4QtEd
         eZscMer30jrRzA8l3XAu9wcdRKjn81++wQUkfRkO1QMzD4uU8sH4JKj65gUWCH/C2Sd5
         uHMhru+CbpRl272FIz0mh9SMXrGwo8hsmCvfyUYubYbNSZOV0PatWJ46l/sKz6LqAqwH
         hc3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rql5lkHIilEsa0sSySbuWa6q0Nff0LMH3lCKUE1ryYVbx05+FG9gdFY7kWnj/FgWfoF1TkPG5oAJH6BzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwD6rdUOg+tOh/fXOcOdLXuI7eBJ2ugPu1RFJBUJ4JuilxeghKh
	7gOvsNbdmAgFCSlBA4Qz8D8j9OQd6CiKus3yHcboNjUJvKWEg5m3uUlyBhEJE8xkgCmMYzaI3Vr
	8+YF3Bkp/Y8zPNZdv5IRg3dsefBmTOFc=
X-Gm-Gg: AfdE7cnnFQSFAISq/LVLsru09TdodUB1Mx/BuRvDo20KRJxMZZA7dj6DB/1LgY3/vyg
	Y+ajaD+ia18o1hyKACiS7z5JXktbppEQuvV3lwWk/MN/TCJf2lGL07JisLQlW8DSXPaHjSpyDwJ
	p7vsxaAJ7o1gbqNtFFU1WQqeKiVlT60IJRH2uGCxx1DEJXZs9/ubYIUTDfy1XX7Q/KAiMNODhCF
	QiHTsHKAKJ8yBWiRELeFksQz0LkQ5VjOUkjosAWwKI8WFGvDMYQxEkP4eqdB9KVtNo79fnCl1U0
	NCEj1KFMGK9gTmv0VBDGxBiaVXR6KOb6YA07MTTumzQfT17l9dTdrnX83iasBKG99OLiICjDC/m
	Dl+OUDa0h99WN
X-Received: by 2002:a17:90b:2d4e:b0:368:b002:bdad with SMTP id
 98e67ed59e1d1-38dc779df28mr2131886a91.5.1783775380898; Sat, 11 Jul 2026
 06:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709100100.604252-1-yuantan098@gmail.com>
In-Reply-To: <20260709100100.604252-1-yuantan098@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 11 Jul 2026 15:09:26 +0200
X-Gm-Features: AUfX_mz0L0PMjZc5QaihoCm9iseWlIO_uGF5cqSVyeeh5Ceo099XX7o0kud-B7o
Message-ID: <CANiq72kbrtG2vecjXjnw2=qnFbQ0BV6NS1phm9Xvcwu9t8HM2w@mail.gmail.com>
Subject: Re: [PATCH] block: rust: fix `Send` bound for `GenDisk`
To: Yuan Tan <yuantan098@gmail.com>, a.hindborg@kernel.org
Cc: boqun@kernel.org, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, zhiyunq@cs.ucr.edu, ardalan@uci.edu, 
	pgovind2@uci.edu, dzueck@uci.edu, Yuan Tan <ytan089@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 12:01=E2=80=AFPM Yuan Tan <yuantan098@gmail.com> wro=
te:
>
> I noticed that this patch has not been merged yet, and I am not sure what
> its current status is.

Nit: this patch wasn't tagged as v4, so that may be confusing.

Cheers,
Miguel
