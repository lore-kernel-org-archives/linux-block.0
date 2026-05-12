Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA76492188;
	Tue, 12 May 2026 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573585; cv=none; b=qy00gWX/M/P6/r0pfBpXMmRRDLrH6kAFMHwpXEouTz+7RG2OdDu8AsPp1R3EvVNaIRY0lO5Mux9OWA6YTwPYunK5HSP+/8psZar6OczfwJwHpDyYE57lSSn96cRxD6wAbh5utQ8YfPHyCPE/YNm456wRWF0emqqG2Ar/lJ/nNRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573585; c=relaxed/simple;
	bh=BYL3Nj8xAQDf01o29bt+3vC0EBC0fEQa91HekCGI85g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gwKjDFjuubiI6SETCNEdvK2k+yMnTjPNKJGFIEDlgNAsUkrvYZ3pyu6bS3kDWlP8i5Y4zBjlIGyQc8FXL4DlPdMjdp+lBN8EINcOPgbctk2hEkCrvezEQDEeguuRaltwKA5VLFXKQbeJQ8SCMbfpsUkX/+t2yMO1RdAXbyLuopU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=TRsvU4Mo; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="TRsvU4Mo"
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:39a:0:640:15c4:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id 478E3812EB;
	Tue, 12 May 2026 11:12:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp) with ESMTPSA id nCFf6A3RB8c0-y9E09JTj;
	Tue, 12 May 2026 11:12:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1778573570; bh=XJ+oUBWpEaY2qbP7rSYzkjlbVvJJPvJAXa5sPFYRbb8=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=TRsvU4Moi2MaABcBaJZ3fhICfiiBkukj4QR/JCg/AQreukxgDbXkU/IgvQ9m9v76y
	 y9CtJR7W7Q58cECXULCaC/kt63ZotVL1Fd4Ff+8NFTiIHQBSzQ+GUQ3v1xTTNGAcT5
	 mlnYxqIlAezPQnH8Za+1LVvNU/tg9QOo39NTaYV4=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <89db3b52508cfb345317feec8fe066849abccc14.camel@yandex.ru>
Subject: Re: [PATCH] lib: free pagelist on error in iov_iter_extract_pages()
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
  Christoph Hellwig	 <hch@lst.de>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, 	lvc-project@linuxtesting.org, Fedor
 Pchelkin <pchelkin@ispras.ru>
Date: Tue, 12 May 2026 11:12:49 +0300
In-Reply-To: <CADUfDZpC5WOBY4_xvAy6ORtgQsxwFYj3Px81RdN7NKQZBFdJSQ@mail.gmail.com>
References: <20260508111329.329943-1-dmantipov@yandex.ru>
	 <CADUfDZpC5WOBY4_xvAy6ORtgQsxwFYj3Px81RdN7NKQZBFdJSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-08 at 11:33 -0700, Caleb Sander Mateos wrote:

> Indeed, it looks like *all* callers of iov_iter_extract_pages()
> pass a non-NULL struct page **.

This is not true for 6.12.x at least (where this issue was initially discov=
ered)
where bio_map_user_iov() do the following:
...
	while (iov_iter_count(iter)) {
		struct page *stack_pages[UIO_FASTIOV];
		struct page **pages =3D stack_pages;
		ssize_t bytes;
		size_t offs;
		int npages;

		if (nr_vecs > ARRAY_SIZE(stack_pages))
                        /* Stack pages aren't enough, so set 'pages' to NUL=
L
                           and force allocation by want_pages_array(). */
			pages =3D NULL;

		bytes =3D iov_iter_extract_pages(iter, &pages, LONG_MAX,
					       nr_vecs, extraction_flags, &offs);
		if (unlikely(bytes <=3D 0)) {
                        /* If 'pages' was allocated (and so pages !=3D stac=
k_pages), memory leak here */
			ret =3D bytes ? bytes : -EFAULT;
			goto out_unmap;
		}

For 6.12.x and may be other stables, the simplest possible fix is
https://lore.kernel.org/stable/20260505094529.406783-1-dmantipov@yandex.ru/=
T/#u.

For upstream, it may be better to tweak iov_iter_extract_pages() itself, bu=
t
it may be required to adjust all of the callers.

Dmitry
