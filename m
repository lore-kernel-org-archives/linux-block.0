Return-Path: <adrian.hunter@intel.com>
Subject: Re: [PATCH v2] RFD: switch MMC/SD to use blk-mq multiqueueing
To: Christoph Hellwig <hch@lst.de>, Linus Walleij <linus.walleij@linaro.org>
References: <1482242508-26131-1-git-send-email-linus.walleij@linaro.org>
 <0fec238b-3c3c-6928-71ec-c3d4bcc6d267@codeaurora.org>
 <CACRpkdazLSk1i37ERs4YwuwXnmbmrnyAX1T5kRXjKcPSaAYd7Q@mail.gmail.com>
 <20161228085503.GA340@lst.de>
Cc: Ritesh Harjani <riteshh@codeaurora.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 linux-block@vger.kernel.org, Chunyan Zhang <zhang.chunyan@linaro.org>,
 Baolin Wang <baolin.wang@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Paolo Valente <paolo.valente@linaro.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <38ec2c14-fc54-b059-1b29-0144ef87e14a@intel.com>
Date: Mon, 2 Jan 2017 15:56:40 +0200
MIME-Version: 1.0
In-Reply-To: <20161228085503.GA340@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 28/12/16 10:55, Christoph Hellwig wrote:
> On Tue, Dec 27, 2016 at 01:21:28PM +0100, Linus Walleij wrote:
>>> Could you please confirm on this- does even the HW/SW CMDQ in emmc would use
>>> only 1 hardware queue with (say ~31) as queue depth, of that HW queue? Is
>>> this understanding correct?
>>
>> Yes as far as I can tell.
>>
>> But you may have to tell me, because I'm not an expert in CMDQ.
>>
>> Multiple queues are for when you can issue different request truly parallel
>> without taking any previous and later request into account. CMDQ on
>> MMC seems to require rollback etc if any of the issued requests after
>> a certain request fail, and then it is essentially one queue, like a pipeline,
>> and if one request fails all requests after that request needs to be backed
>> out, correct?
> 
> I'm not an expert on the MMC CMDQ feature, but I know blk-mq pretty
> well, so based on that and the decription of the series CMDQ finally
> allows MMC to implement one single queue almost properly, but certainly
> not multiple queues.
> 
> In block storage terms a queue is something where the OS can send
> multiple commands to the device and let the device operate on them in
> parallel (or at least pseudo-parallel).  Even with the MMC CMDQ feature
> is seems after queueing up command the host still needs to control
> execution ordering by talking to the hardware again for each command,
> which isn't up to par with what other standards have been doing for the
> last decades.  It's certainly not support for multiple queues, which
> is defined as hardware features where the host allows multiple issuers
> to use queue entirely independently of each other.

eMMC can only do one thing at a time.  However when the host controller has
a command queue engine (CQE), then the engine takes care of executing tasks
in the queue, so the driver only needs to queue transfers and handle
completions.

Unfortunately there is a complication.  EMMC can be blocked for a number of
reasons:

First, eMMC has a number of internal partitions that are represented as
disks with their own (block-layer) queues.  Because eMMC can only do one
thing at a time, the queues must be synchronized with each other, and there
is a switch command that must be issued to switch the eMMC between internal
partitions.  Currently that synchronization is provided by "claiming" the
host controller.  A queue (mmc_queue_thread) is blocked until it claims the
host.

Secondly, MMC block driver has an IOCTL interface that bypasses the queue,
and consequently also needs to be synchronized - again currently by claiming
the host.  There is also a proposed RPMB interface that works similarly.

Thirdly, discards are not (properly) supported by the CQE or (at all by)
eMMC CMDQ.  A discard (or erase) requires 3 commands to be sent in
succession.  Even if the CQE supports direct commands (DCMD) as described by
the Command Queue Host Controller (CQHCI) specification, only one DCMD can
be issued at a time.  That means no new reads/writes can be issued while the
first 2 commands are being issued, and no new discards can be issued until
the previous one completes.  However it is possible there are CQE that don't
support DCMD anyway - which would just mean the queue is halted/blocked
until the discard completes.

Fourthly, eMMC/SD make use of runtime PM for both the host controller and
the card.  The card might require a full reinitialization sequence to be
resumed.

Fifthly, although it is a minor point, the CQHCI spec specifies that the CQE
must be halted to handle any error, and indeed the CQE must be halted to
send commands to perform recovery anyway.

Sixthly, there are debugfs files that issue commands and are also
synchronized by claiming the host.

The problem with blocking is that it leaves up to queue_depth requests
sitting in a (local or dispatch) list unavailable for merging or
prioritizing.  That won't matter if the queue_depth is 2, but it might if
the queue_depth is the eMMC CMDQ maximum of 32.

If we assume it doesn't matter to have up to queue_depth requests
unavailable for merging or prioritizing, then a switch to blk-mq can be done
most simply by having ->queue_rq() put requests on a list, and have the
existing mmc_queue_thread() process them the same way it does now.  One
disadvantage of that approach is that the mmc_queue_thread() would not get
woken until ->queue_rq() is called which is done by scheduled work for async
requests.

If it does matter that all requests are still available for merging or
prioritizing when the queue is blocked, then AFAICT mmc will need more
support from blk-mq.
