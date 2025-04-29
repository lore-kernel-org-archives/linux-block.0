Received: from mail.189.cn (189sx01-ptr.21cn.com [14.18.100.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C2D3595D
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.18.100.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745913747; cv=none; b=TCtlCj+OnQSlGsbE++ye9yrWCk+eJGcpVGCWk21A07qeCctDqrif+hrBXN4DKrpMg1G0bS/C7JY0s4fnF0GqlgMtnKnjPHYmMpwYjyWYWB+QN3CIv5/Ag55k1n2myO8DGi3YHVdDdaZw9IgRVM3RVt9LCaJUhuKzxW6p1nZ2NJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745913747; c=relaxed/simple;
	bh=5/U9gFfps0ehR1zoPuhN16tcvhhKgjWX0kC65Ye0loE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=LQWduuHj97jbf2X5ZCcW6zt6oaZsvfHyGEpidqirMlcbxz+wyYDG36tCHrWqRHiWyrBCtPpXDlJLAzS7Zxn8T3IcuP2lzEjGAUACiXIUMAcghT9h9lKVYoA13DDjnAuZQOwl9gO00RNuk61GAdTd0LdmXfbt6ke7f3ohc/U+7IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=14.18.100.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.243.220:0.201711066
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-221.238.56.49 (unknown [10.158.243.220])
	by mail.189.cn (HERMES) with SMTP id 9E946400089
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 15:57:16 +0800 (CST)
Received: from  ([221.238.56.49])
	by gateway-153622-dep-589669576-lvbzc with ESMTP id 1165d7e8f4df45c4a717f55f8e74983f for linux-block@vger.kernel.org;
	Tue, 29 Apr 2025 15:57:16 CST
X-Transaction-ID: 1165d7e8f4df45c4a717f55f8e74983f
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 221.238.56.49
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <46249efa-4848-4dd7-a3f4-e0fb9781b6c5@189.cn>
Date: Tue, 29 Apr 2025 15:57:15 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-block@vger.kernel.org
From: Song Chen <chensong_2000@189.cn>
Subject: a question about direct IO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear experts,

I was trying to improve the performance of loading a big file to memory, 
inspired by this patchset[1], i used direct IO to read this file to the 
CMA memory i reserved, in order to reduce the overhead of memory copy 
from page cache to its destination.

below is detail:
1, i used cma=6G in cmdline to reserve memory
2, allocate memory with "addr = dma_alloc_coherent"
3, open file with O_RIRECT
int fd = open(FILE_PATH, O_RDONLY | O_DIRECT);
4, read file
    while (copied < fsz) {
         ssize_t bytes;
         ssize_t wanted = fsz - copied;

         bytes = kernel_read(file, addr + copied, wanted, &pos);
         if (bytes <= 0) {
	    printk("%s, error , bytes:%ld, wanted:%ld, cpoied:%ld\n", 
__FUNCTION__, bytes, wanted, copied);
             return bytes;
         }

         copied += bytes;
     }

ftrace log shows every single pair of block_rq_issue and 
block_rq_complete spends 0.07s.

test-2991    0.....   119.255974: block_rq_issue:       8,0 R 1310720 () 
505083904 + 2560 0x0,0,0 [test]
test-2991    0.....   119.255974: scsi_dispatch_cmd_start: host_no=0 
channel=0 id=0 lun=0 data_sgl=20 prot_sgl=0 prot_op=0x0 driver_tag=19 
scheduler_tag=40 cmnd=(READ_10 lba=505083904 txlen=2560 protect=0 raw=28 
00 1e 1a f8 00 00 0a 00 00)
     test-2991    0d..1.   119.255977: ata_qc_issue:         [FAILED TO 
PARSE] ata_port=1 ata_dev=0 tag=19 cmd=96 dev=64 lbal=0 lbam=248 lbah=26 
nsect=152 feature=0 hob_lbal=30 hob_lbam=0 hob_lbah=0 hob_nsect=0 
hob_feature=10 ctl=0 proto=6 flags=0x0
     test-2991    0.....   119.255979: block_rq_issue:       8,0 R 
1310720 () 505086464 + 2560 0x0,0,0 [test]
     test-2991    0.....   119.255994: scsi_dispatch_cmd_start: 
host_no=0 channel=0 id=0 lun=0 data_sgl=20 prot_sgl=0 prot_op=0x0 
driver_tag=20 scheduler_tag=41 cmnd=(READ_10 lba=505086464 txlen=2560 
protect=0 raw=28 00 1e 1b 02 00 00 0a 00 00)
     test-2991    0d..1.   119.255997: ata_qc_issue:         [FAILED TO 
PARSE] ata_port=1 ata_dev=0 tag=20 cmd=96 dev=64 lbal=0 lbam=2 lbah=27 
nsect=160 feature=0 hob_lbal=30 hob_lbam=0 hob_lbah=0 hob_nsect=0 
hob_feature=10 ctl=0 proto=6 flags=0x0
     ......
   <idle>-0       4d.h2.   119.323158: ata_qc_complete_done: [FAILED TO 
PARSE] ata_port=1 ata_dev=0 tag=19 status=64 dev=0 lbal=0 lbam=0 lbah=0 
nsect=1 error=0 hob_lbal=0 hob_lbam=0 hob_lbah=0 hob_nsect=0 
hob_feature=0 ctl=0 flags=0xf
   <idle>-0       4d.h2.   119.323166: scsi_dispatch_cmd_done: host_no=0 
channel=0 id=0 lun=0 data_sgl=20 prot_sgl=0 prot_op=0x0 driver_tag=19 
scheduler_tag=40 cmnd=(READ_10 lba=505083904 txlen=2560 protect=0 raw=28 
00 1e 1a f8 00 00 0a 00 00) result=(driver=DRIVER_OK host=0x0 
message=COMMAND_COMPLETE status=0x0) sense=(key=0 asc=0 ascq=0)
   <idle>-0       4..s1.   119.323172: block_rq_complete:    8,0 R () 
505083904 + 2560 0x0,0,0 [0]

sorry for the mess, this request applies to read 2560 sectors from 
sector 505083904, it takes 119.323172 - 119.255974 = 0.067s.

however, i also used buffered IO to compare, instead of opening with 
O_DIRECT, i only open it with O_RDONLY. Turns out, it only takes 0.003 
second for each block_rq_issue and block_rq_complete pair(read 2560 
sectors from sector 505083904). below is ftrace log:

     test-3136    2.....   284.024657: block_rq_issue:       8,0 RA 
1310720 () 505083904 + 2560 0x0,0,0 [test]
     test-3136    2.....   284.024659: scsi_dispatch_cmd_start: 
host_no=0 channel=0 id=0 lun=0 data_sgl=20 prot_sgl=0 prot_op=0x0 
driver_tag=10 scheduler_tag=12 cmnd=(READ_10 lba=505083904 txlen=2560 
protect=0 raw=28 00 1e 1a f8 00 00 0a 00 00)
     test-3136    2d..1.   284.024672: ata_qc_issue:         [FAILED TO 
PARSE] ata_port=1 ata_dev=0 tag=10 cmd=96 dev=64 lbal=0 lbam=248 lbah=26 
nsect=80 feature=0 hob_lbal=30 hob_lbam=0 hob_lbah=0 hob_nsect=0 
hob_feature=10 ctl=0 proto=6 flags=0x0
   <idle>-0       4d.h2.   284.025808: ata_qc_complete_done: [FAILED TO 
PARSE] ata_port=1 ata_dev=0 tag=9 status=64 dev=0 lbal=0 lbam=0 lbah=0 
nsect=0 error=0 hob_lbal=0 hob_lbam=0 hob_lbah=0 hob_nsect=0 
hob_feature=0 ctl=0 flags=0xf
   <idle>-0       4d.h2.   284.025819: scsi_dispatch_cmd_done: host_no=0 
channel=0 id=0 lun=0 data_sgl=20 prot_sgl=0 prot_op=0x0 driver_tag=9 
scheduler_tag=11 cmnd=(READ_10 lba=505081344 txlen=2560 protect=0 raw=28 
00 1e 1a ee 00 00 0a 00 00) result=(driver=DRIVER_OK host=0x0 
message=COMMAND_COMPLETE status=0x0) sense=(key=0 asc=0 ascq=0)
   <idle>-0       4..s1.   284.025825: block_rq_complete:    8,0 RA () 
505081344 + 2560 0x0,0,0 [0]
     test-3136    2.....   284.026912: block_rq_issue:       8,0 RA 
1310720 () 505086464 + 2560 0x0,0,0 [test]
     test-3136    2.....   284.026914: scsi_dispatch_cmd_start: 
host_no=0 channel=0 id=0 lun=0 data_sgl=20 prot_sgl=0 prot_op=0x0 
driver_tag=11 scheduler_tag=13 cmnd=(READ_10 lba=505086464 txlen=2560 
protect=0 raw=28 00 1e 1b 02 00 00 0a 00 00)
     test-3136    2d..1.   284.026927: ata_qc_issue:         [FAILED TO 
PARSE] ata_port=1 ata_dev=0 tag=11 cmd=96 dev=64 lbal=0 lbam=2 lbah=27 
nsect=88 feature=0 hob_lbal=30 hob_lbam=0 hob_lbah=0 hob_nsect=0 
hob_feature=10 ctl=0 proto=6 flags=0x0
   <idle>-0       4d.h2.   284.028022: ata_qc_complete_done: [FAILED TO 
PARSE] ata_port=1 ata_dev=0 tag=10 status=64 dev=0 lbal=0 lbam=0 lbah=0 
nsect=0 error=0 hob_lbal=0 hob_lbam=0 hob_lbah=0 hob_nsect=0 
hob_feature=0 ctl=0 flags=0xf
   <idle>-0       4d.h2.   284.028033: scsi_dispatch_cmd_done: host_no=0 
channel=0 id=0 lun=0 data_sgl=20 prot_sgl=0 prot_op=0x0 driver_tag=10 
scheduler_tag=12 cmnd=(READ_10 lba=505083904 txlen=2560 protect=0 raw=28 
00 1e 1a f8 00 00 0a 00 00) result=(driver=DRIVER_OK host=0x0 
message=COMMAND_COMPLETE status=0x0) sense=(key=0 asc=0 ascq=0)
   <idle>-0       4..s1.   284.028039: block_rq_complete:    8,0 RA () 
505083904 + 2560 0x0,0,0 [0]

284.028039 - 284.024657 = 0.003382.

It seems the ssd returns data immediately but i don't know what is the 
problem of direct IO read. I would appreciate it if anyone of you gives 
me some advice about this case.

My OS is ubuntu 24.04, kernel is 6.14, from upstream no change, with 
CONFIG_CMA and CONFIG_DMA_CMA. Intel i5, 16G DDR, 500G SATA SSD(Kingston).

/Song

[1]:https://lore.kernel.org/all/20240730075755.10941-1-link@vivo.com/
