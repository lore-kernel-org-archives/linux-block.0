Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8931AC
	for <linux-block@vger.kernel.org>; Wed, 13 Dec 2023 07:56:09 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 341B268B05; Wed, 13 Dec 2023 16:56:06 +0100 (CET)
Date: Wed, 13 Dec 2023 16:56:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Message-ID: <20231213155606.GA8748@lst.de>
References: <20231212154140.GB20933@lst.de> <42054848-2e8d-4856-b404-c042a4365097@acm.org> <20231212171846.GA28682@lst.de> <686cc853-96e2-4aa4-8f68-fdcc5cdabbba@acm.org> <20231212174802.GA30659@lst.de> <5b7be2e9-3691-409d-abff-f1fbf04cef7d@acm.org> <20231212181304.GA32666@lst.de> <19cd459e-d79e-4ecd-8ec8-778be0066e84@acm.org> <20231212182613.GA1216@lst.de> <ZXiual-UkUY4OWY2@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXiual-UkUY4OWY2@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 12, 2023 at 11:03:06AM -0800, Jaegeuk Kim wrote:
> As one of users of zoned devices, I disagree this is a broken model,

So you think that chasing potential for reordering all over the I/O
stack in perpetualality, including obscure error handling paths and
disabling features intentended to throttle and delay I/O (like
ioprio and cgroups) is not a broken model?

> it is essential to place the data per file to get better bandwidth. And for
> NAND-based storage, filesystem is the right place to deal with the more efficient
> garbage collecion based on the known data locations.

And that works perfectly fine match for zone append.

> That's why all the flash
> storage vendors adopted it in the JEDEC.

Everyone sucking up to Google to place their product in Android, yes..


> Agreed that zone append is nice, but
> IMO, it's not practical for production.

You've delivered exactly zero arguments for that.
