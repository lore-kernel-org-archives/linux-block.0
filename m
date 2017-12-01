Return-Path: <ming.lei@redhat.com>
Date: Fri, 1 Dec 2017 16:50:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: ivan@ludios.org
Cc: axboe@kernel.dk, paolo.valente@linaro.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, oleksandr@natalenko.name
Subject: Re: blk-mq + bfq IO hangs after writing partition table
Message-ID: <20171201085051.GA1308@ming.t460p>
References: <87fu8v7xe2.fsf@ksca2.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87fu8v7xe2.fsf@ksca2.i-did-not-set--mail-host-address--so-tickle-me>
List-ID: <linux-block@vger.kernel.org>

On Fri, Dec 01, 2017 at 06:52:37AM +0000, ivan@ludios.org wrote:
> 
> Hi,
> 
> I think I am triggering a blk-mq + bfq bug that I can reproduce 100%
> of the time by using gdisk (1.0.1-1 in Debian stretch) to write a
> partition table to a USB flash drive.  After it is triggered, IO hangs
> forever to that device and the machine cannot be shut down cleanly.
> I have reproduced this on two very different amd64 machines and two
> different USB drives.  I don't know if this affects other storage
> devices.  This happens *only* with blk-mq + bfq, never with mq-deadline
> or kyber.
> 
> I built df8ba95c572a187ed2aa7403e97a7a7f58c01f00 (2017-11-30) from
> Linus's tree with make-kpkg, without patches of any sort.
> 
> My cmdline was:
> scsi_mod.use_blk_mq=y dm_mod.use_blk_mq=y apparmor=1 security=apparmor
> 
> .config file:
> https://gist.githubusercontent.com/ivan/35935783e3153878ce650ab105c1695f/raw/b3de6c85eabd342118b5fecf2b4fab362bde7aa6/config
> 
> To reproduce:
> boot with blk-mq
> plug in a USB stick without any data you want to keep
> echo bfq > /sys/block/sdX/queue/scheduler
> gdisk /dev/sdX
> delete some partitions or add some partitions
> "w" to write the partition table
> observe IO hang and call trace (below) in the journal after 2 minutes
> 
> Note the log below does not show "bfq" because it was loaded earlier.
> 
> If it does not reproduce, try another USB flash drive; if that does not
> reproduce, cat /dev/zero over it first.

Hi,

The trick of USB flash is just that 'can_queue' is one, I have tried to
simulate your test with scsi_debug by setting 'can_queue' as one, looks
can't reproduce your issue.

Could you run the following script[1] and provide us the result after
the IO hang is triggered?

	#./dump-blk-info /dev/sdX	#/dev/sdX is name of your USB disk

[1] http://people.redhat.com/minlei/tests/tools/dump-blk-info

Thanks,
Ming
