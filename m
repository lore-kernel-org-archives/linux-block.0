Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E47A15D1
	for <linux-block@vger.kernel.org>; Tue, 17 Jun 2025 04:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750135201; cv=none; b=AS2+Wok+Qjcow9hTbIr4E3KkcDCgN9YtzLUCh0uWlUSseAFONP9rDOVWlFoceY+6A8k8cFagXSbkmErgAXXCYVJyYEkLTuO5+j/hUZ2GYdtnDmtX2igiaARVPnk9tKuP1rccUCkDt07bLZI1V3kWJ3QHuQ6WRrUiAf3bLTRIzEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750135201; c=relaxed/simple;
	bh=3nh5L7iPIsUx0zUfs98qLa0UUoHYjC5rXzn2MViv8L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a96P46oyyNfgkenlTHUqwzQ6sTDH/SJ5P/U4y+sh0ilpDKyB/uULopK8vzK+Kbgj/WYnCxuE6Fwg5iBgiuvE+eFAwG/dsm2nybA8Y+djJUWFe1RWXPTuPy9a12U1EooTENND8vJEdxL2vVgUwnlpKjb78U19TuUS4Ipmyy+iDWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nxwFOw+i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nxwFOw+i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MNM4kV+A6F/UHTs5MZt4D4Jc7133C1H/8+7BqWG7YPM=; b=nxwFOw+iMuTbJj9X7olnrnS+p2
	ECZLs4q5NXQvjDke5LwaCnmfHotWj6J1FfJ25rnLbkrSAzEszdMTxzrY582XsW2NrOgNkexlxSCTA
	l7VUHgeIRDO/Ea+08Dkx79i9tcbX96zrWvzQaWfhA/oXlr7/HWD1XqsVvQvIOM6PyLO7V2hXfqWzM
	7zPLqounNhOM21tkycry0JKo7MsjVPGztcJsyoL+oDwcxvFjfuRV10/Rfxhovr+AMINTn6QtRtTrC
	+IhDDZJ8gyCGNQyirOqRf8Oy0ykUE7iwyAkE2aMvfxJYBl6C+0CWRqMFpL1Pc6LDUVJDQC2tTfiQH
	6+P0UG+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRO75-00000006BV4-2Rhz;
	Tue, 17 Jun 2025 04:39:59 +0000
Date: Mon, 16 Jun 2025 21:39:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: use plug request list tail for one-shot backmerge
 attempt
Message-ID: <aFDxnwsLz8Mri3xr@infradead.org>
References: <f4ed489d-af31-4ca0-bfc1-a340034c61f5@kernel.dk>
 <aEpkIxvuTWgY5BnO@infradead.org>
 <045d300e-9b52-4ead-8664-2cea6354f5bf@kernel.dk>
 <aErAYSg6f10p_WJK@infradead.org>
 <505e4900-b814-47cd-9572-c0172fa0d01e@kernel.dk>
 <aErGpBWAMPyT2un9@infradead.org>
 <2de604b5-0f57-4f41-84a1-aa6f3130d7c8@kernel.dk>
 <aFAYDPrW4THB0ga7@infradead.org>
 <CADUfDZqie84nJeBVJn94UvYqNhY73n41L+tbXOnXdMBqesLDWA@mail.gmail.com>
 <aFDUlnKVHLJC6VuE@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFDUlnKVHLJC6VuE@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 17, 2025 at 10:36:06AM +0800, Ming Lei wrote:

[full quote deleted, please fix your mailer]

> > ublk_cmd_list_tw_cb() doesn't need a doubly-linked list. It should be
> > fine to continue storing just the first struct request * of the list
> > in struct ublk_uring_cmd_pdu. That would avoid growing
> > ublk_uring_cmd_pdu past the 32-byte limit.
> 
> Agree.
> 
> ublk needn't re-order, and doubly-linked list is useless here.

No driver needs to reorder, it just needs to consume the list passed to
it, for which using list_cut_before is really useful.  Just passing it
on would be optimal, but if that can't work the frankenlist proposed by
Caleb might work.

