Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V3 0/4] block: make loop block device cgroup aware
To: Shaohua Li <shli@kernel.org>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: tj@kernel.org, lizefan@huawei.com, tglx@linutronix.de,
 kernel-team@fb.com, Shaohua Li <shli@fb.com>
References: <cover.1505422351.git.shli@fb.com>
 <20170925164403.2gxyec7ehvw3aypr@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <558e572f-0a84-1115-24f9-40bf1ebb7ff3@kernel.dk>
Date: Mon, 25 Sep 2017 13:03:25 -0600
MIME-Version: 1.0
In-Reply-To: <20170925164403.2gxyec7ehvw3aypr@kernel.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/25/2017 10:44 AM, Shaohua Li wrote:
> On Thu, Sep 14, 2017 at 02:02:03PM -0700, Shaohua Li wrote:
>> From: Shaohua Li <shli@fb.com>
>>
>> Hi,
>>
>> The IO dispatched to under layer disk by loop block device isn't cloned from
>> original bio, so the IO loses cgroup information of original bio. These IO
>> escapes from cgroup control. The patches try to address this issue. The idea is
>> quite generic, but we currently only make it work for blkcg.
> 
> Ping! how do we proceed with this patch set?

I'll queue it up for 4.15.

-- 
Jens Axboe
