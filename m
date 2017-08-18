Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 06/12] blk-mq-debugfs: Generate name-to-text translation
 tables
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "osandov@fb.com" <osandov@fb.com>, "hare@suse.com" <hare@suse.com>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
 <20170817232311.25948-7-bart.vanassche@wdc.com>
 <20170818143545.GB20707@kernel.dk> <1503069063.2622.2.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <98500f25-55ed-09c7-d924-ff9c643f181c@kernel.dk>
Date: Fri, 18 Aug 2017 09:36:33 -0600
MIME-Version: 1.0
In-Reply-To: <1503069063.2622.2.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 09:11 AM, Bart Van Assche wrote:
> On Fri, 2017-08-18 at 08:35 -0600, Jens Axboe wrote:
>> On Thu, Aug 17 2017, Bart Van Assche wrote:
>>> It is easy to add a flag to one of the block layer headers and to
>>> forget to update blk-mq-debugfs.c. E.g. QUEUE_FLAG_SCSI_PASSTHROUGH,
>>> QUEUE_FLAG_QUIESCED and REQ_NOWAIT are missing from blk-mq-debugfs.c.
>>> Hence generate the symbol-to-text translation tables.
>>
>> This is just too ugly to live...
> 
> Hello Jens,
> 
> How about adding rules to the makefile that check for missing symbols and
> that issue a warning if a symbol is missing from blk-mq-debugfs.c? Would
> you consider that approach acceptable?

If it's small and clean, I'd consider it. The problem with this
version is that it's massive and really nasty. It better be solving
a huge problem to warrant that, and it doesn't. It's really a minor
thing. I'd like to ensure that we keep them synced, but the solution
complexity has to match the problem.

-- 
Jens Axboe
