Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6F325CC74;
	Wed,  6 Aug 2025 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754522432; cv=none; b=YDBhQLc5A2//gGsqGSkkhWI61AiONGNyv6FseatT6HpHRnD9z8rTJf8kFYOLhsEdDTdUdpCc16bdslKvBGVwYlMio9TJoqplvfaBBHHvxhwEm/1owff0rnjaIHyPhFSAcH0c0cp2th19WveXfAkAgIDIqwStQMYW/9up0aHzOQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754522432; c=relaxed/simple;
	bh=gquwR7ixwIVTOYhHe+6cO7dBDOrfjKTNuescVYL64bg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oBePbGAQxoRq8v2oq8wh0ovJbglWu/LYWotCK0woWUL/oxS0ZyhXar5kRLVKu1m4+zvyKTWnEXaiGTXxPhY0skBO8w0U+u4Y2wZevCuowu1XXhVoaHs0No32BP1+SJCIwiNb9p/XkSLjoxvSxISOg6xKtKZEQhRghBd2gsQVeHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PtTdtUNK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PtTdtUNK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C47C4CEE7;
	Wed,  6 Aug 2025 23:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1754522431;
	bh=gquwR7ixwIVTOYhHe+6cO7dBDOrfjKTNuescVYL64bg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PtTdtUNK4PbQtdp53cPWnvvUqt91eQXxOqqkBnOvB0N/UtExF39wGLSkk85//q2YD
	 H9jF8Spci0tJuDWLK7w5owGV7vONkDkAX+1kG3fUC5tXTvATcrfqz+JunxdUskedlb
	 qfez1fRihbwr7mPsL2oc+2kdyzslajuo8IjA07dA=
Date: Wed, 6 Aug 2025 16:20:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Seyediman
 Seyedarab <imandevel@gmail.com>
Subject: Re: [PATCH] zram: protect recomp_algorithm_show() with ->init_lock
Message-Id: <20250806162030.2deaa905530e182bbf939910@linux-foundation.org>
In-Reply-To: <fm5et2vgfl5npfmivdpwj7lb5ztrgmvst4kbvxccisdnudyhhx@5szzuwprhmgw>
References: <20250805101946.1774112-1-senozhatsky@chromium.org>
	<20250805150323.0f5615ec97de2cc5d50b0b6f@linux-foundation.org>
	<fm5et2vgfl5npfmivdpwj7lb5ztrgmvst4kbvxccisdnudyhhx@5szzuwprhmgw>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Aug 2025 11:58:49 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> > > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > Reported-by: Seyediman Seyedarab <imandevel@gmail.com>
> > 
> > And including a Closes: for Seyediman's report (if it's publicly
> > linkable) would be great too, thanks.
> > 
> > I'm guessing that a Fixes: isn't appropriate here because the
> > bug has been there since day 1.
> 
> Yes, also there isn't really a public bug report there, I just noticed
> that while looking at some things that Seyediman was looking at.  So I
> wanted to give Seyediman some credit.  I suppose I probably should have
> added
> 	Suggested-by: Seyediman Seyedarab <imandevel@gmail.com>
> 
> instead.

Great, thanks.

> Should I send a v2?

Nope, I updated the changelog locally.
