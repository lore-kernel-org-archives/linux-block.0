Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2BAC433ED
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 20:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF4E1613A9
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 20:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241819AbhDZUKS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 16:10:18 -0400
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com ([40.107.236.40]:24033
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241724AbhDZUKS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 16:10:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZH4grVg7O3Ga/mfTjUM7iSIIIC54XnWB8Yvl9rOjP0G6dDIUYL1Gvx2y7jKzYMsqq4Z5EsZ6NiQFhqNr27qFZiDU4bUoXvPyMoXgOhpbRBO42p2mSXgCCREdxayUSt7zFO9Fc9vXj73U/ZgrQ8ND8hH/4wQ2tg/bd2A2vtGmNNME9m4W2Nj2WkFYh+wRUHlEjG7oUmYJsviNzm/ElneAOn91ftj01pB+Tldxm6eL90qvljCOSmItMeJVwBJJM1ORVfz/m2wsdNvAkNsPsXEecrv8wtRV2wm+ibP96+9XkZZhXhDKceGSDKV6L5YMq/Roe7/2PjY64diP42OponFL8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVdMSq6uNlWeTx8pED8GbweStHI3o2AkSeeOpWDMm94=;
 b=h7H/Rbi4qlNLCq6LA20F5M74eKNqVUym/u9z7yJMKN9he+E4/m/O8tdbDZcsD/HBbYNM1uwdKYo/dcb+KoNLKaR3REglC/KjqTN+A9f9BxinjpYRrUx2Sl5U/NHgrLNSSfWIujEhPhJ9QbpTcjywlt8ibbh60K17mcXNx2sAkoDbwK07xD06hPHjv7fumMuTvoHz/bRYYCTDBLFIMUn0Hv2K5+gz0fJQdUTnfHf3h1rYGI/bZYhkHswdaw2/3EE9t8fLypzi8S/6xas8txkkLlPx6IJD/dA8644xlR4VwPTtcQCfgmO4DK33SjWboCOD91KXHBbOh4GgutZLdlWLTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVdMSq6uNlWeTx8pED8GbweStHI3o2AkSeeOpWDMm94=;
 b=SVK9WJNusIDmCNpLP6BYWKTBCzNizQwosA7VaE/+DfIr3PddxU1IQ/G11anIcycL8Pmk97OvGoZAlMXClnMLsISo/eNP6YylSuU9qgMdPCuUGCQ6NR8KWHit9mFeniorEl67iwm1ym+qcENGXO8t0/BvU1vPG2sDUoV21crZHjMTWVQuw+jaPuxEpHH/n71z/+llnlegw6laeEbJHE7VLgnYCqVRpZzj4Bjv7t6tSQtK243Fs7yMXkPueKykdhw3L0yRR+8QIpQziKUhxDQWxm86aIHKzLXmhGI4nd8WpGAGcUEu4A7g4cnoLdCZ1T08TeheCCkf6D7xaIa3hz1cgQ==
Received: from BN9PR11CA0027.namprd11.prod.outlook.com (2603:10b6:408:10b::25)
 by CH0PR12MB5186.namprd12.prod.outlook.com (2603:10b6:610:b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Mon, 26 Apr
 2021 20:09:34 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::1e) by BN9PR11CA0027.outlook.office365.com
 (2603:10b6:408:10b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend
 Transport; Mon, 26 Apr 2021 20:09:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Mon, 26 Apr 2021 20:09:34 +0000
Received: from [10.26.49.10] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 26 Apr
 2021 20:09:29 +0000
Subject: Re: [PATCH v8] bio: limit bio max size
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Changheun Lee <nanich.lee@samsung.com>, <bvanassche@acm.org>,
        <Johannes.Thumshirn@wdc.com>, <asml.silence@gmail.com>,
        <axboe@kernel.dk>, <damien.lemoal@wdc.com>,
        <gregkh@linuxfoundation.org>, <hch@infradead.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>, <osandov@fb.com>,
        <patchwork-bot@kernel.org>, <tj@kernel.org>,
        <tom.leiming@gmail.com>
CC:     <jisoo2146.oh@samsung.com>, <junho89.kim@samsung.com>,
        <mj0123.lee@samsung.com>, <seunghwan.hyun@samsung.com>,
        <sookwan7.kim@samsung.com>, <woosung2.lee@samsung.com>,
        <yt0928.kim@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <CGME20210421100544epcas1p13c2c86e84102f0955dd591f72e45756a@epcas1p1.samsung.com>
 <20210421094745.29660-1-nanich.lee@samsung.com>
 <cb011703-4781-fd8e-d628-3dc488e0de7d@samsung.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <3af9a177-9d4d-75b1-4df7-9a1004c275a9@nvidia.com>
Date:   Mon, 26 Apr 2021 21:09:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <cb011703-4781-fd8e-d628-3dc488e0de7d@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 453d98b0-91fd-4b95-1c6e-08d908ef35f3
X-MS-TrafficTypeDiagnostic: CH0PR12MB5186:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5186FEF8729AE4F27D79F49DD9429@CH0PR12MB5186.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ufI+yEVfmtk9kFPgF3kiFSBnx8vXltTN5E/VWJ2U3UYW4XJzjzZFvXZZf2HVI+OmxdPF1Qyu4XAouRkMUGq5NVecxDwLCf3Yo9oyG2jFC0+p1jm9arpGpcV6wPhyD3zynreJO35dvAy1v2zLvxU29XBCR0fbaqdh+iEnci+57+D3BLOJHFZaN/hxyXv1jFDOTLBKS5HW1t06EZQXc0kUzawLzbg7yBsHicg+Wszu51psw5fXFdk5ggr8Ul3N/+bwTQk1baXAnx2KjmA+KXIB0vo8++H7G3t4SFOP2yjlm4HtDsHqe4iFzJA0lHK8bo7Fuswy2x0asPP/id1UIQ8GtTdvC6B/QbnyfAGaD4ALad3iC1uiUIjGC0GZ6WQ6Wg3ILs05l0IzrSQOnt1VT/my08FvTy44IkENY0Dv72EXRR1Pg6NldML2lrDsPfvG6okbLNtQnF3oVR8hl+b5Z50ArfNQVjwLLAI0u5Fe3MRXScozRjSd1fdIpfIj2j3LyZyTzVX6qosgHlmXCaCSJ7mB7/R18/hhjL5bzvxM1+qO96t3bEh55vja0ohFwOvhX/72tkp3MiDnK58hHYEvAN6bpetnGz/Sl1a//TAs7xKn7V5WLk4/5L6t5Hki2ikrdhW1nNm8XK2luHtRxG2WgEUUulpv+NY8OfQ/pkYZf5lGj/pHibYVYB0iYAZATCHG6Lsa5hLkfzcmWivDCOahDRF9e/naNdNJtTVb+vXuWPb/x7u8Xayujx8/ktWPeLL0Imm
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966006)(36840700001)(16576012)(31686004)(82310400003)(53546011)(921005)(478600001)(356005)(186003)(8676002)(26005)(7636003)(82740400003)(47076005)(2906002)(36906005)(31696002)(16526019)(36860700001)(316002)(5660300002)(86362001)(426003)(54906003)(2616005)(45080400002)(83380400001)(8936002)(4326008)(7416002)(336012)(70586007)(70206006)(36756003)(110136005)(6666004)(83996005)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 20:09:34.2578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 453d98b0-91fd-4b95-1c6e-08d908ef35f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5186
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 26/04/2021 14:18, Marek Szyprowski wrote:

...

> This patch landed in linux-next 20210426 as commit 42fb54fbc707 ("bio: 
> limit bio max size"). Sadly it causes the following regression during 
> boot on my test systems:
> 
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address 0000023c
> pgd = (ptrval)
> [0000023c] *pgd=00000000
> Internal error: Oops: 5 [#2] SMP ARM
> Modules linked in:
> CPU: 0 PID: 186 Comm: systemd-udevd Tainted: G      D 
> 5.12.0-next-20210426 #3045
> Hardware name: Generic DT based system
> PC is at bio_add_hw_page+0x58/0x1fc
> LR is at bio_add_pc_page+0x40/0x5c
> pc : [<c06c5bf0>]    lr : [<c06c5dd4>]    psr: 20000013
> sp : c3cc7de0  ip : ffffffff  fp : 00000000
> r10: 00000cc0  r9 : c20b2000  r8 : c21b5680
> r7 : dbc51b80  r6 : c30d0540  r5 : 00000014  r4 : c21b5680
> r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : c30d0540
> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 43ccc06a  DAC: 00000051
> Register r0 information: slab request_queue start c30d0540 pointer offset 0
> Register r1 information: NULL pointer
> Register r2 information: NULL pointer
> Register r3 information: NULL pointer
> Register r4 information: slab kmalloc-128 start c21b5680 pointer offset 
> 0 size 128
> Register r5 information: non-paged memory
> Register r6 information: slab request_queue start c30d0540 pointer offset 0
> Register r7 information: non-slab/vmalloc memory
> Register r8 information: slab kmalloc-128 start c21b5680 pointer offset 
> 0 size 128
> Register r9 information: slab kmalloc-4k start c20b2000 pointer offset 0 
> size 4096
> Register r10 information: non-paged memory
> Register r11 information: NULL pointer
> Register r12 information: non-paged memory
> Process systemd-udevd (pid: 186, stack limit = 0x(ptrval))
> Stack: (0xc3cc7de0 to 0xc3cc8000)
> ...
> [<c06c5bf0>] (bio_add_hw_page) from [<c06c5dd4>] (bio_add_pc_page+0x40/0x5c)
> [<c06c5dd4>] (bio_add_pc_page) from [<c06cf0ac>] 
> (blk_rq_map_kern+0x234/0x304)
> [<c06cf0ac>] (blk_rq_map_kern) from [<c0a54634>] (serial_show+0x64/0xd4)
> [<c0a54634>] (serial_show) from [<c0a228ac>] (dev_attr_show+0x18/0x48)
> [<c0a228ac>] (dev_attr_show) from [<c054721c>] (sysfs_kf_seq_show+0x88/0xf4)
> [<c054721c>] (sysfs_kf_seq_show) from [<c04d7a44>] 
> (seq_read_iter+0x10c/0x4bc)
> [<c04d7a44>] (seq_read_iter) from [<c04adf60>] (vfs_read+0x1d4/0x2e0)
> [<c04adf60>] (vfs_read) from [<c04ae47c>] (ksys_read+0x5c/0xd0)
> [<c04ae47c>] (ksys_read) from [<c03000c0>] (ret_fast_syscall+0x0/0x58)
> Exception stack(0xc3cc7fa8 to 0xc3cc7ff0)
> ...
> Code: e1520003 9a000021 e5942004 e5941020 (e592223c)
> ---[ end trace 51c4d8003ec70244 ]---


I have also noticed that an eMMC test we have started failing
today and bisect is pointing to this commit. Reverting this
change fixes it. The signature is a bit different to the
above, but nonetheless seems to be causing problems ...

[   76.675488] ------------[ cut here ]------------
[   76.680147] WARNING: CPU: 1 PID: 705 at /dvs/git/dirty/git-master_l4t-upstream/kernel/block/bio.c:1033 bio_iov_iter_get_pages+0x480/0x490
[   76.692518] Modules linked in: snd_soc_tegra30_i2s snd_soc_tegra_pcm snd_hda_codec_hdmi snd_soc_rt5640 snd_soc_tegra_rt5640 snd_soc_rl6231 snd_soc_tegra_utils snd_soc_core ac97_bus snd_pcm_dmaengine snd_soc_tegra30_ahub snd_hda_tegra snd_hda_codec snd_hda_core snd_pcm tegra_soctherm xhci_tegra snd_timer snd soundcore nouveau drm_ttm_helper ttm tegra30_devfreq tegra_wdt
[   76.725279] CPU: 1 PID: 705 Comm: dd Not tainted 5.12.0-next-20210426-g3f1fee3e7237 #1
[   76.733192] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[   76.739457] [<c0311628>] (unwind_backtrace) from [<c030bdd4>] (show_stack+0x10/0x14)
[   76.747203] [<c030bdd4>] (show_stack) from [<c0fe550c>] (dump_stack+0xc8/0xdc)
[   76.754423] [<c0fe550c>] (dump_stack) from [<c0345900>] (__warn+0x104/0x108)
[   76.761466] [<c0345900>] (__warn) from [<c03459b8>] (warn_slowpath_fmt+0xb4/0xbc)
[   76.768950] [<c03459b8>] (warn_slowpath_fmt) from [<c06cbb58>] (bio_iov_iter_get_pages+0x480/0x490)
[   76.777996] [<c06cbb58>] (bio_iov_iter_get_pages) from [<c0533864>] (iomap_dio_bio_actor+0x278/0x528)
[   76.787216] [<c0533864>] (iomap_dio_bio_actor) from [<c052f2d0>] (iomap_apply+0x170/0x440)
[   76.795476] [<c052f2d0>] (iomap_apply) from [<c053433c>] (__iomap_dio_rw+0x3f0/0x638)
[   76.803297] [<c053433c>] (__iomap_dio_rw) from [<c0534598>] (iomap_dio_rw+0x14/0x3c)
[   76.811043] [<c0534598>] (iomap_dio_rw) from [<c056347c>] (ext4_file_write_iter+0x550/0xa78)
[   76.819483] [<c056347c>] (ext4_file_write_iter) from [<c04b1700>] (vfs_write+0x2ec/0x3bc)
[   76.827662] [<c04b1700>] (vfs_write) from [<c04b1954>] (ksys_write+0xa8/0xd8)
[   76.834792] [<c04b1954>] (ksys_write) from [<c03000c0>] (ret_fast_syscall+0x0/0x58)
[   76.842435] Exception stack(0xc5471fa8 to 0xc5471ff0)
[   76.847485] 1fa0:                   0000006c 06400000 00000001 b0a2f000 06400000 00000000
[   76.855653] 1fc0: 0000006c 06400000 0050d0b8 00000004 0050d0b8 0050d0b8 00000000 00000000
[   76.863823] 1fe0: 00000004 beb0c9d0 b6ebdc0b b6e48206
[   76.868917] ---[ end trace d33cae3bcbc64fcb ]---


Cheers
Jon

-- 
nvpublic
