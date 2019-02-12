Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C328C282CA
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 16:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E3120855
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 16:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="RGZ9Nhy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbfBLQju (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:39:50 -0500
Received: from mail-eopbgr800109.outbound.protection.outlook.com ([40.107.80.109]:2477
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731150AbfBLQju (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 11:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1IzLCCwVEI9IHjTEO78jR2XVTh7HabU6F/cG7G3gHg=;
 b=RGZ9Nhy5dwSXQ3XIPX8z4f9pk+K0rS6LL09KRykHOs3dz7bBIHoAb9yWLuMgjN7SCggfa4gWmufN8NXFHuCH92ySj4NCThEPEQN99+CdWArSOe0McSdqosfb2J70Ve1ztE7SuYjS3+xNbuxTSTfIOre2h3Fvxy7ZIn4O4IUyg+c=
Received: from BYAPR01CA0071.prod.exchangelabs.com (2603:10b6:a03:94::48) by
 CY4PR01MB3206.prod.exchangelabs.com (2603:10b6:903:e1::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 12 Feb 2019 16:39:45 +0000
Received: from DM3NAM03FT058.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::205) by BYAPR01CA0071.outlook.office365.com
 (2603:10b6:a03:94::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Tue, 12 Feb 2019 16:39:45 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 DM3NAM03FT058.mail.protection.outlook.com (10.152.82.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Tue, 12 Feb 2019 16:39:44 +0000
Received: from callcc.thunk.org (guestnat-104-133-0-100.corp.google.com [104.133.0.100] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x1CGdfl3000828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Feb 2019 11:39:43 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 27DE57A4EA7; Tue, 12 Feb 2019 11:39:41 -0500 (EST)
Date:   Tue, 12 Feb 2019 11:39:41 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     <linux-block@vger.kernel.org>
CC:     Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: blktests nvme/013 failing
Message-ID: <20190212163941.GA7967@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(396003)(346002)(2980300002)(189003)(199004)(23726003)(246002)(6266002)(50466002)(75432002)(316002)(16586007)(42186006)(786003)(58126008)(36756003)(305945005)(8936002)(8676002)(54906003)(186003)(1076003)(356004)(336012)(476003)(2616005)(126002)(486006)(46406003)(106002)(47776003)(33656002)(2351001)(90966002)(478600001)(86362001)(88552002)(4326008)(106466001)(52956003)(2906002)(26005)(36906005)(6916009)(14444005)(103686004)(97756001)(26826003)(18370500001)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR01MB3206;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT058;1:A808yFzj3XKDf4kdnbiTDqdpMXwop3eLlKT6L+6Qcv4MYmLAllII1dLMgPoNwHTYhtMsPBfkp9QMRq6mQN4hko6C8DMs5q58i22QsZILeYiQ/uVskOGB/rk7oxu8ofUwoJxBB1v3aSh2uUd9Q+1VAQ==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7485b923-11b8-48e0-f93c-08d69108b216
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:CY4PR01MB3206;
X-MS-TrafficTypeDiagnostic: CY4PR01MB3206:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;CY4PR01MB3206;20:DVpfSxtfAeeNmHyZk3bhhE02ChufpGif6rwRfYcn2cRDvi4vfRwqN8PDQN0Jdr8OtkzGoY6GMM7OcwkgEnrZAjF6FarOx34IRynVPI3a7WBJ2y1fgJJz06gETn08DGtWU6EIMdOdFBzJV56FweLd8vykzpPZx913wKlH9YifkkeJWIv3HxcLhKArm72dT2bPbqFaeFVKATq3iVKRr6xRcg0vc9XpGy/8V4h+CuiaICZZ0W5IxLkDcxsGnV8IzsKXsJWsETQzqt6PKxtlprxWvHEnhKcrzHCikGDFmxHzsvLtVXBE1MOMtKVJLLxKIEKXW1aLyyaPabmM4jYLhEQbtgy23sn1otA48x8c7pmTVJNZVul+Zx1SwtL1qSzvaCR+k+d38BvMQDbICWqtEqf1QlnHG7csFOq/ekYufepIq17PwAaNM/79R/kNI/BDOhkzIjTmdkLkohpPUwk7yDsbaHet0xiyxBTSuYKXiLADKMfQ9xE82TfUAFzZL1/XJAZqviWXUIxXg6PKyqu2qthr1y0+2Q7Qe7o7VWpRSWHnxLH/MdUxMCvOVSJrcX4OeSPg9hghovRAjGEyIbEA9kg3BSuO2OOI0/dL/L63MuqYn3k=
X-Microsoft-Antispam-PRVS: <CY4PR01MB3206A88F24BB28CD5DD20AD4B5650@CY4PR01MB3206.prod.exchangelabs.com>
X-Forefront-PRVS: 0946DC87A1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR01MB3206;23:NAUHnhvgZJlSKUI4Dm7O+bF0GiKMXcBdqpgaPBhG5?=
 =?us-ascii?Q?yHhOwrnJHwEw0YNoH2BYEUDKB5CyB5XsIJfAfrJE4b+4n882tvRzeequfDdZ?=
 =?us-ascii?Q?e2+OU+eIgvwhL56KBxo90QEtuwzeB7gyIWSvDoqlm8DRDAN4trktqxL68HTd?=
 =?us-ascii?Q?qaA5nu6ZJ9NYhpDoemDDa1m4Kk5ipSA+tg4c+iDUMtsYOHNPtY7NjFUxhDu0?=
 =?us-ascii?Q?ihEFvQOtx+iUEqVLGeDM3tbfrWGvor5Ve1wH0c4VWDCxnwmRZCsHTcWyA/zi?=
 =?us-ascii?Q?/aomH+upQherjlkb8Do2O54StQwRtT2Edk4PnWF1XKDeR8Iakpd1DupbG3L8?=
 =?us-ascii?Q?BYLMPySkZ692FexJNnIBhB9eUowQ+S6zg7lSnmFEKGL1cFuFaNO9qcpZSTxA?=
 =?us-ascii?Q?92C032aJx4GOUzTBp2Ojp1pvrnfxI6QFiATNm/WDKS66HUMrBAXY4KRbbDCo?=
 =?us-ascii?Q?cxwr4+wKDRbumz3puTEJsIPIlGqUV0ublJy/4/ILf95gr8zRrrFRK6VDXtFa?=
 =?us-ascii?Q?qQQSDO7Tkn4XaB68YXr+G7JJ9Z/bmma0Qu8/bAyOfh5asUXJIjd3pAXPVjfV?=
 =?us-ascii?Q?8WrChN4RKAIoq1quPiAMGomEmycbUjAVugaPFNClslq6Ad53ngW6JO+uCfi5?=
 =?us-ascii?Q?tPSiTlc5p/L+qdTbF1p8HLAqH9nFRydZvh+VrQln9HYFfJCFZWa8ytzPtA+4?=
 =?us-ascii?Q?46CBxCYomEuRnQsVIEXqKyuIPTKghofq6t9ZBu0+RewsDGmThFsqzQrxR19o?=
 =?us-ascii?Q?y1saRHOH/kd+ONM+IcagBby+ikys6Kab+xfh0aV24bH+g1BY+8OS3AaAyLOp?=
 =?us-ascii?Q?LGlbFjs92CiqVlLSbR0f/DwgmK/I6Mf5KCdWOP2gDMAV0MHT6j2b99/Fv+MS?=
 =?us-ascii?Q?gS0KDMVmO4EvP/HvtaIs78rtcDQ0cfacirPAYd7VG9tmaTHDostjASi0Msf8?=
 =?us-ascii?Q?eixcs+BVBZyFsyxKiUkzrDI+YYSno8WeWFyfn1rNdT0n/wkFx13EJTEg8pGm?=
 =?us-ascii?Q?vco4pq45e8HlFfAVM9+nzea0Hjw39JNxxAcVCcIsZUQ5Inr0HjDjvVIVNj4J?=
 =?us-ascii?Q?9G/RslkrUabWxGA9vwErKeqwtpuUkBuSp50MlwTU1vT3E+5rhW+dFky+3cqR?=
 =?us-ascii?Q?pTrQRPM4OTIaLn9MWfN2zpgt69nwKJJwSC7fX46yzXid0jXb2052CUGfh5xG?=
 =?us-ascii?Q?Cdf4Q7Jlbmttgc=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: uV57iSzTQU1jdAEftv0XMkgP98R9khiSwNrS002rerJuOILf0VmWlxQNabAuZoy+iw9udiGm1NIH12jRMZMEqgeM17Oro3Px8JZprajs1FOThpvDXy670LPxiavh90h2qGeq4g6zDU/Qe3bLfz7yERsTdc9mH+bzCPZywIYqLbY/2DoLdbm+Gteyufc1E+cY4mtsAWHM2FOVrspbuew6hNzarV1AXKC6nDnlrmfo043NA4jS0aynNOwFLYmcpW0kcRiIQm9mmHXi5eMyVZW7RbqwoPIPTJu8C7UFiRJ0NNIqXL5LUrRuREJ5Pxz/tMtexvefbT1J69kcMxHj9QnxT6FwQZpDruOu76TgfygqxzvCz5rOOXr6NKt9ztlEZ0Yg8x/G8si78XE312MQ0EyCXYsJNvCH+Swk4JYMjVH7Qhc=
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2019 16:39:44.9987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7485b923-11b8-48e0-f93c-08d69108b216
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR01MB3206
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are a number of NVMeOF tests which are failing of which nvme/013
is the first one.  Are these test failures known?  It's often not
clear to me whether blktests problems are due to kernel bugs, kernel
misconfiguration, out-of-date or missing userspace components, or test
bugs.

nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [failed]
    runtime  ...  31.249s
    --- tests/nvme/013.out	2019-02-11 18:57:39.000000000 -0500
    +++ /results/nodev/nvme/013.out.bad	2019-02-11 21:00:42.839324301 -0500
    @@ -1,5 +1,9 @@
     Running nvme/013
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    +fio: io_u error on file /mnt/blktests///verify.0.0: Input/output error: write offset=216387584, buflen=4096
    +fio: io_u error on file /mnt/blktests///verify.0.0: Input/output error: write offset=207941632, buflen=4096
    +fio exited with status 0
    ...

Found in syslog:

Feb 11 21:00:11 xfstests-tytso-20190211202457 root: run blktests nvme/013
Feb 11 21:00:11 xfstests-tytso-20190211202457 kernel: [ 2065.131191] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
Feb 11 21:00:11 xfstests-tytso-20190211202457 kernel: [ 2065.144934] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:41c2b863-9912-450a-87ca-7996c9228743.
Feb 11 21:00:11 xfstests-tytso-20190211202457 kernel: [ 2065.160868] nvme nvme0: ANA group 1: optimized.
Feb 11 21:00:11 xfstests-tytso-20190211202457 kernel: [ 2065.167407] nvme nvme0: creating 2 I/O queues.
Feb 11 21:00:11 xfstests-tytso-20190211202457 kernel: [ 2065.174566] nvme nvme0: new ctrl: "blktests-subsystem-1"
Feb 11 21:00:11 xfstests-tytso-20190211202457 kernel: [ 2065.384041] print_req_error: 1452 callbacks suppressed
Feb 11 21:00:11 xfstests-tytso-20190211202457 kernel: [ 2065.384044] print_req_error: I/O error, dev nvme0c1n1, sector 0 flags 1000801
Feb 11 21:00:11 xfstests-tytso-20190211202457 kernel: [ 2065.412748] XFS (nvme0n1): Mounting V5 Filesystem
Feb 11 21:00:11 xfstests-tytso-20190211202457 kernel: [ 2065.446064] XFS (nvme0n1): Ending clean mount
Feb 11 21:00:42 xfstests-tytso-20190211202457 kernel: [ 2095.710995] print_req_error: I/O error, dev nvme0c1n1, sector 1048648 flags 1021801
Feb 11 21:00:42 xfstests-tytso-20190211202457 kernel: [ 2095.718852] XFS (nvme0n1): metadata I/O error in "xlog_iodone" at daddr 0x100048 len 64 error 5
Feb 11 21:00:42 xfstests-tytso-20190211202457 kernel: [ 2095.727729] XFS (nvme0n1): xfs_do_force_shutdown(0x2) called from line 1271 of file fs/xfs/xfs_log.c. Return address = 00000000588c28c5
Feb 11 21:00:42 xfstests-tytso-20190211202457 kernel: [ 2095.740041] XFS (nvme0n1): Log I/O Error Detected. Shutting down filesystem
   ... (and things go downhill from here)

Thanks,

					- Ted
