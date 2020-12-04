Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786B9C433FE
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 02:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DAC222511
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 02:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgLDCFX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 21:05:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37535 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgLDCFX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Dec 2020 21:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607047436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qAzlATevKVsfS0B0Y6sohYhm6zY8rB2tZXdOJa1bHW4=;
        b=UUAvaFwBD58X5cX0lp8mOh+oFIgG9cIXDgH41e9enAJFhMJbUdLuW1PnIj5HZCwQOr+2Zi
        4De8NzGIfhrMvMRLS31RmjXPZm1FgjDAS3CtvfGOMXHIcvXQSlPpWXv7sEl8MsdP7yv599
        yaFPTg6znd/6ru9Yp24M7f7znGzTrQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-tObFgy7AOBWF6v7hg4Sacw-1; Thu, 03 Dec 2020 21:03:54 -0500
X-MC-Unique: tObFgy7AOBWF6v7hg4Sacw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80AED180A089;
        Fri,  4 Dec 2020 02:03:53 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 305FE620D7;
        Fri,  4 Dec 2020 02:03:44 +0000 (UTC)
Date:   Thu, 3 Dec 2020 21:03:43 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        jdorminy@redhat.com, bjohnsto@redhat.com
Subject: Re: [PATCH v2] block: use gcd() to fix chunk_sectors limit stacking
Message-ID: <20201204020343.GA32150@redhat.com>
References: <20201130171805.77712-1-snitzer@redhat.com>
 <20201201160709.31748-1-snitzer@redhat.com>
 <20201203032608.GD540033@T590>
 <20201203143359.GA29261@redhat.com>
 <20201204011243.GB661914@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204011243.GB661914@T590>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 03 2020 at  8:12pm -0500,
Ming Lei <ming.lei@redhat.com> wrote:

> On Thu, Dec 03, 2020 at 09:33:59AM -0500, Mike Snitzer wrote:
> > On Wed, Dec 02 2020 at 10:26pm -0500,
> > Ming Lei <ming.lei@redhat.com> wrote:
> > 
> > > On Tue, Dec 01, 2020 at 11:07:09AM -0500, Mike Snitzer wrote:
> > > > commit 22ada802ede8 ("block: use lcm_not_zero() when stacking
> > > > chunk_sectors") broke chunk_sectors limit stacking. chunk_sectors must
> > > > reflect the most limited of all devices in the IO stack.
> > > > 
> > > > Otherwise malformed IO may result. E.g.: prior to this fix,
> > > > ->chunk_sectors = lcm_not_zero(8, 128) would result in
> > > > blk_max_size_offset() splitting IO at 128 sectors rather than the
> > > > required more restrictive 8 sectors.
> > > 
> > > What is the user-visible result of splitting IO at 128 sectors?
> > 
> > The VDO dm target fails because it requires IO it receives to be split
> > as it advertised (8 sectors).
> 
> OK, looks VDO's chunk_sector limit is one hard constraint, even though it
> is one DM device, so I guess you are talking about DM over VDO?
> 
> Another reason should be that VDO doesn't use blk_queue_split(), otherwise it
> won't be a trouble, right?
> 
> Frankly speaking, if the stacking driver/device has its own hard queue limit
> like normal hardware drive, the driver should be responsible for the splitting.

DM core does the splitting for VDO (just like any other DM target).
In 5.9 I updated DM to use chunk_sectors, use blk_stack_limits()
stacking of it, and also use blk_max_size_offset().

But all that block core code has shown itself to be too rigid for DM.  I
tried to force the issue by stacking DM targets' ti->max_io_len with
chunk_sectors.  But really I'd need to be able to pass in the per-target
max_io_len to blk_max_size_offset() to salvage using it.

Stacking chunk_sectors seems ill-conceived.  One size-fits-all splitting
is too rigid.

> > > I understand it isn't related with correctness, because the underlying
> > > queue can split by its own chunk_sectors limit further. So is the issue
> > > too many further-splitting on queue with chunk_sectors 8? then CPU
> > > utilization is increased? Or other issue?
> > 
> > No, this is all about correctness.
> > 
> > Seems you're confining the definition of the possible stacking so that
> > the top-level device isn't allowed to have its own hard requirements on
> 
> I just don't know this story, thanks for your clarification.
> 
> As I mentioned above, if the stacking driver has its own hard queue
> limit, it should be the driver's responsibility to respect it via
> blk_queue_split() or whatever.

Again, DM does its own splitting... that aspect of it isn't an issue.
The problem is the basis for splitting cannot be the stacked up
chunk_sectors.

Mike

