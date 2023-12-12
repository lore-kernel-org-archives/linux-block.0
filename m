Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AFBDB
	for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 10:26:16 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id C107468AFE; Tue, 12 Dec 2023 19:26:13 +0100 (CET)
Date: Tue, 12 Dec 2023 19:26:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Message-ID: <20231212182613.GA1216@lst.de>
References: <20231211165720.GC26039@lst.de> <177773fd-c8ed-4822-9344-3058e820ddf0@kernel.org> <20231212154140.GB20933@lst.de> <42054848-2e8d-4856-b404-c042a4365097@acm.org> <20231212171846.GA28682@lst.de> <686cc853-96e2-4aa4-8f68-fdcc5cdabbba@acm.org> <20231212174802.GA30659@lst.de> <5b7be2e9-3691-409d-abff-f1fbf04cef7d@acm.org> <20231212181304.GA32666@lst.de> <19cd459e-d79e-4ecd-8ec8-778be0066e84@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19cd459e-d79e-4ecd-8ec8-778be0066e84@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 12, 2023 at 10:19:31AM -0800, Bart Van Assche wrote:
> "Fundamentally broken model" is your personal opinion. I don't know anyone
> else than you who considers zoned writes as a broken model.

No Bart, it is not.  Talk to Damien, talk to Martin, to Jens.  Or just
look at all the patches you're sending to the list that play a never
ending hac-a-mole trying to bandaid over reordering that should be
perfectly fine.  You're playing a long term losing game by trying to
prevent reordering that you can't win.
