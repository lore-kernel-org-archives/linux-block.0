Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4927E6
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 01:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710205769; cv=none; b=pDxQ0Ebmx6BCBs9Q5KUxjX0STYCSikGKK1WYdUpGXo/aEv/Po6k3zFXZ3EHFyRKObiNVfQWXn6AdQcZhZjLhVaeR5D3GwlKhe+KZrSlZ92PjZNwLkqVMZtWeOY65XScwGflIFVHLJZUvsTYmZqX4Q4NL2DlW0dPVXNw6Reqz6Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710205769; c=relaxed/simple;
	bh=ruNzu+Roo/Lcn2kgjHZzjsK4d8iCH+7Beqeh4/p+52c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCSH0fDjX8nfrvNRDbWm9WtVV4cJCzp3yxOxMzOxRYtayRc47eC+euGOXorUskbg/N0qQEWzmAD9n63KV1M6rNzRhHFUybrhsZ8XIztWa4DBiG0Trg/HfufTxb2UB4ytYsQOo9tOyrLcdMbwzfWC8kW6HXgKJ67z/2bNLJvo3Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Os4GGfqD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Os4GGfqD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IN6rew5u0yVw22V6locOdDT9Rl2ynrJCjrD9jHQa28Y=; b=Os4GGfqDRwzBrKXu5J4XfJspim
	guXz+wE/SqHz7pnTrbu9bhCg+v3YPXuGCJgQs2AOdPXN3IHDgfSVSFzqyhBhpfkGVva/Ln9RgRpLe
	Kh7fZeUCSXuxoLWNXed8NZ/FyjETvQZY00IxyNT8R4qm+BIYI6tRePYNJRKBb1FaIXzi3deo3nXfs
	3TIJ+9h/xX4g1D1YmTu6LDbpiit8qPKtHHlTYHu/j+y9R1nRaMgXxkW+kI9Vygsvodc+WZ1mJQTB5
	7LPRauut4eBTeVSAlJ44lWXhkdwEv8zAYiSCj4v8Cgkk2qYwmrQt0nhKz56fyDIF7WX3eIcva9+5P
	ANmjiqlw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjqdy-00000003lLI-08is;
	Tue, 12 Mar 2024 01:09:26 +0000
Date: Mon, 11 Mar 2024 18:09:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [GIT PULL] Block updates for 6.9-rc1
Message-ID: <Ze-rRvKpux44ueao@infradead.org>
References: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>
 <20240311235023.GA1205@cmpxchg.org>
 <CAHk-=wgOfw8NBQ2Qyh8QUjhp5z4v--PuciLE7drn5LJkTtgPVw@mail.gmail.com>
 <e3fea6c3-7704-46cd-b078-0c6e8d966474@kernel.dk>
 <CAHk-=wgXZ6dE1yHK_jQmnSjbEbndyzZHC5dJNsmQYTD2K-m61w@mail.gmail.com>
 <Ze-hwnd3ocfJc9xU@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze-hwnd3ocfJc9xU@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 11, 2024 at 08:28:50PM -0400, Mike Snitzer wrote:
> All for Jens being made to suffer with dm-crypt but I think we need a
> proper root cause of what is happening for you and Johannes ;)

I'm going to try to stay out of the cranking, but I think the reason is
that the limits stacking inherits the max_segment_size, nvme has weird
rules for them due their odd PRPs, and dm-crypt set it's own
max_segment_size to split out each page.  The regression here is
that we now actually verify that conflict.

So this happens only for dm-crypt on nvme.  The fix is probably
to not inherit low-level limits like max_segment_size, but I need
to think about it a bit more and come up with an automated test case
using say nvme-loop.

So for now the revert is the right thing.
