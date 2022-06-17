Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A473C43334
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 13:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiFQN1G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 09:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiFQN1F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 09:27:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B66957131
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 06:27:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 91B8667373; Fri, 17 Jun 2022 15:26:59 +0200 (CEST)
Date:   Fri, 17 Jun 2022 15:26:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, linux-block@vger.kernel.org,
        syzbot+3e3f419f4a7816471838@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/4] block: disable the elevator int del_gendisk
Message-ID: <20220617132659.GA26192@lst.de>
References: <20220614074827.458955-1-hch@lst.de> <20220614074827.458955-2-hch@lst.de> <YqhFiDx0/IW25bSp@T590> <20220614083453.GA6999@lst.de> <Yqhwv0POjMi1TNo3@T590> <d76649ab-7392-33e9-13fd-785073bbfe4c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d76649ab-7392-33e9-13fd-785073bbfe4c@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 17, 2022 at 06:50:50AM -0600, Jens Axboe wrote:
> > Then looks this pattern has problem in dealing with the examples I
> > mentioned.
> > 
> > And the elevator usage in __blk_mq_update_nr_hw_queues() looks one
> > old problem, but easy to fix by protecting it via sysfs_lock.
> > 
> > And fixing blk_mq_has_sqsched() should be easy too.
> > 
> > I will send patches later.
> 
> Just checking in on this series, Ming did you make any progress?

He send the patches in the "blk-mq: three misc patches" series and you
already applied them.
