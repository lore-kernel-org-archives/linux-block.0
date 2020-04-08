Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2730AC2D0EA
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 13:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3422072A
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 13:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XR4Vc5MY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgDHNZd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 09:25:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37773 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726996AbgDHNZc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Apr 2020 09:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586352331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zDl0FPyf+TJnkDDNfbthzsHje6rZEWm6xfpX838XKG4=;
        b=XR4Vc5MYntFPzCRlVg+KQZvtfFqLkG9J2AU1Cp1UlVCqW8x7MHplyM8lUKXMZWQfoTP5Eg
        bJtOB0Q3yViH5mt4P0L5RGJASLy95hUn2nnTsOc2DPhnNtohEuXcYuDkmoa6KJKhT80DfY
        do2LsdDTS8fKv/1bjBP/rf5YND3yKv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-xG1gdfvVOWWaOe9xKp7X8g-1; Wed, 08 Apr 2020 09:25:27 -0400
X-MC-Unique: xG1gdfvVOWWaOe9xKp7X8g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BA4810CE783;
        Wed,  8 Apr 2020 13:25:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E67A338D;
        Wed,  8 Apr 2020 13:25:18 +0000 (UTC)
Date:   Wed, 8 Apr 2020 21:25:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V6 0/8] blk-mq: improvement CPU hotplug
Message-ID: <20200408132513.GA366654@localhost.localdomain>
References: <20200407092901.314228-1-ming.lei@redhat.com>
 <20200408124017.g6wizq5bljzwb2gq@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408124017.g6wizq5bljzwb2gq@beryllium.lan>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Daniel,

On Wed, Apr 08, 2020 at 02:40:17PM +0200, Daniel Wagner wrote:
> Hi Ming,
> 
> On Tue, Apr 07, 2020 at 05:28:53PM +0800, Ming Lei wrote:
> > Hi,
> > 
> > Thomas mentioned:
> >     "
> >      That was the constraint of managed interrupts from the very beginning:
> >     
> >       The driver/subsystem has to quiesce the interrupt line and the associated
> >       queue _before_ it gets shutdown in CPU unplug and not fiddle with it
> >       until it's restarted by the core when the CPU is plugged in again.
> >     "
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
> > Please comment & review, thanks!
> 
> FWIW, I've stress test this series by running the stress-cpu-hotplug
> with a fio workload in the background. Nothing exploded, all just
> worked fine.

Thanks for your test!

Especially this patch changes flush & passthrough IO handling during
CPU hotplug, if possible, please include the two kinds of background IO
when running cpu hotplug test.

BTW, I verified the patches by running 'dbench -s 64' & concurrent NVMe
user IO during cpu hotplug, looks it works fine.

Also there is one known performance drop issue reported by John, which has
been addressed in the following link:

https://github.com/ming1/linux/commit/1cfbe1b2f7fd7085bc86e09c6443a20e89142975


Thanks,
Ming

