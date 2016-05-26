Return-Path: <dan.j.williams@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5742B023.2040503@bjorling.me>
References: <5742B023.2040503@bjorling.me>
Date: Thu, 26 May 2016 10:40:17 -0700
Message-ID: <CAA9_cmfVKoEw1XpJJ4j4+QHWB29-cRvdDp1hmtyegxSpBy0fNw@mail.gmail.com>
Subject: Re: gendisk and lightnvm
From: Dan Williams <dan.j.williams@gmail.com>
To: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Keith Busch <keith.busch@intel.com>, Simon Lund <slund@cnexlabs.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Mon, May 23, 2016 at 12:24 AM, Matias Bj=C3=B8rling <m@bjorling.me> wrot=
e:
> Hi Jens, Christoph, and Keith,
>
> I have been pondering for a couple of weeks on how to integrate lightnvm
> into the sysfs stack. Lightnvm does not currently expose a "physical"
> device. During device registration, the block device name is simply store=
d,
> which the user may then use as an id later, and expose through a target
> implementation.
>
> Until then, the device is left "dangling" in the kernel, without any good
> way to reference it other than asking the lightnvm manager. This also
> includes device driver specific configuration, such as power and mq sysfs
> entries.
>
> It would be great to have a common way to expose the lightnvm subsystem
> through the block storage stack.
>
> With block devices, the device driver centric information includes:
>
> /sys/block/*/
>   inflight
>   removable
>   serial
>   /mq
>   /power

Which of these attributes do you need to access before the device is live?

> Simon has currently built an RFC patch that wires lightnvm devices up in
> /sys/devices/virtual/misc/lightnvm/*, without any access to the above
> entries.

This seems inverted, shouldn't lightnvm be a child of the device +
driver that uses the api?
