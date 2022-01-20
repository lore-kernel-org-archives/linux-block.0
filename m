Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20616C433F5
	for <linux-block@archiver.kernel.org>; Thu, 20 Jan 2022 08:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359138AbiATIRR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jan 2022 03:17:17 -0500
Received: from verein.lst.de ([213.95.11.211]:43482 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359124AbiATIRQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jan 2022 03:17:16 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A0FEE68AA6; Thu, 20 Jan 2022 09:17:12 +0100 (CET)
Date:   Thu, 20 Jan 2022 09:17:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jan Stancek <jstancek@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block <linux-block@vger.kernel.org>, ltp@lists.linux.it
Subject: Re: [PATCH] make autoclear operation synchronous again
Message-ID: <20220120081712.GA4980@lst.de>
References: <03f43407-c34b-b7b2-68cd-d4ca93a993b8@i-love.sakura.ne.jp> <20211229172902.GC27693@lst.de> <4e7b711f-744b-3a78-39be-c9432a3cecd2@i-love.sakura.ne.jp> <20220105060201.GA2261405@janakin.usersys.redhat.com> <2b29ac47-ed8f-3b50-f47c-c080fb83cbd5@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b29ac47-ed8f-3b50-f47c-c080fb83cbd5@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 05, 2022 at 03:10:23PM +0900, Tetsuo Handa wrote:
> On 2022/01/05 15:02, Jan Stancek wrote:
> > On Thu, Dec 30, 2021 at 07:52:34PM +0900, Tetsuo Handa wrote:
> >> OK. Two patches shown below. Are these look reasonable?
> >>
> >>
> >>
> >>> From 1409a49181efcc474fbae2cf4e60cbc37adf34aa Mon Sep 17 00:00:00 2001
> >> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >> Date: Thu, 30 Dec 2021 18:41:05 +0900
> >> Subject: [PATCH 1/2] loop: Revert "loop: make autoclear operation asynchronous"
> >>
> > 
> > Thanks, the revert fixes failures we saw recently in LTP tests,
> > which do mount/umount in close succession:
> > 
> > # for i in `seq 1 2`;do mount -t iso9660 -o loop /root/isofs.iso /mnt/isofs; umount /mnt/isofs/; done
> > mount: /mnt/isofs: WARNING: source write-protected, mounted read-only.
> > mount: /mnt/isofs: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.
> > umount: /mnt/isofs/: not mounted.
> > 
> 
> I'm waiting for Jens to come back to
> https://lkml.kernel.org/r/c205dcd2-db55-a35c-e2ef-20193b5ac0da@i-love.sakura.ne.jp .

So I think the version in this thread is what we should merge.

On top of that we should:

 - remove the probe mechanism (patch already sent)
 - stop taking open_mutex in del_gendisk and bdev_disk_changed (I have
   a series for that now)
