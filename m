Return-Path: <jthumshirn@suse.de>
Date: Mon, 26 Jun 2017 16:06:10 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Omar Sandoval <osandov@osandov.com>,
	Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH blktests 2/2] block/011: Perform PCI reset while doing IO
Message-ID: <20170626140610.GA25745@linux-x5ow.site>
References: <20170623142951.17189-1-jthumshirn@suse.de>
 <20170623142951.17189-2-jthumshirn@suse.de>
 <813a788b-58f6-f3d5-57f0-60d1d439a923@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <813a788b-58f6-f3d5-57f0-60d1d439a923@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 23, 2017 at 09:36:14AM -0600, Jens Axboe wrote:
> On 06/23/2017 08:29 AM, Johannes Thumshirn wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > This test-case performs I/O with fio while doing PCI disable/enable
> > cycles.
> > 
> > In the results we don't care for I/O errors but for hiccups in dmesg only.
> 
> Let's get this in, that would be a very useful test. A few comments -
> not necessarily on this patch in particular, but for future cleanups
> and improvements.
> 
> > +	if _test_dev_is_rotational; then
> > +		size="32m"
> > +	else
> > +		size="1g"
> > +	fi
> 
> I introduced this idea in one of my previous patches. I wonder if we
> should turn that into a helper. Pass in the dev, get returned a
> suitable fio size, instead of hard coding this in each job that
> needs it.

Sure.

> 
> > +	# start fio job
> > +	_run_fio --bs=4k --rw=randread --norandommap \
> > +		--name=reads --filename="$TEST_DEV" --size="$size" \
> > +		--numjobs=8 --direct=1 2>/dev/null &
> 
> I don't believe we check for fio errors right now, but we probably
> should in the future. So I think you'd want to add something ala:
> 
> --ignore_error=EIO,ENXIO,ENODEV
> 
> to your options to make it explicit that you don't care about IO
> errors for this test.

Oh nice, didn't know about the option. Btw as we're currently all have
arbitrary values for the numjobs parameter, how about a wrapper over getconf
_NPROCESSORS_ONLN?

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
