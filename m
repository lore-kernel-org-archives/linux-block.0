Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140AFC433EF
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 06:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346583AbiA1Gq5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 01:46:57 -0500
Received: from verein.lst.de ([213.95.11.211]:47027 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346581AbiA1Gq5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 01:46:57 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0620768AA6; Fri, 28 Jan 2022 07:46:54 +0100 (CET)
Date:   Fri, 28 Jan 2022 07:46:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 6/8] loop: don't freeze the queue in lo_release
Message-ID: <20220128064653.GA1777@lst.de>
References: <20220126155040.1190842-1-hch@lst.de> <20220126155040.1190842-7-hch@lst.de> <20220127104256.5tmkxo4m4uvcbqai@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127104256.5tmkxo4m4uvcbqai@quack3.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 27, 2022 at 11:42:56AM +0100, Jan Kara wrote:
> Maybe worth a comment like:
> 
> 	/*
> 	 * No IO can be running at this point since there are no openers
> 	 * (covers filesystems, stacked devices, AIO) and the page cache is
> 	 * evicted.
> 	 */

I really don't see the point to add this to a specific driver instance.
It is a block layer guarantee so maybe we should document it better
there, but certainly not duplicate it in all the instances.
