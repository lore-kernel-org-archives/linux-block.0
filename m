Return-Path: <tytso@thunk.org>
Date: Mon, 15 Oct 2018 21:52:01 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: valdis.kletnieks@vt.edu
Cc: Dennis Zhou <dennisszhou@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [BUG] ext4/block null pointer crashes in linux-next
Message-ID: <20181016015201.GB18547@thunk.org>
References: <13987.1539646128@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <13987.1539646128@turing-police.cc.vt.edu>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 15, 2018 at 07:28:48PM -0400, valdis.kletnieks@vt.edu wrote:
> 
> Traceback of the rm crash (I have *no* idea why it has systemd-tmpfile as Comm:
> as none of the tmpfile config reference /usr/src at all, and the config says it
> shouldn't have been running at the time of the crash, and I can't replicate as
> the directory is now empty...)

Given the commit that it bisected down to, I very much doubt it has
anything to do with a specific directory or pathname.  Either you or
your distribution has enabled blk cgroup for I/O throttling, and
there's some race that you're tripping across.  What ext4 file or
directory happens to be accessed when you trip across the problem is
probably just pure luck.

If you can disable the block I/O throttling configuration (which may
very well be distro-specific), the problem will probably go away.  I
don't use blkcg at all, personally, and on a personal laptop
(especially if you have an SSD), I really don't see the point.

Still, I'm sure the people who *do* use blkcg for real (mostly in data
centers, in my experience) will probably thank you for being a great
guinea pig.  :-)

						- Ted
