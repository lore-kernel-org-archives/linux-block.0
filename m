Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48633313E1D;
	Fri,  8 May 2026 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778276904; cv=none; b=Lh4CtUi/XbW/1BRb15YwpoDXZzxjJwv4l5nct3GrDQt5RMxJBgRL8dHuuw5zhdU0o10LLMK/vKpGwxQMsRxpROcxE2Qfi2OA5TlBQ8cQJgY6ejqG34srtnno1Ly97obJzHxk9wfHNt3qv5Wghs1NvHoNm630zw2j7/fhaLGjNMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778276904; c=relaxed/simple;
	bh=sDrByXkNM/hfNAgnMiBhFUzfsx2eIayFCqoEwBNZBUg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=S4ecUl5PpN/6zAaDh2Oqb//IGtg5atHtJK7vlPqObKnJ0lx1Jp/U4z5DR8wUeyp8m9jpazIAIglATxYQhFia4CtvTOFz7sBQCuv+HMs/xmFrH34OMOvKierk+GdtF9imsoYGpGUnD2NjRog1SOlsLdytBo4kdumKLxKfIP/D/Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b2hsc13r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b2hsc13r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E0EC2BCB0;
	Fri,  8 May 2026 21:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1778276904;
	bh=sDrByXkNM/hfNAgnMiBhFUzfsx2eIayFCqoEwBNZBUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b2hsc13r3jGPAriQu8pal0P53uwSmh90Ma0aR4PVQivKbZczxKXBv17HVJglTVF4l
	 E9AR2YRmhwKOB9F4hLq8Zh8Xn3uzwcuTKhG0RL8r2f8M2fSgtMsQ26pIoEFk7AAass
	 ov7Vnh4t499uT2SUPODznNucbivx5JrHMQuozOrE=
Date: Fri, 8 May 2026 14:48:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 lvc-project@linuxtesting.org, Fedor Pchelkin <pchelkin@ispras.ru>
Subject: Re: [PATCH] lib: free pagelist on error in iov_iter_extract_pages()
Message-Id: <20260508144823.0213964cb15e7ef8fbdcd7c5@linux-foundation.org>
In-Reply-To: <20260508111329.329943-1-dmantipov@yandex.ru>
References: <20260508111329.329943-1-dmantipov@yandex.ru>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 May 2026 14:13:29 +0300 Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Since 'iov_iter_extract_pages()' may allocate new pagelist if the passed
> one isn't large enough, the worst-case scenario may be:
> 
> ...
> struct page *stack_pages[SMALL];
> struct page **pages = stack_pages;
> ...
> if (iov_iter_extract_pages(i..., &pages, ...) <= 0) {
>         /* Even in case of error, new pagelist may be allocated */
>         if (pages != stack_pages)
>                 kvfree(pages);                                  [1]
>         /* The rest of error handling and return */
> }
> /* Regular flow */
> ...
> if (pages != stack_pages)
>         kvfree(pages);
> ...
> return 0;
> 
> If you're unlucky so SMALL amount of pages wasn't enough and new
> pagelist was allocated, missing [1] causes the memory leak similar
> to one I've recently observed and fixed for 6.12 in [2]. So adjust
> 'iov_iter_extract_pages()' to make such a cleanup itself rather than
> rely on caller's handling on error paths, thus making [1] not needed.

AI review said things:
	https://sashiko.dev/#/patchset/20260508111329.329943-1-dmantipov@yandex.ru

