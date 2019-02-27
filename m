Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D027C00319
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 10:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBA020830
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 10:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbfB0KaY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:30:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:42190 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725993AbfB0KaY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 05:30:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 164E4B125;
        Wed, 27 Feb 2019 10:30:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D3BA31E4263; Wed, 27 Feb 2019 11:30:22 +0100 (CET)
Date:   Wed, 27 Feb 2019 11:30:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Thomas Lindroth <thomas.lindroth@gmail.com>
Cc:     jack@suse.cz, linux-block@vger.kernel.org, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Regression caused by loopback related patches in 4.14.95
Message-ID: <20190227103022.GA27119@quack2.suse.cz>
References: <44a918ac-55fe-b7d3-5a4d-97acf3e38d95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44a918ac-55fe-b7d3-5a4d-97acf3e38d95@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello!

Thanks for the detailed report and bisection!

On Wed 27-02-19 00:35:26, Thomas Lindroth wrote:
> When I run "losetup --verbose --partscan --read-only --find
> /mnt/gemini.61rn.3T/Backups/debian.raw" on a 4.14.103 system losetup
> hangs for exactly 3 minutes. After the hang the loopback device works
> like it should. The /mnt/gemini.61rn.3T mount is an ext4 fs on dm-crypt
> on a spinning sata disk.
> 
> The hang was introduced in 4.14.95 and there are several loop related
> patches in 4.14.95.  I bisected it down to commit
> c1e63df4f30c3918476ac9bc594355b0e9629893 "loop: Get rid of
> loop_index_mutex". Reverting that commit from 4.14.103 also fixes the
> problem.

So as you mention below, all the problems with loop device deadlocks didn't
get fixed in stable kernels as some changes were too intrusive for the
stable tree. Now unfortunately the commit 0a42e99b58a "loop: Get rid of
loop_index_mutex" that did get backported makes some deadlocks much easier
to hit as I'm looking into that now. For example when partitions are reread in
loop_set_status(), it takes just one process trying to open the loop device
to deadlock the kernel.

Actually that commit got already reverted in 4.4 stable because I've
pointed out to Greg earlier that it has a doubtful benefit without followup
fixes. But sadly it remained in other stable branches. Now going through
the active branches the summary seems to be:

3.18 and older: never applied
4.4:  already reverted
4.9:  needs revert
4.14: needs revert
4.19 and newer: followup fixes applied

So Greg, can you please revert the same three commits that you've reverted
in 4.4 also in 4.9 and 4.14 stable threes? These are:

0a42e99b58a "loop: Get rid of loop_index_mutex"
967d1dc144b "loop: Fold __loop_release into loop_release"
628bd859470 "loop: Fix double mutex_unlock(&loop_ctl_mutex) in loop_control_ioctl()"

Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
