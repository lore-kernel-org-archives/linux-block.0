Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E038314AD20;
	Thu,  4 Jun 2026 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580765; cv=none; b=THWIYpl9T4YCQeTi2UKspFzrbS+NHu3aKUZptKIiaCKqQwZ8balfXo9ps+ACBTwEJfw0roIYLr0r2EQG+2hXdVHKliumngecJso1SrrgQwWc3rBb3z398ACCboV5S3VXBEXi5ZwUrKVQ5LAZRAyyUV4pSMdapVIGNBRbwreUfac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580765; c=relaxed/simple;
	bh=01X6Kqr98NOmMbP/RcRtAcmg54Lv7psOZl3zCVtkLZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/CcsafPzjNl635sUdgwYKDsQS3lnBfWegqQQ038JR4+AfdZMSwqVXYmJwWrxIg1VXznCpJpM0+UU0m+DgzjkyCoMipa+r5oOfhyRoIYg3ORlm9Gcz+29vaa39iX96LK84P8snxjF8qvUUN2T000oGSqNQ67wgdnv0GurPgg1sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=ZzBOpOK9; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="ZzBOpOK9"
Received: from localhost (unknown [95.24.32.92])
	by mail.ispras.ru (Postfix) with ESMTPSA id 3A64A413A4B6;
	Thu,  4 Jun 2026 13:46:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3A64A413A4B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1780580760;
	bh=1zhOtfKyBs8itJUULNBhvsC3TjATuVO+yO+37bdnlaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZzBOpOK9eSJ6Hj/K1Vqmg6yg9IeiZSjo6QVDolrte1hSgzwTiUkq0T3Ovv678BlX5
	 O+he0gLrftYzoL7iP2gDl+r0d8pblgIoO70OXmv/PDaSizPnf7Nc901MdsZxP+owBj
	 RPQ7i/jgPITXaUegPQJJXdXVq/VwAz+yDfsrqWx8=
Date: Thu, 4 Jun 2026 16:46:00 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Antipov <dmantipov@yandex.ru>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	lvc-project@linuxtesting.org, Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH] lib: free pagelist on error in iov_iter_extract_pages()
Message-ID: <20260604163242-e1f021c7c87c8ea7ab98b721-pchelkin@ispras>
References: <20260508111329.329943-1-dmantipov@yandex.ru>
 <20260508144823.0213964cb15e7ef8fbdcd7c5@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260508144823.0213964cb15e7ef8fbdcd7c5@linux-foundation.org>

On Fri, 08. May 14:48, Andrew Morton wrote:
> On Fri,  8 May 2026 14:13:29 +0300 Dmitry Antipov <dmantipov@yandex.ru> wrote:
> 
> > Since 'iov_iter_extract_pages()' may allocate new pagelist if the passed
> > one isn't large enough, the worst-case scenario may be:
> > 
> > ...
> > struct page *stack_pages[SMALL];
> > struct page **pages = stack_pages;
> > ...
> > if (iov_iter_extract_pages(i..., &pages, ...) <= 0) {
> >         /* Even in case of error, new pagelist may be allocated */
> >         if (pages != stack_pages)
> >                 kvfree(pages);                                  [1]
> >         /* The rest of error handling and return */
> > }
> > /* Regular flow */
> > ...
> > if (pages != stack_pages)
> >         kvfree(pages);
> > ...
> > return 0;
> > 
> > If you're unlucky so SMALL amount of pages wasn't enough and new
> > pagelist was allocated, missing [1] causes the memory leak similar
> > to one I've recently observed and fixed for 6.12 in [2]. So adjust
> > 'iov_iter_extract_pages()' to make such a cleanup itself rather than
> > rely on caller's handling on error paths, thus making [1] not needed.
> 
> AI review said things:
> 	https://sashiko.dev/#/patchset/20260508111329.329943-1-dmantipov@yandex.ru

The current v1 patch is in mm-nonmm-unstable branch of your repo [1].
Please drop it.

Apart from AI, there were comments from Caleb Sander Mateos in this
thread.  v2 then appeared [2], but it had some issues, too.  Eventually it
seems a direct patch into block subsystem [3] has found some positive
feedback.  (Though it's still not applied but that question is left for
block subsystem maintainers)

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-nonmm-unstable&id=3ba07338fe5aae5f0f6b09d9029e1ccb4434b867
[2]: https://lore.kernel.org/all/20260512170525.357573-1-dmantipov@yandex.ru/
[3]: https://lore.kernel.org/all/20260513070515.528861-1-dmantipov@yandex.ru/
