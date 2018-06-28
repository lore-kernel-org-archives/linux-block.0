Return-Path: <ming.lei@redhat.com>
Date: Thu, 28 Jun 2018 15:08:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Laurence Oberman <loberman@redhat.com>,
	Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 0/3] blk-mq: improve IO perf in case of none io sched
Message-ID: <20180628070801.GA20248@ming.t460p>
References: <20180628031918.17694-1-ming.lei@redhat.com>
 <318a4d1724afae4dddbf39c55860278b@mail.gmail.com>
 <6683279e-7703-f8d3-bf97-67edcd6f2680@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6683279e-7703-f8d3-bf97-67edcd6f2680@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 28, 2018 at 02:03:47PM +0800, jianchao.wang wrote:
> 
> 
> On 06/28/2018 01:42 PM, Kashyap Desai wrote:
> > Ming -
> > 
> > Performance drop is resolved on my setup, but may be some stability of the
> > kernel is caused due to this patch set. I have not tried without patch
> > set, but in case you can figure out if below crash is due to this patch
> > set, I can try potential fix as well.  I am seeing kernel panic if I use
> > below three settings in my fio script.
> > 
> > iodepth_batch=8
> > iodepth_batch_complete_min=4
> > iodepth_batch_complete_max=16
> > 
> > 
> > Here is panic detail -
> > 
> > [65237.831029] ------------[ cut here ]------------
> > [65237.831031] list_add corruption. prev->next should be next
> > (ffffbb1d0a41fdf8), but was ffff94d0f0c57240. (prev=ffff94d0f0c57240).
> > [65237.831046] WARNING: CPU: 18 PID: 13897 at lib/list_debug.c:28
> > __list_add_valid+0x6a/0x70
> > [65237.831046] Modules linked in: mpt3sas raid_class ses enclosure
> > scsi_transport_sas megaraid_sas(OE) xt_CHECKSUM ipt_MASQUERADE tun
> > ip6t_rpfilter ipt_REJECT nf_reject_ipv4 ip6t_REJECT nf_reject_ipv6
> > xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc
> > ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle
> > ip6table_security ip6table_raw iptable_nat nf_conntrack_ipv4
> > nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle
> > iptable_security iptable_raw ebtable_filter ebtables ip6table_filter
> > ip6_tables iptable_filter intel_rapl skx_edac nfit libnvdimm
> > x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
> > crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel
> > snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel crypto_simd
> > cryptd
> > [65237.831079]  snd_hda_codec snd_hda_core glue_helper snd_hwdep iTCO_wdt
> > snd_seq iTCO_vendor_support snd_seq_device pcspkr snd_pcm sg i2c_i801
> > joydev wmi mei_me ipmi_si mei snd_timer acpi_power_meter ioatdma snd
> > acpi_pad ipmi_devintf ipmi_msghandler soundcore lpc_ich nfsd auth_rpcgss
> > nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c sd_mod ast i2c_algo_bit
> > drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm ixgbe
> > ahci libahci crc32c_intel libata mdio i2c_core dca dm_mirror
> > dm_region_hash dm_log dm_mod
> > [65237.831109] CPU: 18 PID: 13897 Comm: fio Kdump: loaded Tainted: G
> > OE     4.18.0-rc1+ #1
> > [65237.831110] Hardware name: Supermicro Super Server/X11DPG-QT, BIOS 1.0
> > 06/22/2017
> > [65237.831112] RIP: 0010:__list_add_valid+0x6a/0x70
> > [65237.831112] Code: 31 c0 48 c7 c7 90 08 ab a0 e8 22 b4 cd ff 0f 0b 31 c0
> > c3 48 89 d1 48 c7 c7 40 08 ab a0 48 89 f2 48 89 c6 31 c0 e8 06 b4 cd ff
> > <0f> 0b 31 c0 c3 90 48 8b 07 48 b9 00 01 00 00 00 00 ad de 48 8b 57
> > [65237.831130] RSP: 0018:ffffbb1d0a41fdd8 EFLAGS: 00010286
> > [65237.831131] RAX: 0000000000000000 RBX: ffff94d0ebf90000 RCX:
> > 0000000000000006
> > [65237.831132] RDX: 0000000000000000 RSI: 0000000000000086 RDI:
> > ffff94d91ec16970
> > [65237.831132] RBP: ffffdb1cff59e980 R08: 0000000000000000 R09:
> > 0000000000000663
> > [65237.831133] R10: 0000000000000004 R11: 0000000000000000 R12:
> > 0000000000000001
> > [65237.831134] R13: 0000000000000000 R14: ffff94d0f0c57240 R15:
> > ffff94d0f0f04c40
> > [65237.831135] FS:  00007fad10d02740(0000) GS:ffff94d91ec00000(0000)
> > knlGS:0000000000000000
> > [65237.831135] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [65237.831136] CR2: 00007fad10c2a004 CR3: 000000085600e006 CR4:
> > 00000000007606e0
> > [65237.831137] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > [65237.831138] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > 0000000000000400
> > [65237.831138] PKRU: 55555554
> > [65237.831138] Call Trace:
> > [65237.831145]  blk_mq_flush_plug_list+0x12d/0x260
> > [65237.831150]  blk_flush_plug_list+0xe7/0x240
> > [65237.831152]  blk_finish_plug+0x27/0x40
> > [65237.831156]  __x64_sys_io_submit+0xc9/0x180
> > [65237.831162]  do_syscall_64+0x5b/0x180
> > [65237.831166]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> I guess we need to clean list after list_splice_tail in the 1/1 patch as following
> @@ -1533,19 +1533,19 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
>  			    struct list_head *list)
>  
>  {
> ...
> +
> +	spin_lock(&ctx->lock);
> +	list_splice_tail(list, &ctx->rq_list);
> +       INIT_LIST_HEAD(list);          // ---> HERE !
>  	blk_mq_hctx_mark_pending(hctx, ctx);
>  	spin_unlock(&ctx->lock);

Right.

Kashyap, could you test the following patch?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2f20c9e3efda..7d972b1c3153 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1567,7 +1567,7 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 	}
 
 	spin_lock(&ctx->lock);
-	list_splice_tail(list, &ctx->rq_list);
+	list_splice_tail_init(list, &ctx->rq_list);
 	blk_mq_hctx_mark_pending(hctx, ctx);
 	spin_unlock(&ctx->lock);
 }

Thanks,
Ming
