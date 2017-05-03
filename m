Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "osandov@fb.com" <osandov@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 0/4] blk-mq: support to use hw tag for scheduling
Date: Wed, 3 May 2017 17:41:26 +0000
Message-ID: <1493833286.3901.23.camel@sandisk.com>
References: <20170428151539.25514-1-ming.lei@redhat.com>
	 <839682da-f375-8eab-d6f5-fcf1457150f1@fb.com>
	 <20170503040303.GA20187@ming.t460p>
	 <f52b4478-0d18-a248-3fbf-721216a79f92@fb.com>
	 <370fbeb6-d832-968a-2759-47f16b866551@kernel.dk>
	 <20170503150351.GA7927@ming.t460p>
	 <31bb973e-d9cf-9454-58fd-4893701088c5@kernel.dk>
	 <20170503153808.GB7927@ming.t460p> <20170503165201.GB9706@ming.t460p>
	 <1493831309.3901.17.camel@sandisk.com> <20170503171911.GE9706@ming.t460p>
In-Reply-To: <20170503171911.GE9706@ming.t460p>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-05-04 at 01:19 +0800, Ming Lei wrote:
> On Wed, May 03, 2017 at 05:08:30PM +0000, Bart Van Assche wrote:
> > Callers of blk_mq_quiesce_queue() really need blk_mq_stop_hw_queue() to
> > cancel delayed work synchronously. The above call stack shows that we h=
ave
> > to do something about the blk_mq_stop_hw_queue() calls from inside .que=
ue_rq()
> > functions for queues for which BLK_MQ_F_BLOCKING has not been set. I'm =
not
> > sure what the best approach would be: setting BLK_MQ_F_BLOCKING for que=
ues
> > that call blk_mq_stop_hw_queue() from inside .queue_rq() or creating tw=
o
> > versions of blk_mq_stop_hw_queue().
>=20
> I think either synchronize_srcu() or synchronize_rcu() can handle=20
> this, since they are waiting for completion of .queue_rq(). So looks
> cancel_delayed_work_sync() shouldn't be needed?

Hello Ming,

What you wrote is not correct. synchronize_*rcu() only waits for ongoing
.queue_rq() calls. cancel_delayed_work() will return immediately if it is
called after hctx->run_work has already been started. And the hctx->run_wor=
k
handler can trigger new .queue_rq() calls after synchronize_*rcu() has
already returned.

Bart.=
