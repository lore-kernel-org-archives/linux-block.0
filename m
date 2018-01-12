Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq-debugfs: Also show requests that have not yet been
 started
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "hare@suse.com" <hare@suse.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <20180112215207.17852-1-bart.vanassche@wdc.com>
 <78a60ddb-7e5f-3dac-2024-390e17da02f8@kernel.dk>
 <1515794417.2396.72.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9ae89a07-7ade-f0c6-cc54-ed56bcc4d5cf@kernel.dk>
Date: Fri, 12 Jan 2018 15:05:03 -0700
MIME-Version: 1.0
In-Reply-To: <1515794417.2396.72.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/12/18 3:00 PM, Bart Van Assche wrote:
> On Fri, 2018-01-12 at 14:55 -0700, Jens Axboe wrote:
>> On 1/12/18 2:52 PM, Bart Van Assche wrote:
>>> When debugging e.g. the SCSI timeout handler it is important that
>>> requests that have not yet been started or that already have
>>> completed are also reported through debugfs.
>>>
>>> This patch depends on a patch that went upstream recently, namely
>>> commit 14e3062fb185 ("scsi: core: Fix a scsi_show_rq() NULL pointer
>>> dereference").
>>
>> Why don't we just kill the check, and dump any request that has a
>> matching hctx? We already know the bit was set, so just print
>> all of them.
> 
> It is very helpful during debugging that requests owned by a block driver and
> requests owned by the block layer core show up in different debugfs files.
> Removing the check completely would cause all requests to show up in the same
> debugfs file and would make interpreting the contents of these debugfs files
> much harder.

Yeah, we'd have to make it just one file at that point. I'm not hugely
against the queuelist check, but probably warrants a comment as it's not
immediately clear (as opposed to the idle check, or the previous START
bit check).

-- 
Jens Axboe
