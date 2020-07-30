Return-Path: <SRS0=0pY0=BJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A709C433DF
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 18:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4768F2083E
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 18:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596133141;
	bh=YneOXmfMX/VCJCqOxykrtCNP9BEL/Sppaueh6TQR09A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CrLFv1NJ5+SOjnm/33Fl+b9/SqmuVksFFbqavdFxKQZVyraCHJqPPDGZtTJtaJlvZ
	 IOeKnwd2ujsND8P8858mdz5rz89byOgOoDyAJQF2EOT5VuxqHEav2Rb6IR0fvKFxDe
	 PcwxO1U6TNCD0RAvXCGSKcCH1yDn9/togSaML4ZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgG3STA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 14:19:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgG3STA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 14:19:00 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6131620829;
        Thu, 30 Jul 2020 18:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596133140;
        bh=YneOXmfMX/VCJCqOxykrtCNP9BEL/Sppaueh6TQR09A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vy6DPyJs3aLe1FtXEpFCq753hd1zGpFSeOQwiHZJfvnxCS8i/Giqmqd1dzWxIHsQg
         q3iBrcz2AVMMAdtKfFq/7EVOFnVap8vQKKSeZaFTI5eP4ZrcR3OKRQMxxq1SXnjPbg
         2oSpHDg7Dl/ebvdJsdHm+QIi7sVBrw4vf/xHtO8U=
Date:   Thu, 30 Jul 2020 11:18:57 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [RFC PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
Message-ID: <20200730181857.GA147247@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200728134938.1505467-1-ming.lei@redhat.com>
 <20200729102856.GA1563056@T590>
 <b80fa58d-34f0-cff5-c3f9-7b3d05a8a1ca@grimberg.me>
 <20200729154957.GD1698748@T590>
 <f3ead535-070d-40ec-08b8-56e2c1cd7ba4@grimberg.me>
 <20200730145325.GA1710335@T590>
 <57689a6d-9e6f-bb28-dd5f-f575988e7cb6@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57689a6d-9e6f-bb28-dd5f-f575988e7cb6@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 30, 2020 at 09:10:48AM -0700, Sagi Grimberg wrote:
> > > I think it will be a significant improvement to have a single code path.
> > > The code will be more robust and we won't need to face issues that are
> > > specific for blocking.
> > > 
> > > If the cost is negligible, I think the upside is worth it.
> > > 
> > 
> > rcu_read_lock and rcu_read_unlock has been proved as efficient enough,
> > and I don't think percpu_refcount is better than it, so I'd suggest to
> > not switch non-blocking into this way.
> 
> It's not a matter of which is better, its a matter of making the code
> more robust because it has a single code-path. If moving to percpu_ref
> is negligible, I would suggest to move both, I don't want to have two
> completely different mechanism for blocking vs. non-blocking.

FWIW, I proposed an hctx percpu_ref over a year ago (but for a
completely different reason), and it was measured as too costly.

  https://lore.kernel.org/linux-block/d4a4b6c0-3ea8-f748-85b0-6b39c5023a6f@kernel.dk/
