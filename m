Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F70FC43334
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 11:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiFNL2P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 07:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiFNL2O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 07:28:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82720393CC
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 04:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655206092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KvXmd4bdqtEG9mUnG5cWrQk4WL5cMwLqoDvFzCaXz38=;
        b=FkRVsJiOdhj4H6mCtHdX/ZyJhsnrVNTgR7iTBEpF+NpAzm93MK5qaiXf83WuEvj+bU0kdT
        Drye+Hq6mNVeCo4MuNXm0I7mXTD7J9W2451H0IWGTF/TZatqi0PVto+/GDCnyau9JMjGtO
        3xs16tJ7WbeoWhebEN+8BY7RqPADn08=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-EdLcKhXjNzakwlxRVEPf8g-1; Tue, 14 Jun 2022 07:28:09 -0400
X-MC-Unique: EdLcKhXjNzakwlxRVEPf8g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B408529ABA38;
        Tue, 14 Jun 2022 11:28:08 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A86CB492CA2;
        Tue, 14 Jun 2022 11:28:04 +0000 (UTC)
Date:   Tue, 14 Jun 2022 19:27:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, shinichiro.kawasaki@wdc.com,
        dan.j.williams@intel.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org,
        syzbot+3e3f419f4a7816471838@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/4] block: disable the elevator int del_gendisk
Message-ID: <Yqhwv0POjMi1TNo3@T590>
References: <20220614074827.458955-1-hch@lst.de>
 <20220614074827.458955-2-hch@lst.de>
 <YqhFiDx0/IW25bSp@T590>
 <20220614083453.GA6999@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614083453.GA6999@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 14, 2022 at 10:34:53AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 14, 2022 at 04:23:36PM +0800, Ming Lei wrote:
> > >  	blk_sync_queue(q);
> > >  	blk_flush_integrity();
> > > +	blk_mq_cancel_work_sync(q);
> > > +
> > > +	blk_mq_quiesce_queue(q);
> > 
> > quiesce queue adds a bit long delay in del_gendisk, not sure if this way may
> > cause regression in big machines with lots of disks.
> 
> It does.  But at least we remove a freeze in the queue teardown path.
> But either way I'd really like to get things correct first before
> looking into optimizations.

The removed one works at atomic mode and it is super fast.

> 
> > 
> > > +	if (q->elevator) {
> > > +		mutex_lock(&q->sysfs_lock);
> > > +		elevator_exit(q);
> > > +		mutex_unlock(&q->sysfs_lock);
> > > +	}
> > > +	rq_qos_exit(q);
> > > +	blk_mq_unquiesce_queue(q);
> > 
> > Also tearing down elevator here has to be carefully, that means any
> > elevator reference has to hold rcu read lock or .q_usage_counter,
> > meantime it has to be checked, otherwise use-after-free may be caused.
> 
> This is not a new pattern.  We have the same locking here as a
> sysfs-induced change of the elevator to none which also clears
> q->elevator under a queue that is frozen and quiesced.

Then looks this pattern has problem in dealing with the examples I
mentioned.

And the elevator usage in __blk_mq_update_nr_hw_queues() looks one
old problem, but easy to fix by protecting it via sysfs_lock.

And fixing blk_mq_has_sqsched() should be easy too.

I will send patches later.


Thanks,
Ming

