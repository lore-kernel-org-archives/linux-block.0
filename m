Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9772CC48BCF
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 16:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74244613CA
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 16:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhFIQsi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 12:48:38 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40880 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhFIQsh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 12:48:37 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3400420B7188;
        Wed,  9 Jun 2021 09:46:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3400420B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623257202;
        bh=Bqt1lVTZISrS178wzklg4SHx5gFwo1MfoQwvBPoV7aM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HR9QMe6V9Nvprm7jqe5A6zaZU87b1aYbEhzqE9wA/yYI3t4zdVeJ+gfogPor7kXlG
         3UbpIKX9g48D4/KeKYNxNVX/GtB+wsjEyoEzujgRII44ouUwazO3/KZ//1PnhtO6lE
         4+3EIzQ6NHkQBsySXZR7qzaigc8MHmuQvhh2R6YU=
Date:   Wed, 9 Jun 2021 11:46:39 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block <linux-block@vger.kernel.org>,
        syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>,
        Petr Vorel <pvorel@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [syzbot] possible deadlock in del_gendisk
Message-ID: <20210609164639.GM4910@sequoia>
References: <000000000000ae236f05bfde0678@google.com>
 <1435f266-9f6d-22ef-ba7d-f031c616aede@I-love.SAKURA.ne.jp>
 <7b8c9eeb-789d-e5e6-04d6-130ee8be7305@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b8c9eeb-789d-e5e6-04d6-130ee8be7305@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021-06-10 01:31:17, Tetsuo Handa wrote:
> Hello, Christoph.
> 
> I'm currently trying full bisection.
> 
>   # bad: [fc0586062816559defb14c947319ef8c4c326fb3] Merge tag 'for-5.13/drivers-2021-04-27' of git://git.kernel.dk/linux-block
>   # good: [42dec9a936e7696bea1f27d3c5a0068cd9aa95fd] Merge tag 'perf-core-2021-04-28' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>   # good: [68a32ba14177d4a21c4a9a941cf1d7aea86d436f] Merge tag 'drm-next-2021-04-28' of git://anongit.freedesktop.org/drm/drm
>   # good: [a800abd3ecb9acc55821f7ac9bba6c956b36a595] net: enetc: move skb creation into enetc_build_skb
>   # good: [6cc8e7430801fa238bd7d3acae1eb406c6e02fe1] loop: scale loop device by introducing per device lock

Thanks for doing this. I haven't had a chance to retry this commit with
lockdep but I did re-review it and didn't think that it would be the
cause of this lockdep report since it strictly reduced the usage of the
loop_ctl_mutex.

Tyler

>   git bisect start 'fc0586062816559defb14c947319ef8c4c326fb3' '42dec9a936e7696bea1f27d3c5a0068cd9aa95fd' '68a32ba14177d4a21c4a9a941cf1d7aea86d436f' 'a800abd3ecb9acc55821f7ac9bba6c956b36a595' '6cc8e7430801fa238bd7d3acae1eb406c6e02fe1'
>   # good: [2958a995edc94654df690318df7b9b49e5a3ef88] block/rnbd-clt: Support polling mode for IO latency optimization
>   git bisect good 2958a995edc94654df690318df7b9b49e5a3ef88
> 
> I think we will bisect this problem to
> 
>   commit c76f48eb5c084b1e ("block: take bd_mutex around delete_partitions in del_gendisk")
> 
> because that commit introduced new locking dependency bdev_lookup_sem => disk->part0->bd_mutex
> which matches the lockdep's report.
> 
>   ======================================================
>   WARNING: possible circular locking dependency detected
>   5.12.0-rc6-next-20210409-syzkaller #0 Not tainted
>   ------------------------------------------------------
>   syz-executor.4/10285 is trying to acquire lock:
>   ffff8881423245a0 (&bdev->bd_mutex){+.+.}-{3:3}, at: del_gendisk+0x250/0x9e0 block/genhd.c:618
>   
>   but task is already holding lock:
>   ffffffff8c7d9430 (bdev_lookup_sem){++++}-{3:3}, at: del_gendisk+0x222/0x9e0 block/genhd.c:616
> 
> Do we need to revert "partition iteration simplifications" work?
> 
> On 2021/06/07 19:56, Tetsuo Handa wrote:
> > Hello.
> > 
> > syzbot is reporting "possible deadlock in del_gendisk" problem.
> > 
> > I guess this is caused by commit 6cc8e7430801fa23 ("loop: scale loop device
> > by introducing per device lock") because it touches loop_ctl_mutex usage
> > between v5.11 and v5.12-rc1. Please have a look.
> > 
> > On 2021/04/14 2:33, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    e99d8a84 Add linux-next specific files for 20210409
> >> git tree:       linux-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=13b01681d00000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd69574979bfeb7
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=61e04e51b7ac86930589
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148265d9d00000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a981a1d00000
> > 
> 
