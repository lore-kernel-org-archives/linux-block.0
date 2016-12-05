Return-Path: <jthumshirn@suse.de>
Date: Mon, 5 Dec 2016 16:18:54 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, paolo.valente@linaro.org
Subject: Re: [PATCH 2/7] cfq-iosched: use appropriate run queue function
Message-ID: <20161205151854.GJ8481@linux-x5ow.site>
References: <1480734921-23701-1-git-send-email-axboe@fb.com>
 <1480734921-23701-3-git-send-email-axboe@fb.com>
 <20161205084826.GA8481@linux-x5ow.site>
 <d7717e7a-b1eb-693e-145b-a165f1e446f0@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <d7717e7a-b1eb-693e-145b-a165f1e446f0@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Dec 05, 2016 at 08:12:16AM -0700, Jens Axboe wrote:
> On 12/05/2016 01:48 AM, Johannes Thumshirn wrote:
> > On Fri, Dec 02, 2016 at 08:15:16PM -0700, Jens Axboe wrote:
> >> For MQ devices, we have to use other functions to run the queue.
> >> No functional changes in this patch, just a prep patch for
> >> support legacy schedulers on blk-mq.
> >>
> >> Signed-off-by: Jens Axboe <axboe@fb.com>
> >> ---
> >>  block/cfq-iosched.c | 22 +++++++++++++++++++---
> >>  1 file changed, 19 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
> >> index c73a6fcaeb9d..d6d454a72bd4 100644
> >> --- a/block/cfq-iosched.c
> >> +++ b/block/cfq-iosched.c
> >> @@ -919,8 +919,14 @@ static inline struct cfq_data *cic_to_cfqd(struct cfq_io_cq *cic)
> >>  static inline void cfq_schedule_dispatch(struct cfq_data *cfqd)
> >>  {
> >>  	if (cfqd->busy_queues) {
> >> +		struct request_queue *q = cfqd->queue;
> >> +
> >>  		cfq_log(cfqd, "schedule dispatch");
> >> -		kblockd_schedule_work(&cfqd->unplug_work);
> >> +
> >> +		if (q->mq_ops)
> > 
> > You've introduced blk_use_mq_path() in patch 1, so why don't you use it here
> > as well?
> 
> There's a difference. q->mq_ops means "this driver is blk-mq",
> blk_use_mq_path() checks for ->elevator as well, which means "for this
> driver, allocate and insert requests via the legacy IO scheduler path".

Ah OK, that clarifies it. thanks

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
