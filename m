Return-Path: <hch@lst.de>
Date: Thu, 19 Oct 2017 15:54:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 03/17] block: provide a direct_make_request helper
Message-ID: <20171019135430.GD21452@lst.de>
References: <20171018165258.23212-1-hch@lst.de> <20171018165258.23212-4-hch@lst.de> <d8605553-ef38-4aa2-1513-39ae49de3856@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d8605553-ef38-4aa2-1513-39ae49de3856@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 19, 2017 at 01:35:58PM +0300, Sagi Grimberg wrote:
>
>> +/**
>> + * direct_make_request - hand a buffer directly to its device driver for I/O
>> + * @bio:  The bio describing the location in memory and on the device.
>> + *
>> + * This function behaves like generic_make_request(), but does not protect
>> + * against recursion.  Must only be used if the called driver is known
>> + * to not call generic_make_request (or direct_make_request) again from
>> + * its make_request function.  (Calling direct_make_request again from
>> + * a workqueue is perfectly fine as that doesn't recurse).
>
> Question: are the double spaces on purpose?

Yes.  It's a very common style, and especially useful with monospace fonts.
https://en.wikipedia.org/wiki/Sentence_spacing for reference.
