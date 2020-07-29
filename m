Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B9EC433E5
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 00:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A44207E8
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 00:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595984387;
	bh=inRLNcNir+2HXo5UAjgkF7XPH8Znd3x+ex92gz6b024=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N5tO639eOlgiZmVq/N2yBhydbmO5EkTWIQA7AC0+2faESpaBp1vGrJW3ShE6TABnn
	 zcZGXLbajufZgI7OaGknk8s8VkwVKG7Q/S4YTEMREqI29qW5ayVnb2a+tr0oD1/U1m
	 MkrKpxzLeeSOW3NgemcOqyXMp2kAFIKayk13CxSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbgG2A7q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729867AbgG2A7p (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 20:59:45 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C13E207FC;
        Wed, 29 Jul 2020 00:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595984385;
        bh=inRLNcNir+2HXo5UAjgkF7XPH8Znd3x+ex92gz6b024=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sH8OIflDUuu0bNAyqO0ygXSQHjK6EQ3psTuArUDssDeNX46Y+I7YhZBlYqK4Gm3Bx
         WnvTQ9ivIRjGIozLaJXYseQkoJHtMmx6/CEqDHEjb9zbHEop0UCNtH96hvSKEam7wh
         9f7/qwT1vh+cT1va3kvDucqsCDVbc/Q24OgPVJsE=
Date:   Tue, 28 Jul 2020 17:59:42 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     paulmck@kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chao Leng <lengchao@huawei.com>, Ming Lin <mlin@kernel.org>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200729005942.GA2729664@dhcp-10-100-145-180.wdl.wdc.com>
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

So:

  (1) We don't want to embed the struct in the hctx because we allocate
  so many of them that this is non-negligable to add for something we
  typically never use.

  (2) We don't want to allocate dynamically because it's potentially
  huge.

As long as we're using srcu for blocking hctx's, I think it's "pick your
poison".

Alternatively, Ming's percpu_ref patch(*) may be worth a look.

 * https://www.spinics.net/lists/linux-block/msg56976.html1
