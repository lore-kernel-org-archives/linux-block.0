Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8407C433DB
	for <linux-block@archiver.kernel.org>; Mon, 28 Dec 2020 08:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99302208BA
	for <linux-block@archiver.kernel.org>; Mon, 28 Dec 2020 08:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgL1IaU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Dec 2020 03:30:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51671 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726354AbgL1IaT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Dec 2020 03:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609144132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UaOuLgpFoeN0oTRLHLO4TgNcGhQC3vq+vzim6sDzPWg=;
        b=MvENQa0j/gWTVGlWnLq4xrg/LAsi0ZDkAn7OvWGLERJDZRR9xKKYs9Ot7hPF0FCObBWWTM
        D5IDNvFP2E8QIYStzvcoDDwQbq3/25mXbRfsZsw3dsivAxxfKMoAMUOIblh2Hn6FBEVWDg
        cHB5SaB6qouAqqIEyX87SqKQlYYerbA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-vPJBaJFINfWXd14xKzAlXw-1; Mon, 28 Dec 2020 03:28:47 -0500
X-MC-Unique: vPJBaJFINfWXd14xKzAlXw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54A761005513;
        Mon, 28 Dec 2020 08:28:46 +0000 (UTC)
Received: from T590 (ovpn-13-139.pek2.redhat.com [10.72.13.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0253C1F44D;
        Mon, 28 Dec 2020 08:28:39 +0000 (UTC)
Date:   Mon, 28 Dec 2020 16:28:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 1/3] blk-mq: allow hardware queue to get more tag while
 sharing a tag set
Message-ID: <20201228082835.GB3304670@T590>
References: <20201226102808.2534966-1-yukuai3@huawei.com>
 <20201226102808.2534966-2-yukuai3@huawei.com>
 <20201227115859.GA3282759@T590>
 <04c39621-0c4a-e593-5545-c4bd274c5fc2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04c39621-0c4a-e593-5545-c4bd274c5fc2@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 28, 2020 at 09:56:15AM +0800, yukuai (C) wrote:
> Hi,
> 
> On 2020/12/27 19:58, Ming Lei wrote:
> > Hi Yu Kuai,
> > 
> > On Sat, Dec 26, 2020 at 06:28:06PM +0800, Yu Kuai wrote:
> > > When sharing a tag set, if most disks are issuing small amount of IO, and
> > > only a few is issuing a large amount of IO. Current approach is to limit
> > > the max amount of tags a disk can get equally to the average of total
> > > tags. Thus the few heavy load disk can't get enough tags while many tags
> > > are still free in the tag set.
> > 
> > Yeah, current approach just allocates same share for each active queue
> > which is evaluated in each timeout period.
> > 
> > That said you are trying to improve the following case:
> > - heavy IO on one or several disks, and the average share for these
> >    disks become bottleneck of IO performance
> > - small amount IO on other disks attached to the same host, and all IOs are
> > submitted to disk in <30 second period.
> > 
> > Just wondering if you may share the workload you are trying to optimize,
> > or it is just one improvement in theory? And what is the disk(hdd, ssd
> > or nvme) and host? And how many disks in your setting? And how deep the tagset
> > depth is?
> 
> The details of the environment that we found the problem are as follows:
> 
>  total driver tags: 128

Looks the tagset depth is a bit low.

>  number of disks: 13 (network drive, and they form a dm-multipath)
>  default queue_depth: 32

Another candidate solution may be to always return true from hctx_may_queue()
for this kind of queue because queue_depth has provided fair allocation for
each LUN, and looks not necessary to do that again.

>  disk performance: when test with 4k randread and single thread, iops is
>                    300. And can up to 4000 with 32 thread.
>  test cmd: fio -ioengine=psync -numjobs=32 ...
> 
> We found that mpath will issue sg_io periodically(about 15s)，which lead
> to active_queues setting to 13 for about 5s in every 15s.

BTW, I just observe sg_io on rhel8 & rhel7 on mpath over scsi_debug, looks not
see any such activity.

> 
> By the way, I'm not sure this is a common scenario, however, sq don't
> have such problem,

If it is done by mpath at default setting, I think it can be thought as
one common case.


Thanks,
Ming

