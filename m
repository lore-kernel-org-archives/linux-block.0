Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B455BC433EF
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 21:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B5F61073
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 21:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhKCVld (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 17:41:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229698AbhKCVlc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Nov 2021 17:41:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CFEE60E52;
        Wed,  3 Nov 2021 21:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635975535;
        bh=+SMBeReyddr18eZ5XGQI9t9/e9IhOx0nYZvtCGoRhfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X1sqyLjKTfJHRnIgVWq8czHLxb1cBHBMLydq/CqDnEsEHIm5pRYdyh0FQWj2QY3zt
         n6myAFtxqzV4hSQWwcv6Yg23KmID5c+e2cnKnNth6DIQM1KjSOnKHke6lkmC/MLLvP
         T+WYlXK6k42lKmHAHAHWg/aZ8Sw5vWSo3fZQlotfbNMKUYekcTCxJuCfadoXw6rdxd
         jAg9Oe/5IblPHRnmD04VsfbBI2Hyb/cEaGFl+EMUjuwPVl1Hr9tm8XcEHeS/LdWAXk
         +9CIWKhe2SZtB5RudLp4lxV4BmFVu0hrfSIU4Hrm1EOaSlxq1RuxaPge9dUZBcu3t+
         xiKPY+p9KLJMA==
Date:   Wed, 3 Nov 2021 14:38:53 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kernel test robot <oliver.sang@intel.com>, lkp@lists.01.org,
        lkp@intel.com, linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [nvme] f9c499bbbf: nvme nvme0: Identify Controller failed (16641)
Message-ID: <20211103213853.GA2654246@dhcp-10-100-145-180.wdc.com>
References: <20211103141454.GA30634@xsang-OptiPlex-9020>
 <e6f09b9b-386a-8a26-7c4b-c528791f7c9a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6f09b9b-386a-8a26-7c4b-c528791f7c9a@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 03, 2021 at 01:51:18PM -0600, Jens Axboe wrote:
> On 11/3/21 8:14 AM, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: f9c499bbbf603389abad60d1931c16b2f96dee06 ("[PATCH 1/2] nvme: move command clear into the various setup helpers")
> > url: https://github.com/0day-ci/linux/commits/Jens-Axboe/nvme-move-command-clear-into-the-various-setup-helpers/20211018-214956
> > base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 519d81956ee277b4419c723adfb154603c2565ba
> > patch link: https://lore.kernel.org/linux-block/20211018124934.235658-2-axboe@kernel.dk
> > 
> > in testcase: will-it-scale
> > version: will-it-scale-x86_64-a34a85c-1_20211029
> > with following parameters:
> > 
> > 	nr_task: 50%
> > 	mode: process
> > 	test: readseek1
> > 	cpufreq_governor: performance
> > 	ucode: 0x700001e
> > 
> > test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> > test-url: https://github.com/antonblanchard/will-it-scale
> > 
> > 
> > on test machine: 144 threads 4 sockets Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > 
> > 
> > [   38.907274][  T868] nvme nvme0: pci function 0000:24:00.0
> > [   38.924627][ T1103] scsi host0: ahci
> > 0m.
> > [   38.948010][  T773] nvme nvme0: Identify Controller failed (16641)
> > [   38.951220][ T1103] scsi host1: ahci
> > [   38.954193][  T773] nvme nvme0: Removing after probe failure status: -5
> 
> This is odd, looks like it's saying invalid opcode. Looking at the probe
> path, it's pretty standard and the command passed in is cleared already.
> So not quite sure why the patch would make a difference here. I'll
> poke at it.

It's actually an Invalid Queue Identifier error (0x4101). That error
makes no sense for an Identify command, so it sounds like the controller
observed a different opcode than the driver intended to send, which
seems odd; I didn't observe any problems and I'm pretty sure I'm running
the same code. I'll take a second look as well.
