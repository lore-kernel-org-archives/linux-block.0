Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F26FC33C99
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 10:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F272077B
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 10:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1x16H/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgAGKqm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:46:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40217 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727177AbgAGKqm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Jan 2020 05:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578394000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CEFARvfwrj+3xddAi+LfA27F6qgD07yRQQzviQn+UGo=;
        b=P1x16H/OR3q8pvP3P02QBSWRoA3hYVUSFLK7f/xCmQHZ3S2qIo4KdaqJS7UXd/EpyN8Miz
        FIK12M2IFNzWPNw+6uiQagcOAF4GAfYuhV8PIaLDX0cjnmtYXg7diZZfvIvURjCrqx+rz5
        4F12+7OXwTl2Owk6BtZSBZbLo5Y3Bgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-52Wu0-tNOUq8-rPrKqSzFQ-1; Tue, 07 Jan 2020 05:46:39 -0500
X-MC-Unique: 52Wu0-tNOUq8-rPrKqSzFQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34C45107ACC5;
        Tue,  7 Jan 2020 10:46:38 +0000 (UTC)
Received: from localhost (unknown [10.33.36.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2B6060BE2;
        Tue,  7 Jan 2020 10:46:28 +0000 (UTC)
Date:   Tue, 7 Jan 2020 10:46:27 +0000
From:   Joe Thornber <thornber@redhat.com>
To:     LVM2 development <lvm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, markus.schade@gmail.com,
        ejt@redhat.com, linux-block@vger.kernel.org, dm-devel@redhat.com,
        joe.thornber@gmail.com
Subject: Re: [lvm-devel] [dm-devel] kernel BUG at
 drivers/md/persistent-data/dm-space-map-disk.c:178
Message-ID: <20200107104627.plviq37qhok2igt4@reti>
Mail-Followup-To: LVM2 development <lvm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, markus.schade@gmail.com,
        ejt@redhat.com, linux-block@vger.kernel.org, dm-devel@redhat.com,
        joe.thornber@gmail.com
References: <alpine.LRH.2.11.1909251814220.15810@mx.ewheeler.net>
 <alpine.LRH.2.11.1912201829300.26683@mx.ewheeler.net>
 <alpine.LRH.2.11.1912270137420.26683@mx.ewheeler.net>
 <alpine.LRH.2.11.1912271946380.26683@mx.ewheeler.net>
 <20200107103546.asf4tmlfdmk6xsub@reti>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107103546.asf4tmlfdmk6xsub@reti>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 07, 2020 at 10:35:46AM +0000, Joe Thornber wrote:
> On Sat, Dec 28, 2019 at 02:13:07AM +0000, Eric Wheeler wrote:
> > On Fri, 27 Dec 2019, Eric Wheeler wrote:
> 
> > > Just hit the bug again without mq-scsi (scsi_mod.use_blk_mq=n), all other 
> > > times MQ has been turned on. 
> > > 
> > > I'm trying the -ENOSPC hack which will flag the pool as being out of space 
> > > so I can recover more gracefully than a BUG_ON. Here's a first-draft 
> > > patch, maybe the spinlock will even prevent the issue.
> > > 
> > > Compile tested, I'll try on a real system tomorrow.
> > > 
> > > Comments welcome:
> 
> Both sm_ll_find_free_block() and sm_ll_inc() can trigger synchronous IO.  So you
> absolutely cannot use a spin lock.
> 
> dm_pool_alloc_data_block() holds a big rw semaphore which should prevent anything
> else trying to allocate at the same time.

I suspect the problem is to do with the way we search for the new block in the 
space map for the previous transaction (sm->old_ll), and then increment in the current
transaction (sm->ll).

We keep old_ll around so we can ensure we never (re) allocate a block that's used in
the previous transaction.  This gives us our crash resistance, since if anything goes
wrong we effectively rollback to the previous transaction.

What I think we should be doing is running find_free on the old_ll, then double checking
it's not actually used in the current transaction.  ATM we're relying on smd->begin being
set properly everywhere, and I suspect this isn't the case.  A quick look shows sm_disk_inc_block()
doesn't adjust it.  sm_disk_inc_block() can be called when breaking sharing of a neighbouring entry
in a leaf btree node ... and we know you use snapshots very heavily.

I'll get a patch to you later today.

- Joe

