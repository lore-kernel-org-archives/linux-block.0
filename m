Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 6/6] blk-mq-debugfs: Add 'kick' operation
To: Omar Sandoval <osandov@osandov.com>,
 Bart Van Assche <bart.vanassche@sandisk.com>
References: <20170427155437.23228-1-bart.vanassche@sandisk.com>
 <20170427155437.23228-7-bart.vanassche@sandisk.com>
 <20170502001924.GB2894@vader>
Cc: linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
 Hannes Reinecke <hare@suse.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8eb91d1b-c44d-089a-2b2b-9d24496d7ef2@kernel.dk>
Date: Mon, 1 May 2017 18:24:20 -0600
MIME-Version: 1.0
In-Reply-To: <20170502001924.GB2894@vader>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 05/01/2017 06:19 PM, Omar Sandoval wrote:
> On Thu, Apr 27, 2017 at 08:54:37AM -0700, Bart Van Assche wrote:
>> Running a queue causes the block layer to examine the per-CPU and
>> hw queues but not the requeue list. Hence add a 'kick' operation
>> that also examines the requeue list.
> 
> The naming of these operations isn't super intuitive, but it makes
> enough sense if you know the code, I guess.

I don't worry about that too much, but I do think it's important
that we have some way of knowing WHAT commands are available
for a given kernel, without having to consult the source. It's
no big deal you're running the latest and greatest debug kernels,
but it's a bigger issue if you're debugging kernel x.y.z for
a customer and you have to consult the source to find them.

Can we include it in the show output?

-- 
Jens Axboe
