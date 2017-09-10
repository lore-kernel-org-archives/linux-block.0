Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.mpynet.fi ([82.197.21.84]:18865 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751511AbdIJTOc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Sep 2017 15:14:32 -0400
Date: Sun, 10 Sep 2017 22:14:30 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: Re: [PATCH] lightnvm: prevent bd removal if busy
Message-ID: <20170910191430.GA7352@hercules.tuxera.com>
References: <20170907135825.GA44302@dhcp-216.srv.tuxera.com>
 <d5587325-11b0-a50f-c260-b20f344c0cfc@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <d5587325-11b0-a50f-c260-b20f344c0cfc@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Sep 08, 2017 at 12:42:47PM +0200, Matias Bj�rling wrote:
> On 09/07/2017 03:58 PM, Rakesh Pandit wrote:
> > Removal of virtual block device by "nvm lnvm remove..." undergoing IO
> > and created by "nvme lnvm create... -t pblk" results in following and
> > is annoying.
> > 
> > 446416.309757] bdi-block not registered
> > [446416.309773] ------------[ cut here ]------------
> > [446416.309780] WARNING: CPU: 3 PID: 4319 at fs/fs-writeback.c:2159 __mark_inode_dirty+0x268/0x340
> > .....
> > 
> > This patch solves this by checking bd_openers for each partition
> > before removal can continue.  Note that this isn't full proof as
> > device can become busy as soon as it's bd_mutex is unlocked but it
> > needn't be full proof either.  It does work for general case where
> > device is mounted and removal can be prevented.
> > 
> > Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
[..]
> > +	while ((part = disk_part_iter_next(&piter))) {
> 
> A race condition can occur where disk_part_next tries to pblk (in
> block/genhd.c), and it in the meantime has been set to NULL. Leading to a
> kernel crash. Is there a better way to do it?
> 
> [root@localhost ~]# nvme lnvm remove -n pblk0
> [ 5262.338647] BUG: unable to handle kernel NULL pointer dereference at
> 0000000000000010
> [ 5262.340769] IP: disk_part_iter_next+0xd3/0xf0

Thanks, indeed partition can go away from our feet if we don't lock
the whole thing from changing and not just individual partition locks.

I have given it another go which should avoid taking mutex locks on
bdev.  Posted V2.
