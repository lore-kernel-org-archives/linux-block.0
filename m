Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA880C433F5
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 09:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbiFAJII (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 05:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiFAJIH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 05:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D97C49F81
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 02:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654074485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C0Q4suk/UoFQZ19J300unXPjOTZm2BXXfZLKJoQ3ujY=;
        b=L6DeknknT9lp7GvwUn4mUxfnrQFtgwJI6QAzFUhqY5ptM40wC7wYqLfOCBBFbhwBeYdB/l
        rf3E+nkztg5PEmrpQdXjzIMhmVFezmP5ytSZ/Ih7WNM4kt0tGjMbLM4UMpRwtlzEOKo7Yz
        iXuM8XAMkmXeXeXCPri4tU3/5pwPEzg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-1vOFdGBsP2Cw5JsTtI9UMw-1; Wed, 01 Jun 2022 05:08:04 -0400
X-MC-Unique: 1vOFdGBsP2Cw5JsTtI9UMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0166A8032E5;
        Wed,  1 Jun 2022 09:08:04 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 90D982166B26;
        Wed,  1 Jun 2022 09:08:00 +0000 (UTC)
Date:   Wed, 1 Jun 2022 17:07:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        syzbot+3e3f419f4a7816471838@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: disable the elevator int del_gendisk
Message-ID: <YpcsaRDNN0LeVNny@T590>
References: <20220531160535.3444915-1-hch@lst.de>
 <Ypa4xrAHUslpQPhN@T590>
 <20220601064329.GB22915@lst.de>
 <YpcQpjUlX/CTORmp@T590>
 <20220601071429.GA24431@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601071429.GA24431@lst.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 01, 2022 at 09:14:29AM +0200, Christoph Hellwig wrote:
> On Wed, Jun 01, 2022 at 03:09:26PM +0800, Ming Lei wrote:
> > > Yes, we probably need a blk_mq_quiesce_queue call like in the incremental
> > > patch below.  Do you have any good reproducer, though?
> > 
> > blktests block/027 should cover this.
> 
> That did not trigger the problem for me.

This kind of issue is often not 100% duplicated.

> 
> > >  	if (q->elevator) {
> > > +		blk_mq_quiesce_queue(q);
> > > +
> > >  		mutex_lock(&q->sysfs_lock);
> > >  		elevator_exit(q);
> > >  		mutex_unlock(&q->sysfs_lock);
> > > +
> > > +		blk_mq_unquiesce_queue(q);
> > >  	}
> > >  
> > 
> > I am afraid the above way may slow down disk shutdown a lot, see
> > the following commit, that is also the reason why I moved it into disk
> > release handler, when any sync io submission are done.
> 
> SCSI devices that are just probed and never had a disk attached will
> not have q->elevator set and not hit this quiesce at all.

Yes, but host with hundreds of real LUNs may be shutdown slowly too
since sd_remove() won't be called in async way.


Thanks,
Ming

