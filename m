Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EB6C33C99
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 10:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E052081E
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 10:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/E2JMFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgAGKgC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:36:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43586 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726558AbgAGKgC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Jan 2020 05:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578393360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FfN1P6ZObu9SrbzlwvpLv9bwkLap5FviWZtNgAzWxvY=;
        b=O/E2JMFGoGCNJ/F4Q5DxlSPBY3qPv1zXlQh2+b+gh785x/irlCykT2+ud/AVXSup2H3KL+
        6wgYNnoIcMXWQqePQ1x5Zn60G0RZYgK7Pq5yzmVWTOtmPazi+yeI+PSafyDmZ53506ZncF
        SEk6bUZIbB5Ena1BQGpAEacCusi7/To=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-vVUkVBscNsCxSx74nvAwjA-1; Tue, 07 Jan 2020 05:35:57 -0500
X-MC-Unique: vVUkVBscNsCxSx74nvAwjA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DB9A800D4C;
        Tue,  7 Jan 2020 10:35:56 +0000 (UTC)
Received: from localhost (unknown [10.33.36.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43B6D1C4;
        Tue,  7 Jan 2020 10:35:46 +0000 (UTC)
Date:   Tue, 7 Jan 2020 10:35:46 +0000
From:   Joe Thornber <thornber@redhat.com>
To:     LVM2 development <lvm-devel@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, markus.schade@gmail.com,
        ejt@redhat.com, linux-block@vger.kernel.org, dm-devel@redhat.com,
        joe.thornber@gmail.com
Subject: Re: [lvm-devel] [dm-devel] kernel BUG at
 drivers/md/persistent-data/dm-space-map-disk.c:178
Message-ID: <20200107103546.asf4tmlfdmk6xsub@reti>
Mail-Followup-To: LVM2 development <lvm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, markus.schade@gmail.com,
        ejt@redhat.com, linux-block@vger.kernel.org, dm-devel@redhat.com,
        joe.thornber@gmail.com
References: <alpine.LRH.2.11.1909251814220.15810@mx.ewheeler.net>
 <alpine.LRH.2.11.1912201829300.26683@mx.ewheeler.net>
 <alpine.LRH.2.11.1912270137420.26683@mx.ewheeler.net>
 <alpine.LRH.2.11.1912271946380.26683@mx.ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.11.1912271946380.26683@mx.ewheeler.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Dec 28, 2019 at 02:13:07AM +0000, Eric Wheeler wrote:
> On Fri, 27 Dec 2019, Eric Wheeler wrote:

> > Just hit the bug again without mq-scsi (scsi_mod.use_blk_mq=n), all other 
> > times MQ has been turned on. 
> > 
> > I'm trying the -ENOSPC hack which will flag the pool as being out of space 
> > so I can recover more gracefully than a BUG_ON. Here's a first-draft 
> > patch, maybe the spinlock will even prevent the issue.
> > 
> > Compile tested, I'll try on a real system tomorrow.
> > 
> > Comments welcome:

Both sm_ll_find_free_block() and sm_ll_inc() can trigger synchronous IO.  So you
absolutely cannot use a spin lock.

dm_pool_alloc_data_block() holds a big rw semaphore which should prevent anything
else trying to allocate at the same time.

- Joe

