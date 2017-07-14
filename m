Return-Path: <tomi.p.sarvela@intel.com>
Subject: Re: linux-next scsi-mq hang in suspend-resume
To: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <21128504.iYAzanzLsA@fractal.fi.intel.com>
 <dd9daa92-0c9c-51dd-95b5-961cfd1fca36@kernel.dk>
 <20170713071220.GA19972@infradead.org> <20170714124424.GA28150@infradead.org>
From: Tomi Sarvela <tomi.p.sarvela@intel.com>
Message-ID: <d455b080-13ff-af9c-c793-7a47356fee6f@intel.com>
Date: Fri, 14 Jul 2017 16:33:26 +0300
MIME-Version: 1.0
In-Reply-To: <20170714124424.GA28150@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 14/07/17 15:44, Christoph Hellwig wrote:
> can you please report what hardware this is one (e.g. libata or
> real scsi, which driver), a kernel config and the actual command
> used to suspend the system (to ram, to disk?) so that I an try to
> reproduce it?

The hardware I used to bisect the problem is is Broxton: Asrock 
ITX-J3455 motherboard with Intel J3455 SoC (about Skylake Gen). Disk is 
Intel SATA SSD. Issue also happens with Samsung SSD on other testhost.

Note that there is half dozen other hosts indicating the same problem, 
and traces are available starting from ILK to Skylake. None of the Kaby 
Lakes triggers the issue (the KBL issue is probably NVMe-related 
instead). Usual setup is one SATA SSD disk on port 0 on motherboard.

Kernel config is available at:
https://intel-gfx-ci.01.org/CI/next-20170711/kernel.config.bz2

Kernel options:
BOOT_IMAGE=/boot/drm_intel root=/dev/sda2 console=ttyS0,115200n8 
console=tty0 intel_iommu=igfx_off drm.debug=0xe nmi_watchdog=panic,auto 
panic=1 softdog.soft_panic=1 rootwait ro 3

To reproduce the problem on Broxton, i-g-t was used:
https://cgit.freedesktop.org/xorg/app/intel-gpu-tools/

 From i-g-t, the binaries could be run with:

tests/gem_exec_gttfill --r basic
tests/gem_exec_suspend --r basic-s3

but, from my experience, this issue pops up much easier if there is 
piglit framework capturing logs to disk:

https://cgit.freedesktop.org/piglit

With IGT/piglit testlist file would be (ex. scsi-mq.testlist):
#
igt@gem_exec_gttfill@basic
igt@gem_exec_suspend@basic-s3
#
and command to run i-g-t through piglit is
/opt/igt/scripts/run-tests.sh -vT scsi-mq.testlist

I can try to reproduce the issue without i-g-t/piglit, but it might take 
some trying. Definitely suspend-to-ram and writes to disk are needed to 
trigger this, gem_exec_suspend/basic-s3 can loop quite well without 
panicing.

Tomi
-- 
Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
