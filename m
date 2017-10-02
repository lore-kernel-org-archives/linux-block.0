Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:37966 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751774AbdJBR6y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Oct 2017 13:58:54 -0400
Date: Mon, 2 Oct 2017 20:58:52 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
CC: <axboe@fb.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>
Subject: Re: [PATCH 0/5] lightnvm: pblk: audit mempool usage
Message-ID: <20171002175851.GA6874@hercules.tuxera.com>
References: <1505385227-28706-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <1505385227-28706-1-git-send-email-javier@cnexlabs.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 14, 2017 at 12:33:42PM +0200, Javier Gonz�lez wrote:
> As suggested by Jens [1], I audited all mempools on pblk.
> 
> This patche series (i) fixes bad mempool allocations that did not
> guarantee forward progress and downsizes the sizes of some overused
> mempools, (ii) removes unnecessary checks, and (iii) eliminates some
> mempools that where introduced in early versions of pblk.

All claims made above seem to be addressed in patches correctly to me.

I also did some functional testing of pblk after reviewing.

Feel free to use tag for all patches in this series even though I am
not aware of some aspects of subsystem yet. This series doesn't seem
to touch those.

Reviewed-by: Rakesh Pandit <rakesh@tuxera.com>

> 
> [1] https://patchwork.kernel.org/patch/9940973/
> 
> Javier Gonz�lez (5):
>   lightnvm: pblk: fix min size for page mempool
>   lightnvm: pblk: simplify work_queue mempool
>   lightnvm: pblk: decouple read/erase mempools
>   lightnvm: pblk: do not use a mempool for line bitmaps
>   lightnvm: pblk: remove checks on mempool alloc.
> 
>  drivers/lightnvm/pblk-core.c     | 61 ++++++++++----------------
>  drivers/lightnvm/pblk-gc.c       | 32 +++++++-------
>  drivers/lightnvm/pblk-init.c     | 94 +++++++++++++++++-----------------------
>  drivers/lightnvm/pblk-read.c     | 10 +----
>  drivers/lightnvm/pblk-recovery.c | 37 ++++------------
>  drivers/lightnvm/pblk-write.c    | 32 ++++----------
>  drivers/lightnvm/pblk.h          | 21 +++++----
>  7 files changed, 106 insertions(+), 181 deletions(-)
> 
> -- 
> 2.7.4
> 
