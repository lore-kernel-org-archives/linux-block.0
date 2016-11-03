Return-Path: <prvs=0115b0b9d1=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>
CC: <hch@lst.de>
Subject: [PATCHSET v2] block: IO polling improvements
Date: Thu, 3 Nov 2016 13:45:02 -0600
Message-ID: <1478202307-1947-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Fixed a few bugs in this, and addressed some review comments. Patches
are against my 4.10 block branch, for-4.10/block.

Some performance results, running random reads against a fast device,
using either IRQ driven completions, classic polled, or the new hybrid
polled:

Method		IOPS		CPU%		IOPS/CPU%
=========================================================
IRQ		476K		48.45%		 9843
Poll		897K		99.9%		 8982
Hybrid		836K		68.1%		12273

Classic polling is still a bit faster, but is uses a lot more CPU. The
rightmost column is an efficiency metric, and with the new hybrid
scheme, we're both faster and more efficient than IRQ driven. We should
be able to close the speed gap as well, so you can have your cake and
eat it too.

I've adjusted the default, so that classic polling is the default poll
method. To enable hybrid polling for a device, you would do:

# echo 0 > /sys/block/<dev>/queue/io_poll_delay

Also see the last patch for the other values this can be set to.
