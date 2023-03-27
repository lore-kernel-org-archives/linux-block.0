Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AF3C76195
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 23:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjC0XnS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 19:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjC0XnR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 19:43:17 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1211AB
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 16:43:16 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 33B0B68AA6; Tue, 28 Mar 2023 01:43:12 +0200 (CEST)
Date:   Tue, 28 Mar 2023 01:43:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Message-ID: <20230327234311.GA19281@lst.de>
References: <20230323082604.GC21977@lst.de> <acd13f8c-6cbe-a14d-e3b4-645d62811cec@opensource.wdc.com> <122cdca2-b0ae-ce74-664d-e268fe0699a8@acm.org> <7a795b9b-51dc-9166-1cf0-6c51db77b195@opensource.wdc.com> <1e65e542-e8e9-bd3f-6ff1-1bbd4716a8c3@acm.org> <e83d1111-1841-7b2a-973b-16bea2e789c6@opensource.wdc.com> <7f4463c1-fd02-8ac5-16d7-61ffe6279e07@acm.org> <5b450fee-714b-224e-69ae-497633e005ed@opensource.wdc.com> <20230326234552.GC20017@lst.de> <7b668546-addb-9a47-b6f0-4f2422617ead@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b668546-addb-9a47-b6f0-4f2422617ead@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 27, 2023 at 02:06:09PM -0700, Bart Van Assche wrote:
> Using REQ_OP_ZONE_APPEND may lead to reordering - data being written on the 
> storage medium in another order than the order in which the 
> REQ_OP_ZONE_APPEND commands were submitted.

Only if that reordering actually happens.  Which we're very good at avoiding.
e.g. when looking at btrfs on ZNS drives we see that this reordering does
not actually happen to a quantifiable amount.

> Hence, the number of extents 
> for large files increases and performance when reading large files reduces. 
> To me comparing the performance of these two approaches sounds like a good 
> topic for a research paper. I'm not sure that REQ_OP_ZONE_APPEND is better 
> for all zoned storage workloads than REQ_OP_WRITE.

For REQ_OP_WRITE you absolutely must avoid reordering, so you need to
globally serialize.  If you can come up with a workload where your write
based approach is fast, please show it!
