Return-Path: <zwp10758@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20171010182340.rpqkzgx6pmmlplin@kernel.org>
References: <cover.1507337347.git.shli@fb.com> <c8b704eb77e0b8d1792cde7ca1fefcca09b7684f.1507337347.git.shli@fb.com>
 <20171010173551.GB2924@localhost.didichuxing.com> <20171010182340.rpqkzgx6pmmlplin@kernel.org>
From: weiping zhang <zwp10758@gmail.com>
Date: Wed, 11 Oct 2017 22:41:14 +0800
Message-ID: <CAA70yB7fcx+KdfN_w7xofGLABeh9izEY8qmFMWm7JTOEYYkwUw@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] blockcg: export latency info for each cgroup
To: Shaohua Li <shli@kernel.org>
Cc: linux-block@vger.kernel.org, vgoyal@redhat.com, tj@kernel.org,
	Jens Axboe <axboe@kernel.dk>, Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

2017-10-11 2:23 GMT+08:00 Shaohua Li <shli@kernel.org>:
> On Wed, Oct 11, 2017 at 01:35:51AM +0800, weiping zhang wrote:
>> On Fri, Oct 06, 2017 at 05:56:01PM -0700, Shaohua Li wrote:
>> > From: Shaohua Li <shli@fb.com>
>> >
>> > Export the latency info to user. The latency is a good sign to indicate
>> > if IO is congested or not. User can use the info to make decisions like
>> > adjust cgroup settings.
>> Hi Shaohua,
>> How to check IO congested or not by latency ? Different SSD has
>> different latency especially when mixed sequence and random IO
>> operatons.
>
> There is no magic here, you should know the SSD characteristics first. The idea
> is observing the latency when the system isn't overcommited, for example,
> running the workload in a one-cgroup setup, then using the observed latency to
> guide configuration for multi-cgroup settings or check if IO is healthy in
> cgroups.
>
Could you please give more detail about how to get the SSD characteristics ?
I cann't find a good way to get the reasonable latency at mixed
sequence , random,
read, and write. Is there a value or a range represent the reasonable latency at
mixed circurmastance ?

Thanks
Weiping
