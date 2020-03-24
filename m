Return-Path: <SRS0=A/1A=5J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1F0C41621
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 10:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81AA208C3
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 10:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgCXKlg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:41:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:54450 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgCXKlf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 06:41:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E1B87ACFF;
        Tue, 24 Mar 2020 10:41:33 +0000 (UTC)
Date:   Tue, 24 Mar 2020 11:41:32 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH blktests v3 4/4] Add a test that triggers the
 blk_mq_realloc_hw_ctxs() error path
Message-ID: <20200324104132.kihzqmgrcel3ufco@beryllium.lan>
References: <20200320222413.24386-1-bvanassche@acm.org>
 <20200320222413.24386-5-bvanassche@acm.org>
 <20200323112909.wrbnlvdioe37mni7@beryllium.lan>
 <e4248d0c-445d-55b2-36c7-05b453f6d343@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4248d0c-445d-55b2-36c7-05b453f6d343@acm.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

On Mon, Mar 23, 2020 at 08:09:27PM -0700, Bart Van Assche wrote:
> On 2020-03-23 04:29, Daniel Wagner wrote:
> > On Fri, Mar 20, 2020 at 03:24:13PM -0700, Bart Van Assche wrote:
> >> +test() {
> >> +	local i sq=/sys/kernel/config/nullb/nullb0/submit_queues
> >> +
> >> +	: "${TIMEOUT:=30}"
> >> +	if ! _init_null_blk nr_devices=0 queue_mode=2 "init_hctx=$(nproc),100,0,0"; then

From the kernel code:

	/* "<interval>,<probability>,<space>,<times>" */

Don't you need to set the times attribute to -1 in order to inject the
everytime the interval is reached? If I understood it correctly,
with times=0 no failure is injected.

BTW, I've had to change it to init_hctx=$(($(nproc)+1)) to pass
the initial __configure_null_blk call before the first fail hits.

> > Doesn't make the $(nproc) the test subtil depending on the execution
> > environment?
> The value $(nproc) has been chosen on purpose. The following code from
> the test script:
>
> +			echo 1 >$sq
> +			nproc >$sq
>
> triggers (nproc + 1) calls to null_init_hctx().So injecting a failure
> after (nproc) null_init_hctx() calls triggers the following pattern:
> * The first blk_mq_realloc_hw_ctxs() call fails after (nproc - 1)
> null_init_hctx() calls.
> * The second blk_mq_realloc_hw_ctxs() call fails after (nproc - 2)
> null_init_hctx() calls.
> ...
> * The (nproc) th blk_mq_realloc_hw_ctxs() call fails after one
> null_init_hctx() call.
> * The (nproc + 1) th blk_mq_realloc_hw_ctxs() call succeeds.
>
> I'm not sure to trigger this behavior without using the $(nproc) value?

Okay, I get the idea how you want to test.

Is the dependency on nproc because null_blk expects submit_queue <= online
cpus?

Though why the 100?

		for ((i=0;i<100;i++)); do
			echo 1 >$sq
			nproc >$sq
		done

And shouldn't be there a test for error?

Thanks,
Daniel
