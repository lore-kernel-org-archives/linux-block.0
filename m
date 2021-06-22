Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59987C48BDF
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 07:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 436E5611BF
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 07:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFVHmQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 03:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230206AbhFVHl7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 03:41:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 168796112D;
        Tue, 22 Jun 2021 07:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624347583;
        bh=QbJE9LxmdhH3eGRXPQXb6I6KsPkDdvUnyB3gNvMxX6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r6hSAG4BlxdJfUn4N91g/X57wM8ZFg5HqcCvG8Un9wkkZPiSBWY2KU3nMttBXTGll
         hBQZh307GMno/CnX/amQ4H48GcCnjAsZstAm9q4TBxhba/2U/E7E1JbNNv9LPwiQGm
         Hgpzu2WjfLoj/KWqmnMSjbUCyIR0XxtqJXe9/3uU=
Date:   Tue, 22 Jun 2021 09:39:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     minchan@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, jpoimboe@redhat.com, tglx@linutronix.de,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <YNGTvN2cVOPr+duH@kroah.com>
References: <20210621233013.562641-1-mcgrof@kernel.org>
 <20210621233013.562641-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621233013.562641-2-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 21, 2021 at 04:30:11PM -0700, Luis Chamberlain wrote:
> Provide a simple state machine to fix races with driver exit where we
> remove the CPU multistate callbacks and re-initialization / creation of
> new per CPU instances which should be managed by these callbacks.
> 
> The zram driver makes use of cpu hotplug multistate support, whereby it
> associates a struct zcomp per CPU. Each struct zcomp represents a
> compression algorithm in charge of managing compression streams per CPU.
> Although a compiled zram driver only supports a fixed set of compression
> algorithms, each zram device gets a struct zcomp allocated per CPU. The
> "multi" in CPU hotplug multstate refers to these per cpu struct zcomp
> instances. Each of these will have the CPU hotplug callback called for
> it on CPU plug / unplug. The kernel's CPU hotplug multistate keeps a
> linked list of these different structures so that it will iterate over
> them on CPU transitions.
> 
> By default at driver initialization we will create just one zram device
> (num_devices=1) and a zcomp structure then set for the now default
> lzo-rle comrpession algorithm. At driver removal we first remove each
> zram device, and so we destroy the associated struct zcomp per CPU. But
> since we expose sysfs attributes to create new devices or reset / initialize
> existing zram devices, we can easily end up re-initializing a struct zcomp
> for a zram device before the exit routine of the module removes the cpu
> hotplug callback. When this happens the kernel's CPU hotplug will detect
> that at least one instance (struct zcomp for us) exists. This can happen
> in the following situation:
> 
> CPU 1                            CPU 2
> 
> class_unregister(...);

Now the sysfs files are removed and invalidated for all devices
associated with that class.

> idr_for_each(...);
> zram_debugfs_destroy();
>                                 disksize_store(...);

How will this call into the kobject's store function if
class_unregister() has already happened?

> idr_destroy(...);
> unregister_blkdev(...);

Ah, it's a block device's store function you are worried about, not the
class one?

> cpuhp_remove_multi_state(...);
> 
> The warning comes up on cpuhp_remove_multi_state() when it sees that the
> state for CPUHP_ZCOMP_PREPARE does not have an empty instance linked list.
> In this case, that a struct zcom still exists, the driver allowed its
> creation per CPU even though we could have just freed them per CPU
> though a call on another CPU, and we are then later trying to remove the
> hotplug callback.
> 
> Fix all this by providing a zram initialization boolean
> protected the the shared in the driver zram_index_mutex,
> which we can use to annotate when sysfs attributes are
> safe to use or not -- once the driver is properly initialized.
> When the driver is going down we also are sure to not let
> userspace muck with attributes which may affect each per cpu
> struct zcomp.
> 
> This also fixes a series of possible memory leaks. The
> crashes and memory leaks can easily be caused by issuing
> the zram02.sh script from the LTP project [0] in a loop
> in two separate windows:
> 
>   cd testcases/kernel/device-drivers/zram
>   while true; do PATH=$PATH:$PWD:$PWD/../../../lib/ ./zram02.sh; done
> 
> You end up with a splat as follows:
> 
> kernel: zram: Removed device: zram0
> kernel: zram: Added device: zram0
> kernel: zram0: detected capacity change from 0 to 209715200
> kernel: Adding 104857596k swap on /dev/zram0.  Priority:-2 extents:1 across:104857596k SSFS
> kernel: zram0: detected capacitky change from 209715200 to 0
> kernel: zram0: detected capacity change from 0 to 209715200
> kernel: ------------[ cut here ]------------
> kernel: Error: Removing state 63 which has instances left.
> kernel: WARNING: CPU: 7 PID: 70457 at kernel/cpu.c:2069 __cpuhp_remove_state_cpuslocked+0xf9/0x100
> kernel: Modules linked in: zram(E-) zsmalloc(E) <etc>
> kernel: CPU: 7 PID: 70457 Comm: rmmod Tainted: G            E     5.12.0-rc1-next-20210304 #3
> kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> kernel: RIP: 0010:__cpuhp_remove_state_cpuslocked+0xf9/0x100
> kernel: Code: <etc>
> kernel: RSP: 0018:ffffa800c139be98 EFLAGS: 00010282
> kernel: RAX: 0000000000000000 RBX: ffffffff9083db58 RCX: ffff9609f7dd86d8
> kernel: RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff9609f7dd86d0
> kernel: RBP: 0000000000000000i R08: 0000000000000000 R09: ffffa800c139bcb8
> kernel: R10: ffffa800c139bcb0 R11: ffffffff908bea40 R12: 000000000000003f
> kernel: R13: 00000000000009d8 R14: 0000000000000000 R15: 0000000000000000
> kernel: FS: 00007f1b075a7540(0000) GS:ffff9609f7dc0000(0000) knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES 0000 CR0: 0000000080050033
> kernel: CR2: 00007f1b07610490 CR3: 00000001bd04e000 CR4: 0000000000350ee0
> kernel: Call Trace:
> kernel: __cpuhp_remove_state+0x2e/0x80
> kernel: __do_sys_delete_module+0x190/0x2a0
> kernel:  do_syscall_64+0x33/0x80
> kernel: entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> The "Error: Removing state 63 which has instances left" refers
> to the zram per CPU struc zcomp instances left.
> 
> [0] https://github.com/linux-test-project/ltp.git
> 
> Acked-by: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/block/zram/zram_drv.c | 63 ++++++++++++++++++++++++++++++-----
>  1 file changed, 55 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index cf8deecc39ef..431b60cd85c1 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -44,6 +44,8 @@ static DEFINE_MUTEX(zram_index_mutex);
>  static int zram_major;
>  static const char *default_compressor = CONFIG_ZRAM_DEF_COMP;
>  
> +bool zram_up;

static?

> +
>  /* Module params (documentation at end) */
>  static unsigned int num_devices = 1;
>  /*
> @@ -1704,6 +1706,7 @@ static void zram_reset_device(struct zram *zram)
>  	comp = zram->comp;
>  	disksize = zram->disksize;
>  	zram->disksize = 0;
> +	zram->comp = NULL;

Is this a new change?

Other than these two things, seems reasonable, if not total overkill :)

thanks,

greg k-h
