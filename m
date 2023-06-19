Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA9DEB64D9
	for <linux-block@archiver.kernel.org>; Mon, 19 Jun 2023 10:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjFSKPR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jun 2023 06:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjFSKOt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2023 06:14:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E0FE58;
        Mon, 19 Jun 2023 03:14:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6990960A50;
        Mon, 19 Jun 2023 10:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F55C433C9;
        Mon, 19 Jun 2023 10:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687169684;
        bh=Zuhm6jIOghtFuLke9BGwHGq/HQJPt6fx2PoAZUwJ/dY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SrqOeppkzCsYtK6/tBsxdHf1MJpIjnQx2PcC4vKdLNXI1R+pc9g154gfmQQeIms+C
         GsoEQZ8qeeheT8PBmAltXFzKi+oUKJ5f9oGsD76MR31Qj+Kdx+vEMdmTIOb9+W/Zjo
         kYpSBgKoTW7c0lLJ5sO6C/EHRXHtq4LNTFYKovj0=
Date:   Mon, 19 Jun 2023 12:14:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jay Shin <jaeshin@redhat.com>,
        Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>,
        mkoutny@suse.com, Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH 6.3.y] blk-cgroup: Flush stats before releasing blkcg_gq
Message-ID: <2023061933-corporate-overkill-e24a@gregkh>
References: <20230619083009.743135-1-ming.lei@redhat.com>
 <2023061901-fleshed-patrol-afc4@gregkh>
 <ZJAd0xNvx99haE6y@ovpn-8-18.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJAd0xNvx99haE6y@ovpn-8-18.pek2.redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 19, 2023 at 05:20:19PM +0800, Ming Lei wrote:
> On Mon, Jun 19, 2023 at 10:51:16AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jun 19, 2023 at 04:30:09PM +0800, Ming Lei wrote:
> > > As noted by Michal, the blkg_iostat_set's in the lockless list hold
> > > reference to blkg's to protect against their removal. Those blkg's
> > > hold reference to blkcg. When a cgroup is being destroyed,
> > > cgroup_rstat_flush() is only called at css_release_work_fn() which
> > > is called when the blkcg reference count reaches 0. This circular
> > > dependency will prevent blkcg and some blkgs from being freed after
> > > they are made offline.
> > > 
> > > It is less a problem if the cgroup to be destroyed also has other
> > > controllers like memory that will call cgroup_rstat_flush() which will
> > > clean up the reference count. If block is the only controller that uses
> > > rstat, these offline blkcg and blkgs may never be freed leaking more
> > > and more memory over time.
> > > 
> > > To prevent this potential memory leak:
> > > 
> > > - flush blkcg per-cpu stats list in __blkg_release(), when no new stat
> > > can be added
> > > 
> > > - add global blkg_stat_lock for covering concurrent parent blkg stat
> > > update
> > > 
> > > - don't grab bio->bi_blkg reference when adding the stats into blkcg's
> > > per-cpu stat list since all stats are guaranteed to be consumed before
> > > releasing blkg instance, and grabbing blkg reference for stats was the
> > > most fragile part of original patch
> > > 
> > > Based on Waiman's patch:
> > > 
> > > https://lore.kernel.org/linux-block/20221215033132.230023-3-longman@redhat.com/
> > > 
> > > Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Jay Shin <jaeshin@redhat.com>
> > > Acked-by: Tejun Heo <tj@kernel.org>
> > > Cc: Waiman Long <longman@redhat.com>
> > > Cc: mkoutny@suse.com
> > > Cc: Yosry Ahmed <yosryahmed@google.com>
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > Link: https://lore.kernel.org/r/20230609234249.1412858-1-ming.lei@redhat.com
> > > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > > ---
> > > Context difference with linus tree: 2c275afeb61d ("block: make blkcg_punt_bio_submit
> > > optional") adds '#ifdef CONFIG_BLK_CGROUP_PUNT_BIO' in __blkg_release().
> > > 
> > > 
> > 
> > What is the git commit id of this change in Linus's tree?
> 
> 20cb1c2fb756 ("blk-cgroup: Flush stats before releasing blkcg_gq")

Thanks, now queued up.

greg k-h
