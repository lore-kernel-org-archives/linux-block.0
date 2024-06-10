Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3AE1CD15;
	Mon, 10 Jun 2024 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718005889; cv=none; b=Pe/aIJdHjFO3rfJRGrDuA8biaz0zNnMyckyd5GKjym75DiUClx6i5v9SGVGbU2T4iAxndwO3MFv51rDjPCxGn3h25qsGOavl1rgoXhr7Ybsc5KARU0g8cAWiRIM+SVhajZLyM/dyDNpc+FDOFNNf3YIlJ/UsNssFM4SWnbOKymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718005889; c=relaxed/simple;
	bh=zrT0EGilxBVte1bvO9FEt6EF04OYcW+aYrqqeGdpO8w=;
	h=Message-ID:Date:MIME-Version:Cc:From:To:Subject:Content-Type; b=eQeiNbIpR5aD2fjqnLZjN+WV627O5WOIvLWhqYAOubCvgp9dR9p+GIR/fODMiCZYWLutPT0SOA68Kal1MKKER8rHDYa55cW2hiR+r94UMD3WiUG1dv57y/anF4ZArHBNHSXUyAuWzxDF7J1Fd6zr5VF9eOPNHekIoy48KRiKDJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VsR/uuLt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VsR/uuLt"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A7SLlw006146;
	Mon, 10 Jun 2024 07:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:cc:from:to:subject:content-type
	:content-transfer-encoding; s=pp1; bh=nsTUAhGPInye92bi+dTdyUmg2Q
	/RLoZC+TRIvK7quo8=; b=VsR/uuLtLuwUM4lsfsjEXfs9GADEfsP0kkWzeBG5vX
	vWS7//ezrWFJ1O2MKNp8OpxLbR0eaiZlbKKsboS2JJbadZnWahqrjblvqgOmpkWm
	08h6bAEzG2IOIrVjiHouAGSruIeWVkQjICDuJh313A2w/Gx0AkWK7OAl383C/F4b
	yKlzSEBUdgsP7zGa/wMDw7Sxrq3jOyr4oeT9pMS9A5OKfKsuJn7MF7WVtm8boQym
	spRqIhST2KWTen688tKH/CYPIZDixtxEbnbQDj6OLv/Wx4BZP1qsR5EK1MWKkA0E
	ADpr1zyifYXLoUzn/ZiqhuYVZLPoEb33J0I6bKHsl7Rg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ynw4fr29j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 07:51:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45A6ajau027267;
	Mon, 10 Jun 2024 07:51:07 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn210ef3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 07:51:07 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45A7p5pM28508714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 07:51:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D71658052;
	Mon, 10 Jun 2024 07:51:05 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4025558069;
	Mon, 10 Jun 2024 07:51:02 +0000 (GMT)
Received: from [9.43.109.30] (unknown [9.43.109.30])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Jun 2024 07:51:01 +0000 (GMT)
Message-ID: <2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com>
Date: Mon, 10 Jun 2024 13:21:00 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, sachinp@linux.vnet.com
From: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
To: kbusch@kernel.org, sagi@grimberg.me
Subject: Kernel OOPS while creating a NVMe Namespace
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GbUrgM5lRbY41DSQ2LJiM9DYhgGllun8
X-Proofpoint-ORIG-GUID: GbUrgM5lRbY41DSQ2LJiM9DYhgGllun8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1011 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=972 lowpriorityscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406100056

Greetings!!!

Observing Kernel OOPS, while creating namespace on a NVMe device.

[  140.209777] BUG: Unable to handle kernel data access at 
0x18d7003065646fee
[  140.209792] Faulting instruction address: 0xc00000000023b45c
[  140.209798] Oops: Kernel access of bad area, sig: 11 [#1]
[  140.209802] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=8192 NUMA pSeries
[  140.209809] Modules linked in: rpadlpar_io rpaphp xsk_diag 
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet 
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat 
bonding nf_conntrack tls nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set 
nf_tables nfnetlink vmx_crypto pseries_rng binfmt_misc fuse xfs 
libcrc32c sd_mod sg ibmvscsi scsi_transport_srp ibmveth nvme nvme_core 
t10_pi crc64_rocksoft_generic crc64_rocksoft crc64
[  140.209864] CPU: 2 PID: 129 Comm: kworker/u65:3 Kdump: loaded Not 
tainted 6.10.0-rc3 #2
[  140.209870] Hardware name: IBM,9009-42A POWER9 (raw) 0x4e0202 
0xf000005 of:IBM,FW950.A0 (VL950_141) hv:phyp pSeries
[  140.209876] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[  140.209889] NIP:  c00000000023b45c LR: c008000006a96b20 CTR: 
c00000000023b42c
[  140.209894] REGS: c0000000506078a0 TRAP: 0380   Not tainted (6.10.0-rc3)
[  140.209899] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  
CR: 24000244  XER: 00000000
[  140.209915] CFAR: c008000006aa80ac IRQMASK: 0
[  140.209915] GPR00: c008000006a96b20 c000000050607b40 c000000001573700 
c000000004291ee0
[  140.209915] GPR04: 0000000000000000 c000000006150080 00000000c0080005 
fffffffffffe0000
[  140.209915] GPR08: 0000000000000000 18d7003065646f6e 0000000000000000 
c008000006aa8098
[  140.209915] GPR12: c00000000023b42c c00000000f7cdf00 c0000000001a151c 
c000000004f2be80
[  140.209915] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[  140.209915] GPR20: c000000004dbcc00 0000000000000006 0000000000000002 
c000000004911270
[  140.209915] GPR24: 0000000000000000 0000000000000000 c0000000ee254ffc 
c0000000049111f0
[  140.209915] GPR28: 0000000000000000 c000000004911260 c000000004291ee0 
c000000004911260
[  140.209975] NIP [c00000000023b45c] synchronize_srcu+0x30/0x1c0
[  140.209984] LR [c008000006a96b20] nvme_ns_remove+0x80/0x2d8 [nvme_core]
[  140.209994] Call Trace:
[  140.209997] [c000000050607b90] [c008000006a96b20] 
nvme_ns_remove+0x80/0x2d8 [nvme_core]
[  140.210008] [c000000050607bd0] [c008000006a972b4] 
nvme_remove_invalid_namespaces+0x144/0x1ac [nvme_core]
[  140.210020] [c000000050607c60] [c008000006a9dbd4] 
nvme_scan_ns_list+0x19c/0x370 [nvme_core]
[  140.210032] [c000000050607d70] [c008000006a9dfc8] 
nvme_scan_work+0xc8/0x278 [nvme_core]
[  140.210043] [c000000050607e40] [c00000000019414c] 
process_one_work+0x20c/0x4f4
[  140.210051] [c000000050607ef0] [c0000000001950cc] 
worker_thread+0x378/0x544
[  140.210058] [c000000050607f90] [c0000000001a164c] kthread+0x138/0x140
[  140.210065] [c000000050607fe0] [c00000000000df98] 
start_kernel_thread+0x14/0x18
[  140.210072] Code: 3c4c0134 384282d4 7c0802a6 60000000 7c0802a6 
fbc1fff0 fba1ffe8 fbe1fff8 7c7e1b78 f8010010 f821ffb1 e9230010 
<e9290080> 7c2004ac 71290003 41820008
[  140.210093] ---[ end trace 0000000000000000 ]---


Issue is introduced by the patch: be647e2c76b27f409cdd520f66c95be888b553a3.


Reverting it, issue is not seen.


Regards,

Venkat.


