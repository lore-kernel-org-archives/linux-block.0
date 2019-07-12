Return-Path: <SRS0=GKUn=VJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB58C742A8
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 08:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F215E2084B
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 08:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfGLIFh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Jul 2019 04:05:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfGLIFh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jul 2019 04:05:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6AB4859441;
        Fri, 12 Jul 2019 08:05:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id F00D55D9C5;
        Fri, 12 Jul 2019 08:05:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 12 Jul 2019 10:05:36 +0200 (CEST)
Date:   Fri, 12 Jul 2019 10:05:34 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@fb.com>, Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/2] wait: add wq_has_multiple_sleepers helper
Message-ID: <20190712080533.GA21989@redhat.com>
References: <20190710195227.92322-1-josef@toxicpanda.com>
 <bbe73e4e-9270-46ac-16d7-39a40485fe53@kernel.dk>
 <20190710203516.GL3419@hirez.programming.kicks-ass.net>
 <752dbdc9-945d-e70c-e6f3-0c48932c7f60@fb.com>
 <20190711114543.GA14901@redhat.com>
 <20190711134006.GA19160@redhat.com>
 <20190711192110.aqpin7pr6jwmydsr@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711192110.aqpin7pr6jwmydsr@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 12 Jul 2019 08:05:36 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 07/11, Josef Bacik wrote:
>
> On Thu, Jul 11, 2019 at 03:40:06PM +0200, Oleg Nesterov wrote:
> > rq_qos_wait() inside the main loop does
> >
> > 		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
> > 			finish_wait(&rqw->wait, &data.wq);
> >
> > 			/*
> > 			 * We raced with wbt_wake_function() getting a token,
> > 			 * which means we now have two. Put our local token
> > 			 * and wake anyone else potentially waiting for one.
> > 			 */
> > 			if (data.got_token)
> > 				cleanup_cb(rqw, private_data);
> > 			break;
> > 		}
> >
> > finish_wait() + "if (data.got_token)" can race with rq_qos_wake_function()
> > which does
> >
> > 	data->got_token = true;
> > 	list_del_init(&curr->entry);
> >
>
> Argh finish_wait() does __set_current_state, well that's shitty.

Hmm. I think this is irrelevant,

> data->got_token = true;
> smp_wmb()
> list_del_init(&curr->entry);
>
> and then do
>
> smp_rmb();
> if (data.got_token)
> 	cleanup_cb(rqw, private_data);

Yes, this should work,

> > and I don't really understand
> >
> > 	has_sleeper = false;
> >
> > at the end of the main loop. I think it should do "has_sleeper = true",
> > we need to execute the code above only once, right after prepare_to_wait().
> > But this is harmless.
>
> We want has_sleeper = false because the second time around we just want to grab
> the inflight counter.

I don't think so.

> Yes we should have been worken up by our special thing
> and so should already have data.got_token,

Yes. Again, unless wakeup was spurious and this needs another trivial fix.

If we can't rely on this then this code is simply broken?

> but that sort of thinking ends in
> hung boxes and me having to try to mitigate thousands of boxes suddenly hitting
> a case we didn't think was possible.  Thanks,

I can't understand this logic, but I can't argue. However, in this case I'd
suggest the patch below instead of this series.

If rq_qos_wait() does the unnecessary acquire_inflight_cb() because it can
hit a case we didn't think was possible, then why can't it do on the first
iteration for the same reason? This should equally fix the problem and
simplify the code.

In case it is not clear: no, I don't like it. Just I can't understand your
logic.

And btw... again, I won't argue, but wq_has_multiple_sleepers is badly named,
and the comments are simply wrong. It can return T if wq has no sleepers, iow
if list_empty(wq_head->head). 2/2 actualy uses !wq_has_multiple_sleepers(),
this turns the condition back into list_is_singular(), but to me this alll
looks very confusing.

Plus I too do not understand smp_mb() in this helper.

Oleg.

--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -247,7 +247,7 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 	do {
 		if (data.got_token)
 			break;
-		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
+		if (acquire_inflight_cb(rqw, private_data)) {
 			finish_wait(&rqw->wait, &data.wq);
 
 			/*
@@ -260,7 +260,6 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 			break;
 		}
 		io_schedule();
-		has_sleeper = false;
 	} while (1);
 	finish_wait(&rqw->wait, &data.wq);
 }

