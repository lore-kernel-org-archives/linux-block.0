Return-Path: <dennisszhou@gmail.com>
Return-Path: <dennisszhou@gmail.com>
Date: Sat, 20 Oct 2018 00:04:11 -0400
From: Dennis Zhou <dennis@kernel.org>
To: valdis.kletnieks@vt.edu
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [BUG] ext4/block null pointer crashes in linux-next
Message-ID: <20181020040411.GA41962@dennisz-mbp>
References: <13987.1539646128@turing-police.cc.vt.edu>
 <20181016160203.GA88193@dennisz-mbp.dhcp.thefacebook.com>
 <20181016182513.GA9886@dennisz-mbp.dhcp.thefacebook.com>
 <13448.1539791255@turing-police.cc.vt.edu>
 <20181017212029.GA85639@dennisz-mbp.dhcp.thefacebook.com>
 <14614.1539964356@turing-police.cc.vt.edu>
 <20181019222100.GA20900@dennisz-mbp.dhcp.thefacebook.com>
 <19715.1540003639@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19715.1540003639@turing-police.cc.vt.edu>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 19, 2018 at 10:47:19PM -0400, valdis.kletnieks@vt.edu wrote:
> On Fri, 19 Oct 2018 18:21:00 -0400, Dennis Zhou said:
> 
> > Do you by chance run any encryption or anything on top of your hard
> > drive or ssd?
> 
> ext4 on an LVM LV that's part of a PV that's inside a cryptLUKS partition on a hard drive..
> 
> So lots of nested levels there.
> 

Awesome, that explains why I wasn't able to easily reproduce the bug!

> > I thought of another issue that may explain what's going on. It has to
> > do with how a bio can go through make_request() several times. However,
> > I do association on the first entry, but subsequent requests may go to
> > separate queues. Therefore association and the blk_get_rl() returns the
> > wrong request_list. It may be that a particular blkg doesn't have a
> > fully initialized request_list.
> 
> > Thanks for being patient with me. Would you be able to try the following
> > on Jens' for-4.20/block branch? His tree is available here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> 
> No problem.  I've managed to trip over issues that took a *lot* longer to resolve
> (I think back around 2.5.47 or so, the PCMCIA slot in my Dell Latitude kept finding
> different ways to explode the kernel for close to 8-9 months...)
> 
> I checked, and linux-next was all of 1 commit behind jens' for-4.20 tree, so
> I applied it to that (I had a linux-next tree that works, but I'm a git idiot so
> figuring out how to graft that tree on was going to take a while...)
> 

That's great it worked this time, but in the future it may be worth
taking the time to switch trees. As for-next carries a lot of stuff that
has limited testing, it is nice to help limit the footprint of possible
adverse interactions and to for sure determine it exists solely say
within Jens' for-4.20/block tree.

For future reference, something like the following works as a way to
keep multiple remotes in the same repo.

git remote add block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
git fetch
git checkout -b for-4.20/block -t block/for-4.20/block

This checks out the for-4.20/block branch from the remote block as a
local branch called for-4.20/block.

> Result:
> 
> Script started on 2018-10-19 22:29:32-04:00
> [root@turing-police x86_64]# uname -a
> Linux turing-police.cc.vt.edu 4.19.0-rc8-next-20181019-dirty #641 SMP PREEMPT Fri Oct 19 21:18:19 EDT 2018 x86_64 x86_64 x86_64 GNU/Linux
> [root@turing-police x86_64]# rpm -Uvh --force dracut-049-4.git20181010.fc30.x86_64.rpm
> Verifying...                          ################################# [100%]
> warning: Unable to get systemd shutdown inhibition lock: Failed to connect to socket /run/dbus/system_bus_socket: No such file or directory
> Preparing...                          ################################# [100%]
> Updating / installing...
>    1:dracut-049-4.git20181010.fc30    ################################# [100%]
> [root@turing-police x86_64]# exit
> exit
> 
> Script done on 2018-10-19 22:29:59-04:00
> 
> System stable, RPM works, dnf works, some good-sized compiles worked.
> 
> Looks like it's time to commit that, and add these:
> 
> Reported-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> Tested-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> 
> :)

Fantastic! Thanks for working with me and reporting the issue on
for-next. I'll run the series with the above tomorrow to Jens.

Thanks,
Dennis
