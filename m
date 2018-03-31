Return-Path: <linux-block-owner@vger.kernel.org>
Received: from tartarus.angband.pl ([89.206.35.136]:49298 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeCaWkK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 31 Mar 2018 18:40:10 -0400
Date: Sun, 1 Apr 2018 00:40:06 +0200
From: Adam Borowski <kilobyte@angband.pl>
To: Chris Murphy <lists@colorremedies.com>
Cc: Btrfs BTRFS <linux-block@vger.kernel.org>
Subject: Re: dead or dying SDXC card fsck's OK but mount hangs indefinitely
Message-ID: <20180331224006.llzkfni4tsuaaveg@angband.pl>
References: <CAJCQCtTTerrYvXpof+jiShO1D8PmaPaFCA9W1PyFxaGs0PZaig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAJCQCtTTerrYvXpof+jiShO1D8PmaPaFCA9W1PyFxaGs0PZaig@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Mar 31, 2018 at 03:50:03PM -0600, Chris Murphy wrote:
> This is perhaps a novelty problem report. And it's also a throw away
> card data wise, and is a $12 Samsung EVO+ SDXC card used in an Intel
> NUC.
> 
> It contains FAT, ext4, and Btrfs file systems. They can all be fsck'd,
> but none can be mounted. Even if it use blockdev --setro on the entire
> mmc device and then mount -o ro it still fails. Kinda weird huh?

> [69107.488123] mmc0: Card stuck in programming state! mmcblk0 card_busy_detect
> [69107.539128] mmc0: Tuning timeout, falling back to fixed sampling clock

> The corrupt 10 was fixed with a scrub months ago, and I never reset
> the counter so that's not a current corruption. The most recent scrub
> was maybe a week ago. And even offline scrub works. So literally every
> single block related to this Btrfs file system is readable, and yet
> it's not mountable? Very weird.

> Basically the card is in some sort of state that the kernel code is
> not going to ever second guess. So there's no further error or reset
> attempt.

As the SD card is tiny compared to any hard disks (be they spinning or
solid), I'd dd it as an image as the first step.

This in general is a wise step for any kind of recovery, but in your case
it's especially easy.  It also lets you separate hardware issues from
filesystem corruption.


Meow!
-- 
ᛊᚨᚾᛁᛏᚣ᛫ᛁᛊ᛫ᚠᛟᚱ᛫ᚦᛖ᛫ᚹᛖᚨᚲ
