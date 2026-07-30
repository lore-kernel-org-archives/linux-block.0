Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443D63921E6
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785429998; cv=none; b=OxEtDokDDwgP3/PiPo7IIAx3zQVeSvkLAWvf+CE0HINzX1tmq0uDq4MH5q8w7/AHzDTLVUpWj3FKpuwV3snCo2VsLlqKqiog+ZANuUCVzvoVjdGL3SHDH1f8PIl3g6vTzvLyuKjXtk7ervRjFyRcZO9AnDukiRVzbo4eXRQ0OEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785429998; c=relaxed/simple;
	bh=ez/ftBKUFZXPMBA1j+BIjM+rYkY7cSycREcI8v/26vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBNdCcPaJZLfG5tj32tKlbdG0LnUyNdjUkkpbZx4voFJ+/zvVQaDrDuxOJkFU5lMtIbQjH0U2nYfHHZDe9uomj4ZNwDDMhRG1b8+2asJqShfw6IFMaBxEQT3mZCpk6Z9wyNdEUQ4LZWLLkMM/2nwyEPG/rCOy5Ib9/ZU9Vzt/y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PGhXI/tA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PGhXI/tA"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c1c24ec9525so402819466b.1
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1785429994; x=1786034794; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dZlOLGFSy/CTNPahqtj7kyVyKyd2w+qb5becmlDJdco=;
        b=PGhXI/tAvl4JMRlLw8i6XFvIO6ZAojxRy8W5kPXs65myiAm1pR7b+vzpAgz3nEg4JK
         /9Eq83kPX0jnms1s+ivCoGbv3knzRgqA5n2aVCQMshFpKE3NxCD0YF+l6qwW+R/4mVp6
         32g2VK+8z20ik56Ce0mUGEYwEKhEKEs80brS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785429994; x=1786034794;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dZlOLGFSy/CTNPahqtj7kyVyKyd2w+qb5becmlDJdco=;
        b=Bi9fjrRVogdOsdqziYSDvkhuMIM4S2mVgULa/ubqcPZieZidpWKiSTesiaZK6dVgcU
         w1dyRUXzQAkBf1u0LlKQw081NFGrSvBrWZP2HFQByg/O1bd2Q86w4QybcTQf4e3ttItH
         1p62nJ4AUtvTL7N2roSxYfL9xoGuN1YSLfAXeAN3QeAkHF7KVrpWO4EpHTHU90p2Q4zt
         xoeOzJcJ1TFM89e4etRLR3G4jYo2+Q5m14wRB2/TkH7xJLUxO7grSHoAIAed1TVc0WlY
         RfKR4ptD/+tsYlCC8T4XddXotGcNcIC6CqVpXLEigmipvaOGjR9hqOG2Ee8AT4g1ire6
         f5AA==
X-Forwarded-Encrypted: i=1; AHgh+RpuXyZ/cTjIAYruHQ59RqHOxoovm+cpoaC0rXW++6mqrcXO+O1Vc3DQEWvPd+oDcw0phadhHberIqiNVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0otcwRgLonBlLI/FsmZQ3crOc9OfLzpwDqHJQj/VwTNUBTww7
	J2WqrTPRvrvRHMVDXiOwUi1lnUOAs77rylgcgkTS9NgFuPlHd+bk7BHtw7k9HB3tBzItqO7uVes
	Kdpf7w9c=
X-Gm-Gg: AR+sD12i0EyzyXL1/mYl/9r2RifcD1S5hj65sphAqfPIaKjuVpniZUC5FpgGl50NSRi
	uN4X5hngZpNh+tUlN8Tl5kikfg9fIybJyC4t2kQlVt5z/qopUQXIACwSQ9fuM9xt2UkkgEY+Bch
	3uv886g91PsugU+9mAphrjjc/lzHSE7Ai1hoyE2LIX03Ml9KYLgvCETbXXOc3kLZC90yfYUd++Y
	x/C058J8QDra1lofTsFDr/RODaeb0IdZK9TlBsESuMbr7wKJGZUUgGqI9bg/NGV3w9pkG59viJH
	Fnf/ok6YIsnRNUvhVIqWUPwnVI1ZeyPVIhdL33Tt+TMWcDYUlANkJ3P2mbgc36KVJhDizPgynQt
	39fii6Ft5bd7lQpf5e5AqCH4y6fzzM4roqD1ClG8mq6ztnx26PFsMFlqNlmg6EAIEZaYfh/AmAO
	9XCM0mhMD2oBGbfZWvJ6RAewKnNUYoKb07HAcn42uS0f+D9lgUPDtwLM7VxMadxA7vXElhsmUJo
	wmlmkcc4ZOhudHjxeUnjtI64nmMvtAFiRO7fA==
X-Received: by 2002:a17:907:eccc:b0:c1c:4858:251a with SMTP id a640c23a62f3a-c1fa554e5ebmr188077066b.8.1785429994493;
        Thu, 30 Jul 2026 09:46:34 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa851b352sm90363466b.8.2026.07.30.09.46.33
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:46:33 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c1c24ec9525so402816266b.1
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 09:46:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpBPDHkEHC1eNqdtcIiNrxNS8bxic+7EbXeQPlvGyt9UPraw6v8ZaYE2osY3BtY5uf55bg56jET3t0drA==@vger.kernel.org
X-Received: by 2002:a17:907:c17:b0:c1f:1267:deb7 with SMTP id
 a640c23a62f3a-c1fa57ad4d6mr193696066b.62.1785429993415; Thu, 30 Jul 2026
 09:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720201057.1862857-1-kbusch@meta.com> <ampRQyXDbGgeg49V@kbusch-mbp>
 <fbe9e74d-c389-46f4-9874-3e9ffd9c91d3@kernel.dk> <ampce7mxSmxAwAiu@kbusch-mbp>
 <20260730112626.GA24827@lst.de> <00104e90-48b8-4419-90c4-ac0c4a2e1c44@leemhuis.info>
 <bd7249ff-d0a6-4a3b-8aec-3b5325f24b08@kernel.dk>
In-Reply-To: <bd7249ff-d0a6-4a3b-8aec-3b5325f24b08@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 Jul 2026 09:46:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDsWYL2c_vpqArX+UL9k8v3qoge7HqjtcrxbVsLAjfXw@mail.gmail.com>
X-Gm-Features: AUfX_mzqOY3ca4Dui_O7sukC5vCEWaDgT57cEJGjc9a8_XBsD7VAxqL5ujTpsZc
Message-ID: <CAHk-=wiDsWYL2c_vpqArX+UL9k8v3qoge7HqjtcrxbVsLAjfXw@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/5] block: validate direct I/O memory alignment
To: Jens Axboe <axboe@kernel.dk>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, dm-devel@lists.linux.dev, brauner@kernel.org, 
	djwong@kernel.org, viro@zeniv.linux.org.uk, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Jul 2026 at 09:23, Jens Axboe <axboe@kernel.dk> wrote:
>
> Sorry that's nonsense, because how is Linus going to make that call if
> we can't.

There's not a big enough thumbs up emoji in the whole universe for this.

          Linus
