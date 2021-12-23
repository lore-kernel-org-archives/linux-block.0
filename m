Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02361C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Dec 2021 13:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243683AbhLWNkw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 08:40:52 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39632 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238660AbhLWNkw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 08:40:52 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 16A79210FE;
        Thu, 23 Dec 2021 13:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640266851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1z7OZ0rR0P0RKIxtTpXCekGGavovOZJ7xmNdBmMBHWs=;
        b=jB3zfhm3Qdta9/CrojrUHeWpz3PclVivNnqkNEzCjCpcKxVGvEKxEz/6AyfWnHLlKmu0uC
        zp5zQsFuoq5fDwS/1CIw7KEZlkQQygBXxRIXtA98jlgXpSRZ37XLJ5pQz2yT0XeWKjWrp2
        1a5X2gNWmGIstfPd4XgXGhkSmme8aW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640266851;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1z7OZ0rR0P0RKIxtTpXCekGGavovOZJ7xmNdBmMBHWs=;
        b=U7mBhKscVssGu0NynAL/yRJix2XjbbIV7rSANWAGQw7uQWzYNK8hlJwLMev/4L1W/RQQcR
        +JSfzrEDtBur/gAA==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id C071AA3B84;
        Thu, 23 Dec 2021 13:40:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7FDAE1E1328; Thu, 23 Dec 2021 14:40:50 +0100 (CET)
Date:   Thu, 23 Dec 2021 14:40:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: fix loop autoclear for xfstets xfs/049
Message-ID: <20211223134050.GD19129@quack2.suse.cz>
References: <20211223112509.1116461-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223112509.1116461-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi!

On Thu 23-12-21 12:25:07, Christoph Hellwig wrote:
> this is a 3rd approach to fix the loop autoclean delay.  Instead of
> working around the workqueue lockdep issues this switches the loop
> driver to use a global workqueue and thus avoids the destroy_workqueue
> call under disk->open_mutex entirely.

Hum, I have nothing against this but I'm somewhat wondering: Lockdep was
originally complaining because it somehow managed to find a write whose
completion was indirectly dependent on disk->open_mutex and
destroy_workqueue() could wait for such write to complete under
disk->open_mutex. Now your patch will fix this lockdep complaint but we
still would wait for the write to complete through blk_mq_freeze_queue()
(just lockdep is not clever enough to detect this). So IHMO if there was a
deadlock before, it will be still there with your changes. Now I'm not 100%
sure the deadlock lockdep was complaining about is real in the first place
because it involved some writes to proc files (taking some locks) and
hibernation mutex and whatnot.  But it is true that writing to a backing
file will grab fs freeze protection and that can bring with it all sorts of
interesting dependencies.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
