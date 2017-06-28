Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V4 00/12] blktrace: output cgroup info
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, tj@kernel.org,
 gregkh@linuxfoundation.org, hch@lst.de, rostedt@goodmis.org,
 lizefan@huawei.com, Kernel-team@fb.com, Shaohua Li <shli@fb.com>
References: <cover.1498666964.git.shli@fb.com>
 <f458724a-464b-6039-4893-a2584540044d@kernel.dk>
 <20170628165316.nozfbdvmpflqwt3f@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <15d71514-4f24-0cff-8f85-3e70268fc7a7@kernel.dk>
Date: Wed, 28 Jun 2017 10:54:28 -0600
MIME-Version: 1.0
In-Reply-To: <20170628165316.nozfbdvmpflqwt3f@kernel.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/28/2017 10:53 AM, Shaohua Li wrote:
> On Wed, Jun 28, 2017 at 10:43:48AM -0600, Jens Axboe wrote:
>> On 06/28/2017 10:29 AM, Shaohua Li wrote:
>>> From: Shaohua Li <shli@fb.com>
>>>
>>> Hi,
>>>
>>> Currently blktrace isn't cgroup aware. blktrace prints out task name of current
>>> context, but the task of current context isn't always in the cgroup where the
>>> BIO comes from. We can't use task name to find out IO cgroup. For example,
>>> Writeback BIOs always comes from flusher thread but the BIOs are for different
>>> blk cgroups. Request could be requeued and dispatched from completely different
>>> tasks. MD/DM are another examples. This brings challenges if we want to use
>>> blktrace for performance tunning with cgroup enabled.
>>>
>>> This patchset try to fix the gap. We print out cgroup fhandle info in blktrace.
>>> Userspace can use open_by_handle_at() syscall to find the cgroup by fhandle. Or
>>> userspace can use name_to_handle_at() syscall to find fhandle for a cgroup and
>>> use a BPF program to filter out blktrace for a specific cgroup.
>>>
>>> The first 6 patches adds export operation handlers for kernfs, so userspace can
>>> use open_by_handle_at/name_to_handle_at to a kernfs file. Later patches make
>>> blktrace output cgroup info.
>>
>> Series looks fine to me. I don't know how you want to split or funnel it,
>> since it touches multiple different parts. Would it make sense to split this
>> series into two - one for the kernfs changes, and then a subsequent block
>> series that depend on that?
> 
> What's the best practice to do this without building errors? Ask Tejun
> to merge the first 7 patches first?

Yes, and then resend the block patches, just noting that dependency. Then
we can funnel them in like that.

-- 
Jens Axboe
