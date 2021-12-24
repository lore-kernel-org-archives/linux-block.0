Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E72C433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Dec 2021 06:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351436AbhLXGCI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Dec 2021 01:02:08 -0500
Received: from verein.lst.de ([213.95.11.211]:55691 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351431AbhLXGCI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Dec 2021 01:02:08 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 12D2B68AA6; Fri, 24 Dec 2021 07:02:06 +0100 (CET)
Date:   Fri, 24 Dec 2021 07:02:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: fix loop autoclear for xfstets xfs/049
Message-ID: <20211224060205.GB12234@lst.de>
References: <20211223112509.1116461-1-hch@lst.de> <20211223134050.GD19129@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223134050.GD19129@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 23, 2021 at 02:40:50PM +0100, Jan Kara wrote:
> Hum, I have nothing against this but I'm somewhat wondering: Lockdep was
> originally complaining because it somehow managed to find a write whose
> completion was indirectly dependent on disk->open_mutex and
> destroy_workqueue() could wait for such write to complete under
> disk->open_mutex. Now your patch will fix this lockdep complaint but we
> still would wait for the write to complete through blk_mq_freeze_queue()
> (just lockdep is not clever enough to detect this). So IHMO if there was a
> deadlock before, it will be still there with your changes. Now I'm not 100%
> sure the deadlock lockdep was complaining about is real in the first place
> because it involved some writes to proc files (taking some locks) and
> hibernation mutex and whatnot.  But it is true that writing to a backing
> file will grab fs freeze protection and that can bring with it all sorts of
> interesting dependencies.

I don't think the problem was a write completion, but the synchronous
nature of the workqueue operations.  But I also have to admit the whole
lockdep vs workqueue thing keeps confusing me.
