Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D66BC282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 16:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0914B20842
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 16:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="VqiZiIpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfBLQbp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:31:45 -0500
Received: from mail-eopbgr700135.outbound.protection.outlook.com ([40.107.70.135]:22666
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727372AbfBLQbp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 11:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADtZG+dgcLidPgYvuH/M0J+Cg3fGewWs8nqOTiIjluI=;
 b=VqiZiIpDmtsOGdS1bONCFrKEZ+dBqrE5dMmScoP/swDIo+JBFznMuuABjZkxkvMAABhpnVUxGvnDzO6hsvPKc5ZptBgfk0vbgthKKctlUlhYlI5IuwuSTEUN80k2nfBfhqZIdlUKibOVbFrkUxCrfrCGX9Khxg8yWbvAQZiy9TA=
Received: from BN6PR0101CA0021.prod.exchangelabs.com (2603:10b6:405:2a::34) by
 SN6PR01MB4541.prod.exchangelabs.com (2603:10b6:805:e4::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Tue, 12 Feb 2019 16:31:41 +0000
Received: from BY2NAM03FT034.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::207) by BN6PR0101CA0021.outlook.office365.com
 (2603:10b6:405:2a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Tue, 12 Feb 2019 16:31:40 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 BY2NAM03FT034.mail.protection.outlook.com (10.152.84.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Tue, 12 Feb 2019 16:31:40 +0000
Received: from callcc.thunk.org (guestnat-104-133-0-100.corp.google.com [104.133.0.100] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x1CGVcFW030184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Feb 2019 11:31:38 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3B6FA7A4EA7; Tue, 12 Feb 2019 11:31:37 -0500 (EST)
Date:   Tue, 12 Feb 2019 11:31:37 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     <linux-block@vger.kernel.org>
Subject: blktests nvme/012 triggering LOCKDEP warning
Message-ID: <20190212163137.GA7701@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(376002)(396003)(2980300002)(199004)(189003)(336012)(2616005)(106002)(246002)(305945005)(186003)(75432002)(106466001)(47776003)(26826003)(46406003)(88552002)(36906005)(2351001)(33656002)(478600001)(16586007)(14444005)(36756003)(90966002)(8936002)(42186006)(23726003)(316002)(6916009)(6266002)(58126008)(8676002)(786003)(52956003)(126002)(50466002)(2906002)(486006)(1076003)(356004)(86362001)(97756001)(103686004)(476003)(26005)(18370500001)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR01MB4541;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM03FT034;1:SiuxyJagGz3ZZIFFIIBQWaZkGOJU+5r8s9s40bUXRMDkyIzoM1gPelps6o3Qal+9Dz/xQs6/51hbcI43CCwR7HcDAboL8C+AMt4L5xp/oxDlId5JOHlmPxl2uanBG2EP+B678CexefZ1syy67jFgiA==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db265421-17a0-467e-b4d6-08d691079115
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:SN6PR01MB4541;
X-MS-TrafficTypeDiagnostic: SN6PR01MB4541:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;SN6PR01MB4541;20:eSj3ez8ic3Ld83iMjIqt57iIr798s8f3ANK5QDazhxZo1IhVaPZA+qTV4AsLGYVfSdKRnV0LKPZnoBlN4xEpFAli685tvUG8+BLnFGs8ftLH7002B6tu+XuXMBEGiZfLRnDfPYcSzga0xzrQ0w6vAJb6/4kauBq5eXyyrs7hviWjC5GjYKRp0dH4gxV0l23k4tlNVNclqJ7LBQd4hEWqCpUUXkKOHfjP6J8v/jy1R/PlyRV6oWQhxSq6yGtWN/OsHBIcQC93cB9QULZ3em9cpGHeN8F9xWNiNXOoEHXjw/GWzunOIbcQpahUAHVlPBUp/Rf2zE4EDmEGhT9319puR2HgdoypGAzwDlmWsLTvlxvh2yUi0m4gQ39q6G9z4i5/bpZIjCdadpSm/TO5vifRjX0+gyMO4tw/nPY3dizULGcVsB0z7uZA6AlKsjkJIBy9rW0LuUgda8W5nAarszysMGOi8SDzUHPXdOT9VfH0ZvsHMy3C6Ly5+zenCu9DPUCoCegEz+2cImZLDpFPcLIy5jb+kaNAFFjYgaQrN5MINoB4wlLYWd/YO7GnCCkEfBNRjVSj/3BNhDM2wk2Csk4XJ+bTCRBbAeCU4refVodBkDA=
X-Microsoft-Antispam-PRVS: <SN6PR01MB4541C25A6ECB2A286157DA18B5650@SN6PR01MB4541.prod.exchangelabs.com>
X-Forefront-PRVS: 0946DC87A1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR01MB4541;23:46lXEfhkIL+LP7EpG0Ka5End4ul4OKrFUUar8f9qj?=
 =?us-ascii?Q?IF68Gwt1zxzg5J6QnQ9OTs/LjQMDcCy7JnTuJd6TPt8wunSpKmQS4oV9nmRL?=
 =?us-ascii?Q?TD8+GdLd2sxYu2JPSXM6X2lr4yj2QYQWUfZFGJXQ8UI75SLzA9mdptb2Mjhs?=
 =?us-ascii?Q?kueWleIJMN41LIfobGs1FJaZMZ47tKorLQsaYlWolLKIpCsZcmj0xBzDWaD5?=
 =?us-ascii?Q?yvK+fv+h/NMEmNAQdunOGFRQV7jJ2YYDuXXsYbiHvJd0ZtaPAfZt1IGl8gHy?=
 =?us-ascii?Q?NLISlAN2QRnAxpt0MAXwJwM1+cePkbVOZuSOdhxXlt4phU88bzbAtkCADuxG?=
 =?us-ascii?Q?NhSgHDBj7EgjNOpb0/1Dl0JgvNNt+F9nTJKVLrRgI4lULk4dx9kv/BTqr92l?=
 =?us-ascii?Q?ZbgoKU4gmUXo6QwmFBtXKskiIrZ4KDC2MNMctT99aG1p2b7xdiJ6jcX854Wd?=
 =?us-ascii?Q?CEjdvIj/oLzkEZTnFdbIkOlip7hezDTexoMMQkrQvjLu+JdoqnVqS0wIXDEz?=
 =?us-ascii?Q?v/c6+Uq2kRuci64xCsJVSUrx6bg0FfMbxig1LLxPelVBNX2XbXKVR10v0wVS?=
 =?us-ascii?Q?b27jQF6nW5rYQkk6Y6kyDj2+iZ/9IlR2/c3GzXhfE+bLC8F/uKN/cYy0h9+q?=
 =?us-ascii?Q?OzW077amdfud4c05ulbJf9sIknNlW+BoTFCZeM7Jm7iQePii0rxJTkvI0037?=
 =?us-ascii?Q?2loToWDPSrJE/8ksgyI6wv+fAX3SnImVq9aNhRDeIZEUZjS9RV/O39w0iO3y?=
 =?us-ascii?Q?rocov4uCV8DmxgvcpWG31wXmXesowaAsNFYLBg9F+5lk0ilA7OZbyZR+p/rw?=
 =?us-ascii?Q?tSSTVHtXhRdCN5I4jfDBVbzOu5jpwgKx2h+8Ww3CUDVTaP1sdYZJHCVDSB2U?=
 =?us-ascii?Q?LHrWgv71hVp9kbUC6a1YWZg++kh6Lmtyzd5gMUrQs37zryXpQV07rPURW3UK?=
 =?us-ascii?Q?t87qvPrnAR+Ck4nSolN7KamVrclP60wvN/3auYwSAgGMI8tSPQBfezTP8VL/?=
 =?us-ascii?Q?c8rWDmD2DFg2iRnBpLB/1VZNwRWsr6hu7pqYyB6DDQoTkmDriR5eMHyOjDXv?=
 =?us-ascii?Q?R6utax8buoUV3UiT0jmNhp0i6FdogKKUHW54E0AqxY/VA661H4W77l774BrR?=
 =?us-ascii?Q?w6nNiRfzk91926M6urFuclc4vq5A2TW?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 7yymFo+fy4l+qidDzJ14/oIU0VRbxzfTeJod6dk8+RCOLUkR3BnPHLehLEaG+g3rUfzX2igPgv325XzWkhZlkR6prJDFbONYjUJP8YzjU4xSFCyjdprKu0IXA1zs2lN6g6hr7QSAll4zg4ny5mxVMz41iwGYtq1LOe4pHjq+4gXLXmMCnqmsiULIeaA4cElfumR9f6435jfBm6qgc4T6eMT/tVYpDk3YPyoMfLGc2pdfQy6PEGPHbc/0scBGBixQzf1rwCZiEWFKue6lwtGLvIc41XUCz4jmbCq7ErWJ9o77gAG35CpJZ8UXd45Ze/RiV2unczglsKAQCnZ2K5HwQTon+PHUJDZ8qhk+7Dd5kWneG/0sN5GXGURDijgkR/JbVnPVzsqWFokOJgCKFZ0gIfcDAPmM1ez0qGcFJuQCJvI=
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2019 16:31:40.1368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db265421-17a0-467e-b4d6-08d691079115
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4541
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Is this a known issue?  nvme/012 is triggering the following lockdep warning:

Thanks,

					- Ted

[ 1964.751910] run blktests nvme/012 at 2019-02-11 20:58:31
[ 1964.977624] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1965.006395] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:8a58b187-6d09-4c5d-bc03-593896d2d80d.
[ 1965.011811] nvme nvme0: ANA group 1: optimized.
[ 1965.011899] nvme nvme0: creating 2 I/O queues.
[ 1965.013966] nvme nvme0: new ctrl: "blktests-subsystem-1"

[ 1965.282478] ============================================
[ 1965.287922] WARNING: possible recursive locking detected
[ 1965.293364] 5.0.0-rc3-xfstests-00015-g1236f7d60242 #841 Not tainted
[ 1965.299762] --------------------------------------------
[ 1965.305207] ksoftirqd/1/16 is trying to acquire lock:
[ 1965.310389] 000000000282032e (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0
[ 1965.319146] 
               but task is already holding lock:
[ 1965.325106] 00000000cbadcbc2 (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0
[ 1965.333957] 
               other info that might help us debug this:
[ 1965.340615]  Possible unsafe locking scenario:

[ 1965.346664]        CPU0
[ 1965.349248]        ----
[ 1965.351820]   lock(&(&fq->mq_flush_lock)->rlock);
[ 1965.356654]   lock(&(&fq->mq_flush_lock)->rlock);
[ 1965.361490] 
                *** DEADLOCK ***

[ 1965.367541]  May be due to missing lock nesting notation

[ 1965.374636] 1 lock held by ksoftirqd/1/16:
[ 1965.378890]  #0: 00000000cbadcbc2 (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0
[ 1965.388080] 
               stack backtrace:
[ 1965.392570] CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.0.0-rc3-xfstests-00015-g1236f7d60242 #841
[ 1965.402002] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[ 1965.411411] Call Trace:
[ 1965.413996]  dump_stack+0x67/0x90
[ 1965.417433]  __lock_acquire.cold.45+0x2b4/0x313
[ 1965.422194]  lock_acquire+0x98/0x160
[ 1965.425894]  ? flush_end_io+0x4e/0x1d0
[ 1965.429817]  _raw_spin_lock_irqsave+0x3b/0x80
[ 1965.434299]  ? flush_end_io+0x4e/0x1d0
[ 1965.438162]  flush_end_io+0x4e/0x1d0
[ 1965.441909]  blk_mq_complete_request+0x76/0x110
[ 1965.446580]  nvmet_req_complete+0x15/0x110 [nvmet]
[ 1965.452098]  nvmet_bio_done+0x27/0x50 [nvmet]
[ 1965.456634]  blk_update_request+0xd7/0x2d0
[ 1965.460869]  blk_mq_end_request+0x1a/0x100
[ 1965.465091]  blk_flush_complete_seq+0xe5/0x350
[ 1965.469660]  flush_end_io+0x12f/0x1d0
[ 1965.473436]  blk_done_softirq+0x9f/0xd0
[ 1965.477398]  __do_softirq+0xca/0x440
[ 1965.481092]  ? smpboot_thread_fn+0x2f/0x1e0
[ 1965.485512]  ? smpboot_thread_fn+0x74/0x1e0
[ 1965.489813]  ? smpboot_thread_fn+0x118/0x1e0
[ 1965.494379]  run_ksoftirqd+0x24/0x50
[ 1965.498081]  smpboot_thread_fn+0x113/0x1e0
[ 1965.502399]  ? sort_range+0x20/0x20
[ 1965.506008]  kthread+0x121/0x140
[ 1965.509395]  ? kthread_park+0x80/0x80
[ 1965.513290]  ret_from_fork+0x3a/0x50
[ 1965.527032] XFS (nvme0n1): Mounting V5 Filesystem
[ 1965.541778] XFS (nvme0n1): Ending clean mount
[ 2064.142830] XFS (nvme0n1): Unmounting Filesystem
[ 2064.171432] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
