Return-Path: <evgreen@chromium.org>
Return-Path: <evgreen@chromium.org>
MIME-Version: 1.0
References: <20181030230624.61834-1-evgreen@chromium.org> <1540943443.196084.131.camel@acm.org>
 <CAE=gft4xwXuJ=aHbF08SxFxtSRX_6KBzPHxCCMbA6F7RnGQ8jA@mail.gmail.com>
 <CAPUE2uuhfk7kstwO2kp_Rs=9QQPgGQGY+QqR76zpZpTkKp5Mig@mail.gmail.com> <1541174532.196084.146.camel@acm.org>
In-Reply-To: <1541174532.196084.146.camel@acm.org>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 5 Nov 2018 12:35:09 -0800
Message-ID: <CAE=gft4pdgmfdE4N7W1TeKQxJpexxasbx2spzBOQQbx6JwusZQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] loop: Better discard for block devices
To: bvanassche@acm.org
Cc: Gwendal Grignou <gwendal@chromium.org>, axboe@kernel.dk, asavery@chromium.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Nov 2, 2018 at 9:02 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Thu, 2018-11-01 at 15:44 -0700, Gwendal Grignou wrote:
> > On Thu, Nov 1, 2018 at 11:15 AM Evan Green <evgreen@chromium.org> wrote:
> > >
> > > On Tue, Oct 30, 2018 at 4:50 PM Bart Van Assche <bvanassche@acm.org> wrote:
> > > >
> > > > On Tue, 2018-10-30 at 16:06 -0700, Evan Green wrote:
> > > > > This series addresses some errors seen when using the loop
> > > > > device directly backed by a block device. The first change plumbs
> > > > > out the correct error message, and the second change prevents the
> > > > > error from occurring in many cases.
> > > >
> > > > Hi Evan,
> > > >
> > > > Can you provide some information about the use case? Why do you think that
> > > > it would be useful to support backing a loop device by a block device? Why
> > > > to use the loop driver instead of dm-linear for this use case?
> > > >
> > >
> > > Hi Bart,
> > > In our case, the Chrome OS installer uses the loop device to map
> > > slices of the disk that will ultimately represent partitions [1]. I
> > > believe it has been doing install this way for a very long time, and
> > > has been working well. It actually continues to work, but on block
> > > devices that don't support discard operations, things are a tiny bit
> > > bumpy. This series is meant to smooth out those bumps. As far as I
> > > knew this was a supported scenario.
> > >
> > > -Evan
> > > [1] https://chromium.googlesource.com/chromiumos/platform/installer/+/master/chromeos-install
> >
> > The code has moved to
> > https://chromium.googlesource.com/chromiumos/platform2/+/master/installer/chromeos-install
> > but the idea is the same. We create a loop device to abstract the
> > persistent destination. The destination can be a block device or a
> > file. The later case is used for creating master images to be flashed
> > on memory chip before soldering on the production line.
> > It is handy when the final device is 4K block aligned but the builder
> > is using 512b block aligned device, we can mount a device over a file
> > that will behave like the real device we will flash the image on.
>
> Hi Evan and Gwendal,
>
> Since this is a new use case for the loop driver you may want to add a test
> for this use case to the blktests project. Many block layer contributors run
> these tests to verify their own block layer changes. Contributing a blktests
> test for this new use case will make it easier for others to verify that
> their changes do not break your use case.
>

Good idea. Thanks Bart.

> Bart.
