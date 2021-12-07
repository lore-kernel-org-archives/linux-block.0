Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F4DC433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Dec 2021 10:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhLGKnj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Dec 2021 05:43:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25076 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233914AbhLGKng (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Dec 2021 05:43:36 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B79MZtm008989;
        Tue, 7 Dec 2021 10:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=zquerGDE3SGRvWzmhsR8yTYfmgZ/uepShGRHi3HPRK4=;
 b=cb5EufjNpGgtguzwy3FBjKnPZhXdP5M6dnxuymKu5Env9oFzAyjc5QC+ImGbPpFH01nu
 35wikMIPqowGl+zi/tp1rSu1Oy3959ADDR2zvJdNZPIEIH3EHH6VENSUigHZFyeqZG/L
 5AH/ixyFpdEcMFGQ+q2Vha8LiZlqv9D5lbLoexDgd7X6+3Hh3BRE+1U4z4J/BfVgCFAs
 PKNymHlL4FPxP72b4TrJXNHMBtiAOTKdU57WZMsMBXibwQDNINDA1au3rqQl0z1mhjbl
 RCMUxSJfYbaHIrCx04rQ5zGQfDnRsCZcIaCkeEaDZjCteOSR87BLswP2cso4s4o9bhvl fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ct4x61f2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 10:40:05 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B7AadEC029746;
        Tue, 7 Dec 2021 10:40:05 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ct4x61f1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 10:40:04 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B7AMP5D002227;
        Tue, 7 Dec 2021 10:40:03 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3cqyy9c9as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 10:40:03 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B7Ae0Fp29557034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Dec 2021 10:40:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7652642052;
        Tue,  7 Dec 2021 10:40:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C9D24204B;
        Tue,  7 Dec 2021 10:40:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Dec 2021 10:40:00 +0000 (GMT)
From:   Halil Pasic <pasic@linux.ibm.com>
To:     yi.zhang@redhat.com
Cc:     axboe@kernel.dk, bgoncalv@redhat.com, czhong@redhat.com,
        linux-block@vger.kernel.org, skt-results-master@redhat.com
Subject: Re: [bug report][bisected] WARNING: CPU: 4 PID: 10482 at block/mq-deadline.c:597 dd_exit_sched+0x198/0x1d0'
Date:   Tue,  7 Dec 2021 11:40:00 +0100
Message-Id: <20211207104000.1360015-1-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _23cvQUabQMGGxe_4JDfor23mK_4xn8l
X-Proofpoint-ORIG-GUID: z2Tca_D2-_bm5mliUtCbDKEntvO1kc5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_03,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112070060
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens!

What is the status of this?

I see just one fix for e0d78afeb8d1 ("block: fix too broad elevator check in
blk_mq_free_request()") which pre-dates this bug report.

We see something similar (i.e. the exact same warning) in our CI occasionally,
when the nbd module is unloaded. Unfortunately I can't trigger it reliably and
frequently enough to confirm that the problem is caused by the aforementioned
commit. All I know is that we occasionally do hit the same warning.

Thanks in advance!

Regards,
Halil 

If your interested, here are the  relevant kernel messages we observed:

[ 2697.795977] block nbd0: shutting down sockets
[ 2697.949807] ------------[ cut here ]------------
[ 2697.949816] statistics for priority 1: i 2736 m 0 d 2739 c 2735
[ 2697.949839] WARNING: CPU: 5 PID: 163229 at block/mq-deadline.c:597 dd_exit_sched+0x118/0x138
[ 2697.949849] Modules linked in: nbd(-) crc32_generic algif_hash dm_mirror dm_region_hash dm_log algif_skcipher af_alg paes_s390 dm_crypt encrypted_keys loop lcs ctcm fsm kvm binfmt_misc sunrpc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink dm_service_time dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua zfcp scsi_transport_fc mlx5_ib ib_uverbs ib_core s390_trng vfio_ccw mdev vfio_iommu_type1 zcrypt_cex4 vfio eadm_sch sch_fq_codel configfs ip_tables x_tables ghash_s390 prng chacha_s390 libchacha aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 mlx5_core sha1_s390 sha_common nvme nvme_core pkey zcrypt rng_core autofs4 [last unloaded: trace_printk]
[ 2697.949904] CPU: 5 PID: 163229 Comm: modprobe Not tainted 5.16.0-20211122.rc1.git0.b2753a24042f.300.fc34.s390x #1
[ 2697.949907] Hardware name: IBM 8561 T01 703 (LPAR)
[ 2697.949908] Krnl PSW : 0704c00180000000 00000002eac7f4f4 (dd_exit_sched+0x11c/0x138)
[ 2697.949912]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[ 2697.949915] Krnl GPRS: 00000000ffffffea 0000000200000027 0000000000000033 00000000fffeffff
[ 2697.949917]            00000002f6cfc000 0000038000000001 0000000000000ab3 0000000100000000
[ 2697.949919]            000000025d5caf48 000000025d5cae00 0000000000000001 000000025d5cae80
[ 2697.949920]            00000002b31f2100 000000025d5caf4a 00000002eac7f4f0 0000038007167af8
[ 2697.949927] Krnl Code: 00000002eac7f4e4: e310f0a00024        stg     %r1,160(%r15)
                          00000002eac7f4ea: c0e50025381f        brasl   %r14,00000002eb126528
                         #00000002eac7f4f0: af000000            mc      0,0
                         >00000002eac7f4f4: a7f4ffca            brc     15,00000002eac7f488
                          00000002eac7f4f8: b9040028            lgr     %r2,%r8
                          00000002eac7f4fc: c0e50008acda        brasl   %r14,00000002ead94eb0
                          00000002eac7f502: a7f4ffb5            brc     15,00000002eac7f46c
                          00000002eac7f506: af000000            mc      0,0
[ 2697.949941] Call Trace:
[ 2697.949943]  [<00000002eac7f4f4>] dd_exit_sched+0x11c/0x138
[ 2697.949946] ([<00000002eac7f4f0>] dd_exit_sched+0x118/0x138)
[ 2697.949948]  [<00000002eac5fddc>] blk_mq_exit_sched+0xb4/0xd8
[ 2697.949951]  [<00000002eac44e38>] __elevator_exit+0x40/0x60
[ 2697.949955]  [<00000002eac4abda>] blk_release_queue+0xc2/0x168
[ 2697.949958]  [<00000002ead7f78a>] kobject_cleanup+0x5a/0x180
[ 2697.949961]  [<00000002eac62270>] disk_release+0x70/0x90
[ 2697.949963]  [<00000002eae04b38>] device_release+0x48/0xb0
[ 2697.949968]  [<00000002ead7f78a>] kobject_cleanup+0x5a/0x180
[ 2697.949970]  [<000003ff806b724a>] nbd_dev_remove+0x3a/0x90 [nbd]
[ 2697.949976]  [<000003ff806bc1c2>] nbd_cleanup+0xda/0x120 [nbd]
[ 2697.949980]  [<00000002ea67838a>] __do_sys_delete_module+0x1a2/0x268
[ 2697.949984]  [<00000002eb1369ec>] __do_syscall+0x1d4/0x200
[ 2697.949987]  [<00000002eb143f32>] system_call+0x82/0xb0
[ 2697.949990] Last Breaking-Event-Address:
[ 2697.949991]  [<00000002eb126588>] __warn_printk+0x60/0x68
[ 2697.949996] Kernel panic - not syncing: panic_on_warn set ...

