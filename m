Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v5 05/10] blk-mq: Unregister debugfs attributes earlier
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
 "osandov@osandov.com" <osandov@osandov.com>
References: <20170425203745.19946-1-bart.vanassche@sandisk.com>
 <20170425203745.19946-6-bart.vanassche@sandisk.com>
 <20170425213018.GB6361@vader> <1493159087.2628.28.camel@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bffcc658-50f7-cf61-eefa-f652ea4604d6@kernel.dk>
Date: Tue, 25 Apr 2017 15:29:39 -0700
MIME-Version: 1.0
In-Reply-To: <1493159087.2628.28.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/25/2017 03:24 PM, Bart Van Assche wrote:
> On Tue, 2017-04-25 at 14:30 -0700, Omar Sandoval wrote:
>> On Tue, Apr 25, 2017 at 01:37:40PM -0700, Bart Van Assche wrote:
>>> One of the debugfs attributes allows to run a queue. Since running
>>> a queue after a queue has entered the "dead" state is not allowed
>>> and triggers a use-after-free, unregister the debugfs attributes
>>> before a queue reaches the "dead" state.
>>
>> Still not happy with this commit message. I'd prefer:
>>
>> We currently call blk_mq_free_queue() from blk_cleanup_queue() before we
>> unregister the debugfs attributes for that queue in blk_release_queue().
>> This leaves a window open during which accessing most of the mq debugfs
>> attributes would cause a use-after-free. Additionally, the "state"
>> attribute allows running the queue, which we should not do after the
>> queue has entered the "dead" state. Fix both of these cases by
>> unregistering the debugfs attributes before this.
> 
> Hello Omar,
> 
> That's a very verbose description. How about this?
> 
>     Unregister the debugfs attributes before freeing of request queue
>     resources starts to avoid that a use-after-free can be triggered
>     through one of the debugfs attributes.

Personally I find Omar's commit message much cleaner to read, and
more easily understandable. We really don't need to be laconic in
commit messages.

-- 
Jens Axboe
