Return-Path: <hch@lst.de>
Date: Mon, 22 Oct 2018 11:08:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@kernel.dk,
	martin.petersen@oracle.com, tom.leiming@gmail.com, hch@lst.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] block: fix the DISCARD request merge
Message-ID: <20181022090849.GA19053@lst.de>
References: <1540045777-10290-1-git-send-email-jianchao.w.wang@oracle.com> <20181022090601.GA21171@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181022090601.GA21171@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 22, 2018 at 05:06:02PM +0800, Ming Lei wrote:
> 
> The above may be changed to 'if (blk_try_merge(req) == ELEVATOR_DISCARD_MERGE)'
> or sort of in future, which may has document benefit at least, since
> ELEVATOR_DISCARD_MERGE means multi-segment discard merge.

I like that idea, and we should do it for the respin
