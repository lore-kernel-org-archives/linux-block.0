Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55538 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726378AbeG3WMV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jul 2018 18:12:21 -0400
Message-ID: <1532982936.14893.1.camel@HansenPartnership.com>
Subject: Re: What's the best way to call sd_shutdown() on all SCSI disks on
 shutdown?
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Date: Mon, 30 Jul 2018 13:35:36 -0700
In-Reply-To: <20180730191707.GA28569@thunk.org>
References: <20180730191707.GA28569@thunk.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2018-07-30 at 15:17 -0400, Theodore Y. Ts'o wrote:
> I've been looking at what's the best way to make sure everything gets
> cleanly flushed out to disk on a powerdown.  Right now in
> __orderly_poweroff(), we call emergency_sync() which kicks a
> workqueue to flush all file systems and block devices --- and then we
> immediately power down the system, before the scheduler even has a
> chance to schedule the workqueue thread.  Hopefully userspace has the
> unmounted all file systems, which will has implicitly issued a cache
> flush command, but if we have a userspace program writing to a block
> device directly, currently there's nothing to make sure things will
> get flushed out to the device.
> 
> Beyond that, though, I'm interested in figuring out how to make sure
> that all SCSI devices will receive (and acknowledge) SHUTDOWN command
> so that the disks can be spun down and heads retracted to a safe
> landing zone before we power down the system.

The basic way to do this is to shut down the scsi bus, see below.

> It appears the best way to do this is to call sd_shutdown(), since we
> don't seem to have a high-level "shutdown" concept recognized in the
> block layer (the way we currently, have, say support for "discard").
> 
> So the question is, what's the best way to architect something like
> this.  I could implement a hacky interator loop in the SCSI
> subsystem, and call it directly from __orderly_poweroff in
> kernel/reboot.c.  But I'm pretty sure that would never get accepted
> upstream, and so it would remain a Google data center hack.
> 
> What do people think would be the best way of implementing something
> that would be upstream acceptable?

The sd_shutdown function is fully plumbed in to the current sysfs model
with every scsi device being on a dummy scsi bus. So if you detach the
device from the scsi bus, the remove function (which calls sd_shutdown)
gets called as part of the detach.  At the moment, the way that happens
is either by specific detach of the device or via the module_exit
function of SCSI, so if you can get that called before the system shuts
down everything should just work.  To be honest, I really thought this
did actually happen anyway today.  The separate device_shutdown()
method in the kernel_shutdown_prepare() should call our sd_shutdown
method (eventually), can you investigate why that isn't working for you
... is it being called too late?

Alternatively, if you can find a way to get sysfs to trigger a shutdown
on all its busses at some point then we'll get swept up in that. 
Finally, you could keep a list of busses needing to be shut down for
storage safety and we could add scsi to that.

James
