Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77520C433DB
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 01:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EC2721D94
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 01:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgL2BQ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Dec 2020 20:16:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44060 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728866AbgL2BQ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Dec 2020 20:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609204531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eBJ6kKQWYuEAaXHdRSBBZAxKMVtN23/Wd2vMiKf4R5k=;
        b=RqTjFa9u3LxNTszQGNFWIehAPgtT8pnIi/mCXC89MUFeVXwexVAFdirrZdmuhKOQSoqMps
        eeVOKkT7p+ubaNfR5mxRUxe+nTUYeM7jXQDpL4XCeR4raYU6B2Yr+mKmwTu4Z7pRojxrQB
        N8SExQFlxteIW4dB/aa32PIwarALOAM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-yiUW1BBxPKy65RM5wJYOEw-1; Mon, 28 Dec 2020 20:15:30 -0500
X-MC-Unique: yiUW1BBxPKy65RM5wJYOEw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C701107ACF6;
        Tue, 29 Dec 2020 01:15:28 +0000 (UTC)
Received: from T590 (ovpn-12-203.pek2.redhat.com [10.72.12.203])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A35B360D11;
        Tue, 29 Dec 2020 01:15:21 +0000 (UTC)
Date:   Tue, 29 Dec 2020 09:15:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 1/3] blk-mq: allow hardware queue to get more tag while
 sharing a tag set
Message-ID: <20201229011517.GA3355551@T590>
References: <20201226102808.2534966-1-yukuai3@huawei.com>
 <20201226102808.2534966-2-yukuai3@huawei.com>
 <20201227115859.GA3282759@T590>
 <04c39621-0c4a-e593-5545-c4bd274c5fc2@huawei.com>
 <20201228082835.GB3304670@T590>
 <fce32e47-0e7d-39fa-611f-31ac0b422ba5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fce32e47-0e7d-39fa-611f-31ac0b422ba5@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 28, 2020 at 05:02:50PM +0800, yukuai (C) wrote:
> Hi
> 
> On 2020/12/28 16:28, Ming Lei wrote:
> > Another candidate solution may be to always return true from hctx_may_queue()
> > for this kind of queue because queue_depth has provided fair allocation for
> > each LUN, and looks not necessary to do that again.
> 
> If always return true from hctx_may_queue() in this case, for example,
> we set queue_depth to 128(if can't, the biggger, the better) for all
> disks, and test with numjobs=64. The result should be one disk with high
> iops, and the rest very low. So I think it's better to ensure the max
> tags a disk can get in this case.

Just wondering why you try to set 128 via sysfs for all disks? If you do that,
you should know the potential result given the whole tags queue depth is just
128.


Thanks,
Ming

