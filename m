Return-Path: <SRS0=bgcA=6B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C8CC2D0EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 13:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13FE2084D
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 13:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="VtzJa/XV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgDQNAh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:00:37 -0400
Received: from mail-vi1eur05on2125.outbound.protection.outlook.com ([40.107.21.125]:62305
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729851AbgDQNAg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Apr 2020 09:00:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0+ozMGo5zLiUJTiN3uY0jwTza2CWrRZru7nxbd6zHLfiqK5DcpVyv2I4btM2RFrpP0Cnij6uQGhHj1dRgQJWnXAOJLUc5bOf/bGmJkAGTrA1F5Zw7EiDP85750s3gsXM7EV6IDdamjMw4kKV6rSw5GgH3kZ604tyEDCFZ+eRbP6V3eMXHuhr1V+Lam8/f5tmeLaZ1PC+SETSNjsmroGiGor6O0+gRbYPHoEwuETn3P9jAy0GdnVXkdpthZxLInzMUdbjAXObMo32rYD3BCF3PPjO/1LOjn8MEBsNukpUiHEUleqTsl3ZvMdiPlseNWqhyoDoP3jRqLrTQhXyoQXQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcORvX4h+njomY+HB0hkU39yI0fVkD5zK0okFSN5yXE=;
 b=dJqqG11JTD7+QanlubrYb9+DXO7f8+oujyhapvOSv4ogKfQ6EdiOL1ln+q1sb59mFC69T2L9AWCVe7GzSqjs26nKVcKsXMiogU1YLoQjoLwj4E2fD3KT8sQHfaFjh38a2n6UoqTU/cEuBdVQUSyNfbcpPaohPFQlFCDFix/CyhP0sGzlB2zVAk2BqNlBhKUjjuVku4ON2UXX376AzK8BxS8UmRxfX7qNdg5ltl3PHaJMchRxOqshAH5OOKHvCE22H3tkSP1eqrydSQiQUMMh/HfR7fvUvh06+46nwrbPIfDPSoK/EIPs0d5GqD2LcEwooe/9em9Fy//0Z5DzMj8UVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcORvX4h+njomY+HB0hkU39yI0fVkD5zK0okFSN5yXE=;
 b=VtzJa/XV6fgKAcRhju9mltZhsDLPuS1V4TU2yvDHVk3eo/vVIkL/KYFdUzuqYGVcAeRb1KG+nIKtaqUAd2IXXm9IDcTb9ygGTcXG8w2dW0uUUXOnWvOaMxJU2SZCayxgitje/uEpHgsmn7YUiMlBAGqPKkWRlXvAK0pd2KIWamE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
Received: from HE1PR0701MB2938.eurprd07.prod.outlook.com (2603:10a6:3:4b::11)
 by HE1PR0701MB2409.eurprd07.prod.outlook.com (2603:10a6:3:6e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.24; Fri, 17 Apr
 2020 13:00:33 +0000
Received: from HE1PR0701MB2938.eurprd07.prod.outlook.com
 ([fe80::7877:564:f523:aece]) by HE1PR0701MB2938.eurprd07.prod.outlook.com
 ([fe80::7877:564:f523:aece%10]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 13:00:33 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] blk-wbt: Use tracepoint_string() for wbt_step tracepoint string literals
Date:   Fri, 17 Apr 2020 16:00:22 +0300
Message-Id: <20200417130023.104481-1-tommi.t.rantala@nokia.com>
X-Mailer: git-send-email 2.25.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P18901CA0001.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::11) To HE1PR0701MB2938.eurprd07.prod.outlook.com
 (2603:10a6:3:4b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from trfedora.emea.nsn-net.net (131.228.2.16) by HE1P18901CA0001.EURP189.PROD.OUTLOOK.COM (2603:10a6:3:8b::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 13:00:32 +0000
X-Mailer: git-send-email 2.25.2
X-Originating-IP: [131.228.2.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7c39c8e9-1af5-43bc-7e0a-08d7e2cf4fdd
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB24096B0F02B6451B5F9F5F0AB4D90@HE1PR0701MB2409.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0701MB2938.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(8936002)(2616005)(478600001)(36756003)(4744005)(8676002)(5660300002)(2906002)(81156014)(103116003)(86362001)(6666004)(52116002)(6916009)(4326008)(956004)(66556008)(6486002)(16526019)(6512007)(26005)(1076003)(316002)(6506007)(186003)(66946007)(66476007);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nkTB8OC/FvXB3hzPFtDMXrqBjr5v51W9chTUKbfqPUa/YI4SWiCU0pVjOboOCRLBXCcoal71V2jX0EVyMQPpyOzO6dWHCG3u35BfqMX4UOSNBv0nvcUzULUeAIXT6wPmyvd7EV2GhL6hmi7IT5G+RmCd1APt73cfhWxOHr8DfeHv/2BOn1y20DCTU+bViHkVyoGZgtGTDZdO8WMZvhectt8wtYRQoTkR/Aolbd2beLOvQANEfn1uYhg8hsSkePw09cVtBmiEWB3GpQCL8POnlzF3zqXJyl3vynN82aZdx4GCjhjMVjuKIifYf4MXiR/NUV+aZ+E7El4OJkFfFZgAVo8SOjBH3aEGtlmp4t/lbsc9+jxL3szdX73RNcX8sxWz9uTvRAzHwsA8DbuveYnPatXUypdWsp9f+3b3W6yA4yaTBtW3nOi0oSa362MCoMCM
X-MS-Exchange-AntiSpam-MessageData: d/bKokA/RAP18Y+NPJDPPEiOhIL5SNkWEUMKXF9jEvOfzxks4Jp4qQ2QPwpfj2PK1K0Z2W+wVVtcAgwMDtXclC/999kDCjTdCImrjgmtoqeCeU0TJ8Fn3/c4zKeVI7NyBUGoQhDci+TJ0yH++WvNMA==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c39c8e9-1af5-43bc-7e0a-08d7e2cf4fdd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 13:00:32.9145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBjob277dcqqBZ7FlaYAEQDezAQFg0wHvYUoczb58Uf3a9xC7gTc4rZmx+ddJ7CaqIjnEeW3zXOCKlXHlENAKxj2N+wGqbDeL47A369Vm5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2409
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use tracepoint_string() for string literals that are used in the
wbt_step tracepoint, so that userspace tools can display the string
content.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 block/blk-wbt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 8641ba9793c5..9cb082f38b93 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -313,7 +313,7 @@ static void scale_up(struct rq_wb *rwb)
 	calc_wb_limits(rwb);
 	rwb->unknown_cnt = 0;
 	rwb_wake_all(rwb);
-	rwb_trace_step(rwb, "scale up");
+	rwb_trace_step(rwb, tracepoint_string("scale up"));
 }
 
 static void scale_down(struct rq_wb *rwb, bool hard_throttle)
@@ -322,7 +322,7 @@ static void scale_down(struct rq_wb *rwb, bool hard_throttle)
 		return;
 	calc_wb_limits(rwb);
 	rwb->unknown_cnt = 0;
-	rwb_trace_step(rwb, "scale down");
+	rwb_trace_step(rwb, tracepoint_string("scale down"));
 }
 
 static void rwb_arm_timer(struct rq_wb *rwb)
-- 
2.25.2

