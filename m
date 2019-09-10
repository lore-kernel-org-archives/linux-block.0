Return-Path: <SRS0=q0Gp=XF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B1CC49ED7
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 16:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C342089F
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 16:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436508AbfIJQ1L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Sep 2019 12:27:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34017 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436494AbfIJQ1L (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Sep 2019 12:27:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC52C3016F49;
        Tue, 10 Sep 2019 16:27:10 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A009C60BFB;
        Tue, 10 Sep 2019 16:27:10 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 9008224F2F;
        Tue, 10 Sep 2019 16:27:10 +0000 (UTC)
Date:   Tue, 10 Sep 2019 12:27:10 -0400 (EDT)
From:   Jan Stancek <jstancek@redhat.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        systemd-devel@lists.freedesktop.org,
        Jan Stancek <jstancek@redhat.com>
Message-ID: <1802022622.11216716.1568132830207.JavaMail.zimbra@redhat.com>
In-Reply-To: <87r24o24eo.fsf@mail.parknet.co.jp>
References: <fc8878aeefea128c105c49671b2a1ac4694e1f48.1567468225.git.jstancek@redhat.com> <87v9u3xf5q.fsf@mail.parknet.co.jp> <339755031.10549626.1567969588805.JavaMail.zimbra@redhat.com> <87r24o24eo.fsf@mail.parknet.co.jp>
Subject: Re: [PATCH] fat: fix corruption in fat_alloc_new_dir()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.17.163, 10.4.195.13]
Thread-Topic: fix corruption in fat_alloc_new_dir()
Thread-Index: btCRHWvdReVkaymHhT2xSAQwL/tLmw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 10 Sep 2019 16:27:11 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



----- Original Message -----
> Jan Stancek <jstancek@redhat.com> writes:
> 
> >> Using the device while mounting same device doesn't work reliably like
> >> this race. (getblk() is intentionally used to get the buffer to write
> >> new data.)
> >
> > Are you saying this is expected even if 'usage' is just read?
> 
> Yes, assuming exclusive access.

Seems we were lucky so far to only hit this with FAT.

I also tried couple variations of reproducer:

- Disabling udevd and running just "blkid --probe" in parallel
  also reproduced it
- Disabling udevd and running read() on first 1024 sectors in parallel
  also reproduced it
- aio_read() submitted prior to mount could reproduce it,
  as long as fd was held open
- I couldn't reproduce it with fadvise/madvise WILLNEED submitted prior to mount

> 
> >> mount(2) internally opens the device by EXCL mode, so I guess udev opens
> >> without EXCL (I dont know if it is intent or not).
> >
> > I gave this a try and added O_EXCL to udev-builtin-blkid.c. My system had
> > trouble
> > booting, it was getting stuck on mounting LVM volumes.
> >
> > So, I'm not sure how to move forward here.
> 
> OK. I'm still think the userspace should avoid to use blockdev while
> mounting though, this patch will workaround this race with small race.

https://systemd.io/BLOCK_DEVICE_LOCKING.html mentions flock(LOCK_EX) as a way
to avoid probing while "another program concurrently modifies a superblock or
partition table". Adding flock(LOCK_EX) works around the problem too, but that
would address problem only for LTP (and tools/scripts that use this approach).

> 
> Can you test this?
> 
> Thanks.
> --
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> 
> 
> [PATCH] fat: Workaround the race with userspace's read via blockdev while
> mounting

I ran reproducer on patched kernel for 5 hours, it made over 25000 iterations,
there was no corruption. Thank you for looking at this.

Regards,
Jan
