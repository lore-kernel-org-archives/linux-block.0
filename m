Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
Date: Thu, 17 May 2018 14:41:19 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "kernel-team@fb.com" <kernel-team@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"nbd@other.debian.org" <nbd@other.debian.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"jbacik@fb.com" <jbacik@fb.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] nbd: don't start req until after the dead connection
 logic
Message-ID: <20180517184117.v3tqqg4utvs6imcv@destiny>
References: <1508444519-8751-1-git-send-email-josef@toxicpanda.com>
 <1508444519-8751-2-git-send-email-josef@toxicpanda.com>
 <18f4a25c14a0803c87bf465c686f0274f558818a.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18f4a25c14a0803c87bf465c686f0274f558818a.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 17, 2018 at 06:21:40PM +0000, Bart Van Assche wrote:
> On Thu, 2017-10-19 at 16:21 -0400, Josef Bacik wrote:
> > +	blk_mq_start_request(req);
> >  	if (unlikely(nsock->pending && nsock->pending != req)) {
> >  		blk_mq_requeue_request(req, true);
> >  		ret = 0;
> 
> (replying to an e-mail from seven months ago)
> 
> Hello Josef,
> 
> Are you aware that the nbd driver is one of the very few block drivers that
> calls blk_mq_requeue_request() after a request has been started? I think that
> can lead to the block layer core to undesired behavior, e.g. that the timeout
> handler fires concurrently with a request being reinstered. Can you or a
> colleague have a look at this? I would like to add the following code to the
> block layer core and I think that the nbd driver would trigger this warning:
> 
>  void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
>  {
> +       WARN_ON_ONCE(old_state != MQ_RQ_COMPLETE);
> +
>         __blk_mq_requeue_request(rq);
> 

Yup I can tell you why, on 4.11 where I originally did this work
__blk_mq_requeue_request() did this

static void __blk_mq_requeue_request(struct request *rq)
{
        struct request_queue *q = rq->q;

        trace_block_rq_requeue(q, rq);
        rq_qos_requeue(q, &rq->issue_stat);
        blk_mq_sched_requeue_request(rq);

        if (test_and_clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags)) {
                if (q->dma_drain_size && blk_rq_bytes(rq))
                        rq->nr_phys_segments--;
        }
}

So it was clearing the started part when it did the requeue.  If that's not what
I'm supposed to be doing anymore then I can send a patch to fix it.  What is
supposed to be done if I did already do blk_mq_start_request, because I can
avoid doing the start until after that chunk of code, but there's a part further
down that needs to have start done before we reach it, so I'll have to do
whatever the special thing is now there.  Thanks,

Josef
