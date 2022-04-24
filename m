Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC06C433EF
	for <linux-block@archiver.kernel.org>; Sun, 24 Apr 2022 09:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbiDXJbs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Apr 2022 05:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbiDXJbr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Apr 2022 05:31:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 187E8E90
        for <linux-block@vger.kernel.org>; Sun, 24 Apr 2022 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650792526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vMSiVwA+g8kZT9Onc9g6xp9QWkuJh2EYuju/9bThKS4=;
        b=Xs7HeplPYFXag//aPMp33NS4XY3KispuCHoFnW1obxqR4RGCWwiauhW/I36YFWzMaHv+gZ
        7RFW3kFWpi29OsJGGzocsHUod4olN28QzN9xH8VxSfo/wDQazNWEICdyG2LxLXyX+eKCIf
        edHhtKRPI4rpM6CIsMFM6g8EsbkgAD8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-f2PAO2GBNwi8W5I18EkOPw-1; Sun, 24 Apr 2022 05:28:45 -0400
X-MC-Unique: f2PAO2GBNwi8W5I18EkOPw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9DFE3806709;
        Sun, 24 Apr 2022 09:28:40 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B315E4538B0;
        Sun, 24 Apr 2022 09:28:35 +0000 (UTC)
Date:   Sun, 24 Apr 2022 17:28:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>
Subject: Re: [PATCH V2 2/2] block: fix "Directory XXXXX with parent 'block'
 already present!"
Message-ID: <YmUX/Q9o08rOSTaQ@T590>
References: <20220423143952.3162999-1-ming.lei@redhat.com>
 <20220423143952.3162999-3-ming.lei@redhat.com>
 <68e17ba8-24ec-5b60-d52e-18d41f91892c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68e17ba8-24ec-5b60-d52e-18d41f91892c@suse.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 24, 2022 at 10:53:29AM +0200, Hannes Reinecke wrote:
> On 4/23/22 16:39, Ming Lei wrote:
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
> > 
> > Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Reported-by: Dan Williams <dan.j.williams@intel.com>
> > Cc: yukuai (C) <yukuai3@huawei.com>
> > Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/blk-core.c  | 4 ++++
> >   block/blk-sysfs.c | 4 ++--
> >   block/genhd.c     | 8 ++++++++
> >   3 files changed, 14 insertions(+), 2 deletions(-)
> > 
> Errm.
> 
> Isn't this superfluous now that Jens merged Yu Kuais patch?

Jens has dropped Yu Kuai's patch which caused kernel panic.


Thanks,
Ming

