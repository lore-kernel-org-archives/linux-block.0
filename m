Return-Path: <mhocko@kernel.org>
Date: Wed, 6 Dec 2017 10:05:08 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: axboe@kernel.dk, oleg@redhat.com, bcrl@kvack.org, tj@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aio@kvack.org, jmoyer@redhat.com
Subject: Re: [PATCH] aio: Add memcg accounting of user used data
Message-ID: <20171206090508.GF16386@dhcp22.suse.cz>
References: <151246799787.29619.13497559380263553588.stgit@localhost.localdomain>
 <20171205151532.5evofjjma2zg3kte@dhcp22.suse.cz>
 <7f440fd7-872e-ff17-a152-6ef6dbd10a4e@virtuozzo.com>
 <20171205154301.p53ut2osrykveoso@dhcp22.suse.cz>
 <82853c8c-ed5f-4ac2-cdc1-f03fcca7505d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <82853c8c-ed5f-4ac2-cdc1-f03fcca7505d@virtuozzo.com>
List-ID: <linux-block@vger.kernel.org>

On Tue 05-12-17 19:02:00, Kirill Tkhai wrote:
> On 05.12.2017 18:43, Michal Hocko wrote:
> > On Tue 05-12-17 18:34:59, Kirill Tkhai wrote:
> >> On 05.12.2017 18:15, Michal Hocko wrote:
> >>> On Tue 05-12-17 13:00:54, Kirill Tkhai wrote:
> >>>> Currently, number of available aio requests may be
> >>>> limited only globally. There are two sysctl variables
> >>>> aio_max_nr and aio_nr, which implement the limitation
> >>>> and request accounting. They help to avoid
> >>>> the situation, when all the memory is eaten in-flight
> >>>> requests, which are written by slow block device,
> >>>> and which can't be reclaimed by shrinker.
> >>>>
> >>>> This meets the problem in case of many containers
> >>>> are used on the hardware node. Since aio_max_nr is
> >>>> a global limit, any container may occupy the whole
> >>>> available aio requests, and to deprive others the
> >>>> possibility to use aio at all. The situation may
> >>>> happen because of evil intentions of the container's
> >>>> user or because of the program error, when the user
> >>>> makes this occasionally
> >>>>
> >>>> The patch allows to fix the problem. It adds memcg
> >>>> accounting of user used aio data (the biggest is
> >>>> the bunch of aio_kiocb; ring buffer is the second
> >>>> biggest), so a user of a certain memcg won't be able
> >>>> to allocate more aio requests memory, then the cgroup
> >>>> allows, and he will bumped into the limit.
> >>>
> >>> So what happens when we hit the hard limit and oom kill somebody?
> >>> Are those charged objects somehow bound to a process context?
> >>
> >> There is exit_aio() called from __mmput(), which waits till
> >> the charged objects complete and decrement reference counter.
> > 
> > OK, so it is bound to _a_ process context. The oom killer will not know
> > about which process has consumed those objects but the effect will be at
> > least reduced to a memcg.
> > 
> >> If there was a problem with oom in memcg, there would be
> >> the same problem on global oom, as it can be seen there is
> >> no __GFP_NOFAIL flags anywhere in aio code.
> >>
> >> But it seems everything is safe.
> > 
> > Could you share your testing scenario and the way how the system behaved
> > during a heavy aio?
> > 
> > I am not saying the patch is wrong, I am just trying to undestand all
> > the consequences.
> 
> My test is simple program, which creates aio context and then starts
> infinity io_submit() cycle. I've tested the cases, when certain stages
> fail: io_setup() meets oom, io_submit() meets oom, io_getevents() meets
> oom. This was simply tested by inserting sleep() before the stage, and
> moving the task to appropriate cgroup with low memory limit. The most
> cases, I get bash killed (I moved it to cgroup too). Also, I've executed
> the test in parallel.
> 
> If you want I can send you the source code, but I don't think it will be
> easy to use it if you are not the author.

Well, not really, I was merely interest about the testing scenario
mainly to see how the system behaved because memcg hitting the hard
limit will OOM kill something only if the failing charge is from the
page fault path. All kernel allocations therefore return with ENOMEM.
The fact we are not considering per task charged kernel memory and
therefore a small task constantly allocating kernel memory can put the
whole cgroup down. As I've said this is something that _should_ be OK
because the bad behavior is isolated within the cgroup.

If that is something that is expected behavior for your usecase then OK.
-- 
Michal Hocko
SUSE Labs
