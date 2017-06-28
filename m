Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V4 00/12] blktrace: output cgroup info
To: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 gregkh@linuxfoundation.org
Cc: Shaohua Li <shli@kernel.org>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, hch@lst.de, rostedt@goodmis.org,
 lizefan@huawei.com, Kernel-team@fb.com, Shaohua Li <shli@fb.com>
References: <cover.1498666964.git.shli@fb.com>
 <f458724a-464b-6039-4893-a2584540044d@kernel.dk>
 <20170628165316.nozfbdvmpflqwt3f@kernel.org>
 <15d71514-4f24-0cff-8f85-3e70268fc7a7@kernel.dk>
 <20170628181159.GB24647@htj.duckdns.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c6fb1aba-f836-bac1-bd7c-572b1bcb1ae8@kernel.dk>
Date: Wed, 28 Jun 2017 14:57:38 -0600
MIME-Version: 1.0
In-Reply-To: <20170628181159.GB24647@htj.duckdns.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/28/2017 12:11 PM, Tejun Heo wrote:
> Hello,
> 
> On Wed, Jun 28, 2017 at 10:54:28AM -0600, Jens Axboe wrote:
>>>> Series looks fine to me. I don't know how you want to split or funnel it,
>>>> since it touches multiple different parts. Would it make sense to split this
>>>> series into two - one for the kernfs changes, and then a subsequent block
>>>> series that depend on that?
>>>
>>> What's the best practice to do this without building errors? Ask Tejun
>>> to merge the first 7 patches first?
>>
>> Yes, and then resend the block patches, just noting that dependency. Then
>> we can funnel them in like that.
> 
> I wonder whether it'd be a lot easier to route the whole series
> through one tree, most likely block.  Greg, would that be okay with
> you?  Alternatively, we can route the whole thing through driver tree
> if Jens is okay with that.

Personally I don't care that much, but the risk of conflicts is much
higher on the block side, than on the kernfs side. So might be the
path of less resistance to pull it through the block tree. And I'd be
happy to do that, if the sign offs on the kernfs side are sufficient.

-- 
Jens Axboe
