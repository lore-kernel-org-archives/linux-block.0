Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D992741AC
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764024975; cv=none; b=NY07QQNFNLDIXVZP5Bruh0fbWsDyJ9gsinCUceJXfYyAoL+ZFI8qPPrXiWm5UKFzDdq2a/hR6cLyOwuk1GZUKx2F8moaJlbqBSdKvvjF4tmrUqAbTZLqMaH29Ni9Q+qyBIOmEuIqUXPsDr4mLi70TnAFXTXvMjTW1uuEmPTwmD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764024975; c=relaxed/simple;
	bh=IUfF3YONEI5olGC76f01yrZXqBWlAnR21kE+xhP9VuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwOfLC3KBORZi8xcv49gdbJC3l/Ugxg5eN1SEKimzmjDSf50wTEBHyPEF6B0GtD/AwRX13q8Rm8AfWYyJhG9Wvx/dXo6S02bpPht3wDjbYK0nUkKp5Ahe/KBFAPh0cBYlTfmBmGlMD7vh9HAJEBJYIvnUVHv8nL4r9EAca8iI5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ji78YdxP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ji78YdxP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8177C4CEF1;
	Mon, 24 Nov 2025 22:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764024974;
	bh=IUfF3YONEI5olGC76f01yrZXqBWlAnR21kE+xhP9VuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ji78YdxPFWzXb3Jj6oQBuTYMGlQL9TxDcsi+M3iV64SohfnsOcgNokWHXg+Y51RJd
	 h/7JDODRR17+UScb9F2A6pG++75Bw8pnQonERxUW9J9+ZlWQzKy0WT6NCL0wQ3wm5J
	 vXCIsKyLwsNSrKpItN2KkyLMFqzKRGYbQM0th7pdJxfnu0BTtZAFA3hHU1mfTq6pk+
	 jWrNaEDbID0dW65OJHzBl1p3wRImIeKgN2YG7rt6gh5D9pFIFabyh9Zfr3dIebGp44
	 O8lxbLbP5qJK/CSbxFgptU1e7FuTUC5mdvP2UpScgj5O8cz+dQVdhpPAHt6x8SKEqZ
	 hXLpDFd98tmug==
Date: Mon, 24 Nov 2025 15:56:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, ebiggers@kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv6] blk-integrity: support arbitrary buffer alignment
Message-ID: <aSTii9KbN6wQCvOt@kbusch-mbp>
References: <20251124161707.3491456-1-kbusch@meta.com>
 <CADUfDZqrpJXLLU9V3eFJvRgth45-ht-yi4cSpmrBdnbfQGtWYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqrpJXLLU9V3eFJvRgth45-ht-yi4cSpmrBdnbfQGtWYw@mail.gmail.com>

On Mon, Nov 24, 2025 at 01:34:03PM -0800, Caleb Sander Mateos wrote:
> On Mon, Nov 24, 2025 at 8:18 AM Keith Busch <kbusch@meta.com> wrote:
> >
> > From: Keith Busch <kbusch@kernel.org>
> >
> > A bio segment may have partial interval block data with the rest continuing
> > into the next segments because direct-io data payloads only need to aligned in
> 
> "need to be aligned"?

In the original text, s/aligned/align
 
> > +       while (offset > 0) {
> > +               struct bio_vec pbv = mp_bvec_iter_bvec(bvec, iter->prot_iter);
> > +               unsigned int len = min(pbv.bv_len, offset);
> > +               void *prot_buf = bvec_kmap_local(&pbv);
> 
> Is it valid to use bvec_kmap_local() on a multi-page bvec? 

If it wasn't valid, there'd be a major problem with large folios.

> It calls
> kmap_local_page() internally, which will only map the first page,
> right?

Compare kmap_local_page() with kmap_local_folio(). They both resolve to
the same lower level mapping function, and folios have no problem
spanning pages.
 
> > @@ -1874,6 +1874,7 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
> >                 break;
> >         }
> >
> > +       bi->flags |= BLK_SPLIT_INTERVAL_CAPABLE;
> 
> Can just be = instead of |= since bi is zeroed above.

It can, but these kinds of syntax are a courtesty to future changes so
that you don't need to change this line later. You can also end a struct
initialization without a trailing "," too, but that's just mean.
