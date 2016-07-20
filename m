Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 20 Jul 2016 11:30:52 -0400
From: Tejun Heo <tj@kernel.org>
To: =?utf-8?B?5byg55yf?= <zhangzhen507@163.com>
Cc: aaronlee0817@163.com, axboe@kernel.dk, mlin@kernel.org, shli@kernel.org,
	linux-kernel@vger.kernel.org, cgroup@vger.kernel.org,
	linux-block@vger.kernel.org, zhen1.zhang@samsung.com,
	yanzi.zhang@samsung.com, jiale0817.li@samsung.com
Subject: Re: Cgroup: iops throttle problem
Message-ID: <20160720153052.GE4574@htj.duckdns.org>
References: <3aad6640.14fc7.155fe37ba10.Coremail.zhangzhen507@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <3aad6640.14fc7.155fe37ba10.Coremail.zhangzhen507@163.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Mon, Jul 18, 2016 at 09:35:12PM +0800, 张真 wrote:
> Hello
> My name is Zhen Zhang , me and Jiale Li recently test and analyze the cgroup
> blkio functions.
> We tested the buffered read a file using bio when the 
> blkio.throttle.read_iops_device is set 1000.
> The fio result file displays the iops is 13720 larger than 1000 when blocksize 
> is 4K in fio.

blk-throttle does allow bursts so the iops might go over the set limit
for a short period.  Over time, it shouldn't be over the set limit.

> We set different blocksize in fio:
> 4K, 8K , 16K, 32K, 64K, 128K, 256K, 512K, 1024K
> 
> The iops in fio:
> 13035, 7258, 3711, 1698, 907, 460, 228, 102, 54

Looks like you were hitting the natural bandwidth limit of the device.

> When bs is less than 64K, the iops is larger than 1000, when bs is larger than
> 64K, the iops is less than 1000.
> We tested it on ubuntu 16.04 with kernel 4.4.0
> 
> Dose this a problem of blkio iops throttle?

I don't know how the test was run but consistently going over the set
limit isn't the expected behavior.

Thanks.

-- 
tejun
