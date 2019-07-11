Return-Path: <SRS0=DuRR=VI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E65CC74A35
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 13:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0694C21019
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 13:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfGKNkJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 09:40:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbfGKNkJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 09:40:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 11CBD307D853;
        Thu, 11 Jul 2019 13:40:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9A0FD1001B2C;
        Thu, 11 Jul 2019 13:40:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 11 Jul 2019 15:40:08 +0200 (CEST)
Date:   Thu, 11 Jul 2019 15:40:06 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jens Axboe <axboe@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/2] wait: add wq_has_multiple_sleepers helper
Message-ID: <20190711134006.GA19160@redhat.com>
References: <20190710195227.92322-1-josef@toxicpanda.com>
 <bbe73e4e-9270-46ac-16d7-39a40485fe53@kernel.dk>
 <20190710203516.GL3419@hirez.programming.kicks-ass.net>
 <752dbdc9-945d-e70c-e6f3-0c48932c7f60@fb.com>
 <20190711114543.GA14901@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711114543.GA14901@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 11 Jul 2019 13:40:09 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 07/11, Oleg Nesterov wrote:
>
> Jens,
>
> I managed to convince myself I understand why 2/2 needs this change...
> But rq_qos_wait() still looks suspicious to me. Why can't the main loop
> "break" right after io_schedule()? rq_qos_wake_function() either sets
> data->got_token = true or it doesn't wakeup the waiter sleeping in
> io_schedule()
>
> This means that data.got_token = F at the 2nd iteration is only possible
> after a spurious wakeup, right? But in this case we need to set state =
> TASK_UNINTERRUPTIBLE again to avoid busy-wait looping ?

Oh. I can be easily wrong, I never read this code before, but it seems to
me there is another unrelated race.

rq_qos_wait() can't rely on finish_wait() because it doesn't necessarily
take wq_head->lock.

rq_qos_wait() inside the main loop does

		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
			finish_wait(&rqw->wait, &data.wq);

			/*
			 * We raced with wbt_wake_function() getting a token,
			 * which means we now have two. Put our local token
			 * and wake anyone else potentially waiting for one.
			 */
			if (data.got_token)
				cleanup_cb(rqw, private_data);
			break;
		}

finish_wait() + "if (data.got_token)" can race with rq_qos_wake_function()
which does

	data->got_token = true;
	list_del_init(&curr->entry);

rq_qos_wait() can see these changes out-of-order: finish_wait() can see
list_empty_careful() == T and avoid wq_head->lock, and in this case the
code above can see data->got_token = false.

No?

and I don't really understand

	has_sleeper = false;

at the end of the main loop. I think it should do "has_sleeper = true",
we need to execute the code above only once, right after prepare_to_wait().
But this is harmless.

Oleg.

