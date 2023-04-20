Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A596CC77B73
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 05:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjDTFA4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 01:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDTFAz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 01:00:55 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DAB46AA
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 22:00:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 886A468B05; Thu, 20 Apr 2023 07:00:50 +0200 (CEST)
Date:   Thu, 20 Apr 2023 07:00:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 02/11] block: Micro-optimize
 blk_req_needs_zone_write_lock()
Message-ID: <20230420050050.GA4371@lst.de>
References: <20230418224002.1195163-1-bvanassche@acm.org> <20230418224002.1195163-3-bvanassche@acm.org> <20230419041106.GB25329@lst.de> <790b6dc9-90fc-dab6-e6ff-64742fefee86@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <790b6dc9-90fc-dab6-e6ff-64742fefee86@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 19, 2023 at 11:30:36AM -0700, Bart Van Assche wrote:
>> This looks correct, but I also kinda hate adding queue back in more
>> places.
>
> Hi Christoph,
>
> How about changing queue_op_is_zoned_write() into disk_op_is_zoned_write()? 
> That won't be as efficient as patch 2/11 in this series but still removes 
> the 'part0' dereference.

Or just open code it since we only have two callers anyway?
