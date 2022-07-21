Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701BFC43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 05:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiGUFMw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 01:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGUFMv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 01:12:51 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786E074E3F
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 22:12:50 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BC59C68AFE; Thu, 21 Jul 2022 07:12:46 +0200 (CEST)
Date:   Thu, 21 Jul 2022 07:12:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert "ublk_drv: fix request queue leak"
Message-ID: <20220721051246.GA19522@lst.de>
References: <20220718062928.335399-1-hch@lst.de> <20220718062928.335399-2-hch@lst.de> <YtalgzqC/q3JpYCR@T590> <20220720060705.GB6734@lst.de> <YtezD/apQ1dM0n33@T590> <20220720090040.GA18210@lst.de> <YtfXmlbhN9WAPK71@T590> <20220720130845.GA11940@lst.de> <YtggRH5AJpKYmmwt@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtggRH5AJpKYmmwt@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 20, 2022 at 11:33:24PM +0800, Ming Lei wrote:
> I meant that request queue is supposed to be low level stuff for implementing
> disk function, and request queue hasn't to be released and re-allocated
> after each disk whole lifetime(alloc disk, add disk, del_gendisk, release disk).

It doesn't have to.  But it is pretty damn convenient if we can.

What we can't easily do is to re-add a disk after del_gendisk was
called but before the final reference went away, which is what ublk
does do currently.  In other words it does not even follow the SCSI
model, which works but is somewhat cumbersome, but comes up with
yet another weird model that is probably going to fall apart pretty
quickly when doing STAT_DEV, STOP_DEV loops.
