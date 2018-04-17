Return-Path: <jthumshirn@suse.de>
Date: Tue, 17 Apr 2018 09:21:05 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH] blktests: regression test "block: do not use
 interruptible wait anywhere"
Message-ID: <20180417072105.ghmocvu4is3u3hsk@linux-x5ow.site>
References: <20180416212311.19326-1-alan.christopher.jenkins@gmail.com>
 <20180416215247.27290-1-alan.christopher.jenkins@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180416215247.27290-1-alan.christopher.jenkins@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 16, 2018 at 10:52:47PM +0100, Alan Jenkins wrote:
> > Without this fix, I get an IO error in this test:
> >
> > # dd if=/dev/sda of=/dev/null iflag=direct & \
> >   while killall -SIGUSR1 dd; do sleep 0.1; done & \
> >   echo mem > /sys/power/state ; \
> >   sleep 5; killall dd  # stop after 5 seconds
> 
> linux-block insisted they wanted this, based on my reproducer above.
> If you start wondering why you wouldn't base it on scsi_debug with a new
> "quiesce" option, that makes two of us.

Thanks for doing this:

> +	# Maybe annoying for Xen dom0, but I'm guessing it's not common.
> +	if grep -q ^flags.*\ hypervisor /proc/cpuinfo &&
> +	   (( !HAVE_BARE_METAL_SCSI )); then
> +		SKIP_REASON=\
> +"Hypervisor detected, but this test wants bare-metal SCSI timings.
> +If you have a pass-through device, you may set HAVE_BARE_METAL_SCSI=1."
> +		return 1
> +	fi

I don't think we need this, if people want to shoot themselves in the
foot by runnning a possibly destructive test suite in a HV we
shouldn't stop them.

> +
> +	_have_fio

Not needed anymore as per below comment?


> +	# I tried using fio with the exact same IO pattern,
> +	# sadly it was not 100% reliable at reproducing this
> +	# issue.
> +	#
> +	dd iflag=direct if="$TEST_DEV" of=/dev/null bs=$bs status=none &
> +	dd_pid=$!
> +
> +# 	fio --output="$FULL" --loops=65535 \
> +# 	    --thread --exitall_on_error \
> +# 	    --direct=1 \
> +# 	    --bs=$bs --rw=read --name=reads \
> +# 	    --filename="$TEST_DEV" &
> +# 	fio_pid=$!

I think we can just zap the commented out fio part and the comment
about it.

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
