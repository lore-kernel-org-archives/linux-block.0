Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CCDC433F5
	for <linux-block@archiver.kernel.org>; Tue,  1 Mar 2022 00:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiCAA70 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Feb 2022 19:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiCAA7Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Feb 2022 19:59:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87AFCBD8BF
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 16:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646096324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k6qL3R8imhLm5OOCKmDBgZy5t3Vd+L/7gG3nuPx8IZI=;
        b=Lla2KSlB0R/1yG46Lt2cPI2HoahtYqouq61fa7Gg8jRmvElNyRcw2S7CMQBJlqpbXzL8JU
        FqtqbQC4Cu/965MLT2ApWvBOEpw5f/jpkULKyEqX+hSi0bHulmd6QMQBH552ZFjsDdafRd
        iKeO9PEdl885gARM3vXi/RBzZo7PpW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-aPwbxvBsOuOQXFLRfmfxbA-1; Mon, 28 Feb 2022 19:58:43 -0500
X-MC-Unique: aPwbxvBsOuOQXFLRfmfxbA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFDAD51DC;
        Tue,  1 Mar 2022 00:58:41 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 099DA5C3E2;
        Tue,  1 Mar 2022 00:58:25 +0000 (UTC)
Date:   Tue, 1 Mar 2022 08:58:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 0/3] block/dm: support bio polling
Message-ID: <Yh1vrWXlaTnEcrNd@T590>
References: <20210623074032.1484665-1-ming.lei@redhat.com>
 <Yhz4AGXcn0DUeSwq@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhz4AGXcn0DUeSwq@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 28, 2022 at 11:27:44AM -0500, Mike Snitzer wrote:
> On Wed, Jun 23 2021 at  3:40P -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > Hello Guys,
> > 
> > Based on Christoph's bio based polling model[1], implement DM bio polling
> > with one very simple approach.
> > 
> > Patch 1 adds helper of blk_queue_poll().
> > 
> > Patch 2 adds .bio_poll() callback to block_device_operations, so bio
> > driver can implement its own logic for io polling.
> > 
> > Patch 3 implements bio polling for device mapper.
> > 
> > 
> > V3:
> > 	- patch style change as suggested by Christoph(2/3)
> > 	- fix kernel panic issue caused by nested dm polling, which is found
> > 	  & figured out by Jeffle Xu (3/3)
> > 	- re-organize setup polling code (3/3)
> > 	- remove RFC
> > 
> > V2:
> > 	- drop patch to add new fields into bio
> > 	- support io polling for dm native bio splitting
> > 	- add comment
> > 
> > Ming Lei (3):
> >   block: add helper of blk_queue_poll
> >   block: add ->poll_bio to block_device_operations
> >   dm: support bio polling
> > 
> >  block/blk-core.c         |  18 +++---
> >  block/blk-sysfs.c        |   4 +-
> >  block/genhd.c            |   2 +
> >  drivers/md/dm-table.c    |  24 +++++++
> >  drivers/md/dm.c          | 131 ++++++++++++++++++++++++++++++++++++++-
> >  drivers/nvme/host/core.c |   2 +-
> >  include/linux/blkdev.h   |   2 +
> >  7 files changed, 170 insertions(+), 13 deletions(-)
> > 
> > -- 
> > 2.31.1
> > 
> 
> Hey Ming,
> 
> I'd like us to follow-through with adding bio-based polling support.
> Kind of strange none of us that were sent this V3 ever responded,
> sorry about that!
> 
> Do you have interest in rebasing this patchset (against linux-dm.git's
> "dm-5.18" branch since there has been quite some churn)?  Or are you
> OK with me doing the rebase?

Hi Mike,

Actually I have one local v5.17 rebase:

https://github.com/ming1/linux/tree/my_v5.17-dm-io-poll

Also one for-5.18/block rebase which is done just now:

https://github.com/ming1/linux/tree/my_v5.18-dm-bio-poll

In my previous test on v5.17 rebase, the IOPS improvement is a bit small,
so I didn't post it out. Recently not get time to investigate
the performance further, so please feel free to work on it.


Thanks,
Ming

