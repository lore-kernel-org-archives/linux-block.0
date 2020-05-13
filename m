Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BABC2D0FA
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 10:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 142C3206CC
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 10:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtIHZhP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgEMKh7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 06:37:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36089 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727812AbgEMKh6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 06:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589366277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gdNC0ty3ENMOdTGk98VyHoz+Z4ST5QAHRtJjWFzl0as=;
        b=VtIHZhP96o9QxTunEQ9mIky+HF5V/IZprqN37CROj3W0wi/dwz09oqQs2X2qQqVkhMES4C
        NRlo7DBsF9Y4hy3BJxFDVOPrRfMPdd97F0FtArXqsjydzILUKV6ZmF7a4exgf/u1KBG/RW
        SKYHOMUwqhudHytsKpxKP4OlY47ehe8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-hGiUDzVHOxeiJZVg5wFrsw-1; Wed, 13 May 2020 06:37:54 -0400
X-MC-Unique: hGiUDzVHOxeiJZVg5wFrsw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 283A1461;
        Wed, 13 May 2020 10:37:53 +0000 (UTC)
Received: from T590 (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D1765D9C5;
        Wed, 13 May 2020 10:37:47 +0000 (UTC)
Date:   Wed, 13 May 2020 18:37:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH V11 00/12] blk-mq: improvement CPU hotplug
Message-ID: <20200513103743.GC2038938@T590>
References: <20200513034803.1844579-1-ming.lei@redhat.com>
 <2b4b0a75-c9c0-27de-77e8-85ada602b18f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b4b0a75-c9c0-27de-77e8-85ada602b18f@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 08:34:01AM +0100, John Garry wrote:
> On 13/05/2020 04:47, Ming Lei wrote:
> > Hi,
> > 
> > Thomas mentioned:
> >      "
> >       That was the constraint of managed interrupts from the very beginning:
> >        The driver/subsystem has to quiesce the interrupt line and the associated
> >        queue _before_ it gets shutdown in CPU unplug and not fiddle with it
> >        until it's restarted by the core when the CPU is plugged in again.
> >      "
> > 
> > But no drivers or blk-mq do that before one hctx becomes inactive(all
> > CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
> > to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().
> > 
> > This patchset tries to address the issue by two stages:
> > 
> > 1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE
> > 
> > - mark the hctx as internal stopped, and drain all in-flight requests
> > if the hctx is going to be dead.
> > 
> > 2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx becomes dead
> > 
> > - steal bios from the request, and resubmit them via generic_make_request(),
> > then these IO will be mapped to other live hctx for dispatch
> > 
> > Thanks John Garry for running lots of tests on arm64 with this patchset
> > and co-working on investigating all kinds of issues.
> > 
> > Thanks Christoph's review on V7 & V8.
> > 
> > Please consider it for v5.8.
> > 
> > https://github.com/ming1/linux/commits/v5.7-rc-blk-mq-improve-cpu-hotplug
> > 
> > V11:
> > 	- drop new callback from blk_mq_all_tag_busy_iter, add new helper
> > 	of blk_mq_all_tag_iter (5/12), as suggested by Bart
> > 	- fix request allocation hang in case of queue freeze(11/12), as
> > 	reported by Bart
> > 
> > V10:
> > 	- fix double bio complete in request resubmission(10/11)
> > 	- add tested-by tag
> > 
> > V9:
> > 	- add Reviewed-by tag
> > 	- document more on memory barrier usage between getting driver tag
> > 	and handling cpu offline(7/11)
> > 	- small code cleanup as suggested by Chritoph(7/11)
> > 	- rebase against for-5.8/block(1/11, 2/11)
> > V8:
> > 	- add patches to share code with blk_rq_prep_clone
> > 	- code re-organization as suggested by Christoph, most of them are
> > 	in 04/11, 10/11
> > 	- add reviewed-by tag
> > 
> > V7:
> > 	- fix updating .nr_active in get_driver_tag
> > 	- add hctx->cpumask check in cpuhp handler
> > 	- only drain requests which tag is >= 0
> > 	- pass more aggressive cpuhotplug&io test
> > 
> > V6:
> > 	- simplify getting driver tag, so that we can drain in-flight
> > 	  requests correctly without using synchronize_rcu()
> > 	- handle re-submission of flush & passthrough request correctly
> > 
> > V5:
> > 	- rename BLK_MQ_S_INTERNAL_STOPPED as BLK_MQ_S_INACTIVE
> > 	- re-factor code for re-submit requests in cpu dead hotplug handler
> > 	- address requeue corner case
> > 
> > V4:
> > 	- resubmit IOs in dispatch list in case that this hctx is dead
> > 
> > V3:
> > 	- re-organize patch 2 & 3 a bit for addressing Hannes's comment
> > 	- fix patch 4 for avoiding potential deadlock, as found by Hannes
> > 
> > V2:
> > 	- patch4 & patch 5 in V1 have been merged to block tree, so remove
> > 	  them
> > 	- address comments from John Garry and Minwoo
> > 
> > 
> > *** BLURB HERE ***
> 
> :)
> 
> So my tested-by tags have been dropped. I'll test again, since the changes
> are non-trivial.
> 
> Tip commit of
> https://github.com/ming1/linux/commits/v5.7-rc-blk-mq-improve-cpu-hotplug at
> this moment is b55e97a4

Hi John,

I just sent out V12 of patch 10/12, which can kill the warning on BLK_MQ_REQ_FORCE,
and the warning is harmless actually. And the above git branch has been
updated too.

Please retest and update with us.

Thanks, 
Ming

