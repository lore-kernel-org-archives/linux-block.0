Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D089D83
	for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 09:48:06 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id D38F868AFE; Tue, 12 Dec 2023 18:48:02 +0100 (CET)
Date: Tue, 12 Dec 2023 18:48:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Message-ID: <20231212174802.GA30659@lst.de>
References: <20231205053213.522772-1-bvanassche@acm.org> <20231205053213.522772-4-bvanassche@acm.org> <20231211165720.GC26039@lst.de> <177773fd-c8ed-4822-9344-3058e820ddf0@kernel.org> <20231212154140.GB20933@lst.de> <42054848-2e8d-4856-b404-c042a4365097@acm.org> <20231212171846.GA28682@lst.de> <686cc853-96e2-4aa4-8f68-fdcc5cdabbba@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686cc853-96e2-4aa4-8f68-fdcc5cdabbba@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 12, 2023 at 09:42:24AM -0800, Bart Van Assche wrote:
> drivers/scsi/sd_zbc.c (or any other zone append emulation) is not an option for
> high performance devices. This is because emulating zone append can only be done
> by serializing write operations. Any such serialization negatively affects
> performance.

Seriously Bart, we've been through this a few times.  You keep insisting
on using a broken model despite having a major influence on the standards.
Go and fix them, and I bet you'll actually have plenty of support.  And
stop pushing hacks into the block layer and SCSI code to work around your
broken file system code and lack of interest in actually making the
hardware interface sane.

This isn't going to get you anywhere, while you're wasting a lot of
peoples time.
