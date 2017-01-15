Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38362 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750809AbdAOKML (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Jan 2017 05:12:11 -0500
Received: by mail-wm0-f43.google.com with SMTP id r144so133194430wme.1
        for <linux-block@vger.kernel.org>; Sun, 15 Jan 2017 02:12:11 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCHSET v6] blk-mq scheduling framework
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1484170803-9311-1-git-send-email-axboe@fb.com>
Date: Sun, 15 Jan 2017 11:12:01 +0100
Cc: Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>,
        bart.vanassche@sandisk.com
Message-Id: <C14FF2E2-886B-4EFD-8FBB-7DC528B02373@linaro.org>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
To: Jens Axboe <axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 11 gen 2017, alle ore 22:39, Jens Axboe <axboe@fb.com> ha =
scritto:
>=20
> Another year, another posting of this patchset. The previous posting
> was here:
>=20
> https://www.spinics.net/lists/kernel/msg2406106.html
>=20
> (yes, I've skipped v5, it was fixes on top of v4, not the rework).
>=20
> I've reworked bits of this to get rid of the shadow requests, thanks
> to Bart for the inspiration. The missing piece, for me, was the fact
> that we have the tags->rqs[] indirection array already. I've done this
> somewhat differently, though, by having the internal scheduler tag
> map be allocated/torn down when an IO scheduler is attached or
> detached. This also means that when we run without a scheduler, we
> don't have to do double tag allocations, it'll work like before.
>=20
> The patchset applies on top of 4.10-rc3, or can be pulled here:
>=20
> git://git.kernel.dk/linux-block blk-mq-sched.6
>=20
>=20

Hi Jens,
I have checked this new version to find solutions to the apparent
errors, mistakes or just unclear parts (to me) that I have pointed out
before Christmas last year.  But I have found no changes related to
these problems.

As I have already written, I'm willing to try to fix those errors
myself, if they really are errors, but I would first need at least
some minimal initial feedback and guidance.  If needed, tell me how I
can help you get in sync again with these issues (sending my reports
again, sending a digest of them, ...).

Thanks,
Paolo

> block/Kconfig.iosched    |   50 ++++
> block/Makefile           |    3=20
> block/blk-core.c         |   19 -
> block/blk-exec.c         |    3=20
> block/blk-flush.c        |   15 -
> block/blk-ioc.c          |   12=20
> block/blk-merge.c        |    4=20
> block/blk-mq-sched.c     |  354 +++++++++++++++++++++++++++++
> block/blk-mq-sched.h     |  157 ++++++++++++
> block/blk-mq-sysfs.c     |   13 +
> block/blk-mq-tag.c       |   58 ++--
> block/blk-mq-tag.h       |    4=20
> block/blk-mq.c           |  413 +++++++++++++++++++---------------
> block/blk-mq.h           |   40 +++
> block/blk-tag.c          |    1=20
> block/blk.h              |   26 +-
> block/cfq-iosched.c      |    2=20
> block/deadline-iosched.c |    2=20
> block/elevator.c         |  247 +++++++++++++++-----
> block/mq-deadline.c      |  569 =
+++++++++++++++++++++++++++++++++++++++++++++++
> block/noop-iosched.c     |    2=20
> drivers/nvme/host/pci.c  |    1=20
> include/linux/blk-mq.h   |    9=20
> include/linux/blkdev.h   |    6=20
> include/linux/elevator.h |   36 ++
> 25 files changed, 1732 insertions(+), 314 deletions(-)
>=20
> --=20
> Jens Axboe
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


