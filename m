Return-Path: <mail@maciej.szmigiero.name>
Subject: Re: [PATCH] cfq-iosched: add "leaf_weight" setting for the root
 cgroup in cgroups v2
To: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <a1828795-3f51-9455-9d0b-93f9dcfb6fd4@maciej.szmigiero.name>
 <20171030145526.GB3252168@devbig577.frc2.facebook.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <7acef26f-3c11-6623-a95d-fefd06f555a0@maciej.szmigiero.name>
Date: Mon, 30 Oct 2017 17:02:41 +0100
MIME-Version: 1.0
In-Reply-To: <20171030145526.GB3252168@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 30.10.2017 15:55, Tejun Heo wrote:
> On Sun, Oct 29, 2017 at 05:36:53PM +0100, Maciej S. Szmigiero wrote:
>> CFQ scheduler has a property that processes (or tasks in cgroups v1) that
>> aren't assigned to any particular cgroup - that is, which stay in the root
>> cgroup - effectively form an implicit leaf child node attached to the root
>> cgroup.
>>
>> This behavior is documented in blkio-controller.txt for cgroups v1, however
>> as far as I know it isn't documented anywhere for cgroups v2 besides a
>> generic remark that "How resource consumption in the root cgroup is
>> governed is up to each controller" in cgroup-v2.txt.
>>
>> By default, this implicit leaf child node has a (CFQ) weight which is two
>> times higher that the default weight of a child cgroup.
>>
>> cgroups v1 provide a "leaf_weight" setting which allow changing this value.
>> However, this setting is missing from cgroups v2 and so the only way to
>> tweak how much IO time processes in the root cgroup get is to adapt
>> weight settings of all child cgroups accordingly.
>> Let's add a "leaf_weight" setting to the root cgroup in cgroups v2, too.
>>
>> Note that new kernel threads appear in the root cgroup and there seems to
>> be no way to change this since kthreadd cannot be moved to another cgroup
>> (for a good reason).
>>
>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> 
> I don't think we wanna do this.  It's inconsistent with what other
> controllers do 

And what do other (cgroup v2) controllers do in this case?
The only other controller that I know about that divides a shared resource
by weights is the cpu controller but it isn't implemented for cgroups v2
yet.

If this controller (cpu) is going to behave the same way in cgroups v2 as
it is in cgroups v1 with respect to processes in the root cgroup (mapping
priorities to weights) then it won't have this problem.

The "leaf_weight" name is both consistent with how this setting is named
in cgroups v1 and also underlines that this isn't a normal "weight"
setting, which apply at a parent cgroup level.

> and we want to charge the IOs in the root cgroup to the
> right cgroup.

As long as it is possible to have process in the root cgroup there has to
be some policy how resources are distributed to these processes.

It's only that currently for cgroups v2 this policy is undocumented and
has a hardcoded weight setting (of 200).
This patch documents this behaviors and makes it adjustable, just as it
is in cgroups v1.

> Thanks.

Thanks,
Maciej
