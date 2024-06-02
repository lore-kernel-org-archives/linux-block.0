Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE28333FE;
	Sun,  2 Jun 2024 03:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717300177; cv=none; b=jePFDSloUdBfj/S48GNJ7hIiAV2JnAtiTAlzy3vVEzbY+mOtoH7spkJD6O/Xm7Q2PUN3KlDoEtDsYqW/DrmbxaXG3BoEE9cIB3tA2VEZI9khaThNy9qSqIXmSG9AJTCvKg7iWWlmiSu1OB4+TQbdYGVlVtzSQu40ybox2F0Ouog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717300177; c=relaxed/simple;
	bh=nI+JdCdtSJsrLAJ8ilaI4AYR3YEqWcnZFiRDQVHYHO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChoxLPI/jGzmrT3pI1ZuLqiQWeupN6UtrJQtViWtt0FLLGrYhy+PSMlTpj4RmCHt04DradaoPJM8k8nBR+rz7qvf/RVxJNgW9EM+GcRSoz4oGibioVU/v6xTqH7qJpZ3hj0TyY06O25Vqf+UpvzjvzMCk5urhvyMf1UvhbsP9WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KbMIzHs5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KbMIzHs5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o7NoMXzPthc9zQlJ66cfUGuyRStXBoiGWt66Jwklgk8=; b=KbMIzHs5gt1BcRON61TXatunNp
	q3vENuIK+gxN6Givz28UrOa3Uc8zlgPpsxgsGti80Yxy7URNy2r5h2EWzydq0h1qljXa/4f12VrQg
	ZbId0F5kiYsw/TJxH9jXcTjD6cPiXrVR1uJ+zy1Y9CX8/DG9uYpz6Q7cIezrHEx1+S9vHlqeIaLBX
	YnTOEv4PPHUFeMm2kqbzdqP0unuraFAlyI4W8aCeI1HYe//ziQqUpuRPYnSb0pak9t5NNgMJI4ocI
	zJzfF+gMyiUKkXPxzpOKUmq6YQ8G/LjvX2iKHO/eNK+9QABDKwE4OjkLk2ZuOPdCnkoFBEVihi5zw
	JfIiXu8g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDcDh-0000000D1A1-0j0Z;
	Sun, 02 Jun 2024 03:49:21 +0000
Date: Sun, 2 Jun 2024 04:49:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yexuan Yang <1182282462@bupt.edu.cn>,
	Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>,
	Joel Granados <j.granados@samsung.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Conor Dooley <conor@kernel.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>,
	open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH v4 2/3] rust: block: add rnull, Rust null_blk
 implementation
Message-ID: <ZlvrwbQ1WJZQ6_KR@casper.infradead.org>
References: <20240601134005.621714-1-nmi@metaspace.dk>
 <20240601134005.621714-3-nmi@metaspace.dk>
 <ZlsvHV6y4DEdC8ja@kbusch-mbp.dhcp.thefacebook.com>
 <875xusoetn.fsf@metaspace.dk>
 <ZltF5NvDnKFphcOo@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZltF5NvDnKFphcOo@kbusch-mbp.dhcp.thefacebook.com>

On Sat, Jun 01, 2024 at 10:01:40AM -0600, Keith Busch wrote:
> It's fine, just wondering why it's there. But it also allows values like
> 1536 and 3584, which are not valid block sizes, so I think you want the
> check to be:
> 
> 	if !(512..=4096).contains(&block_size) || ((block_size & (block_size - 1)) != 0)

I'd drop the range check.  We're pretty close to landing the bs>PS
patches, so just

	if block_size & block_size - 1 != 0

should be enough of a validation.  Is it considered "good style" in
Rust to omit the brackets here?
