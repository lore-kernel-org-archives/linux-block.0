Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [GIT PULL] nvme update for Linux 4.14, take 2
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "hch@infradead.org" <hch@infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>
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
 <0ca15e8f-fc04-7694-a471-379103c6428d@grimberg.me>
 <1504109513.2526.28.camel@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a2945cf7-93e5-11da-0780-3472b29f18bc@grimberg.me>
Date: Wed, 30 Aug 2017 19:47:52 +0300
MIME-Version: 1.0
In-Reply-To: <1504109513.2526.28.camel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>> If we get to choose, my preference would be to restore the old behavior
>> because currently existing nvme transports keep their internal ctrl
>> representation in the tagset->driver_data as they implement
>> init/exit_request. Bouncing in nvme core would require to change that
>> and always keep struct nvme_ctrl as the tagset->driver_data and convert
>> it on every handler...
>>
>> Everything is doable but it seems like an unneeded hassle to me...
> 
> Sorry but I'm not convinced that it would be necessary to change what
> tagset->driver_data points at. How about moving blk_mq_reinit_tagset() from
> the block layer core to the NVMe core, to rename it and to pass a pointer
> to the nvme_ctrl data structure to that function instead of only block layer
> information?

That would mean that I need to open-code the tagset iteration in nvme
which does not feel like something a driver should do.
