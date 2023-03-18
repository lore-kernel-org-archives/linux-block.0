Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E4AC7619A
	for <linux-block@archiver.kernel.org>; Sat, 18 Mar 2023 06:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjCRGdW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Mar 2023 02:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjCRGdU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Mar 2023 02:33:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2E36EBB4
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 23:33:18 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2E25468C4E; Sat, 18 Mar 2023 07:33:15 +0100 (CET)
Date:   Sat, 18 Mar 2023 07:33:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Message-ID: <20230318063314.GC24880@lst.de>
References: <20230317195938.1745318-1-bvanassche@acm.org> <20230317195938.1745318-3-bvanassche@acm.org> <20230317222813.xkjia2cottjwzls7@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317222813.xkjia2cottjwzls7@quack3>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 17, 2023 at 11:28:13PM +0100, Jan Kara wrote:
> > -	rq_list_add(&plug->mq_list, rq);
> > +	last_p = &plug->mq_list;
> > +	while (*last_p)
> > +		last_p = &(*last_p)->rq_next;
> > +	rq_list_add_tail(&last_p, rq);
> >  	plug->rq_count++;
> >  }
> 
> Uh, I don't think we want to traverse the whole plug list each time we are
> adding a request to it. We have just recently managed to avoid that at
> least for single-device cases and apparently it was a win for fast devices
> (see commit d38a9c04c0d5 ("block: only check previous entry for plug merge
> attempt")).

REQ_OP_WRITE request for zoned devices are never added to the plug
list, so all of this actually is dead (and probably untested?) code.

See blk_mq_plug() and bdev_op_is_zoned_write().
