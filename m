Return-Path: <SRS0=Ij7C=UE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B617C28CC6
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 09:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF1820866
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 09:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfFEJNZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jun 2019 05:13:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727124AbfFEJNZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jun 2019 05:13:25 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5597x8o082105
        for <linux-block@vger.kernel.org>; Wed, 5 Jun 2019 05:13:24 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sx7rqy7kf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 05 Jun 2019 05:13:23 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <sebott@linux.ibm.com>;
        Wed, 5 Jun 2019 10:13:15 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Jun 2019 10:13:12 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x559DC6w46727418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jun 2019 09:13:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7B6DA4053;
        Wed,  5 Jun 2019 09:13:11 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7B50A4059;
        Wed,  5 Jun 2019 09:13:11 +0000 (GMT)
Received: from dyn-9-152-212-90.boeblingen.de.ibm.com (unknown [9.152.212.90])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Jun 2019 09:13:11 +0000 (GMT)
Date:   Wed, 5 Jun 2019 11:13:11 +0200 (CEST)
From:   Sebastian Ott <sebott@linux.ibm.com>
X-X-Sender: sebott@schleppi
To:     Christoph Hellwig <hch@lst.de>
cc:     Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: too large sg segments with commit 09324d32d2a08
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH?=
 =?ISO-8859-15?Q?_=2F_Vorsitzende_des_Aufsichtsrats=3A_Matthias?=
 =?ISO-8859-15?Q?_Hartmann_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp?=
 =?ISO-8859-15?Q?_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Reg?=
 =?ISO-8859-15?Q?istergericht=3A_Amtsgericht_Stuttgart=2C_HRB_2432?=
 =?ISO-8859-15?Q?94=22?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
x-cbid: 19060509-0012-0000-0000-000003241CA7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060509-0013-0000-0000-0000215CFF39
Message-Id: <alpine.LFD.2.21.1906051057200.2118@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906050058
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

this warning turned up on s390:

[    7.041512] ------------[ cut here ]------------
[    7.041518] DMA-API: nvme 0000:00:00.0: mapping sg segment longer than device claims to support [len=106496] [max=65536]
[    7.041531] WARNING: CPU: 1 PID: 229 at kernel/dma/debug.c:1233 debug_dma_map_sg+0x21e/0x350
[    7.041537] Modules linked in: scm_block(+) eadm_sch sch_fq_codel autofs4
[    7.041547] CPU: 1 PID: 229 Comm: systemd-udevd Not tainted 5.2.0-rc3-00002-g112d38aa4733-dirty #146
[    7.041552] Hardware name: IBM 3906 M03 703 (LPAR)
[    7.041558] Krnl PSW : 0704d00180000000 00000000af580b6e (debug_dma_map_sg+0x21e/0x350)
[    7.041566]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
[    7.041572] Krnl GPRS: 0000000095969122 0000000080000000 000000000000006c 00000000af5624bc
[    7.041578]            0000000000000007 0000000000000001 0000000000010000 0000000000000001
[    7.041583]            00000000b081d278 00000000fea06888 000000008fa43400 00000000f255b418
[    7.041589]            00000000f4a28100 ffffffff00000000 00000000af580b6a 000003e0004a36e0
[    7.041599] Krnl Code: 00000000af580b5e: c02000566fd7	larl	%r2,b004eb0c
                          00000000af580b64: c0e5fffad1fe	brasl	%r14,af4daf60
                         #00000000af580b6a: a7f40001		brc	15,af580b6c
                         >00000000af580b6e: c010005f45f5	larl	%r1,b0169758
                          00000000af580b74: e31010000012	lt	%r1,0(%r1)
                          00000000af580b7a: a774000f		brc	7,af580b98
                          00000000af580b7e: c010005fac23	larl	%r1,b01763c4
                          00000000af580b84: e31010000012	lt	%r1,0(%r1)
[    7.041620] Call Trace:
[    7.041626] ([<00000000af580b6a>] debug_dma_map_sg+0x21a/0x350)
[    7.041633]  [<00000000afbe2152>] nvme_queue_rq+0x49a/0xd18 
[    7.041639]  [<00000000afa178d0>] __blk_mq_try_issue_directly+0x108/0x1f0 
[    7.041645]  [<00000000afa18e96>] blk_mq_request_issue_directly+0x4e/0x70 
[    7.041651]  [<00000000afa18f42>] blk_mq_try_issue_list_directly+0x8a/0x118 
[    7.041657]  [<00000000afa1e42e>] blk_mq_sched_insert_requests+0x1c6/0x350 
[    7.041663]  [<00000000afa18e40>] blk_mq_flush_plug_list+0x4f8/0x500 
[    7.041669]  [<00000000afa0bb3e>] blk_flush_plug_list+0x106/0x110 
[    7.041674]  [<00000000afa0bb7c>] blk_finish_plug+0x34/0x50 
[    7.041680]  [<00000000af6938c2>] read_pages+0x152/0x160 
[    7.041687]  [<00000000af693b06>] __do_page_cache_readahead+0x236/0x268 
[    7.041693]  [<00000000af694458>] force_page_cache_readahead+0x110/0x120 
[    7.041699]  [<00000000af683fa4>] generic_file_buffered_read+0x144/0x968 
[    7.041706]  [<00000000af74d14c>] new_sync_read+0x13c/0x1b8 
[    7.041712]  [<00000000af74f9fa>] vfs_read+0x82/0x138 
[    7.041717]  [<00000000af74fd92>] ksys_read+0x62/0xd8 
[    7.041724]  [<00000000afe60e00>] system_call+0x2b0/0x2d0 
[    7.041729] 1 lock held by systemd-udevd/229:
[    7.041734]  #0: 00000000f715c4f3 (rcu_read_lock){....}, at: hctx_lock+0x28/0xf8
[    7.041743] Last Breaking-Event-Address:
[    7.041749]  [<00000000af580b6a>] debug_dma_map_sg+0x21a/0x350
[    7.041754] irq event stamp: 14457
[    7.041760] hardirqs last  enabled at (14465): [<00000000af560a2c>] console_unlock+0x63c/0x6a8
[    7.041766] hardirqs last disabled at (14472): [<00000000af5604ba>] console_unlock+0xca/0x6a8
[    7.041773] softirqs last  enabled at (11488): [<00000000afa20ed4>] get_gendisk+0xf4/0x148
[    7.041779] softirqs last disabled at (11486): [<00000000afa20e48>] get_gendisk+0x68/0x148
[    7.041784] ---[ end trace 9142fc6f63a22c6e ]---

The length of the sg entry created by blk_rq_map_sg is indeed largen than
the dma max_segment_size.

Bisect points to 09324d32d2a0 ("block: force an unlimited segment size on queues with a virt boundary")

Regards,
Sebastian

