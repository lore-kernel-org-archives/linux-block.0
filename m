Return-Path: <SRS0=Upb7=PP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD451C43387
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 21:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C632173C
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 21:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="HdgKPgTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfAGVNc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:13:32 -0500
Received: from mail-eopbgr750123.outbound.protection.outlook.com ([40.107.75.123]:32634
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726667AbfAGVNb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Jan 2019 16:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jM1RotnqEtMw6HpdzD4RNBozgIDiHb81abw+7LSjdA=;
 b=HdgKPgTxiGJ6ruI9lSYDxtFcattp2qo6pe0K5cokLIHUqf0D70GeZVBQmPBakgC6nyRGWYEZezzdGw1p4iLUqtGLpT1ZHGCdewT2qbG/X/f8AiCG6DAbR7V8MPMlrOmGMSBLA+Rh1pUcFhRywlzGMbZrKpAxcgi30VE+vGCNrlc=
Received: from BL0PR0102CA0021.prod.exchangelabs.com (2603:10b6:207:18::34) by
 BN6PR01MB2435.prod.exchangelabs.com (2603:10b6:404:51::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.10; Mon, 7 Jan 2019 21:13:26 +0000
Received: from DM3NAM03FT013.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::209) by BL0PR0102CA0021.outlook.office365.com
 (2603:10b6:207:18::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.7 via Frontend
 Transport; Mon, 7 Jan 2019 21:13:26 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 DM3NAM03FT013.mail.protection.outlook.com (10.152.82.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.13 via Frontend Transport; Mon, 7 Jan 2019 21:13:25 +0000
Received: from callcc.thunk.org (guestnat-104-133-0-100.corp.google.com [104.133.0.100] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x07LDOvA026019
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Jan 2019 16:13:25 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 028A27A02E7; Mon,  7 Jan 2019 16:13:23 -0500 (EST)
From:   Theodore Ts'o <tytso@mit.edu>
To:     <linux-block@vger.kernel.org>
CC:     Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH blktests] src/sg/syzkaller1.c: fix portability problem for syscall(__NR_mmap, ...)
Date:   Mon, 7 Jan 2019 16:13:16 -0500
Message-ID: <20190107211316.17578-1-tytso@mit.edu>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(189003)(199004)(316002)(476003)(2616005)(86362001)(575784001)(786003)(126002)(6916009)(4326008)(246002)(336012)(1076003)(50226002)(52956003)(6266002)(26005)(51416003)(186003)(47776003)(2351001)(356004)(6666004)(103686004)(106466001)(8936002)(50466002)(48376002)(90966002)(305945005)(106002)(36756003)(5660300001)(2870700001)(486006)(75432002)(88552002)(36906005)(8676002)(42186006)(478600001)(2906002)(26826003)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR01MB2435;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT013;1:w8shWEGgXHi6nonIIRBX5Md9t2Z9JEC9hobLHd4I1OBTxTKksHB4JNCqlxdPWYhFLeN0anBIkZlzJqqz5o/rJ202z0d8YLeo199Xjq/LnDcXNXyfu7r+2CWVRfV+/Dt+
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25e4008b-da6b-4339-ac82-08d674e4f6d5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BN6PR01MB2435;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR01MB2435;3:wj6UTP0zLHemI9tPKMoLpFEsgkeOEeJKKhiVLwzzWE6e0KJhC3jDbaWVaQcysU71Mu+zeEYr1kyM5cbrA6goDeAgrxs5ZG6/TaW0zdMCUNwT3j4bwQpGh5PIsPMHPTionASSsRY0Dfh2fXpOCc9j+Dxm34+YtwEMbiHMU9/FyXnoEZISSTI+2Y6ZJlSuk2TNUz4Ekir2nMCcbigpiLIhhpdhpGnmHDBKfXR/TF7TB56+gSTStNVMwAZgwkEeD2au9LiFfxTebbdkwnLpAIqEUKcM+fHkiFO7JY5sMz1VE0S8SLUv0sK7bM/SwROj+v+lx5hmik1+vM0+KyiUvQZBWeN2KqwXe3rxqUR/2nvHewM8vv7poHu9FbgVu9bYcZ28;25:LEQvK7i2qpacKAn9BhV7mi5JygI3IvSYCCGKvVLTX0O6qnbs9brmNQpLXFuwicKiEtL9FVLJTrLhkV/lfopOm4sSErV14IKs4mAekVTezGoZefzBR6pBt0MV6Mwqiux7is4O1yh1Zt4I3HWex1QIJndle6Cfy53g3uD1WrMa9BwFWsDS3EfJ0Y60m42jEkddqsbDHg52ii1NOhRB2tnZ987safcM1++tHDW6JRHVxkaitJOsCYqRa87TQZjIHdtOCwnKS00iTpYVmG654OHWusm8S5g0UTO2OLHbiQUHGmaJM9exB+1ye8gUSiM0+2M/Lrnddi/Ts9QKzobvRsBD5A==
X-MS-TrafficTypeDiagnostic: BN6PR01MB2435:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BN6PR01MB2435;31:v8YtKjr4ki8i8NH+xIZ8ruYGF+tz7IkicD7AV6TnhLX9BW45OPOoCefru3aQseZ/LuBR3h5fgkjMGBWIymPMjsS7XKlmf8V6p2/L/1YLE78IUzqPxEG1UlZlKAi2qs0OC2QzSyHSFTO+9d/791Nw16XrZAmte6jlJ26dB9PbJYMCvXWoiycRRYmBbSBBSXNwOex9iFksYAOQWNvLxh14gSJvDh3iBDewq24j5r5FJWE=;20:S/MumAmxBZaN6+3wQiNLOwt27tGDN2y9WOMDJrQiQl5ZXr9myl31Djpr+MzEG3g0Ny7Ll7wg45F1IlkrtAelxyC8GP7XnV3WlHKMAhybK13JliiVyIBGd6zyznLzoOVK/gqQqeN+cazDU8GsxNTHcy7ioC50Ke3yqfqBdrP+YK5p8cS7LDk7WFndGVfWp0h/TnFpdknYJH5YBI4LHwshqiAMQ8yXoBzQM6b0NBymg0mo6Hsiyp81bMzj7LX9z3FUEfh6KpbD2OOcNUVvgA7IIfXK4/VjZfxuqIqwx6m+ftQSamVGlQaj7ij32qii7t7/ebu5fNJtJEfoDhsOUhGlfq6NOYYUCpCcBl134gX/Qq9J7SIeMOpxuue08/iPDAxCtKW1R7tFqXU/e1cFAKCC4aMdeHmSO/z11wRhgwLVM9WadyQw3ec/06v3CL90BVDj7HxpDQiPlKIc6rSzGNneSKM+16ijCOiL/HmIMlO4lFK35NTpSr27X/2VAZ7YKbuG
X-Microsoft-Antispam-PRVS: <BN6PR01MB24359D8FCE0BDC3C77EB6F34B5890@BN6PR01MB2435.prod.exchangelabs.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93004095)(3231475)(944501520)(52105112)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(201702281529075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR01MB2435;BCL:0;PCL:0;RULEID:;SRVR:BN6PR01MB2435;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR01MB2435;4:MWXdbe/BD1+10BBWh5OYKIndSNRynmVYVYmg10tNuYSodIb3O+PvzRd5TMEy18XN8IZ1ZDrg0q2JBt2jVQc9N3aJlUTwLRfW+unoJjhnTWTGmXmAD7hwob7u16gFfCNedy6PBT+52T5Vy1iSfyhofaq5izJssnpYZfBbBRff4/2PNlKKUNGgA5fwl15hAZ/XcjmHujwaUkh7C1WmPLmu2mGFsn39SP8VZ1sCdfbaaKmp+PLv26mBtD1CPFNVb45LLQ8JOEJoP6I7t+NY0fQ0h+ZuvDepQaPWA9hiuoEO7Lg=
X-Forefront-PRVS: 0910AAF391
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR01MB2435;23:o2Ib3LZkzWz85J0WjG7DCzV8VZfnGCQ8B7b6zWPQI?=
 =?us-ascii?Q?jG3IsNEGyhK1skg1NMUtYJcZlR8Qh7Yum5tu4AI8wzsicC6k9GBz6w1+BA41?=
 =?us-ascii?Q?dO2eYNKnIXigX3BHXkrSJOp1ENry0btK+eDfVE5iO6aaZ8kFPO6mKMx2Dqea?=
 =?us-ascii?Q?KRFsPHrj1XEJYrvje2zfYbz+LkfgGI4Rm4WZnX4cvOybjW/O8+cBVsJEjsEE?=
 =?us-ascii?Q?r7M+5HkL86Nz3d55vChyazkkrLX/fE18gjDFjbXi5zQDuZI4MqSpQQMI3UYS?=
 =?us-ascii?Q?DfMwhsDlPKu7r03Ir0dNVaKRgymUpzErcwG0hBLc6909O+tScsUj9VzZSYx3?=
 =?us-ascii?Q?ToAXZhvEDBw/np8du3hgbrXBNY40641yWvPB6f2MMQfaB9KA3FszQZMScl26?=
 =?us-ascii?Q?juySIAMQ1Y7PJobc5u3fVYKKzI3B4hYh3h5BMr9t2OsRR9O8LlbDj31claEo?=
 =?us-ascii?Q?EvoyQTPBBMGAlnhESBBZdmuEfZ5M6Fs+Yv7ZDvHwBk3wlBdM+bMY69IBaJ5f?=
 =?us-ascii?Q?EnaGqCnS/UudyTVXVr3rnLEin196I9Aa5W0qc8wNkeJChPwvHZrBalJX2Fog?=
 =?us-ascii?Q?n8NsKP5Yd/eFhervPoF7ycLzPfiW5+F+OxcsQV9vOutUl7XypuX38CBnai2m?=
 =?us-ascii?Q?sqA/Lc0Wjl9OgVVCoIMa4jE8Eph+H8IKnWMxnjA4gsr0z68BhbBuoZnx3qAh?=
 =?us-ascii?Q?aXDBsDZrdZnps3Cw+f+cy+VI+vhAHswX+6s4L5QGH2dYgciRWCDdhHcNolcr?=
 =?us-ascii?Q?DPLNuTWwFE+aaSqSlXqGRro2N+Vn3Ws7n2tYwMMwi78+VQ5VAzDXwCXQ8tJD?=
 =?us-ascii?Q?kKBvX/tzX/gbRJqt0mtNMc2hlnP1Vv/ZKI+GGdIEyBNONPZbZ4yXURVTx/5J?=
 =?us-ascii?Q?yLK1Me2NcyfXZ5qXnUU991tsDJMUs0u+UXuFWu8N7KizxO9iKcH4xlFrYW9E?=
 =?us-ascii?Q?ZweTSXhXjaBwk5k4FmxznFK1DRupdgfSdTKNz2weASXRFu2MpAydoCZANsVL?=
 =?us-ascii?Q?M/zPaxi+8t+CLsZfRCiRW3rKyIsAXp1XpyTJ4k3Tw+PYvf8jes6qC/a9mPJe?=
 =?us-ascii?Q?CviygSye/OM2vjZxr40aoXYNpBXLbtJ0w0+VTEOW9K2jn1HQXuchF1kDG8xP?=
 =?us-ascii?Q?3wgUJPOSrA9DlEkfKROpxrFT8fUIlO0?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 31NsbYCMNc/OZ2iDl1I84KxGSiLNpQe7xEKh4z1aubD4JJ3o1Q6w3XLSV+R4ordKbHIPXgThYQ9TFalR7d9qxlWjxUOQ3p86whI+bZVuLOXDZdwY+A58HC0M/frkTqMqVJzaRVx2EdsVAdGKSNLeLXe9HOVAx66Ipkq9CkcTlII2dUJvUN23hJ7fI3bzAH3eFlrHCtT5ZuQbMp4Td779Cjqwio+/HqLt0flmbDAWRUMYX4lIE4unHgtX9vEYvR8vA8T7irQaO6BQRm0ISVKQx3Vvzm1A4/YVGTCdL8xWxqyNhnQYUwCRSZjERa5igeSy
X-Microsoft-Exchange-Diagnostics: 1;BN6PR01MB2435;6:aDfs3jGGyqsg3hDgORvWkjoqYNPih/us+vR+jdbKhIIh0NbUCA0lhWYLcDrh+n6LxlCBGWRc2fivkhv4q7XbN1fvYvzowOfIOUoQuI15NgkS4+YrU0Jj/VeNmlKULOn2/0BcDqVP5NSZHEpbj1Yehb1w01Szc468OEFIZwM+2fFCSG6K0PRvZB62qU52cf9rppR4jkYt5epkyVSvJvZ+e8LP/MTV8dO8GSeMhh3y9uhGhGDni+RGYdZRX9T+5xlP2guhLk2omaBPZ/iy4XOxavrP9VCbD5yX7zJTjtu0aqOpxZz14eLo9PL4RqJ1lE+VldwCr7dAsl3IJCQGLakYIumkpKOafZnj2vohyMLth//lEV12zAvfcdDU7BK25vOEzPT81FzOGPL365q4dqzOhlof/6z8MllKrokR7p6OwQi0xFbM+wQDY8+clFQPO4Tjg34OX374zxEwOTrZWOS/7A==;5:bzeAVuQ3BNZqU+tY5iI16WJBaKaNmrlop/MlrreIDVh5DouSqUcQurQRS1TyYP17reZywMYsbl7UBhPHfKaeEwyxml8djWQTyAAetZHv6+Cma1Xglt86U/dZv5mlLS+LDpmhtQkLWaCxBjoQPIDS2awnKKvVEkwuS1+ewiFg/eiH0F3Vz1o+4B2NqPrxYje/GT8HdId3+Y7vPhyxkKa1jw==;7:ax05H89KnxMQ/TtcYWCqmX5fbh9KOapeDATb+g7izcCzoeER26RM9Qfxz+Sl9mntSgzXhcYHhHStvUkSN/P7BBX2LeTByzGD2QkVBXspeJ7pQ9NwLiJirM9nfr8d3NGvYOME8m2cV6Lp1B7SAt4Dug==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2019 21:13:25.9411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e4008b-da6b-4339-ac82-08d674e4f6d5
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR01MB2435
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

How mmap is mapped to a raw system call varies across different
archiecture.  On some architectures (such as 32-bit ARM), __NR_mmap
may not exist at all; glibc will use __NR_mmap2 to implement mmap(2).
Syzkaller is using mmap() as a non-portable version of malloc(3), so
it should be safe to use the glibc's mmap wrapper instead of trying to
directly call the system call.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 src/sg/syzkaller1.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

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

