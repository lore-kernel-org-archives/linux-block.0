Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759969AbcLWAD7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Dec 2016 19:03:59 -0500
Date: Thu, 22 Dec 2016 16:03:56 -0800
From: Chris Leech <cleech@redhat.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Duncan <lduncan@suse.com>, open-iscsi@googlegroups.com,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [4.10, panic, regression] iscsi: null pointer deref at
 iscsi_tcp_segment_done+0x20d/0x2e0
Message-ID: <20161223000356.dxwkgsei32w7hc4f@straylight.hirudinean.org>
References: <20161214222953.GI4326@dastard>
 <20161216185906.t2wmrr6wqjdsrduw@straylight.hirudinean.org>
 <20161221221638.GD4758@dastard>
 <CA+55aFyb1jcdpavyZgZ4nedA0=6tLognyWcJXfOJjMPFTm5GWA@mail.gmail.com>
 <20161222001303.nvrtm22szn3hgxar@straylight.hirudinean.org>
 <20161222051322.GF4758@dastard>
 <CA+55aFza=cv6TGYh+Be1xz2x-G-U=vruhbmfGpHSqY1ocZrBeg@mail.gmail.com>
 <20161222065012.GI4758@dastard>
 <20161222185030.so4btkuzzkih3owz@straylight.hirudinean.org>
 <CACVXFVOGoh+AEGSSMsbxfdAjZQS5k_t+7uR-+qwusm0vfauHEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVOGoh+AEGSSMsbxfdAjZQS5k_t+7uR-+qwusm0vfauHEA@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Dec 23, 2016 at 07:53:50AM +0800, Ming Lei wrote:
> On Fri, Dec 23, 2016 at 2:50 AM, Chris Leech <cleech@redhat.com> wrote:
> > I'm not reproducing any problems with xfstests running over iscsi_tcp
> > right now.  Two 10G luns exported from an LIO target, attached directly
> > to a test VM as sda/sdb and xfstests configured to use sda1/sdb1 as
> > TEST_DEV and SCRATCH_DEV.
> >
> > The virtio scatterlist issue that popped right away for me is triggered
> > by an hdparm ioctl, which is being run by tuned on Fedora.  And that
> > actually seems to happen back on 4.9 as well :(
> 
> Could you share us what the specific hdparm cmd line is? I tried several
> random cmds over virtio-blk/virito-scsi, looks not see this problem.

Of course, looks like I've screwed up my bisect run on this so I'm still
taking a look.  It triggers for me with 'hdparm -B /dev/vda' but may
also depend on kernel configuration.

I started with the fedora rawhide config with a lot of debug on and
trimed it down with a localmodconfig run in the VM to speed up rebuilds.

Chris
