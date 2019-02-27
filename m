Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E22C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 14:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFCC2147C
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 14:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551276670;
	bh=6zWpu1KfPOF4n1EgwLcmU6V+XXwuWHmvNoEutpLKwDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tPyw9BtGGZFxJSV+C/y/E0dWZn+RXX112A+3w7X4oEOG8+A22xFw+Rxa181YQTz/r
	 NuYpjr0DwotB/XW9PqDJQImB4dd82wY03WUaNBlXMgbl+4JzLRKakVwR6GuVj+US/3
	 J+18m4QaOfT5n6gtLSMCoeA6oWcZPaiIszCjBFek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfB0OLJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:11:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbfB0OLJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 09:11:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C33E2083D;
        Wed, 27 Feb 2019 14:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551276668;
        bh=6zWpu1KfPOF4n1EgwLcmU6V+XXwuWHmvNoEutpLKwDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FpOgzMIen+kfJJIyPWavEauNgQJ3B7FkDv+TQIBpTzpfm/4YQbTRwJ/bWj6O8OQT5
         5WhIq0KLYr/j57IskiS3r+B+W2C5J8gBtAxMvvCvtzrDS0Ypf0KyVB0N8Bvv9ids8L
         ff7iPHM2Ko7ry8YxpX8Jgg9rl9X6jyJ3geW0bVBQ=
Date:   Wed, 27 Feb 2019 15:11:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Thomas Lindroth <thomas.lindroth@gmail.com>,
        linux-block@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Regression caused by loopback related patches in 4.14.95
Message-ID: <20190227141100.GA2746@kroah.com>
References: <44a918ac-55fe-b7d3-5a4d-97acf3e38d95@gmail.com>
 <20190227103022.GA27119@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227103022.GA27119@quack2.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 27, 2019 at 11:30:22AM +0100, Jan Kara wrote:
> Hello!
> 
> Thanks for the detailed report and bisection!
> 
> On Wed 27-02-19 00:35:26, Thomas Lindroth wrote:
> > When I run "losetup --verbose --partscan --read-only --find
> > /mnt/gemini.61rn.3T/Backups/debian.raw" on a 4.14.103 system losetup
> > hangs for exactly 3 minutes. After the hang the loopback device works
> > like it should. The /mnt/gemini.61rn.3T mount is an ext4 fs on dm-crypt
> > on a spinning sata disk.
> > 
> > The hang was introduced in 4.14.95 and there are several loop related
> > patches in 4.14.95.  I bisected it down to commit
> > c1e63df4f30c3918476ac9bc594355b0e9629893 "loop: Get rid of
> > loop_index_mutex". Reverting that commit from 4.14.103 also fixes the
> > problem.
> 
> So as you mention below, all the problems with loop device deadlocks didn't
> get fixed in stable kernels as some changes were too intrusive for the
> stable tree. Now unfortunately the commit 0a42e99b58a "loop: Get rid of
> loop_index_mutex" that did get backported makes some deadlocks much easier
> to hit as I'm looking into that now. For example when partitions are reread in
> loop_set_status(), it takes just one process trying to open the loop device
> to deadlock the kernel.
> 
> Actually that commit got already reverted in 4.4 stable because I've
> pointed out to Greg earlier that it has a doubtful benefit without followup
> fixes. But sadly it remained in other stable branches. Now going through
> the active branches the summary seems to be:
> 
> 3.18 and older: never applied
> 4.4:  already reverted
> 4.9:  needs revert
> 4.14: needs revert
> 4.19 and newer: followup fixes applied
> 
> So Greg, can you please revert the same three commits that you've reverted
> in 4.4 also in 4.9 and 4.14 stable threes? These are:
> 
> 0a42e99b58a "loop: Get rid of loop_index_mutex"
> 967d1dc144b "loop: Fold __loop_release into loop_release"
> 628bd859470 "loop: Fix double mutex_unlock(&loop_ctl_mutex) in loop_control_ioctl()"

Now all reverted, sorry about this.

greg k-h
