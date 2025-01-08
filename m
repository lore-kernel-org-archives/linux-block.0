Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAB4537E9
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736345417; cv=none; b=aif0DGk1pMbOsDwzSWXLzOZ2PR9+MW8lhiOY+UVEe1KYTYASZ15doFRVSJ1klKInjOHBcXgfO7E8+kBYUnmgdrQwaRBFEBqr/xrxQ7A7boytNqLMHdXQD/eaFIcqsRfuTvg4NjB8Ab6Q7MwMRx9lOpyZFZRDML4L95AzaZOtFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736345417; c=relaxed/simple;
	bh=mNqopxgUX41bNAXMYMWhkdb7vw3oqNxlRy2DTBX7jNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQQzMTLL/BddZYkWZ98KqHB+8Th9xKcjB9POxt1rUGgi4OSvx9tYBiQxA3TfH8w90Lh2YBf2sQs7Fti+nFEEUgZVkOzAEqy5QFFPpf4rpTJdEW/1Pqe7k9p6ZUf+XAaOWli16VrIqmN9zo+RmaiUfyG6CsuqX78BWKrhJAHP9MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ZZFlpxLT; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ZZFlpxLT"
Received: from cwcc.thunk.org (pool-173-48-116-211.bstnma.fios.verizon.net [173.48.116.211])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 508EA1ki001236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Jan 2025 09:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1736345404; bh=o5WddbL0WudF0Rt4AmlCKx0xRns3r0O/OCa4PNY/Rtg=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ZZFlpxLTDq4v3mPD4WcbHHVm3EXPUr1/5xpoZeryHZL5yMzBROdB9bcFk+UItezAv
	 okp6YkUgZGkGhPvtyv6vecT3FuVvlNOqsFYOO4Wt2s1gN2f7t4B4dNFxClUfDBcx7+
	 tsgVjIfFp2gYODfoeTyLYeRccuwsHO995VMPXZ6+KnKaRnW4DBPGdz1XquAk4eX+sA
	 6vhVaqliVa6ctQRBBBuvw9sDxvvhXtH0nw0ZODV+NHTy+OrfHx+OzmfxPH7zmQ3/UO
	 mk8V1OGV497+2QudfpjeQO9jG5TV9fHORs121Auycv7V9zd7PIGQCqrrqmXzTL80FM
	 3oICtHTtPvBzw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 7163415C0108; Wed, 08 Jan 2025 09:10:01 -0500 (EST)
Date: Wed, 8 Jan 2025 09:10:01 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] New zoned loop block device driver
Message-ID: <20250108141001.GN1284777@mit.edu>
References: <20250106142439.216598-1-dlemoal@kernel.org>
 <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk>
 <20250106152118.GB27324@lst.de>
 <98be988f-5f6a-489d-b0e1-2f783c5b8a32@kernel.dk>
 <20250106153252.GA27739@lst.de>
 <0f2eea00-e5e9-4cd1-8fe6-89ed0c2b262b@kernel.dk>
 <20250106154433.GA28074@lst.de>
 <Z33nXTkBueJ4uju7@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z33nXTkBueJ4uju7@fedora>

On Wed, Jan 08, 2025 at 10:47:57AM +0800, Ming Lei wrote:
> > > Why would they have to fork it? Just put it in xfstests itself. These
> > > are very weak reasons, imho.
> > 
> > Because that way other users can't use it.  Damien has already mentioned
> > some.
> 
> - cargo install rublk
> - rublk add zoned
> 
> Then you can setup xfstests over the ublk/zoned disk, also Fedora 42
> starts to ship rublk.

Um, I build xfstests on Debian Stable; other people build xfstests on
enterprise Linux distributions (e.g., RHEL).

I'd be really nice if we don't add a rust dependency on xfstests
anytime soon.  Or at least, have a way of skipping tests that have a
rust dependency if xfstesets is built on a system that doesn't have
Rust, and to not add Rust dependency on existing tests, so that we
don't suddenly lose a lot of test coverage all in the name of adding
Rust....

						- Ted
