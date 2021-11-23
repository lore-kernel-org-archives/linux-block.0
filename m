Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D872BC433EF
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 06:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhKWGhT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 01:37:19 -0500
Received: from mail-sgaapc01on2126.outbound.protection.outlook.com ([40.107.215.126]:28513
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230176AbhKWGhS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 01:37:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdFe0KuRthp9vjBDHUVd15vEr2kyxc3NhbN6LpmcxgokkO/IaZWyfE5mBEhPpWDpuLWPJ/QteifomnfHdm/DJVbF6i6T8ccbc6LEg7jE9lXwlz857zMVSSjjwPJTQrSvx/ZTRrEom5yiCuCxHiqbNJQd+/9oUGJ/HmY3fFBdpZubTWBii3bhg08UGwYaLkFO87qr/HO8NqckNlG6RbfeNkOTnkTAeE0LYu5CjSIITaxQY7h+rZdEZhte8MH0oELo406JLQRkxXXhMKcnUHXAGLfuBINVIfsFDnLRzwhwI0TVO68FTRCYQAX6Iwae5qa6rvddcZ7k3Ua/0mpmPeTFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5e/9opRQdoXcnD2ce6Xucqv1oJjQsTznqM3lXa8gWU=;
 b=kCNVFuIURXiK7d/DK6/Z8hADy0UGcA8+Au2Xx/+/DvVWSFUUegbSDZsZcPi6xyT5T/xqfbKg9L4zhnSlmqD5mAlOaKBBj6UcwUozyjrwrZ+VK7/MVNL5fIh6oFX0e5OoXlQuaKA2xgs5AGpqT0jXrlpmC5vAUDrJzBNq7CzwLOFwIpDpFNzIMGYGgOFNCjpsF1lZuuaNG1WjwlyB8JjGYCB5bQ+eyaBX8K8ESqtsKusB+W/3RFOmfMg0T8pl8P/KcWUS0YR+UL/YW2SbDXIwd7E+K5G/0ME2c8w0CoVS6Sk13c0YjhmmEBjknoTv0AyBC25xjD7wzKq7ms2bB44/EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5e/9opRQdoXcnD2ce6Xucqv1oJjQsTznqM3lXa8gWU=;
 b=FHKZphZXlRHB7/CYdvOl5yQ7Q7dqZfEXueQHBKBWusWxK1sVWasmnP/pi0gCsyI2LblkyiQvFnvZHVUcVx4IzBB6nOGq9MKc9Q/DT1ZBFkp3h3jkU+DNGA2aDivqyA5csS/Tks32rn285x0f+V71Ed79FchzAA8E+oqkgNiJe2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK2PR06MB3587.apcprd06.prod.outlook.com (2603:1096:202:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 06:34:05 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::814a:4668:a3bd:768]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::814a:4668:a3bd:768%7]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 06:34:04 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list)
Cc:     kernel@vivo.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] blk_mq: remove repeated includes
Date:   Tue, 23 Nov 2021 14:33:40 +0800
Message-Id: <20211123063340.25882-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0046.apcprd03.prod.outlook.com
 (2603:1096:202:17::16) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
Received: from guozhengkui.debian (203.90.234.87) by HK2PR03CA0046.apcprd03.prod.outlook.com (2603:1096:202:17::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.13 via Frontend Transport; Tue, 23 Nov 2021 06:34:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d373cf3-3453-4214-c558-08d9ae4b3e55
X-MS-TrafficTypeDiagnostic: HK2PR06MB3587:
X-Microsoft-Antispam-PRVS: <HK2PR06MB3587855BCFA841B6917FA3F5C7609@HK2PR06MB3587.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGWr0tw297Jq3V3/HwHM0rYQhG3YBLUdHiCdwiDT/wg5UaijgM04UPZVrdNmQQzf+hHbahqiZvXqq6iMrf9ciF3zefrX+XywjI3uWaIiqq3v7UOpRiqcLM+VjDspCU3Jz8JzxgxxY1U1uk8TXQ9QKRBj2s5wLQvicXxrhuxMNWHquBEf0AXRwNvIe/nzxPH8BvbbSM8pxewlm2GrodrWIMdBvHA/EoDyX8sdsOgtozXdnWi69kO4Gk4d61nIo624y+2PLZJcZ02bQYC/PBnABPcZGq5uO6HCM5WX5Ago1uI6SpZyHie5dGLwefS0RsPKihTJuMxvtK6zOKqn7xmqRdRvEcr1mPc3QJRrm5VMICj2ppOM8j8E2ZNwjYHmNZlyVDFWwejjfATWELGS8qLmvVazVqh3zZUbmNH4TdPW33JE6RkVmH1TYY/KEu0ZLudSxLI1ZUOAatkFCxRMtdZODJFrIwVxqzCaXCIoX73xIkqabO6ddresiarNYiLX8fTv69/S5MjnVKiBbvLrLvVMfpulszCLl+wB46OiVeFCMZD19C/NIKSz8OUnNpa7IYq8t5/H3bzPelKE45bbS6i79mzlQ1m43RBGRWGHxfzpFSCVYwemKUnEMtvOcquXUFbBPm/ngTWQTNSAn9nYZxsWM3aiLJUfval2GbNLKmRuewDuvPWW4UgOms7ThAJ9UyRcej578lR2FSltnl4kgV3M2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(2906002)(66556008)(6512007)(66946007)(8936002)(186003)(107886003)(6666004)(8676002)(26005)(86362001)(956004)(2616005)(38100700002)(38350700002)(5660300002)(6486002)(508600001)(4744005)(52116002)(1076003)(83380400001)(4326008)(316002)(6506007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WD+L5Lf+cIHs+rZKy/Ow6O1mnAMpDHctE5Z3mL9Qof+Yn9GQYhOs6QU8jIqo?=
 =?us-ascii?Q?uj19i5nKvnwX3pFNE4i4wuZIyxHrdl7lEtU11YagRW0Z1VBl6neNq6VI+FcQ?=
 =?us-ascii?Q?WjKVlsrYaPnNgu3KooSyFF5YOOvbXXNKRzNUyEnq4id3vC7TUMudmB6p59p1?=
 =?us-ascii?Q?AzAhBdUuyKPhJ9Sj1cDuxssKY9bIZEgzSFqq/D80m2pAmXH2+TmTcby/VuCe?=
 =?us-ascii?Q?NGKc1otp4lv5/09DGOUx/X+MtlXdMIIvIF6OZgOHSXZATP1Lsekv96Ne6f+0?=
 =?us-ascii?Q?kGJwtyPQKcUzUPMxgqm85Ydo/RG7P6EEbIJ2YVD6DFxQiEHOBF8Qj20yMSLH?=
 =?us-ascii?Q?wAHLAiI2pyH1untPfPWnkFd5Aw3+jXHedXJtDwuQgxKaUxSnFefcl3VgYD6T?=
 =?us-ascii?Q?63vR4Qshfa3U088CrWP9kK2oT7YaA6MpJ/1CAb0cuRSkkG6poKCcOX8d1cFR?=
 =?us-ascii?Q?xyxXl+USUnsCe+lNZ3CPEPXYqeqg5CIDN9/7Cl+DezCvQkyVhoTLo109S+zR?=
 =?us-ascii?Q?lt8YyOwvrv8/lZQsmiS2Zry71W2F7EK2ST2Abhx+NQVB1t1GYOpb0Ftw4nF2?=
 =?us-ascii?Q?ggM6dNGRFvxL3RAVyBxxj6SthPSkQtznqQGwOR1+MqkLcwOFLhn6/k9EjaNj?=
 =?us-ascii?Q?qLHzDoWNFs91XTcAfzUg+UbTnXoRZVVUVQC9EwcFR3h9Cung03XWdPQrJyBl?=
 =?us-ascii?Q?wJAqZpZm/wIA5XsxefzJMBfPuK5e9+6/9/3+0wK/rXWohuAdUU5ajn49/90u?=
 =?us-ascii?Q?OrJkivxxG+9mSRmC6ArWr46YP0Q03l2T42zVIYTfjlsqsBdeC1uY9/EMi8Jr?=
 =?us-ascii?Q?uuSbZ6bHl6pw5TM0eEd88uDxjPiaQwgWZ9rreGHXt0x/Q/bWf/feTjqzDcIC?=
 =?us-ascii?Q?3wZg/ph/0gn5OyMVd8klrj0VcGMVs0OSE1lYMfcA2upQwK4uXoBjYQR0+/Ev?=
 =?us-ascii?Q?IJiCP1I7IaJjsdREWrBmanTCKvYFgDmmhjSfz5ULpvSGb1QQ1J7LcZxxM4Pi?=
 =?us-ascii?Q?BkVqCrV7WPKSzkgqWoDaIjC5udyeUWYVi63IqI3TWvhXZwgTbHMY1bj4cYVZ?=
 =?us-ascii?Q?32wyjxkW5fMiEccwK7iuWi7FTaUSmqRZfIU3rw1cb7+2/S0X60q9X2IAeiOb?=
 =?us-ascii?Q?Njcf+J3cqiZw2C0Lz3ir0VzGw5KeOJRfNfp4ZboIhwedWHBD2afXn3cBAIiU?=
 =?us-ascii?Q?YM5hfePcOXk8CWE/ptRuYoqwMrLSUYKzw0IFOGlhmdiqbkKqr94QMSF9vsva?=
 =?us-ascii?Q?IS3ehSTojBsSQxQIKiNiR/RIBHMvjXAiHzGrx4+4QFSG21SnKZRoBkCDTfqm?=
 =?us-ascii?Q?PLEyJC5l9SyqR+y1+sYEQX9hDeiDq1YMyrn9NHDunPcMbz8WyViGlmGMfdmn?=
 =?us-ascii?Q?N9/wuUdajl6abKQhec8yMbS1lTvBGF8wjUSB0vtWk+g6UoxrLiKWjsZABpVQ?=
 =?us-ascii?Q?JNkAQksKwaQ+JbnM0I+NiRrUorJUVfQPycvSRUZrifsVckIamrez6nazHbeF?=
 =?us-ascii?Q?DfhDnM1mxLtAI3nlnVfvANrVggGCurzOmCbOOit8p14IQI/2bu8rTb3UPy6W?=
 =?us-ascii?Q?SQs2NJ/bP+41nPzXtgqq/U1BQjzZFyjdGtHY5gCkVu7fU8pD8lKksZy5PiCq?=
 =?us-ascii?Q?5NvbQyeI66TbfSc/W3zxM30=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d373cf3-3453-4214-c558-08d9ae4b3e55
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 06:34:04.4132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrI2HnGfnNpUifOmTrLG/wpvLbY7/4/+i0t88+28GvcvgGQXYElSu9u68DibTAmStiwcJlilabrjmhW8mpeSDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR06MB3587
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove a repeated "#include<linux/sched/sysctl.h>".

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 block/blk-mq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e29b4fdc93dc..959b4cf60443 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -23,17 +23,16 @@
 #include <linux/cache.h>
 #include <linux/sched/sysctl.h>
 #include <linux/sched/topology.h>
 #include <linux/sched/signal.h>
 #include <linux/delay.h>
 #include <linux/crash_dump.h>
 #include <linux/prefetch.h>
 #include <linux/blk-crypto.h>
-#include <linux/sched/sysctl.h>
 
 #include <trace/events/block.h>
 
 #include <linux/blk-mq.h>
 #include <linux/t10-pi.h>
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
-- 
2.20.1

