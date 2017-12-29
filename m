Return-Path: <zwp10758@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20171211151705.GG2421075@devbig577.frc2.facebook.com>
References: <20171211145621.GA2115@localhost.didichuxing.com> <20171211151705.GG2421075@devbig577.frc2.facebook.com>
From: weiping zhang <zwp10758@gmail.com>
Date: Sat, 30 Dec 2017 01:17:24 +0800
Message-ID: <CAA70yB7wTVHKLdCGsgCzVi5thtwuU5buTA2acDyv_gABY8GDpw@mail.gmail.com>
Subject: Re: [RFC] blk-throttle: export io_serviced_recursive, io_service_bytes_recursive
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@kernel.org>, lizefan@huawei.com,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

2017-12-11 23:17 GMT+08:00 Tejun Heo <tj@kernel.org>:
> On Mon, Dec 11, 2017 at 10:56:25PM +0800, weiping zhang wrote:
>> export these two interface for cgroup-v1.
>>
>> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
>
> Acked-by: Tejun Heo <tj@kernel.org>
>
> Thanks.
>

Hi Jens,

these two interface are useful to collect blkcg info, would you pick it up ?

Thanks
