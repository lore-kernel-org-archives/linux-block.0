Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0963F26FA67
	for <linux-block@vger.kernel.org>; Sun,  7 Sep 2025 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757256523; cv=none; b=DW9DxNFzNjle9uUP7fVL/GPMl5Ea7uqRhyM9/iOM+E8SZAlELtF0E2hN1ld9+Z782nYJvzc/SqimeaG0NvyRoeGe71KdwHrAbjsUwG3Q+DpFFUxuTVoKG36M5cfnCAofM3AKpQxa4ov45T6AE44OdNiSDtbA2CXl3KNrelK6BPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757256523; c=relaxed/simple;
	bh=RAou2zrvH2Ddtn2PfoujPky2kZj9A+2qR2a+If4hS28=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ChblUrbsm9tzMBOsvLWUEmGrqASjDB4AY6OyIhfg9PgZ+bo5LzZsUuJT9wwDXRvoOnVLX3AwXHwnfr+gO0knRaggoIITxk0woHHbTHPrKF0UpNc3D2/SQ8JDxKbndQcmfN4dxSN3OOBasI65AOvLTU9N3RtJyeWhY21Q8Cph69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.geov.name; spf=pass smtp.mailfrom=mail.geov.name; dkim=pass (2048-bit key) header.d=mail.geov.name header.i=@mail.geov.name header.b=i8mMWsGy; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.geov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.geov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.geov.name header.i=@mail.geov.name header.b="i8mMWsGy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.geov.name;
	s=protonmail; t=1757256510; x=1757515710;
	bh=gDY+uQHXH5f3Y3b5Le8gyK8E8PiL+/46NgPR3feiReg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=i8mMWsGyPmEo6naWstQI3ca5K2LuxQ2M0vZIUZJKtEUOzf3HTbQKEfEgRQ/5DQl1V
	 uvYgb6OvFX5f39lXWh9p/3Tq6jdItINWP8VEY9pyXz9Z8fpnom4/M0q9VaTplMFXu1
	 3Kh/cjSrSoAxH1ZYpe/3UAGbc+4eIviChUKV96R6wozPwNPNo2I44/9JI0o+DAtUwv
	 sSwjTMS4yXvgeQochLJzALRqfdlEJtOcrEva7D7dfuaXB3m++DzNXYFlPW9Y8yZMnS
	 Gis/LczY7N580F2qOp3shIwwuHAJUjRvLS/hTcu8TKzukaYlLzXxGl7LLhQwI0MSQk
	 Np0xfyieAL3yA==
Date: Sun, 07 Sep 2025 14:48:27 +0000
To: Ming Lei <ming.lei@redhat.com>
From: Heorhi Valakhanovich <code@mail.geov.name>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: [blk-mq] Kernel OOPS after usb drive surprise remove (bisected)
Message-ID: <LmKwxMZhQ0h6bHWk_m7EMu4jDpbdcL0Z4gix3USIvS2sJpGZP1b_858GvxaDL6zwoGxrPIs-dT10NLxersJpxExsOOpJmyDh_fTOp97ZBYE=@mail.geov.name>
Feedback-ID: 35076807:user:proton
X-Pm-Message-ID: fa963a6b3f4a00c1f6911db0b4eb8f3b59571bd3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kernel version 6.16.4 and later.

Usb3 thumb drive surprise removal triggers an oops in blk_mq_free_map_and_r=
qs.
Block IO is limping afterwards and often system is unusable.


Bisected to:

commit f9a9098ca82612006b9c71ce03b8fe189a437370 (HEAD)
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Aug 15 21:17:37 2025 +0800

    blk-mq: fix lockdep warning in __blk_mq_update_nr_hw_queues

    [ Upstream commit 2d82f3bd8910eb65e30bb2a3c9b945bfb3b6d661 ]


relevant kernel log:

Sep 07 17:19:26: BUG: kernel NULL pointer dereference, address: 00000000000=
00020
Sep 07 17:19:26: #PF: supervisor read access in kernel mode
Sep 07 17:19:26: #PF: error_code(0x0000) - not-present page
Sep 07 17:19:26: PGD 0 P4D 0=20
Sep 07 17:19:26: Oops: Oops: 0000 [#1] SMP NOPTI
Sep 07 17:19:26: CPU: 13 UID: 0 PID: 187 Comm: kworker/13:1 Not tainted 6.1=
6.3-00443-gf9a9098ca826 #1 PREEMPT(full)  423b99baa3ae977c97c0f9254bac675c4=
062a00a
Sep 07 17:19:26: Hardware name: Micro-Star International Co., Ltd. MS-7B89/=
B450M MORTAR MAX (MS-7B89), BIOS 2.K0 10/20/2023
Sep 07 17:19:26: Workqueue: usb_hub_wq hub_event
Sep 07 17:19:26: RIP: 0010:blk_mq_free_rqs+0xdd/0x1f0
Sep 07 17:19:26: Code: ed 0f 84 fb 00 00 00 4c 39 e5 0f 84 f2 00 00 00 49 8=
b 84 24 a0 00 00 00 31 ff 4c 8d 40 f8 48 39 c3 74 77 8b 45 00 85 c0 74 63 <=
49> 8b 48 28 4c 89 c6 48 2b 35 9d 42 1b 01 31 d2 48 c1 fe 06 41 b9
Sep 07 17:19:26: RSP: 0018:ffffce50c133f8d8 EFLAGS: 00010202
Sep 07 17:19:26: RAX: 0000000000000001 RBX: ffff8d90870baee0 RCX: ffff8d904=
b335d70
Sep 07 17:19:26: RDX: 0000000000000000 RSI: ffff8d90870bae40 RDI: 000000000=
0000000
Sep 07 17:19:26: RBP: ffff8d9044aaeb40 R08: fffffffffffffff8 R09: 000000000=
0000001
Sep 07 17:19:26: R10: ffffce50c133f8c8 R11: ffffce50c133f8c0 R12: ffff8d908=
70bae40
Sep 07 17:19:26: R13: 0000000000000001 R14: ffff8d90a2f850e0 R15: ffff8d90a=
2f850e0
Sep 07 17:19:26: FS:  0000000000000000(0000) GS:ffff8d97bbc6a000(0000) knlG=
S:0000000000000000
Sep 07 17:19:26: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Sep 07 17:19:26: CR2: 0000000000000020 CR3: 0000000168fad000 CR4: 000000000=
0f50ef0
Sep 07 17:19:26: PKRU: 55555554
Sep 07 17:19:26: Call Trace:
Sep 07 17:19:26:  <TASK>
Sep 07 17:19:26:  blk_mq_free_map_and_rqs+0x17/0x60
Sep 07 17:19:26:  blk_mq_free_sched_tags+0x34/0x70
Sep 07 17:19:26:  elevator_change_done+0x4a/0x1f0
Sep 07 17:19:26:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 07 17:19:26:  ? elevator_switch+0x1a3/0x210
Sep 07 17:19:26:  elevator_change+0xdb/0x180
Sep 07 17:19:26:  elevator_set_none+0x50/0x80
Sep 07 17:19:26:  blk_unregister_queue+0xae/0x110
Sep 07 17:19:26:  __del_gendisk+0x140/0x2f0
Sep 07 17:19:26:  del_gendisk+0x7b/0xa0
Sep 07 17:19:26:  sd_remove+0x2f/0x60
Sep 07 17:19:26:  device_release_driver_internal+0x19e/0x200
Sep 07 17:19:26:  bus_remove_device+0xc2/0x130
Sep 07 17:19:26:  device_del+0x160/0x3d0
Sep 07 17:19:26:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 07 17:19:26:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 07 17:19:26:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 07 17:19:26:  __scsi_remove_device+0x13a/0x190
Sep 07 17:19:26:  scsi_forget_host+0x59/0x60
Sep 07 17:19:26:  scsi_remove_host+0x76/0x160
Sep 07 17:19:26:  usb_stor_disconnect+0x46/0xb0 [usb_storage 8e39c2fe1b0cfd=
509b87bd75841570a6d09a4d0d]
Sep 07 17:19:26:  usb_unbind_interface+0x93/0x280
Sep 07 17:19:26:  device_release_driver_internal+0x19e/0x200
Sep 07 17:19:26:  bus_remove_device+0xc2/0x130
Sep 07 17:19:26:  device_del+0x160/0x3d0
Sep 07 17:19:26:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 07 17:19:26:  ? kobject_put+0xa2/0x200
Sep 07 17:19:26:  usb_disable_device+0xf4/0x220
Sep 07 17:19:26:  usb_disconnect+0xdf/0x2d0
Sep 07 17:19:26:  hub_event+0xe4e/0x1900
Sep 07 17:19:26:  ? exc_bounds+0x1/0xb0
Sep 07 17:19:26:  process_one_work+0x193/0x350
Sep 07 17:19:26:  worker_thread+0x2d7/0x410
Sep 07 17:19:26:  ? __pfx_worker_thread+0x10/0x10
Sep 07 17:19:26:  kthread+0xfc/0x240
Sep 07 17:19:26:  ? __pfx_kthread+0x10/0x10
Sep 07 17:19:26:  ? __pfx_kthread+0x10/0x10
Sep 07 17:19:26:  ret_from_fork+0x19a/0x1d0
Sep 07 17:19:26:  ? __pfx_kthread+0x10/0x10
Sep 07 17:19:26:  ret_from_fork_asm+0x1a/0x30
Sep 07 17:19:26:  </TASK>
Sep 07 17:19:26: Modules linked in: uas usb_storage snd_seq_dummy snd_hrtim=
er snd_seq snd_seq_device nft_masq nft_ct nft_reject_ipv4 nf_reject_ipv4 nf=
t_reject act_csum cls_u32 sch_htb nft_chain_nat nf_nat nf_conntrack nf_defr=
ag_ipv6 nf_defrag_ipv4 nf_tables bridge stp llc cmac nls_utf8 cifs cifs_arc=
4 nls_ucs2_utils rdma_cm iw_cm ib_cm ib_core cifs_md4 dns_resolver netfs tu=
n nct6775 nct6775_core hwmon_vid r8153_ecm cdc_ether usbnet vfat fat amd_at=
l intel_rapl_msr intel_rapl_common snd_hda_codec_realtek snd_hda_codec_gene=
ric snd_hda_scodec_component snd_hda_codec_hdmi snd_hda_intel snd_intel_dsp=
cfg snd_intel_sdw_acpi kvm_amd snd_hda_codec snd_hda_core snd_hwdep essiv k=
vm ee1004 r8169 authenc snd_pcm r8152 realtek mii snd_timer mdio_devres irq=
bypass sp5100_tco snd rapl wmi_bmof pcspkr libphy i2c_piix4 cfg80211 soundc=
ore i2c_smbus mdio_bus joydev mousedev gpio_amdpt gpio_generic rfkill mac_h=
id sch_fq tcp_westwood tcp_veno tcp_htcp tcp_yeah tcp_vegas tcp_bbr ntsync =
i2c_dev sg crypto_user loop nfnetlink ip_tables x_tables
Sep 07 17:19:26:  dm_crypt encrypted_keys trusted asn1_encoder tee amdgpu d=
m_mod amdxcp i2c_algo_bit drm_ttm_helper ttm drm_exec gpu_sched drm_suballo=
c_helper video drm_panel_backlight_quirks drm_buddy nvme drm_display_helper=
 polyval_clmulni nvme_core ghash_clmulni_intel sha512_ssse3 ccp sha1_ssse3 =
aesni_intel cec nvme_keyring nvme_auth wmi
Sep 07 17:19:26: CR2: 0000000000000020
Sep 07 17:19:26: ---[ end trace 0000000000000000 ]---
Sep 07 17:19:26: RIP: 0010:blk_mq_free_rqs+0xdd/0x1f0
Sep 07 17:19:26: Code: ed 0f 84 fb 00 00 00 4c 39 e5 0f 84 f2 00 00 00 49 8=
b 84 24 a0 00 00 00 31 ff 4c 8d 40 f8 48 39 c3 74 77 8b 45 00 85 c0 74 63 <=
49> 8b 48 28 4c 89 c6 48 2b 35 9d 42 1b 01 31 d2 48 c1 fe 06 41 b9
Sep 07 17:19:26: RSP: 0018:ffffce50c133f8d8 EFLAGS: 00010202
Sep 07 17:19:26: RAX: 0000000000000001 RBX: ffff8d90870baee0 RCX: ffff8d904=
b335d70
Sep 07 17:19:26: RDX: 0000000000000000 RSI: ffff8d90870bae40 RDI: 000000000=
0000000
Sep 07 17:19:26: RBP: ffff8d9044aaeb40 R08: fffffffffffffff8 R09: 000000000=
0000001
Sep 07 17:19:26: R10: ffffce50c133f8c8 R11: ffffce50c133f8c0 R12: ffff8d908=
70bae40
Sep 07 17:19:26: R13: 0000000000000001 R14: ffff8d90a2f850e0 R15: ffff8d90a=
2f850e0
Sep 07 17:19:26: FS:  0000000000000000(0000) GS:ffff8d97bbc6a000(0000) knlG=
S:0000000000000000
Sep 07 17:19:26: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Sep 07 17:19:26: CR2: 0000000000000020 CR3: 0000000168fad000 CR4: 000000000=
0f50ef0
Sep 07 17:19:26: PKRU: 55555554
Sep 07 17:19:26: note: kworker/13:1[187] exited with irqs disabled
