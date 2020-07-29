Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBD1C433E0
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 04:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89EA120768
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 04:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595995806;
	bh=IKuBNsl4qI263D75wzMMfJxggGK+N6Re79brmEIzMxA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=l3iJzkCQPsKHBAhohuX9eC5N71NUYagshMIC6PSWQ8XSU4akS+TX1dfmX/qerHhIa
	 h8Z7ROvSlR1Y2doVwCxoA4SjcYh7ubawucK3pgixB5G/hpkw/hP/CZR6S9T/GlUz/m
	 bvQsxgYyLSj0mCD2deWHz0cljAd11gSndSPIYIqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgG2EKF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 00:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgG2EKF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 00:10:05 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA2C9206D7;
        Wed, 29 Jul 2020 04:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595995805;
        bh=IKuBNsl4qI263D75wzMMfJxggGK+N6Re79brmEIzMxA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OH1QkGNd8OQvbYtYzMt3W9axgOV4KN7144XsAoavF/F84RBlHJJIG75jz/4fq06/Y
         H347LXh6xgmmQ4rxh0sKnPuqwkgbQGfj+7P7BQFfpaFdX76IwSDQlUcNDQmUxelGKk
         UM3Go1sN/Nzwhz6ROLO3/Uy3rpGwcDvhQg/VfWjw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C7F783522621; Tue, 28 Jul 2020 21:10:04 -0700 (PDT)
Date:   Tue, 28 Jul 2020 21:10:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>,
        Keith Busch <kbusch@kernel.org>, Ming Lin <mlin@kernel.org>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200729041004.GV9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me>
 <20200728071859.GA21629@lst.de>
 <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
 <20200728135436.GP9247@paulmck-ThinkPad-P72>
 <d1ba2009-130a-d423-1389-c7af72e25a6a@grimberg.me>
 <20200729003124.GT9247@paulmck-ThinkPad-P72>
 <07c90cf1-bb6f-a343-b0bf-4c91b9acb431@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c90cf1-bb6f-a343-b0bf-4c91b9acb431@grimberg.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 28, 2020 at 05:43:02PM -0700, Sagi Grimberg wrote:
> 
> > > Dynamically allocating each one is possible but not very scalable.
> > > 
> > > The question is if there is some way, we can do this with on-stack
> > > or a single on-heap rcu_head or equivalent that can achieve the same
> > > effect.
> > 
> > If the hctx structures are guaranteed to stay put, you could count
> > them and then do a single allocation of an array of rcu_head structures
> > (or some larger structure containing an rcu_head structure, if needed).
> > You could then sequence through this array, consuming one rcu_head per
> > hctx as you processed it.  Once all the callbacks had been invoked,
> > it would be safe to free the array.
> > 
> > Sounds too simple, though.  So what am I missing?
> 
> We don't want higher-order allocations...

OK, I will bite...  Do multiple lower-order allocations (page size is
still lower-order, correct?) and link them together.

Sorry, couldn't resist...

							Thanx, Paul
