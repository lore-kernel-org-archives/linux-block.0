Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 9 Jan 2018 08:02:58 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "jbacik@fb.com" <jbacik@fb.com>, "jack@suse.cz" <jack@suse.cz>,
	"clm@fb.com" <clm@fb.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"hoeppner@linux.vnet.ibm.com" <hoeppner@linux.vnet.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"sth@linux.vnet.ibm.com" <sth@linux.vnet.ibm.com>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"asamymuthupa@micron.com" <asamymuthupa@micron.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 5/8] blk-mq: make blk_abort_request() trigger timeout path
Message-ID: <20180109160258.GL3668920@devbig577.frc2.facebook.com>
References: <20180108191542.379478-1-tj@kernel.org>
 <20180108191542.379478-6-tj@kernel.org>
 <1515449400.2909.31.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515449400.2909.31.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 08, 2018 at 10:10:01PM +0000, Bart Van Assche wrote:
> Other req->deadline writes are protected by preempt_disable(),
> write_seqcount_begin(&rq->gstate_seq), write_seqcount_end(&rq->gstate_seq)
> and preempt_enable(). I think it's fine that the above req->deadline store
> does not have that protection but I also think that that deserves a comment.

Will add.

Thanks.

-- 
tejun
