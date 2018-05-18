Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V6 11/11] nvme: pci: support nested EH
To: Keith Busch <keith.busch@linux.intel.com>, Ming Lei <ming.lei@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Laurence Oberman <loberman@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <keith.busch@intel.com>,
 Jianchao Wang <jianchao.w.wang@oracle.com>, Christoph Hellwig <hch@lst.de>
References: <20180516040313.13596-1-ming.lei@redhat.com>
 <20180516040313.13596-12-ming.lei@redhat.com>
 <20180516141242.GA20119@localhost.localdomain>
 <20180516231058.GB28727@ming.t460p>
 <20180517022030.GB21959@localhost.localdomain>
 <20180518001958.GA2742@ming.t460p>
 <20180518135751.GI23555@localhost.localdomain>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <05640a87-b0bd-3ebb-7ff6-58645f658d88@kernel.dk>
Date: Fri, 18 May 2018 10:58:46 -0600
MIME-Version: 1.0
In-Reply-To: <20180518135751.GI23555@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/18/18 7:57 AM, Keith Busch wrote:
> On Fri, May 18, 2018 at 08:20:05AM +0800, Ming Lei wrote:
>> What I think block/011 is helpful is that it can trigger IO timeout
>> during reset, which can be triggered in reality too.
> 
> As I mentioned earlier, there is nothing wrong with the spirit of
> the test. What's wrong with it is the misguided implemention.
> 
> Do you underestand why it ever passes? The success happens when the
> enabling part of the loop happens to coincide with the driver's enabling,
> creating the pci_dev->enable_cnt > 1, making subsequent disable parts
> of the loop do absolutely nothing; the exact same as the one-liner
> (non-serious) patch I sent to defeat the test.
> 
> A better way to induce the timeout is:
> 
>   # setpci -s <B:D.f> 4.w=0:6
> 
> This will halt the device without messing with the kernel structures,
> just like how a real device failure would occur.

Let's just improve/fix the test case. Sounds like the 'enable' sysfs
attribute should never have been exported, and hence the test should
never have used it. blktests is not the source of truth, necessarily,
and it would be silly to work around cases in the kernel if it's a
clear case of "doctor it hurts when I shoot myself in the foot".

-- 
Jens Axboe
