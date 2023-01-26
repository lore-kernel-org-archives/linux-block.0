Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7167FC54E94
	for <linux-block@archiver.kernel.org>; Thu, 26 Jan 2023 05:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbjAZFab (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Jan 2023 00:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjAZFaa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2023 00:30:30 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC8351C7B;
        Wed, 25 Jan 2023 21:30:30 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6D8C568D0A; Thu, 26 Jan 2023 06:30:26 +0100 (CET)
Date:   Thu, 26 Jan 2023 06:30:25 +0100
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
Subject: Re: [PATCH 2/7] mm: remove the swap_readpage return value
Message-ID: <20230126053025.GB28355@lst.de>
References: <20230125133436.447864-1-hch@lst.de> <20230125133436.447864-3-hch@lst.de> <Y9FRpwaiee2GaOm+@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9FRpwaiee2GaOm+@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 25, 2023 at 08:58:31AM -0700, Keith Busch wrote:
> On Wed, Jan 25, 2023 at 02:34:31PM +0100, Christoph Hellwig wrote:
> > -static inline int swap_readpage(struct page *page, bool do_poll,
> > -				struct swap_iocb **plug)
> > +static inline void swap_readpage(struct page *page, bool do_poll,
> > +		struct swap_iocb **plug)
> >  {
> >  	return 0;
> >  }
> 
> Need to remove the 'return 0'.

Yes.
