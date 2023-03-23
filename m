Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2497DC6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 08:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCWIWq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 04:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjCWIWp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 04:22:45 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C755C2FCDD
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 01:22:44 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 313B468AA6; Thu, 23 Mar 2023 09:22:41 +0100 (CET)
Date:   Thu, 23 Mar 2023 09:22:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 2/3] block: Split and submit bios in LBA order
Message-ID: <20230323082240.GB21977@lst.de>
References: <20230320234905.3832131-1-bvanassche@acm.org> <20230320234905.3832131-3-bvanassche@acm.org> <20230321060307.GB18078@lst.de> <20230321060530.GC18078@lst.de> <6596c17f-62cc-2f2b-1a25-0ec2b6ae230c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6596c17f-62cc-2f2b-1a25-0ec2b6ae230c@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 21, 2023 at 11:44:59AM -0700, Bart Van Assche wrote:
> On 3/20/23 23:05, Christoph Hellwig wrote:
>> In fact I wonder how you managed to get into __bio_split_to_limits
>> wtih a NULL current->bio_list at all.
>
> Hi Christoph,
>
> This patch series is what I came up with after having observed an UNALIGNED 
> WRITE COMMAND response with a 5.15 kernel. In that kernel version (but 
> probably not in the latest upstream kernel) the device mapper core submits 
> split bios in the wrong order. I will check again whether this patch is 
> really necessary.

How did that escape the upper layer serialization of zoned writes?

But my point is that all ->submit_bio instances as well as
blk_mq_submit_bio are only called with a non-NULL current->bio_list.
So I don't think you can reach the NULL current->bio_list case in this
patch.

Note that even without any specific zone device isss, submitting bios
in LBA oders works best for both spinning and solid state media,
but all of the arguments here don't add up.
