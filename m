Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792922758;
	b=I/OV/Q0gjUTHlRxtKAkbHqYjpnh8qKZwUxR8Wn0kgJAFM0ntCsaQxjg+3gAcPw1UzrzV
	 nfmPyiIarswKjqlx5L2zAm/7dMfg/TAQYWVZkbbjdzIjdCb04cnYvwgMZ3v11KHaLJzYD
	 1sZnkWg2PbDC23z9Ae6EMFe0su40RrqktomkPlAjTJ+GlVIxQzJ1uWDI+uXST+H9bPjRw
	 8a0iE9LaGVSvON7zom9/k69DsBe/zMbSXnU9yLxbiu3BOzI7D9TnPTSIJXD/7pnlDyoWv
	 IydASbz3jejpZM+ZGJekW52DO1v9sL3xQoku9ADZGOew/WAoJwJrpJyZimlZNUDNgyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792922758;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=W7gJTuVi9tDXgHlyaf5e6Te/gAcfSr0TPEgIwLiJCcU=;
	b=5Z4oZFnxEANVPTIiWLCHOof55bnsCwKPhS4FfvAD+2/u8Gt5mam/eu+Sl9XgC0URPqnG
	 Upc7bsW2g+nJlyd6AhAe/F/0ksSZveO+hEmyoUdgV+rR7CK9hDyRrEnHxaav2uPf0JPXV
	 H07nqxHbiHrNbOSZGMhfBNCkSafnWwq82N2qdt+1iFjJ/HD6W5rzLErNj6LelSZbLhEIE
	 p7ZK1QREv5POY5TSDj7FscNvmQWoYOXoRfa2kbJQPn5S7A+xXHvSkZcrB7QT6FgYl0JZc
	 zC1apGDLEz9sMUG2xu7/V2X9kpDuXUm9rpC8/808Vz/zdc0frZ2xObUNmWL4g57bdZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9JNF4nw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E75606A31D
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9JNF4nw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A598D1F031E3
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 10:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792922757;
	bh=W7gJTuVi9tDXgHlyaf5e6Te/gAcfSr0TPEgIwLiJCcU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=g9JNF4nwhyjZEs/ZmRDaoMhjB0L73RSQupVBm5JRTYeoBrJv0gN7l+AJKK5JzrreO
	 DFWfEJdJP3h2ysBnfN9qCKn37wITJF0Dt92aWPzo/uug3aUd/nX+jKQ3rVOsmEj1zE
	 KI6GS3VtLtlnLUkmoNrs22U0WLxUR7YvWdPj6pJdEqsWTHIiE1Rr4Z7BfFaKpCoYoa
	 UKkqCjf35AUpWlkaseQGXSrENUrbXG+Thu2FLQPVKSKya4Q4UnWP48NWfIElqMOq4e
	 G1qu0s+OaWBK274L/Ehzd/nwg/WWf36lzoOd5siZVSCEkW1ge6jFYiWZ3X7gmo96iq
	 3CJdBb3LHHp7Q==
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f1ca4132bso185034685a.0
        for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 03:05:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzS3iBwXHFVwWWfuUXFJiylXgw82avVgaHDvWQTeWwyLVho8gqNheJb8z3XYuM1D64n0WvZs6qGincClw==@vger.kernel.org
X-Gm-Message-State: AFq9FYK46xMoAR6pmScHLDGmYHMt4Z+tPljxP1wVwRqwHFuvzsPW8QSn
	XbzUOFHFttEq4L5ZH56jiIU0GA7BtPTVqpH4mgEg9nlMZNNVbInm7ENiaTO0dixk+RjXGI1wkRp
	67ZWOd8wD84DjDIcp3wgmt51f7CT76mg=
X-Received: by 2002:a05:620a:261e:b0:93f:24e6:403e with SMTP id
 af79cd13be357-940ef98287dmr493200085a.54.1792922756979; Sun, 25 Oct 2026
 03:05:56 -0700 (PDT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025021839.1542805-1-senozhatsky@chromium.org> <20261025021839.1542805-2-senozhatsky@chromium.org>
In-Reply-To: <20261025021839.1542805-2-senozhatsky@chromium.org>
From: Barry Song <baohua@kernel.org>
Date: Sun, 25 Oct 2026 18:05:46 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wBz8SHAy_nmv8w1UX7yX_yqhp_ShnNNJ+Ek82S3ZvYzw@mail.gmail.com>
X-Gm-Features: AclHuK9dW6R5A382Z6S5kYHE3k5MMyEbL-uFyfOty30ebho3VuUUWRklFvN0H7Y
Message-ID: <CAGsJ_4wBz8SHAy_nmv8w1UX7yX_yqhp_ShnNNJ+Ek82S3ZvYzw@mail.gmail.com>
Subject: Re: [PATCH v7 01/15] zram: prefix backends printk-s
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Brian Geffon <bgeffon@google.com>, 
	Bo Zhang <zhangbo0325@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 10:18=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Currently, zram backends prefix printk-s with their names, which may
> look a little confusing, e.g. "zstd: alloc size 408128".  Prefix
> backend names with "zram:" so it's clear that the message is coming
> from a zram backend.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>
