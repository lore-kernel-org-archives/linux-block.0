Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180518174247.31098-1-keith.busch@intel.com>
References: <20180518174247.31098-1-keith.busch@intel.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 19 May 2018 19:58:40 +0800
Message-ID: <CACVXFVNacaFRVxXd3nL1MfYQfhRRjtYN2HSrqjAb_=btpckFQg@mail.gmail.com>
Subject: Re: [PATCH blktests] Fix block/011 to not use sysfs for device disabling
To: Keith Busch <keith.busch@intel.com>
Cc: Omar Sandoval <osandov@osandov.com>, linux-block <linux-block@vger.kernel.org>,
	linux-nvme <linux-nvme@lists.infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sat, May 19, 2018 at 1:42 AM, Keith Busch <keith.busch@intel.com> wrote:
> The PCI sysfs interface may not be a dependable method for toggling the
> PCI device state to trigger the timeouts. This patch goes directly to
> the config space to make device failure occur.
>
> The success of this test is still senstive to timing, as it may disable
> IO memory when a driver is trying to bring it online. This can look like
> a permanent device failure from the driver's perspective.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  tests/block/011 | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tests/block/011 b/tests/block/011
> index 62e89f7..2fc0ffb 100755
> --- a/tests/block/011
> +++ b/tests/block/011
> @@ -21,7 +21,7 @@ DESCRIPTION="disable PCI device while doing I/O"
>  TIMED=1
>
>  requires() {
> -       _have_fio
> +       _have_fio && _have_program setpci
>  }
>
>  device_requires() {
> @@ -43,10 +43,11 @@ test_device() {
>         _run_fio_rand_io --filename="$TEST_DEV" --size="$size" \
>                         --ignore_error=EIO,ENXIO,ENODEV &
>
> +       # toggle PCI Command Register's Memory and Bus Master enabling
>         while kill -0 $! 2>/dev/null; do
> -               echo 0 > "/sys/bus/pci/devices/${pdev}/enable"
> +               setpci -s "${pdev}" 4.w=0:6
>                 sleep .2
> -               echo 1 > "/sys/bus/pci/devices/${pdev}/enable"
> +               setpci -s "${pdev}" 4.w=6:6
>                 sleep .2
>         done

Given 'echo 0 > .../${pdev}/enable' clears 'Bus Master' bit only,
I suggest this patch only clear and set 'Bus Master' bit too.

And similar issue can be triggered as before if only 'Bus Master'
is touched.

Otherwise, this patch looks fine.

Thanks,
Ming Lei
