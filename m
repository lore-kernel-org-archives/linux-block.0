Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11282C433EF
	for <linux-block@archiver.kernel.org>; Sun, 24 Apr 2022 09:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbiDXJ1c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Apr 2022 05:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiDXJ11 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Apr 2022 05:27:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F9E2191C71
        for <linux-block@vger.kernel.org>; Sun, 24 Apr 2022 02:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650792266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JAgucLjSIuQpNc/g/zxHb3hFwSBFGjjPn2wmfKQv2gQ=;
        b=hW9eWJdVb3HpIjd5Ib46g8IlpcX7NJBZPwpL8lW7yHEava6TrS8ID8Cyw8k29CvUjHPtmr
        P9LIqY7Nm/SOzLFor9pFoxToybEbneDv1W2GOW943987m73zhrTwMRfoYZHkNxtBcv5UOC
        /JCySpAQFU/2MoBjIzNn6UPcWSYdJjk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-WPWg4VslPeWbtdiwo19pHA-1; Sun, 24 Apr 2022 05:24:23 -0400
X-MC-Unique: WPWg4VslPeWbtdiwo19pHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF9E829AB3E3;
        Sun, 24 Apr 2022 09:24:22 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1076C40EC001;
        Sun, 24 Apr 2022 09:24:17 +0000 (UTC)
Date:   Sun, 24 Apr 2022 17:24:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>
Subject: Re: [PATCH V2 2/2] block: fix "Directory XXXXX with parent 'block'
 already present!"
Message-ID: <YmUXPA4EE5jOo1yz@T590>
References: <20220423143952.3162999-1-ming.lei@redhat.com>
 <20220423143952.3162999-3-ming.lei@redhat.com>
 <20220423162937.GA28340@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423162937.GA28340@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 23, 2022 at 06:29:37PM +0200, Christoph Hellwig wrote:
> On Sat, Apr 23, 2022 at 10:39:52PM +0800, Ming Lei wrote:
> > q->debugfs_dir is used by blk-mq debugfs and blktrace. The dentry is
> > created when adding disk, and removed when releasing request queue.
> > 
> > There is small window between releasing disk and releasing request
> > queue, and during the period, one disk with same name may be created
> > and added, so debugfs_create_dir() may complain with "Directory XXXXX
> > with parent 'block' already present!"
> > 
> > Fixes the issue by moving debugfs_create_dir() into blk_alloc_queue(),
> > and the dir name is named with q->id from beginning, and switched to
> > disk name when adding disk, and finally changed to q->id in disk_release().
> 
> As said before I very much think this is going in the wrong direction.

So far I'd suggest to keep q->debugfs_dir inside request queue, another
goodness is that we can use it for exposing non-blk qeueue's debug info,
and there is request queue without gendisk attached.

> 
> As the debugfs directory use the name of the gendisk, the lifetime rules
> should simply match those of the gendisk.  If anyone wants to trace
> SCSI commands sent before probing the gendisk or after removing it
> they can use blktrace on the /dev/sg node.

Not sure blktrace can trace on /dev/sg since blktrace works on
block_device.


Thanks, 
Ming

