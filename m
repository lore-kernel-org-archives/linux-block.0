Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20171209002721.537a5290@darkstar.example.org>
References: <20171208163851.0f3823b6@darkstar.example.org> <f59e66c4-e09b-95aa-a5a5-f26288beb3f0@kernel.dk>
 <20171209002721.537a5290@darkstar.example.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 18 Dec 2017 15:46:36 +0800
Message-ID: <CACVXFVPYYGx8Q25kC+ugReK1wixOmjj2EUVY+Mr2x9Rh5prLrQ@mail.gmail.com>
Subject: Re: block: oopses on 4.13.*, 4.14.* and 4.15-rc2 (bisected)
To: Michele Ballabio <barra_cuda@katamail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
	linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sat, Dec 9, 2017 at 7:27 AM, Michele Ballabio
<barra_cuda@katamail.com> wrote:
> On Fri, 8 Dec 2017 13:08:37 -0700
> Jens Axboe <axboe@kernel.dk> wrote:
>
>> On 12/08/2017 08:38 AM, Michele Ballabio wrote:
>> > Hi,
>> >     kernels 4.13.*, 4.14.* 4.15-rc2 crash on occasion,
>> > especially on x86-32 systems. To trigger the problem, run as root:
>> >
>> > while true
>> > do
>> >         /sbin/udevadm trigger --type=subsystems --action=change
>> >         /sbin/udevadm trigger --type=devices --action=change
>> >         /sbin/udevadm settle --timeout=120
>> > done
>> >
>> > (Thanks to Patrick Volkerding for the reproducer).
>> >
>> > Sometimes the kernel oopses immediately, sometimes a bit later
>> > (less than five minutes).
>> >
>> > The bisection pointed to commit
>> > caa4b02476e31fc7933d2138062f7f355d3cd8f7 (blk-map: call
>> > blk_queue_bounce from blk_rq_append_bio). A revert fixes the
>> > problem (tested on 4.13 and master).
>>
>> Thanks for your report - can you try the below patch? Totally
>> untested...
>
> I applied the patch on master
> (968edbd93c0cbb40ab48aca972392d377713a0c3), I tried two times to boot
> the system but couldn't get to the shell. I found this in the log:

Hi Michele,

Please test the patches I sent out and see if it fixes your issue. In
my environment
the two just works fine.

https://marc.info/?l=linux-block&m=151358285916762&w=2

-- 
Ming Lei
