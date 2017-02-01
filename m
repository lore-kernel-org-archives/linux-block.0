Return-Path: <axboe@kernel.dk>
Subject: Re: [dm-devel] split scsi passthrough fields out of struct request V2
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
 <1485464486.2540.12.camel@sandisk.com>
 <6995c991-65a4-8dca-c36e-fb2eff277ca9@fb.com>
 <1485467235.2540.14.camel@sandisk.com>
 <e1d5f4e6-c63f-545d-710f-d4d10fa8d2e0@fb.com>
 <1485472465.2540.19.camel@sandisk.com>
 <e222c541-3239-104d-e0b0-40d19b012b66@fb.com>
 <1485474426.2540.25.camel@sandisk.com>
 <b98195e7-6e04-5a59-8b83-ce2e1c5c4e1a@fb.com>
 <1485477510.2540.27.camel@sandisk.com>
 <2d971693-b79d-c1b9-fb2a-f5dd04128c68@fb.com>
 <1485479738.2540.30.camel@sandisk.com>
 <ecca734c-7a9c-f060-9335-c2de089849c2@fb.com>
 <37ab009a-bc2d-d2ae-a875-269ab563a430@fb.com>
 <9cbf0ce5-ed79-0252-fd2d-34bebaafffa3@fb.com>
 <1485535925.4267.1.camel@sandisk.com>
 <2c696943-2a44-4f36-f0f8-0bebceb95a4a@fb.com>
 <1485825148.2669.18.camel@sandisk.com>
 <4D024E85-CDE7-4FB0-B8CA-F2B8C86CCFCB@kernel.dk>
 <1485898487.3113.7.camel@sandisk.com> <1485899692.3113.9.camel@sandisk.com>
 <2085a3e6-25fc-d104-35cb-38995d154fd2@kernel.dk>
 <1485910862.3113.12.camel@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9198f024-9d55-3a28-9f77-ecbca42873b5@kernel.dk>
Date: Tue, 31 Jan 2017 22:38:34 -0800
MIME-Version: 1.0
In-Reply-To: <1485910862.3113.12.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/31/2017 05:01 PM, Bart Van Assche wrote:
> On Tue, 2017-01-31 at 13:58 -0800, Jens Axboe wrote:
>> Interesting, I'll check this. Doesn't make any sense why the scheduler
>> would be implicated in that, given how we run completions now. But if
>> it complains, then something must be up.
> 
> (reduced CC-list)
> 
> There is another issue that needs further attention and for which I have
> not yet had the time to root-cause it: several processes became unkillable
> while I was running srp-test (with scheduler "none"). Apparently the dm
> queues got stuck in state BLK_MQ_S_SCHED_RESTART:
> 
> # grep -aH '' dm*/*/0/{state,dispatch,*/rq_list}
> dm-0/mq/0/state:0x4
> dm-1/mq/0/state:0x4
> dm-0/mq/0/dispatch:ffff880386d1ca00 {.cmd_type=1, .cmd_flags=0x8801, .rq_flags=0x2000, .tag=1637, .internal_tag=-1}
> dm-1/mq/0/dispatch:ffff880388ee5400 {.cmd_type=1, .cmd_flags=0x4000, .rq_flags=0x2000, .tag=42, .internal_tag=-1}
> dm-1/mq/0/dispatch:ffff880388ee5600 {.cmd_type=1, .cmd_flags=0x4000, .rq_flags=0x2000, .tag=43, .internal_tag=-1}

I think this patch:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-4.11/block&id=12d70958a2e8d587acaa51dafd5d6620e00b7543

should fix it for you. I just ran into the same thing tonight, testing
an unrelated thing. It's the only reason that state should be 0x4 for
you, so it has the same finger print.

The patch has been merged into for-next.

-- 
Jens Axboe
