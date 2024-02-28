Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6B1B515AAAC
	for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135204; cv=none; b=gCPrQsgMStqspmY4AqkzW7E6zu5AimF63NQblOkU1ROfMt3SNgoYJZScoBMLtnQd/aDtbjlkw4nRLQFEBuSCQZIG2772gVXbCNuDQ/Oz88m1DBa2mxGEhMQqJfyxsuxMsgeRfywSRONic4WC+fCYEafUSDKDbDS0Aw2IDBrWIcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135204; c=relaxed/simple;
	bh=RRhUjTarAWFgFe85hnqY3oCI4kex7NyqDN6Wz1RpY5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5tW9tlgrCHSeD3Ayi70CeASs5XIuUi65Fg698Xwch8hVTzwyHzFRk8D8Lepg/TSiloRcDv0kTWsRees4Ar0pv8pvoyRlwIwHKdT0mjuzgcrmIwu9fM7RtTPlqIxlgIMYyNJDbuAsZ8v/iGBDniW2oM+n+CbyMW2CzhQVxL8cs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 796578 invoked by uid 1000); 28 Feb 2024 10:46:39 -0500
Date: Wed, 28 Feb 2024 10:46:39 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Harald Dunkel <harald.dunkel@aixigo.com>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
  linux-block@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: RIP on discard, JMicron USB adaptor
Message-ID: <62296d89-f7e6-4f54-add8-35b531dc657c@rowland.harvard.edu>
References: <70bc51d7-c8a2-4b06-ab7a-e321d20db49a@aixigo.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <70bc51d7-c8a2-4b06-ab7a-e321d20db49a@aixigo.com>

On Wed, Feb 28, 2024 at 01:22:12PM +0100, Harald Dunkel wrote:
> Hi folks,
>=20
> not sure if this was supposed to happen:
>=20
> [1400821.811585] ------------[ cut here ]------------
> [1400821.811594] WARNING: CPU: 0 PID: 614303 at block/blk-lib.c:50 __blkd=
ev_issue_discard+0x14b/0x180
> [1400821.811612] Modules linked in: cdc_mbim cdc_wdm tcp_diag udp_diag in=
et_diag exfat snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd=
_seq cpufreq_userspace cpufreq_conservative cpufreq_powersave cpufreq_ondem=
and cts rpcsec_gss_krb5 nfsv4 dns_resolver nfs lockd grace fscache netfs sc=
si_transport_iscsi nvme_fabrics dell_rbu rfkill qrtr dcdbas uinput binfmt_m=
isc nls_ascii nls_cp437 vfat fat nvidia_drm(POE) nvidia_modeset(POE) intel_=
rapl_msr intel_rapl_common x86_pkg_temp_thermal snd_hda_codec_realtek intel=
_powerclamp xt_recent snd_hda_codec_generic ledtrig_audio coretemp snd_sof_=
pci_intel_tgl snd_sof_intel_hda_common soundwire_intel soundwire_generic_al=
location soundwire_cadence snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp=
 snd_sof snd_sof_utils snd_soc_hdac_hda snd_hda_codec_hdmi snd_hda_ext_core=
 snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core snd_compress soundwire_=
bus snd_hda_intel snd_usb_audio snd_intel_dspcfg br_netfilter snd_intel_sdw=
_acpi kvm_intel overlay
> [1400821.811692]  snd_usbmidi_lib i915 xt_comment snd_hda_codec uvcvideo =
xt_CHECKSUM snd_rawmidi snd_hda_core videobuf2_vmalloc kvm drm_buddy snd_se=
q_device nf_tables snd_hwdep videobuf2_memops drm_display_helper videobuf2_=
v4l2 nfnetlink snd_pcm_oss irqbypass videobuf2_common bridge snd_mixer_oss =
cec 8021q videodev rapl garp rc_core intel_cstate mei_hdcp nvidia(POE) snd_=
pcm evdev stp mc wmi_bmof gigabyte_wmi mrp intel_uncore ttm iTCO_wdt llc sn=
d_timer intel_pmc_bxt bonding pcspkr drm_kms_helper macvlan snd iTCO_vendor=
_support intel_hid tls watchdog soundcore veth i2c_algo_bit sg sparse_keyma=
p acpi_pad intel_pmc_core acpi_tad button mei_me mei iptable_nat iptable_ma=
ngle iptable_filter ip6table_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defr=
ag_ipv4 auth_rpcgss ip6table_mangle ip6table_filter ip6_tables drm fuse loo=
p efi_pstore sunrpc configfs ip_tables x_tables autofs4 ext4 crc16 mbcache =
jbd2 btrfs blake2b_generic zstd_compress efivarfs raid10 raid456 async_raid=
6_recov async_memcpy async_pq
> [1400821.811799]  async_xor async_tx xor raid6_pq libcrc32c crc32c_generi=
c raid0 multipath linear hid_logitech_hidpp hid_logitech_dj uas usb_storage=
 hid_generic usbhid hid cdc_ncm cdc_ether usbnet raid1 md_mod r8152 mii sd_=
mod dm_mod crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 sha51=
2_generic sha256_ssse3 sha1_ssse3 nvme nvme_core ahci xhci_pci t10_pi libah=
ci crc64_rocksoft_generic xhci_hcd libata aesni_intel r8169 realtek crc64_r=
ocksoft crc_t10dif mdio_devres usbcore scsi_mod crypto_simd libphy cryptd c=
rct10dif_generic intel_lpss_pci i2c_i801 crct10dif_pclmul crc64 crct10dif_c=
ommon intel_lpss i2c_smbus idma64 usb_common scsi_common fan video wmi pinc=
trl_alderlake
> [1400821.811868] CPU: 0 PID: 614303 Comm: blkdiscard Tainted: P          =
 OE      6.1.0-18-amd64 #1  Debian 6.1.76-1
> [1400821.811875] Hardware name: Gigabyte Technology Co., Ltd. Z790 GAMING=
 X/Z790 GAMING X, BIOS F9b 11/10/2023
> [1400821.811878] RIP: 0010:__blkdev_issue_discard+0x14b/0x180
> [1400821.811887] Code: 48 39 d8 75 8b f7 da 89 d3 c1 eb 09 eb 85 48 8b 04=
 24 4c 89 20 48 83 c4 08 31 c0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc=
 <0f> 0b 48 c7 c6 80 fd 0a a9 48 c7 c7 40 2c b9 a9 e8 60 45 4f 00 85
> [1400821.811891] RSP: 0018:ffffb3d7a50d7d50 EFLAGS: 00010246
> [1400821.811896] RAX: ffff9fb0cb248750 RBX: ffff9fbb794612c0 RCX: ffff9fb=
60167be80
> [1400821.811899] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9fb=
b794612c0
> [1400821.811902] RBP: 0000000000000cc0 R08: ffffb3d7a50d7d90 R09: fffff5f=
4d6f7efc0
> [1400821.811904] R10: 000000000ee778ff R11: 0000000000000000 R12: 0000000=
000000000
> [1400821.811907] R13: 00000000773bc800 R14: 000000ee77900000 R15: ffff9fb=
b794612c0
> [1400821.811910] FS:  00007f2af0e95740(0000) GS:ffff9fbb7f200000(0000) kn=
lGS:0000000000000000
> [1400821.811914] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [1400821.811917] CR2: 00007ffc65eec170 CR3: 00000002dcf78000 CR4: 0000000=
000750ef0
> [1400821.811920] PKRU: 55555554
> [1400821.811923] Call Trace:
> [1400821.811926]  <TASK>
> [1400821.811931]  ? __warn+0x7d/0xc0
> [1400821.811938]  ? __blkdev_issue_discard+0x14b/0x180
> [1400821.811945]  ? report_bug+0xe2/0x150
> [1400821.811955]  ? handle_bug+0x41/0x70
> [1400821.811959]  ? exc_invalid_op+0x13/0x60
> [1400821.811963]  ? asm_exc_invalid_op+0x16/0x20
> [1400821.811974]  ? __blkdev_issue_discard+0x14b/0x180
> [1400821.811982]  blkdev_issue_discard+0x7e/0xe0
> [1400821.811990]  blkdev_common_ioctl+0x61f/0xa30
> [1400821.811999]  blkdev_ioctl+0x104/0x270
> [1400821.812006]  __x64_sys_ioctl+0x8d/0xd0
> [1400821.812013]  do_syscall_64+0x58/0xc0
> [1400821.812017]  ? do_user_addr_fault+0x1b0/0x580
> [1400821.812023]  ? exit_to_user_mode_prepare+0x40/0x1e0
> [1400821.812030]  entry_SYSCALL_64_after_hwframe+0x64/0xce
> [1400821.812038] RIP: 0033:0x7f2af0f95c5b
> [1400821.812042] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10=
 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05=
 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> [1400821.812046] RSP: 002b:00007ffc65ecec40 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000010
> [1400821.812051] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2=
af0f95c5b
> [1400821.812054] RDX: 00007ffc65eced00 RSI: 0000000000001277 RDI: 0000000=
000000003
> [1400821.812056] RBP: 0000000000000000 R08: 0000000000000007 R09: 0000563=
c2300a2f0
> [1400821.812058] R10: 00007ffc65eec170 R11: 0000000000000246 R12: 000000e=
e77900000
> [1400821.812061] R13: 0000000000000003 R14: 0000563c2300a2f0 R15: 0000000=
000000000
> [1400821.812065]  </TASK>
> [1400821.812067] ---[ end trace 0000000000000000 ]---
>=20
> I tried a discard on a Samsung PM981 1TB SSD (m.2) using a JMicron USB ad=
aptor.
>=20
> udev rule:
>=20
> ACTION=3D=3D"add|change", ATTRS{idVendor}=3D=3D"152d", ATTRS{idProduct}=
=3D=3D"0583", SUBSYSTEM=3D=3D"scsi_disk", ATTR{provisioning_mode}=3D"unmap"
>=20
> Probably I was too optimistic.

Notice that the USB layer does not show up at all in the stack dump=20
above, but the block layer figures prominently.  This strongly suggests=20
that the bug lies in the block layer.

CC'ing the appropriate mailing list and maintainer.

Alan Stern
