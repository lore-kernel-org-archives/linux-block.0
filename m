Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB1AC04A95
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 15:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiJYPa2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 11:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiJYPa1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 11:30:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7DE444BD
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 08:30:25 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1111968C7B; Tue, 25 Oct 2022 17:30:19 +0200 (CEST)
Date:   Tue, 25 Oct 2022 17:30:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Message-ID: <20221025153017.GA24137@lst.de>
References: <20220928195510.165062-1-sagi@grimberg.me> <20220928195510.165062-2-sagi@grimberg.me> <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com> <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me> <YzWzvOKgoAqltAA0@kbusch-mbp.dhcp.thefacebook.com> <1b7feff8-48a4-6cd2-5a44-28a499630132@grimberg.me> <YzcJdeR82tHbFGAh@kbusch-mbp.dhcp.thefacebook.com> <414f04b6-aeac-5492-c175-9624b91d21c9@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414f04b6-aeac-5492-c175-9624b91d21c9@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 03, 2022 at 11:09:06AM +0300, Sagi Grimberg wrote:
>> make up the multipath device. Only the low-level driver can do that right now,
>> so perhaps either call into the driver to get all the block_device parts, or
>> the gendisk needs to maintain a list of those parts itself.
>
> I definitely don't think we want to propagate the device relationship to
> blk-mq. But a callback to the driver also seems very niche to nvme 
> multipath and is also kinda messy to combine calculations like
> iops/bw/latency accurately which depends on the submission distribution
> to the bottom devices which we would need to track now.
>
> I'm leaning towards just moving forward with this, take the relatively
> small hit, and if people absolutely care about the extra latency, then
> they can disable it altogether (upper and/or bottom devices).

So looking at the patches I'm really not a big fan of the extra
accounting calls, and especially the start_time field in the
nvme_request and even more so the special start/end calls in all
the transport drivers.

the stats sysfs attributes already have the entirely separate
blk-mq vs bio based code pathes.  So I think having a block_device
operation that replaces part_stat_read_all which allows nvme to
iterate over all pathes and collect the numbers would seem
a lot nicer.  There might be some caveats like having to stash
away the numbers for disappearing paths, though.
