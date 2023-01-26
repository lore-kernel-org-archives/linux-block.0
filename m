Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5D6C61D97
	for <linux-block@archiver.kernel.org>; Thu, 26 Jan 2023 05:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjAZFaZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Jan 2023 00:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjAZFaY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2023 00:30:24 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B4449973;
        Wed, 25 Jan 2023 21:30:23 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7936068D09; Thu, 26 Jan 2023 06:30:18 +0100 (CET)
Date:   Thu, 26 Jan 2023 06:30:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 7/7] block: remove ->rw_page
Message-ID: <20230126053017.GA28355@lst.de>
References: <20230125133436.447864-1-hch@lst.de> <20230125133436.447864-8-hch@lst.de> <Y9FYsXgo9pVJ5weX@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9FYsXgo9pVJ5weX@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 25, 2023 at 09:28:33AM -0700, Keith Busch wrote:
> On Wed, Jan 25, 2023 at 02:34:36PM +0100, Christoph Hellwig wrote:
> > @@ -363,8 +384,10 @@ void __swap_writepage(struct page *page, struct writeback_control *wbc)
> >  	 */
> >  	if (data_race(sis->flags & SWP_FS_OPS))
> >  		swap_writepage_fs(page, wbc);
> > +	else if (sis->flags & SWP_SYNCHRONOUS_IO)
> > +		swap_writepage_bdev_sync(page, wbc, sis);
> 
> For an additional cleanup, it looks okay to remove the SWP_SYNCHRONOUS_IO flag
> entirely and just check bdev_synchronous(sis->bdev)) directly instead.

The swap code relatively consistently maps bdev flags to SWP_* flags,
including SWP_STABLE_WRITES, SWAP_FLAG_DISCARD and the somewhat misnamed
SWP_SOLIDSTATE.   So if we want to change that it's probably a separate
series.
