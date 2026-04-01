Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DB03644CF
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 10:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039555; cv=none; b=JUIzHv48i6GVaC1Z5wgrZyBZ00+RfqgOgrVVQzlsb61+cRGf7IOutHgtdqBWSmP8fjzYG1R65xcXqfX4okw09rrVaWsdStmYrj1sdNSR0yE3PKRgniy7jtsBC9+PdvoFGg0fDpQpG8q9rgSrybXg8QpNqqv1q415T2YkkxLIG+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039555; c=relaxed/simple;
	bh=+7U0jJgrvqBta9VRrosYI+rBRrmVA1cPP4pjE9n0m30=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GeJq7FLpqTmlJNHHrBhg0dwPAwqXCff4WAZQ8THAA3eziQZbZreMDv8gbGRcPthfL8zp6ePCAf9rSV1buPaw1S+8xazoVB0f3XKbabSM7rYLrNNZaxm3khYEHJQpu8jtWIh/IHKDFAL46eVL+nI1wnlAyQshkMirMArv3HW1Q6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 20ED943BF9;
	Wed, 01 Apr 2026 12:32:29 +0200 (CEST)
Message-ID: <ac2256a0-25ce-4453-8c47-04cb7716d46a@proxmox.com>
Date: Wed, 1 Apr 2026 12:32:24 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mira Limbeck <m.limbeck@proxmox.com>
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
To: Damien Le Moal <dlemoal@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
 martin.petersen@oracle.com, Friedrich Weber <f.weber@proxmox.com>
References: <20250618060045.37593-1-dlemoal@kernel.org>
 <291f78bf-4b4a-40dd-867d-053b36c564b3@proxmox.com>
 <ff5e2877-840b-4eb6-b449-bb64fb2e4097@kernel.org>
Content-Language: en-US
In-Reply-To: <ff5e2877-840b-4eb6-b449-bb64fb2e4097@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1775039488017

On 3/31/26 9:48 PM, Damien Le Moal wrote:
> On 3/31/26 21:02, Mira Limbeck wrote:
>> Hi,
>>
>>
>> Some of our Proxmox VE users started seeing `unable to handle page
>> fault` after switching to our downstream kernel 6.17, and after
>> bisecting with the mainline kernel we've identified this patch as the
>> first commit (9b8b84879d4adc506b0d3944e20b28d9f3f6994b) where we see
>> those errors.
>=20
> Please test with the current mainline kernel. We do not deal with non-s=
tandard
> kernels.
>=20

Sorry if I wasn't clear enough, we did test the following mainline
kernels without any downstream patches (git tags):
v6.16 (unaffected)
v6.17 (affected)
v7.0-rc5 (affected)

Afterwards we started to bisect between mainline 6.16
(038d61fd642278bab63ee8ef722c50d10ab01e8f) and mainline 6.17
(e5f0a698b34ed76002dc5cff3804a61c80233a7a) without any downstream
patches, which led us to this commit as the first bad one:
9b8b84879d4adc506b0d3944e20b28d9f3f6994b

Building our downstream kernel 6.17 with this commit reverted, fixed it.

To make sure that's also the case for the current mainline kernel, we've
tried 7.0-rc6 today (v7.0-rc6, 7aaa8047eafd0bd628065b15757d9b48c5f9c07d,
affected), and again with this commit reverted (unaffected).

Here the logs from 7.0-rc6:

Apr 01 11:41:19 pve-test-hba kernel: sd 9:2:2:0: [sdc] tag#3962 page boun=
dary curr_buff: 0x00000000f4d7cfce
Apr 01 11:41:19 pve-test-hba kernel: BUG: unable to handle page fault for=
 address: ff3a241243d70000
Apr 01 11:41:19 pve-test-hba kernel: #PF: supervisor write access in kern=
el mode
Apr 01 11:41:19 pve-test-hba kernel: #PF: error_code(0x0002) - not-presen=
t page
Apr 01 11:41:19 pve-test-hba kernel: PGD 100010067 P4D 10066d067 PUD 1006=
6e067 PMD 11f0fa067 PTE 0
Apr 01 11:41:19 pve-test-hba kernel: Oops: Oops: 0002 [#3] SMP NOPTI
Apr 01 11:41:19 pve-test-hba kernel: CPU: 15 UID: 0 PID: 6695 Comm: vgs T=
ainted: G      D W   E       7.0.0-rc6 #19 PREEMPT(full)
Apr 01 11:41:19 pve-test-hba kernel: Tainted: [D]=3DDIE, [W]=3DWARN, [E]=3D=
UNSIGNED_MODULE
Apr 01 11:41:19 pve-test-hba kernel: Hardware name: <snip>
Apr 01 11:41:19 pve-test-hba kernel: RIP: 0010:_base_build_sg_scmd_ieee+0=
x478/0x590 [mpt3sas]
Apr 01 11:41:19 pve-test-hba kernel: Code: 20 48 83 c3 20 48 89 d1 48 83 =
e1 fc 83 e2 01 48 0f 45 d9 4c 8b 73 10 44 8b 63 18 4c 89 e9 4c 8d 69 08 4=
4 85 e8 74 31 45 29 d7 <4c> 89 31 49 83 c1 08 41 83 c0 01 45 29 d4 45 85 =
ff 7f af 4c 8b 75
Apr 01 11:41:19 pve-test-hba kernel: RSP: 0018:ff3a2412497ff370 EFLAGS: 0=
0010206
Apr 01 11:41:19 pve-test-hba kernel: RAX: 0000000000000fff RBX: ff1cd46a5=
ff2c578 RCX: ff3a241243d70000
Apr 01 11:41:19 pve-test-hba kernel: RDX: ff3a241243d70008 RSI: 000000000=
0000000 RDI: 0000000000000000
Apr 01 11:41:19 pve-test-hba kernel: RBP: ff3a2412497ff3d0 R08: 000000000=
0000200 R09: 00000000fea86000
Apr 01 11:41:19 pve-test-hba kernel: R10: 0000000000001000 R11: 000000000=
0001000 R12: 00000000000b0000
Apr 01 11:41:19 pve-test-hba kernel: R13: ff3a241243d70008 R14: 00000000f=
a200000 R15: 00000000000af000
Apr 01 11:41:19 pve-test-hba kernel: FS:  00007f3fbd181940(0000) GS:ff1cd=
46e06c7e000(0000) knlGS:0000000000000000
Apr 01 11:41:19 pve-test-hba kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000=
0000080050033
Apr 01 11:41:19 pve-test-hba kernel: CR2: ff3a241243d70000 CR3: 000000010=
c6d2006 CR4: 0000000000f71ef0
Apr 01 11:41:19 pve-test-hba kernel: PKRU: 55555554
Apr 01 11:41:19 pve-test-hba kernel: Call Trace:
Apr 01 11:41:19 pve-test-hba kernel:  <TASK>
Apr 01 11:41:19 pve-test-hba kernel:  scsih_qcmd+0x4a1/0x5f0 [mpt3sas]
Apr 01 11:41:19 pve-test-hba kernel:  scsi_queue_rq+0x71c/0xd10
Apr 01 11:41:19 pve-test-hba kernel:  blk_mq_dispatch_rq_list+0x11b/0x740=

Apr 01 11:41:19 pve-test-hba kernel:  __blk_mq_sched_dispatch_requests+0x=
b4/0x5c0
Apr 01 11:41:19 pve-test-hba kernel:  ? elv_attempt_insert_merge+0xa6/0x1=
00
Apr 01 11:41:19 pve-test-hba kernel:  blk_mq_sched_dispatch_requests+0x2d=
/0x70
Apr 01 11:41:19 pve-test-hba kernel:  blk_mq_run_hw_queue+0x250/0x340
Apr 01 11:41:19 pve-test-hba kernel:  blk_mq_dispatch_list+0x16f/0x470
Apr 01 11:41:19 pve-test-hba kernel:  blk_mq_flush_plug_list+0x62/0x1e0
Apr 01 11:41:19 pve-test-hba kernel:  __blk_flush_plug+0xde/0x140
Apr 01 11:41:19 pve-test-hba kernel:  __submit_bio+0x19b/0x260
Apr 01 11:41:19 pve-test-hba kernel:  submit_bio_noacct_nocheck+0x275/0x3=
40
Apr 01 11:41:19 pve-test-hba kernel:  submit_bio_noacct+0x1eb/0x630
Apr 01 11:41:19 pve-test-hba kernel:  submit_bio+0xb1/0x110
Apr 01 11:41:19 pve-test-hba kernel:  blkdev_direct_IO+0x2fd/0x760
Apr 01 11:41:19 pve-test-hba kernel:  blkdev_read_iter+0xe5/0x180
Apr 01 11:41:19 pve-test-hba kernel:  aio_read+0x136/0x210
Apr 01 11:41:19 pve-test-hba kernel:  ? dput.part.0+0x39/0x120
Apr 01 11:41:19 pve-test-hba kernel:  io_submit_one+0x635/0x9c0
Apr 01 11:41:19 pve-test-hba kernel:  ? io_submit_one+0x635/0x9c0
Apr 01 11:41:19 pve-test-hba kernel:  ? path_openat+0x530/0x1290
Apr 01 11:41:19 pve-test-hba kernel:  __x64_sys_io_submit+0x90/0x1c0
Apr 01 11:41:19 pve-test-hba kernel:  x64_sys_call+0x175b/0x25e0
Apr 01 11:41:19 pve-test-hba kernel:  do_syscall_64+0xcb/0x14b0
Apr 01 11:41:19 pve-test-hba kernel:  ? __do_sys_newfstat+0x4c/0x80
Apr 01 11:41:19 pve-test-hba kernel:  ? __x64_sys_newfstat+0x15/0x20
Apr 01 11:41:19 pve-test-hba kernel:  ? x64_sys_call+0x1b1b/0x25e0
Apr 01 11:41:19 pve-test-hba kernel:  ? do_syscall_64+0x109/0x14b0
Apr 01 11:41:19 pve-test-hba kernel:  ? do_syscall_64+0x109/0x14b0
Apr 01 11:41:19 pve-test-hba kernel:  ? __x64_sys_newfstat+0x15/0x20
Apr 01 11:41:19 pve-test-hba kernel:  ? x64_sys_call+0x1b1b/0x25e0
Apr 01 11:41:19 pve-test-hba kernel:  ? do_syscall_64+0x109/0x14b0
Apr 01 11:41:19 pve-test-hba kernel:  ? handle_mm_fault+0xbb/0x380
Apr 01 11:41:19 pve-test-hba kernel:  ? do_user_addr_fault+0x2ec/0x880
Apr 01 11:41:19 pve-test-hba kernel:  ? irqentry_exit+0xb2/0x780
Apr 01 11:41:19 pve-test-hba kernel:  ? exc_page_fault+0x92/0x1c0
Apr 01 11:41:19 pve-test-hba kernel:  entry_SYSCALL_64_after_hwframe+0x76=
/0x7e
Apr 01 11:41:19 pve-test-hba kernel: RIP: 0033:0x7f3fbd41e7b9
Apr 01 11:41:19 pve-test-hba kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 =
00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c=
8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 27 66 0d 00 =
f7 d8 64 89 01 48
Apr 01 11:41:19 pve-test-hba kernel: RSP: 002b:00007ffde2893c18 EFLAGS: 0=
0000246 ORIG_RAX: 00000000000000d1
Apr 01 11:41:19 pve-test-hba kernel: RAX: ffffffffffffffda RBX: 00007f3fb=
d1816f0 RCX: 00007f3fbd41e7b9
Apr 01 11:41:19 pve-test-hba kernel: RDX: 00007ffde2893cc0 RSI: 000000000=
0000001 RDI: 00007f3fbd82f000
Apr 01 11:41:19 pve-test-hba kernel: RBP: 00007f3fbd82f000 R08: 0000596c2=
e67f000 R09: 0000000000000000
Apr 01 11:41:19 pve-test-hba kernel: R10: 0000000000000100 R11: 000000000=
0000246 R12: 0000000000000001
Apr 01 11:41:19 pve-test-hba kernel: R13: 0000000000000002 R14: 00007ffde=
2893cc0 R15: 0000596c12ab5e50
Apr 01 11:41:19 pve-test-hba kernel:  </TASK>
Apr 01 11:41:19 pve-test-hba kernel: Modules linked in: dm_crypt(E) nf_ta=
bles(E) sunrpc(E) bonding(E) tls(E) softdog(E) nfnetlink_log(E) binfmt_mi=
sc(E) ipmi_ssif(E) amd_atl(E) intel_rapl_msr(E) intel_rapl_common(E) amd6=
4_edac(E) edac_mce_amd(E) kvm_amd(E) dax_hmem(E) cxl_acpi(E) kvm(E) cxl_p=
ort(E) irqbypass(E) cxl_pmem(E) cxl_core(E) ghash_clmulni_intel(E) joydev=
(E) acpi_ipmi(E) aesni_intel(E) ast(E) input_leds(E) fwctl(E) ses(E) i2c_=
algo_bit(E) enclosure(E) rapl(E) einj(E) ccp(E) pcspkr(E) ipmi_si(E) wmi_=
bmof(E) spd5118(E) ipmi_devintf(E) hsmp_acpi(E) k10temp(E) hsmp_common(E)=
 ipmi_msghandler(E) mac_hid(E) sch_fq_codel(E) msr(E) vhost_net(E) vhost(=
E) nvme_fabrics(E) vhost_iotlb(E) tap(E) nvme_core(E) nvme_keyring(E) nvm=
e_auth(E) hkdf(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) autofs4(E) btrf=
s(E) libblake2b(E) xor(E) raid6_pq(E) dm_thin_pool(E) dm_persistent_data(=
E) dm_bio_prison(E) dm_bufio(E) hid_generic(E) usbmouse(E) usbhid(E) rndi=
s_host(E) cdc_ether(E) hid(E) usbnet(E) mii(E) xhci_pci_renesas(E) mpt3sa=
s(E) xhci_pci(E) raid_class(E)
Apr 01 11:41:19 pve-test-hba kernel:  ahci(E) tg3(E) scsi_transport_sas(E=
) libahci(E) xhci_hcd(E) i2c_piix4(E) i2c_smbus(E) wmi(E) 8250_dw(E)
Apr 01 11:41:19 pve-test-hba kernel: CR2: ff3a241243d70000
Apr 01 11:41:19 pve-test-hba kernel: ---[ end trace 0000000000000000 ]---=

Apr 01 11:41:19 pve-test-hba kernel: RIP: 0010:_base_build_sg_scmd_ieee+0=
x478/0x590 [mpt3sas]
Apr 01 11:41:19 pve-test-hba kernel: Code: 20 48 83 c3 20 48 89 d1 48 83 =
e1 fc 83 e2 01 48 0f 45 d9 4c 8b 73 10 44 8b 63 18 4c 89 e9 4c 8d 69 08 4=
4 85 e8 74 31 45 29 d7 <4c> 89 31 49 83 c1 08 41 83 c0 01 45 29 d4 45 85 =
ff 7f af 4c 8b 75
Apr 01 11:41:19 pve-test-hba kernel: RSP: 0018:ff3a241249717a68 EFLAGS: 0=
0010206
Apr 01 11:41:19 pve-test-hba kernel: RAX: 0000000000000fff RBX: ff1cd46a5=
ff2c578 RCX: ff3a241243d68000
Apr 01 11:41:19 pve-test-hba kernel: RDX: ff3a241243d68008 RSI: 000000000=
0000000 RDI: 0000000000000000
Apr 01 11:41:19 pve-test-hba kernel: RBP: ff3a241249717ac8 R08: 000000000=
0000200 R09: 00000000fea8a000
Apr 01 11:41:19 pve-test-hba kernel: R10: 0000000000001000 R11: 000000000=
0001000 R12: 00000000000b0000
Apr 01 11:41:19 pve-test-hba kernel: R13: ff3a241243d68008 R14: 00000000f=
a200000 R15: 00000000000af000
Apr 01 11:41:19 pve-test-hba kernel: FS:  00007f3fbd181940(0000) GS:ff1cd=
46e06c7e000(0000) knlGS:0000000000000000
Apr 01 11:41:19 pve-test-hba kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000=
0000080050033
Apr 01 11:41:19 pve-test-hba kernel: CR2: ff3a241243d70000 CR3: 000000010=
c6d2006 CR4: 0000000000f71ef0
Apr 01 11:41:19 pve-test-hba kernel: PKRU: 55555554
Apr 01 11:41:19 pve-test-hba kernel: note: vgs[6695] exited with irqs dis=
abled
Apr 01 11:41:19 pve-test-hba kernel: ------------[ cut here ]------------=

Apr 01 11:41:19 pve-test-hba kernel: WARNING: kernel/exit.c:903 at do_exi=
t+0x81a/0xa80, CPU#15: vgs/6695
Apr 01 11:41:19 pve-test-hba kernel: Modules linked in: dm_crypt(E) nf_ta=
bles(E) sunrpc(E) bonding(E) tls(E) softdog(E) nfnetlink_log(E) binfmt_mi=
sc(E) ipmi_ssif(E) amd_atl(E) intel_rapl_msr(E) intel_rapl_common(E) amd6=
4_edac(E) edac_mce_amd(E) kvm_amd(E) dax_hmem(E) cxl_acpi(E) kvm(E) cxl_p=
ort(E) irqbypass(E) cxl_pmem(E) cxl_core(E) ghash_clmulni_intel(E) joydev=
(E) acpi_ipmi(E) aesni_intel(E) ast(E) input_leds(E) fwctl(E) ses(E) i2c_=
algo_bit(E) enclosure(E) rapl(E) einj(E) ccp(E) pcspkr(E) ipmi_si(E) wmi_=
bmof(E) spd5118(E) ipmi_devintf(E) hsmp_acpi(E) k10temp(E) hsmp_common(E)=
 ipmi_msghandler(E) mac_hid(E) sch_fq_codel(E) msr(E) vhost_net(E) vhost(=
E) nvme_fabrics(E) vhost_iotlb(E) tap(E) nvme_core(E) nvme_keyring(E) nvm=
e_auth(E) hkdf(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) autofs4(E) btrf=
s(E) libblake2b(E) xor(E) raid6_pq(E) dm_thin_pool(E) dm_persistent_data(=
E) dm_bio_prison(E) dm_bufio(E) hid_generic(E) usbmouse(E) usbhid(E) rndi=
s_host(E) cdc_ether(E) hid(E) usbnet(E) mii(E) xhci_pci_renesas(E) mpt3sa=
s(E) xhci_pci(E) raid_class(E)
Apr 01 11:41:19 pve-test-hba kernel:  ahci(E) tg3(E) scsi_transport_sas(E=
) libahci(E) xhci_hcd(E) i2c_piix4(E) i2c_smbus(E) wmi(E) 8250_dw(E)
Apr 01 11:41:19 pve-test-hba kernel: CPU: 15 UID: 0 PID: 6695 Comm: vgs T=
ainted: G      D W   E       7.0.0-rc6 #19 PREEMPT(full)
Apr 01 11:41:19 pve-test-hba kernel: Tainted: [D]=3DDIE, [W]=3DWARN, [E]=3D=
UNSIGNED_MODULE
Apr 01 11:41:19 pve-test-hba kernel: Hardware name: <snip>
Apr 01 11:41:19 pve-test-hba kernel: RIP: 0010:do_exit+0x81a/0xa80
Apr 01 11:41:19 pve-test-hba kernel: Code: 4c 89 ab 50 0b 00 00 48 89 45 =
c0 48 8b 83 78 0d 00 00 e9 2b fe ff ff 48 8b bb 30 0b 00 00 31 f6 e8 3b e=
2 ff ff e9 de fd ff ff <0f> 0b e9 2b f8 ff ff 4c 89 e6 bf 05 06 00 00 e8 =
d2 44 01 00 e9 7a
Apr 01 11:41:19 pve-test-hba kernel: RSP: 0018:ff3a2412497ffec0 EFLAGS: 0=
0010286
Apr 01 11:41:19 pve-test-hba kernel: RAX: 0000000000000246 RBX: ff1cd46a5=
81f3100 RCX: 0000000000000000
Apr 01 11:41:19 pve-test-hba kernel: RDX: 000000000000270f RSI: 000000000=
0002710 RDI: 0000000000000009
Apr 01 11:41:19 pve-test-hba kernel: RBP: ff3a2412497fff10 R08: 000000000=
0000000 R09: 0000000000000000
Apr 01 11:41:19 pve-test-hba kernel: R10: 0000000000000000 R11: 000000000=
0000000 R12: 0000000000000009
Apr 01 11:41:19 pve-test-hba kernel: R13: ff1cd46a581f3100 R14: ff1cd46a5=
81f3100 R15: 0000000000000000
Apr 01 11:41:19 pve-test-hba kernel: FS:  00007f3fbd181940(0000) GS:ff1cd=
46e06c7e000(0000) knlGS:0000000000000000
Apr 01 11:41:19 pve-test-hba kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000=
0000080050033
Apr 01 11:41:19 pve-test-hba kernel: CR2: ff3a241243d70000 CR3: 000000010=
c6d2006 CR4: 0000000000f71ef0
Apr 01 11:41:19 pve-test-hba kernel: PKRU: 55555554
Apr 01 11:41:19 pve-test-hba kernel: Call Trace:
Apr 01 11:41:19 pve-test-hba kernel:  <TASK>
Apr 01 11:41:19 pve-test-hba kernel:  make_task_dead+0x81/0x160
Apr 01 11:41:19 pve-test-hba kernel:  rewind_stack_and_make_dead+0x16/0x2=
0
Apr 01 11:41:19 pve-test-hba kernel: RIP: 0033:0x7f3fbd41e7b9
Apr 01 11:41:19 pve-test-hba kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 =
00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c=
8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 27 66 0d 00 =
f7 d8 64 89 01 48
Apr 01 11:41:19 pve-test-hba kernel: RSP: 002b:00007ffde2893c18 EFLAGS: 0=
0000246 ORIG_RAX: 00000000000000d1
Apr 01 11:41:19 pve-test-hba kernel: RAX: ffffffffffffffda RBX: 00007f3fb=
d1816f0 RCX: 00007f3fbd41e7b9
Apr 01 11:41:19 pve-test-hba kernel: RDX: 00007ffde2893cc0 RSI: 000000000=
0000001 RDI: 00007f3fbd82f000
Apr 01 11:41:19 pve-test-hba kernel: RBP: 00007f3fbd82f000 R08: 0000596c2=
e67f000 R09: 0000000000000000
Apr 01 11:41:19 pve-test-hba kernel: R10: 0000000000000100 R11: 000000000=
0000246 R12: 0000000000000001
Apr 01 11:41:19 pve-test-hba kernel: R13: 0000000000000002 R14: 00007ffde=
2893cc0 R15: 0000596c12ab5e50
Apr 01 11:41:19 pve-test-hba kernel:  </TASK>
Apr 01 11:41:19 pve-test-hba kernel: ---[ end trace 0000000000000000 ]---=

Apr 01 11:41:19 pve-test-hba kernel: BUG: kernel NULL pointer dereference=
, address: 0000000000000300
Apr 01 11:41:19 pve-test-hba kernel: #PF: supervisor write access in kern=
el mode
Apr 01 11:41:19 pve-test-hba kernel: #PF: error_code(0x0002) - not-presen=
t page
Apr 01 11:41:19 pve-test-hba kernel: PGD 11f55f067 P4D 0
Apr 01 11:41:19 pve-test-hba kernel: Oops: Oops: 0002 [#4] SMP NOPTI
Apr 01 11:41:19 pve-test-hba kernel: CPU: 15 UID: 0 PID: 6695 Comm: vgs T=
ainted: G      D W   E       7.0.0-rc6 #19 PREEMPT(full)
Apr 01 11:41:19 pve-test-hba kernel: Tainted: [D]=3DDIE, [W]=3DWARN, [E]=3D=
UNSIGNED_MODULE
Apr 01 11:41:19 pve-test-hba kernel: Hardware name: <snip>
Apr 01 11:41:19 pve-test-hba kernel: RIP: 0010:__blk_flush_plug+0x8a/0x14=
0
Apr 01 11:41:19 pve-test-hba kernel: Code: 48 89 5d c8 48 39 c1 74 6a 49 =
8b 47 30 48 8b 75 b8 48 39 c6 74 4a 49 8b 4f 30 49 8b 57 38 48 8b 45 c0 4=
8 89 59 08 48 89 4d c0 <48> 89 02 48 89 50 08 49 89 77 30 49 89 77 38 eb =
25 48 8b 7d c0 44
Apr 01 11:41:19 pve-test-hba kernel: RSP: 0018:ff3a2412497ffce8 EFLAGS: 0=
0010206
Apr 01 11:41:19 pve-test-hba kernel: RAX: ff3a2412497ffcf0 RBX: ff3a24124=
97ffcf0 RCX: ff1cd46a42ef3a00
Apr 01 11:41:19 pve-test-hba kernel: RDX: 0000000000000300 RSI: ff3a24124=
97ff760 RDI: ff3a2412497ff730
Apr 01 11:41:19 pve-test-hba kernel: RBP: ff3a2412497ffd30 R08: 000000000=
0000000 R09: 0000000000000000
Apr 01 11:41:19 pve-test-hba kernel: R10: 0000000000000000 R11: 000000000=
0000000 R12: 0000000000000001
Apr 01 11:41:19 pve-test-hba kernel: R13: dead000000000122 R14: dead00000=
0000100 R15: ff3a2412497ff730
Apr 01 11:41:19 pve-test-hba kernel: FS:  0000000000000000(0000) GS:ff1cd=
46e06c7e000(0000) knlGS:0000000000000000
Apr 01 11:41:19 pve-test-hba kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000=
0000080050033
Apr 01 11:41:19 pve-test-hba kernel: CR2: 0000000000000300 CR3: 000000010=
c6d2006 CR4: 0000000000f71ef0
Apr 01 11:41:19 pve-test-hba kernel: PKRU: 55555554
Apr 01 11:41:19 pve-test-hba kernel: Call Trace:
Apr 01 11:41:19 pve-test-hba kernel:  <TASK>
Apr 01 11:41:19 pve-test-hba kernel:  schedule+0xa3/0xf0
Apr 01 11:41:19 pve-test-hba kernel:  schedule_timeout+0x104/0x110
Apr 01 11:41:19 pve-test-hba kernel:  __wait_for_common+0x98/0x180
Apr 01 11:41:19 pve-test-hba kernel:  ? __pfx_schedule_timeout+0x10/0x10
Apr 01 11:41:19 pve-test-hba kernel:  wait_for_completion+0x24/0x40
Apr 01 11:41:19 pve-test-hba kernel:  exit_aio+0x116/0x120
Apr 01 11:41:19 pve-test-hba kernel:  __mmput+0x15/0x120
Apr 01 11:41:19 pve-test-hba kernel:  mmput+0x31/0x40
Apr 01 11:41:19 pve-test-hba kernel:  do_exit+0x28c/0xa80
Apr 01 11:41:19 pve-test-hba kernel:  make_task_dead+0x81/0x160
Apr 01 11:41:19 pve-test-hba kernel:  rewind_stack_and_make_dead+0x16/0x2=
0
Apr 01 11:41:19 pve-test-hba kernel: RIP: 0033:0x7f3fbd41e7b9
Apr 01 11:41:19 pve-test-hba kernel: Code: Unable to access opcode bytes =
at 0x7f3fbd41e78f.
Apr 01 11:41:19 pve-test-hba kernel: RSP: 002b:00007ffde2893c18 EFLAGS: 0=
0000246 ORIG_RAX: 00000000000000d1
Apr 01 11:41:19 pve-test-hba kernel: RAX: ffffffffffffffda RBX: 00007f3fb=
d1816f0 RCX: 00007f3fbd41e7b9
Apr 01 11:41:19 pve-test-hba kernel: RDX: 00007ffde2893cc0 RSI: 000000000=
0000001 RDI: 00007f3fbd82f000
Apr 01 11:41:19 pve-test-hba kernel: RBP: 00007f3fbd82f000 R08: 0000596c2=
e67f000 R09: 0000000000000000
Apr 01 11:41:19 pve-test-hba kernel: R10: 0000000000000100 R11: 000000000=
0000246 R12: 0000000000000001
Apr 01 11:41:19 pve-test-hba kernel: R13: 0000000000000002 R14: 00007ffde=
2893cc0 R15: 0000596c12ab5e50
Apr 01 11:41:19 pve-test-hba kernel:  </TASK>
Apr 01 11:41:19 pve-test-hba kernel: Modules linked in: dm_crypt(E) nf_ta=
bles(E) sunrpc(E) bonding(E) tls(E) softdog(E) nfnetlink_log(E) binfmt_mi=
sc(E) ipmi_ssif(E) amd_atl(E) intel_rapl_msr(E) intel_rapl_common(E) amd6=
4_edac(E) edac_mce_amd(E) kvm_amd(E) dax_hmem(E) cxl_acpi(E) kvm(E) cxl_p=
ort(E) irqbypass(E) cxl_pmem(E) cxl_core(E) ghash_clmulni_intel(E) joydev=
(E) acpi_ipmi(E) aesni_intel(E) ast(E) input_leds(E) fwctl(E) ses(E) i2c_=
algo_bit(E) enclosure(E) rapl(E) einj(E) ccp(E) pcspkr(E) ipmi_si(E) wmi_=
bmof(E) spd5118(E) ipmi_devintf(E) hsmp_acpi(E) k10temp(E) hsmp_common(E)=
 ipmi_msghandler(E) mac_hid(E) sch_fq_codel(E) msr(E) vhost_net(E) vhost(=
E) nvme_fabrics(E) vhost_iotlb(E) tap(E) nvme_core(E) nvme_keyring(E) nvm=
e_auth(E) hkdf(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) autofs4(E) btrf=
s(E) libblake2b(E) xor(E) raid6_pq(E) dm_thin_pool(E) dm_persistent_data(=
E) dm_bio_prison(E) dm_bufio(E) hid_generic(E) usbmouse(E) usbhid(E) rndi=
s_host(E) cdc_ether(E) hid(E) usbnet(E) mii(E) xhci_pci_renesas(E) mpt3sa=
s(E) xhci_pci(E) raid_class(E)
Apr 01 11:41:19 pve-test-hba kernel:  ahci(E) tg3(E) scsi_transport_sas(E=
) libahci(E) xhci_hcd(E) i2c_piix4(E) i2c_smbus(E) wmi(E) 8250_dw(E)
Apr 01 11:41:19 pve-test-hba kernel: CR2: 0000000000000300
Apr 01 11:41:19 pve-test-hba kernel: ---[ end trace 0000000000000000 ]---=

Apr 01 11:41:19 pve-test-hba kernel: RIP: 0010:_base_build_sg_scmd_ieee+0=
x478/0x590 [mpt3sas]
Apr 01 11:41:19 pve-test-hba kernel: Code: 20 48 83 c3 20 48 89 d1 48 83 =
e1 fc 83 e2 01 48 0f 45 d9 4c 8b 73 10 44 8b 63 18 4c 89 e9 4c 8d 69 08 4=
4 85 e8 74 31 45 29 d7 <4c> 89 31 49 83 c1 08 41 83 c0 01 45 29 d4 45 85 =
ff 7f af 4c 8b 75
Apr 01 11:41:19 pve-test-hba kernel: RSP: 0018:ff3a241249717a68 EFLAGS: 0=
0010206
Apr 01 11:41:19 pve-test-hba kernel: RAX: 0000000000000fff RBX: ff1cd46a5=
ff2c578 RCX: ff3a241243d68000
Apr 01 11:41:19 pve-test-hba kernel: RDX: ff3a241243d68008 RSI: 000000000=
0000000 RDI: 0000000000000000
Apr 01 11:41:19 pve-test-hba kernel: RBP: ff3a241249717ac8 R08: 000000000=
0000200 R09: 00000000fea8a000
Apr 01 11:41:19 pve-test-hba kernel: R10: 0000000000001000 R11: 000000000=
0001000 R12: 00000000000b0000
Apr 01 11:41:19 pve-test-hba kernel: R13: ff3a241243d68008 R14: 00000000f=
a200000 R15: 00000000000af000
Apr 01 11:41:19 pve-test-hba kernel: FS:  0000000000000000(0000) GS:ff1cd=
46e06c7e000(0000) knlGS:0000000000000000
Apr 01 11:41:19 pve-test-hba kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000=
0000080050033
Apr 01 11:41:19 pve-test-hba kernel: CR2: 0000000000000300 CR3: 000000010=
c6d2006 CR4: 0000000000f71ef0
Apr 01 11:41:19 pve-test-hba kernel: PKRU: 55555554
Apr 01 11:41:19 pve-test-hba kernel: note: vgs[6695] exited with irqs dis=
abled
Apr 01 11:41:19 pve-test-hba kernel: Fixing recursive fault but reboot is=
 needed!
Apr 01 11:41:19 pve-test-hba kernel: BUG: scheduling while atomic: vgs/66=
95/0x00000000
Apr 01 11:41:19 pve-test-hba kernel: Modules linked in: dm_crypt(E) nf_ta=
bles(E) sunrpc(E) bonding(E) tls(E) softdog(E) nfnetlink_log(E) binfmt_mi=
sc(E) ipmi_ssif(E) amd_atl(E) intel_rapl_msr(E) intel_rapl_common(E) amd6=
4_edac(E) edac_mce_amd(E) kvm_amd(E) dax_hmem(E) cxl_acpi(E) kvm(E) cxl_p=
ort(E) irqbypass(E) cxl_pmem(E) cxl_core(E) ghash_clmulni_intel(E) joydev=
(E) acpi_ipmi(E) aesni_intel(E) ast(E) input_leds(E) fwctl(E) ses(E) i2c_=
algo_bit(E) enclosure(E) rapl(E) einj(E) ccp(E) pcspkr(E) ipmi_si(E) wmi_=
bmof(E) spd5118(E) ipmi_devintf(E) hsmp_acpi(E) k10temp(E) hsmp_common(E)=
 ipmi_msghandler(E) mac_hid(E) sch_fq_codel(E) msr(E) vhost_net(E) vhost(=
E) nvme_fabrics(E) vhost_iotlb(E) tap(E) nvme_core(E) nvme_keyring(E) nvm=
e_auth(E) hkdf(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) autofs4(E) btrf=
s(E) libblake2b(E) xor(E) raid6_pq(E) dm_thin_pool(E) dm_persistent_data(=
E) dm_bio_prison(E) dm_bufio(E) hid_generic(E) usbmouse(E) usbhid(E) rndi=
s_host(E) cdc_ether(E) hid(E) usbnet(E) mii(E) xhci_pci_renesas(E) mpt3sa=
s(E) xhci_pci(E) raid_class(E)
Apr 01 11:41:19 pve-test-hba kernel:  ahci(E) tg3(E) scsi_transport_sas(E=
) libahci(E) xhci_hcd(E) i2c_piix4(E) i2c_smbus(E) wmi(E) 8250_dw(E)
Apr 01 11:41:19 pve-test-hba kernel: CPU: 15 UID: 0 PID: 6695 Comm: vgs T=
ainted: G      D W   E       7.0.0-rc6 #19 PREEMPT(full)
Apr 01 11:41:19 pve-test-hba kernel: Tainted: [D]=3DDIE, [W]=3DWARN, [E]=3D=
UNSIGNED_MODULE
Apr 01 11:41:19 pve-test-hba kernel: Hardware name: <snip>
Apr 01 11:41:19 pve-test-hba kernel: Call Trace:
Apr 01 11:41:19 pve-test-hba kernel:  <TASK>
Apr 01 11:41:19 pve-test-hba kernel:  dump_stack_lvl+0x76/0xa0
Apr 01 11:41:19 pve-test-hba kernel:  dump_stack+0x10/0x20
Apr 01 11:41:19 pve-test-hba kernel:  __schedule_bug+0x64/0x80
Apr 01 11:41:19 pve-test-hba kernel:  __schedule+0x1168/0x1760
Apr 01 11:41:19 pve-test-hba kernel:  ? vprintk_default+0x1d/0x30
Apr 01 11:41:19 pve-test-hba kernel:  do_task_dead+0x4c/0xb0
Apr 01 11:41:19 pve-test-hba kernel:  make_task_dead+0x142/0x160
Apr 01 11:41:19 pve-test-hba kernel:  rewind_stack_and_make_dead+0x16/0x2=
0
Apr 01 11:41:19 pve-test-hba kernel: RIP: 0033:0x7f3fbd41e7b9
Apr 01 11:41:19 pve-test-hba kernel: Code: Unable to access opcode bytes =
at 0x7f3fbd41e78f.
Apr 01 11:41:19 pve-test-hba kernel: RSP: 002b:00007ffde2893c18 EFLAGS: 0=
0000246 ORIG_RAX: 00000000000000d1
Apr 01 11:41:19 pve-test-hba kernel: RAX: ffffffffffffffda RBX: 00007f3fb=
d1816f0 RCX: 00007f3fbd41e7b9
Apr 01 11:41:19 pve-test-hba kernel: RDX: 00007ffde2893cc0 RSI: 000000000=
0000001 RDI: 00007f3fbd82f000
Apr 01 11:41:19 pve-test-hba kernel: RBP: 00007f3fbd82f000 R08: 0000596c2=
e67f000 R09: 0000000000000000
Apr 01 11:41:19 pve-test-hba kernel: R10: 0000000000000100 R11: 000000000=
0000246 R12: 0000000000000001
Apr 01 11:41:19 pve-test-hba kernel: R13: 0000000000000002 R14: 00007ffde=
2893cc0 R15: 0000596c12ab5e50
Apr 01 11:41:19 pve-test-hba kernel:  </TASK>
Apr 01 11:41:19 pve-test-hba kernel: ------------[ cut here ]------------=

Apr 01 11:41:19 pve-test-hba kernel: Voluntary context switch within RCU =
read-side critical section!
Apr 01 11:41:19 pve-test-hba kernel: WARNING: kernel/rcu/tree_plugin.h:33=
2 at rcu_note_context_switch+0x4e/0x530, CPU#15: vgs/6695
Apr 01 11:41:19 pve-test-hba kernel: Modules linked in: dm_crypt(E) nf_ta=
bles(E) sunrpc(E) bonding(E) tls(E) softdog(E) nfnetlink_log(E) binfmt_mi=
sc(E) ipmi_ssif(E) amd_atl(E) intel_rapl_msr(E) intel_rapl_common(E) amd6=
4_edac(E) edac_mce_amd(E) kvm_amd(E) dax_hmem(E) cxl_acpi(E) kvm(E) cxl_p=
ort(E) irqbypass(E) cxl_pmem(E) cxl_core(E) ghash_clmulni_intel(E) joydev=
(E) acpi_ipmi(E) aesni_intel(E) ast(E) input_leds(E) fwctl(E) ses(E) i2c_=
algo_bit(E) enclosure(E) rapl(E) einj(E) ccp(E) pcspkr(E) ipmi_si(E) wmi_=
bmof(E) spd5118(E) ipmi_devintf(E) hsmp_acpi(E) k10temp(E) hsmp_common(E)=
 ipmi_msghandler(E) mac_hid(E) sch_fq_codel(E) msr(E) vhost_net(E) vhost(=
E) nvme_fabrics(E) vhost_iotlb(E) tap(E) nvme_core(E) nvme_keyring(E) nvm=
e_auth(E) hkdf(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) autofs4(E) btrf=
s(E) libblake2b(E) xor(E) raid6_pq(E) dm_thin_pool(E) dm_persistent_data(=
E) dm_bio_prison(E) dm_bufio(E) hid_generic(E) usbmouse(E) usbhid(E) rndi=
s_host(E) cdc_ether(E) hid(E) usbnet(E) mii(E) xhci_pci_renesas(E) mpt3sa=
s(E) xhci_pci(E) raid_class(E)
Apr 01 11:41:19 pve-test-hba kernel:  ahci(E) tg3(E) scsi_transport_sas(E=
) libahci(E) xhci_hcd(E) i2c_piix4(E) i2c_smbus(E) wmi(E) 8250_dw(E)
Apr 01 11:41:19 pve-test-hba kernel: CPU: 15 UID: 0 PID: 6695 Comm: vgs T=
ainted: G      D W   E       7.0.0-rc6 #19 PREEMPT(full)
Apr 01 11:41:19 pve-test-hba kernel: Tainted: [D]=3DDIE, [W]=3DWARN, [E]=3D=
UNSIGNED_MODULE
Apr 01 11:41:19 pve-test-hba kernel: Hardware name: <snip>
Apr 01 11:41:19 pve-test-hba kernel: RIP: 0010:rcu_note_context_switch+0x=
4e/0x530
Apr 01 11:41:19 pve-test-hba kernel: Code: 65 48 8b 1d fc c2 ab 02 4c 8d =
a0 80 65 b3 86 0f 1f 44 00 00 45 84 ed 75 16 8b 83 7c 09 00 00 85 c0 7e 0=
c 48 8d 3d 02 78 5a 02 <67> 48 0f b9 3a 8b 83 7c 09 00 00 85 c0 7e 09 80 =
bb 80 09 00 00 00
Apr 01 11:41:19 pve-test-hba kernel: RSP: 0018:ff3a2412497ffe08 EFLAGS: 0=
0010002
Apr 01 11:41:19 pve-test-hba kernel: RAX: 0000000000000001 RBX: ff1cd46a5=
81f3100 RCX: 0000000000000000
Apr 01 11:41:19 pve-test-hba kernel: RDX: 0000000080000001 RSI: ffffffff8=
591fa97 RDI: ffffffff86605540
Apr 01 11:41:19 pve-test-hba kernel: RBP: ff3a2412497ffe30 R08: 000000000=
0000000 R09: 0000000000000000
Apr 01 11:41:19 pve-test-hba kernel: R10: 0000000000000000 R11: 000000000=
0000000 R12: ff1cd46d8d7b4580
Apr 01 11:41:19 pve-test-hba kernel: R13: 0000000000000000 R14: ff1cd46a5=
81f3100 R15: 0000000000000000
Apr 01 11:41:19 pve-test-hba kernel: FS:  0000000000000000(0000) GS:ff1cd=
46e06c7e000(0000) knlGS:0000000000000000
Apr 01 11:41:19 pve-test-hba kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000=
0000080050033
Apr 01 11:41:19 pve-test-hba kernel: CR2: 0000000000000300 CR3: 000000010=
c6d2006 CR4: 0000000000f71ef0
Apr 01 11:41:19 pve-test-hba kernel: PKRU: 55555554
Apr 01 11:41:19 pve-test-hba kernel: Call Trace:
Apr 01 11:41:19 pve-test-hba kernel:  <TASK>
Apr 01 11:41:19 pve-test-hba kernel:  __schedule+0xda/0x1760
Apr 01 11:41:19 pve-test-hba kernel:  ? vprintk_default+0x1d/0x30
Apr 01 11:41:19 pve-test-hba kernel:  do_task_dead+0x4c/0xb0
Apr 01 11:41:19 pve-test-hba kernel:  make_task_dead+0x142/0x160
Apr 01 11:41:19 pve-test-hba kernel:  rewind_stack_and_make_dead+0x16/0x2=
0
Apr 01 11:41:19 pve-test-hba kernel: RIP: 0033:0x7f3fbd41e7b9
Apr 01 11:41:19 pve-test-hba kernel: Code: Unable to access opcode bytes =
at 0x7f3fbd41e78f.
Apr 01 11:41:19 pve-test-hba kernel: RSP: 002b:00007ffde2893c18 EFLAGS: 0=
0000246 ORIG_RAX: 00000000000000d1
Apr 01 11:41:19 pve-test-hba kernel: RAX: ffffffffffffffda RBX: 00007f3fb=
d1816f0 RCX: 00007f3fbd41e7b9
Apr 01 11:41:19 pve-test-hba kernel: RDX: 00007ffde2893cc0 RSI: 000000000=
0000001 RDI: 00007f3fbd82f000
Apr 01 11:41:19 pve-test-hba kernel: RBP: 00007f3fbd82f000 R08: 0000596c2=
e67f000 R09: 0000000000000000
Apr 01 11:41:19 pve-test-hba kernel: R10: 0000000000000100 R11: 000000000=
0000246 R12: 0000000000000001
Apr 01 11:41:19 pve-test-hba kernel: R13: 0000000000000002 R14: 00007ffde=
2893cc0 R15: 0000596c12ab5e50
Apr 01 11:41:19 pve-test-hba kernel:  </TASK>
Apr 01 11:41:19 pve-test-hba kernel: ---[ end trace 0000000000000000 ]---=


