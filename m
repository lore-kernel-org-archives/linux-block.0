Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [GIT PULL] nvme update for Linux 4.14, take 2
To: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <Bart.VanAssche@wdc.com>,
 "hch@infradead.org" <hch@infradead.org>
Cc: "keith.busch@intel.com" <keith.busch@intel.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20170829150507.rjixn6uf3id6kltx@infradead.org>
 <9a27048d-1252-985f-c905-b738d709b204@kernel.dk>
 <38ddd70f-3fec-09c0-dafb-eba1e8f9cc18@grimberg.me>
 <1504106914.2526.5.camel@wdc.com>
 <a798247e-cc89-f189-4ad9-92095a86106e@grimberg.me>
 <1504107991.2526.16.camel@wdc.com>
 <30e386a2-aac7-e9b7-59e2-52c481247e4e@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0ca15e8f-fc04-7694-a471-379103c6428d@grimberg.me>
Date: Wed, 30 Aug 2017 19:05:36 +0300
MIME-Version: 1.0
In-Reply-To: <30e386a2-aac7-e9b7-59e2-52c481247e4e@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>>>> Hello Sagi,
>>>>
>>>> Sorry but I doubt that that patch makes it "impossible" to move controller
>>>> reset flow to the NVMe core. There are already several function pointers in
>>>> the nvme_ctrl_ops data structure and there is one such data structure per
>>>> transport. Had you already considered to add a function pointer to that
>>>> structure?
>>>
>>> I have, that's the trampoline function that I was referring to, it feels
>>> a bit funny to have aa nvme core function that would look like:
>>>
>>> int nvme_reinit_request()
>>> {
>>> 	return ctrl->ops->reinit_request()
>>> }
>>>
>>> I can easily do that, but doesn't it defeat the purpose of blk_mq_ops?
>>
>> I don't think so. Request reinitialization is an NVMe concept that is
>> not used by any other block driver, so why should the pointer to the
>> reinitialization function exist in blk_mq_ops?
> 
> The point of blk-mq is to provide all the functionality that drivers
> need, even if it is for just a single driver. Functionality that can be
> removed from drivers is good. The smaller/simpler we can make the
> driver, the better off we are, even if that means adding a bit of
> complexity to the core.
> 
> Obviously this is a case-by-case decision. For this particular case, I'm
> happy with either solution.

If we get to choose, my preference would be to restore the old behavior
because currently existing nvme transports keep their internal ctrl
representation in the tagset->driver_data as they implement
init/exit_request. Bouncing in nvme core would require to change that
and always keep struct nvme_ctrl as the tagset->driver_data and convert
it on every handler...

Everything is doable but it seems like an unneeded hassle to me...
