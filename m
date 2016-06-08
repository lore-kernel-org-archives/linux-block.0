Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: keith.busch@intel.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, sagi@lightbits.io,
        ming.l@ssi.samsung.com
Subject: Re: [PATCH 01/11] Revert "blk-mq: add blk_mq_alloc_request_hctx"
References: <1465389066-19119-1-git-send-email-hch@lst.de>
	<1465389066-19119-2-git-send-email-hch@lst.de>
	<x49mvmv235d.fsf@segfault.boston.devel.redhat.com>
	<20160608141019.GB1020@lst.de>
Date: Wed, 08 Jun 2016 10:13:43 -0400
In-Reply-To: <20160608141019.GB1020@lst.de> (Christoph Hellwig's message of
	"Wed, 8 Jun 2016 16:10:19 +0200")
Message-ID: <x49inxj22g8.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> On Wed, Jun 08, 2016 at 09:58:38AM -0400, Jeff Moyer wrote:
>> Christoph Hellwig <hch@lst.de> writes:
>> 
>> > Just for book keeping. The next patch brings it back with some changes.
>> 
>> That's a strange thing to do, and breaks bisectability.  Why not just
>> update the function?
>
> Because it's just an updated to a not yet applied series.  The idea is
> that Jens could just take patch 2 if we get a positive review or two for
> it.

Ah, gotcha.  Thanks for the clarification.

-Jeff
