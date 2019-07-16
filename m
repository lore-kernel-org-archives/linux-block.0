Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA8AC76188
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 08:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A126920659
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 08:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfGPI36 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 04:29:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfGPI36 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 04:29:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EAF3A308FBAF;
        Tue, 16 Jul 2019 08:29:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id CCB385D71B;
        Tue, 16 Jul 2019 08:29:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 16 Jul 2019 10:29:57 +0200 (CEST)
Date:   Tue, 16 Jul 2019 10:29:56 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org
Subject: Re: [PATCH 3/4] rq-qos: use READ_ONCE/WRITE_ONCE for got_token
Message-ID: <20190716082955.GA15528@redhat.com>
References: <20190715201120.72749-1-josef@toxicpanda.com>
 <20190715201120.72749-4-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715201120.72749-4-josef@toxicpanda.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 16 Jul 2019 08:29:58 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 07/15, Josef Bacik wrote:
>
> Oleg noticed that our checking of data.got_token is unsafe in the
> cleanup case, and should really use a memory barrier.  Use the
> READ_ONCE/WRITE_ONCE helpers on got_token so we can be sure we're always
> safe.

READ/WRITE_ONCE can't help, both are compiler barriers. You need smp_wmb/rmb.

Alternatively,

> @@ -246,7 +246,7 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
>  	prepare_to_wait_exclusive(&rqw->wait, &data.wq, TASK_UNINTERRUPTIBLE);
>  	has_sleeper = !wq_has_single_sleeper(&rqw->wait);
>  	do {
> -		if (data.got_token)
> +		if (READ_ONCE(data.got_token))
>  			break;
>  		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
>  			finish_wait(&rqw->wait, &data.wq);

You can use remove_wait_queue() which takes rqw->wait->lock unconditonally,
but then you will need to do __set_current_state(TASK_RUNNING) and use
"return" instead of break.

Oleg.

