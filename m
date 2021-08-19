Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1422C4338F
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 09:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B7D06109F
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 09:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbhHSJEd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Aug 2021 05:04:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52716 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236203AbhHSJEd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Aug 2021 05:04:33 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17J93o8Q034459;
        Thu, 19 Aug 2021 05:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=vERMTs42rS8bdKzKcqDcNN0jHs7MXQ8/rLNCAKq2Tso=;
 b=Pj8K8IpNgTYcsLT67mx8DmKtmQhH3I/Icje4nTMNJC7w5RZF40gsAyZCcSPsG4+4K52S
 5aCImyLpiP/dFG1YLBxh0siSGxxo8HidkxFrPZL75CT6s6JOciod89ZseOUF8JfEGziw
 75Bla1kYmxGvoaiMK1F8gc6w6gFLJ+c3JWRBxL/0UK+TbKgvBEhph3Ur9CZHaCk08Sog
 gIutq38AUIvsloaDFdmDR2Su/8XrWA7/ns33akjMIXIh+lkwvjr7ikxf7eGWv+HK2WxH
 UgPot6DCSnaZYSiXlLRnHtpCVVMZONAak/HIJDFOaD0E0wQYWaHKSBG3HU5JeTPxY9U7 eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3agcwxqdng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 05:03:52 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17J93qil034664;
        Thu, 19 Aug 2021 05:03:52 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3agcwxqdk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 05:03:52 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17J92jaJ017935;
        Thu, 19 Aug 2021 09:03:46 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3ae5f8evhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 09:03:46 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17J90Emh60948788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 09:00:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B00014C046;
        Thu, 19 Aug 2021 09:03:43 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4806F4C062;
        Thu, 19 Aug 2021 09:03:43 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 19 Aug 2021 09:03:43 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+aa0801b6b32dca9dda82@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] general protection fault in wb_timer_fn
References: <00000000000072e53a05c983ab22@google.com>
        <20210816091041.3313-1-hdanton@sina.com>
        <20210816093336.GA3950@lst.de>
Date:   Thu, 19 Aug 2021 11:03:42 +0200
In-Reply-To: <20210816093336.GA3950@lst.de> (Christoph Hellwig's message of
        "Mon, 16 Aug 2021 11:33:36 +0200")
Message-ID: <yt9dim01iz69.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aZTXg9NdExr1Hn1gPSid0zrge7_sbyNp
X-Proofpoint-ORIG-GUID: 7pvWX5WR3xL3qAdbX2jnjzZUIWDAsJ_Z
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-19_03:2021-08-17,2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1011 malwarescore=0 spamscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=509 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108190051
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> On Mon, Aug 16, 2021 at 05:10:41PM +0800, Hillf Danton wrote:
>> Remove and free all qos callbacks added, with cb->timer deleted in
>> blk_stat_remove_callback().
>> 
>> only for thoughts.
>> 
>> +++ x/block/blk-sysfs.c
>> @@ -800,9 +800,7 @@ static void blk_release_queue(struct kob
>>  
>>  	might_sleep();
>>  
>> -	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
>> -		blk_stat_remove_callback(q, q->poll_cb);
>> -	blk_stat_free_callback(q->poll_cb);
>> +	rq_qos_exit(q);
>
> rq_qos_exit is already called in blk_cleanup_queue, and the blk-mq
> pollig doesn't even use the qos framework.  So I'm not sure what this
> is supposed to help.

I'm seeing a similar crash in our CI:

[  464.072042] nbd0: detected capacity change from 0 to 2097152
[  464.092297]  nbd0: p1
[  464.244242] EXT4-fs (nbd0p1): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[  468.266306] block nbd0: NBD_DISCONNECT
[  468.266318] block nbd0: Disconnected due to user request.
[  468.266320] block nbd0: shutting down sockets
[  468.291814] Unable to handle kernel pointer dereference in virtual kernel address space
[  468.291817] Failing address: 000002aa264a7000 TEID: 000002aa264a7803
[  468.291819] Fault in home space mode while using kernel ASCE.
[  468.291822] AS:0000000159c84007 R3:0000000000000024 
[  468.291843] Oops: 003b ilc:3 [#1] SMP 
[  468.291846] Modules linked in: nbd(E-) xt_CHECKSUM(E) xt_MASQUERADE(E) xt_conntrack(E) ipt_REJECT(E) xt_tcpudp(E) nft_compat(E) nf_nat_tftp(E) nft_objref(E) nf_conntrack_tftp(E) nft_counter(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E) dm_service_time(E) nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) ip_set(E) nf_tables(E) nfnetlink(E) sunrpc(E) zfcp(E) scsi_transport_fc(E) dm_multipath(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) mlx5_ib(E) ib_uverbs(E) ib_core(E) s390_trng(E) vfio_ccw(E) mdev(E) vfio_iommu_type1(E) vfio(E) zcrypt_cex4(E) eadm_sch(E) sch_fq_codel(E) configfs(E) ip_tables(E) x_tables(E) ghash_s390(E) prng(E) aes_s390(E) des_s390(E) libdes(E) sha3_512_s390(E) sha3_256_s390(E) sha512_s390(E) sha256_s390(E) sha1_s390(E) sha_common(E) mlx5_core(E) nvme(E) nvme_core(E) pkey(E) zcrypt(E) rng_core(E) autofs4(E)
[  468.291891] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G            E     5.14.0-20210819.rc6.git0.f26c3abc432a.300.fc34.s390x+next #1
[  468.291894] Hardware name: IBM 8561 T01 703 (LPAR)
[  468.291895] Krnl PSW : 0704c00180000000 0000000158cfe3b6 (wb_timer_fn+0x56/0x538)
[  468.291902]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[  468.291905] Krnl GPRS: 0000000000000200 000002aa264a7018 0000000189fc3400 0000000000000000
[  468.291907]            fffffffffffc0000 0000000000000000 00000002f767c000 0000000158cc9420
[  468.291909]            0000000000000000 0000000189fc3410 00000001e19622a0 0000000138e9a700
[  468.291911]            0000000080378000 00000002f767c002 0000038000d43ca0 0000038000d43c40
[  468.291937] Krnl Code: 0000000158cfe3a4: e380b0280004        lg      %r8,40(%r11)
                          0000000158cfe3aa: e31010900004        lg      %r1,144(%r1)
                         #0000000158cfe3b0: e31012000004        lg      %r1,512(%r1)
                         >0000000158cfe3b6: e36010980004        lg      %r6,152(%r1)
                          0000000158cfe3bc: ec88005e007c        cgij    %r8,0,8,0000000158cfe478
                          0000000158cfe3c2: e310b0300002        ltg     %r1,48(%r11)
                          0000000158cfe3c8: a7840058            brc     8,0000000158cfe478
                          0000000158cfe3cc: c0e5ffce8822        brasl   %r14,00000001586cf410
[  468.291951] Call Trace:
[  468.291953]  [<0000000158cfe3b6>] wb_timer_fn+0x56/0x538 
[  468.291956]  [<00000001586ca980>] call_timer_fn+0x38/0x178 
[  468.291960]  [<00000001586cad58>] __run_timers.part.0+0x298/0x358 
[  468.291962]  [<00000001586cae62>] run_timer_softirq+0x4a/0x88 
[  468.291964]  [<0000000159149236>] __do_softirq+0x146/0x3c8 
[  468.291967]  [<000000015862cbaa>] irq_exit+0xf2/0x120 
[  468.291970]  [<000000015913a334>] do_ext_irq+0xd4/0x160 
[  468.291972]  [<000000015914769c>] ext_int_handler+0xdc/0x110 
[  468.291974]  [<0000000159147826>] psw_idle_exit+0x0/0xa 
[  468.291976] ([<00000001585dbfe8>] arch_cpu_idle+0x40/0xd0)
[  468.291978]  [<000000015914718a>] default_idle_call+0x42/0x108 
[  468.291980]  [<000000015866ab6a>] do_idle+0xd2/0x160 
[  468.291983]  [<000000015866adb6>] cpu_startup_entry+0x36/0x40 
[  468.291985]  [<00000001585ef74e>] smp_start_secondary+0x86/0x90 
[  468.291987] Last Breaking-Event-Address:
[  468.291989]  [<0000038000d43d30>] 0x38000d43d30
[  468.291992] Kernel panic - not syncing: Fatal exception in interrupt

The crash is likely triggered by nbd. wb_timer_fn+0x56 is block/blk-wbt.c: 237
like in the syzbot reported crash. That line was just recently touched,
so i wonder whether that's related?
