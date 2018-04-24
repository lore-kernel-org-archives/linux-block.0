Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Tue, 24 Apr 2018 15:46:04 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH v4] blktests: regression test "block: do not use
 interruptible wait anywhere"
Message-ID: <20180424224604.GA28295@vader>
References: <20180417151000.9931-1-alan.christopher.jenkins@gmail.com>
 <20180417152136.16546-1-alan.christopher.jenkins@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180417152136.16546-1-alan.christopher.jenkins@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 17, 2018 at 04:21:36PM +0100, Alan Jenkins wrote:
> > Without this fix, I get an IO error in this test:
> >
> > # dd if=/dev/sda of=/dev/null iflag=direct & \
> >   while killall -SIGUSR1 dd; do sleep 0.1; done & \
> >   echo mem > /sys/power/state ; \
> >   sleep 5; killall dd  # stop after 5 seconds
> 
> linux-block specifically asked for a test derived from this reproducer.
> They didn't come up with any suggestion for testing the code more directly
> (and robustly).  So this test uses system suspend, automated with pm_test.
> 
> Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>

Hi, Alan, thanks for the test. I was able to come up with a
deterministic reproducer which runs in a few seconds, added here:
https://github.com/osandov/blktests/blob/master/tests/block/016.
