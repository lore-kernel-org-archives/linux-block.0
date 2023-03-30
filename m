Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E945C761A6
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 18:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjC3SuE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjC3SuC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 14:50:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11hn2224.outbound.protection.outlook.com [52.100.173.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44253CDF5
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 11:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gO9FwSr1F16J9zQ9x4h50Sr0s8j5crm2Hg3ee9OgYAJzRub1vGXzRrzvXUHlULtidw/rArrwpfBaYLCa72N8JxoW2eyqKAmXSpp08R7ET0bXGh6IN/Vuu/wEC4qZdeVdMkiDIgOb5HeWiB1sCVl5JZl+9HtWCQdTW/3Vhe1o/GmHDAwZm1co5BlMYrNzXnUoRm6wUi7f/OiXOZpW5CaAxbQ6zuPas2QZOtHWqGd9DXdksMkUOnO7c7Cml3yZK05SAMMZDEdQcUk/aMFpkqxYu5nbkoDboktvMTgvhcu2o1KtP96HM6x6bPEsfQ8/V5lfKpXPOFJ2CboiDRbKkYzOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGeXClZknw5J3HvjmKeEb1ThiknHYgwdXc7JGNh/yOk=;
 b=PnKlfjQyS0GH0ECLoL6Ydm/CO6HlbwEb3s3NGJUWrymx02mHj28Lhx0SNH+czZQx7wizMfPE9sp+la3PE3q3pYGgmQsz7pw/nlBUEdTGMnDNc7oxfY5WmyjVxFR0corcsdWA5xWptGxFm/KiLrqTRh2cG/trtoseVCvmH/CUzX54/0vvq14kpon9aNMHhxReTbpjptIXyRTGCaNIr7pT8GLFtJZqNDr9P5D1ScHvJUJXuqTVMYAVMCBv0nFJCpG0dJHgD9owAOr9oDuIj7TVr1D/kDF0EAg3FmIhDzpZZQfPucdow3gsAV8warm8NqQD7b7vvUIQdnuIXWOFKGnH2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGeXClZknw5J3HvjmKeEb1ThiknHYgwdXc7JGNh/yOk=;
 b=s9GRQvCZ4aundPuWEFG8y1F6By2lSFVt1P3Vlw5ae2ykUfI2i5/dR7OGhSWGciA5owyDhyZIIDV1bN1KZ0n4COlO+1ReL/oGvmOvNGjcLtJH2pDK0zW3xKJ8zuAZVXGCSurZ8uje8bDY3yRsW2qQtOkFEWhmolNxZv1ZqTMlfo+2Vvr7UzauUoU3uWp3x5IAzCA0CEqyxNT3mRWstMqKkCaw+kDjxIy+OI2iVXebKoDIwr8s3h3ziKVrpyWGN4oM2e824g9SrQNSXhbSE9YAVBuhnhRwhOl84eLoiXlpTjVKkthWGLKuX+iwFbDNVy41CoJqSXWD2hrJCPjEt7HNzQ==
Received: from BN9PR03CA0041.namprd03.prod.outlook.com (2603:10b6:408:fb::16)
 by DS0PR12MB7897.namprd12.prod.outlook.com (2603:10b6:8:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 18:49:56 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::cf) by BN9PR03CA0041.outlook.office365.com
 (2603:10b6:408:fb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 18:49:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 18:49:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 11:49:40 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 30 Mar
 2023 11:49:39 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <johannes.thumshirn@wdc.com>, <bvanassche@acm.org>,
        <kbusch@kernel.org>, <vincent.fu@samsung.com>,
        <shinichiro.kawasaki@wdc.com>, <error27@gmail.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 0/2] null_blk: usr memcpy_[to|from]_page()
Date:   Thu, 30 Mar 2023 11:49:24 -0700
Message-ID: <20230330184926.64209-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT085:EE_|DS0PR12MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 86983150-1d9e-44ab-7df5-08db314f8e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZ1BsqvC30pQ+NE4zhhzccaCoQIFO9AdhrqD5HnhWxFqnAY0xf56NaIuIxSvAj8fz09EptPdnawnueQDWHFyy69OSCgtGPgTGTfxBBRUKI1ldq0/GXzWP3vRbN8drf41pbsPVaFgs2o4jIlnw2UMgwGfXyHpc5o6hKuD/j2ZixSFnCCsoTne9mLm47jYXX/ipdfDKOeRmkwF1ho2qkrAd2LehtEDmZXhFWzb+8kxrCjg7s7+fh8Jg3jwZ2+Ga2YDO3yeaUVFj845mnjTF8Z/E0u/5ogRxSCSxY2dMOMi/4Jd+12dFQDuohJhLBJkayMuYOIAbYaUaRin2ikzemEl0wabow0KRBWuaOI3/Opi72ThK5JXFkWR5phj28nxXH2r6mAvbUQquiTmm1/snvnuL4TvRNmViBDklQ33snqVlPhp04wCdaXxW39Z/xwaRNtUq5PUHG+olZhdj8I9t3sqEHXoOCq3mxiJ9P6Pvqr5IMbq1z+JbeVXMx6D+NfJWzqz9dvylUa6Z978RyWgZ7fMmWyLDObeN7H4ovWy+BiLqYS8DFfvVci/SdlqAg4G1QRvk9Bd8i5HGWapa0N6PROi8SEKhm9FEYZUtxIgbUc4jzKUCx2fsmQ7kL+Vcmecwqce1Ax6TQYSuWRc8fzrYBwA+Do55Ff101jItMTcxgiPifHeb+lexSIg8m/T1bpk6ckMjcwGZ6kkeNI1YOpjdBFtQilnzwYUTfatmclXiVQtm41FFtt+RHH3T5ZAP8xrtS4DOhIax14BDt67DzX+0e2XrvL95NJAwsiCtsG7j34O3rGhBz0NA2aS+5qOdrC/F140x709sz1y4DtseH0PuarI1FS5c2VE/Rje/DnwtOC44jM=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(5400799015)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(316002)(40460700003)(70206006)(34020700004)(54906003)(70586007)(36860700001)(5660300002)(82740400003)(8676002)(7636003)(186003)(356005)(8936002)(41300700001)(16526019)(6666004)(83380400001)(1076003)(426003)(336012)(47076005)(478600001)(2616005)(4326008)(6916009)(107886003)(7696005)(26005)(82310400005)(2906002)(30864003)(36756003)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 18:49:56.0253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86983150-1d9e-44ab-7df5-08db314f8e47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7897
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

From :include/linux/highmem.h:
"kmap_atomic - Atomically map a page for temporary usage - Deprecated!"

Use memcpy_from_page() since does the same job of mapping, copying, and
unmaping except it uses non deprecated kmap_local_page() and
kunmap_local(). Following are the differences between kmal_local_page()
and kmap_atomic() :-

* creates local mapping per thread, local to CPU & not globally visible
* allows to be called from any context
* allows task preemption 

Below is the test for the fio verification job and perf numbers on nullb
along with the test log with debug patch to cover all the calls that are
modified in this series:-
copy_to_nullb()
	memcpy_to_page()
copy_from_nullb()
	memcpy_to_page()
	zero_user()
null_fill_pattern()
	memset_page()
null_flush_cache_page()
	kmap_local_page()
	kunmap_local_page()

* Avg IOPs delta (higher is better) :- ~5k higher with this patch seires
default-nullb.1.fio:           read: IOPS=1050k, BW=4101MiB/s (4300MB/s)(240GiB/60001msec)
default-nullb.2.fio:           read: IOPS=1049k, BW=4096MiB/s (4295MB/s)(240GiB/60001msec)
default-nullb.3.fio:           read: IOPS=1051k, BW=4105MiB/s (4304MB/s)(241GiB/60001msec)
(1050+1049+1051)/3 = 1050

with-memcpy-page-nullb.1.fio:  read: IOPS=1057k, BW=4129MiB/s (4330MB/s)(242GiB/60001msec)
with-memcpy-page-nullb.2.fio:  read: IOPS=1057k, BW=4127MiB/s (4328MB/s)(242GiB/60001msec)
with-memcpy-page-nullb.3.fio:  read: IOPS=1053k, BW=4114MiB/s (4314MB/s)(241GiB/60002msec)
(1057+1057+1053)/3 = 1055

In case someone shows up with performance regression on the arch that
I've don't have access to we can decide then if we want to drop it this
series or keep using deprecated kernel API, but I think removing
deprecated API is useful in long term in anyway.

-ck

v1->v2:

* Consolidate patch 1-3 in a single patch.
* Rebase/retest.

Chaitanya Kulkarni (2):
  null_blk: use non-deprecated lib functions
  null_blk: use kmap_local_page() and kunmap_local()

 drivers/block/null_blk/main.c | 37 +++++++++++------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

linux-block (null-memcpy-page) # ./compile_nullb.sh 
+ umount /mnt/nullb0
umount: /mnt/nullb0: not mounted.
+ rmdir config/nullb/nullb0
+ dmesg -c
+ modprobe -r null_blk
+ lsmod
+ grep null_blk
++ nproc
+ make -j 48 M=drivers/block modules
+ HOST=drivers/block/null_blk/
++ uname -r
+ HOST_DEST=/lib/modules/6.3.0-rc1lblk+/kernel/drivers/block/null_blk/
+ cp drivers/block/null_blk//null_blk.ko /lib/modules/6.3.0-rc1lblk+/kernel/drivers/block/null_blk//
+ ls -lrth /lib/modules/6.3.0-rc1lblk+/kernel/drivers/block/null_blk//null_blk.ko
-rw-r--r--. 1 root root 1.1M Mar 29 23:04 /lib/modules/6.3.0-rc1lblk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ dmesg -c
linux-block (null-memcpy-page) # modprobe  -r null_blk 
linux-block (null-memcpy-page) # modprobe null_blk gb=1 memory_backed=1 zoned=1
linux-block (null-memcpy-page) # dd if=/dev/nullb0 of=/dev/null bs=4k count=1
1+0 records in
1+0 records out
4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000217633 s, 18.8 MB/s
linux-block (null-memcpy-page) # blkzone report /dev/nullb0
  start: 0x000000000, len 0x080000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x080000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x080000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x080000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
linux-block (null-memcpy-page) # dd if=/dev/nullb0 of=/dev/null count=10 bs=4k
10+0 records in
10+0 records out
40960 bytes (41 kB, 40 KiB) copied, 0.000409999 s, 99.9 MB/s
linux-block (null-memcpy-page) # dd if=/dev/zero of=/dev/nullb0 count=1 bs=4k oflag=direct
1+0 records in
1+0 records out
4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000240897 s, 17.0 MB/s
linux-block (null-memcpy-page) # dd if=/dev/nullb0 of=/dev/null count=1 bs=4k
1+0 records in
1+0 records out
4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000291694 s, 14.0 MB/s
linux-block (null-memcpy-page) # dmesg  -c  
[30856.801950] blk_queue_max_hw_sectors: set to minimum 8
[30856.803437] null_blk: nullb_fill_pattern 1175 memset_page()
[30856.803484] null_blk: nullb_fill_pattern 1175 memset_page()
[30856.803514] null_blk: disk nullb0 created
[30856.803516] null_blk: module loaded
[30860.129178] null_blk: nullb_fill_pattern 1175 memset_page()
[30860.129194] null_blk: nullb_fill_pattern 1175 memset_page()
[30860.129197] null_blk: nullb_fill_pattern 1175 memset_page()
[30860.129199] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063243] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063258] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063261] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063264] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063324] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063330] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063333] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063338] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063340] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063342] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063346] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063349] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063394] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063399] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063401] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063405] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063408] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063413] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063415] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063419] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063421] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063426] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063428] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063444] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063447] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063448] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063453] null_blk: nullb_fill_pattern 1175 memset_page()
[30869.063455] null_blk: nullb_fill_pattern 1175 memset_page()
[30874.238091] null_blk: copy_to_nullb 1129 memcpy_page()
[30874.238099] null_blk: copy_to_nullb 1129 memcpy_page()
[30874.238101] null_blk: copy_to_nullb 1129 memcpy_page()
[30874.238102] null_blk: copy_to_nullb 1129 memcpy_page()
[30874.238103] null_blk: copy_to_nullb 1129 memcpy_page()
[30874.238104] null_blk: copy_to_nullb 1129 memcpy_page()
[30874.238105] null_blk: copy_to_nullb 1129 memcpy_page()
[30874.238106] null_blk: copy_to_nullb 1129 memcpy_page()
[30877.398604] null_blk: nullb_fill_pattern 1175 memset_page()
[30877.398619] null_blk: nullb_fill_pattern 1175 memset_page()
[30877.398622] null_blk: nullb_fill_pattern 1175 memset_page()
[30877.398626] null_blk: copy_from_nullb 1160 memcpy_page()
[30877.398627] null_blk: copy_from_nullb 1160 memcpy_page()
[30877.398628] null_blk: copy_from_nullb 1160 memcpy_page()
[30877.398629] null_blk: copy_from_nullb 1160 memcpy_page()
[30877.398630] null_blk: copy_from_nullb 1160 memcpy_page()
[30877.398631] null_blk: copy_from_nullb 1160 memcpy_page()
[30877.398632] null_blk: copy_from_nullb 1160 memcpy_page()
[30877.398633] null_blk: copy_from_nullb 1160 memcpy_page()
linux-block (null-memcpy-page) # modprobe  -r null_blk
linux-block (null-memcpy-page) # modprobe null_blk gb=1 memory_backed=1 cache_size=1
linux-block (null-memcpy-page) # dd if=/dev/nullb0 of=/dev/null bs=4k count=1 
1+0 records in
1+0 records out
4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000258311 s, 15.9 MB/s
linux-block (null-memcpy-page) # dd if=/dev/nullb0 of=/dev/null bs=4k count=1 
1+0 records in
1+0 records out
4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000250157 s, 16.4 MB/s
linux-block (null-memcpy-page) # modprobe  -r null_blk
linux-block (null-memcpy-page) # dmesg  -c  
[30891.505589] blk_queue_max_hw_sectors: set to minimum 8
[30891.506898] null_blk: copy_from_nullb 1163 zero_user()
[30891.506901] null_blk: copy_from_nullb 1163 zero_user()
[30891.506901] null_blk: copy_from_nullb 1163 zero_user()
[30891.506902] null_blk: copy_from_nullb 1163 zero_user()
[30891.506903] null_blk: copy_from_nullb 1163 zero_user()
[30891.506903] null_blk: copy_from_nullb 1163 zero_user()
[30891.506904] null_blk: copy_from_nullb 1163 zero_user()
[30891.506904] null_blk: copy_from_nullb 1163 zero_user()
[30891.506914] null_blk: copy_from_nullb 1163 zero_user()
[30891.506914] null_blk: copy_from_nullb 1163 zero_user()
[30891.506915] null_blk: copy_from_nullb 1163 zero_user()
[30891.506915] null_blk: copy_from_nullb 1163 zero_user()
[30891.506916] null_blk: copy_from_nullb 1163 zero_user()
[30891.506916] null_blk: copy_from_nullb 1163 zero_user()
[30891.506917] null_blk: copy_from_nullb 1163 zero_user()
[30891.506917] null_blk: copy_from_nullb 1163 zero_user()
[30891.506936] null_blk: disk nullb0 created
[30891.506937] null_blk: module loaded
[30894.734835] null_blk: copy_from_nullb 1163 zero_user()
[30894.734843] null_blk: copy_from_nullb 1163 zero_user()
[30894.734845] null_blk: copy_from_nullb 1163 zero_user()
[30894.734854] null_blk: copy_from_nullb 1163 zero_user()
[30897.718799] null_blk: copy_from_nullb 1163 zero_user()
[30897.718800] null_blk: copy_from_nullb 1163 zero_user()
[30897.718801] null_blk: copy_from_nullb 1163 zero_user()
[30897.718802] null_blk: copy_from_nullb 1163 zero_user()
[30897.718803] null_blk: copy_from_nullb 1163 zero_user()
[30897.718804] null_blk: copy_from_nullb 1163 zero_user()
[30897.718806] null_blk: copy_from_nullb 1163 zero_user()
linux-block (null-memcpy-page) # 
linux-block (null-memcpy-page) # 
linux-block (null-memcpy-page) # 
linux-block (null-memcpy-page) # modprobe null_blk gb=1 cache_size=1 memory_backed=1
linux-block (null-memcpy-page) # dd if=/dev/zero of=/dev/nullb0 count=$((2*1024*1024/4096)) bs=4k
512+0 records in
512+0 records out
2097152 bytes (2.1 MB, 2.0 MiB) copied, 0.00729801 s, 287 MB/s
linux-block (null-memcpy-page) # dmesg  -c
[30915.665977] blk_queue_max_hw_sectors: set to minimum 8
[30915.667332] null_blk: copy_from_nullb 1163 zero_user()
[30915.667334] null_blk: copy_from_nullb 1163 zero_user()
[30915.667335] null_blk: copy_from_nullb 1163 zero_user()
[30915.667336] null_blk: copy_from_nullb 1163 zero_user()
[30915.667336] null_blk: copy_from_nullb 1163 zero_user()
[30915.667337] null_blk: copy_from_nullb 1163 zero_user()
[30915.667337] null_blk: copy_from_nullb 1163 zero_user()
[30915.667338] null_blk: copy_from_nullb 1163 zero_user()
[30915.667347] null_blk: copy_from_nullb 1163 zero_user()
[30915.667347] null_blk: copy_from_nullb 1163 zero_user()
[30915.667348] null_blk: copy_from_nullb 1163 zero_user()
[30915.667348] null_blk: copy_from_nullb 1163 zero_user()
[30915.667349] null_blk: copy_from_nullb 1163 zero_user()
[30915.667349] null_blk: copy_from_nullb 1163 zero_user()
[30915.667350] null_blk: copy_from_nullb 1163 zero_user()
[30915.667350] null_blk: copy_from_nullb 1163 zero_user()
[30915.667372] null_blk: disk nullb0 created
[30915.667373] null_blk: module loaded
[30919.905781] null_blk: copy_to_nullb 1129 memcpy_page()
[30919.905786] null_blk: copy_to_nullb 1129 memcpy_page()
[30919.905788] null_blk: copy_to_nullb 1129 memcpy_page()
[30919.905788] null_blk: copy_to_nullb 1129 memcpy_page()
[30919.905793] null_blk: copy_to_nullb 1129 memcpy_page()
[30919.905794] null_blk: copy_to_nullb 1129 memcpy_page()
[30919.911028] null_blk: null_flush_cache_page 1033 kmap_local_page()
[30919.911030] null_blk: null_flush_cache_page 1033 kmap_local_page()
[30919.911032] null_blk: null_flush_cache_page 1033 kmap_local_page()
[30919.911033] null_blk: null_flush_cache_page 1033 kmap_local_page()
[30919.911035] null_blk: null_flush_cache_page 1033 kmap_local_page()
[30919.911039] null_blk: null_flush_cache_page 1033 kmap_local_page()
[30919.911040] null_blk: null_flush_cache_page 1033 kmap_local_page()
[30919.911042] null_blk: null_flush_cache_page 1033 kmap_local_page()
[30919.911043] null_blk: null_flush_cache_page 1033 kmap_local_page()
[30919.911044] null_blk: null_flush_cache_page 1033 kmap_local_page()
[30919.911046] null_blk: null_flush_cache_page 1033 kmap_local_page()
[30919.911047] null_blk: null_flush_cache_page 1033 kmap_local_page()
[30919.911050] null_blk: null_flush_cache_page 1033 kmap_local_page()
[30919.911051] null_blk: null_flush_cache_page 1033 kmap_local_page()
[30919.911052] null_blk: null_flush_cache_page 1033 kmap_local_page()
[30919.911054] null_blk: null_flush_cache_page 1033 kmap_local_page()
[30919.911055] null_blk: copy_to_nullb 1129 memcpy_page()
[30919.911056] null_blk: copy_to_nullb 1129 memcpy_page()
[30919.911057] null_blk: copy_to_nullb 1129 memcpy_page()
[30919.911058] null_blk: copy_to_nullb 1129 memcpy_page()
[30919.911058] null_blk: copy_to_nullb 1129 memcpy_page()
[30919.911059] null_blk: copy_to_nullb 1129 memcpy_page()
[30919.911060] null_blk: copy_to_nullb 1129 memcpy_page()
[30919.911062] null_blk: copy_to_nullb 1129 memcpy_page()
[30919.911063] null_blk: copy_to_nullb 1129 memcpy_page()
[30919.911063] null_blk: copy_to_nullb 1129 memcpy_page()
[30919.911064] null_blk: copy_to_nullb 1129 memcpy_page()
[30919.911065] null_blk: copy_to_nullb 1129 memcpy_page()
[30919.911066] null_blk: copy_to_nullb 1129 memcpy_page()
[30919.911066] null_blk: copy_to_nullb 1129 memcpy_page()
[30919.911067] null_blk: copy_to_nullb 1129 memcpy_page()
linux-block (null-memcpy-page) # modprobe -r null_blk
linux-block (null-memcpy-page) # odprobe null_blk gb=1 memory_backed=1 zoned=1
bash: odprobe: command not found...
linux-block (null-memcpy-page) # modprobe null_blk gb=1 memory_backed=1 zoned=1
linux-block (null-memcpy-page) # dd if=/dev/nullb0 of=/dev/null bs=4k count=1
1+0 records in
1+0 records out
4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000259513 s, 15.8 MB/s
linux-block (null-memcpy-page) # dmesg  -c
[30955.086508] blk_queue_max_hw_sectors: set to minimum 8
[30955.087986] null_blk: nullb_fill_pattern 1175 memset_page()
[30955.088030] null_blk: nullb_fill_pattern 1175 memset_page()
[30955.088061] null_blk: disk nullb0 created
[30955.088063] null_blk: module loaded
[30961.489556] null_blk: nullb_fill_pattern 1175 memset_page()
[30961.489572] null_blk: nullb_fill_pattern 1175 memset_page()
[30961.489575] null_blk: nullb_fill_pattern 1175 memset_page()
[30961.489577] null_blk: nullb_fill_pattern 1175 memset_page()
linux-block (null-memcpy-page) # dd if=/dev/zero of=/dev/nullb0 count=1 bs=4k oflag=direct
1+0 records in
1+0 records out
4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000243984 s, 16.8 MB/s
linux-block (null-memcpy-page) # dd if=/dev/nullb0 of=/dev/null count=1 bs=4k
1+0 records in
1+0 records out
4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000253021 s, 16.2 MB/s
linux-block (null-memcpy-page) # dmesg  -c
[30973.806184] null_blk: copy_to_nullb 1129 memcpy_page()
[30973.806190] null_blk: copy_to_nullb 1129 memcpy_page()
[30973.806191] null_blk: copy_to_nullb 1129 memcpy_page()
[30973.806192] null_blk: copy_to_nullb 1129 memcpy_page()
[30973.806193] null_blk: copy_to_nullb 1129 memcpy_page()
[30973.806194] null_blk: copy_to_nullb 1129 memcpy_page()
[30973.806196] null_blk: copy_to_nullb 1129 memcpy_page()
[30973.806197] null_blk: copy_to_nullb 1129 memcpy_page()
[30978.670129] null_blk: nullb_fill_pattern 1175 memset_page()
[30978.670145] null_blk: nullb_fill_pattern 1175 memset_page()
[30978.670148] null_blk: nullb_fill_pattern 1175 memset_page()
[30978.670168] null_blk: copy_from_nullb 1160 memcpy_page()
[30978.670170] null_blk: copy_from_nullb 1160 memcpy_page()
[30978.670171] null_blk: copy_from_nullb 1160 memcpy_page()
[30978.670172] null_blk: copy_from_nullb 1160 memcpy_page()
[30978.670173] null_blk: copy_from_nullb 1160 memcpy_page()
[30978.670174] null_blk: copy_from_nullb 1160 memcpy_page()
[30978.670176] null_blk: copy_from_nullb 1160 memcpy_page()
[30978.670177] null_blk: copy_from_nullb 1160 memcpy_page()
linux-block (null-memcpy-page) #  modprobe  -r null_blk
linux-block (null-memcpy-page) # modprobe null_blk gb=1 memory_backed=1 cache_size=1
linux-block (null-memcpy-page) #  dd if=/dev/nullb0 of=/dev/null bs=4k count=1
1+0 records in
1+0 records out
4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000227442 s, 18.0 MB/s
linux-block (null-memcpy-page) # dmesg  -c
[30996.959156] blk_queue_max_hw_sectors: set to minimum 8
[30996.960786] null_blk: copy_from_nullb 1163 zero_user()
[30996.960789] null_blk: copy_from_nullb 1163 zero_user()
[30996.960803] null_blk: copy_from_nullb 1163 zero_user()
[30996.960804] null_blk: copy_from_nullb 1163 zero_user()
[30996.960804] null_blk: copy_from_nullb 1163 zero_user()
[30996.960805] null_blk: copy_from_nullb 1163 zero_user()
[30996.960805] null_blk: copy_from_nullb 1163 zero_user()
[30996.960806] null_blk: copy_from_nullb 1163 zero_user()
[30996.960833] null_blk: disk nullb0 created
[30996.960834] null_blk: module loaded
[31003.136892] null_blk: copy_from_nullb 1163 zero_user()
[31003.136898] null_blk: copy_from_nullb 1163 zero_user()
[31003.136900] null_blk: copy_from_nullb 1163 zero_user()
[31003.136901] null_blk: copy_from_nullb 1163 zero_user()
[31003.136902] null_blk: copy_from_nullb 1163 zero_user()
[31003.136903] null_blk: copy_from_nullb 1163 zero_user()
[31003.136903] null_blk: copy_from_nullb 1163 zero_user()
[31003.136904] null_blk: copy_from_nullb 1163 zero_user()
linux-block (null-memcpy-page) # 

-- 
2.29.0

