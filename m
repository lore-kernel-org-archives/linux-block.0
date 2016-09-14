Return-Path: <msnitzer@redhat.com>
Date: Wed, 14 Sep 2016 09:45:46 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Bart Van Assche <bart.vanassche@gmail.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] blk-mq: introduce blk_mq_delay_kick_requeue_list()
Message-ID: <20160914134545.GA29338@redhat.com>
References: <1473782495-44128-1-git-send-email-snitzer@redhat.com>
 <1473782495-44128-2-git-send-email-snitzer@redhat.com>
 <7745fd2a-b8e3-f2c8-5154-4f0bcd263338@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7745fd2a-b8e3-f2c8-5154-4f0bcd263338@acm.org>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 14 2016 at  7:28am -0400,
Bart Van Assche <bart.vanassche@gmail.com> wrote:

> On 09/13/2016 06:01 PM, Mike Snitzer wrote:
> >+void blk_mq_delay_kick_requeue_list(struct request_queue *q,
> >+				    unsigned long msecs)
> >+{
> >+	kblockd_schedule_delayed_work(&q->requeue_work, msecs);
> >+}
> >+EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
> 
> Hello Mike,
> 
> I think kblockd_schedule_delayed_work() expects that the second
> argument is a number of jiffies instead of a number of milliseconds.

Yeap, you're right.  An earlier version was using msecs_to_jiffies() in
the DM caller.  I'll submit v2.
