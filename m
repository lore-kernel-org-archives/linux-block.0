Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF60C433F5
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 08:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiAQINZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:13:25 -0500
Received: from verein.lst.de ([213.95.11.211]:58928 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbiAQINY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 03:13:24 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B5EB268AFE; Mon, 17 Jan 2022 09:13:21 +0100 (CET)
Date:   Mon, 17 Jan 2022 09:13:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/3] block: don't drain file system I/O on del_gendisk
Message-ID: <20220117081321.GA22627@lst.de>
References: <20220116041815.1218170-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220116041815.1218170-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jan 16, 2022 at 12:18:12PM +0800, Ming Lei wrote:
> Hello,
> 
> Draining FS I/O on del_gendisk() is added for just avoiding to refer to
> recently added q->disk in IO path, and it isn't actually needed.

We need it to have proper life times in the block layer.  Everything only
needed for file system I/O and not blk-mq specific should slowly move
from the request_queue to the gendisk and I have patches going in
that direction.  In the end only the SCSI discovery code and the case
of /dev/sg without SCSI ULP will ever do passthrough I/O purely on the
gendisk.

So I think this series is moving in the wrong direction.  If you care
about no doing two freeze cycles the right thing to do is to record
if we ever did non-disk based passthrough I/O on a requeue_queue and
if not simplify the request_queue cleanup.  Doing this is on my TODO
list but I haven't look into the details yet.

> 1) queue freezing can't drain FS I/O for bio based driver

This is something I've started looking into it.

> 2) it isn't easy to move elevator/cgroup/throttle shutdown during
> del_gendisk, and q->disk can still be referred in these code paths

I've also done some prep work to land this cycle here, as all that
code is only used for FS I/O.
