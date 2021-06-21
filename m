Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA28AC49EA2
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 08:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A582B61164
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 08:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhFUI4x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 04:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhFUI4u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 04:56:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2964060724;
        Mon, 21 Jun 2021 08:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624265668;
        bh=VcbXkDe9DOW5t++lY6Mh89RpWsDOFcnF5LaCm5CLVu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xmzMcAcftuSuGmVHxWPyg82c8VgqbVJWe/R2fZFNNlpRxtGwcDY9wLgnE+F1a0iWQ
         ygf32c0yBJb1/3S4EYAXdGCCAmYhbrV0VZ+x59xsXGZsjoBsiR/He9x4b9V+/nMvbN
         JX2eRKEvBqPPPBp+I/qA1cmpLoQAu7q4l4PxgwKw=
Date:   Mon, 21 Jun 2021 10:54:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Hillf Danton <hdanton@sina.com>, hch@infradead.org,
        axboe@kernel.dk, desmondcheongzx@gmail.com,
        linux-block@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at,
        Shuah Khan <skhan@linuxfoundation.org>,
        syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com,
        vigneshr@ti.com
Subject: Re: [PATCH v2] block: genhd: don't call probe function with
 major_names_lock held
Message-ID: <YNBTwhbJ/uiE8iZe@kroah.com>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
 <YM2STfTN5AupWlSa@kroah.com>
 <20210620024403.820-1-hdanton@sina.com>
 <24b7c3a9-e10a-f983-9fde-1ae66b0bc6b0@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24b7c3a9-e10a-f983-9fde-1ae66b0bc6b0@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jun 20, 2021 at 10:54:20PM +0900, Tetsuo Handa wrote:
> On 2021/06/20 11:44, Hillf Danton wrote:
> > Good craft in regard to triggering the ABBA deadlock, but curious why not
> > move unregister_blkdev out of and before loop_ctl_mutex, given it will also
> > serialise with the prober.
> > 
> 
> Well, something like this untested diff?
> 
> Call unregister_blkdev() as soon as __exit function starts, for calling
> probe function after cleanup started will be unexpected for __exit function.
> 
> Keep probe function no-op until __init function ends, for probe function
> might be called as soon as __register_blkdev() succeeded but calling probe
> function before setup completes will be unexpected for __init function.
> 
>  drivers/block/ataflop.c |    6 +++++-
>  drivers/block/brd.c     |    8 ++++++--
>  drivers/block/floppy.c  |    4 ++++
>  drivers/block/loop.c    |    4 ++--
>  drivers/ide/ide-probe.c |    8 +++++++-
>  drivers/md/md.c         |    5 +++++
>  drivers/scsi/sd.c       |   10 +---------
>  7 files changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
> index d601e49f80e0..3681e8c493b1 100644
> --- a/drivers/block/ataflop.c
> +++ b/drivers/block/ataflop.c
> @@ -1995,6 +1995,7 @@ static int ataflop_alloc_disk(unsigned int drive, unsigned int type)
>  }
>  
>  static DEFINE_MUTEX(ataflop_probe_lock);
> +static bool module_initialize_completed;

This is almost always wrong.

>  
>  static void ataflop_probe(dev_t dev)
>  {
> @@ -2006,6 +2007,8 @@ static void ataflop_probe(dev_t dev)
>  
>  	if (drive >= FD_MAX_UNITS || type >= NUM_DISK_MINORS)
>  		return;
> +	if (!module_initialize_completed)
> +		return;

This is not correct, when you register a callback structure, it can be
instantly called.  Do not expect it to be delayed until later.

thanks,

greg k-h
