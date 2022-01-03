Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDBFC433F5
	for <linux-block@archiver.kernel.org>; Mon,  3 Jan 2022 08:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiACIdH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jan 2022 03:33:07 -0500
Received: from verein.lst.de ([213.95.11.211]:45905 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232071AbiACIdG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Jan 2022 03:33:06 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B3D4968AA6; Mon,  3 Jan 2022 09:33:03 +0100 (CET)
Date:   Mon, 3 Jan 2022 09:33:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] make autoclear operation synchronous again
Message-ID: <20220103083303.GA28831@lst.de>
References: <03f43407-c34b-b7b2-68cd-d4ca93a993b8@i-love.sakura.ne.jp> <20211229172902.GC27693@lst.de> <4e7b711f-744b-3a78-39be-c9432a3cecd2@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e7b711f-744b-3a78-39be-c9432a3cecd2@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 30, 2021 at 07:52:34PM +0900, Tetsuo Handa wrote:
> > Instead of having to deal with sometimes present workqueues, why
> > not move the workqueue allocation to loop_add?
> 
> A bit of worrisome thing is that destroy_workqueue() can be called with
> major_names_lock held, for loop_add() may be called as probe function from
> blk_request_module(). Some unexpected dependency might bite us in future.
> 
> We can avoid destroy_workqueue() from loop_add() if we call alloc_workqueue()
> after add_disk() succeeded. But in that case calling alloc_workqueue() from
> loop_configure() (which is called without global locks like major_names_lock)
> sounds safer.

Ok.

> OK. Two patches shown below. Are these look reasonable?

They do look reasonable to me based on a quick glance, but please post
them one patch per mail in a separate thread for proper review.
