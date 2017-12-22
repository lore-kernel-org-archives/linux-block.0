Return-Path: <James.Bottomley@hansenpartnership.com>
Message-ID: <1513902570.3132.22.camel@HansenPartnership.com>
Subject: Re: Regression with a0747a859ef6 ("bdi: add error handle for
 bdi_debug_register")
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jens Axboe <axboe@kernel.dk>, Bruno Wolff III <bruno@wolff.to>, weiping
	zhang <zwp10758@gmail.com>
Cc: Laura Abbott <labbott@redhat.com>, Jan Kara <jack@suse.cz>,
 linux-mm@kvack.org, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,  regressions@leemhuis.info, weiping zhang
 <zhangweiping@didichuxing.com>,  linux-block@vger.kernel.org
Date: Thu, 21 Dec 2017 16:29:30 -0800
In-Reply-To: <14f04d43-728a-953f-e07c-e7f9d5e3392d@kernel.dk>
References: <b1415a6d-fccd-31d0-ffa2-9b54fa699692@redhat.com>
	 <20171221130057.GA26743@wolff.to>
	 <CAA70yB6Z=r+zO7E+ZP74jXNk_XM2CggYthAD=TKOdBVsHLLV-w@mail.gmail.com>
	 <20171221151843.GA453@wolff.to>
	 <CAA70yB496Nuy2FM5idxLZthBwOVbhtsZ4VtXNJ_9mj2cvNC4kA@mail.gmail.com>
	 <20171221153631.GA2300@wolff.to>
	 <CAA70yB6nD7CiDZUpVPy7cGhi7ooQ5SPkrcXPDKqSYD2ezLrGHA@mail.gmail.com>
	 <20171221164221.GA23680@wolff.to>
	 <14f04d43-728a-953f-e07c-e7f9d5e3392d@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-12-21 at 10:02 -0700, Jens Axboe wrote:
> On 12/21/17 9:42 AM, Bruno Wolff III wrote:
> > 
> > On Thu, Dec 21, 2017 at 23:48:19 +0800,
> >   weiping zhang <zwp10758@gmail.com> wrote:
> > > 
> > > > 
> > > > output you want. I never saw it for any kernels I compiled
> > > > myself. Only when I test kernels built by Fedora do I see it.
> > > > see it every boot ?
> > 
> > I don't look every boot. The warning gets scrolled of the screen.
> > Once I see the CPU hang warnings I know the boot is failing. I
> > don't always look at journalctl later to see what's there.
> 
> I'm going to revert a0747a859ef6 for now, since we're now 8 days into
> this and no progress has been made on fixing it.

I think this is correct.  If you build the kernel with
CONFIG_DEBUG_FS=N, you're definitely going to get the same hang
(because the debugfs_ functions fail with -ENODEV and the bdi will
never get registered).  This alone leads me to suspect the commit is
bogus because it's a randconfig/test accident waiting to happen.

We should still root cause the debugfs failure in this case, but I
really think debugfs files should be treated as optional, so a failure
in setting them up should translate to some sort of warning not a
failure to set up the bdi.

James
