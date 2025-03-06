Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E28B259C9F;
	Thu,  6 Mar 2025 23:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741303736; cv=none; b=unOCFHJRgnvwwfx3bMFmvxurJeeO12YMoDScH3yPw2aTtozKR2gc4K2Quz0su3TEaNLe+7C+rBsFdKkAitTqdelt7CegsP0btxmAyc/WdiHxH8+mpVOw5e1uV+MQCSkxBLOg58nuK3qdiELx/2FkrQaYAB8eS+mMQsYkK0Cl5TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741303736; c=relaxed/simple;
	bh=nh7ClG5xpB7iVPUSC5b9cR+XtRGFSg8uFU+sQmc5mHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJhTTdlywn++wTfgVdhVmXGIOYTPR/hHtBZG7aJLH8SLpOobuJ0iuMThp5H2uHv8sjMtoUscnxhn2bROhaizVsJXXfvhbTjaaDR41U4Wf+OxM18uLdmowigmO5An5Ciy6OPjo1KBjqoZJyjONpMEpVkTRL7GYSpjVxVH08tgp/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZbVxBka; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZbVxBka"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394036c0efso7269515e9.2;
        Thu, 06 Mar 2025 15:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741303732; x=1741908532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZl2HOj5CnuXTvILYduxJ5ao1DJjyVJeLLF8l6J639c=;
        b=lZbVxBka06BAUL3hn+A8qmBwAXa6lBSIhu+SIVOSSzAouI0F2zGruGY/lcDa3lv622
         V/2Jou9bde95w4+m8a0IYPlyXp5amvTZ/hRCyO9OM3ELzNT7WIWvqpaQkw5fpvdDODEs
         DdN415Tn79/PB2XS8IgKjFLBIwpfWESp+LFGLeQl9ecr8KjXXnrbVbPQa3X0+eMiI5Q7
         MxvF4ZhnXXcpMsTdwl/vEcYJttzwwTuLFcjDlYt05gyY1wGkT6t0t0JuOzaFO0KBaWGI
         jXjjAWHF6JESIClop0ay5OA8HR5MfYaXUyOC0OPaUDwshSr+6wZh6KLednmc4Z831B0C
         92LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741303732; x=1741908532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZl2HOj5CnuXTvILYduxJ5ao1DJjyVJeLLF8l6J639c=;
        b=HlDZxetRYvSljn7rh/Zi5Q9tWUdL78tsrs2Wdc6i397qZzEoDmHqbM6VuKUDDfT1qK
         QrH3lmt5/NVzevim/iO1v//qPhkBEaRMxnM8C+dOBBwUfJfC1h838BrXyOGqGlMW82uI
         MVibd7Qr4kmXN4W4o+/4b7oznutKiy6toLttpRY6rDUVp5uOMsoAvUTQ7jsDE4U4Mmmn
         4kLoUADpE1XXUNQYWDeKIuCB8+Oj41A83irO5ZeWLcfrYhfv7xJwUUrdmumRxZ/sEJSH
         rtKMr7PY+OkEWquCnwuBLnmjllRK5S165imTQob6LiUgtIp6QzmoVvEOSM+Mdh0YJA5v
         LuZw==
X-Forwarded-Encrypted: i=1; AJvYcCVw5mYgLZMMxTp/X8yvEP3hZ1OJ7BJZNtZIsTdhMX9FlXnN7ikiouR2DwpygzvhhkBEs3ibX2dB5uBS3A==@vger.kernel.org, AJvYcCXuUWNNfIkdTuaCU9NQ1XJjoIieMPrLySws4JLNW/1ZkrOxo5Hnols5Sss0I3nn9s2z1xadwIPT40ejjxX3@vger.kernel.org
X-Gm-Message-State: AOJu0YxSQ7/yKx6HXusrreo6Z1klHSxeQvm2GB90AwjDp6nMcu7ZUuSN
	21Z/ivkqDtK00eBkMFsss/8oMVTz821T8d10VJJibkBbrbDya+6gIVkCnipqx25Losp7Q2bVWY5
	pqfYblOyBgfDqxN0CCkmAiWOalRc=
X-Gm-Gg: ASbGncuIaOfdvOGedfSnwdMa00PiVMFpn+/XimFhEwS54zpXH3p3eSniVZSkJ7MIOji
	34lqdUMRv99XB7XpmGwjp9VtwDwTEyQMpRqmNs2VjGv03UiGHtqvvJfCUndnsiZh69cWTDs0LQ9
	fN9A6Wo963DYc75DosU8qX3g==
X-Google-Smtp-Source: AGHT+IEQmCH6dK55zXOkds/ZHDMnczRyVqU6As+1fkm66BRqyj6QpVHUWogFcNW2HSeh3J4QkVBTphwhdwBXfd/xI2o=
X-Received: by 2002:a05:6000:1fa4:b0:391:319c:1950 with SMTP id
 ffacd0b85a97d-39132d0539dmr704892f8f.8.1741303732207; Thu, 06 Mar 2025
 15:28:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>
 <20250306074056.246582-1-s.suk@samsung.com> <Z8m-vJ6mP1Sh2pt3@infradead.org>
In-Reply-To: <Z8m-vJ6mP1Sh2pt3@infradead.org>
From: Jaewon Kim <jaewon31.kim@gmail.com>
Date: Fri, 7 Mar 2025 08:28:41 +0900
X-Gm-Features: AQ5f1JopaLOUpTwxdPg5AfqwLDYqWbHBUyR2VJnXqln5-8Dd2-m6QI-_lvHe4-8
Message-ID: <CAJrd-UuLvOPLC2Xr=yOzZYvOw9k8qwbNa0r9oNjne31x8Pmnhw@mail.gmail.com>
Subject: Re: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct IO
To: Christoph Hellwig <hch@infradead.org>
Cc: Sooyong Suk <s.suk@samsung.com>, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	spssyr@gmail.com, "axboe@kernel.dk" <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	dhavale@google.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 12:26=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, Mar 06, 2025 at 04:40:56PM +0900, Sooyong Suk wrote:
> > There are GUP references to pages that are serving as direct IO buffers=
.
> > Those pages can be allocated from CMA pageblocks despite they can be
> > pinned until the DIO is completed.
>
> direct I/O is eactly the case that is not FOLL_LONGTERM and one of
> the reasons to even have the flag.  So big fat no to this.
>

Hello, thank you for your comment.
We, Sooyong and I, wanted to get some opinions about this
FOLL_LONGTERM for direct I/O as CMA memory got pinned pages which had
been pinned from direct io.

> You also completely failed to address the relevant mailinglist and
> maintainers.

I added block maintainer Jens Axboe and the block layer maillinst
here, and added Suren and Sandeep, too.
