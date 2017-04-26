Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v5 05/10] blk-mq: Unregister debugfs attributes earlier
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
 "osandov@osandov.com" <osandov@osandov.com>
References: <20170425203745.19946-1-bart.vanassche@sandisk.com>
 <20170425203745.19946-6-bart.vanassche@sandisk.com>
 <20170425213018.GB6361@vader> <1493238750.2632.13.camel@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <321087a2-387d-1391-cce6-817010b03f6e@kernel.dk>
Date: Wed, 26 Apr 2017 13:37:08 -0700
MIME-Version: 1.0
In-Reply-To: <1493238750.2632.13.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/26/2017 01:32 PM, Bart Van Assche wrote:
> On Tue, 2017-04-25 at 14:30 -0700, Omar Sandoval wrote:
>> Jens, could you ack that dropping the lock is okay?
> 
> Hello Omar,
> 
> If you have a look at the block layer history then you will see that the
> current approach for shutting down block layer queues is an approach that
> I had introduced myself. See also commits 3f3299d5c026, 807592a4fafb and
> c246e80d8673.

Bart, did you see my reply on the topic?

-- 
Jens Axboe
