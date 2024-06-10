Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3430A4D8A0
	for <linux-block@vger.kernel.org>; Mon, 10 Jun 2024 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718012631; cv=none; b=YYvzufiXR7T6BXkSOKJ8NADu2cubR5MZ7IlPywokB+fNUf+ZyFmtdeYhrTc9y9Gh0XBGq/O86RN1AgJAZDdTk7LwOO3BCKlzH4OTC3miwJR4FdnfohFQ7sjKvkC2NsqYkdBMFihOnD6p+u4ySKK+VOtdFg2LQ7Hls08zaLr5ixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718012631; c=relaxed/simple;
	bh=VDzE3RSwnrxU/yC/vUrKtkweZzQ3kekLxfWWailNru4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e1gsRORxRmquARUkDLKC7Ujkao5CFR6iGH5vy2oP1OoHjmL2Lym+HzhYr0PJpylyX2N530iQqn/LMEGbYHCONtFssQ/Bo13oxiSqL5LXxjb4/caMtFn+2CNWpmO+HPAtH5DT+AWeOtmTpR7PWmG1zspO+TAW+H8w+Jjf2hMQjXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.173])
	by sina.com (10.75.12.45) with ESMTP
	id 6666CAC600006219; Mon, 10 Jun 2024 17:43:37 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 40054931457759
X-SMAIL-UIID: 3FB5AC4B5CAB4E03AA8A8F19874F619D-20240610-174337-1
From: Hillf Danton <hdanton@sina.com>
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: kbusch@kernel.org,
	sagi@grimberg.me,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sachinp@linux.vnet.com
Subject: Re: Kernel OOPS while creating a NVMe Namespace
Date: Mon, 10 Jun 2024 17:43:25 +0800
Message-Id: <20240610094325.2156-1-hdanton@sina.com>
In-Reply-To: <2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 10 Jun 2024 13:21:00 +0530 Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> Observing Kernel OOPS, while creating namespace on a NVMe device.
> 
> [  140.209777] BUG: Unable to handle kernel data access at 
> 0x18d7003065646fee
> [  140.209792] Faulting instruction address: 0xc00000000023b45c
> [  140.209798] Oops: Kernel access of bad area, sig: 11 [#1]
> [  140.209802] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=8192 NUMA pSeries
> [  140.209809] Modules linked in: rpadlpar_io rpaphp xsk_diag 
> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet 
> nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat 
> bonding nf_conntrack tls nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set 
> nf_tables nfnetlink vmx_crypto pseries_rng binfmt_misc fuse xfs 
> libcrc32c sd_mod sg ibmvscsi scsi_transport_srp ibmveth nvme nvme_core 
> t10_pi crc64_rocksoft_generic crc64_rocksoft crc64
> [  140.209864] CPU: 2 PID: 129 Comm: kworker/u65:3 Kdump: loaded Not 
> tainted 6.10.0-rc3 #2
> [  140.209870] Hardware name: IBM,9009-42A POWER9 (raw) 0x4e0202 
> 0xf000005 of:IBM,FW950.A0 (VL950_141) hv:phyp pSeries
> [  140.209876] Workqueue: nvme-wq nvme_scan_work [nvme_core]
> [  140.209889] NIP:  c00000000023b45c LR: c008000006a96b20 CTR: 
> c00000000023b42c
> [  140.209894] REGS: c0000000506078a0 TRAP: 0380   Not tainted (6.10.0-rc3)
> [  140.209899] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  
> CR: 24000244  XER: 00000000
> [  140.209915] CFAR: c008000006aa80ac IRQMASK: 0
> [  140.209915] GPR00: c008000006a96b20 c000000050607b40 c000000001573700 
> c000000004291ee0
> [  140.209915] GPR04: 0000000000000000 c000000006150080 00000000c0080005 
> fffffffffffe0000
> [  140.209915] GPR08: 0000000000000000 18d7003065646f6e 0000000000000000 
> c008000006aa8098
> [  140.209915] GPR12: c00000000023b42c c00000000f7cdf00 c0000000001a151c 
> c000000004f2be80
> [  140.209915] GPR16: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [  140.209915] GPR20: c000000004dbcc00 0000000000000006 0000000000000002 
> c000000004911270
> [  140.209915] GPR24: 0000000000000000 0000000000000000 c0000000ee254ffc 
> c0000000049111f0
> [  140.209915] GPR28: 0000000000000000 c000000004911260 c000000004291ee0 
> c000000004911260
> [  140.209975] NIP [c00000000023b45c] synchronize_srcu+0x30/0x1c0
> [  140.209984] LR [c008000006a96b20] nvme_ns_remove+0x80/0x2d8 [nvme_core]
> [  140.209994] Call Trace:
> [  140.209997] [c000000050607b90] [c008000006a96b20] 
> nvme_ns_remove+0x80/0x2d8 [nvme_core]
> [  140.210008] [c000000050607bd0] [c008000006a972b4] 
> nvme_remove_invalid_namespaces+0x144/0x1ac [nvme_core]
> [  140.210020] [c000000050607c60] [c008000006a9dbd4] 
> nvme_scan_ns_list+0x19c/0x370 [nvme_core]
> [  140.210032] [c000000050607d70] [c008000006a9dfc8] 
> nvme_scan_work+0xc8/0x278 [nvme_core]
> [  140.210043] [c000000050607e40] [c00000000019414c] 
> process_one_work+0x20c/0x4f4
> [  140.210051] [c000000050607ef0] [c0000000001950cc] 
> worker_thread+0x378/0x544
> [  140.210058] [c000000050607f90] [c0000000001a164c] kthread+0x138/0x140
> [  140.210065] [c000000050607fe0] [c00000000000df98] 
> start_kernel_thread+0x14/0x18
> [  140.210072] Code: 3c4c0134 384282d4 7c0802a6 60000000 7c0802a6 
> fbc1fff0 fba1ffe8 fbe1fff8 7c7e1b78 f8010010 f821ffb1 e9230010 
> <e9290080> 7c2004ac 71290003 41820008
> [  140.210093] ---[ end trace 0000000000000000 ]---
> 
> 
> Issue is introduced by the patch: be647e2c76b27f409cdd520f66c95be888b553a3.
> 
> Reverting it, issue is not seen.

See if refcnt leak existed before be647e2c76b2

--- x/drivers/nvme/host/core.c
+++ y/drivers/nvme/host/core.c
@@ -4078,6 +4078,7 @@ static void nvme_scan_work(struct work_s
 		return;
 	}
 
+	nvme_get_ctrl(ctrl);
 	if (test_and_clear_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events)) {
 		dev_info(ctrl->device, "rescanning namespaces.\n");
 		nvme_clear_changed_ns_log(ctrl);
@@ -4097,6 +4098,7 @@ static void nvme_scan_work(struct work_s
 			nvme_scan_ns_sequential(ctrl);
 	}
 	mutex_unlock(&ctrl->scan_lock);
+	nvme_put_ctrl(ctrl);
 }
 
 /*
--
