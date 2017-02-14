Return-Path: <ulf.hansson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1486428890-28187-1-git-send-email-shawn.lin@rock-chips.com>
References: <1486428890-28187-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 14 Feb 2017 10:17:21 +0100
Message-ID: <CAPDyKFqS+OgmweTySyer422TfkWZrXMrQeuiymQ0HjqiZAdJzg@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: sdio: check the buffer address for sdio API
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

+Russell, Jens, Christoph, linux-block (asking for help in review)

On 7 February 2017 at 01:54, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> It's fine if the host driver use PIO mode to transfer the
> vmalloc area buffer but not for DMA mode. The sdio APIs haven't
> provide the capability to tell the caller whether it will use DMA
> to finish the IO transfer or not, so don't give the randomly
> insmoded sdio function driver the possibility to break the kernel.
> Also the APIs shouldn't take the liberty to do a copy for these
> cases and just kick out these requests should be enough.
>
> This issue is observed by doing insmod a downloaded wifi module
> driver and the kernel panic right away. Unfortunately we don't have
> the source code but adding this patch that it proves that the module
> driver was passing on a vmalloc area buffer for sdio APIs.
>
> It could very easy to be reproduced by writing a simple function
> module driver and insmod it, and panic log looks like:
>
> unsigned u8 __aligned(32) buf[PAGE_SIZE];
>
> static int wifi_probe(struct sdio_func *func, const struct
> sdio_device_id *id)
> {
>         sdio_claim_host(func);
>         sdio_enable_func(func);
>         sdio_memcpy_toio(func, 0x0, buf, 0x200);
> }
>
> [  236.748210] wifi_probe: buf = 0xffffff8000a40b80
> [  236.748258] swiotlb_tbl_map_single: orig_addr = 0xfffffffff8c40b80,
> tlb_addr = 0xf7eae000 //I added log here
> [  236.748276] Unable to handle kernel paging request at virtual address
> fffffffff8c40b80
> [  236.776486] pgd = ffffffc0b3417000
> [  236.776789] [fffffffff8c40b80] *pgd=00000000b3427003,
> *pud=00000000b3427003, *pmd=0000000000000000
> [  236.777601] Internal error: Oops: 96000005 [#1] PREEMPT SMP
> [  236.778093] Modules linked in: drvtst(O+)
> [  236.778463] CPU: 0 PID: 1918 Comm: insmod Tainted: G           O
> 4.4.36 #25
> [  236.779096] Hardware name: Rockchip RK3399 Evaluation Board v3 edp
> (Android) (DT)
> [  236.779753] task: ffffffc0e3db0c40 ti: ffffffc0b342c000 task.ti:
> ffffffc0b342c000
> [  236.780418] PC is at __memcpy+0x100/0x180
> [  236.780777] LR is at swiotlb_tbl_map_single+0x254/0x274
> [  236.781237] pc : [<ffffff80083579c0>] lr : [<ffffff800837cf70>]
> ...
>
> [  236.941392] f460: 3d20726464615f67 6666666666783020
> [  236.941826] [<ffffff80083579c0>] __memcpy+0x100/0x180
> [  236.942274] [<ffffff800837dc18>] swiotlb_map_sg_attrs+0xa8/0x170
> [  236.942810] [<ffffff800809359c>] __swiotlb_map_sg_attrs+0x24/0x8c
> [  236.943353] [<ffffff800871113c>]
> dw_mci_pre_dma_transfer.isra.16+0xf0/0x11c
> [  236.943967] [<ffffff80087129cc>] __dw_mci_start_request+0x17c/0x4d0
> [  236.944520] [<ffffff80087132e0>] dw_mci_request+0xb8/0xf0
> [  236.945002] [<ffffff80086f8b44>] __mmc_start_request+0x9c/0xc0
> [  236.945520] [<ffffff80087ae0e8>]
> mmc_start_request.part.17+0x100/0x11c
> [  236.946097] [<ffffff80086f9c74>] mmc_wait_for_req+0x78/0x1a8
> [  236.946600] [<ffffff800870421c>] mmc_io_rw_extended+0x27c/0x2fc
> [  236.947124] [<ffffff8008705800>] sdio_io_rw_ext_helper+0x1e4/0x238
> [  236.947670] [<ffffff8008705954>] sdio_memcpy_toio+0x24/0x2c
> [  236.948169] [<ffffff8000a40108>] wifi_probe+0xa8/0x198 [drvtst]
> [  236.948708] [<ffffff8008704734>] sdio_bus_probe+0xb0/0x140
> [  236.949195] [<ffffff80084bfd6c>] driver_probe_device+0x118/0x2b0
> [  236.949724] [<ffffff80084bff68>] __driver_attach+0x64/0x90
> [  236.950212] [<ffffff80084bee18>] bus_for_each_dev+0x80/0xb0
> [  236.950706] [<ffffff80084bf8ac>] driver_attach+0x20/0x28
> [  236.951176] [<ffffff80084bf45c>] bus_add_driver+0xe8/0x1ec
> [  236.951661] [<ffffff80084c0afc>] driver_register+0x98/0xe4
> [  236.952147] [<ffffff8008704580>] sdio_register_driver+0x24/0x2c
> [  236.952675] [<ffffff8000a40228>] wifi_sdio_init+0x30/0x68 [drvtst]
> [  236.953241] [<ffffff8000a4400c>] wifi_drv_init+0xc/0x38 [drvtst]
> [  236.953789] [<ffffff8008082ba4>] do_one_initcall+0x17c/0x198
> [  236.954293] [<ffffff800815e564>] do_init_module+0x60/0x1b8
> [  236.954779] [<ffffff80081150f0>] load_module+0x1660/0x1a50
> [  236.955264] [<ffffff800811562c>] SyS_init_module+0x14c/0x180
> [  236.955765] [<ffffff80080826f0>] el0_svc_naked+0x24/0x28
>
> So the kernel crash since the vmalloc area buffer, on-stack buffer or
> the on-module buffer aren't physical continuous and swiotlb couldn't find
> the correct mapping address in fact. Anyway, don't give the chance to panic
> kernel by using sdio APIs.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> ---
>
> Changes in v4:
> - fix build warning by gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
>
> Changes in v3:
> - fix build issue reported by Kbuild Robot
>
> Changes in v2:
> - add new function to check the addr of vmalloc/module/stack
>
>  drivers/mmc/core/sdio_io.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
> index 406e5f0..4df7c6f 100644
> --- a/drivers/mmc/core/sdio_io.c
> +++ b/drivers/mmc/core/sdio_io.c
> @@ -10,6 +10,7 @@
>   */
>
>  #include <linux/export.h>
> +#include <linux/mm.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/sdio.h>
> @@ -298,6 +299,19 @@ unsigned int sdio_align_size(struct sdio_func *func, unsigned int sz)
>  }
>  EXPORT_SYMBOL_GPL(sdio_align_size);
>
> +static int sdio_io_addr_sanity_check(void *buf)
> +{
> +#if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
> +       unsigned long addr = (unsigned long)buf;
> +
> +       if ((addr >= MODULES_VADDR && addr < MODULES_END) ||
> +           object_is_on_stack(buf))
> +               return 1;
> +#endif
> +       return (is_vmalloc_addr(buf) || object_is_on_stack(buf));
> +
> +}
> +
>  /* Split an arbitrarily sized data transfer into several
>   * IO_RW_EXTENDED commands. */
>  static int sdio_io_rw_ext_helper(struct sdio_func *func, int write,
> @@ -307,7 +321,7 @@ static int sdio_io_rw_ext_helper(struct sdio_func *func, int write,
>         unsigned max_blocks;
>         int ret;
>
> -       if (!func || (func->num > 7))
> +       if (!func || (func->num > 7) || sdio_io_addr_sanity_check(buf))
>                 return -EINVAL;
>
>         /* Do the bulk of the transfer using block mode (if supported). */
> --
> 1.9.1
>
>

I somewhat understand the issue you are trying to solve when
validating the buffer for DMA. However, I don't know what a proper fix
should be. Especially since I have seen nothing similar in the kernel
so far.

Therefore I have looped in Russell King, Jens Axboe, Christoph Hellwig
and linux-block to ask for help in reviewing this. Hopefully we can
get some advise here.

To give some more background to the folkz above, the SDIO func API
(part of the MMC subsystem) is intended to be used by for example WLAN
drivers, which may be built as kernel modules. Part of SDIO func API
is about writing/reading buffers to/from an SDIO card. That may
involve doing DMA transactions, depending on what the corresponding
MMC/SDIO host controller/driver supports.

Kind regards
Uffe
