Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
References: <20181002124329.21248-1-linus.walleij@linaro.org> <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
In-Reply-To: <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 2 Oct 2018 16:45:36 +0200
Message-ID: <CACRpkdZFeGy2e9OiDYaq_8XwMTjCd+oeGiJ1HXzNifqZyxPkKw@mail.gmail.com>
Subject: Re: [PATCH] block: BFQ default for single queue devices
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>,
	linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
	Paolo Valente <paolo.valente@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Richard Weinberger <richard@nod.at>, Artem Bityutskiy <dedekind1@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, Oct 2, 2018 at 4:31 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 10/2/18 6:43 AM, Linus Walleij wrote:

> > This sets BFQ as the default scheduler for single queue
> > block devices (nr_hw_queues == 1) if it is available. This
> > affects notably MMC/SD-cards but notably also UBI and
> > the loopback device.
>
> I think this should just be done with udev rules, and I'd
> prefer if the distros would lead the way on this, as they
> are the ones that will most likely see the most bug reports
> on a change like this.

AFAICT there is no sysfs property that
states how many hw queues the device has. And what
we want to do is activate BFQ when there is one HW
queue.

Should I make a patch to add a nr_hw_queues sysfs
file for this purpose in that case?

That will be a slightly misleading file for loop or networked
devices.

udev is a way to do this with desktop/server distros that has
"standard" (as they think about it) userspace. They can even
do it from their initrd/initramfs to mount root using BFQ
I guess (quick handover from e.g. UEFI).

However this is not a very good fit with Embedded systems,
as they tend to be minimal, not use udev (e.g. Android,
OpenWRT, busybox-derivates...) they don't do udev
rules, but I guess they can in theory do other scripts.
But they will mount root before anything like that can
happen. They don't use initrd/initramfs.

What I want to achieve
is to mount my rootfs with BFQ but that is not possible
on embedded systems that do not use initramfs, e.g.
a rootfs on MMC/SD or UBI.

Yours,
Linus Walleij
