Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1B4C432BE
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 13:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2342660F4C
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 13:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbhHRN2w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 09:28:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237204AbhHRN2P (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 09:28:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CEDA60FE6;
        Wed, 18 Aug 2021 13:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629293260;
        bh=l2Cm3tSoUaEYuG6eGCNI85E157UIrFk3V+XhEqHXlr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=orWKtVcyp1dUoVKId6ZdKwedKfWNIUZGhmig+CqEKbIvMGPS4B/HsrO6mCSajmvMx
         6WOdjvbuVA6Cy/1WdJI/gGQCrScSV3Na0ofm4inOvDYrXgmIM0KwXWNnQgnRXnzFhb
         I6tfhbklz9q5FauIMmlu6p5BF0aDiFyEVKWp+sJg=
Date:   Wed, 18 Aug 2021 15:27:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hillf Danton <hdanton@sina.com>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH v4] block: genhd: don't call probe function with
 major_names_lock held
Message-ID: <YR0KySFfiDk+s7pn@kroah.com>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
 <4e153910-bf60-2cca-fa02-b46d22b6e2c5@i-love.sakura.ne.jp>
 <YRi9EQJqfK6ldrZG@kroah.com>
 <a3f43d54-8d10-3272-1fbb-1193d9f1b6dd@i-love.sakura.ne.jp>
 <YRjcHJE0qEIIJ9gA@kroah.com>
 <d7d31bf1-33d3-b817-0ce3-943e6835de33@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7d31bf1-33d3-b817-0ce3-943e6835de33@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 18, 2021 at 08:07:32PM +0900, Tetsuo Handa wrote:
> syzbot is reporting circular locking problem at __loop_clr_fd() [1], for
> commit a160c6159d4a0cf8 ("block: add an optional probe callback to
> major_names") is calling the module's probe function with major_names_lock
> held.
> 
> When copying content of /proc/devices to another file via sendfile(),
> 
>   sb_writers#$N => &p->lock => major_names_lock
> 
> dependency is recorded.
> 
> When loop_process_work() from WQ context performs a write request,
> 
>   (wq_completion)loop$M => (work_completion)&lo->rootcg_work =>
>   sb_writers#$N
> 
> dependency is recorded.
> 
> When flush_workqueue() from drain_workqueue() from destroy_workqueue()
>  from __loop_clr_fd() from blkdev_put() from blkdev_close() from __fput()
> is called,
> 
>   &disk->open_mutex => &lo->lo_mutex => (wq_completion)loop$M
> 
> dependency is recorded.
> 
> When loop_control_remove() from loop_control_ioctl(LOOP_CTL_REMOVE) is
> called,
> 
>   loop_ctl_mutex => &lo->lo_mutex
> 
> dependency is recorded.
> 
> As a result, lockdep thinks that there is
> 
>   loop_ctl_mutex => &lo->lo_mutex => (wq_completion)loop$M =>
>   (work_completion)&lo->rootcg_work => sb_writers#$N => &p->lock =>
>   major_names_lock
> 
> dependency chain.
> 
> Then, if loop_add() from loop_probe() from blk_request_module() from
> blkdev_get_no_open() from blkdev_get_by_dev() from blkdev_open() from
> do_dentry_open() from path_openat() from do_filp_open() is called,
> 
>   major_names_lock => loop_ctl_mutex
> 
> dependency is appended to the dependency chain.
> 
> There would be two approaches for breaking this circular dependency.
> One is to kill loop_ctl_mutex => &lo->lo_mutex chain. The other is to
> kill major_names_lock => loop_ctl_mutex chain. This patch implements
> the latter, due to the following reasons.
> 
>  (1) sb_writers#$N => &p->lock => major_names_lock chain is unavoidable
> 
>  (2) this patch can also fix similar problem in other modules [2] which
>      is caused by calling the probe function with major_names_lock held
> 
>  (3) I believe that this patch is principally safer than e.g.
>      commit bd5c39edad535d9f ("loop: reduce loop_ctl_mutex coverage in
>      loop_exit") which waits until the probe function finishes using
>      global mutex in order to fix deadlock reproducible by sleep
>      injection [3]
> 
> This patch adds THIS_MODULE parameter to __register_blkdev() as with
> usb_register(), and drops major_names_lock before calling probe function
> by holding a reference to that module which contains that probe function.
> 
> Since cdev uses register_chrdev() and __register_chrdev(), bdev should be
> able to preserve register_blkdev() and __register_blkdev() naming scheme.

Note, the cdev api is anything but good, so should not be used as an
excuse for anything.  Don't copy it unless you have a very good reason.

Also, what changed in this version?  I see no patch history here :(

thanks,

greg k-h
