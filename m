Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0511D95
	for <linux-block@vger.kernel.org>; Thu, 14 Dec 2023 00:52:02 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id B766768B05; Thu, 14 Dec 2023 09:51:59 +0100 (CET)
Date: Thu, 14 Dec 2023 09:51:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Message-ID: <20231214085159.GA9006@lst.de>
References: <177773fd-c8ed-4822-9344-3058e820ddf0@kernel.org> <20231212154140.GB20933@lst.de> <42054848-2e8d-4856-b404-c042a4365097@acm.org> <20231212171846.GA28682@lst.de> <686cc853-96e2-4aa4-8f68-fdcc5cdabbba@acm.org> <20231212174802.GA30659@lst.de> <5b7be2e9-3691-409d-abff-f1fbf04cef7d@acm.org> <20231212181304.GA32666@lst.de> <697f5bc2-88ea-42f8-9175-fbc414271ea3@acm.org> <abc13a22-74b4-4f72-b592-09781d0cfdd2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abc13a22-74b4-4f72-b592-09781d0cfdd2@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 14, 2023 at 09:37:21AM +0900, Damien Le Moal wrote:
> Yes, that can be trivially done with the sd_zbc.c zone append emulation. If you
> check the code, you'll see that sd_zbc_prepare_zone_append() returns
> BLK_STS_ZONE_RESOURCE if the target zone is already locked. That causes a
> requeue and the zone append to be resubmitted later. All you need to do for UFS
> devices is tweak that to not requeue the zone append if the write command used
> to emulate it can be issued. The completion path will also, of course, need some
> tweaks to not attempt to unlock the target zone if it was not locked.

On the Linux side yes.  I still don't see how the hardware can actually
make this scheme work withou the potential of deadlocks.  But compared
to the problems with having a completely in-order I/O stacks that's
peanuts as they say in Germany.
