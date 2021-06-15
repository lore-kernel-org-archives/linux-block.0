Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C6FC48BE5
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 09:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8569A61429
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 09:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhFOJGk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 05:06:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44810 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhFOJGd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 05:06:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E3EBE1FD2A;
        Tue, 15 Jun 2021 09:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623747868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NJoqqhsvx2sNs9lDgOIYwwi7W2f6G9EVJ5fv0zA7HuU=;
        b=iQS0yPTnUMPsqXOO3g3QJRx+U2JeH+r1OOvYREr8pAgz6aNNOE+daDqbi8XTesZQWVB8NP
        J9DXvHNmscJX6JW1RW+nGYqhrBFj+Y51/QOXFD3AmmI/2fYxYEnFaYvWwLTjHdRIrCMP2G
        Vz1yO6qgiv96iVEJ3YfYLnwSab14YXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623747868;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NJoqqhsvx2sNs9lDgOIYwwi7W2f6G9EVJ5fv0zA7HuU=;
        b=wlZcB/Smx73aUJOHz0iT3seRvKb3QsSjy+R/M3lrFqffwfj43eI9LFeosldkMz+gbLs8+0
        kjBEDk8cPiIoamDg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id C7324A3B84;
        Tue, 15 Jun 2021 09:04:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 645251F2C88; Tue, 15 Jun 2021 11:04:28 +0200 (CEST)
Date:   Tue, 15 Jun 2021 11:04:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Petr Vorel <pvorel@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block <linux-block@vger.kernel.org>,
        syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] loop: drop loop_ctl_mutex around del_gendisk() in
 loop_remove()
Message-ID: <20210615090428.GH29751@quack2.suse.cz>
References: <000000000000ae236f05bfde0678@google.com>
 <1435f266-9f6d-22ef-ba7d-f031c616aede@I-love.SAKURA.ne.jp>
 <7b8c9eeb-789d-e5e6-04d6-130ee8be7305@i-love.sakura.ne.jp>
 <20210609164639.GM4910@sequoia>
 <718b44b5-a230-1907-e1e1-9f609cb67322@i-love.sakura.ne.jp>
 <4e315cc1-cbb9-b00e-c4cd-ca4f6f60f202@i-love.sakura.ne.jp>
 <d15e9392-44d0-f42c-cbac-859459a99395@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d15e9392-44d0-f42c-cbac-859459a99395@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat 12-06-21 00:14:20, Tetsuo Handa wrote:
> syzbot is reporting circular locking dependency between loop_ctl_mutex and
> bdev->bd_mutex [1] due to commit c76f48eb5c084b1e ("block: take bd_mutex
> around delete_partitions in del_gendisk").
> 
> But calling del_gendisk() from loop_remove() without loop_ctl_mutex held
> triggers a different race problem regarding sysfs entry management. We
> somehow need to serialize "add_disk() from loop_add()" and "del_gendisk()
>  from loop_remove()". Fortunately, since loop_control_ioctl() is called
> with no locks held, we can use "sleep and retry" approach without risking
> deadlock.
> 
> Since "struct loop_device"->lo_disk->private_data is set to non-NULL at
> loop_add() and is reset to NULL before calling loop_remove(), we can use
> it as a flag for taking appropriate action ("sleep and retry" or "skip")
> when loop_remove() is in progress.
> 
> Link: https://syzkaller.appspot.com/bug?extid=61e04e51b7ac86930589 [1]
> Reported-by: syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Tested-by: syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>
> Fixes: c76f48eb5c084b1e ("block: take bd_mutex around delete_partitions in del_gendisk")

Christoph seems to have already fixed this by 990e78116d380 ("block: loop:
fix deadlock between open and remove").

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
