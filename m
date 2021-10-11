Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10569C433EF
	for <linux-block@archiver.kernel.org>; Mon, 11 Oct 2021 11:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE9F560EE2
	for <linux-block@archiver.kernel.org>; Mon, 11 Oct 2021 11:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbhJKLmn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Oct 2021 07:42:43 -0400
Received: from verein.lst.de ([213.95.11.211]:37008 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231128AbhJKLmn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Oct 2021 07:42:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A095D68BEB; Mon, 11 Oct 2021 13:40:41 +0200 (CEST)
Date:   Mon, 11 Oct 2021 13:40:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Xie Yongji <xieyongji@bytedance.com>, jasowang@redhat.com,
        stefanha@redhat.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kevin Wolf <kwolf@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
Message-ID: <20211011114041.GB16138@lst.de>
References: <20210809101609.148-1-xieyongji@bytedance.com> <20211004112623-mutt-send-email-mst@kernel.org> <20211005062359-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005062359-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 05, 2021 at 06:42:43AM -0400, Michael S. Tsirkin wrote:
> Stefan also pointed out this duplicates the logic from 
> 
>         if (blksize < 512 || blksize > PAGE_SIZE || !is_power_of_2(blksize))
>                 return -EINVAL;
> 
> 
> and a bunch of other places.
> 
> 
> Would it be acceptable for blk layer to validate the input
> instead of having each driver do it's own thing?
> Maybe inside blk_queue_logical_block_size?

I'm pretty sure we want down that before.  Let's just add a helper
just for that check for now as part of this series.  Actually validating
in in blk_queue_logical_block_size seems like a good idea, but returning
errors from that has a long tail.
