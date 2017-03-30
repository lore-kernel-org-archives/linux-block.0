Subject: Re: [PATCH] blk-mq: Export queue state through
 /sys/kernel/debug/block/*/state
To: Bart Van Assche <Bart.VanAssche@sandisk.com>, "hare@suse.de"
 <hare@suse.de>
References: <1D08B61A9CF0974AA09887BE32D889DA12B851@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <824697ce-3fe4-f7ab-e23b-237b280196fb@suse.de>
 <1490886955.2753.3.camel@sandisk.com>
Cc: "osandov@fb.com" <osandov@fb.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <fe04eba2-a67d-9e02-83f4-1f519f79ed4b@fb.com>
Date: Thu, 30 Mar 2017 09:19:55 -0600
MIME-Version: 1.0
In-Reply-To: <1490886955.2753.3.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/30/2017 09:16 AM, Bart Van Assche wrote:
> On Thu, 2017-03-30 at 07:50 +0200, Hannes Reinecke wrote:
>> On 03/29/2017 10:20 PM, Bart Van Assche wrote:
>>> Make it possible to check whether or not a block layer queue has
>>> been stopped. Make it possible to run a blk-mq queue from user
>>> space.
>>>
>>> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
>>> Cc: Omar Sandoval <osandov@fb.com>
>>> Cc: Hannes Reinecke <hare@suse.com>
>>> ---
>>>  block/blk-mq-debugfs.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 84 insertions(+)
>>>
>>
>> About bloody time :-)
>>
>> Reviewed-by: Hannes Reinecke <hare@suse.com>
> 
> Hello Hannes,
> 
> Thanks for the review :-) However, had you noticed that I had already
> posted a v2 of this patch? Anyway, since I have improved v2 further
> after I had posted it, I will post a v3 today.

I didn't see a v2 posting?

-- 
Jens Axboe
