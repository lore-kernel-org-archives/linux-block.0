Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 6/6] blk-mq-debugfs: Add 'kick' operation
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
 "osandov@osandov.com" <osandov@osandov.com>
References: <20170427155437.23228-1-bart.vanassche@sandisk.com>
 <20170427155437.23228-7-bart.vanassche@sandisk.com>
 <20170502001924.GB2894@vader>
 <8eb91d1b-c44d-089a-2b2b-9d24496d7ef2@kernel.dk>
 <1493742227.2552.6.camel@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "osandov@fb.com" <osandov@fb.com>, "hare@suse.com" <hare@suse.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <93d3e04e-80d0-4625-4124-885764e3499b@kernel.dk>
Date: Tue, 2 May 2017 10:25:44 -0600
MIME-Version: 1.0
In-Reply-To: <1493742227.2552.6.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 05/02/2017 10:23 AM, Bart Van Assche wrote:
> On Mon, 2017-05-01 at 18:24 -0600, Jens Axboe wrote:
>> On 05/01/2017 06:19 PM, Omar Sandoval wrote:
>>> On Thu, Apr 27, 2017 at 08:54:37AM -0700, Bart Van Assche wrote:
>>>> Running a queue causes the block layer to examine the per-CPU and
>>>> hw queues but not the requeue list. Hence add a 'kick' operation
>>>> that also examines the requeue list.
>>>
>>> The naming of these operations isn't super intuitive, but it makes
>>> enough sense if you know the code, I guess.
>>
>> I don't worry about that too much, but I do think it's important
>> that we have some way of knowing WHAT commands are available
>> for a given kernel, without having to consult the source. It's
>> no big deal you're running the latest and greatest debug kernels,
>> but it's a bigger issue if you're debugging kernel x.y.z for
>> a customer and you have to consult the source to find them.
>>
>> Can we include it in the show output?
> 
> Hello Jens,
> 
> Sorry but I'm afraid that including the list of supported commands in the
> 'show' output would make that output harder to read. Figuring out what the
> supported commands are is not that hard as the output below shows:
> 
> # dmesg -c >/dev/null; for d in /sys/kernel/debug/block/*/mq/state; do \
>   if [ -e "$d" ]; then echo help >$d 2>/dev/null; break; fi; done; dmesg
> blk_queue_flags_store: unsupported operation help. Use 'run', 'start' or 'kick'

Ah perfect, I missed that. That's perfectly fine, all I care about is
that there is some way to tell what the valid commands are, without
having to find the source.

-- 
Jens Axboe
