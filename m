Return-Path: <hch@lst.de>
Date: Wed, 16 May 2018 18:24:32 +0200
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"sebott@linux.ibm.com" <sebott@linux.ibm.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"maxg@mellanox.com" <maxg@mellanox.com>,
	"tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH v9 2/2] blk-mq: Rework blk-mq timeout handling again
Message-ID: <20180516162432.GA4398@lst.de>
References: <20180515225124.20428-1-bart.vanassche@wdc.com> <20180515225124.20428-6-bart.vanassche@wdc.com> <20180516125110.GA32078@lst.de> <8058d72fef475caffa78c962bc4220f5f8fa3dde.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8058d72fef475caffa78c962bc4220f5f8fa3dde.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 16, 2018 at 04:17:42PM +0000, Bart Van Assche wrote:
> There is another reason the deadline is included in the atomic operation,
> namely to handle races between the BLK_EH_RESET_TIMER case in blk_mq_rq_timed_out()
> and blk_mq_complete_request(). I don't think that race is addressed properly by
> your patch. I will see what I can do to address that race without using 64-bit
> atomic operations.

I might be missing something here, so please help me understand
what is missing.

If we restart the timer in blk_mq_rq_timed_out we also bump the
generation at the same time as we reset the deadline in your old
patch.  With this patch we only bump the generation, but that should
be enough to address the rest, or not?
