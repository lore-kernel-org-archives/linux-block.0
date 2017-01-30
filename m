Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:33383 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753373AbdA3NFl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2017 08:05:41 -0500
Received: by mail-io0-f174.google.com with SMTP id v96so10053534ioi.0
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2017 05:05:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq6wzw=_6oc=hyW3B_tBAGfqzrixoy-gr=ki=M2wyhiNg@mail.gmail.com>
References: <20170124101757.19676-1-linus.walleij@linaro.org>
 <CAPDyKFrB9UfkfGD08fTKegSB2W65pdWuDU=10mGukQmB=yhaqQ@mail.gmail.com> <CAPDyKFq6wzw=_6oc=hyW3B_tBAGfqzrixoy-gr=ki=M2wyhiNg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 30 Jan 2017 14:05:39 +0100
Message-ID: <CACRpkdaL0qNXKOp9J-yLAN3njPoViE7iGtCr=mhmPGHdY+9LBQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] mmc: block: command issue cleanups
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 27, 2017 at 8:58 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

>>> Linus Walleij (6):
>>>   mmc: block: break out mmc_blk_rw_cmd_abort()
>>>   mmc: block: break out mmc_blk_rw_start_new()
>>>   mmc: block: do not assign mq_rq when aborting command
>>>   mmc: block: inline command abortions
>>>   mmc: block: introduce new_areq and old_areq
>>>   mmc: block: stop passing around pointless return values
(...)
> Seems like this series may have issues. I have looked at boot reports
> from kernelci, and particular the reports for
> https://kernelci.org/boot/sun7i-a20-bananapi/job/ulfh/ are
> interesting.
>
> Apparently, this board has an SD card attached. There have been errors
> reported in the log for a while when doing data transfers, although
> none of these errors have triggered the kernelci to report a boot
> error.

Damned I wish I could be hands-on with this system and bisect
it. It's very helpful with shaky systems really. Sadly the errors are
hard to reproduce :(

The old errors look like so:

[    6.099124] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 18, RD SBE !!
[    6.105211] sunxi-mmc 1c0f000.mmc: data error, sending stop command
[    6.122394] mmcblk0: timed out sending r/w cmd command, card status 0x900
[    6.665013] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 18, RD DTO !!
[    6.671011] sunxi-mmc 1c0f000.mmc: data error, sending stop command
[    6.677812] mmcblk0: timed out sending r/w cmd command, card status 0x900
[    7.123727] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 18, RD DTO !!
[    7.129692] sunxi-mmc 1c0f000.mmc: data error, sending stop command
[    7.136489] mmcblk0: timed out sending r/w cmd command, card status 0x900
[    7.143349] blk_update_request: I/O error, dev mmcblk0, sector 124800
[    7.493691] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 18, RD DTO !!
[    7.499651] sunxi-mmc 1c0f000.mmc: data error, sending stop command
[    7.506229] mmcblk0: timed out sending r/w cmd command, card status 0x900
[    7.943641] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 18, RD DTO !!
[    7.949595] sunxi-mmc 1c0f000.mmc: data error, sending stop command
[    7.956222] mmcblk0: timed out sending r/w cmd command, card status 0x900
[    7.963010] blk_update_request: I/O error, dev mmcblk0, sector 124800
[    7.969499] Buffer I/O error on dev mmcblk0p1, logical block 15344,
async page read
[    8.321411] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 18, RD DTO !!
[    8.327378] sunxi-mmc 1c0f000.mmc: data error, sending stop command
[    8.334018] mmcblk0: timed out sending r/w cmd command, card status 0x900
[    8.763338] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 18, RD DTO !!
[    8.769276] sunxi-mmc 1c0f000.mmc: data error, sending stop command
[    8.775960] mmcblk0: timed out sending r/w cmd command, card status 0x900
[    8.782750] blk_update_request: I/O error, dev mmcblk0, sector 124928
[    9.125126] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 18, RD DTO !!
[    9.131084] sunxi-mmc 1c0f000.mmc: data error, sending stop command
[    9.137624] mmcblk0: timed out sending r/w cmd command, card status 0x900
[    9.144445] blk_update_request: I/O error, dev mmcblk0, sector 124928
[    9.150881] Buffer I/O error on dev mmcblk0p2, logical block 0,
async page read

So something was causing errors on the read command.

> However, I suspect that some of the changes in this series make it
> worse. Perhaps because of a changed error handling the mmc block
> layer!?
>
> Particular, look at the difference between these [1] boot logs, it
> might give you some hints. I have also added Maxime to this thread,
> perhaps he can help out with the sunxi mmc driver.

The new errors look like so:

[    6.099171] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 18, RD SBE !!
[    6.105259] sunxi-mmc 1c0f000.mmc: data error, sending stop command
[    6.127415] mmcblk0: timed out sending r/w cmd command, card status 0x900
[    6.666628] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 18, RD DTO !!
[    6.672626] sunxi-mmc 1c0f000.mmc: data error, sending stop command
[    6.679420] mmcblk0: timed out sending r/w cmd command, card status 0x900
[    7.503256] sunxi-mmc 1c0f000.mmc: fatal err update clk timeout
[    8.623257] sunxi-mmc 1c0f000.mmc: fatal err update clk timeout

This "fatal err update clk timeout" is new and is coming from the driver.

[    8.630370] mmc0: tried to reset card, got error -5
[    8.635309] blk_update_request: I/O error, dev mmcblk0, sector 124800
[    8.642366] mmcblk0: error -5 sending status command, retrying
[    8.648279] mmcblk0: error -5 sending status command, retrying
[    8.654132] mmcblk0: error -5 sending status command, aborting
[    8.659961] blk_update_request: I/O error, dev mmcblk0, sector 7167872
[    8.667201] mmcblk0: error -5 sending status command, retrying
[    8.673031] mmcblk0: error -5 sending status command, retrying
[    8.678916] mmcblk0: error -5 sending status command, aborting
[    8.684758] blk_update_request: I/O error, dev mmcblk0, sector 124800
[    8.691195] Buffer I/O error on dev mmcblk0p1, logical block 15344,
async page read
[    8.700492] mmcblk0: error -5 sending status command, retrying
[    8.706405] mmcblk0: error -5 sending status command, retrying
[    8.712232] mmcblk0: error -5 sending status command, aborting
[    8.718103] blk_update_request: I/O error, dev mmcblk0, sector 7167872
[    8.724643] Buffer I/O error on dev mmcblk0p2, logical block
880368, async page read
[    8.732403] Unable to handle kernel NULL pointer dereference at
virtual address 00000028
[    8.740501] pgd = c0004000
[    8.743204] [00000028] *pgd=00000000
[    8.746794] Internal error: Oops: 17 [#1] SMP ARM
[    8.751491] Modules linked in:
[    8.754547] CPU: 0 PID: 65 Comm: mmcqd/0 Not tainted
4.10.0-rc5-00097-ge1defa2da4d3 #1
[    8.762450] Hardware name: Allwinner sun7i (A20) Family
[    8.767666] task: ee9b0fc0 task.stack: ee9d8000
[    8.772201] PC is at mmc_blk_rw_rq_prep+0x20/0x39c
[    8.776985] LR is at mmc_blk_issue_rw_rq+0x124/0x370

And now it is crashing at mmc_blk_rw_rq_prep() + 0x20 so I suspect it is one of
these:

struct mmc_blk_request *brq = &mqrq->brq;
struct request *req = mqrq->req;
struct mmc_blk_data *md = mq->blkdata;

I guess the first: mqrq is NULL.

So I suspect the oneliner in commit 0ebd6e72b5ee2592625d5ae567a729345dfe07b6
"mmc: block: do not assign mq_rq when aborting command"

That is not easily reverted so I will sent a RTF patch to restore the behaviour.

Yours,
Linus Walleij
