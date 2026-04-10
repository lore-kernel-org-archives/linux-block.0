Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C473DCD8C
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838929; cv=pass; b=juzk14Uf0nGQb80sh0ALyFOwDJBjcpgLTY6Ag1radiABwamAx/a9ly/snWtizLYP4ml5nhAzjoSRtFl9C0OV8HRs7aRg6s06e0t5vicHkDavWyQymoO5Y3ERcqPBF4TtwxfPWjzdFt08KjAqSWWpFzn5eZK+YyrjUjzFN9f+00U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838929; c=relaxed/simple;
	bh=nZhZVTEl2HixnZN4nd5HjMhIolvVAiADceEjgAbf9UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVSFfqufnJe3TNcqfAnh4VEaKexkSWlxszdu4axYfK/5lQ20EBjL5zwpGBkhhHxFciUnXsOXhE/qH2kgkgovrZajojZENpPQYQMGq/5cYLkaiB3VVgmKie+rldyYnjRrp9zSow1GR60hO4V9fylrsB8Bx7myxTGrG8ltxF/YIaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjCWPq3J; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjCWPq3J"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2d3c9ae1355so119825eec.1
        for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 09:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775838928; cv=none;
        d=google.com; s=arc-20240605;
        b=NFW13c3sl4MmGLN9oqzXR7OKyWra2ARB4KmbY+eJ8Us1zVwDCjxeWtqL/E/TNEjECF
         bj3KMMlW3yE06imUon/3E25tW+dp5mdExA2UoGVStPdiJLa4+z81MhIZkpdME7rl6rLu
         28ZHuXXBN0UJqKM0mFrKk8o3n04a1ntjAo4V3ekY2+JtupxWLKXMcZ+ETFVZitv/E4k6
         quEp/u4I30Rses/LGQIH+A+6qB013y6ez/iDI8eFAL0667rz3ZJ0XRkTtZPddu1osYUK
         b1fygGua2YuMo/ZpU+Qbv0q6zVhkfpxGp6AkOkuYwJr+J+TLVu8zcSz3/S1exKvZr7lf
         +uFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1A2t24dEeevhX3tSnHC8LYu/k2C32HhKCU7LEoHypy0=;
        fh=fX435q4hvbPSmVmExjLYJEnD0Gg8ywVveobC1je6myQ=;
        b=Q1Zlr0jco3fmyyMKtevHdx6HYo8CiuIaesjpnhSVA6trpojE7+yHiqwb21pImPpLXh
         igQ1vbFt9Wgwg+3ifgAy56GRdcFfR2IXEzYrl+A/EcVUNhA5499MunURrqIfiSYx3191
         RA3LSsJRWRJP38m9ub94EaZfdkeOapqi7A14chHrhwI/Cfr9ZcfldKXS33/h1igjjZkB
         ZptiGJxEOkeJbYUXh0sQzk5Ut2DP1qMcCTNq25tP240KA+LiXdLhJ0yZHbVkzGa+aE7w
         +vPe6xGv/oq1+TS57g+C0IJBZV33VUqA7w1Mq+Ac+ht4n6Wp9sJae6v7aetUC9eN7O4Q
         9poA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775838928; x=1776443728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1A2t24dEeevhX3tSnHC8LYu/k2C32HhKCU7LEoHypy0=;
        b=VjCWPq3J776DCvqUz/3Q2PCVI/5eF1JL+3npWZ4iE7KYUM+2qWE8qBQXZHjHMFSkJ8
         eL6ozEpTexjq/ufYpg7L0pvuZEBEsSBP+7rFWG3bClUrgVjtM/+m3jt1zj7mwjFghXj3
         DObSmtpcUWKOqa0ZB3zdK3WzHfRY8NzfULKUK6XYddoC1LY74taYWhKCELy6suNrDE/j
         iVIcjTqIpK9xZE8U/rfaXeAfeD0OvEZt/155cop+JOUTPUDfup/i2NczLpVNdsSvxFd4
         G9nLy9XA2DKZbuIXwGZAX4/C7fJNe24o2vcBTO6I6mv/HSOZWkEZp3d9I6H/UMpGhxs0
         5s+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775838928; x=1776443728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1A2t24dEeevhX3tSnHC8LYu/k2C32HhKCU7LEoHypy0=;
        b=kgld0P0ql4JuvKSqIJpWSWkRqh4Qh14NC684UtW6w9b9nzgtlX5tJtyZEoBDrmW6BQ
         AoJvOrjRt6ybP0CSqhTzby/Fl8+CLy5BrxPUpTRwzOvCHAbHV+nRAcLgJLU3GM9jUt6m
         bDA4JU69F+MFkXk//41Kjto/ICMuymikb5W0SElWRbW6+ndLzE+Bs4wJKL8qjLhxfP8P
         CBiVe8d4BRaAAEl0Qsa/BNhFJ5twVaFXdubq03tVfCYh7GkRRuxzUE6P5vCMjantVWdD
         R9geD85uTMHqTw8RcN/+oO3/hGUYWSWHA3Teq6ZsWzVQcj2SreLP8evHZ0z5uayU9kpV
         T6Mg==
X-Forwarded-Encrypted: i=1; AJvYcCU1lctFz3YY24aLcSWp0fC90pruEZDHYMrYhSxTjeLaoReL6vIohnAENLpDMmqeZyBYYl144aq6zd55xA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAyJ8UQY2qkdnbXJuxjlbQdfSWtdbFXp1ZC6bt9/CeGXfYqAi6
	+pH3Icx+CLb6z9cxM6KOCoHXEI6xYJ8tG1ONoNKUn20PWdlKxpesLKgbc28fLt5dR2Nz87viVtF
	anHsZG3oGjueniUTbNkRp3eJTwDWHsJqJqTCD
X-Gm-Gg: AeBDieski6mNMl65FV8iwDUsUMtdHPxFrI/1ILwjzTLPV6w9Jfe5bkb8s3crWn2F7yE
	qZGDoaYSdoPYzpyi9ml44Hj3mYttHW4QKvdEaaHIXvlnpuFfMDnMPia1DN+nyA4ztVpuAIyERv3
	xigAnThmINFlNIOqMPpEU5YmW5s2pYCcyJHgLovkFoanM4/N7b0JyziP7IJ2Ur1LobNKNQZaiT+
	PfauXs2CdmjDEQmHPyQSgYy/IzmmreL5xyr6JfkEWmgUzmu8dAvrENPCqL0eWzmkRmf69rgCTc7
	vYhvB4y4xHsGV8aJQaM/TyUPQKRJINc6hvWfRm9iRLZpSuNkjWTomnfShbkGjNd1QIfQBXNwgr4
	5TlddR8XsXRLDUiBIbyroYT4=
X-Received: by 2002:a05:693c:3114:b0:2c6:7f49:a862 with SMTP id
 5a478bee46e88-2d5871bcae7mr817130eec.2.1775838927812; Fri, 10 Apr 2026
 09:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ANIA6QDpKJDgGvi6bWi53Krz.1.1775836309095.Hmail.2023000929@ruc.edu.cn>
In-Reply-To: <ANIA6QDpKJDgGvi6bWi53Krz.1.1775836309095.Hmail.2023000929@ruc.edu.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 10 Apr 2026 18:35:14 +0200
X-Gm-Features: AQROBzCEbimQSafwwRYOmIwGS8A5xzuRb2XBrZuca3M22OU4taVbHqoeyVYiwK8
Message-ID: <CANiq72ntFnV8ESA7gOr1BhUNVrNKpG+BqO60o2-h0vPxfB0zig@mail.gmail.com>
Subject: Re: Re: [RFC PATCH 0/2] rust block-mq TagSet flags plumbing and rnull
 blocking wiring
To: wenzhaoliao <wenzhaoliao@ruc.edu.cn>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, axboe@kernel.dk, ojeda@kernel.org, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	bjorn3_gh@protonmail.com, aliceryhl@google.com, lossin@kernel.org, 
	boqun@kernel.org, dakr@kernel.org, gary@garyguo.net, sunke@kylinos.cn, 
	tmgross@umich.edu, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 5:52=E2=80=AFPM wenzhaoliao <wenzhaoliao@ruc.edu.cn=
> wrote:
>
> On a broader note, Could you recommend any specific missing abstractions=
=E2=80=94either in the block subsystem, configfs, or elsewhere=E2=80=94that=
 the RFL project currently needs? Alternatively, is there a specific TODO l=
ist or tracking repository you would recommend us to look at so we can pick=
 up the right tasks without stepping on anyone's toes?

I would recommend looking at the notes I have at

  https://rust-for-linux.com/contributing#finding-tasks-and-issues-to-work-=
on

and the links there -- I hope that helps a bit! :)

(The kernel doesn't merge abstractions without a user, so what we need
are use cases to justify the abstractions.)

Cheers,
Miguel
