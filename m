Return-Path: <hch@lst.de>
Date: Tue, 29 May 2018 19:45:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Verkamp, Daniel" <daniel.verkamp@intel.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Hannes Reinecke <hare@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
	"Busch, Keith" <keith.busch@intel.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 09/14] nvmet: Add AEN configuration support
Message-ID: <20180529174517.GB1637@lst.de>
References: <20180526102735.31404-1-hch@lst.de> <20180526102735.31404-10-hch@lst.de> <A5F28D4A728A7E41839CDC5C3B5A01E8B74D2557@FMSMSX103.amr.corp.intel.com> <20180529172936.GA1235@lst.de> <A5F28D4A728A7E41839CDC5C3B5A01E8B74D35C6@FMSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A5F28D4A728A7E41839CDC5C3B5A01E8B74D35C6@FMSMSX103.amr.corp.intel.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 29, 2018 at 05:35:12PM +0000, Verkamp, Daniel wrote:
> Sorry, I should have been clearer - I agree with your position here.  Only bits that are valid should be allowed, so for example it is fine to fail commands that set reserved bits, or optional bits that have a mechanism to indicate they are not supported, like Telemetry (which has an associated bit in Identify controller data - LPA).  My note above was really just about the health warning bits, which by my reading are not optional.

Yes, I think your reading is right and we should not fail those bits.
I'll fix it for the next version.
