Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:57177 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751720AbeCMNIZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Mar 2018 09:08:25 -0400
From: Martin Steigerwald <martin@lichtvoll.de>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [Possible REGRESSION, 4.16-rc4] Error updating SMART data during runtime and could not connect to lvmetad at some boot attempts
Date: Tue, 13 Mar 2018 14:08:23 +0100
Message-ID: <2276139.2HCKFmVDEL@merkaba>
In-Reply-To: <f6e73c8e-1186-744b-c856-2c56ceeeab10@redhat.com>
References: <27165802.vQ9JbjrmvU@merkaba> <f6e73c8e-1186-744b-c856-2c56ceeeab10@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hans de Goede - 11.03.18, 15:37:
> Hi Martin,
> 
> On 11-03-18 09:20, Martin Steigerwald wrote:
> > Hello.
> > 
> > Since 4.16-rc4 (upgraded from 4.15.2 which worked) I have an issue
> > with SMART checks occassionally failing like this:
> > 
> > smartd[28017]: Device: /dev/sdb [SAT], is in SLEEP mode, suspending checks
> > udisksd[24408]: Error performing housekeeping for drive
> > /org/freedesktop/UDisks2/drives/INTEL_SSDSA2CW300G3_[…]: Error updating
> > SMART data: Error sending ATA command CHECK POWER MODE: Unexpected sense
> > data returned:#0120000: 0e 09 0c 00  00 00 ff 00  00 00 00 00  00 00 50
> > 00    ..............P.#0120010: 00 00 00 00  00 00 00 00  00 00 00 00  00
> > 00 00 00    ................#012 (g-io-error-quark, 0) merkaba
> > udisksd[24408]: Error performing housekeeping for drive
> > /org/freedesktop/UDisks2/drives/Crucial_CT480M500SSD3_[…]: Error updating
> > SMART dat a: Error sending ATA command CHECK POWER MODE: Unexpected sense
> > data returned:#0120000: 01 00 1d 00  00 00 0e 09  0c 00 00 00  ff 00 00
> > 00    ................#0120010: 00 0 0 00 00  50 00 00 00  00 00 00 00 
> > 00 00 00 00    ....P...........#012 (g-io-error-quark, 0)
> > 
> > (Intel SSD is connected via SATA, Crucial via mSATA in a ThinkPad T520)
> > 
> > However when I then check manually with smartctl -a | -x | -H the device
> > reports SMART data just fine.
> > 
> > As smartd correctly detects that device is in sleep mode, this may be an
> > userspace issue in udisksd.
> > 
> > Also at some boot attempts the boot hangs with a message like "could not
> > connect to lvmetad, scanning manually for devices". I use BTRFS RAID 1
> > on to LVs (each on one of the SSDs). A configuration that requires a
> > manual
> > adaption to InitRAMFS in order to boot (basically vgchange -ay before
> > btrfs device scan).
> > 
> > I wonder whether that has to do with the new SATA LPM policy stuff, but as
> > I had issues with
> > 
> >   3 => Medium power with Device Initiated PM enabled
> > 
> > (machine did not boot, which could also have been caused by me
> > accidentally
> > removing all TCP/IP network support in the kernel with that setting)
> > 
> > I set it back to
> > 
> > CONFIG_SATA_MOBILE_LPM_POLICY=0
> > 
> > (firmware settings)
> 
> Right, so at that settings the LPM policy changes are effectively
> disabled and cannot explain your SMART issues.

Yes, I now good a photo of one of those boot failures I mentioned, at it seems 
to be related to blk-mq, as the backtrace contains "blk_mq_terminate_expired".

I add the screenshot to my bug report.

[Possible REGRESSION, 4.16-rc4] Error updating SMART data during runtime and 
boot failures with blk_mq_terminate_expired in backtrace
https://bugzilla.kernel.org/show_bug.cgi?id=199077

Hans, I will test your LPM policy horkage for Crucial m500 patch at a later 
time. I first wanted to add the photo of the boot failure to the bug report.

Ming and Bart, I added you to cc, cause I had to do with you about another 
blk-mq report, please feel free to adapt.

Thanks,
-- 
Martin
