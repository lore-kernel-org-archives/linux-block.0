Return-Path: <hch@lst.de>
Date: Tue, 2 May 2017 17:16:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH 4/6] mtip32xx: convert internal command issue to block
	IO path
Message-ID: <20170502151607.GA22963@lst.de>
References: <1493398473-29872-1-git-send-email-axboe@fb.com> <1493398473-29872-5-git-send-email-axboe@fb.com> <20170502072810.GA11582@lst.de> <b5eae6e4-92f3-3266-5f8e-21c7ab6e69f6@fb.com> <a43cf987-6f97-a82d-38e7-f8880c4d63ae@kernel.dk> <da3549ce-74ad-07da-528c-3a8b84b275f9@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <da3549ce-74ad-07da-528c-3a8b84b275f9@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

This looks reasonable to me, although of course I don't have a way
to test it.

Any reason for the move from ->end_io_data to ->special?  I thought
that ->special was something we'd get rid of sooner or later now
that we can have additional per-cmd data even for !mq.
