Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C2DC04EB9
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 21:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F9321019
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 21:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F9321019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeK3JEq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:04:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeK3JEp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 04:04:45 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD6576EB87;
        Thu, 29 Nov 2018 21:57:52 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67DBA19743;
        Thu, 29 Nov 2018 21:57:47 +0000 (UTC)
Date:   Thu, 29 Nov 2018 16:57:47 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, "Alasdair G. Kergon" <agk@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/3] block: switch to per-cpu in-flight counters
Message-ID: <20181129215746.GA9226@redhat.com>
References: <20181128004250.325095242@debian.vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128004250.325095242@debian.vm>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 29 Nov 2018 21:57:52 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 27 2018 at  7:42pm -0500,
Mikulas Patocka <mpatocka@redhat.com> wrote:

> Now when part_round_stats is gone, we can switch to per-cpu in-flight
> counters.
> 
> We use the local-atomic type local_t, so that if part_inc_in_flight or
> part_dec_in_flight is reentrantly called from an interrupt, the value will
> be correct.
> 
> The other counters could be corrupted due to reentrant interrupt, but the
> corruption only results in slight counter skew - the in_flight counter
> must be exact, so it needs local_t.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> ---
>  block/bio.c           |    4 ++--
>  block/blk-core.c      |    4 ++--
>  block/blk-merge.c     |    2 +-
>  block/genhd.c         |   47 +++++++++++++++++++++++++++++++++++------------
>  drivers/md/dm.c       |    4 +---
>  include/linux/genhd.h |    7 ++++---
>  6 files changed, 45 insertions(+), 23 deletions(-)
> 
...
> Index: linux-block/drivers/md/dm.c
> ===================================================================
> --- linux-block.orig/drivers/md/dm.c	2018-11-28 00:09:59.000000000 +0100
> +++ linux-block/drivers/md/dm.c	2018-11-28 00:09:59.000000000 +0100
> @@ -663,8 +663,7 @@ static void start_io_acct(struct dm_io *
>  	generic_start_io_acct(md->queue, bio_op(bio), bio_sectors(bio),
>  			      &dm_disk(md)->part0);
>  
> -	atomic_set(&dm_disk(md)->part0.in_flight[rw],
> -		   atomic_inc_return(&md->pending[rw]));
> +	atomic_inc(&md->pending[rw]);
>  
>  	if (unlikely(dm_stats_used(&md->stats)))
>  		dm_stats_account_io(&md->stats, bio_data_dir(bio),
> @@ -693,7 +692,6 @@ static void end_io_acct(struct dm_io *io
>  	 * a flush.
>  	 */
>  	pending = atomic_dec_return(&md->pending[rw]);
> -	atomic_set(&dm_disk(md)->part0.in_flight[rw], pending);
>  	pending += atomic_read(&md->pending[rw^0x1]);
>  
>  	/* nudge anyone waiting on suspend queue */
> 


These dm.c hunks conflict with changes from you that I already staged in
dm-4.21, see:

https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-4.21&id=b5616f7a11592cc74860f4ec3e3c4fba6688eefa
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-4.21&id=78f95b53c203c969bbe6b86e405f7a891a43b6be

I'd really like to get away from DM maintaining its own ->pending
counters.

Mike
