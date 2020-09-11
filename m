Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20914C43461
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 16:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD182221EB
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 16:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ityv3gBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgIKQOM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:14:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20718 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726557AbgIKQOE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 12:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599840836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qkd0qL/BsnG+n++EK2rnb3Rk63sVV1+xI7kRBCebKvo=;
        b=ityv3gBIcJT+bsFAB+z1GBOUhgwandB93hywOYfNvhEJ7SzL96X+H36dP3N4Qo71FngYr9
        wWBsYhRos5JNGAB8JmjRU17VVdK0ydgdkgSQL/BiMKhoRVkfX9FwUP8GHI/tzl6JTWpGRg
        qSEBbF64COkIhcOD5iPu3lf7EnLHV0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-oxLFnuA6MbKQdp33KimbCw-1; Fri, 11 Sep 2020 12:13:52 -0400
X-MC-Unique: oxLFnuA6MbKQdp33KimbCw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89A751084C82;
        Fri, 11 Sep 2020 16:13:51 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F4CB5D9E8;
        Fri, 11 Sep 2020 16:13:45 +0000 (UTC)
Date:   Fri, 11 Sep 2020 12:13:45 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: Revert "dm: always call blk_queue_split() in dm_process_bio()"
Message-ID: <20200911161344.GA28614@redhat.com>
References: <529c2394-1b58-b9d8-d462-1f3de1b78ac8@oracle.com>
 <20200910142438.GA21919@redhat.com>
 <20200911122038.GA167338@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911122038.GA167338@T590>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 11 2020 at  8:20am -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> On Thu, Sep 10, 2020 at 10:24:39AM -0400, Mike Snitzer wrote:
> > [cc'ing dm-devel and linux-block because this is upstream concern too]
> > 
> > On Wed, Sep 09 2020 at  1:00pm -0400,
> > Vijayendra Suman <vijayendra.suman@oracle.com> wrote:
> > 
> > >    Hello Mike,
> > > 
> > >    While Running pgbench tool with  5.4.17 kernel build
> > > 
> > >    Following performance degrade is found out
> > > 
> > >    buffer read/write metric : -17.2%
> > >    cache read/write metric : -18.7%
> > >    disk read/write metric : -19%
> > > 
> > >    buffer
> > >    number of transactions actually processed: 840972
> > >    latency average = 24.013 ms
> > >    tps = 4664.153934 (including connections establishing)
> > >    tps = 4664.421492 (excluding connections establishing)
> > > 
> > >    cache
> > >    number of transactions actually processed: 551345
> > >    latency average = 36.949 ms
> > >    tps = 3031.223905 (including connections establishing)
> > >    tps = 3031.402581 (excluding connections establishing)
> > > 
> > >    After revert of Commit
> > >    2892100bc85ae446088cebe0c00ba9b194c0ac9d ( Revert "dm: always call
> > >    blk_queue_split() in dm_process_bio()")
> > 
> > I assume 2892100bc85ae446088cebe0c00ba9b194c0ac9d is 5.4-stable's
> > backport of upstream commit 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74 ?
> > 
> > >    Performance is Counter measurement
> > > 
> > >    buffer ->
> > >    number of transactions actually processed: 1135735
> > >    latency average = 17.799 ms
> > >    tps = 6292.586749 (including connections establishing)
> > >    tps = 6292.875089 (excluding connections establishing)
> > > 
> > >    cache ->
> > >    number of transactions actually processed: 648177
> > >    latency average = 31.217 ms
> > >    tps = 3587.755975 (including connections establishing)
> > >    tps = 3587.966359 (excluding connections establishing)
> > > 
> > >    Following is your commit
> > > 
> > >    diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > >    index cf71a2277d60..1e6e0c970e19 100644
> > >    --- a/drivers/md/dm.c
> > >    +++ b/drivers/md/dm.c
> > >    @@ -1760,8 +1760,9 @@ static blk_qc_t dm_process_bio(struct mapped_device
> > >    *md,
> > >             * won't be imposed.
> > >             */
> > >            if (current->bio_list) {
> > >    -               blk_queue_split(md->queue, &bio);
> > >    -               if (!is_abnormal_io(bio))
> > >    +               if (is_abnormal_io(bio))
> > >    +                       blk_queue_split(md->queue, &bio);
> > >    +               else
> > >                            dm_queue_split(md, ti, &bio);
> > >            }
> > > 
> > >    Could you have a look if it is safe to revert this commit.
> > 
> > No, it really isn't a good idea given what was documented in the commit
> > header for commit 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74 -- the
> > excessive splitting is not conducive to performance either.
> > 
> > So I think we need to identify _why_ reverting this commit is causing
> > such a performance improvement.  Why is calling blk_queue_split() before
> > dm_queue_split() benefiting your pgbench workload?
> 
> blk_queue_split() takes every queue's limit into account, and dm_queue_split()
> only splits bio according to max len(offset, chunk size), so the
> splitted bio may not be optimal one from device viewpoint.

Yes, but the issue is blk_queue_split() is doing the wrong thing for the
case described in the header for commit
120c9257f5f19e5d1e87efcbb5531b7cd81b7d74
 
> Maybe DM can switch to blk_queue_split() if 'chunk_sectors' limit is power-2
> aligned.

Not seeing relation to chunk_sectors being power of 2 -- other than that
is all block core supports.  But chunk_sectors isn't set for DM, you
added chunk_sectors for MD or something and DM was caught out, so
blk_queue_split() falls back to splitting on max_sectors.

You're saying DM should set 'chunk_sectors' IFF it'd be a power of 2?
While I could do that, it seems like just continuing a sequence of
hacks around earlier imposed chunk_sectors infrastructure that was a
half-measure to begin with.  Think chunk_sectors logic in block core
needs to be enhanced -- but I'll take a closer look.

Mike

