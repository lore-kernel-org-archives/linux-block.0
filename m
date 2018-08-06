Return-Path: <BATV+2e2b7d69833f9a8d01a8+5461+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 6 Aug 2018 00:31:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: nvme updates for 4.19
Message-ID: <20180806073100.GA11515@infradead.org>
References: <20180804084354.GA26103@infradead.org>
 <df1c976e-8ea7-ba14-d1d2-caf8511de527@kernel.dk>
 <20180805073305.GA31663@infradead.org>
 <da7f8241-cd79-ff46-21a2-71b282bc1a57@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <da7f8241-cd79-ff46-21a2-71b282bc1a57@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Sun, Aug 05, 2018 at 08:27:22AM -0600, Jens Axboe wrote:
> Right, the change is fine, it's just fighting a similar change
> in a different branch. I did fix it up (picked in the original change
> first), please double check at your convenience.

The merge looks good.  Given that you've changed the head anyway I'd
also be happy to give you a version of the ANA commit without that
change..
