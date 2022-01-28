Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFADC433F5
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 07:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiA1HIJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 02:08:09 -0500
Received: from verein.lst.de ([213.95.11.211]:47100 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238217AbiA1HIG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 02:08:06 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8335A68AA6; Fri, 28 Jan 2022 08:08:03 +0100 (CET)
Date:   Fri, 28 Jan 2022 08:08:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: yet another approach to fix loop autoclear for xfstets xfs/049
Message-ID: <20220128070803.GA2381@lst.de>
References: <20220126155040.1190842-1-hch@lst.de> <7bebf860-2415-7eb6-55a1-47dc4439d9e9@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bebf860-2415-7eb6-55a1-47dc4439d9e9@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[nit: please properly trim the lines in your mails, this needed a
 reformat to be readable at all]

On Thu, Jan 27, 2022 at 10:05:45AM +0900, Tetsuo Handa wrote:
> I want to remove disk->open_mutex => lo->lo_mutex => I/O completion chain
> itself from /proc/lockdep . Even if real deadlock does not happen due to
> lo->lo_refcnt exclusion, I consider that disk->open_mutex => lo->lo_mutex
> dependency being recorded is a bad sign.
> It makes difficult to find real possibility of deadlock when things change
> in future. I consider that lo_release() is doing too much things under
> disk->open_mutex.
> 
> I tried to defer lo->lo_mutex in lo_release() as much as possible.
> But this chain still remains.

Yes.  To completely remove it we'd need something like:

 - remove lo_refcnt and rely on bd_openers on the whole device bdev
 - add a block layer flag to temporarily disable a gendisk and fail
   all opens for it.

For now I'd really like to just fix the regression, though.
