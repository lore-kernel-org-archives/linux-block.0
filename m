Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8778BC43334
	for <linux-block@archiver.kernel.org>; Wed, 20 Jul 2022 13:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiGTNIv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jul 2022 09:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239803AbiGTNIv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jul 2022 09:08:51 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F96252FD1
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 06:08:49 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 470A868AFE; Wed, 20 Jul 2022 15:08:46 +0200 (CEST)
Date:   Wed, 20 Jul 2022 15:08:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert "ublk_drv: fix request queue leak"
Message-ID: <20220720130845.GA11940@lst.de>
References: <20220718062928.335399-1-hch@lst.de> <20220718062928.335399-2-hch@lst.de> <YtalgzqC/q3JpYCR@T590> <20220720060705.GB6734@lst.de> <YtezD/apQ1dM0n33@T590> <20220720090040.GA18210@lst.de> <YtfXmlbhN9WAPK71@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtfXmlbhN9WAPK71@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 20, 2022 at 06:23:22PM +0800, Ming Lei wrote:
> Even though alloc_disk and add_disk is paired here, GD_OWNS_QUEUE still
> can't be set because request queue has to be workable for the new alloc/
> added disk, just like scsi.

How so?  dm has totally normall disk/request_queue lifetimes.  The only
caveat is that the blk-mq bits of the queue are added after the initial
non-mq disk allocation.  There is no newly added disk after the disk
and queue are torn down.
