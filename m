Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028898F42
	for <linux-block@vger.kernel.org>; Wed, 20 Dec 2023 03:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A450468BFE; Wed, 20 Dec 2023 04:53:47 +0100 (CET)
Date: Wed, 20 Dec 2023 04:53:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 4/4] block/mq-deadline: Prevent zoned write
 reordering due to I/O prioritization
Message-ID: <20231220035347.GA30894@lst.de>
References: <20231218211342.2179689-1-bvanassche@acm.org> <20231218211342.2179689-5-bvanassche@acm.org> <20231219121010.GA21240@lst.de> <54a920d3-08e3-4810-806d-2961110d876d@acm.org> <6d2e8aaa-3e0e-4f8e-8295-0f74b65f23ae@kernel.org> <2e475db5-fd09-483c-9c34-d9bf9e64d273@acm.org> <995e1ae3-5d03-453a-8a97-a435bfa3e2c4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <995e1ae3-5d03-453a-8a97-a435bfa3e2c4@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Dec 20, 2023 at 10:28:37AM +0900, Damien Le Moal wrote:
> zone, and as I said before, since doing that is nonsensical, getting the IOs to
> fail is fine by me. The user will then be aware that this should not be done.
> 
> f2fs has a problem with that though as that leads to write errors and FS going
> read-only (I guess). btrfs will not have this issue because it uses zone append.
> Need to check dm-zoned as their may be an issue there.
> 
> So what about what I proposed in an earlier email: introduce a bio flag "ignore
> ioprio" that causes bio_set_ioprio() to not set any IO priority and have f2fs
> set that flag for any zone write BIO it issues ? That will solve your f2fs issue
> without messing up good use cases.

How can this even be a problem for f2f2 upsteam where f2fs must only
have a single write per zone outstanding?  I really don't want crap
in the block layer to work around a known broken model (multiple
outstanding WRITE commands per zone) that because it's so known broken
isn't even merged upstream.


