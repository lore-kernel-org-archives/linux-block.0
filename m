Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC505C433E2
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 10:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B625E207ED
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 10:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgERKnI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 06:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgERKnH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 06:43:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0271C061A0C
        for <linux-block@vger.kernel.org>; Mon, 18 May 2020 03:43:07 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jadEV-0007Op-JQ; Mon, 18 May 2020 12:42:55 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id F1236100606; Mon, 18 May 2020 12:42:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 5/9] blk-mq: don't set data->ctx and data->hctx in blk_mq_alloc_request_hctx
In-Reply-To: <20200518093155.GB35380@T590>
Date:   Mon, 18 May 2020 12:42:54 +0200
Message-ID: <87imgty15d.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ming Lei <ming.lei@redhat.com> writes:
> On Mon, May 18, 2020 at 10:32:22AM +0200, Thomas Gleixner wrote:
>> Christoph Hellwig <hch@lst.de> writes:
>> Is this absolutely necessary to be a smp function call? That's going to
>
> I think it is.
>
> Request is bound to the allocation CPU and the hw queue(hctx) which is
> mapped from the allocation CPU.
>
> If request is allocated from one cpu which is going to offline, we can't
> handle that easily.

That's a pretty handwavy explanation and does not give any reason why
this needs to be a smp function call and cannot be solved otherwise,
e.g. by delegating this to a work queue.

>> be problematic vs. RT. Same applies to the explicit preempt_disable() in
>> patch 7.
>
> I think it is true and the reason is same too, but the period is quite short,
> and it is just taken for iterating several bitmaps for finding one free bit.

And takes spinlocks along the way.... See:

  https://www.kernel.org/doc/html/latest/locking/locktypes.html

for a full explanation why this can't work on RT. And that's the same
reason why the smp function call will fall apart on a RT enabled kernel.

Thanks,

        tglx

