Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2412F2E;
	Sat, 31 Aug 2024 21:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725140538; cv=none; b=ONnJehecjESZKDopEb6KFTDBI1mEDMbd0vPSKSO/8/RTzRrKHSwsLgGqdnnr2NhUv8nwD1ULdDDdpWQ+KldhlhRe6rpN5fK37RuG3HeM8pO6OvqVbJIZ5HdbNwhs3J9Ws9wdHf1JxkXg35VjBGLJ/RGdToOxxW3Va5BBwlsY5zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725140538; c=relaxed/simple;
	bh=lcz+HFj7p6wKSwvMO8xJnnqLvFwsM3Eva0aQ3Uxet80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNlgvAy4sCUKqd3yx0pVYsxSMzYFR0ZcW5Xh5UYegHMWjFV/AqSkH+p4U/NEAylf5b2arP34x02+9Arce9/96y2fRTs36cSzf6DdltKDDTWQW2g5q+fQKfHma06vRWKP+6oELwbvqBbQZs1Du6HpmnXtQHs3o0cQ8cca8eAi2u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTbMBzZj; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTbMBzZj"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7c3d415f85eso412172a12.0;
        Sat, 31 Aug 2024 14:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725140537; x=1725745337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcz+HFj7p6wKSwvMO8xJnnqLvFwsM3Eva0aQ3Uxet80=;
        b=RTbMBzZjZVHjsTDa5b4QuaBul43Dlw/qZJVSnRJyKUG9BJYHrIw+o7GmogwLw7do1G
         9fMzo3r6MQccWPuxiQgcTnYT77cPwCtMuk4wtWO64eHjDloDDIt8j7PN3xtXSLxEZf+b
         BvmLvT5U7i5M9RliCx7FLDiIDavSXQYb0pwgA/z8+26Fpz7tKNFXbUNw/irkFpgnrQGH
         hmhDcNXom8D4IrqvbfrQ767seAVOvL8pa0iGd06NelEaqGz2sSQW//jYLRYF5z7KeJU0
         s5XjtBl4VR0WQZ+vN0/ryUjvJ0KoMAPYVygX13GOwfwtrLwGlIQm1XpjQg0gJza4WG/Q
         9/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725140537; x=1725745337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcz+HFj7p6wKSwvMO8xJnnqLvFwsM3Eva0aQ3Uxet80=;
        b=B7hrL7XygYE0tGt5UK2J1deDyP1P6/22on9gf+95R+Lv2EXPtRrPBuph40ggHl5meO
         Ol/Y/9B6B1/ouq6FCEu9HBgmFNN2lFXDZgPwGGWsXD/yBBDR30wQelQtc4lcjX4L+Ggc
         COKjpYObtZGzQ3z5CpD8aWRhk/HN9m0dX0t5DSRnDUALXOPX6vChwh24rDaBRX4HGUDN
         37ZWAUsDCQiDaSXr8zT8WNHUIwwL7Kk3x504ryiajCTMkwk+UJ1gi4N5dy77GB/T/Ugv
         Ok5aFeov/gGUbYAWfw6qdIJ56W1VW6GGjgzMb9IhzMHp2I5/bTZ7yLUKxiFtWQ4aiqru
         BlSw==
X-Forwarded-Encrypted: i=1; AJvYcCVbEROPMqvXRS8C2wGvjrqB2aU0eIBXPzbh1ARNmT358+woOKxQpKcSiv69jzW4l8kbDXEu95wNYDqYAenpcGk=@vger.kernel.org, AJvYcCXoMy2D7EVauzo0kJyeZukTXWTRjCuFcPr9vRE3oGSEAT1hxBwbPjy5yGRsCT+8OVjeoXR5CoSqmrGoaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFB6suVmQIvnHjgOicf14BOTAxzu35ELuf2EQkarYZxZwTiTqH
	1EG50+umLOOilOV+yCVwWwO2r5LMpHx4Y7FvAYleIxzBf9BEJQh/gT0PTLUwKJP4XKwbjUm1CR1
	lVvfSLSiC2f4bc6hNChxGfg9D7LY=
X-Google-Smtp-Source: AGHT+IFYtkMBdQmDiGuPFmf/0c8iWeNY/88bomMsOTIR2DEeCpBL5yPlbKmvVTlnJoo7+9SIvX6oUTIq7rCCLQsTaa0=
X-Received: by 2002:a17:90a:65cb:b0:2d3:b598:8daa with SMTP id
 98e67ed59e1d1-2d86b84fa28mr3635540a91.4.1725140536614; Sat, 31 Aug 2024
 14:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACVxJT-Hj6jdE0vwNrfGpKs73+ScTyxxxL8w_VXfoLAx79mr8w@mail.gmail.com>
 <CANiq72=pX32F4pDq85H=9pB=hmUcH59Xp7JoNGpKJ+XxkzovcQ@mail.gmail.com> <6ca8edb0-10f9-4967-b0d6-3510836fdbcf@p183>
In-Reply-To: <6ca8edb0-10f9-4967-b0d6-3510836fdbcf@p183>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 31 Aug 2024 23:42:04 +0200
Message-ID: <CANiq72kMRBAUMBSA8vC29U=c7JVycW8c+yfMc8ZDN9Mq0oi9tg@mail.gmail.com>
Subject: Re: [PATCH] block, rust: simplify validate_block_size() function
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Boqun Feng <boqun.feng@gmail.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 10:13=E2=80=AFPM Alexey Dobriyan <adobriyan@gmail.c=
om> wrote:
>
> Ignore the patch BTW, it was mangled by opening gmail Drafts :-(

No worries, and thanks for the patch by the way!

I leave it up to Andreas whether he wants the range check style or not
(I think we should decide on a coding guideline for those and then be
consistent).

Cheers,
Miguel
