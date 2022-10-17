Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637BBC4332F
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 22:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJQWlS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Oct 2022 18:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiJQWlR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Oct 2022 18:41:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82D12F02B
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 15:41:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2987A612AC
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 22:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F77C433B5;
        Mon, 17 Oct 2022 22:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666046475;
        bh=9fDxJXZK1U5womZDJo/c6FscAHDcI1ZEsc4GYARxhcU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NlhwvhXnMEkst0U+X3torWYjiWRmQFE2imEJmLTmGUTEHw3MwqigrAGHwi0X7+WwC
         o2mU7YTjFZ038Do7gF/b9hhV+sg1qLk0GshZFAN2x0fgMK1fJud1ifPwWvyaGPjZux
         TaNkCQXaZReqDNUM8M1oYjmQ4PL/NpfAcBnyIgFJdgx8802xlgaIobz0auU0K2bQPn
         cqlaVYLWLlvm8fLVeac0JNDJaou4DlbimxTeIb8h8Tj0V7gBOdft5NplZ5K1eXAh57
         CDk8QjvGSyhiZ+kG6g8vnrPk3SKcAz7iPPbzbYuQkb6Owk8QYEAijxMekqj36S+57M
         akMuagydW2GDQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 16EC05C0C34; Mon, 17 Oct 2022 15:41:15 -0700 (PDT)
Date:   Mon, 17 Oct 2022 15:41:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, sagi@grimberg.me, kbusch@kernel.org,
        ming.lei@redhat.com, axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221017224115.GJ5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com>
 <20221017133906.GA24492@lst.de>
 <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1>
 <20221017153105.GA32509@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017153105.GA32509@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 17, 2022 at 05:31:05PM +0200, Christoph Hellwig wrote:
> On Mon, Oct 17, 2022 at 08:21:36AM -0700, Paul E. McKenney wrote:
> > The main reason for having multiple srcu_struct structures is to
> > prevent the readers from one from holding up the updaters from another.
> > Except that by waiting for the multiple grace periods, you are losing
> > that property anyway, correct?  Or is this code waiting on only a small
> > fraction of the srcu_struct structures associated with blk_queue?
> 
> There are a few places that do this.  SCSI and MMC could probably switch
> to this scheme or at least and open coded version of it (if we move
> to a per_tagsect srcu_struct open coding it might be a better idea
> anyway).
> 
> del_gendisk is one where we have to go one queue at a time, and
> that might actually matter for a device removal.  elevator_switch
> is another one, there is a variant for it that works on the whole
> tagset, but also those that don't.

OK, thank you for the info!

Then the big question is "how long do the SRCU readers run?"

If all of the readers ran for exactly the same duration, there would be
little point in having more than one srcu_struct.

If the kernel knew up front how long the SRCU readers for a given entry
would run, it could provide an srcu_struct structure for each duration.
For a (fanciful) example, you could have one srcu_struct structure for
SSDs, another for rotating rust, a third for LAN-attached storage, and
a fourth for WAN-attached storage.  Maybe a fifth for lunar-based storage.

If it is impossible to know up front which entry has what SRCU read-side
latency characteristics, then the current approach of just giving each
entry its own srcu_struct structure is not at all a bad plan.

Does that help, or am I off in the weeds here?

							Thanx, Paul
