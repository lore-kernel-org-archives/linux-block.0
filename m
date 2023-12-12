Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ABF9F
	for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 07:41:43 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 289D668BFE; Tue, 12 Dec 2023 16:41:41 +0100 (CET)
Date: Tue, 12 Dec 2023 16:41:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Message-ID: <20231212154140.GB20933@lst.de>
References: <20231205053213.522772-1-bvanassche@acm.org> <20231205053213.522772-4-bvanassche@acm.org> <20231211165720.GC26039@lst.de> <177773fd-c8ed-4822-9344-3058e820ddf0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177773fd-c8ed-4822-9344-3058e820ddf0@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 12, 2023 at 07:40:02AM +0900, Damien Le Moal wrote:
> The latter is I think better than the former as CGs can change without the FS
> being aware (as far as I know), and such support would need to be implemented
> for all FSes that support zone writing using regular writes (f2fs and zonefs).

How is cse 2 any kind of problem when using the proper append model?
Except when blk-zoned delays it so much that we really need to close
the zone becaue it's timing out, but that would really be configuration
issue.
