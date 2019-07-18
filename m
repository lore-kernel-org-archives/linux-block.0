Return-Path: <SRS0=jAbK=VP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803E1C7618F
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 15:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A0421849
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 15:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfGRP4a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jul 2019 11:56:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfGRP4a (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jul 2019 11:56:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C70830C62A0;
        Thu, 18 Jul 2019 15:56:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4BECD10021B2;
        Thu, 18 Jul 2019 15:56:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 18 Jul 2019 17:56:30 +0200 (CEST)
Date:   Thu, 18 Jul 2019 17:56:28 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        peterz@infradead.org
Subject: Re: [PATCH 0/5][v3] rq-qos memory barrier shenanigans
Message-ID: <20190718155628.GC13355@redhat.com>
References: <20190716201929.79142-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716201929.79142-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 18 Jul 2019 15:56:30 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 07/16, Josef Bacik wrote:
>
> - add a comment about why we don't need a mb for the first data.token check
>   which I'm sure Oleg will tell me is wrong and I'll have to send a v4

we don't need it because prepare_to_wait_exclusive() does set_current_state()
and this implies mb().

(in fact I think in this particular case it is not needed at all because
 rq_qos_wake_function() sets condition == T under wq_head->lock)

I see nothing wrong in this series. Feel free to add

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

But why does it use wq_has_sleeper() ? I do not understand why do we need
mb() before waitqueue_active() in this particular case...


and just for record. iiuc acquire_inflight_cb() can't block, so it is not
clear to me why performance-wise this all is actually better than just

	void rq_qos_wait(struct rq_wait *rqw, void *private_data,
			 acquire_inflight_cb_t *acquire_inflight_cb)
	{
		struct rq_qos_wait_data data = {
			.wq = {
				.flags	= WQ_FLAG_EXCLUSIVE;
				.func	= rq_qos_wake_function,
				.entry	= LIST_HEAD_INIT(data.wq.entry),
			},
			.task = current,
			.rqw = rqw,
			.cb = acquire_inflight_cb,
			.private_data = private_data,
		};

		if (!wq_has_sleeper(&rqw->wait) && acquire_inflight_cb(rqw, private_data))
			return;

		spin_lock_irq(&rqw->wait.lock);
		if (list_empty(&wq_entry->entry) && acquire_inflight_cb(rqw, private_data))
			data.got_token = true;
		else
			__add_wait_queue_entry_tail(&rqw->wait, &data.wq);
		spin_unlock_irq(&rqw->wait.lock);

		for (;;) {
			set_current_state(TASK_UNINTERRUPTIBLE);
			if (data.got_token)
				break;
			io_schedule();
		}
		finish_wait(&rqw->wait, &data.wq);
	}

note also that the acquire_inflight_cb argument goes away.

Nevermind, feel free to ignore.

Oleg.

