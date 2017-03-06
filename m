Return-Path: <vgoyal@redhat.com>
Date: Mon, 6 Mar 2017 08:45:49 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Hou Tao <houtao1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, axboe@kernel.dk, linux-block@vger.kernel.org,
        jmoyer@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH] cfq-iosched: fix the delay of cfq_group's vdisktime
 under iops mode
Message-ID: <20170306134549.GA728@redhat.com>
References: <1488334064-34883-1-git-send-email-houtao1@huawei.com>
 <20170302102945.GA31792@quack2.suse.cz>
 <cb362b2f-e74a-afa8-02f0-22d061c0e5a6@huawei.com>
 <20170303195347.GC960@redhat.com>
 <d19cac38-41f0-0874-037d-2954ab1fbc71@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d19cac38-41f0-0874-037d-2954ab1fbc71@huawei.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 06, 2017 at 04:55:25PM +0800, Hou Tao wrote:
> Hi Vivek,
> 
> On 2017/3/4 3:53, Vivek Goyal wrote:
> > On Fri, Mar 03, 2017 at 09:20:44PM +0800, Hou Tao wrote:
> > 
> > [..]
> >>> Frankly, vdisktime is in fixed-point precision shifted by
> >>> CFQ_SERVICE_SHIFT so using CFQ_IDLE_DELAY does not make much sense in any
> >>> case and just adding 1 to maximum vdisktime should be fine in all the
> >>> cases. But that would require more testing whether I did not miss anything
> >>> subtle.
> > 
> > I think even 1 will work. But in the beginning IIRC I took the idea
> > from cpu scheduler. Adding a value bigger than 1 will allow you to add
> > some other group later before this group. (If you want to give that group
> > higher priority).
> I still don't understand why using a value bigger than 1 will allow a later added
> group to have a vdisktime less than the firstly added group. Could you explain it
> in more detail ?

The way I thought about this was as follows.

Assume Idle delay value is 5.

Say a group A is last group in the tree and has vdisktime=100, now a new
group B gets IO and gets added to tree say with value 105 (100 + 5). Now
another group C gets IO and gets added to tree. Assume we want to give
C little higher priority than group B (but not higher than A). So we 
could assign it value between 100 and 105 and it will work. But if we had
always added 1, then group A wil have vdisktime 100, B will have 101 and
now C can't be put between A and B.

But this is such a corner case, I doubt it is going to matter. So changing
it to 1 might not show any affect at all.

We had the issue that groups which were not continuously backlogged, will
lose their share. So I had tried implemeting something that while adding
give them a smaller vdisktime (scale based on their weight). But that did
not help much. So that's why a comment was left in there.

Vivek
