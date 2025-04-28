Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E286C1A7045;
	Mon, 28 Apr 2025 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745825987; cv=none; b=nK06rOCznwmjm4BfjpU43BqazFBg1UK1xfg0+3AaDYBFJShr69hEx8mrijFGk9N4DytEOsq9I8hxeUx+HHcP7worGDMwqSGtI95HPpxFolNIXXJnKX5tkJdqgnEs+Owv8TNF1Bgq6VpmoHxzT8tcfu+lE2QnCyEmzrc82s/eOkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745825987; c=relaxed/simple;
	bh=I3OprVu72JhhQGKcFW66mQvo5F5aRpp7/PHTbWF0BQQ=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=i14UAXUc1YJ0XQePtYNZuzNo340/8VM2ThJX+BLtDwTJP3MFmU4anTF2B2MevCssYY7ADXy+mP892jOhBFb3oDt4Sf4oLWlXQKQRK41epBSDh0luu5LuNnXTijoIPkRASdqNstu7gXE9GMWZQ6JFLOUgDUoTXEfZ1FJvahFVg3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZmFh22R6zz4f3lCm;
	Mon, 28 Apr 2025 15:39:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 041721A08FD;
	Mon, 28 Apr 2025 15:39:40 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2C4MA9o_qM1Kw--.43388S3;
	Mon, 28 Apr 2025 15:39:37 +0800 (CST)
Subject: Re: [mainline]WARNING: CPU: 29 PID: 1121679 at block/genhd.c:302
 unregister_blkdev+0x1e8/0x2b0
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
 Nilay Shroff <nilay@linux.ibm.com>, shinichiro.kawasaki@wdc.com,
 Madhavan Srinivasan <maddy@linux.ibm.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <dca3fb23-5d0f-4b62-bf7a-24d7e1fef3fe@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b9c78f92-8f3c-6d78-21fe-a5fd832fd179@huaweicloud.com>
Date: Mon, 28 Apr 2025 15:39:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <dca3fb23-5d0f-4b62-bf7a-24d7e1fef3fe@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2C4MA9o_qM1Kw--.43388S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuw17ZF18AF15Zw1fAFWfuFg_yoW7uw4Dpr
	1UXF1UGrW8Jry8CrW7JF45Ja1DJw1DA3WDGr1fKr18Xr4UGw1rXr1UJFyUXr1UXa15tr15
	Jry8JryUKr1UKw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/04/28 15:07, Venkat Rao Bagalkote 写道:
> Hello,
> 
> 
> I am observing kernel warnings on the mainline kernel, while running 
> block_dev Tests from LTP test suite, on IBM Power servers.
> 
> 
> Repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> 
> I have not started the bisection yet.
> 
> 
> Warnings:
> 
> 
> [13323.500222] ltp_block_dev: Test Case 7: unregister_blkdev() with major=0
> [13323.500232] ------------[ cut here ]------------
> [13323.500236] WARNING: CPU: 29 PID: 1121679 at block/genhd.c:302 
> unregister_blkdev+0x1e8/0x2b0
> [13323.500245] Modules linked in: ltp_block_dev(O) dummy veth 
> dns_resolver tun brd overlay exfat vfat fat btrfs blake2b_generic xor 
> raid6_pq zstd_compress xfs loop sctp ip6_udp_tunnel udp_tunnel 
> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet 
> nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat 
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bonding tls rfkill ip_set 
> nf_tables nfnetlink pseries_rng vmx_crypto dax_pmem fuse ext4 crc16 
> mbcache jbd2 sd_mod sg nd_pmem nd_btt papr_scm ibmvscsi 
> scsi_transport_srp ibmveth libnvdimm [last unloaded: ltp_fw_load(O)]
> [13323.500297] CPU: 29 UID: 0 PID: 1121679 Comm: block_dev Kdump: loaded 
> Tainted: G   M       O  K     6.15.0-rc3-gbc3372351d0c #1 VOLUNTARY
> [13323.500304] Tainted: [M]=MACHINE_CHECK, [O]=OOT_MODULE, [K]=LIVEPATCH
> [13323.500313] NIP:  c000000000882d40 LR: c000000000882bc0 CTR: 
> c000000000882b58
> [13323.500317] REGS: c00000006ff0f8b0 TRAP: 0700   Tainted: G M       O 
> K      (6.15.0-rc3-gbc3372351d0c)
> [13323.500322] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
> 28008222  XER: 2004000d
> [13323.500331] CFAR: c000000000882be4 IRQMASK: 0
> [13323.500331] GPR00: c000000000882bc0 c00000006ff0fb50 c000000001688100 
> c000000002fdb2e8
> [13323.500331] GPR04: c008000006790118 000000000000000d 000000000000003b 
> fffffffffffe0000
> [13323.500331] GPR08: 0000000000000000 0000000000000000 0000000000000000 
> c008000006691498
> [13323.500331] GPR12: c000000000882b58 c000000efde70300 0000000000000000 
> 0000000000000000
> [13323.500331] GPR16: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [13323.500331] GPR20: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [13323.500331] GPR24: 0000000000000000 0000000000000000 c0000000671767a0 
> c008000006790118
> [13323.500331] GPR28: c000000002bca9b8 c000000002fdaae8 0000000000000000 
> 0000000000000000
> [13323.500376] NIP [c000000000882d40] unregister_blkdev+0x1e8/0x2b0
> [13323.500381] LR [c000000000882bc0] unregister_blkdev+0x68/0x2b0
> [13323.500386] Call Trace:
> [13323.500388] [c00000006ff0fb50] [c000000000882bb0] 
> unregister_blkdev+0x58/0x2b0 (unreliable)
> [13323.500395] [c00000006ff0fba0] [c008000006691058] 
> sys_tcase+0x804/0x938 [ltp_block_dev]
> [13323.500401] [c00000006ff0fc80] [c000000000ac2454] 
> dev_attr_store+0x34/0x50
> [13323.500408] [c00000006ff0fca0] [c000000000737d6c] 
> sysfs_kf_write+0x78/0x8c
> [13323.500413] [c00000006ff0fcc0] [c0000000007367cc] 
> kernfs_fop_write_iter+0x1b4/0x2a4
> [13323.500419] [c00000006ff0fd10] [c000000000628d28] vfs_write+0x38c/0x488
> [13323.500424] [c00000006ff0fdc0] [c000000000629158] ksys_write+0x84/0x140
> [13323.500429] [c00000006ff0fe10] [c0000000000332f8] 
> system_call_exception+0x138/0x330
> [13323.500436] [c00000006ff0fe50] [c00000000000d05c] 
> system_call_vectored_common+0x15c/0x2ec
> [13323.500442] --- interrupt: 3000 at 0x7fff92933e74
> [13323.500446] NIP:  00007fff92933e74 LR: 00007fff92933e74 CTR: 
> 0000000000000000
> [13323.500450] REGS: c00000006ff0fe80 TRAP: 3000   Tainted: G M       O 
> K      (6.15.0-rc3-gbc3372351d0c)
> [13323.500455] MSR:  800000000280f033 
> <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 44002424  XER: 00000000
> [13323.500466] IRQMASK: 0
> [13323.500466] GPR00: 0000000000000004 00007fffd5bca940 0000000010067f00 
> 0000000000000003
> [13323.500466] GPR04: 0000000030a90b50 0000000000000001 0000000000000000 
> 0000000000000001
> [13323.500466] GPR08: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [13323.500466] GPR12: 0000000000000000 00007fff92c5a5c0 0000000000000000 
> 00000000100332d0
> [13323.500466] GPR16: 0000000010033608 0000000010033ce4 0000000010033ce8 
> 0000000010033b60
> [13323.500466] GPR20: 0000000000000001 0000000000000000 0000000000000000 
> 0000000000000000
> [13323.500466] GPR24: 0000000010060848 00000000100307b0 0000000030a90b50 
> 0000000000000001
> [13323.500466] GPR28: 0000000000000001 0000000030a902a0 0000000030a90b50 
> 0000000000000001
> [13323.500508] NIP [00007fff92933e74] 0x7fff92933e74
> [13323.500512] LR [00007fff92933e74] 0x7fff92933e74
> [13323.500515] --- interrupt: 3000
> [13323.500517] Code: 7d404c28 39200000 7d094bf8 7d0753f8 7d293b39 
> 408200cc 389b0040 38630040 48851ecd 60000000 48000084 60000000 
> <0fe00000> a14d0c82 3be00000 7da96b78
> [13323.500531] ---[ end trace 0000000000000000 ]---
> [13323.500535] ltp_block_dev: Test Case Result: PASS
> 
> 
> If you happen to fix this, please add below tag.

Nothing should be fixed, unregister_blkdev() is called directly by your
testcase with major set to 0, the WARNING is expected.

Thanks,
Kuai

> 
> 
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> 
> 
> Regards,
> 
> Venkat.
> 
> 
> .
> 

