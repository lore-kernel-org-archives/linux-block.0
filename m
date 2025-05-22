Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CC12673AC;
	Thu, 22 May 2025 23:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747955834; cv=none; b=CJA4ZKvnOsJm2Aiyg+gDQj7dNrfFHZiHi8nLMDe6N7un/5ECwOfyf5oTE5ud3MdkLX1fu8BQpGLLNieLZjlBW6jkVsdAD3ZewzDmunKZvNJ77G8xdB2KVtlVPblsDq21Q8X/YzZQMUrt+iwnm4srD8LmIBAPHYwR5YtzmjqDOJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747955834; c=relaxed/simple;
	bh=3f3Fo7Dm23hD8Vzd8mA64sJj0jRQ2dQkVVlple2PRnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtufuFfflcwFJ+zHxFgvLawc5XdIkhMbEkJ5BYFQmkYBhEZ89p+JefCSf3v4suWk4DEpWO5YG3z1igEO/YcVuR0nDmfKY0XxO1i0+ttUqojYBA/6SUBRpWd12UW/JDztjB0USN1/v8Ls7BqhoZr6d9+XZyK45wFszjoOdLjo/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlRoxdE1; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlRoxdE1"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3dc8265b9b5so18026075ab.1;
        Thu, 22 May 2025 16:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747955832; x=1748560632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaM354tZx5U+vN6gfAJSlMDQcTM2SFE45F9vbnngQiw=;
        b=jlRoxdE1LwDm+mLQHMuhiA+6tQirer1KWYsfNpsQIgYxcvwF3B7354a/+w0qid0OCq
         jw1OzRuLRKgjbOG7xdxbe9OQ2Gsi+eF2gtUbLTOjmKq5AwTOQW4zRZQJUq/bgZGjbV6L
         pQgTK70zyWv6HtN4HJndB1RQ9izCnWpZTXPw3PXnhr2WWUq43aHIfPz2cMUXRm/f2Gyq
         KbfY/4XPYYbk2V8XJnthIvePtbrZ2+Fwo0RmurHuYL/hIPAOc2LyFiQJ43ul9mld94rE
         1PCYbWH+hCuVRgPK9FMFek+JdOtuJ5TVd3rSaao2gyiGhH1l7IqhO0ySI7cDrAaVTzkA
         WSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747955832; x=1748560632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaM354tZx5U+vN6gfAJSlMDQcTM2SFE45F9vbnngQiw=;
        b=Qt80QVxcR67BTaqWRQvE7gDik/fg6TBKwO1d+99RO8zlVsYvNqYCdJdgb7psjQLnJK
         JK8elIRt/eWAsMOtOETcAjHV7I27G78RqA8NOgkd2iMb5pd33MT+L2rVEAfxhKGu9kAq
         tD5jFR77htwULCp/X57UkUQVE3AeYAk34ya0Eq0rNULJ5V1LA1mQoZO9KChFLzRdA5q4
         3/BvFm4+6O75Mz3siNmPuPfOAQpXh5nAj+MlaDdAkY6KBEkLOqXplDDFfbDS8o34W7QL
         z0xglv+LHkQESBmc/8ZlVrRywS4FYeRnXEuTh9TWmQUhUd9VhkhgzfuqPn+u5aLD8jIq
         aLrg==
X-Forwarded-Encrypted: i=1; AJvYcCVrwQIH46QC4jH19CH3MSEoKbG6fIfeKLEAaDwOC0inLE2eJzjkAWlfYzYrpHd5YZ6bWhS6O420v+BJK8aLuaFN56nt@vger.kernel.org, AJvYcCX1dpSweyanYw+bJTxyTq7GWisJ/bvwZ5WA9qFCd2nTnijyR1z8gbIjcnmPpdE4pqj/JQAwlHRyZrP6wQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPZUGDrbCr9bgLzL0Kq5UJ1k7hLOgLz00mKnTG/T0uN2CsSZYI
	ptoW3dkS5SOql1lZc6nkvmIdKFVgIkCFvyrmcu4mYUjo2c4RlFCeKBgBXd087mHIWrDMQVfNvN9
	Zo1mRkU3VbEgzyw49O6ovjSvB9MvtT88=
X-Gm-Gg: ASbGncvqGjIFd5qxiUjMUkBShvME+VAzWEFq0jv60qAGzE0jX64+eURHxKLaI0sC8qk
	QkllMorWbOLwkcvvkAGmkaAgaNSitC3QWEVtkYVNkONYrTA9/vUOAf/zFpfFU3P4Gm8z9Vp30Ti
	KSUzlHXixsnCi1rGAgr49SHDrZA4iOrEc=
X-Google-Smtp-Source: AGHT+IHL7FrgTlGS+bXYyQa4ezkcG+a0z9X9zvWhqeGXgBAvxvtnrcJPNRFmVqTXDacSReyBfg0T5giZYyZPcdUJgfE=
X-Received: by 2002:a05:6e02:3c02:b0:3d8:1dc7:ca7a with SMTP id
 e9e14a558f8ab-3db84296d9amr302457135ab.5.1747955831811; Thu, 22 May 2025
 16:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250518025734.61479-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250518025734.61479-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 23 May 2025 07:16:35 +0800
X-Gm-Features: AX0GCFt7enlOC2dQS-dK7V0yyxkE3qzeKRNR56_u9wVWI7Gr7wIMNtBCnBTB4wo
Message-ID: <CAL+tcoCD5ORW=JqvZg7=uJXkLi-WTG-Szj1k8ya9sX6LcR41jQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] relayfs: misc changes
To: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 18, 2025 at 10:57=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> The series mostly focuses on the error counters which helps every user
> debug their own kernel module.
>
> ---
> Note: this series is made on top of this cleanup[1] and unmerged commit[2=
]
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=
=3Dmm-nonmm-unstable
> [2]: https://lore.kernel.org/all/20250507134225.63248-1-kerneljasonxing@g=
mail.com/
>
> Jason Xing (4):
>   relayfs: support a counter tracking if per-cpu buffers is full
>   relayfs: introduce getting relayfs statistics function
>   blktrace: use rbuf->stats.full as a drop indicator in relayfs
>   relayfs: support a counter tracking if data is too big to write
>
>  include/linux/relay.h   | 19 ++++++++++++++-
>  kernel/relay.c          | 52 +++++++++++++++++++++++++++++++++++------
>  kernel/trace/blktrace.c | 22 ++---------------
>  3 files changed, 65 insertions(+), 28 deletions(-)

Hi Andrew,

Any comments on the series?

Thanks,
Jason

>
> --
> 2.43.5
>
