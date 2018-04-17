Return-Path: <alan.christopher.jenkins@gmail.com>
Return-Path: <alan.christopher.jenkins@gmail.com>
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: Re: [PATCH] blktests: regression test "block: do not use
 interruptible wait anywhere"
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Bart Van Assche <Bart.VanAssche@wdc.com>
References: <20180416212311.19326-1-alan.christopher.jenkins@gmail.com>
 <20180416215247.27290-1-alan.christopher.jenkins@gmail.com>
 <20180417072105.ghmocvu4is3u3hsk@linux-x5ow.site>
Message-ID: <78254510-5ba0-1bba-dd4a-87fdc88e55ee@gmail.com>
Date: Tue, 17 Apr 2018 16:55:51 +0100
MIME-Version: 1.0
In-Reply-To: <20180417072105.ghmocvu4is3u3hsk@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 17/04/18 08:21, Johannes Thumshirn wrote:
> On Mon, Apr 16, 2018 at 10:52:47PM +0100, Alan Jenkins wrote:
>>> Without this fix, I get an IO error in this test:
>>>
>>> # dd if=/dev/sda of=/dev/null iflag=direct & \
>>>    while killall -SIGUSR1 dd; do sleep 0.1; done & \
>>>    echo mem > /sys/power/state ; \
>>>    sleep 5; killall dd  # stop after 5 seconds
>> linux-block insisted they wanted this, based on my reproducer above.
>> If you start wondering why you wouldn't base it on scsi_debug with a new
>> "quiesce" option, that makes two of us.
> Thanks for doing this:
>> +	# Maybe annoying for Xen dom0, but I'm guessing it's not common.
>> +	if grep -q ^flags.*\ hypervisor /proc/cpuinfo &&
>> +	   (( !HAVE_BARE_METAL_SCSI )); then
>> +		SKIP_REASON=\
>> +"Hypervisor detected, but this test wants bare-metal SCSI timings.
>> +If you have a pass-through device, you may set HAVE_BARE_METAL_SCSI=1."
>> +		return 1
>> +	fi
> I don't think we need this, if people want to shoot themselves in the
> foot by runnning a possibly destructive test suite in a HV we
> shouldn't stop them.

Thanks, this is what I was hoping to get discussion on :).

What is meant by HV?

This is phrased to solve a problem I hadn't mentioned previously:

+       # I can't expect to hit the window using bash, if the device is
+       # emulated by cpu.

I haven't tested this reproducer against devices emulated in software.  
It's written against real hardware which takes a whole second to bring 
the SATA link up.  (And maybe spin up the hdd as well?).

I'm not familiar with linux-block's testing, to know how prevalent that 
bare-metal access is.  I would like to avoid putting out a lot of "pass" 
where it's effectively being skipped.

(The comment you did quote just refers to this check being annoying in 
dom0, because I assume the check detects dom0 as being virtualized, 
despite it having access to bare-metal scsi devices. It's not a great 
comment; I will clarify it a bit).

Yes, if this reason turns out to be marginal, I would be back to the 
concern about reliability of VM suspend, and wanting it to be opt-in 
with DO_PM_TEST=1 in the config file or something.  As a newb to 
blk-tests I would be very frustrated to spin up virt-manager with a 
virtual test device, because I would run into what turns out to be an 
unfixed kernel bug.

I'm happy to have the simpler check for DO_PM_TEST (with more verbose 
SKIP_REASON) if it works; maybe the autodetection just made extra 
complexity.

>> +
>> +	_have_fio
> Not needed anymore as per below comment?

Good point, yes (but see below).

>> +	# I tried using fio with the exact same IO pattern,
>> +	# sadly it was not 100% reliable at reproducing this
>> +	# issue.
>> +	#
>> +	dd iflag=direct if="$TEST_DEV" of=/dev/null bs=$bs status=none &
>> +	dd_pid=$!
>> +
>> +# 	fio --output="$FULL" --loops=65535 \
>> +# 	    --thread --exitall_on_error \
>> +# 	    --direct=1 \
>> +# 	    --bs=$bs --rw=read --name=reads \
>> +# 	    --filename="$TEST_DEV" &
>> +# 	fio_pid=$!
> I think we can just zap the commented out fio part and the comment
> about it.

fio was attractive as a way to avoid the failure case for ludicrously 
small/fast devices.  Later I actually hit that case, from running this 
test on a small unused partition :).

I think I've worked out the reliability now.  So I can start using fio, 
and have a solid answer to both issues.

Alan
