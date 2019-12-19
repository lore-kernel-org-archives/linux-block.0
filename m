Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5979C43603
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 09:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DC0222C2
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 09:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mddEP1se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfLSJVE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 04:21:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44860 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfLSJVD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 04:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=L5GkT/t6f4PnNOvpHdWu3aKGL2zH/bo2tSmNC9/q9HA=; b=mddEP1seEEQAJCSWNeDGhge7a
        1v9fDA9ktosw6z8UFtOF11Q7LsoUHivAylwsfp/MnLDAzmo2fs1DseTWKz1Kzp4rtHQd6L2psD4Nj
        7dG8aKM6HeUTTsD15EMqCijzys4PmoKjOqAohFrQSRl78r70RtSwpGiBTaWB61TIrahAZnWozWdeH
        xFWuRZuIEboS1BBgCwUJCiUWVsRJgwdqi4bHrFtTnMbeXiCysahaT7x/vIdCkbhOG5qhEFmRZYzVc
        MVtAF6FdHkF6XtGdYo/k8m9KFMYnrcr+o2RIPAkA5yR71aq6UFerio/21v1RZFMyfcR4m4aNJEeJi
        Dd0fzC12g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihryx-0005Zr-Fv; Thu, 19 Dec 2019 09:20:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9871A3007F2;
        Thu, 19 Dec 2019 10:19:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 06B162B291C41; Thu, 19 Dec 2019 10:20:27 +0100 (CET)
Date:   Thu, 19 Dec 2019 10:20:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Long Li <longli@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [RFC PATCH 1/3] sched/core: add API for exporting runqueue clock
Message-ID: <20191219092026.GW2844@hirez.programming.kicks-ass.net>
References: <20191218071942.22336-1-ming.lei@redhat.com>
 <20191218071942.22336-2-ming.lei@redhat.com>
 <20191218095101.GQ2844@hirez.programming.kicks-ass.net>
 <20191219012914.GA6080@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219012914.GA6080@ming.t460p>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 19, 2019 at 09:29:14AM +0800, Ming Lei wrote:
> On Wed, Dec 18, 2019 at 10:51:01AM +0100, Peter Zijlstra wrote:
> > On Wed, Dec 18, 2019 at 03:19:40PM +0800, Ming Lei wrote:
> > > Scheduler runqueue maintains its own software clock that is periodically
> > > synchronised with hardware. Export this clock so that it can be used
> > > by interrupt flood detection for saving the cost of reading from hardware.
> > 
> > But you don't have much, if any, guarantees the thing gets updated.
> 
> Any software clock won't be guaranteed to be updated in time, however,
> they are still useful.

It still is broken, and I really don't want to expose this for whatever
reason.
