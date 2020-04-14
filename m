Return-Path: <SRS0=NWvS=56=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86482C2BA19
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 14:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4BE20578
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 14:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404517AbgDNOpk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:45:40 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53755 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404511AbgDNOpj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Apr 2020 10:45:39 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03EEinef011881
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Apr 2020 10:44:49 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E825A42013D; Tue, 14 Apr 2020 10:44:48 -0400 (EDT)
Date:   Tue, 14 Apr 2020 10:44:48 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
        jack@suse.cz, bvanassche@acm.org, gregkh@linuxfoundation.org,
        hch@infradead.org
Subject: Re: [PATCH v4 0/6] bdi: fix use-after-free for bdi device
Message-ID: <20200414144448.GA317058@mit.edu>
References: <20200325123843.47452-1-yuyufen@huawei.com>
 <1a735dce-c72b-5b2e-66c5-b5db30f1139b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a735dce-c72b-5b2e-66c5-b5db30f1139b@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 09, 2020 at 09:28:07PM +0800, Yufen Yu wrote:
> ping

ping**2

Can this go in as a bugfix during this cycle?

    	       	    	   	  - Ted

> 
> On 2020/3/25 20:38, Yufen Yu wrote:
> > Hi, all
> > 
> > We have reported a use-after-free crash for bdi device in __blkg_prfill_rwstat().
> > The bug is caused by printing device kobj->name while the device and kobj->name
> > has been freed by bdi_unregister().
> > 
> > In fact, commit 68f23b8906 "memcg: fix a crash in wb_workfn when a device disappears"
> > has tried to address the issue, but the code is till somewhat racy after that commit.
> > 
> > In this patchset, we try to protect bdi->dev with spinlock and copy device name
> > into caller buffer, avoiding use-after-free.
> > 
> > V4:
> >    * Fix coding error in bdi_get_dev_name()
> >    * Write one patch for each broken caller
> > 
> > V3:
> >    https://www.spinics.net/lists/linux-block/msg51111.html
> >    Use spinlock to protect bdi->dev and copy device name into caller buffer
> > 
> > V2:
> >    https://www.spinics.net/lists/linux-fsdevel/msg163206.html
> >    Try to protect device lifetime with RCU.
> > 
> > V1:
> >    https://www.spinics.net/lists/linux-block/msg49693.html
> >    Add a new spinlock and copy kobj->name into caller buffer.
> >    Or using synchronize_rcu() to wait until reader complete.
> > 
> > Yufen Yu (6):
> >    bdi: use bdi_dev_name() to get device name
> >    bdi: protect bdi->dev with spinlock
> >    bfq: fix potential kernel crash when print error info
> >    memcg: fix crash in wb_workfn when bdi unregister
> >    blk-wbt: replace bdi_dev_name() with bdi_get_dev_name()
> >    blkcg: fix use-after-free for bdi->dev
> > 
> >   block/bfq-iosched.c              |  6 +++--
> >   block/blk-cgroup-rwstat.c        |  6 +++--
> >   block/blk-cgroup.c               | 19 +++++-----------
> >   block/blk-iocost.c               | 14 +++++++-----
> >   block/blk-iolatency.c            |  5 +++--
> >   block/blk-throttle.c             |  6 +++--
> >   fs/ceph/debugfs.c                |  2 +-
> >   fs/fs-writeback.c                |  4 +++-
> >   include/linux/backing-dev-defs.h |  1 +
> >   include/linux/backing-dev.h      | 26 ++++++++++++++++++++++
> >   include/linux/blk-cgroup.h       |  1 -
> >   include/trace/events/wbt.h       |  8 +++----
> >   include/trace/events/writeback.h | 38 ++++++++++++++------------------
> >   mm/backing-dev.c                 |  9 ++++++--
> >   14 files changed, 88 insertions(+), 57 deletions(-)
> > 
