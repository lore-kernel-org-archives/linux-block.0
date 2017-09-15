Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/6] blk-mq: don't allocate driver tag beforehand for
 flush rq
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
References: <20170914164213.17859-1-ming.lei@redhat.com>
 <77beace7-6243-dbda-0c8e-245fe1a9bed9@kernel.dk>
 <20170915022052.GC19340@ming.t460p>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f9e0c7d5-7b82-6b32-2a59-1064caa632b6@kernel.dk>
Date: Fri, 15 Sep 2017 08:29:29 -0600
MIME-Version: 1.0
In-Reply-To: <20170915022052.GC19340@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/14/2017 08:20 PM, Ming Lei wrote:
> On Thu, Sep 14, 2017 at 12:51:24PM -0600, Jens Axboe wrote:
>> On 09/14/2017 10:42 AM, Ming Lei wrote:
>>> Hi,
>>>
>>> This patchset avoids to allocate driver tag beforehand for flush rq
>>> in case of I/O scheduler, then flush rq isn't treated specially
>>> wrt. get/put driver tag, code gets cleanup much, such as,
>>> reorder_tags_to_front() is removed, and we needn't to worry
>>> about request order in dispatch list for avoiding I/O deadlock.
>>>
>>> 'dbench -t 30 -s -F 64' has been run on different devices(shared tag,
>>> multi-queue, singele queue, ...), and no issues are observed,
>>> even very low queue depth(1) test are run, debench still works
>>> well.
>>
>> Gave this a quick spin on the test box, and I get tons of spewage
>> on booting up:
>>
>> [    9.131290] WARNING: CPU: 2 PID: 337 at block/blk-mq-sched.c:274 blk_mq_sched_insert_request+0x15d/0x170
> 
> Sorry, my fault.
> 
> The WARN_ON() was inside 'if (has_sched)' actually, and could you
> please remove the WARN_ON() in blk_mq_sched_bypass_insert() and
> see if it works?

Putting it inside 'has_sched' makes it go away. I'll fire up some
testing of it here.

-- 
Jens Axboe
