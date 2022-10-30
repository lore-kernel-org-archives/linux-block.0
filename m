Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCCCC38A02
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 07:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJ3HtC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 03:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJ3HtB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 03:49:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FF5119
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 00:48:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D1A768AA6; Sun, 30 Oct 2022 08:48:53 +0100 (CET)
Date:   Sun, 30 Oct 2022 08:48:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Subject: Re: [bug?] blk_queue_may_bounce() has the comparison max_low_pfn
 and max_pfn wrong way
Message-ID: <20221030074853.GB4214@lst.de>
References: <Y1wZTtENDq3fvs6n@ZenIV> <01ce222b-8ad6-b4b3-428a-bae9534795e7@kernel.dk> <Y1wr0g39GzHcAk9v@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1wr0g39GzHcAk9v@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 28, 2022 at 08:21:54PM +0100, Al Viro wrote:
> I wonder if we ought to simply add "depends on BROKEN" for CONFIG_BOUNCE... ;-/

Depends on BROKEN does not help anyone, we might better remove it.

Users are:

  paride drivers
  drivers/mmc/ for a few drivers
  3 SCSI LLDDs (two of those parport attached, one ISA)
  usb-storage

The thing that most matters is usb-storage that can't be used on
highmem systems, and maybe one or two of the mmc drivers might exist
on arm highmem systems.

In general nothing should use these, for MMIO/PIO based drivers they
should kmap, and for DMA drivers nothing should use the kernel virtual
address, except that the USB interfaces are a mess that seems to
partially require one.
