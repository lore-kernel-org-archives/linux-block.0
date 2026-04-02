Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326B53CC9E4
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140434; cv=none; b=TAa/G3STZmymaRN9/vp937A76Jhi9LHfzFlJPfqxIbMFdu0qBOwAOFtt4nA39z0lzOGOPhowvCdselve/MfYf5+VIjH8hsJzb44CSTvcz/wqVQXltKPUjP+3jgIbV6FWjqdbrTD5O7GPJJry0fgGlvT/za5texTfWAPMkUY40J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140434; c=relaxed/simple;
	bh=mWeUJnz/rdVoiTbaqv8iGEP2+beNOx+Hql57xaDIJLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5lP3MqKLfyLi/yIMsbZDE9FW7TkRGqgfjAhR8GDeSgPwTtBFW/Hc7OEpRqnVY0LQmi1PAhvsSC0UrH7HeSZQdzVi52DXX6AWRLeiffQxTjTHMunGtBY9NPMuBz0P2Mz2qccN/XUfqiFIkYN0TFuJQ3xANm9vyEZtOpJhzRBhnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 55EC5869A9;
	Thu, 02 Apr 2026 16:33:49 +0200 (CEST)
Message-ID: <9bf5286c-bac7-4cb7-9bfe-f47195e18b79@proxmox.com>
Date: Thu, 2 Apr 2026 16:33:47 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
To: Damien Le Moal <dlemoal@kernel.org>, Mira Limbeck <m.limbeck@proxmox.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
 martin.petersen@oracle.com
References: <20250618060045.37593-1-dlemoal@kernel.org>
 <291f78bf-4b4a-40dd-867d-053b36c564b3@proxmox.com>
 <ff5e2877-840b-4eb6-b449-bb64fb2e4097@kernel.org>
 <ac2256a0-25ce-4453-8c47-04cb7716d46a@proxmox.com>
 <7a0cfc66-3131-4b94-87f2-cbb96595ebb6@kernel.org>
Content-Language: en-US
From: Friedrich Weber <f.weber@proxmox.com>
In-Reply-To: <7a0cfc66-3131-4b94-87f2-cbb96595ebb6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1775140368897

Hi, Mira and I have been looking into this issue together.

On 01/04/2026 22:01, Damien Le Moal wrote:
> On 4/1/26 19:32, Mira Limbeck wrote:
>> Sorry if I wasn't clear enough, we did test the following mainline
>> kernels without any downstream patches (git tags):
>> v6.16 (unaffected)
>> v6.17 (affected)
>> v7.0-rc5 (affected)
>>
>> Afterwards we started to bisect between mainline 6.16
>> (038d61fd642278bab63ee8ef722c50d10ab01e8f) and mainline 6.17
>> (e5f0a698b34ed76002dc5cff3804a61c80233a7a) without any downstream
>> patches, which led us to this commit as the first bad one:
>> 9b8b84879d4adc506b0d3944e20b28d9f3f6994b
> 
> Note: the proper way to reference a patch is to use 12-digits commit ID and
> patch title:
> 
> 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
> 
> as that make it easier to know what one is talking about without having to go
> look what patch that ID references.

Thanks for the hint, noted!

>> Building our downstream kernel 6.17 with this commit reverted, fixed it.
> 
> Nope, this is likely not fixing anything but rather hiding the issue. With this
> patch reverted, the default max_sectors_kb will be 1280, so all requests will be
> chunked to that size at most, and your devices will not see large commands.
> However, simply doing something like:
> 
> echo 4096 > /sys/block/<dev>/queue/max_sectors_kb
> 
> will put your system in a state that is equivalent to the patch being applied
> and you will likely see the issue again. Try.

Yes, looks like on a system without this patch, setting the max_sectors_kb to
4096 on the encrypted Ceph OSD disk will produce the crash.

> [...]
> 
>> Here the logs from 7.0-rc6:
>>
>> Apr 01 11:41:19 pve-test-hba kernel: sd 9:2:2:0: [sdc] tag#3962 page boundary curr_buff: 0x00000000f4d7cfce
>> Apr 01 11:41:19 pve-test-hba kernel: BUG: unable to handle page fault for address: ff3a241243d70000
>> Apr 01 11:41:19 pve-test-hba kernel: #PF: supervisor write access in kernel mode
>> Apr 01 11:41:19 pve-test-hba kernel: #PF: error_code(0x0002) - not-present page
>> Apr 01 11:41:19 pve-test-hba kernel: PGD 100010067 P4D 10066d067 PUD 10066e067 PMD 11f0fa067 PTE 0
>> Apr 01 11:41:19 pve-test-hba kernel: Oops: Oops: 0002 [#3] SMP NOPTI
>> Apr 01 11:41:19 pve-test-hba kernel: CPU: 15 UID: 0 PID: 6695 Comm: vgs Tainted: G      D W   E       7.0.0-rc6 #19 PREEMPT(full)
>> Apr 01 11:41:19 pve-test-hba kernel: Tainted: [D]=DIE, [W]=WARN, [E]=UNSIGNED_MODULE
>> Apr 01 11:41:19 pve-test-hba kernel: Hardware name: <snip>
>> Apr 01 11:41:19 pve-test-hba kernel: RIP: 0010:_base_build_sg_scmd_ieee+0x478/0x590 [mpt3sas]
> 
> There may be an issue with the mpt3sas driver with large commands.
> 
> However, I am using that driver all day long and doing lots of testing with
> gigantic read/write commands all the time. I have never seen any issues.
> The difference is that I am using the SAS-SATA FW for the Broadcom HBA, so no
> NVMe support, and my target devices are SAS or SATA HDDs, not SSDs.
> 
> Something may be wrong with the NVMe support in that HBA, or, your SSDs do not
> like large commands and cause issues. That is easy to test: try connecting your
> SSDs directly to PCI and test them by issuing large read/write commands with fio
> (you will need to use iomem=mmaphuge option to use hugepages for the IO buffers
> to ensure that you do not get the IOs chunked into small commands due to memory
> fragmentation).

We only have limited access to the test machine, so testing this is not
trivial. If I understand correctly, there is a lead pointing in the direction
of mpt3sas [1], so I'd postpone this test for now. But if needed, we're happy
to look into it.

On a possibly related note, we also got some reports from users with HBAs using
the megaraid_sas (not mpt3sas) driver with NVMes and crashes that look similar,
at least to my eyes. We do not have a test system with the right hardware, so
currently cannot test with a mainline kernel. I am aware that downstream kernels
are not supported here, but wanted to mention it anyway on the off-chance that
there might be a similar issue in megaraid_sas.

The user at [2] has the following hardware:

> 2x Micron NVMe via a Broadcom SAS 3808 iMR (HBA mode)

And reports the following crash (quoted from the attachment in [2]):

Mar 20 14:52:36 pmx01rdm kernel: sd 0:0:5:0: [sdb] tag#1136 page boundary ptr_sgl: 0x00000000dd27511c
Mar 20 14:52:36 pmx01rdm kernel: BUG: unable to handle page fault for address: ff46467d429e0000
Mar 20 14:52:36 pmx01rdm kernel: #PF: supervisor write access in kernel mode
Mar 20 14:52:36 pmx01rdm kernel: #PF: error_code(0x0002) - not-present page
Mar 20 14:52:36 pmx01rdm kernel: PGD 100000067 P4D 1002fe067 PUD 1002ff067 PMD 1037d9067 PTE 0
Mar 20 14:52:36 pmx01rdm kernel: Oops: Oops: 0002 [#1] SMP NOPTI
Mar 20 14:52:36 pmx01rdm kernel: CPU: 22 UID: 0 PID: 263834 Comm: kworker/u130:3 Tainted: P           O        6.17.4-2-pve #1 PREEMPT(voluntary) 
Mar 20 14:52:36 pmx01rdm kernel: Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE
Mar 20 14:52:36 pmx01rdm kernel: Hardware name: Supermicro AS -2015CS-TNR/H13SSW, BIOS 3.7 10/09/2025
Mar 20 14:52:36 pmx01rdm kernel: Workqueue: writeback wb_workfn (flush-8:16)
Mar 20 14:52:36 pmx01rdm kernel: RIP: 0010:megasas_build_and_issue_cmd_fusion+0xeaa/0x1870 [megaraid_sas]
Mar 20 14:52:36 pmx01rdm kernel: Code: 20 48 89 d1 48 83 e1 fc 83 e2 01 48 0f 45 d9 4c 8b 73 10 44 8b 6b 18 4c 89 f9 4c 8d 79 08 45 85 fa 0f 84 fd 03 00 00 45 29 cc <4c> 89 31 48 83 c0 08 41 83 c0 01 45 29 cd 45 85 e4 7f ab 44 89 c0
Mar 20 14:52:36 pmx01rdm kernel: RSP: 0018:ff46467dc4647300 EFLAGS: 00010206
Mar 20 14:52:36 pmx01rdm kernel: RAX: 00000000ff690000 RBX: ff29d11d2c357040 RCX: ff46467d429e0000
Mar 20 14:52:36 pmx01rdm kernel: RDX: ff46467d429e0008 RSI: ff29d11d2c356f08 RDI: 0000000000000000
Mar 20 14:52:36 pmx01rdm kernel: RBP: ff46467dc46473d0 R08: 0000000000000200 R09: 0000000000001000
Mar 20 14:52:36 pmx01rdm kernel: R10: 0000000000000fff R11: 0000000000001000 R12: 00000000001ff000
Mar 20 14:52:36 pmx01rdm kernel: R13: 0000000000200000 R14: 00000000b6600000 R15: ff46467d429e0008
Mar 20 14:52:36 pmx01rdm kernel: FS:  0000000000000000(0000) GS:ff29d15bc8e86000(0000) knlGS:0000000000000000
Mar 20 14:52:36 pmx01rdm kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 20 14:52:36 pmx01rdm kernel: CR2: ff46467d429e0000 CR3: 0000001385c3a005 CR4: 0000000000f71ef0
Mar 20 14:52:36 pmx01rdm kernel: PKRU: 55555554
Mar 20 14:52:36 pmx01rdm kernel: Call Trace:
Mar 20 14:52:36 pmx01rdm kernel:  <TASK>
Mar 20 14:52:36 pmx01rdm kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Mar 20 14:52:36 pmx01rdm kernel:  ? scsi_alloc_sgtables+0xa3/0x3a0
Mar 20 14:52:36 pmx01rdm kernel:  megasas_queue_command+0x122/0x1d0 [megaraid_sas]
Mar 20 14:52:36 pmx01rdm kernel:  scsi_queue_rq+0x409/0xcc0
Mar 20 14:52:36 pmx01rdm kernel:  blk_mq_dispatch_rq_list+0x121/0x740
Mar 20 14:52:36 pmx01rdm kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Mar 20 14:52:36 pmx01rdm kernel:  ? sbitmap_get+0x73/0x180
Mar 20 14:52:36 pmx01rdm kernel:  __blk_mq_sched_dispatch_requests+0x408/0x600
Mar 20 14:52:36 pmx01rdm kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Mar 20 14:52:36 pmx01rdm kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Mar 20 14:52:36 pmx01rdm kernel:  blk_mq_sched_dispatch_requests+0x2d/0x80
Mar 20 14:52:36 pmx01rdm kernel:  blk_mq_run_hw_queue+0x2c3/0x330
Mar 20 14:52:36 pmx01rdm kernel:  blk_mq_dispatch_list+0x13e/0x460
Mar 20 14:52:36 pmx01rdm kernel:  blk_mq_flush_plug_list+0x62/0x1e0
Mar 20 14:52:36 pmx01rdm kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Mar 20 14:52:36 pmx01rdm kernel:  blk_add_rq_to_plug+0xfc/0x1c0
Mar 20 14:52:36 pmx01rdm kernel:  blk_mq_submit_bio+0x61f/0x890
Mar 20 14:52:36 pmx01rdm kernel:  __submit_bio+0x74/0x290
Mar 20 14:52:36 pmx01rdm kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Mar 20 14:52:36 pmx01rdm kernel:  submit_bio_noacct_nocheck+0x28d/0x370
Mar 20 14:52:36 pmx01rdm kernel:  submit_bio_noacct+0x19b/0x5b0
Mar 20 14:52:36 pmx01rdm kernel:  submit_bio+0xb1/0x110
Mar 20 14:52:36 pmx01rdm kernel:  mpage_write_folio+0x76a/0x7c0
Mar 20 14:52:36 pmx01rdm kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Mar 20 14:52:36 pmx01rdm kernel:  ? mod_memcg_lruvec_state+0xd3/0x1f0
Mar 20 14:52:36 pmx01rdm kernel:  mpage_writepages+0x87/0x110
Mar 20 14:52:36 pmx01rdm kernel:  ? __pfx_fat_get_block+0x10/0x10
Mar 20 14:52:36 pmx01rdm kernel:  ? update_curr+0x187/0x1b0
Mar 20 14:52:36 pmx01rdm kernel:  fat_writepages+0x15/0x30
Mar 20 14:52:36 pmx01rdm kernel:  do_writepages+0xc1/0x180
Mar 20 14:52:36 pmx01rdm kernel:  __writeback_single_inode+0x44/0x350
Mar 20 14:52:36 pmx01rdm kernel:  writeback_sb_inodes+0x24e/0x550
Mar 20 14:52:36 pmx01rdm kernel:  wb_writeback+0x98/0x330
Mar 20 14:52:36 pmx01rdm kernel:  wb_workfn+0xb6/0x410
Mar 20 14:52:36 pmx01rdm kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Mar 20 14:52:36 pmx01rdm kernel:  process_one_work+0x188/0x370
Mar 20 14:52:36 pmx01rdm kernel:  worker_thread+0x33a/0x480
Mar 20 14:52:36 pmx01rdm kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Mar 20 14:52:36 pmx01rdm kernel:  ? __pfx_worker_thread+0x10/0x10
Mar 20 14:52:36 pmx01rdm kernel:  kthread+0x108/0x220
Mar 20 14:52:36 pmx01rdm kernel:  ? __pfx_kthread+0x10/0x10
Mar 20 14:52:36 pmx01rdm kernel:  ret_from_fork+0x205/0x240
Mar 20 14:52:36 pmx01rdm kernel:  ? __pfx_kthread+0x10/0x10
Mar 20 14:52:36 pmx01rdm kernel:  ret_from_fork_asm+0x1a/0x30
Mar 20 14:52:36 pmx01rdm kernel:  </TASK>
[...]

[1] https://lore.kernel.org/all/ac2GOOLzui0U0BTJ@kbusch-mbp/
[2] https://bugzilla.proxmox.com/show_bug.cgi?id=7438

