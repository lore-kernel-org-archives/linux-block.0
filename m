Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V5 00/11] blktrace: output cgroup info
To: Shaohua Li <shli@kernel.org>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
 rostedt@goodmis.org, lizefan@huawei.com, Kernel-team@fb.com,
 Shaohua Li <shli@fb.com>
References: <cover.1499884836.git.shli@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0dd93239-1ba7-c02c-09fb-c6f49c556e67@kernel.dk>
Date: Wed, 12 Jul 2017 16:50:55 -0600
MIME-Version: 1.0
In-Reply-To: <cover.1499884836.git.shli@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/12/2017 12:49 PM, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> Hi,
> 
> Currently blktrace isn't cgroup aware. blktrace prints out task name of current
> context, but the task of current context isn't always in the cgroup where the
> BIO comes from. We can't use task name to find out IO cgroup. For example,
> Writeback BIOs always comes from flusher thread but the BIOs are for different
> blk cgroups. Request could be requeued and dispatched from completely different
> tasks. MD/DM are another examples. This brings challenges if we want to use
> blktrace for performance tunning with cgroup enabled.
> 
> This patchset try to fix the gap. We print out cgroup fhandle info in blktrace.
> Userspace can use open_by_handle_at() syscall to find the cgroup by fhandle. Or
> userspace can use name_to_handle_at() syscall to find fhandle for a cgroup and
> use a BPF program to filter out blktrace for a specific cgroup.
> 
> The first 6 patches adds export operation handlers for kernfs, so userspace can
> use open_by_handle_at/name_to_handle_at to a kernfs file. Later patches make
> blktrace output cgroup info.

Added for 4.14, thanks Shaohua.

-- 
Jens Axboe
