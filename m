Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] cfq: priority boost on meta/prio marked IO
To: Jeff Moyer <jmoyer@redhat.com>, Jens Axboe <axboe@fb.com>
References: <20160608204347.GA30146@kernel.dk>
 <x4937omxd9u.fsf@segfault.boston.devel.redhat.com>
 <5759E177.9040307@kernel.dk>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5759E299.2060200@kernel.dk>
Date: Thu, 9 Jun 2016 15:41:45 -0600
MIME-Version: 1.0
In-Reply-To: <5759E177.9040307@kernel.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/09/2016 03:36 PM, Jens Axboe wrote:
> On 06/09/2016 03:28 PM, Jeff Moyer wrote:
>> Jens Axboe <axboe@fb.com> writes:
>>
>>> At Facebook, we have a number of cases where people use ionice to set a
>>> lower priority, then end up having tasks stuck for a long time because
>>> eg meta data updates from an idle priority tasks is blocking out higher
>>> priority processes. It's bad enough that it will trigger the softlockup
>>> warning.
>>>
>>> This patch adds code to CFQ that bumps the priority class and data for
>>> an idle task, if is doing IO marked as PRIO or META. With this, we no
>>> longer see the softlockups.
>>>
>>> Signed-off-by: Jens Axboe <axboe@fb.com>
>>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index 32a283eb7274..3cfd67d006fb 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -1781,6 +1781,11 @@ get_rq:
>>>           rw_flags |= REQ_SYNC;
>>>
>>>       /*
>>> +     * Add in META/PRIO flags, if set, before we get to the IO
>>> scheduler
>>> +     */
>>> +    rw_flags |= (bio->bi_rw & (REQ_META | REQ_PRIO));
>>> +
>>> +    /*
>>
>> This needs a docbook update.  It now reads:
>>
>>   * @rw_flags: RW and SYNC flags
>>
>> so whatever flags we're adding should be specified, I guess.
>>
>> Speaking of which, after much waffling, I think I've decided it would be
>> cleaner to limit the priority boost to REQ_PRIO requests only.
>
> I went and checked, but I don't see it. Where is this?

Ah now I see, you're looking at current -git. The patch is against
for-4.8/core.

Updated version below, dropping REQ_META and changing the naming
s/meta/prio.

diff --git a/block/blk-core.c b/block/blk-core.c
index 32a283eb7274..3cfd67d006fb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1781,6 +1781,11 @@ get_rq:
  		rw_flags |= REQ_SYNC;

  	/*
+	 * Add in META/PRIO flags, if set, before we get to the IO scheduler
+	 */
+	rw_flags |= (bio->bi_rw & (REQ_META | REQ_PRIO));
+
+	/*
  	 * Grab a free request. This is might sleep but can not fail.
  	 * Returns with the queue unlocked.
  	 */
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 4e5978426ee7..f2955c41a306 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -141,7 +141,7 @@ struct cfq_queue {

  	/* io prio of this group */
  	unsigned short ioprio, org_ioprio;
-	unsigned short ioprio_class;
+	unsigned short ioprio_class, org_ioprio_class;

  	pid_t pid;

@@ -3700,6 +3700,7 @@ static void cfq_init_prio_data(struct cfq_queue 
*cfqq, struct cfq_io_cq *cic)
  	 * elevate the priority of this queue
  	 */
  	cfqq->org_ioprio = cfqq->ioprio;
+	cfqq->org_ioprio_class = cfqq->ioprio_class;
  	cfq_clear_cfqq_prio_changed(cfqq);
  }

@@ -4295,6 +4296,20 @@ static void cfq_completed_request(struct 
request_queue *q, struct request *rq)
  		cfq_schedule_dispatch(cfqd);
  }

+static void cfqq_boost_on_prio(struct cfq_queue *cfqq, int op_flags)
+{
+	if (!(op_flags & REQ_PRIO)) {
+		cfqq->ioprio_class = cfqq->org_ioprio_class;
+		cfqq->ioprio = cfqq->org_ioprio;
+		return;
+	}
+
+	if (cfq_class_idle(cfqq))
+		cfqq->ioprio_class = IOPRIO_CLASS_BE;
+	if (cfqq->ioprio > IOPRIO_NORM)
+		cfqq->ioprio = IOPRIO_NORM;
+}
+
  static inline int __cfq_may_queue(struct cfq_queue *cfqq)
  {
  	if (cfq_cfqq_wait_request(cfqq) && !cfq_cfqq_must_alloc_slice(cfqq)) {
@@ -4325,6 +4340,7 @@ static int cfq_may_queue(struct request_queue *q, 
int op, int op_flags)
  	cfqq = cic_to_cfqq(cic, rw_is_sync(op, op_flags));
  	if (cfqq) {
  		cfq_init_prio_data(cfqq, cic);
+		cfqq_boost_on_prio(cfqq, op_flags);

  		return __cfq_may_queue(cfqq);
  	}

-- 
Jens Axboe
