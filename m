Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96EC2566F2
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912530; cv=none; b=CcsdwPKnMpH9QSla+Xan4qWCrd3O8fEjb/BYx+WpmFYGQIIO1p/TtGZ/dPzM2Gyuli1UDz1InqbD7sbMlOjXHjBPeOiaRQlJa7cg3vkZCBh1DNYmYfzuZTcHAIi9PYOj6UxQ2t+C+Qx7FeGZFyTYBs9E/z3cTK9HXZKazKd9gvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912530; c=relaxed/simple;
	bh=5GUBODVqbrbXC+oeqNCm+JoN5ybg4Iu+dLTbMlmaaDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3ujFsW3+oyXfsYy4/p/cQpfiGKeFXlmrzu37ng+YOfdEoxTqnI0b/b8nGz+bw+wl3HUAwSdKGgY7hy4UWgyAySdxgXrhO1S/yfGxdEspBqd/BZGjM71Oa9bUUe76IGlsE1IA2wjOZ2Hs567lZhYlSNqHSlo0xW1F7r28OIE3zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvM0enqJ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvM0enqJ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-30363975406so138121a91.0
        for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 10:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744912528; x=1745517328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gBsXVnMamKirJ8phDM/1SZO4d+WSZ0MEP1U7vrEKXE=;
        b=BvM0enqJIMUh5sD+kEKYOsmnHFAwA5x49TQnhg4iXTl+jYLDpQoBZDx+CDHoOFIKIB
         ijnjhDfFa/KgHkDZlvbjmYpAOKvYOov3ExX8bBnlCoCQw3QgIx64ScHv9pT4hqnI4Bcz
         GvL3X6AkhuvQCp3nFFMU+jhx1QubhJPGGjzYAFU5x10tCT6B5cRg17O+e+zEfKkMhDwW
         GSz9ERkRIVXUSiRrdyKDbBVI1a02wvek3WQ/X87dsnA1t5X4p31szxkhqdQRs5RNxUpD
         LSpxd+BgkU0WoeT1ClEB/CYabBbngilHFoH8oMSRmVOgQ1dFba/isMEpKF3SRjscYXs3
         0y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744912528; x=1745517328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gBsXVnMamKirJ8phDM/1SZO4d+WSZ0MEP1U7vrEKXE=;
        b=V2PaAaxN+v08iLPmZ2xEv03RIf0Kq2gTyM8a8olj/L66ZyeQ4aA5Ha0kgxp+Fo9JYw
         EVETtmmXgXpmlr3P9yrHv0JPezHzKrQZan1fe1MvbhwV6ysrSH8x1P5a3rYJNjC7Ldm8
         5Cl1EHG0W4tCc5zqGGWimgFJFNKcTmEGPCosjcH7PijmEHzvsZJAlGba8jHFac4n0MDb
         g30orKZMBRwStO9+Pp/D5zLrguws2yiziMud9q1EMuGi+ar/6k0jIOh8xl1NST1JhhQu
         zFTzF+VgoW6MlrNlfMv0wpP12aIYCLT7XXHaTK7GUE4IwkaVFsBcpNHts4F87AyECsEr
         S4gA==
X-Gm-Message-State: AOJu0Yw+IGXztTprIg503EEG7DDnVqee+P6BhTAmW0a4s78wzDX7vKRa
	S7Fdg23vqLY1aFpM5IZS0r56hdB58Kh1H2rpRw3Ok6K9F6cBfgjdioEgfVQYmo9jcKUtX9tuKp6
	gczup+ihI0lWxVs3Oac0bq0U0XP8=
X-Gm-Gg: ASbGncucF0K56RMmqWvotNgpMyHAS6hXTc4QiR4OKsC8xOLtk52vbQpZjRsmnujYpjA
	5zB4BTm5z2PB3jbgQSGTsUgkHaO7FOhu7LVYdRdtG69VKuxzoCd1PM4mX1RhyChYWs2nNzz6vdn
	3yH1JoXWwQijl3FPwwx4oSKQ==
X-Google-Smtp-Source: AGHT+IGiv913bZ0B2z+Elvnqpog1Ik+R+aujpb113LI2xREZxdylIhsMPym7pjhS42kg91LECtHu9R31WlfEyjm+BE0=
X-Received: by 2002:a17:90b:3852:b0:306:b6ae:4d7a with SMTP id
 98e67ed59e1d1-3086efc52c0mr1919414a91.3.1744912527976; Thu, 17 Apr 2025
 10:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417163432.1336124-1-prasad.singamsetty@oracle.com>
In-Reply-To: <20250417163432.1336124-1-prasad.singamsetty@oracle.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 17 Apr 2025 19:55:15 +0200
X-Gm-Features: ATxdqUFFMtn63bhEBuiiN6HDneSSgURDYEiAlw0vdds5OOv6Q0u4vxVwJNMiMOE
Message-ID: <CANiq72k-i-hDCWgfqu2OZU=FGKe3MJh5FxnnpGx1Jz866tXY6Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] block: prevent calls to should_fail_bio() optimized
 by gcc
To: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, arnd@arndb.de, 
	ojeda@kernel.org, nathan@kernel.org, martin.petersen@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 6:31=E2=80=AFPM Prasad Singamsetty
<prasad.singamsetty@oracle.com> wrote:
>
> When CONFIG_FAIL_MAKE_REQUEST is not enabled, gcc may optimize out
> calls to should_fail_bio() because the content of should_fail_bio()
> is empty returning always 'false'. The gcc compiler then detects

`should_fail_request` is the one that returns `false`, no? i.e.
`should_fail_bio` is the one that gets optimized due to that to return
`0`.

> This issue is seen with gcc compiler version 14. Previous versions
> of gcc compiler (checked 9, 11, 12, 13) don't have this optimization.

I wonder if whatever changed could be making other things fail.

Anyway, given what Jens said, this may not be needed to begin with.

But if it is, then as far as I recall, we try to avoid that kind of
"don't optimize" attribute (the one you used for Clang). So it would
be nice to find other ways to do it.

For instance, if what you need is to keep the actual calls to
`should_fail_bio` (not `should_fail_request`), then adding a side
effect like the GCC manual suggests in the `noinline` attribute seems
also to work from a quick test:

    Even if a function is declared with the noinline attribute, there
are optimizations other than inlining that can cause calls to be
optimized away if it does not have side effects, although the function
call is live. To keep such calls from being optimized away, put asm
(""); in the called function, to serve as a special side effect.

And if you also need to keep the function name emitted as-is, then
`__used` is also needed in GCC, but that would make sense to add
anyway if these functions were expected to be there. Given what Jens
said, I imagine that is why they aren't annotated like that already.

I hope that helps.

Cheers,
Miguel
