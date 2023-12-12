Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3504E9B
	for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 10:13:08 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id F112E68AFE; Tue, 12 Dec 2023 19:13:04 +0100 (CET)
Date: Tue, 12 Dec 2023 19:13:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Message-ID: <20231212181304.GA32666@lst.de>
References: <20231205053213.522772-1-bvanassche@acm.org> <20231205053213.522772-4-bvanassche@acm.org> <20231211165720.GC26039@lst.de> <177773fd-c8ed-4822-9344-3058e820ddf0@kernel.org> <20231212154140.GB20933@lst.de> <42054848-2e8d-4856-b404-c042a4365097@acm.org> <20231212171846.GA28682@lst.de> <686cc853-96e2-4aa4-8f68-fdcc5cdabbba@acm.org> <20231212174802.GA30659@lst.de> <5b7be2e9-3691-409d-abff-f1fbf04cef7d@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b7be2e9-3691-409d-abff-f1fbf04cef7d@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 12, 2023 at 10:09:49AM -0800, Bart Van Assche wrote:
>
> On 12/12/23 09:48, Christoph Hellwig wrote:
>> You keep insisting
>> on using a broken model despite having a major influence on the standards.
>> Go and fix them, and I bet you'll actually have plenty of support.
>
> Hi Christoph,
>
> I do *not* appreciate what you wrote. You shouldn't tell me what I should do
> with regard to standardization. If you want standards to be changed, please
> change these yourself.

Bart,

I don't appreciate all the work you create by insisting on a fundamentally
broken model either.  If you want zoned devices to work you need something
like zone append, and your insistence on using broken methods is not
helpful.  So if you don't want to change the standard to actually work
for your use case at least don't waste *our* time trying to work around
it badly.


>
> Bart.
---end quoted text---
