Return-Path: <vgoyal@redhat.com>
Date: Fri, 3 Mar 2017 14:53:47 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Hou Tao <houtao1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, axboe@kernel.dk, linux-block@vger.kernel.org,
	jmoyer@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH] cfq-iosched: fix the delay of cfq_group's vdisktime
 under iops mode
Message-ID: <20170303195347.GC960@redhat.com>
References: <1488334064-34883-1-git-send-email-houtao1@huawei.com>
 <20170302102945.GA31792@quack2.suse.cz>
 <cb362b2f-e74a-afa8-02f0-22d061c0e5a6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cb362b2f-e74a-afa8-02f0-22d061c0e5a6@huawei.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Mar 03, 2017 at 09:20:44PM +0800, Hou Tao wrote:

[..]
> > Frankly, vdisktime is in fixed-point precision shifted by
> > CFQ_SERVICE_SHIFT so using CFQ_IDLE_DELAY does not make much sense in any
> > case and just adding 1 to maximum vdisktime should be fine in all the
> > cases. But that would require more testing whether I did not miss anything
> > subtle.

I think even 1 will work. But in the beginning IIRC I took the idea
from cpu scheduler. Adding a value bigger than 1 will allow you to add
some other group later before this group. (If you want to give that group
higher priority).

Thanks
Vivek
