Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4903EB64DC
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 05:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjFOFzp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jun 2023 01:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjFOFzo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 01:55:44 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDA010E9;
        Wed, 14 Jun 2023 22:55:43 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2AB0267373; Thu, 15 Jun 2023 07:55:40 +0200 (CEST)
Date:   Thu, 15 Jun 2023 07:55:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 4/7] brd: make sector size configurable
Message-ID: <20230615055540.GA5561@lst.de>
References: <20230614114637.89759-1-hare@suse.de> <20230614114637.89759-5-hare@suse.de> <ZIp0qH3CAMr1mGzX@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIp0qH3CAMr1mGzX@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 15, 2023 at 12:17:12PM +1000, Dave Chinner wrote:
> On Wed, Jun 14, 2023 at 01:46:34PM +0200, Hannes Reinecke wrote:
> > @@ -310,6 +312,10 @@ static int max_part = 1;
> >  module_param(max_part, int, 0444);
> >  MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
> >  
> > +static unsigned int rd_blksize = PAGE_SIZE;
> > +module_param(rd_blksize, uint, 0444);
> > +MODULE_PARM_DESC(rd_blksize, "Blocksize of each RAM disk in bytes.");
> 
> This needs CONFIG_BLK_DEV_RAM_BLOCK_SIZE to set the default size
> for those of us who don't use modular kernels....

You can set module parameter on the command line for built-in code
like brd.rd_blksize=8196

While we're at it, why that weird rd_ prefix for the parameter?

