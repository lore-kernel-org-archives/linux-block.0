Return-Path: <evgreen@chromium.org>
Return-Path: <evgreen@chromium.org>
MIME-Version: 1.0
References: <20181030230624.61834-1-evgreen@chromium.org> <1540943443.196084.131.camel@acm.org>
In-Reply-To: <1540943443.196084.131.camel@acm.org>
From: Evan Green <evgreen@chromium.org>
Date: Thu, 1 Nov 2018 11:15:15 -0700
Message-ID: <CAE=gft4xwXuJ=aHbF08SxFxtSRX_6KBzPHxCCMbA6F7RnGQ8jA@mail.gmail.com>
Subject: Re: [PATCH 0/2] loop: Better discard for block devices
To: bvanassche@acm.org
Cc: axboe@kernel.dk, Gwendal Grignou <gwendal@chromium.org>, asavery@chromium.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, Oct 30, 2018 at 4:50 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Tue, 2018-10-30 at 16:06 -0700, Evan Green wrote:
> > This series addresses some errors seen when using the loop
> > device directly backed by a block device. The first change plumbs
> > out the correct error message, and the second change prevents the
> > error from occurring in many cases.
>
> Hi Evan,
>
> Can you provide some information about the use case? Why do you think that
> it would be useful to support backing a loop device by a block device? Why
> to use the loop driver instead of dm-linear for this use case?
>

Hi Bart,
In our case, the Chrome OS installer uses the loop device to map
slices of the disk that will ultimately represent partitions [1]. I
believe it has been doing install this way for a very long time, and
has been working well. It actually continues to work, but on block
devices that don't support discard operations, things are a tiny bit
bumpy. This series is meant to smooth out those bumps. As far as I
knew this was a supported scenario.

-Evan
[1] https://chromium.googlesource.com/chromiumos/platform/installer/+/master/chromeos-install
