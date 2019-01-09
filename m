Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0628C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 03:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6612146F
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 03:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="BiMhXrBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfAIDMB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:12:01 -0500
Received: from mail-eopbgr770134.outbound.protection.outlook.com ([40.107.77.134]:49120
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727857AbfAIDMB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jan 2019 22:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ex2Lg4sAvx5EebjEzmocfx+YX6283YnCEFqiVEH0ijM=;
 b=BiMhXrBGgKapr0IywpnIsvyxgt592S2i777ORYCdnSsoaHtlezEOyB1XE6CYKvCF9K+XrEhcFaL+GTn26kAxN/hYTozqFQ00zO/0vBy0G2axojIa639sbrAX2SB2Wf4Fobh3Dl0i4nJ65C5gKnhXLZ9/5zD4BzPitYokV+irxdI=
Received: from BYAPR01CA0031.prod.exchangelabs.com (2603:10b6:a02:80::44) by
 DM6PR01MB4026.prod.exchangelabs.com (2603:10b6:5:2e::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Wed, 9 Jan 2019 03:11:58 +0000
Received: from CO1NAM03FT050.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::205) by BYAPR01CA0031.outlook.office365.com
 (2603:10b6:a02:80::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.7 via Frontend
 Transport; Wed, 9 Jan 2019 03:11:57 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 CO1NAM03FT050.mail.protection.outlook.com (10.152.81.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.13 via Frontend Transport; Wed, 9 Jan 2019 03:11:57 +0000
Received: from callcc.thunk.org (guestnat-104-133-0-100.corp.google.com [104.133.0.100] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x093BtfO005100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Jan 2019 22:11:56 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E9D717A02E7; Tue,  8 Jan 2019 22:11:54 -0500 (EST)
From:   Theodore Ts'o <tytso@mit.edu>
To:     <linux-block@vger.kernel.org>
CC:     "Bart Van Assche --in-reply-to=5423ce34-1d3c-2363-da4e-fe35b02c988b @
        acm . org" <bvanassche@acm.org>, Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH blktests v2] src/sg/syzkaller1.c: fix portability problem for syscall(__NR_mmap, ...)
Date:   Tue, 8 Jan 2019 22:11:53 -0500
Message-ID: <20190109031153.27604-1-tytso@mit.edu>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(376002)(39860400002)(2980300002)(199004)(189003)(2616005)(50466002)(47776003)(6916009)(476003)(126002)(305945005)(48376002)(8936002)(8676002)(246002)(50226002)(90966002)(52956003)(42186006)(2906002)(36756003)(88552002)(2870700001)(36906005)(478600001)(26826003)(316002)(486006)(26005)(786003)(5660300001)(14444005)(75432002)(186003)(86362001)(575784001)(106466001)(1076003)(356004)(2351001)(51416003)(106002)(6266002)(4326008)(54906003)(336012)(103686004)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR01MB4026;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT050;1:aVT69HBkTUbAFhgvXz4MfGRUvy1b3LRhCclM8zQu8X8+NjsnlRmabXsuF1xc/KmZvaGo5X3qbH7esnfujtcAaZdvfLdO75Vv4dnjrE1qRt+Fme5FM/3TVpiUrLd/m+mU
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 828134f0-e376-4170-30cd-08d675e03724
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM6PR01MB4026;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR01MB4026;3:KguMJmpjVLUw2tLPS3vdFzsr/oRBn44Li61FEH6p1zWb5mNw3ghTpKNCdHywSIrG5a5F7S9ZBo8NCAmQyT2GYbjbFzW9wixBv9mlYTbtMu4espHDRGLeiijos6OSNJhFS1S+Z54p2D/KIsIJz7vCi1HIHDlAEzwIYCzG2YidPN6WNWvKzUr5mOOy/ev7i3jBUCGCtvgdSZmeKtzP9Vs/ZYO6UU5VxKBGr1je6jaueEo8765ZpcPIU2T//K297QiTB4A9JiQ4hjU1xeKB4fgUZClfoWC4oiPajJNhxlJgMuxwOrsRpu+htDpGh/lSfJFWe1sHAn73JRTYUV7/hLlc+9DWY9CN/mI+mzqbGbFnSGg88iHFMqmePtMtKrz48gEi;25:f3MuRpe0DspzAYT2S3vrUq+jXwoehir+a27nn0g910AENfecE7OG0I/zjQ/vdb/JmXYxnIveyUgeJq5n6ZjexHhbJ8BZflTStu3SGauHdYt1NrXiTlbzeo6JvxjhPyKxsQXJg3VOQnSYTgFKoXwfuBW4vK5Q3TWdtnUB4xEB8M0RIryTHLshZ9e0ZHkMK3/aBFpC/paVb3Xo1nJcB5lDVecZXfcHGR6gnRPrUQh9UbA6GzuIky7x4mv7e/Fogr/wl7z5KsoNUmlDi5Wj+HGcVywrxpBlQ7jDaYb5l4oMAq/yhAjgMmnzTn0iKar0W+V6JW8Itc8+JgjrReMY+VcdbA==
X-MS-TrafficTypeDiagnostic: DM6PR01MB4026:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM6PR01MB4026;31:uXCLE+3poxegR3BmVl/+olVzLk6aemWdeSDeTPB+Uo6I3ZWkncH75+BsMEK1PgUsHP52MLPkr6bp1kvo3WiVQnZIomKnAZDkw41FWou/aQJiCRqM5kB5LsW/molGLmaE+z9tAyLZRYtHwLiXqFNdm/bD42/m4C92B6V1sQPVBOUTCHfBplGmDBFHKtjlnu3MsIuHWYu9nR5f6FPbrOPuK57POwTJfXkrCufkbkHvvTE=;20:aCJtZVjUsJac5MGVqyO3Cg9+aO22lFz2yxNlKwOnyzhYd3bjmuWOwHgVpWvM5f8iEPWmD9Inc1eVvzG43XhNDEjY1r8jRih9ahO2QSO0OlQkvOKedg+/uQAEABEu5/AbgRYlr6YrddqUm4QYjzJqhoQGwhy8TQybBbY0iTsv9UF6t4HvaSuiI+VBKfBR3W96Xq0f84B4DRwQXHqyKQs/hmLke+LbLA9R8mZ7o/7khx6BWjLF9G41Icue6d4cM/Yzo89goWHoTQ2qvORrpwQLoNso1QgW6Gpo9GTaRghKSWWcLeHIiieVzSA56awjoqdvIoXoqStzOu2baOuYzxeGsDPs01mU7IX6N2s0xXvIurVRkxUpqnrM7YJrFyDSx0GymQX63R6HbaGhc4sGWWy5nqBG6kOg+ON8kBrwRP9NW5da3iLd9wGxmcfqJqjf5EL79q6MOuEdJoT6Dm+MP9YSOoiuGc8TOOlaxsT2F1tG5aOqStYdj3G45HpSiUUr7nhK
X-Microsoft-Antispam-PRVS: <DM6PR01MB4026B421760C122EEF20EE53B58B0@DM6PR01MB4026.prod.exchangelabs.com>
X-Microsoft-Exchange-Diagnostics: 1;DM6PR01MB4026;4:aEb7UigyLuqAh8N3UkUGAO1xuEgtxPfyd2z29LxzVxHktLyqw4eG4UdwenPx1Yt2/HI9d/6ze1I/xr3x74ZmyjE5PtDJ77hUYU49yr5asJuPXnzrpOLwzUG0uELs5LwgRxRb8ZKnRcEa/QhQ8mX5MiJevD8NogKN2wiWwnC+HrpuP1mhu9PRLrtGCPU3qF9bV2HRayeqIRzAD0uuXBYJCqaD3NQ6yFETSw1IENuFv1bsdM/XZC/s2SPyjhBlwvBdeZ1Etn7TYgp2ovxsC1WeXSp9YBBCivd6DrsJ8s81hwc=
X-Forefront-PRVS: 0912297777
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR01MB4026;23:5nH+LM0lA6cpun+gEYmiRtImXpS8vfWrbp6QBCBHW?=
 =?us-ascii?Q?6i4VRDTi1qmRlETqH1oFfgOKdSrOQciz2YSs7Go0y2QgcRQ8dRFk6CXMVhpP?=
 =?us-ascii?Q?6EX7n11X2c+281VfVx7uL2A3i7446SvqhGNwOrMzmsrnDTNiPLzSAAXx97Pa?=
 =?us-ascii?Q?7RcxhaCkBn4MR/jEz4k6IRYgaltTZV4yR6rsGJUoyX6DasqYTezpUs4JDBXW?=
 =?us-ascii?Q?ZP3Y4CkaWZ3lLQQapz56ZwZFvj3sYMVL8g/UQ9VTkxTqnd5mGhVmh0tzAcXi?=
 =?us-ascii?Q?71d9zWF7eA+BtzxIO+lFfyq++6lpitrtiyhFyMeDzoX/VaTPDmtCluC8gDV/?=
 =?us-ascii?Q?x6O1W586UxgLXjGjITMlFBDNkroAALSb5l4Hsy1iivl8oYMw7Zq90ryZNgRG?=
 =?us-ascii?Q?h8qPYkVw7BZScTA8WlBRUy8U/wzLy7XcWk4/l5KBvqJHYI7bWM6Rc/Ht9F5m?=
 =?us-ascii?Q?0UbkegyJGlcc1eK67y1xmWcg3DVXW3+JTytV1MorE2hBq5xTlparpWou4ZNl?=
 =?us-ascii?Q?89N+OVcGCiU+XGHv/dXKDmmkm+X/MnyPO6Rsmd2Fui+fxDdcOAkD6NpoioxJ?=
 =?us-ascii?Q?6C6V3OK9TLtIQu9UHMKHas5sfKcbcgPoD9FE4leOfXCEXhtHwVnotC/K9nhr?=
 =?us-ascii?Q?0nulDWm8GOa49b61/Flik93cjzA/cV0dykAjbOd6DFg8dX0fEbbWgzWKDez2?=
 =?us-ascii?Q?GCLsZ8N+ASIbsbpRZePxZ6T7Ml41OskCcQN1fWITRfUlu1FYg2vS0mU1bFc1?=
 =?us-ascii?Q?+pp9a6A+BTuydQpg78GTIG5wdoHYxMUJgDdcY5lsmbLwl9xIcZo4pvXNLh8p?=
 =?us-ascii?Q?BDwP0YCC8HKsavYhG/AM/1UXCZ3A2QAPcpiWfDx3MzmB3NBhHZ22nDtsIxoL?=
 =?us-ascii?Q?2ZMf4u7B3WbRBAI9houuk+4scNrEoZ2+G4jZA21HrRul+AWh4AfWwkKKcRoB?=
 =?us-ascii?Q?KO40SN/EtMxI9liJwkdkzAtzVAx3BhOqWliINU7wFTR5ntfDAA4FEdItIRwb?=
 =?us-ascii?Q?l++lS31gClB6o5gtxyTcCZVYCEv8QN31SRrjC83Fzfw84RaudMDodbI0mau5?=
 =?us-ascii?Q?rqlxbkV7ndhxVZgkIXINXWIsw/2VfFdGwWnPgzrLGIiNS5Ar9EW/JCnK9PlI?=
 =?us-ascii?Q?h7Zd1K8Qd4oyEWnCfn2j0q+3haOovD4wgWsd1j8Z7y0JXgCV97cMg=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: hASZOqn31RPIwEQL12jmwHplOObHhshonf0cyBX1jCnd7pPdOb4pGrAIF4fGVNnZkBW6EzuHf1B9jdN5yq9EL2bPNRPsfzJt+3CSYk5I8b2LIyE6VMkdKDKZKXWfx8AOv9uP3uVVN2w7RwtClKZ8dG95WpCICIfN2Yga9F4E2ryuQqvU5KXdbrEIs3KfoZNj8p6tcyCxe2mJv2WXLzLrpDYOeCC7TB+wOUGmy6EotdEdmCF6FvXzkW1R2RiBh5Mj8nzLKlHYeMsocu8wzlzCDrU15gXtFHatGL+/jLsSuDhURe/1iOi0VUha4Vcq0BHY
X-Microsoft-Exchange-Diagnostics: 1;DM6PR01MB4026;6:zlyokdSy3G/rJa96A/PZHFNOAnpa0uGnKxaWoWz89d6JyqJ+mWzb22DqHKD0Bpp08KvMBa9KkPIaKnSHCeYUHF8hGOhzL5g3toK6NNpsKzYFVjxGknfDFAW5Jny3hyr0wt7uBEqF9FyRuVW45UQaR4ZucehSqIkbiAF6qQN7hEocwJGNM92V0UhNoncklMNhM20GfG5EVPStTLVu+IyWxyV8+LTLNQka1TY/wcmclevcTCmQ4jobGUNVY38/JsLI9vppiZLGU7bIxNLnBb+T9f3yJf4Y2dT4hIbYY76v+0/kdQNbxNHTYEDAFOyM18AxjpFhaiYEp8Y3STuIQdJXCGn5mRAlUFRV0v+KnihNZCUtR7OIhJ8U+2KcqxYojfbpYgR8tllXrXSo+yzj4mdtcHpnerr1pmMJ/nC0lpru1QgEpXmyfUXu4BOFTjnFXzq5t8iJDtXeggM0EFJ/jJiS2Q==;5:odlIXkUzT72mfYgRTJ5XMl+YE4GrvD2M1RI3lFYV0YK5M6Xdo7z29m+WykIT7GskF2JizL/zPAuj1HYVBns7KAAfGKwkbB/0v0xSFyiO4+5GqvMAkFZyIiYgQm0adnH3ky7wgqRNxDMdlz1w5uEpfDPQNH2u78QBegIvhcXlvVFPnyqWUAgQK/Ou3lPnFBKjci626lSL0cie6vQLvLJ7AQ==;7:Zn3AZE/XkNI/i2ynoP7S/lxcMUfR/kliydbYxpj/DC/aP9Px+4/hmBRSVM15YhFD12JSNICKwgdJ3S+zzUEHtGXEgM2GvYXzwph+c8sDtGpcDJTqljKXs/zkgUL/ISG/mMmaIbQp7THA/JvrA5iMoQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2019 03:11:57.4465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 828134f0-e376-4170-30cd-08d675e03724
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4026
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

How mmap is mapped to a raw system call varies across different
architectures.  On some architectures (such as 32-bit ARM), __NR_mmap
may not exist at all; glibc will use __NR_mmap2 to implement mmap(2).
Syzkaller is using mmap() as a non-portable version of malloc(3), so
it should be safe to use the glibc's mmap wrapper instead of trying to
directly call the system call.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 src/sg/syzkaller1.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

[ I found this issue when trying to build blktests as part of the
  kvm-xfstests test appliance, which I currently do for the x86_64,
  i386, arm64, and armhf platforms.

  The PULL request I sent is this -v2 version, which has the spelling
  correction pointed out by Bart plus his Reviewed-by.

  I thought about rewriting the full Syzkaller test in idiomatic C
  instead of the cr*p assembly-language like mess that it generates,
  but that would risk changing the test case.  So for this change I
  opted to keep it as close as possible to the original
  machine-generated test.
]

diff --git a/src/sg/syzkaller1.c b/src/sg/syzkaller1.c
index 743859a..e254d4a 100644
--- a/src/sg/syzkaller1.c
+++ b/src/sg/syzkaller1.c
@@ -401,8 +401,10 @@ long r[15];
 void test()
 {
   memset(r, -1, sizeof(r));
-  r[0] = execute_syscall(__NR_mmap, 0x20000000ul, 0x5000ul, 0x3ul,
-                         0x32ul, (uintptr_t)(-1ul), 0x0ul, 0, 0, 0);
+//r[0] = execute_syscall(__NR_mmap, 0x20000000ul, 0x5000ul, 0x3ul,
+//                       0x32ul, (uintptr_t)(-1ul), 0x0ul, 0, 0, 0);
+  r[0] = (long) mmap((void *) 0x20000000, (size_t) 0x5000,
+                     PROT_READ | PROT_WRITE, MAP_FIXED | MAP_ANONYMOUS, -1, 0);
   NONFAILING(memcpy((void*)0x20000000,
                     dev_sg, strlen(dev_sg)));
   r[2] = execute_syscall(__NR_syz_open_dev, 0x20000000ul, 0x0ul, 0x2ul,
-- 
2.19.1

