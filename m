Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA695126BF7;
	Mon, 28 Apr 2025 07:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745824071; cv=none; b=S20w9BVmfXCnbOx65ZH8fl6kmQ6PdB6abqXeh77yrY/yJUppZ7E1vRYFFxHTHtfNSv2iY6E3ID0iOHCwYgOP5qexA3vYcO/nSWVsfNnFwQfrju6bwY65UFBsfqQfEzOVNRgcp7wvKBB8x9oPyFREZ5tconRtVWOF/4RadXgq9iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745824071; c=relaxed/simple;
	bh=OM9vRBVa7PTDTupvN4BH0deLyvvOT1eOtt2oV35A1tY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=lrbBtbnsnR1r70wCowlsRFoczqBN+8KLUOk7giZYOeS1e3VSdK5pEM4P6XTpyGWL3mPkcBozf9iKntbncOz7A9Lu8nDBZAGOHPzJFpT70LxP/EVo57Sd0FilRbwdcs+V0M8KOtVPWSVOe1uT/uirDwihhf+57n9rfLviL1S9leo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ViyWOdvw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ViyWOdvw"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53RNkW0Y000975;
	Mon, 28 Apr 2025 07:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=oE9lftvFnOG9tpte7hOzZuSgCHQT
	OkzyU+tVxlmx9XE=; b=ViyWOdvwG1sfOTwRDmIiEyy0JVKgBFnqFHF9D8aUtw4D
	8svEK0c8VpORxD+qkEPNXGBvgkc2538CKHx2pETESOhaQtt9dGduCh+J6YNE9cpI
	5kyA/HrXxrW/NWz0/1AMfchuyf8naaSkAKevj1wlp6ZerN0hMOEtgSoX+MqzKeQM
	F2G26cZiCEEiZsxyyVkpXtTvb/Fv/ShoMAYqVVyQVpWfCRa97/Hgqr1SxXXTFeTo
	DielxLf3364JFvIynjQln+++xSRYITQgVnknfnKDZI+1fy2wI7J8T0ZWXUlTot0B
	Y5BmYKL9bmeB//oMJZGRrdksj3dfbP3EcUsY7snbXA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 469xj0scbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 07:07:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53S4CYgR024634;
	Mon, 28 Apr 2025 07:07:47 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 469c1kw12t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 07:07:47 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53S77kgV66060732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 07:07:46 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 644E25805E;
	Mon, 28 Apr 2025 07:07:46 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B94AA58052;
	Mon, 28 Apr 2025 07:07:44 +0000 (GMT)
Received: from [9.204.204.179] (unknown [9.204.204.179])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Apr 2025 07:07:44 +0000 (GMT)
Message-ID: <dca3fb23-5d0f-4b62-bf7a-24d7e1fef3fe@linux.ibm.com>
Date: Mon, 28 Apr 2025 12:37:43 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        Nilay Shroff <nilay@linux.ibm.com>, shinichiro.kawasaki@wdc.com,
        Madhavan Srinivasan <maddy@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [mainline]WARNING: CPU: 29 PID: 1121679 at block/genhd.c:302
 unregister_blkdev+0x1e8/0x2b0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wqvGc2dr8XvS1ZIGziPgbaLKGIV5rqnV
X-Authority-Analysis: v=2.4 cv=GJYIEvNK c=1 sm=1 tr=0 ts=680f2944 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=PH-0tSwyd6fM5Fd3fpAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDA1OCBTYWx0ZWRfX7ASWhoCc4k82 PVDY1ZgrHQcIV6WYlKFp2dHwCIv8Et2jJrRdWOj6/dS/f2JC09YBciHvyKk0eaESclt+Syc2Riv szEzXeutwfkEp4X1S8ucW9NHfd/xCkbGtHqeGNTiG/Mq0XRyCzijQONJn5lMvJn2fENcX0KyWxd
 F/NS9TGn4hZxm0VXVLWKtr+EK+its4nhT3daVTBHTXoCk+OdA4ahAexYfU1givhuRtdSfdzhMtc YHSl8gIo2et021kEJounTViwDlYCQNeD3hI/s9loZ9Kh1y0f5IPNZvzt3jvFX3Gf3/mDR3BcFzt v9Sq/EDp05drzakr2SwQBq9qrAFx7wfjRGok6P7mg+TttpdNbJHEg4lTiuCY//+XsmLAEXRnVh+
 7F5d5dwM4BLOYmSLLb/vad0yvpm83o0GNejoviKoB63GafKYaihpHwk4iXbWfDzwqDlRM5hS
X-Proofpoint-ORIG-GUID: wqvGc2dr8XvS1ZIGziPgbaLKGIV5rqnV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 mlxlogscore=928
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280058

Hello,


I am observing kernel warnings on the mainline kernel, while running 
block_dev Tests from LTP test suite, on IBM Power servers.


Repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git


I have not started the bisection yet.


Warnings:


[13323.500222] ltp_block_dev: Test Case 7: unregister_blkdev() with major=0
[13323.500232] ------------[ cut here ]------------
[13323.500236] WARNING: CPU: 29 PID: 1121679 at block/genhd.c:302 
unregister_blkdev+0x1e8/0x2b0
[13323.500245] Modules linked in: ltp_block_dev(O) dummy veth 
dns_resolver tun brd overlay exfat vfat fat btrfs blake2b_generic xor 
raid6_pq zstd_compress xfs loop sctp ip6_udp_tunnel udp_tunnel 
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet 
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bonding tls rfkill ip_set 
nf_tables nfnetlink pseries_rng vmx_crypto dax_pmem fuse ext4 crc16 
mbcache jbd2 sd_mod sg nd_pmem nd_btt papr_scm ibmvscsi 
scsi_transport_srp ibmveth libnvdimm [last unloaded: ltp_fw_load(O)]
[13323.500297] CPU: 29 UID: 0 PID: 1121679 Comm: block_dev Kdump: loaded 
Tainted: G   M       O  K     6.15.0-rc3-gbc3372351d0c #1 VOLUNTARY
[13323.500304] Tainted: [M]=MACHINE_CHECK, [O]=OOT_MODULE, [K]=LIVEPATCH
[13323.500313] NIP:  c000000000882d40 LR: c000000000882bc0 CTR: 
c000000000882b58
[13323.500317] REGS: c00000006ff0f8b0 TRAP: 0700   Tainted: G M       O  
K      (6.15.0-rc3-gbc3372351d0c)
[13323.500322] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
28008222  XER: 2004000d
[13323.500331] CFAR: c000000000882be4 IRQMASK: 0
[13323.500331] GPR00: c000000000882bc0 c00000006ff0fb50 c000000001688100 
c000000002fdb2e8
[13323.500331] GPR04: c008000006790118 000000000000000d 000000000000003b 
fffffffffffe0000
[13323.500331] GPR08: 0000000000000000 0000000000000000 0000000000000000 
c008000006691498
[13323.500331] GPR12: c000000000882b58 c000000efde70300 0000000000000000 
0000000000000000
[13323.500331] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[13323.500331] GPR20: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[13323.500331] GPR24: 0000000000000000 0000000000000000 c0000000671767a0 
c008000006790118
[13323.500331] GPR28: c000000002bca9b8 c000000002fdaae8 0000000000000000 
0000000000000000
[13323.500376] NIP [c000000000882d40] unregister_blkdev+0x1e8/0x2b0
[13323.500381] LR [c000000000882bc0] unregister_blkdev+0x68/0x2b0
[13323.500386] Call Trace:
[13323.500388] [c00000006ff0fb50] [c000000000882bb0] 
unregister_blkdev+0x58/0x2b0 (unreliable)
[13323.500395] [c00000006ff0fba0] [c008000006691058] 
sys_tcase+0x804/0x938 [ltp_block_dev]
[13323.500401] [c00000006ff0fc80] [c000000000ac2454] 
dev_attr_store+0x34/0x50
[13323.500408] [c00000006ff0fca0] [c000000000737d6c] 
sysfs_kf_write+0x78/0x8c
[13323.500413] [c00000006ff0fcc0] [c0000000007367cc] 
kernfs_fop_write_iter+0x1b4/0x2a4
[13323.500419] [c00000006ff0fd10] [c000000000628d28] vfs_write+0x38c/0x488
[13323.500424] [c00000006ff0fdc0] [c000000000629158] ksys_write+0x84/0x140
[13323.500429] [c00000006ff0fe10] [c0000000000332f8] 
system_call_exception+0x138/0x330
[13323.500436] [c00000006ff0fe50] [c00000000000d05c] 
system_call_vectored_common+0x15c/0x2ec
[13323.500442] --- interrupt: 3000 at 0x7fff92933e74
[13323.500446] NIP:  00007fff92933e74 LR: 00007fff92933e74 CTR: 
0000000000000000
[13323.500450] REGS: c00000006ff0fe80 TRAP: 3000   Tainted: G M       O  
K      (6.15.0-rc3-gbc3372351d0c)
[13323.500455] MSR:  800000000280f033 
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 44002424  XER: 00000000
[13323.500466] IRQMASK: 0
[13323.500466] GPR00: 0000000000000004 00007fffd5bca940 0000000010067f00 
0000000000000003
[13323.500466] GPR04: 0000000030a90b50 0000000000000001 0000000000000000 
0000000000000001
[13323.500466] GPR08: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[13323.500466] GPR12: 0000000000000000 00007fff92c5a5c0 0000000000000000 
00000000100332d0
[13323.500466] GPR16: 0000000010033608 0000000010033ce4 0000000010033ce8 
0000000010033b60
[13323.500466] GPR20: 0000000000000001 0000000000000000 0000000000000000 
0000000000000000
[13323.500466] GPR24: 0000000010060848 00000000100307b0 0000000030a90b50 
0000000000000001
[13323.500466] GPR28: 0000000000000001 0000000030a902a0 0000000030a90b50 
0000000000000001
[13323.500508] NIP [00007fff92933e74] 0x7fff92933e74
[13323.500512] LR [00007fff92933e74] 0x7fff92933e74
[13323.500515] --- interrupt: 3000
[13323.500517] Code: 7d404c28 39200000 7d094bf8 7d0753f8 7d293b39 
408200cc 389b0040 38630040 48851ecd 60000000 48000084 60000000 
<0fe00000> a14d0c82 3be00000 7da96b78
[13323.500531] ---[ end trace 0000000000000000 ]---
[13323.500535] ltp_block_dev: Test Case Result: PASS


If you happen to fix this, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.

