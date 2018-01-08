Return-Path: <m@bjorling.me>
MIME-Version: 1.0
In-Reply-To: <EC97E53B-ECF3-4EB6-B92A-3950EEFF8580@lightnvm.io>
References: <20180105131621.20808-1-m@bjorling.me> <20180105131621.20808-25-m@bjorling.me>
 <20180105154230.GA13829@kernel.dk> <2491bb34-2098-32f5-3d5b-e3d89fbce4b3@bjorling.me>
 <20180108115457.GA28922@infradead.org> <EC97E53B-ECF3-4EB6-B92A-3950EEFF8580@lightnvm.io>
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
Date: Mon, 8 Jan 2018 14:31:46 +0100
Message-ID: <CAOu_J6=Jv1=yVfGkP15SWB04+t7SDg==KkdyEiraH_4Bo9rvKA@mail.gmail.com>
Subject: Re: [GIT PULL 24/25] lightnvm: pblk: add iostat support
To: =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 8, 2018 at 1:53 PM, Javier Gonz=C3=A1lez <jg@lightnvm.io> wrote=
:
>> On 8 Jan 2018, at 12.54, Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Fri, Jan 05, 2018 at 07:33:36PM +0100, Matias Bj=C3=B8rling wrote:
>>> On 01/05/2018 04:42 PM, Jens Axboe wrote:
>>>> On Fri, Jan 05 2018, Matias Bj=C3=B8rling wrote:
>>>>> From: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>>>>>
>>>>> Since pblk registers its own block device, the iostat accounting is
>>>>> not automatically done for us. Therefore, add the necessary
>>>>> accounting logic to satisfy the iostat interface.
>>>>
>>>> Ignorant question - why is it a raw block device, not using blk-mq?
>>>
>>> The current flow is using the raw block device, together with the blk-m=
q
>>> nvme device driver. A bio is sent down to the nvme_nvm_submit_io() path=
 in
>>> the /drivers/nvme/host/lightnvm.c file. From there it attaches the to N=
VMe
>>> blk-mq implementation.
>>>
>>> Is there a better way to do it?
>>
>> I suspect the right way to do things is to split NVMe for different
>> I/O command sets, and make this an I/O command set.
>
> This makes sense. This was actually how I implemented it to start with,
> but I changed it to be less intrusive on the nvme path. Let's revert the
> patch and we can add it back when we push the 2.0 patches.
>
>> But before touching much of NVMe, I'd really, really like to see an
>> actual spec first.
>
> The 2.0 spec. is open and is available here [1]. I thought you had
> looked into it already... Anyway, feedback is more than welcome.
>
> [1] https://docs.google.com/document/d/1kedBY_1-hfkAlqT4EdwY6gz-6UOZbn7kI=
jWpmBLPNj0
>
> Javier

The 2.0 spec is still under development. No reason to redo the I/O
stacks until it is final.
