Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF06518BC3D
	for <linux-block@vger.kernel.org>; Sun, 26 Oct 2025 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761519469; cv=none; b=Y5SrP71sDttpLL38lDEcz5Mt6DwfJjPmaCdcnNmIReXOSjLIa+aNVnhtaiTI6c1mMVT7H3WLbQ8b8ZMb0uerc+zduvOCJ2bW96U3BRw2v6oGA8Iury8SBbg+Og1XMkm+7BOm2g7OX8DrbAoPKFUpvEq4yPWi2EI44PTWy35Wjfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761519469; c=relaxed/simple;
	bh=eTCy82dBzvhDccXGH6xtnA1xEdG0rMAxXv8v/JOl9oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIif/jFSQV2aTIisVVbozpgo3niRi8BmJj1zDZ7EqiHjToRnNO/lIUZdXWySUQyrb857aGmngbExJXFC83QggOUblCBNldVrKremES4qBukdnjTcJQhTFfIVPIXbua65RNzZCQX69TL5J/ylvfFPsAKJ7zuEtAVAMZRwEbgtxGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZP4pCHxn; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZP4pCHxn"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso865141866b.0
        for <linux-block@vger.kernel.org>; Sun, 26 Oct 2025 15:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761519466; x=1762124266; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tHbMSTbR4YCAeFS3lPr7vbw7nz7n8CmHdlCgaOMJXSk=;
        b=ZP4pCHxnb9bVRrQB4aUok7uFoGAo+qlBfQ4nRjOMwsfbWtaxvn/e89Sv8ENTEW+Xlg
         OZsOBtWHKwJbOmh/OCzbUGbuTMrzNGGH+kOlf4P6PfwCzn2PzsH3hDY81ATnruxGNfQO
         I2T1nCs0h9DaM1aEAIKdFUSDjbVOc9+DGtZaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761519466; x=1762124266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHbMSTbR4YCAeFS3lPr7vbw7nz7n8CmHdlCgaOMJXSk=;
        b=Mvwu4qsBqTTkVTKBzMlU4U8s6Uz1FY/5fl7qKdURxyJup1tUkHF3MgGl9jzKri/iAf
         66jYEGdh+5Mo8YSUrhJEoWDrzf4UmiNZG0rTQMdMKpGPZfMxp/YPKym3cnNCVwk0OVxo
         jwfnR6uq8/Q9SpxnQTcgiSefsAmRvhupBYRbOJpEnlR/J0Ycgd7574c3fOP26yP9VwPU
         RMFlZXZH12kzym3EBbp+ml4ww3u5A9Sb3Cf+XZWgpc+rayp/rRBmlAO2djNG1nuB9Bwz
         R+QVYVpufEQRkEFLi0YWD/LLmV9Y+vvsEXGuVwAMAB9SQA43pke4BlZTvWBNdgs7Y/RR
         JZTw==
X-Forwarded-Encrypted: i=1; AJvYcCXhdj3OekQvn9CEaE6NSBlcm3WEoUyzWZVhrEDdJq7TlFdGvN6eTFwExusa9ZZBpUsU49VekbQghplmpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCuEoEeFyekFbeC3KOe+M1aAEYuhreNNcjKF26A+I9WgEk9X0I
	7pZNjqNylk8hubIzq9MVDisOIz2p388nO5EQt4DhuvP5GET/5BrMfUbpyMIgQVw30DbSWHNPV7e
	AtLoUyv8=
X-Gm-Gg: ASbGnct/iBv52OwIPocK9B0/yHvCsmqP2x7yOyrEuTUAfFCKF7HAARcukBDVvfZX3Wi
	El4S8QruK4CaHjosMYHcvAHsTP0mdxfzJ1n4dppcivvRIO4BausGF7QcHJMGet5mVKrz9Mes9hD
	DGzc6UfoWjQuFtb+KcJ/l11axRWM4QvPVobcIk8OKlmE/Hm10ihekKNXpUvC05Hrp87yJSe7bGS
	HDlY5iUibPRon4YkziwE1C8F4pc4YtAkyENPXkCaJ6Gu2c402UnbJq9HSWzih6SMJr7hxkcpWhe
	YcI1XA+cb1YOvn0Juk5qEWQ36GYmbgtkxXCQavslkKL561/kDi+KapYEBCmKVS7SlUHgQi92o0t
	/iTzpy0jkNYnAjCYZdcwGwKXxYUxOLeQ7wMDzUpZ18XPIMG8Oeo+q9prJPvR20DuPTXgbhWErVD
	MIn/NTcyODPsXYa9p2G3ZZZBja9zgUuY18zMl1fLElNhH6GTsCMw==
X-Google-Smtp-Source: AGHT+IH5gznu0e92t9NS800Q/pFs2skcuw5fVyMYHTLhpusMfHjbB+JBym/pQiscYhbGASoszvBUwg==
X-Received: by 2002:a17:906:2f13:b0:b6d:3a00:983a with SMTP id a640c23a62f3a-b6d3a00988cmr1397149566b.38.1761519465827;
        Sun, 26 Oct 2025 15:57:45 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8548ed8fsm582885466b.73.2025.10.26.15.57.44
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 15:57:44 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso865137666b.0
        for <linux-block@vger.kernel.org>; Sun, 26 Oct 2025 15:57:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/hoH7JmO7OX2P3FhC9Yvhl9SkpfDdClR9AgQDIn6U8eRqfmo9BtC+m3i8JuFofmz6E+VcODkrKlUdjg==@vger.kernel.org
X-Received: by 2002:a17:907:25c6:b0:b2d:a873:38d with SMTP id
 a640c23a62f3a-b64749408dbmr4498715766b.43.1761519464102; Sun, 26 Oct 2025
 15:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <37fb8720-bee9-43b7-b0ff-0214a8ad33a2@kernel.dk>
 <CAHk-=wgZ9x+yxUB9sjete2s9KBiHnPm2+rcwiWNXhx-rpcKxcw@mail.gmail.com> <aP6OJTTWPQBkll56@mail.hallyn.com>
In-Reply-To: <aP6OJTTWPQBkll56@mail.hallyn.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 Oct 2025 15:57:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjE5t6=eO90iXqEsw6yMGfE8Y6=THP0dqXUJHvNQ7=gMg@mail.gmail.com>
X-Gm-Features: AWmQ_bnfaSHJrBUCTUknMbBx-oNR8lppi-asKuqNpXCgeM8R3Iu1_Sv23ysipV8
Message-ID: <CAHk-=wjE5t6=eO90iXqEsw6yMGfE8Y6=THP0dqXUJHvNQ7=gMg@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 6.18-rc3
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Jens Axboe <axboe@kernel.dk>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Oct 2025 at 14:10, Serge E. Hallyn <serge@hallyn.com> wrote:
>
> The keychains are all NULL and won't be allocated (by init) without
> copying a new cred, right?

Right. As mentioned, 'struct init_cred' really should be 'const' -
it's not *technically* really constant, because the reference counting
casts away the const, but refs are designed to be copy-on-write apart
from the reference counting.

So whenever you change it, that's when you are supposed to always copy
things. So that  prepare_kernel_cred() thing exists for a good reason.

But the pattern here in nbd (and the other three usage cases I found)
is really just "use the kernel creds as-is".

They don't even need any reference counting as long as they can just
rely on the cred staying around for the duration of the use - which
obviously is the case for init_cred.

> Now, in theory, some LSM *could* come by and try to merge
> current's info with init's, but that would probably be misguided.
>
> So this does seem like it should work.

Yeah, I can't see how any LSM could possibly do anything about
init_cred - it really ends up being the source of all other creds. You
can't really validly mess with it or deny it anything.

          Linus
