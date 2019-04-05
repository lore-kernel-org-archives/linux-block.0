Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA3FC282CE
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 22:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36E1206BA
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 22:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554503751;
	bh=D+D2m5srfUxEosukw6mXliczfMebuif9CioosThZzAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tmwhWcwb86VoBgABOC58/lTlhjPrCeUGPH3FVkRofqmNljuEac7IkxdXkj1SiIhHG
	 2iXyPPqUdPu6ye84i8nC4YZl3XVR6OPFNKCCHq07X/2IlnWVjC/Geu64NfSkY23Yqh
	 xyWD/RW/eJtP07bsHSOYijjiGYN0ruNEZ55uveQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfDEWfu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:35:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:54243 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfDEWfu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Apr 2019 18:35:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 15:35:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,313,1549958400"; 
   d="scan'208";a="289142686"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga004.jf.intel.com with ESMTP; 05 Apr 2019 15:35:48 -0700
Date:   Fri, 5 Apr 2019 16:37:20 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] blk-mq: Wait for for hctx requests on CPU unplug
Message-ID: <20190405223719.GC25081@localhost.localdomain>
References: <20190405215920.27085-1-keith.busch@intel.com>
 <226503cd-53ac-902c-7944-b2748407b1d3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <226503cd-53ac-902c-7944-b2748407b1d3@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 05, 2019 at 04:23:27PM -0600, Jens Axboe wrote:
> On 4/5/19 3:59 PM, Keith Busch wrote:
> > Managed interrupts can not migrate affinity when their CPUs are offline.
> > If the CPU is allowed to shutdown before they're returned, commands
> > dispatched to managed queues won't be able to complete through their
> > irq handlers.
> > 
> > Introduce per-hctx reference counting so we can block the CPU dead
> > notification for all allocated requests to complete if an hctx's last
> > CPU is being taken offline.
> 
> What does this do to performance? We're doing a map per request...

It should be the same cost as the blk_queue_enter/blk_queue_exit that's
also done per request, which is pretty cheap way to count users. I
don't think I'm measuring a difference, but my test sample size so far
is just one over-powered machine.
