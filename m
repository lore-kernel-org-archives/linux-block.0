Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC651C18E5B
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 08:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD92120663
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 08:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgCYISo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:18:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:52094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgCYISo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 04:18:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E4579AB98;
        Wed, 25 Mar 2020 08:18:42 +0000 (UTC)
Date:   Wed, 25 Mar 2020 09:18:42 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH blktests v3 4/4] Add a test that triggers the
 blk_mq_realloc_hw_ctxs() error path
Message-ID: <20200325081842.qk5rihaf46lzdj2y@beryllium.lan>
References: <20200320222413.24386-1-bvanassche@acm.org>
 <20200320222413.24386-5-bvanassche@acm.org>
 <20200323112909.wrbnlvdioe37mni7@beryllium.lan>
 <e4248d0c-445d-55b2-36c7-05b453f6d343@acm.org>
 <20200324104132.kihzqmgrcel3ufco@beryllium.lan>
 <9c9aaf03-a8c7-03a1-16cd-128b05a0c6b2@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c9aaf03-a8c7-03a1-16cd-128b05a0c6b2@acm.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

> > Is the dependency on nproc because null_blk expects submit_queue <= online
> > cpus?
> 
> That's correct. I want to test with the maximum number of submit queues
> allowed, hence the use of $(nproc).

Ok, I'd probably add this info as comment or have it in the commit
message. Just in case someone in the future wonders why nproc.

> > Though why the 100?
> > 
> > 		for ((i=0;i<100;i++)); do
> > 			echo 1 >$sq
> > 			nproc >$sq
> > 		done
> 
> No particular reason other than "a significant number of iterations".
> 
> > And shouldn't be there a test for error?

Ah ok. I was getting paranoid about numbers :)

> All I want to test is the absence of kernel crashes. The blktests
> framework already inspects dmesg for the absence of kernel crashes. So I
> don't think that I have to check whether or not the quoted sysfs writes
> succeed.

Maybe adding this info to the commit message what this test tries to
cover wouldn't hurt.

Thanks,
Daniel
