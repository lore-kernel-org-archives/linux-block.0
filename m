Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454C3C4338F
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 20:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BC8C61038
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 20:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhHBUkk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 16:40:40 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:57508 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhHBUkj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Aug 2021 16:40:39 -0400
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id CF12EB6D165;
        Mon,  2 Aug 2021 22:40:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1627936828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V5Gf8WHIaRBgcRmpR02+bUOZmjIZRuc2TFbV62MBv24=;
        b=qqlLLpfd+AFqorlYKhqiuAIo/8NO0U/oOaCytTsVDYl3Yk1cGgrIrN8G29a5Y2WCA6rXCb
        EJF06G7iKxcPz9+Ae9R1UGgDkPqS4oEnNyi0xI876gXQkd8tMLQCmdtOd9XfkuIGXiC/+7
        itPeC7rJXURvxe2n8xupbhBNlS/9iKI=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Jan Kara <jack@suse.cz>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luca Mariotti <mariottiluca1@hotmail.it>,
        Holger =?ISO-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Pietro Pedroni <pedroni.pietro.96@gmail.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Khazhy Kumykov <khazhy@google.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH FIXES/IMPROVEMENTS 0/7] block, bfq: preserve control, boost throughput, fix bugs
Date:   Mon, 02 Aug 2021 22:40:26 +0200
Message-ID: <1630141.ki6cbyAirf@natalenko.name>
In-Reply-To: <2957867.CS06ZTPI5V@spock>
References: <20210619140948.98712-1-paolo.valente@linaro.org> <20210622162948.GJ14261@quack2.suse.cz> <2957867.CS06ZTPI5V@spock>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello.

On sobota 3. =C4=8Dervence 2021 0:07:53 CEST Oleksandr Natalenko wrote:
> On =C3=BAter=C3=BD 22. =C4=8Dervna 2021 18:29:48 CEST Jan Kara wrote:
> > On Tue 22-06-21 09:35:05, Oleksandr Natalenko wrote:
> > > On =C3=BAter=C3=BD 22. =C4=8Dervna 2021 9:08:43 CEST Paolo Valente wr=
ote:
> > > > CCing also Jan and Khazhy, because in your commit log I see also the
> > > > commit on bfq_requests_merged().
> > > >=20
> > > > Is this OOPS reproducible for you?
> > >=20
> > > No, I haven't found a reproducer, at least yet. It took half a day of
> > > uptime to hit this, so might not be that easy.
> >=20
> > Hum, if you can acquire a crash dump it would be the easiest I guess. W=
e'd
> > need to find out more about the request we crash on - whether it's
> > otherwise valid, in what state it is etc...
>=20
> Still have no reliable reproducer and no vmcore, however I'm running v5.13
> with the following patches applied on top of it:
>=20
> ```
> blk: Fix lock inversion between ioc lock and bfqd lock
> bfq: Remove merged request already in bfq_requests_merged()
> block: Remove unnecessary elevator operation checks
> block: Do not pull requests from the scheduler when we cannot dispatch th=
em
> block, bfq: reset waker pointer with shared queues
> block, bfq: check waker only for queues with no in-flight I/O
> block, bfq: avoid delayed merge of async queues
> block, bfq: boost throughput by extending queue-merging times
> block, bfq: consider also creation time in delayed stable merge
> block, bfq: fix delayed stable merge check
> block, bfq: let also stably merged queues enjoy weight raising
> ```
>=20
> and just got the following crash:
>=20
> ```
> [60313.522570] ------------[ cut here ]------------
> [60313.522579] WARNING: CPU: 20 PID: 388 at arch/x86/include/asm/kfence.h=
:44
> kfence_protect_page+0x39/0xc0
> [60313.522586] Modules linked in: sctp ip6_udp_tunnel udp_tunnel uinput
> netconsole blocklayoutdriver rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolv=
er
> nfs lockd grace sunrpc fscache netfs rfcomm nft_ct nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 cmac algif_hash algif_skcipher nf_tables
> af_alg bnep tun nfnetlink nls_iso8859_1 intel_rapl_msr vfat
> intel_rapl_common iwlmvm fat mac80211 edac_mce_amd libarc4 btusb eeepc_wmi
> btrtl asus_wmi iwlwifi btbcm snd_usb_audio sparse_keymap kvm_amd video
> wmi_bmof mxm_wmi btintel uvcvideo snd_hda_codec_realtek videobuf2_vmalloc
> videobuf2_memops snd_usbmidi_lib kvm snd_hda_codec_generic bluetooth
> videobuf2_v4l2 ledtrig_audio
> snd_hda_codec_hdmi joydev snd_rawmidi ecdh_generic irqbypass ecc
> snd_hda_intel mousedev pl2303 cfg80211 snd_seq_device videobuf2_common
> crc16 rapl k10temp snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec igb
> r8169 sp5100_tco snd_hda_core realtek i2c_piix4 ipmi_devintf dca snd_hwdep
> mdio_devres rfkill snd_pcm libphy ipmi_msghandler wmi
> [60313.522630]  pinctrl_amd mac_hid acpi_cpufreq tcp_bbr2 vhost_vsock
> vmw_vsock_virtio_transport_common vhost vhost_iotlb vsock v4l2loopback
> videodev mc snd_hrtimer snd_timer snd soundcore nct6775 hwmon_vid
> crypto_user fuse ip_tables x_tables xfs dm_thin_pool dm_persistent_data
> dm_bio_prison dm_bufio libcrc32c crc32c_generic dm_crypt cbc encrypted_ke=
ys
> trusted asn1_encoder tee hid_logitech_hidpp hid_logitech_dj usbhid dm_mod
> crct10dif_pclmul crc32_pclmul crc32c_intel raid10 ghash_clmulni_intel
> aesni_intel md_mod crypto_simd cryptd amdgpu ccp xhci_pci xhci_pci_renesas
> tpm_crb tpm_tis tpm_tis_core tpm rng_core drm_ttm_helper ttm gpu_sched
> i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
> cec drm agpgart
> [60313.522665] CPU: 20 PID: 388 Comm: kworker/20:1H Tainted: G        W
> 5.13.0-pf2 #1
> [60313.522668] Hardware name: ASUS System Product Name/Pro WS X570-ACE, B=
IOS
> 3601 05/26/2021
> [60313.522671] Workqueue: kblockd blk_mq_run_work_fn
> [60313.522675] RIP: 0010:kfence_protect_page+0x39/0xc0
> [60313.522679] Code: 04 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 c7
> 44 24 04 00 00 00 00 e8 83 20 d5 ff 48 85 c0 74 07 83 7c 24 04 01 74 06
> <0f> 0b 31 c0 eb 4c 48 8b 38 48 89 c2 84 db 75 59 48 89 f8 0f 1f 40
> [60313.522682] RSP: 0018:ffffb559c0affb28 EFLAGS: 00010046
> [60313.522684] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> ffffb559c0affb2c [60313.522687] RDX: ffffb559c0affb2c RSI: 00000000000000=
00
> RDI: 0000000000000000 [60313.522690] RBP: 0000000000000000 R08:
> 0000000000000000 R09:
> 0000000000000000
> [60313.522692] R10: 0000000000000000 R11: 0000000000000000 R12:
> 0000000000000002
> [60313.522694] R13: ffffb559c0affc28 R14: 00000000c0affc01 R15:
> 0000000000000000 [60313.522696] FS:  0000000000000000(0000)
> GS:ffff8cf44ef00000(0000) knlGS: 0000000000000000
> [60313.522698] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [60313.522700] CR2: 0000000000000120 CR3: 000000013ebce000 CR4:
> 0000000000350ee0
> [60313.522702] Call Trace:
> [60313.522707]  kfence_handle_page_fault+0xa6/0x280
> [60313.522710]  page_fault_oops+0x9d/0x2d0
> [60313.522714]  exc_page_fault+0x78/0x180
> [60313.522718]  asm_exc_page_fault+0x1e/0x30
> [60313.522721] RIP: 0010:bfq_dispatch_request+0x4c3/0x1280
> [60313.522725] Code: 4c 89 e7 e8 ef da ff ff 4c 89 ff 89 c6 e8 75 64 00 00
> 4c 39 bb a0 00 00 00 0f 84 86 04 00 00 49 8b 84 24 90 00 00 00 48 8b 33
> <ff> 80 20 01 00 00 48 89 34 24 48 8b 46 08 4c 8b 58 08 4c 89 5c 24
> [60313.522727] RSP: 0018:ffffb559c0affcd0 EFLAGS: 00010046
> [60313.522729] RAX: 0000000000000000 RBX: ffff8ced4d6a1000 RCX:
> 0000000000000000 [60313.522731] RDX: 0000000000000000 RSI: ffff8ced4ad900=
00
> RDI: ffff8ced52fc9f40 [60313.522733] RBP: 0000000000000000 R08:
> 0000000000000001 R09:
> 0000000000000000
> [60313.522735] R10: 000000000000003f R11: 0000000000000000 R12:
> ffff8cf20e5a5400 [60313.522737] R13: ffff8cf0e7e91c70 R14: ffff8ced4d6a14=
20
> R15: ffff8cf0e7e91c70 [60313.522741]  ? mod_delayed_work_on+0x71/0xe0
> [60313.522745]  ? __sbitmap_get_word+0x30/0x80
> [60313.522748]  __blk_mq_do_dispatch_sched+0x218/0x320
> [60313.522752]  __blk_mq_sched_dispatch_requests+0x107/0x150
> [60313.522755]  blk_mq_sched_dispatch_requests+0x2f/0x60
> [60313.522758]  blk_mq_run_work_fn+0x43/0xc0
> [60313.522761]  process_one_work+0x24e/0x430
> [60313.522765]  worker_thread+0x54/0x4d0
> [60313.522767]  ? process_one_work+0x430/0x430
> [60313.522770]  kthread+0x182/0x1b0
> [60313.522773]  ? __kthread_init_worker+0x50/0x50
> [60313.522776]  ret_from_fork+0x22/0x30
> [60313.522781] ---[ end trace 55ef262e614b59af ]---
> [60313.522786] ------------[ cut here ]------------
> [60313.522787] WARNING: CPU: 20 PID: 388 at mm/kfence/core.c:135
> kfence_handle_page_fault+0xaa/0x280
> [60313.522791] Modules linked in: sctp ip6_udp_tunnel udp_tunnel uinput
> netconsole blocklayoutdriver rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolv=
er
> nfs lockd grace sunrpc fscache netfs rfcomm nft_ct nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 cmac algif_hash algif_skcipher nf_tables
> af_alg bnep tun nfnetlink nls_iso8859_1 intel_rapl_msr vfat
> intel_rapl_common iwlmvm fat mac80211 edac_mce_amd libarc4 btusb eeepc_wmi
> btrtl asus_wmi iwlwifi btbcm snd_usb_audio sparse_keymap kvm_amd video
> wmi_bmof mxm_wmi btintel uvcvideo snd_hda_codec_realtek videobuf2_vmalloc
> videobuf2_memops snd_usbmidi_lib kvm snd_hda_codec_generic bluetooth
> videobuf2_v4l2 ledtrig_audio
> snd_hda_codec_hdmi joydev snd_rawmidi ecdh_generic irqbypass ecc
> snd_hda_intel mousedev pl2303 cfg80211 snd_seq_device videobuf2_common
> crc16 rapl k10temp snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec igb
> r8169 sp5100_tco snd_hda_core realtek i2c_piix4 ipmi_devintf dca snd_hwdep
> mdio_devres rfkill snd_pcm libphy ipmi_msghandler wmi
> [60313.522817]  pinctrl_amd mac_hid acpi_cpufreq tcp_bbr2 vhost_vsock
> vmw_vsock_virtio_transport_common vhost vhost_iotlb vsock v4l2loopback
> videodev mc snd_hrtimer snd_timer snd soundcore nct6775 hwmon_vid
> crypto_user fuse ip_tables x_tables xfs dm_thin_pool dm_persistent_data
> dm_bio_prison dm_bufio libcrc32c crc32c_generic dm_crypt cbc encrypted_ke=
ys
> trusted asn1_encoder tee hid_logitech_hidpp hid_logitech_dj usbhid dm_mod
> crct10dif_pclmul crc32_pclmul crc32c_intel raid10 ghash_clmulni_intel
> aesni_intel md_mod crypto_simd cryptd amdgpu ccp xhci_pci xhci_pci_renesas
> tpm_crb tpm_tis tpm_tis_core tpm rng_core drm_ttm_helper ttm gpu_sched
> i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
> cec drm agpgart
> [60313.522840] CPU: 20 PID: 388 Comm: kworker/20:1H Tainted: G        W
> 5.13.0-pf2 #1
> [60313.522843] Hardware name: ASUS System Product Name/Pro WS X570-ACE, B=
IOS
> 3601 05/26/2021
> [60313.522845] Workqueue: kblockd blk_mq_run_work_fn
> [60313.522848] RIP: 0010:kfence_handle_page_fault+0xaa/0x280
> [60313.522851] Code: 0f 86 d4 00 00 00 0f b6 f3 41 b8 03 00 00 00 31 c9 4c
> 89 ea 48 89 ef e8 e4 05 00 00 31 f6 4c 89 ff e8 6a f5 ff ff 84 c0 75 8d
> <0f> 0b c6 05 7d fd 6b 01 00 45 31 f6 e9 7c ff ff ff 48 8b 0d 36 a0
> [60313.522853] RSP: 0018:ffffb559c0affb50 EFLAGS: 00010046
> [60313.522855] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> ffffb559c0affb2c [60313.522857] RDX: 0000000000000000 RSI: 00000000000000=
00
> RDI:
> 0000000000000000
> [60313.522859] RBP: 0000000000000120 R08: 0000000000000000 R09:
> 0000000000000000
> [60313.522860] R10: 0000000000000000 R11: 0000000000000000 R12:
> 0000000000000002
> [60313.522862] R13: ffffb559c0affc28 R14: 00000000c0affc01 R15:
> 0000000000000000 [60313.522864] FS:  0000000000000000(0000)
> GS:ffff8cf44ef00000(0000) knlGS: 0000000000000000
> [60313.522866] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [60313.522868] CR2: 0000000000000120 CR3: 000000013ebce000 CR4:
> 0000000000350ee0
> [60313.522870] Call Trace:
> [60313.522872]  page_fault_oops+0x9d/0x2d0
> [60313.522875]  exc_page_fault+0x78/0x180
> [60313.522878]  asm_exc_page_fault+0x1e/0x30
> [60313.522880] RIP: 0010:bfq_dispatch_request+0x4c3/0x1280
> [60313.522883] Code: 4c 89 e7 e8 ef da ff ff 4c 89 ff 89 c6 e8 75 64 00 00
> 4c 39 bb a0 00 00 00 0f 84 86 04 00 00 49 8b 84 24 90 00 00 00 48 8b 33
> <ff> 80 20 01 00 00 48 89 34 24 48 8b 46 08 4c 8b 58 08 4c 89 5c 24
> [60313.522885] RSP: 0018:ffffb559c0affcd0 EFLAGS: 00010046
> [60313.522887] RAX: 0000000000000000 RBX: ffff8ced4d6a1000 RCX:
> 0000000000000000 [60313.522889] RDX: 0000000000000000 RSI: ffff8ced4ad900=
00
> RDI: ffff8ced52fc9f40 [60313.522890] RBP: 0000000000000000 R08:
> 0000000000000001 R09:
> 0000000000000000
> [60313.522892] R10: 000000000000003f R11: 0000000000000000 R12:
> ffff8cf20e5a5400 [60313.523148] R13: ffff8cf0e7e91c70 R14: ffff8ced4d6a14=
20
> R15: ffff8cf0e7e91c70 [60313.523150]  ? mod_delayed_work_on+0x71/0xe0
> [60313.523153]  ? __sbitmap_get_word+0x30/0x80
> [60313.523157]  __blk_mq_do_dispatch_sched+0x218/0x320
> [60313.523161]  __blk_mq_sched_dispatch_requests+0x107/0x150
> [60313.523165]  blk_mq_sched_dispatch_requests+0x2f/0x60
> [60313.523167]  blk_mq_run_work_fn+0x43/0xc0
> [60313.523170]  process_one_work+0x24e/0x430
> [60313.523173]  worker_thread+0x54/0x4d0
> [60313.523176]  ? process_one_work+0x430/0x430
> [60313.523178]  kthread+0x182/0x1b0
> [60313.523181]  ? __kthread_init_worker+0x50/0x50
> [60313.523183]  ret_from_fork+0x22/0x30
> [60313.523187] ---[ end trace 55ef262e614b59b0 ]---
> [60313.523189] BUG: kernel NULL pointer dereference, address:
> 0000000000000120 [60313.523191] #PF: supervisor write access in kernel mo=
de
> [60313.523193] #PF: error_code(0x0002) - not-present page
> [60313.523195] PGD 0 P4D 0
> [60313.523197] Oops: 0002 [#1] PREEMPT SMP NOPTI
> [60313.523200] CPU: 20 PID: 388 Comm: kworker/20:1H Tainted: G        W
> 5.13.0-pf2 #1
> [60313.523202] Hardware name: ASUS System Product Name/Pro WS X570-ACE, B=
IOS
> 3601 05/26/2021
> [60313.523204] Workqueue: kblockd blk_mq_run_work_fn
> [60313.523207] RIP: 0010:bfq_dispatch_request+0x4c3/0x1280
> [60313.523210] Code: 4c 89 e7 e8 ef da ff ff 4c 89 ff 89 c6 e8 75 64 00 00
> 4c 39 bb a0 00 00 00 0f 84 86 04 00 00 49 8b 84 24 90 00 00 00 48 8b 33
> <ff> 80 20 01 00 00 48 89 34 24 48 8b 46 08 4c 8b 58 08 4c 89 5c 24
> [60313.523213] RSP: 0018:ffffb559c0affcd0 EFLAGS: 00010046
> [60313.523215] RAX: 0000000000000000 RBX: ffff8ced4d6a1000 RCX:
> 0000000000000000 [60313.523216] RDX: 0000000000000000 RSI: ffff8ced4ad900=
00
> RDI: ffff8ced52fc9f40 [60313.523218] RBP: 0000000000000000 R08:
> 0000000000000001 R09:
> 0000000000000000
> [60313.523220] R10: 000000000000003f R11: 0000000000000000 R12:
> ffff8cf20e5a5400 [60313.523221] R13: ffff8cf0e7e91c70 R14: ffff8ced4d6a14=
20
> R15: ffff8cf0e7e91c70 [60313.523223] FS:  0000000000000000(0000)
> GS:ffff8cf44ef00000(0000) knlGS: 0000000000000000
> [60313.523225] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [60313.523227] CR2: 0000000000000120 CR3: 000000013ebce000 CR4:
> 0000000000350ee0
> [60313.523229] Call Trace:
> [60313.523231]  ? mod_delayed_work_on+0x71/0xe0
> [60313.523233]  ? __sbitmap_get_word+0x30/0x80
> [60313.523237]  __blk_mq_do_dispatch_sched+0x218/0x320
> [60313.523240]  __blk_mq_sched_dispatch_requests+0x107/0x150
> [60313.523243]  blk_mq_sched_dispatch_requests+0x2f/0x60
> [60313.523246]  blk_mq_run_work_fn+0x43/0xc0
> [60313.523249]  process_one_work+0x24e/0x430
> [60313.523251]  worker_thread+0x54/0x4d0
> [60313.523254]  ? process_one_work+0x430/0x430
> [60313.523257]  kthread+0x182/0x1b0
> [60313.523259]  ? __kthread_init_worker+0x50/0x50
> [60313.523261]  ret_from_fork+0x22/0x30
> [60313.523265] Modules linked in: sctp ip6_udp_tunnel udp_tunnel uinput
> netconsole blocklayoutdriver rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolv=
er
> nfs lockd grace sunrpc fscache netfs rfcomm nft_ct nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 cmac algif_hash algif_skcipher nf_tables
> af_alg bnep tun nfnetlink nls_iso8859_1 intel_rapl_msr vfat
> intel_rapl_common iwlmvm fat mac80211 edac_mce_amd libarc4 btusb eeepc_wmi
> btrtl asus_wmi iwlwifi btbcm snd_usb_audio sparse_keymap kvm_amd video
> wmi_bmof mxm_wmi btintel uvcvideo snd_hda_codec_realtek videobuf2_vmalloc
> videobuf2_memops snd_usbmidi_lib kvm snd_hda_codec_generic bluetooth
> videobuf2_v4l2 ledtrig_audio
> snd_hda_codec_hdmi joydev snd_rawmidi ecdh_generic irqbypass ecc
> snd_hda_intel mousedev pl2303 cfg80211 snd_seq_device videobuf2_common
> crc16 rapl k10temp snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec igb
> r8169 sp5100_tco snd_hda_core realtek i2c_piix4 ipmi_devintf dca snd_hwdep
> mdio_devres rfkill snd_pcm libphy ipmi_msghandler wmi
> [60313.523290]  pinctrl_amd mac_hid acpi_cpufreq tcp_bbr2 vhost_vsock
> vmw_vsock_virtio_transport_common vhost vhost_iotlb vsock v4l2loopback
> videodev mc snd_hrtimer snd_timer snd soundcore nct6775 hwmon_vid
> crypto_user fuse ip_tables x_tables xfs dm_thin_pool dm_persistent_data
> dm_bio_prison dm_bufio libcrc32c crc32c_generic dm_crypt cbc encrypted_ke=
ys
> trusted asn1_encoder tee hid_logitech_hidpp hid_logitech_dj usbhid dm_mod
> crct10dif_pclmul crc32_pclmul crc32c_intel raid10 ghash_clmulni_intel
> aesni_intel md_mod crypto_simd cryptd amdgpu ccp xhci_pci xhci_pci_renesas
> tpm_crb tpm_tis tpm_tis_core tpm rng_core drm_ttm_helper ttm gpu_sched
> i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
> cec drm agpgart
> [60313.523314] CR2: 0000000000000120
> [60313.523316] ---[ end trace 55ef262e614b59b1 ]---
> [60313.523318] RIP: 0010:bfq_dispatch_request+0x4c3/0x1280
> [60313.523321] Code: 4c 89 e7 e8 ef da ff ff 4c 89 ff 89 c6 e8 75 64 00 00
> 4c 39 bb a0 00 00 00 0f 84 86 04 00 00 49 8b 84 24 90 00 00 00 48 8b 33
> <ff> 80 20 01 00 00 48 89 34 24 48 8b 46 08 4c 8b 58 08 4c 89 5c 24
> [60313.523323] RSP: 0018:ffffb559c0affcd0 EFLAGS: 00010046
> [60313.523325] RAX: 0000000000000000 RBX: ffff8ced4d6a1000 RCX:
> 0000000000000000 [60313.523326] RDX: 0000000000000000 RSI: ffff8ced4ad900=
00
> RDI: ffff8ced52fc9f40 [60313.523328] RBP: 0000000000000000 R08:
> 0000000000000001 R09:
> 0000000000000000
> [60313.523330] R10: 000000000000003f R11: 0000000000000000 R12:
> ffff8cf20e5a5400 [60313.523332] R13: ffff8cf0e7e91c70 R14: ffff8ced4d6a14=
20
> R15: ffff8cf0e7e91c70 [60313.523334] FS:  0000000000000000(0000)
> GS:ffff8cf44ef00000(0000) knlGS: 0000000000000000
> [60313.523336] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [60313.523338] CR2: 0000000000000120 CR3: 000000013ebce000 CR4:
> 0000000000350ee0
> [60313.523339] note: kworker/20:1H[388] exited with preempt_count 1
> ```

This is just to let you know that I'm running v5.13.7 without any extra=20
patches under block/ applied, and the issue is not reproducible.

I'll probably defer investigating this till v5.14 unless it is fixed there=
=20
already.

=2D-=20
Oleksandr Natalenko (post-factum)


