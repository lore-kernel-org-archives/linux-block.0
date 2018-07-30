Return-Path: <linux-block-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:44034 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730482AbeG3Uxe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jul 2018 16:53:34 -0400
Date: Mon, 30 Jul 2018 15:17:07 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: What's the best way to call sd_shutdown() on all SCSI disks on
 shutdown?
Message-ID: <20180730191707.GA28569@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I've been looking at what's the best way to make sure everything gets
cleanly flushed out to disk on a powerdown.  Right now in
__orderly_poweroff(), we call emergency_sync() which kicks a workqueue
to flush all file systems and block devices --- and then we
immediately power down the system, before the scheduler even has a
chance to schedule the workqueue thread.  Hopefully userspace has the
unmounted all file systems, which will has implicitly issued a cache
flush command, but if we have a userspace program writing to a block
device directly, currently there's nothing to make sure things will
get flushed out to the device.

Beyond that, though, I'm interested in figuring out how to make sure
that all SCSI devices will receive (and acknowledge) SHUTDOWN command
so that the disks can be spun down and heads retracted to a safe
landing zone before we power down the system.

It appears the best way to do this is to call sd_shutdown(), since we
don't seem to have a high-level "shutdown" concept recognized in the
block layer (the way we currently, have, say support for "discard").

So the question is, what's the best way to architect something like
this.  I could implement a hacky interator loop in the SCSI subsystem,
and call it directly from __orderly_poweroff in kernel/reboot.c.  But
I'm pretty sure that would never get accepted upstream, and so it
would remain a Google data center hack.

What do people think would be the best way of implementing something
that would be upstream acceptable?

Thanks,

						- Ted
