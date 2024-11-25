Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D701426C
	for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 02:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732502324; cv=none; b=DBruGmkRDOlC4s874ZEGyTNY8m5RoJo4Ep2uFJaFRunqjHAL8+zbQsQyi9Ul80m10Wf2+yiMGc12sCeoJSIY2L+G+uAuqfozRA3BYnDAT8xzXTb5MuyvBpmF4A+m3KI/qR3WsLDjx6nRNIvHbPaQWJGBNDaucbwKbjmz7p2m+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732502324; c=relaxed/simple;
	bh=R6gJyhPnknzDw5M8X8bYMVbHMwHY0isZNIRe6aO3UoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jqbb1LXSaTlQvTZZEzd7UoL6qS+RiOP+mnIA1rQLViCYCqLHQgalCdPE1pTXaREcQOZEakov4y1nW8qXI3RghprtPdzMVXQY2bc5VwFMPH1LjCaml5Tubm9V457QGpzrDGLw1U33Eg0+gBM0hHt2mFQgQcxKh53StV6p5l5QKU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8LUymUd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8LUymUd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03BDC4CECC;
	Mon, 25 Nov 2024 02:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732502324;
	bh=R6gJyhPnknzDw5M8X8bYMVbHMwHY0isZNIRe6aO3UoU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C8LUymUdIwiZ7bCZs96VTzutvyrp41UzvtSPV1Xe9lzSp8hczcNIicGGEYaOgIa4V
	 d1c59hSGe7aD1BFstvBqucgi3mFyLpNyConpa9obJMzki3QYBCOKfSOBW54RP5o61n
	 6A0lld7WXu17ctC/cZHcWmk7MMFlI+9uRReYGjtKrTJKNfCUGGtN1OrQ1VudS0UGDp
	 4TtJCfgxhCgjvtiY12YcGAdC47yRVjLxmAsrbqpNCh/4/nLhITZ92bOWuzoAM8ZZt0
	 aFjGa+53lr/cb4AAmKzLQriVXP8PAk0c+305sumPNOM24VM8eyBw7AoGOafhu5H+Wb
	 C4w3LtL8ZBS+Q==
Message-ID: <972b3e03-b393-41f8-845d-3b5628481849@kernel.org>
Date: Mon, 25 Nov 2024 11:38:29 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zone write plugging and the queue full condition
To: Bart Van Assche <bart.vanassche@gmail.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <33753e7a-d38c-4a5e-9a8e-c2e27000337c@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <33753e7a-d38c-4a5e-9a8e-c2e27000337c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/23/24 12:08 PM, Bart Van Assche wrote:
> Hi Damien,
> 
> If I run the following shell commands:
> 
> modprobe -r scsi_debug
> modprobe scsi_debug delay=0 dev_size_mb=256 every_nth=2 max_queue=1 \
>   opts=0x8000 sector_size=4096 zbc=host-managed zone_nr_conv=0 zone_size_mb=4
> while true; do
>     bdev=$(cd /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/target*/*/block
> && echo *) 2>/dev/null
>     if [ -e /dev/"${bdev}" ]; then break; fi
>     sleep .1
> done
> dev=/dev/"${bdev}"
> [ -b "${dev}" ]
> fio --direct=1 --filename=$dev --iodepth=1 --ioengine=io_uring \
>     --ioscheduler=none --gtod_reduce=1 --hipri=0 --name="$(basename "${dev}")" \
>     --runtime=30 --rw=rw --time_based=1 --zonemode=zbd &
> sleep 2
> echo w > /proc/sysrq-trigger

Another thing, probably unrelated. Running the above script with Linus current
tree, when killing fio, I got this:

[ 2302.022055] ------------[ cut here ]------------
[ 2302.028312] WARNING: CPU: 2 PID: 252 at io_uring/io_uring.c:2889
io_ring_exit_work+0x160/0x4d6
[ 2302.038566] Modules linked in: scsi_debug rpcsec_gss_krb5 auth_rpcgss nfsv4
dns_resolver nfs lockd grace netfs nft_fib_inet nft_fib_ipv4 nft_fib_ipv6
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
nf_tables sunrpc intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common nls_ascii vfat fat x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm rapl intel_cstate iTCO_wdt
iTCO_vendor_support btrfs ipmi_ssif intel_uncore lpc_ich igb mfd_core i2c_i801
ioatdma xor intel_pch_thermal dca ipmi_si ipmi_devintf ipmi_msghandler
acpi_power_meter raid6_pq zstd_decompress zstd_compress zstd_common mq_deadline
bfq loop dm_mod nfnetlink sd_mod usbhid crct10dif_pclmul crc32_pclmul
crc32c_intel ast ghash_clmulni_intel drm_client_lib i2c_algo_bit ahci
sha512_ssse3 mpt3sas sha256_ssse3 smartpqi raid_class drm_shmem_helper libahci
xhci_pci xhci_hcd sha1_ssse3 scsi_transport_sas drm_kms_helper nvme libata
usbcore usb_common sg
[ 2302.038813]  scsi_mod scsi_common pkcs8_key_parser fuse [last unloaded:
scsi_debug]
[ 2302.140759] CPU: 2 UID: 0 PID: 252 Comm: kworker/u64:5 Not tainted 6.12.0+ #2107
[ 2302.148854] Hardware name: Supermicro Super Server/X11SPL-F, BIOS 3.8a
10/28/2022
[ 2302.157033] Workqueue: iou_exit io_ring_exit_work
[ 2302.162466] RIP: 0010:io_ring_exit_work+0x160/0x4d6
[ 2302.168044] Code: ff 4c 89 ff e8 c1 45 a1 ff 4c 89 e7 e8 e9 f5 ff ff 31 ff
48 89 bd 40 ff ff ff 48 8b 05 19 3f 9c 00 48 39 85 38 ff ff ff 79 08 <0f> 0b 41
bd 60 ea 00 00 48 8d 7b 58 4c 89 ee e8 2c 97 03 00 48 85
[ 2302.187537] RSP: 0018:ffff9c1d8335fd50 EFLAGS: 00010287
[ 2302.193510] RAX: 00000001001e8356 RBX: ffff8ef8ccd3a658 RCX: 0000000000000000
[ 2302.201389] RDX: 0000000000000000 RSI: ffffffffa4c482d7 RDI: 0000000000000000
[ 2302.209266] RBP: ffff9c1d8335fe20 R08: 0000000000000000 R09: 0000000000000000
[ 2302.217139] R10: 0000000000000000 R11: 00000000004debf3 R12: ffff8ef8ccd3a000
[ 2302.225008] R13: 0000000000000032 R14: ffff8ef8ccd3a040 R15: 0000000000000000
[ 2302.232878] FS:  0000000000000000(0000) GS:ffff8f07c0e80000(0000)
knlGS:0000000000000000
[ 2302.241711] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2302.248202] CR2: 00002241ff81a000 CR3: 0000000c35637006 CR4: 00000000007726f0
[ 2302.256083] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2302.263968] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2302.271834] PKRU: 55555554
[ 2302.275280] Call Trace:
[ 2302.278465]  <TASK>
[ 2302.281294]  ? __warn.cold+0xb7/0x156
[ 2302.285679]  ? io_ring_exit_work+0x160/0x4d6
[ 2302.290749]  ? report_bug+0xfb/0x140
[ 2302.295064]  ? handle_bug+0x4f/0x90
[ 2302.299280]  ? exc_invalid_op+0x17/0x60
[ 2302.303827]  ? asm_exc_invalid_op+0x1a/0x20
[ 2302.308729]  ? io_ring_exit_work+0x147/0x4d6
[ 2302.313709]  ? io_ring_exit_work+0x160/0x4d6
[ 2302.318691]  ? lock_release+0x1fa/0x290
[ 2302.323239]  ? lock_release+0x1fa/0x290
[ 2302.327766]  ? process_one_work+0x21f/0x5a0
[ 2302.332649]  ? process_one_work+0x1f9/0x5a0
[ 2302.337532]  process_one_work+0x21f/0x5a0
[ 2302.342246]  worker_thread+0x1dc/0x3c0
[ 2302.346690]  ? rescuer_thread+0x480/0x480
[ 2302.351382]  kthread+0xe0/0x110
[ 2302.355220]  ? kthread_insert_work_sanity_check+0x60/0x60
[ 2302.361303]  ret_from_fork+0x31/0x50
[ 2302.365553]  ? kthread_insert_work_sanity_check+0x60/0x60
[ 2302.371623]  ret_from_fork_asm+0x11/0x20
[ 2302.376227]  </TASK>
[ 2302.379085] irq event stamp: 9210
[ 2302.383074] hardirqs last  enabled at (9209): [<ffffffffa4c8af28>]
_raw_spin_unlock_irq+0x28/0x40
[ 2302.392619] hardirqs last disabled at (9210): [<ffffffffa4c8052e>]
__schedule+0xede/0x1700
[ 2302.401558] softirqs last  enabled at (9172): [<ffffffffa40a1027>]
__irq_exit_rcu+0xc7/0xf0
[ 2302.410573] softirqs last disabled at (9131): [<ffffffffa40a1027>]
__irq_exit_rcu+0xc7/0xf0
[ 2302.419587] ---[ end trace 0000000000000000 ]---

Did you see anything similar ?

-- 
Damien Le Moal
Western Digital Research
