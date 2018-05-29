Return-Path: <hch@lst.de>
Date: Tue, 29 May 2018 19:29:36 +0200
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
Message-ID: <20180529172936.GA1235@lst.de>
References: <20180526102735.31404-1-hch@lst.de> <20180526102735.31404-10-hch@lst.de> <A5F28D4A728A7E41839CDC5C3B5A01E8B74D2557@FMSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A5F28D4A728A7E41839CDC5C3B5A01E8B74D2557@FMSMSX103.amr.corp.intel.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 29, 2018 at 05:15:34PM +0000, Verkamp, Daniel wrote:
> This looks overly restrictive - a host sending a Set Features with e.g. the health critical warning bits set in CDW11 will get a failure.  As far as I can tell, this isn't allowed by the spec;  Set Features - Asynchronous Event Configuration and the health log page have been mandatory since NVMe 1.0, and presumably support for the corresponding health log page related AER bits is also mandatory (these were the only bits available in NVMe 1.0).

Agreed so far.

> I think it should be fine to just allow the user to set any (valid) combination of bits here, while still only triggering the NS Changed notification.

Disagreeing here.  Catching completely bogus bits that the hosts sets
is important.
