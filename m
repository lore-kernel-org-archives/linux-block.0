Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133E6C433EA
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 07:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A1F2073E
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 07:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgG0H60 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:58:26 -0400
Received: from verein.lst.de ([213.95.11.211]:42430 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgG0H60 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 03:58:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 630C468B05; Mon, 27 Jul 2020 09:58:22 +0200 (CEST)
Date:   Mon, 27 Jul 2020 09:58:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 10/14] bdi: remove BDI_CAP_SYNCHRONOUS_IO
Message-ID: <20200727075822.GA5355@lst.de>
References: <20200726150333.305527-1-hch@lst.de> <20200726150333.305527-11-hch@lst.de> <20200726190639.GA560221@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726190639.GA560221@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 26, 2020 at 12:06:39PM -0700, Minchan Kim wrote:
> > @@ -528,8 +530,7 @@ static ssize_t backing_dev_store(struct device *dev,
> >  	 * freely but in fact, IO is going on so finally could cause
> >  	 * use-after-free when the IO is really done.
> >  	 */
> > -	zram->disk->queue->backing_dev_info->capabilities &=
> > -			~BDI_CAP_SYNCHRONOUS_IO;
> > +	zram->disk->fops = &zram_wb_devops;
> >  	up_write(&zram->init_lock);
> 
> For zram, regardless of BDI_CAP_SYNCHRONOUS_IO, it have used rw_page
> every time on read/write path. This one with next patch will make zram
> use bio instead of rw_page when it's declared !BDI_CAP_SYNCHRONOUS_IO,
> which introduce regression for performance.

It really should not matter, as the overhead of setting up a bio
is minimal.  It also is only used in the legacy mpage buffered I/O
code outside of the swap code, which has so many performance issues on
its own that even if this made a difference it wouldn't matter.

If you want magic treatment for your zram swap code you really need
to integrate it with the swap code instead of burding the block layer
with all this mess.
