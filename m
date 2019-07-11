Return-Path: <SRS0=DuRR=VI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66565C74A4B
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 11:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9EC21655
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 11:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfGKLpq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 07:45:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728350AbfGKLpq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 07:45:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C8AC308626C;
        Thu, 11 Jul 2019 11:45:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id AEE6A600CD;
        Thu, 11 Jul 2019 11:45:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 11 Jul 2019 13:45:46 +0200 (CEST)
Date:   Thu, 11 Jul 2019 13:45:43 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jens Axboe <axboe@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/2] wait: add wq_has_multiple_sleepers helper
Message-ID: <20190711114543.GA14901@redhat.com>
References: <20190710195227.92322-1-josef@toxicpanda.com>
 <bbe73e4e-9270-46ac-16d7-39a40485fe53@kernel.dk>
 <20190710203516.GL3419@hirez.programming.kicks-ass.net>
 <752dbdc9-945d-e70c-e6f3-0c48932c7f60@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <752dbdc9-945d-e70c-e6f3-0c48932c7f60@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 11 Jul 2019 11:45:46 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,

I managed to convince myself I understand why 2/2 needs this change...
But rq_qos_wait() still looks suspicious to me. Why can't the main loop
"break" right after io_schedule()? rq_qos_wake_function() either sets
data->got_token = true or it doesn't wakeup the waiter sleeping in
io_schedule()

This means that data.got_token = F at the 2nd iteration is only possible
after a spurious wakeup, right? But in this case we need to set state =
TASK_UNINTERRUPTIBLE again to avoid busy-wait looping ?

Oleg.

