Return-Path: <ktkhai@virtuozzo.com>
Subject: Re: [PATCH] aio: Add memcg accounting of user used data
To: Michal Hocko <mhocko@kernel.org>
Cc: axboe@kernel.dk, bcrl@kvack.org, tj@kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-aio@kvack.org, jmoyer@redhat.com
References: <151246799787.29619.13497559380263553588.stgit@localhost.localdomain>
 <20171206122303.GA7515@dhcp22.suse.cz>
 <da69b3a4-f4a7-f957-5828-2edee2009b02@virtuozzo.com>
 <20171206124321.GC7515@dhcp22.suse.cz>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <79580666-0f79-def5-dd37-af72108e7ee4@virtuozzo.com>
Date: Wed, 6 Dec 2017 16:13:15 +0300
MIME-Version: 1.0
In-Reply-To: <20171206124321.GC7515@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Return-Path: ktkhai@virtuozzo.com
List-ID: <linux-block@vger.kernel.org>

On 06.12.2017 15:43, Michal Hocko wrote:
> On Wed 06-12-17 15:36:56, Kirill Tkhai wrote:
>> On 06.12.2017 15:23, Michal Hocko wrote:
>>> On Tue 05-12-17 13:00:54, Kirill Tkhai wrote:
>>> [...]
>>>> This meets the problem in case of many containers
>>>> are used on the hardware node. Since aio_max_nr is
>>>> a global limit, any container may occupy the whole
>>>> available aio requests, and to deprive others the
>>>> possibility to use aio at all. The situation may
>>>> happen because of evil intentions of the container's
>>>> user or because of the program error, when the user
>>>> makes this occasionally
>>>
>>> I am sorry to beat more on this but finally got around to
>>> http://lkml.kernel.org/r/17b22d53-ad3d-1ba8-854f-fc2a43d86c44@virtuozzo.com
>>> and read the above paragraph once again. I can see how accounting to
>>> a memcg helps to reduce the memory footprint but I fail to see how it
>>> helps the above scenario. Could you clarify wow you set up a limit to
>>> prevent anybody from DoSing other containers by depleting aio_max_nr?
>> The memcg limit allows to increase aio_max_nr and the accounting guarantees
>> container can't exceed the limit. You may configure the limit and aio_max_nr
>> in the way, all containers requests in sum never reach aio_max_nr.
> 
> So you are essentially saying that you make aio_max_nr unlimited and
> rely on the memory consumption tracking by memcg, right?

Yes, and this is just the way the rest of similar allocated memory
such as pipes, dcache or page cache are accounted in the kernel.

If there are worries about accounting of every submitted request,
it should not be a problem to account page aligned request number only
(i.e., every PAGE_SIZE/sizeof(struct aio_kiocb) requests).
But I'm not sure primitives like memcg_kmem_charge() are allowed
outside mm subsystem.

> Are there any
> downsides (e.g. clog the AIO subsytem)?

Any new functionality affects the subsystem, where it's used :)
Just because of new processor instructions, though not only.
AIO is not something special in this way. But people,
who are not interested in the accounting, may just turn it off,
and the performance will remain the same.

If you are interested in some special benchmark results I should
to execute, please, point the benchmark, and I'll public the results.
 
> Please make sure that all this in the changelog

OK
