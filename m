Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD10FC38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 21:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9932C21655
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 21:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKTDYIBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgEHVuF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 17:50:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42155 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726811AbgEHVuF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 May 2020 17:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588974603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S7rsKhPQ76I9sc+0hqYQCZZQoCeQHSBJEn+RrCufunc=;
        b=eKTDYIBeMAiV4oPJaaNwG3lNSm+aFSx+WBYGQBjOrgNwwqbnjVYawJptxhlS6xFZZN/wn2
        X7ikrBJb/ZUF5orjbKfAMQyCNl9jO8gD19RaZYKrApmIX2cA03CPx6BbiP9YFxVC6rf2jO
        9ltrsCepmH0Q//pSyVO7/XVdAvIyOOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-gm75jjHjNt-UozZmeCqZ3w-1; Fri, 08 May 2020 17:50:00 -0400
X-MC-Unique: gm75jjHjNt-UozZmeCqZ3w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 473DB835B40;
        Fri,  8 May 2020 21:49:59 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7099825262;
        Fri,  8 May 2020 21:49:51 +0000 (UTC)
Date:   Sat, 9 May 2020 05:49:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V10 00/11] blk-mq: improvement CPU hotplug
Message-ID: <20200508214946.GB1389136@T590>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505020930.1146281-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 05, 2020 at 10:09:19AM +0800, Ming Lei wrote:
> Hi,
> 
> Thomas mentioned:
>     "
>      That was the constraint of managed interrupts from the very beginning:
>     
>       The driver/subsystem has to quiesce the interrupt line and the associated
>       queue _before_ it gets shutdown in CPU unplug and not fiddle with it
>       until it's restarted by the core when the CPU is plugged in again.
>     "
> 
> But no drivers or blk-mq do that before one hctx becomes inactive(all
> CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
> to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().
> 
> This patchset tries to address the issue by two stages:
> 
> 1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE
> 
> - mark the hctx as internal stopped, and drain all in-flight requests
> if the hctx is going to be dead.
> 
> 2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx becomes dead
> 
> - steal bios from the request, and resubmit them via generic_make_request(),
> then these IO will be mapped to other live hctx for dispatch
> 
> Thanks John Garry for running lots of tests on arm64 with this patchset
> and co-working on investigating all kinds of issues.
> 
> Thanks Christoph's review on V7 & V8.
> 
> Please comment & review, thanks!
> 
> https://github.com/ming1/linux/commits/v5.7-rc-blk-mq-improve-cpu-hotplug
> 
> V10:
> 	- fix double bio complete in request resubmission(10/11)
> 	- add tested-by tag
> 
> V9:
> 	- add Reviewed-by tag
> 	- document more on memory barrier usage between getting driver tag
> 	and handling cpu offline(7/11)
> 	- small code cleanup as suggested by Chritoph(7/11)
> 	- rebase against for-5.8/block(1/11, 2/11)
> V8:
> 	- add patches to share code with blk_rq_prep_clone
> 	- code re-organization as suggested by Christoph, most of them are
> 	in 04/11, 10/11
> 	- add reviewed-by tag
> 
> V7:
> 	- fix updating .nr_active in get_driver_tag
> 	- add hctx->cpumask check in cpuhp handler
> 	- only drain requests which tag is >= 0
> 	- pass more aggressive cpuhotplug&io test
> 
> V6:
> 	- simplify getting driver tag, so that we can drain in-flight
> 	  requests correctly without using synchronize_rcu()
> 	- handle re-submission of flush & passthrough request correctly
> 
> V5:
> 	- rename BLK_MQ_S_INTERNAL_STOPPED as BLK_MQ_S_INACTIVE
> 	- re-factor code for re-submit requests in cpu dead hotplug handler
> 	- address requeue corner case
> 
> V4:
> 	- resubmit IOs in dispatch list in case that this hctx is dead 
> 
> V3:
> 	- re-organize patch 2 & 3 a bit for addressing Hannes's comment
> 	- fix patch 4 for avoiding potential deadlock, as found by Hannes
> 
> V2:
> 	- patch4 & patch 5 in V1 have been merged to block tree, so remove
> 	  them
> 	- address comments from John Garry and Minwoo
> 
> Ming Lei (11):
>   block: clone nr_integrity_segments and write_hint in blk_rq_prep_clone
>   block: add helper for copying request
>   blk-mq: mark blk_mq_get_driver_tag as static
>   blk-mq: assign rq->tag in blk_mq_get_driver_tag
>   blk-mq: support rq filter callback when iterating rqs
>   blk-mq: prepare for draining IO when hctx's all CPUs are offline
>   blk-mq: stop to handle IO and drain IO before hctx becomes inactive
>   block: add blk_end_flush_machinery
>   blk-mq: add blk_mq_hctx_handle_dead_cpu for handling cpu dead
>   blk-mq: re-submit IO in case that hctx is inactive
>   block: deactivate hctx when the hctx is actually inactive
> 
>  block/blk-core.c           |  27 ++-
>  block/blk-flush.c          | 141 ++++++++++++---
>  block/blk-mq-debugfs.c     |   2 +
>  block/blk-mq-tag.c         |  39 ++--
>  block/blk-mq-tag.h         |   4 +
>  block/blk-mq.c             | 356 +++++++++++++++++++++++++++++--------
>  block/blk-mq.h             |  22 ++-
>  block/blk.h                |  11 +-
>  drivers/block/loop.c       |   2 +-
>  drivers/md/dm-rq.c         |   2 +-
>  include/linux/blk-mq.h     |   6 +
>  include/linux/cpuhotplug.h |   1 +
>  12 files changed, 481 insertions(+), 132 deletions(-)
> 
> Cc: John Garry <john.garry@huawei.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>

Hi Jens,

This patches have been worked and discussed for a while, so any chance
to make it in 5.8 if no any further comments?

Thanks,
Ming

