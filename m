Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD24C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 09:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490A3223DD
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 09:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490A3223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeKNTi0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:38:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbeKNTi0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 14:38:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64A71307A281;
        Wed, 14 Nov 2018 09:35:58 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B73B60BF7;
        Wed, 14 Nov 2018 09:35:50 +0000 (UTC)
Date:   Wed, 14 Nov 2018 17:35:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 2/4] blk-mq: fix issue directly case when q is stopped
 or quiesced
Message-ID: <20181114093544.GD20550@ming.t460p>
References: <1542185131-15029-1-git-send-email-jianchao.w.wang@oracle.com>
 <1542185131-15029-3-git-send-email-jianchao.w.wang@oracle.com>
 <20181114092022.GC20550@ming.t460p>
 <6b29fb1a-31bc-ac3e-cdbd-80b2a9c95e11@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b29fb1a-31bc-ac3e-cdbd-80b2a9c95e11@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 14 Nov 2018 09:35:58 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 05:29:54PM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 11/14/18 5:20 PM, Ming Lei wrote:
> > On Wed, Nov 14, 2018 at 04:45:29PM +0800, Jianchao Wang wrote:
> >> When try to issue request directly, if the queue is stopped or
> >> quiesced, 'bypass' will be ignored and return BLK_STS_OK to caller
> >> to avoid it dispatch request again. Then the request will be
> >> inserted with blk_mq_sched_insert_request. This is not correct
> >> for dm-rq case where we should avoid to pass through the underlying
> >> path's io scheduler.
> >>
> >> To fix it, use blk_mq_request_bypass_insert to insert the request
> >> to hctx->dispatch when we cannot pass through io scheduler but have
> >> to insert.
> > 
> > Not sure if the current behaviour is wrong, or worth of a fix.
> > 
> > Bypassing io scheduler for dm-rq is only for sake of performance
> > because there has been io scheduler for dm device already, and we
> > just don't want to schedule these requests twice.
> 
> As comment of commit 157f377beb710e84bd8bc7a3c4475c0674ebebd7
> (block: directly insert blk-mq request from blk_insert_cloned_request())
> 
>     All said, a request-based DM multipath device's IO scheduler should be
>     the only one used -- when the original requests are issued to the
>     underlying paths as cloned requests they are inserted directly in the
>     underlying dispatch queue(s) rather than through an additional elevator.
>     
>     But commit bd166ef18 ("blk-mq-sched: add framework for MQ capable IO
>     schedulers") switched blk_insert_cloned_request() from using
>     blk_mq_insert_request() to blk_mq_sched_insert_request().  Which
>     incorrectly added elevator machinery into a call chain that isn't
>     supposed to have any.
> 
> It sounds like a wrong action.

As I mentioned, it is only for the sake of performance, and IO scheduler
has to be supported on these devices too, for example, one partition may
be under dm-rq, and another partition can be accessed directly.

However, you are fixing the handling when queue is quiesced or stopped.
Under this situation, it is fine to put requests into scheduler queue,
given no performance need to be worried.

Thanks,
Ming
