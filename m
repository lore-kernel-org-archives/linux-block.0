Return-Path: <SRS0=kLuB=7H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C907C433DF
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 16:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A31720723
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 16:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590425121;
	bh=KVH7LKJR1ciaKJm4MZ5xeh7S4oqgyPcZtFzlre/AYcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h2EgmEXgJg5PG29DEpDLawKyUOTBqNVkZ7X/xqc0RQxuFbhqo0h18Jf+U7s3wOp+K
	 3Kakkc/itIcmp1+xfNodq6EdG4/VPveHLESHDXlq2QglTG+eGFduuUrZLk9SQF7mZx
	 M3Y16dcJfoXiHrx7EvAfi8Z8diFJqs27qa2Hi1gQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389113AbgEYQpU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 May 2020 12:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387766AbgEYQpU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 May 2020 12:45:20 -0400
Received: from C02WT3WMHTD6 (unknown [199.255.45.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB4042070A;
        Mon, 25 May 2020 16:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590425120;
        bh=KVH7LKJR1ciaKJm4MZ5xeh7S4oqgyPcZtFzlre/AYcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l3KQlvZTb7fwZ/3fNF/Mmm55yO1MrMxWNGQ6eIHdgVe1pliK5onlmELx51rgu6DE7
         yWdU70MXD/1JXmUI0VYymanhMKCGtvPVXmXI0ZsNig9/ZXwsHA0uhUMm9Fzhsyar1a
         NmdjfvcstPlhAFDoIgTw0boBmgJAq27qLCDsvHsA=
Date:   Mon, 25 May 2020 10:45:16 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: nvme double __blk_mq_complete_request() bugs
Message-ID: <20200525164516.GC73686@C02WT3WMHTD6>
References: <c77b0998-5112-4d6b-b51c-41d2b901009d@default>
 <86a0321e-d260-ef8c-db9f-b804fc92c670@grimberg.me>
 <49f32df9-81a9-4c15-9950-aceff8fb291e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49f32df9-81a9-4c15-9950-aceff8fb291e@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 24, 2020 at 07:33:02AM -0700, Dongli Zhang wrote:
> >> After code analysis, I think this is for nvme-pci as well.
> >>
> >>                                         nvme_process_cq()
> >>                                         -> nvme_handle_cqe()
> >>                                            -> nvme_end_request()
> >>                                               -> blk_mq_complete_request()
> >> nvme_reset_work()
> >> -> nvme_dev_disable()
> >>     -> nvme_reap_pending_cqes()
> >>        -> nvme_process_cq()
> >>           -> nvme_handle_cqe()
> >>              -> nvme_end_request()
> >>                 -> blk_mq_complete_request()
> >>                    -> __blk_mq_complete_request()
> >>                                                  -> __blk_mq_complete_request()
> > 
> > nvme_dev_disable will first disable the queues before reaping the pending cqes so
> > it shouldn't have this issue.
> > 
> 
> Would you mind help explain how nvme_dev_disable() would avoid this issue?
> 
> nvme_dev_disable() would:
> 
> 1. freeze all the queues so that new request would not enter and submit
> 2. NOT wait for freezing during live reset so that q->q_usage_counter is not
> guaranteed to be zero.
> 3. quiesce all the queues so that new request would not dispatch
> 4. delete the queue and free irq
> 
> However, I do not find a mechanism to prevent if a nvme_end_request() is already
> in progress.
> 
> E.g., suppose __blk_mq_complete_request() is already triggered on cpu 3 and
> waiting for its first line "WRITE_ONCE(rq->state, MQ_RQ_COMPLETE)" to be
> executed ... while another cpu is doing live reset. I do not see how to prevent
> such race.

The queues and their interrupts are torn and synchronized down before the reset
reclaims uncompleted requests. There's no other context that can be running
completions at that point.
