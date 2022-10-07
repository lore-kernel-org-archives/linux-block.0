Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD027C433F5
	for <linux-block@archiver.kernel.org>; Fri,  7 Oct 2022 06:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJGGbM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Oct 2022 02:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJGGbL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Oct 2022 02:31:11 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794F6C2C8B
        for <linux-block@vger.kernel.org>; Thu,  6 Oct 2022 23:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mK2+hS3BWN/cZgaVBfrAEUoTFEtGmpalF/0rduvD8zMvfynwactj3guMzTAkq9FiHSqszvg+FKwpAr6+AEjmPIKQCzwukrp75KL+Oyhy82I0e0fzQJP8vbxr/WVDSa6PGFDSXuW2JEsE4J/2cc3LbevZfPdzVZtYGbAjXPFaIsxwg6B5y5VKDnMEB0ZDUFqhoY02bfhQ0I9NM/m59Q+nPwqFIlBkL32R8jUWS0gV+uQcgZsu1T6dajYhADt1cSX4axxohwvPZuSwtV8ZhwBwDbNktZljOFSptCOnd3/a8kjAEhabVJsPRwMCVSolYKJuo4mExc1/Kz8yvWii8UAOOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgF4WyYGJOySiObmdRTsCeN5txDkcyZIfzF92NxRAOQ=;
 b=MrmbtlvzgKIPBW5VlQjbmi2TQpd67JbW37hJ0Z/H8OE8zj+rGO7F4041hzJrRJzDG8PtM92jDp+mqZFG8IlMQ3nTnh9lV4GRaWMQcQnw7NjQr2Pw9Dr3Bf/W7SEXrYg7HC/B65aPf5moafO3gYVdl6Vu76KqVtgQGx7SY2luj+VQfahmfj/eyjESleKOMQuKNb3IqjCMgNcdQKTeT/2VoQIzKeTMQTHyOtkwFPrmpFVX8hbkUUcjIPTuFAeVBaLmKW1djbViqD09aeOQh6oNjdrVJSEp15RDxzEzdm3GzCoSo/xzAZf9J7trbB++BjLu0DaiYCsFbT4f0Tt3q9suvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgF4WyYGJOySiObmdRTsCeN5txDkcyZIfzF92NxRAOQ=;
 b=r2wx4P2j+iHIulu4oE7aCjSztKOBXHMF8v/o2KB0JS40g9hVj9gpzIQtr+7I23YXdBOLAtgyj8BtapDS7AVXnygpuHKcgfrW6VRAuBK4arxe0wfZXTiE1NUQjHf+58NmR/8mDJ6Dx7DWQMZUbMx1VsjbNW59AhorJf+meecSp0mhdbb/53VNAp/GPVthxGyYdcjvq4DrjevdO903votUtCVQZUNaiAXW2QMf9Q2tPANw95KV9odj+n/MSxxoftO6nLj3PA+eP0RGIuQG5Y1YrgvgHRONoObj8vwmIi3W2VRhrdttp5YRs+l6nzEVFNruZavl0CbXzBJVgCaMf/464w==
Received: from BN9PR03CA0882.namprd03.prod.outlook.com (2603:10b6:408:13c::17)
 by DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Fri, 7 Oct
 2022 06:31:06 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::9) by BN9PR03CA0882.outlook.office365.com
 (2603:10b6:408:13c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Fri, 7 Oct 2022 06:31:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 06:31:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 6 Oct 2022
 23:30:52 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 6 Oct 2022
 23:30:51 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH 0/6] null_blk: add modparam vefication
Date:   Thu, 6 Oct 2022 23:30:30 -0700
Message-ID: <20221007063036.13428-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT052:EE_|DM6PR12MB4578:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f265db-2a6f-4631-79bc-08daa82d8358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: df29KNB0kWg84XMkTWpLJPCQ8lTv/OxR1YbYCdeWEOc4CRSYOkQ5qtwKxTn6AOv9m8CXfwwtIcyAuwO1ctOp9O0xDgx+wp2gXhB2b7XvA85ExKYJMEUAJ9NB3eGXpC43RuruOV3aqZE1LETgnkNnHRJAswQlbCwfgmGHtc7h9JGEcA2REX9eCAVeB90Lqje5nKVyQXRFvD/Yi9iXoPRmrR2d/9ZM85FslKzqG6diTzymOKJLYU6/bonJW0LvEKCGxBz5bkilqHaFh3vuYt142QkHKAjw3DrSZw1lD9tZ1PJrhNzMFIcGSY9p/uDDrE81EWiczdW0A1AtnLadq6SLeWgHTLk8ly2tYlOdlXBgYcVdk6o932Nia9pvMUUbHh0UDNEzK6LuYN9W4V+WexYxpyKO6bcKRTRFnqH7HnSRn0ZagzM6PDWW+a4/2kDE/mTzvGbQ73eQ/PacbeWp1UALiKUxER7UZcbdeFk3sdZfDNIMLg7owVAHxelEyLLmiqZy8MN4wwd3uGzKn9oXDXt/+dIWj+qv8kO91grOnQUQ5guMbIQBsNlT1qNgPbCu7bkKNAFzkhEKZSU61CUg6g+nrwlBezPzWfiguLJR2XD5iAumjO7TknStj/1DGZUNVdN1ihnh1+hm/b7HhoqTYgInNR1f2aVgHthlpy94JF3c+3WjOxuBaVGYMNWjLN7p1fLd+78vi62QqnoogKn1gtg0dDAEGcQsAYzx+sLNzb9yekGLSNghegkoquhXNw4leELAbGfVbcupWVgn/8wLqp7EUA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(478600001)(40460700003)(356005)(7636003)(316002)(6916009)(82740400003)(7696005)(336012)(426003)(54906003)(70206006)(6666004)(4326008)(8676002)(36756003)(82310400005)(70586007)(41300700001)(1076003)(8936002)(40480700001)(26005)(2616005)(30864003)(5660300002)(36860700001)(2906002)(186003)(16526019)(83380400001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 06:31:05.4923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f265db-2a6f-4631-79bc-08daa82d8358
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4578
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Add module parameter verification make sure we are not deling with the
negative value that also fixes follwing Oops :-

linux-block (for-next) # modprobe null_blk poll_queues=-2
Entering kdb (current=0xffff88817eaed100, pid 5624) on processor 12 Oops: (null)
due to oops @ 0xffffffff8165093f
CPU: 12 PID: 5624 Comm: modprobe Tainted: G           OE      6.0.0-rc7blk+ #53
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:blk_mq_alloc_tag_set+0x14f/0x380
Code: 83 c5 01 3b 6b 40 0f 83 9a 01 00 00 48 8b 43 68 4c 63 e5 4e 8d 34 e0 f6 43 58 08 75 d7 8b 53 44 89 ee 48 89 df e8 d1 ed ff ff <49> 89 06 48 8b 43 68 4a 83 3c e0 00 75 c3 83 ed 01 78 0f 89 ee 48
RSP: 0018:ffffc90002eefd70 EFLAGS: 00010282
RAX: ffff888112b155c0 RBX: ffff88811069dc38 RCX: 0000000000000003
RDX: ffff88811069d000 RSI: ffff88810ed60000 RDI: 00000000000001f8
RBP: 0000000000000000 R08: 0000000000000003 R09: ffff888112b15650
R10: 000000000010ed60 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000040 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f71e4147b80(0000) GS:ffff888fff500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000014d81c000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 null_add_dev+0x7a7/0x870 [null_blk]
 null_init+0x1de/0x1000 [null_blk]
 ? 0xffffffffc03a9000
 do_one_initcall+0x44/0x210
 ? kmem_cache_alloc_trace+0x15b/0x2b0
 do_init_module+0x4c/0x1f0
 __do_sys_finit_module+0xb4/0x130
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f71e426e15d
Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007fffb29f27a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 0000564b29d78b90 RCX: 00007f71e426e15d
RDX: 0000000000000000 RSI: 0000564b29d78f00 RDI: 0000000000000003
RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
R10: 0000000000000003 R11: 0000000000000246 R12: 0000564b29d78f00
R13: 0000564b29d78cc0 R14: 0000564b29d78b90 R15: 0000564b29d78f20
 </TASK>

[12]kdb>

-ck

Chaitanya Kulkarni (6):
  null_blk: check for valid submit_queue value
  null_blk: check for valid poll_queue value
  null_blk: check for valid gb value
  null_blk: check for valid block size value
  null_blk: check for valid max_sectors value
  null_blk: check for valid queue depth value

 drivers/block/null_blk/main.c | 107 +++++++++++++++++++++++++++-------
 1 file changed, 85 insertions(+), 22 deletions(-)

Test Report :-

ilinux-block (for-next) # sh ./test-mod-param.sh 
###################################################
poll_queues:
------------------------------------
modprobe null_blk poll_queues=2
[ 1924.377679] null_blk: disk nullb0 created
[ 1924.377688] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4
[ 1924.677126] null_blk: disk nullb0 created
[ 1924.677131] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8
[ 1924.971561] null_blk: disk nullb0 created
[ 1924.971566] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=16
[ 1925.274443] null_blk: disk nullb0 created
[ 1925.274448] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32
[ 1925.576851] null_blk: disk nullb0 created
[ 1925.576856] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=64
[ 1925.891751] null_blk: disk nullb0 created
[ 1925.891755] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=128
[ 1926.195455] null_blk: disk nullb0 created
[ 1926.195460] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=256
[ 1926.503886] null_blk: disk nullb0 created
[ 1926.503890] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=512
[ 1926.834959] null_blk: disk nullb0 created
[ 1926.834965] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=1024
[ 1927.201886] null_blk: disk nullb0 created
[ 1927.201891] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=2048
[ 1927.616806]  nullb0: AHDI p1 p3
[ 1927.616920] nullb0: p3 size 4294949121 extends beyond EOD, truncated
[ 1927.616978] null_blk: disk nullb0 created
[ 1927.616979] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4096
[ 1928.117183] null_blk: disk nullb0 created
[ 1928.117188] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8192
[ 1928.797501] null_blk: disk nullb0 created
[ 1928.797506] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=16384
[ 1929.849149] null_blk: disk nullb0 created
[ 1929.849154] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32768
[ 1931.577964] null_blk: disk nullb0 created
[ 1931.577969] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=65536
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=131072
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=262144
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=524288
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=1048576
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=2097152
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=4194304
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=8388608
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=16777216
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=33554432
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=67108864
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=134217728
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=268435456
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=536870912
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=1073741824
modprobe: ERROR: could not insert 'null_blk': Cannot allocate memory
------------------------------------
modprobe null_blk poll_queues=2147483648
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1937.008217] null_blk: `2147483648' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=4294967296
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1937.290366] null_blk: `4294967296' invalid for parameter `poll_queues'
###################################################
submit_queues:
------------------------------------
modprobe null_blk submit_queues=2
[ 1937.585539] null_blk: disk nullb0 created
[ 1937.585544] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4
[ 1937.880302] null_blk: disk nullb0 created
[ 1937.880306] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8
[ 1938.174551] null_blk: disk nullb0 created
[ 1938.174555] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=16
[ 1938.477783] null_blk: disk nullb0 created
[ 1938.477787] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=32
[ 1938.770354] null_blk: disk nullb0 created
[ 1938.770359] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=64
[ 1939.074975] null_blk: disk nullb0 created
[ 1939.074979] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=128
[ 1939.370133] null_blk: disk nullb0 created
[ 1939.370138] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=256
[ 1939.663309] null_blk: disk nullb0 created
[ 1939.663313] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=512
[ 1939.970666] null_blk: disk nullb0 created
[ 1939.970671] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=1024
[ 1940.267200] null_blk: disk nullb0 created
[ 1940.267203] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2048
[ 1940.569051] null_blk: disk nullb0 created
[ 1940.569055] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4096
[ 1940.869073] null_blk: disk nullb0 created
[ 1940.869076] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8192
[ 1941.170419] null_blk: disk nullb0 created
[ 1941.170423] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=16384
[ 1941.473582] null_blk: disk nullb0 created
[ 1941.473586] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=32768
[ 1941.766981] null_blk: disk nullb0 created
[ 1941.766985] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=65536
[ 1942.069883] null_blk: disk nullb0 created
[ 1942.069887] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=131072
[ 1942.362132] null_blk: disk nullb0 created
[ 1942.362137] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=262144
[ 1942.661742] null_blk: disk nullb0 created
[ 1942.661747] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=524288
[ 1942.955668] null_blk: disk nullb0 created
[ 1942.955673] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=1048576
[ 1943.249454] null_blk: disk nullb0 created
[ 1943.249459] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2097152
[ 1943.550678] null_blk: disk nullb0 created
[ 1943.550683] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4194304
[ 1943.856922] null_blk: disk nullb0 created
[ 1943.856927] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8388608
[ 1944.173595] null_blk: disk nullb0 created
[ 1944.173600] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=16777216
[ 1944.472637] null_blk: disk nullb0 created
[ 1944.472641] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=33554432
[ 1944.767623] null_blk: disk nullb0 created
[ 1944.767627] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=67108864
[ 1945.073317] null_blk: disk nullb0 created
[ 1945.073321] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=134217728
[ 1945.380609] null_blk: disk nullb0 created
[ 1945.380613] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=268435456
[ 1945.677736] null_blk: disk nullb0 created
[ 1945.677740] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=536870912
[ 1945.975502] null_blk: disk nullb0 created
[ 1945.975506] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=1073741824
[ 1946.272191] null_blk: disk nullb0 created
[ 1946.272195] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2147483648
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1946.566080] null_blk: `2147483648' invalid for parameter `submit_queues'
------------------------------------
modprobe null_blk submit_queues=4294967296
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1946.847997] null_blk: `4294967296' invalid for parameter `submit_queues'
###################################################
hw_queue_depth:
------------------------------------
modprobe null_blk hw_queue_depth=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1947.127929] null_blk: `-2' invalid for parameter `hw_queue_depth'
------------------------------------
modprobe null_blk hw_queue_depth=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1947.161958] null_blk: `-1' invalid for parameter `hw_queue_depth'
------------------------------------
modprobe null_blk hw_queue_depth=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1947.192521] null_blk: `0' invalid for parameter `hw_queue_depth'
------------------------------------
modprobe null_blk hw_queue_depth=1
[ 1947.222359] null_blk: disk nullb0 created
[ 1947.222363] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=2
[ 1947.270471] null_blk: disk nullb0 created
[ 1947.270476] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=4
[ 1947.318861] null_blk: disk nullb0 created
[ 1947.318865] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=8
[ 1947.368261] null_blk: disk nullb0 created
[ 1947.368265] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=32
[ 1947.422207] null_blk: disk nullb0 created
[ 1947.422210] null_blk: module loaded
------------------------------------
modprobe null_blk hw_queue_depth=64
[ 1947.469696] null_blk: disk nullb0 created
[ 1947.469699] null_blk: module loaded
###################################################
max_sectors:
------------------------------------
modprobe null_blk max_sectors=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1947.518538] null_blk: `-2' invalid for parameter `max_sectors'
------------------------------------
modprobe null_blk max_sectors=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1947.548179] null_blk: `-1' invalid for parameter `max_sectors'
------------------------------------
modprobe null_blk max_sectors=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1947.584591] null_blk: `0' invalid for parameter `max_sectors'
------------------------------------
modprobe null_blk max_sectors=1
[ 1947.621178] blk_queue_max_hw_sectors: set to minimum 8
[ 1947.622980] null_blk: disk nullb0 created
[ 1947.622983] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=2
[ 1947.673349] blk_queue_max_hw_sectors: set to minimum 8
[ 1947.675181] null_blk: disk nullb0 created
[ 1947.675184] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=4
[ 1947.742695] blk_queue_max_hw_sectors: set to minimum 8
[ 1947.744392] null_blk: disk nullb0 created
[ 1947.744395] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=8
[ 1947.790072] null_blk: disk nullb0 created
[ 1947.790076] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=32
[ 1947.833683] null_blk: disk nullb0 created
[ 1947.833686] null_blk: module loaded
------------------------------------
modprobe null_blk max_sectors=64
[ 1947.879298] null_blk: disk nullb0 created
[ 1947.879302] null_blk: module loaded
###################################################
gb:
------------------------------------
modprobe null_blk gb=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1947.936630] null_blk: `-2' invalid for parameter `gb'
------------------------------------
modprobe null_blk gb=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1947.965811] null_blk: `-1' invalid for parameter `gb'
------------------------------------
modprobe null_blk gb=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1948.000246] null_blk: `0' invalid for parameter `gb'
------------------------------------
modprobe null_blk gb=1
[ 1948.031978] null_blk: disk nullb0 created
[ 1948.031981] null_blk: module loaded
------------------------------------
modprobe null_blk gb=2
[ 1948.076624] null_blk: disk nullb0 created
[ 1948.076628] null_blk: module loaded
------------------------------------
modprobe null_blk gb=4
[ 1948.128380] null_blk: disk nullb0 created
[ 1948.128385] null_blk: module loaded
------------------------------------
modprobe null_blk gb=8
[ 1948.189039] null_blk: disk nullb0 created
[ 1948.189043] null_blk: module loaded
------------------------------------
modprobe null_blk gb=32
[ 1948.242571] null_blk: disk nullb0 created
[ 1948.242576] null_blk: module loaded
------------------------------------
modprobe null_blk gb=64
[ 1948.288508] null_blk: disk nullb0 created
[ 1948.288512] null_blk: module loaded
###################################################
poll_queues:
------------------------------------
modprobe null_blk poll_queues=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1948.338489] null_blk: `-2' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1948.366555] null_blk: `-1' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1948.396045] null_blk: `0' invalid for parameter `poll_queues'
------------------------------------
modprobe null_blk poll_queues=1
[ 1948.431236] null_blk: disk nullb0 created
[ 1948.431240] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=2
[ 1948.483416] null_blk: disk nullb0 created
[ 1948.483420] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=4
[ 1948.531614] null_blk: disk nullb0 created
[ 1948.531617] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=8
[ 1948.579633] null_blk: disk nullb0 created
[ 1948.579638] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=32
[ 1948.628638] null_blk: disk nullb0 created
[ 1948.628643] null_blk: module loaded
------------------------------------
modprobe null_blk poll_queues=64
[ 1948.686840] null_blk: disk nullb0 created
[ 1948.686845] null_blk: module loaded
###################################################
submit_queues:
------------------------------------
modprobe null_blk submit_queues=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1948.735486] null_blk: `-2' invalid for parameter `submit_queues'
------------------------------------
modprobe null_blk submit_queues=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1948.764503] null_blk: `-1' invalid for parameter `submit_queues'
------------------------------------
modprobe null_blk submit_queues=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1948.794944] null_blk: `0' invalid for parameter `submit_queues'
------------------------------------
modprobe null_blk submit_queues=1
[ 1948.826061] null_blk: disk nullb0 created
[ 1948.826065] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=2
[ 1948.872684] null_blk: disk nullb0 created
[ 1948.872688] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=4
[ 1948.928300] null_blk: disk nullb0 created
[ 1948.928303] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=8
[ 1948.984935] null_blk: disk nullb0 created
[ 1948.984939] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=32
[ 1949.034590] null_blk: disk nullb0 created
[ 1949.034595] null_blk: module loaded
------------------------------------
modprobe null_blk submit_queues=64
[ 1949.085751] null_blk: disk nullb0 created
[ 1949.085756] null_blk: module loaded
###################################################
bs:
------------------------------------
modprobe null_blk bs=-2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1949.130053] null_blk: `-2' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=-1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1949.161179] null_blk: `-1' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=0
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1949.199904] null_blk: `0' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=1
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1949.229583] null_blk: `1' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=2
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1949.261719] null_blk: `2' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=4
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1949.292527] null_blk: `4' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=8
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1949.327845] null_blk: `8' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=32
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1949.358911] null_blk: `32' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=64
modprobe: ERROR: could not insert 'null_blk': Invalid argument
[ 1949.387419] null_blk: `64' invalid for parameter `bs'
------------------------------------
modprobe null_blk bs=512
[ 1949.417564] null_blk: disk nullb0 created
[ 1949.417567] null_blk: module loaded
------------------------------------
modprobe null_blk bs=1024
[ 1949.462782] null_blk: disk nullb0 created
[ 1949.462786] null_blk: module loaded
------------------------------------
modprobe null_blk bs=2048
[ 1949.518958] null_blk: disk nullb0 created
[ 1949.518961] null_blk: module loaded
------------------------------------
modprobe null_blk bs=4096
[ 1949.565926] null_blk: disk nullb0 created
[ 1949.565931] null_blk: module loaded
linux-block (for-next) # 

-- 
2.29.0


