Return-Path: <valdis@vt.edu>
Sender: Valdis Kletnieks <valdis@vt.edu>
From: valdis.kletnieks@vt.edu
To: "Theodore Y. Ts'o" <tytso@mit.edu>
cc: Dennis Zhou <dennisszhou@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [BUG] ext4/block null pointer crashes in linux-next
In-reply-to: <20181016015201.GB18547@thunk.org>
References: <13987.1539646128@turing-police.cc.vt.edu>
 <20181016015201.GB18547@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Oct 2018 08:42:14 -0400
Message-ID: <66480.1539693734@turing-police.cc.vt.edu>
List-ID: <linux-block@vger.kernel.org>

On Mon, 15 Oct 2018 21:52:01 -0400, "Theodore Y. Ts'o" said:
> Given the commit that it bisected down to, I very much doubt it has
> anything to do with a specific directory or pathname.  Either you or
> your distribution has enabled blk cgroup for I/O throttling, and

Bingo.

[~] zgrep CGROUP /proc/config.gz 
CONFIG_CGROUPS=y
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
(...)

> there's some race that you're tripping across.  What ext4 file or
> directory happens to be accessed when you trip across the problem is
> probably just pure luck.

I'm suspecting that my repeatable crash with rpm just does a *really*
good job of setting up the race.

> If you can disable the block I/O throttling configuration (which may
> very well be distro-specific), the problem will probably go away.  I
> don't use blkcg at all, personally, and on a personal laptop
> (especially if you have an SSD), I really don't see the point.

I often turn on new features just to watch the sparks fly.

> Still, I'm sure the people who *do* use blkcg for real (mostly in data
> centers, in my experience) will probably thank you for being a great
> guinea pig.  :-)

It's why I build a linux-next kernel every week. ;)

Looks like I should enable DEBUG_BLK_CGROUP and see what that says.
