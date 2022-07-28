Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018CEC19F2B
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 14:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiG1OfE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jul 2022 10:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiG1Oen (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jul 2022 10:34:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BF972EE3
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 07:32:08 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 42BFB67373; Thu, 28 Jul 2022 16:32:04 +0200 (CEST)
Date:   Thu, 28 Jul 2022 16:32:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 3/6] block: move ->bio_split to the gendisk
Message-ID: <20220728143203.GA17963@lst.de>
References: <20220727162300.3089193-1-hch@lst.de> <20220727162300.3089193-4-hch@lst.de> <5323f3a1-14ac-eafb-3b5a-493fea2e86f5@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5323f3a1-14ac-eafb-3b5a-493fea2e86f5@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 28, 2022 at 10:07:14AM +0200, Hannes Reinecke wrote:
>> +	struct bio_set *bs = &bio->bi_bdev->bd_disk->bio_split;
>>   	struct bio *split;
>>   
>
> What happens for nvme-multipath?
> While I know that we shouldn't split on a path, experience shows that we 
> _will_ do it eventually.
> Hence, shouldn't we take precaution for hidden disks with no gendisk 
> attached here?

Every block device including nvme-multioath has a valid gendisk.
