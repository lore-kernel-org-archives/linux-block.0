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
 <a2945cf7-93e5-11da-0780-3472b29f18bc@grimberg.me>
 <1504112187.2526.47.camel@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <36296474-da73-8f1b-2a3c-e64b318d3efa@grimberg.me>
Date: Wed, 30 Aug 2017 23:59:26 +0300
MIME-Version: 1.0
In-Reply-To: <1504112187.2526.47.camel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>> That would mean that I need to open-code the tagset iteration in nvme
>> which does not feel like something a driver should do.
> 
> How about renaming blk_mq_reinit_tagset() into blk_mq_tagset_iter() and
> to make the argument list of blk_mq_tagset_iter() more similar to that of
> blk_mq_queue_tag_busy_iter() such that callers of blk_mq_tagset_iter()
> can pass a pointer to any structure through the @priv argument? That would
> make this function more general and maybe also more useful to other block
> drivers.

We could do that. But it feels like trying to go head over heals just to
keep a change titled:

"blk-mq: Make blk_mq_reinit_tagset() calls easier to read"

Which I'm not exactly sure I share the motivation. Also, I kinda liked
the symmetry of init/exit/reinit_request calling convention.

But, if you absolutely think its necessary to keep the change, we can
add an "all tags" iterator and use that to implement reinit_request in
nvme.

Christoph? Jens? verdict before we go forward here?
