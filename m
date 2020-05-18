Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505FEC433DF
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 18:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CDB02070A
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 18:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgERSrf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 14:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgERSrf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 14:47:35 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7E6C061A0C
        for <linux-block@vger.kernel.org>; Mon, 18 May 2020 11:47:35 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jaknN-00027G-6n; Mon, 18 May 2020 20:47:25 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 9754C100606; Mon, 18 May 2020 20:47:24 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 5/9] blk-mq: don't set data->ctx and data->hctx in blk_mq_alloc_request_hctx
In-Reply-To: <20200518131634.GA645@lst.de>
References: <20200518093155.GB35380@T590> <87imgty15d.fsf@nanos.tec.linutronix.de> <20200518115454.GA46364@T590> <20200518131634.GA645@lst.de>
Date:   Mon, 18 May 2020 20:47:24 +0200
Message-ID: <87k119w05f.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:
> On Mon, May 18, 2020 at 07:54:54PM +0800, Ming Lei wrote:
>> 
>> I guess I misunderstood your point, sorry for that.
>> 
>> The requirement is just that the request needs to be allocated on one online
>> CPU after INACTIVE is set, and we can use a workqueue to do that.
>
> I've looked over the code again, and I'm really not sure why we need that.
> Presumable the CPU hotplug code ensures tasks don't get schedule on the
> CPU running the shutdown state machine, so if we just do a retry of the
> tag allocation we can assume we are on a different CPU now (Thomas,
> correct me if that assumption is wrong).

User space tasks are kicked away once the CPU is cleared in the active
set, which is the very first operation on unplug.

Unbound kthreads are handled the same way as user space tasks.

Per CPU kthreads can run until the CPU clears the online bit which is at
the very end of the unplug operation just before it dies.

Some of these kthreads are managed and stop earlier, e.g. workqueues.

Thanks,

        tglx
