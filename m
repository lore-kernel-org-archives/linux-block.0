Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk,  linux-nvme@lists.infradead.org,  linux-block@vger.kernel.org
Subject: Re: [PATCH 1/5] blk-mq: update ->init_request and ->exit_request prototypes
References: <20170427174501.18965-1-hch@lst.de>
	<20170427174501.18965-2-hch@lst.de>
	<x49inlpsoey.fsf@segfault.boston.devel.redhat.com>
	<20170428140923.GA32073@lst.de>
Date: Fri, 28 Apr 2017 10:27:50 -0400
In-Reply-To: <20170428140923.GA32073@lst.de> (Christoph Hellwig's message of
	"Fri, 28 Apr 2017 16:09:23 +0200")
Message-ID: <x494lx8r4ih.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

>> If you got rid of request_idx, then this shouldn't build.  So, is there
>> some other prerequisite patch I'm missing?
>
> Yes, both you and I are.  It's "mtip32xx: use runtime tag to initialize
> command header" which is in Jens' for-4.12/block tree, but not in the
> post-merge one.

I see.  With that patch, my concern about walking off the end of the
array is addressed.  Thanks.

-Jeff
