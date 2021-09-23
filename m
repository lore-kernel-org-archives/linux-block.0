Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04265C433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB1CE60FC1
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbhIWBwa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 21:52:30 -0400
Received: from mail-bn1nam07on2067.outbound.protection.outlook.com ([40.107.212.67]:7755
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238817AbhIWBw3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 21:52:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVWnJ30vQUaNxihC2hRw0A04dPvLAQ5OhAqJyHU6T/KEt2FWeBW1Y6y2wxVnwkh39su7zTC57K/L0piAHk2EEYr+I93txS72NlIfSZA2RF0uP0b+YZ7XJzkoNnn3PAd7rgvtzTCS6NvAydGPh2GSn8KzNORlMHhyi1zHLRDixPFKMHDtyEX4FhkNByHbFsph2x4RS0tkEBax6wJdPzHPYyZjV34SvZ863UPNyx0m+EU7/dP+INvK48ax9raVcVm64vsQ5LQXhfgIe3WUmtplyCgBXSQBiZbU/8kdNPUh9p4upRnWG3AFFUg4mSnqp6wJYopQ2FOJ9jpzMbXZ+uSdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Gl2WszHW5c7knAkG206RrWW9l/E9N/SnUN07GajKMXY=;
 b=VrLpR6Fixy/mzSOMa8U/XjtPwdOyZIWQhJU4wrleIze6gFhKM11RQ0qpjNJaLrCOXAEXgIFhFd/i397823dET9v8QbcqjnV4181DpP+PO5PgAWAzAuuHu/DPfVFsSzHsM5a3WSsIqAnZIRZu+GahAbBAL/4V8tqoaaUeU8XdWl10MwT76f72ugoWF1VUaMy65XhTpKvV3NgtpyZheGw0qaUoP6N/lC/j8bWYw0IzmiXdOCkz9R3WEVXq9sNOjwizOii3Oc6SETS0w7fvV/r0JV8onHQk9XHQzppscEsqmjwQQfOsqsf1nNIul46D8BzTJf1CyERV5jqKkWmCKXQeHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gl2WszHW5c7knAkG206RrWW9l/E9N/SnUN07GajKMXY=;
 b=ItoMrZSIerTC74bolIMHWBGLEv62nszGU0/nv+H39haHmbwVZM2mueFoiDSxB7caxT8PxVr7X+d23qqr8RqM00ffyNURuPLrGkRuaX9Ujox6oBPzM3xG7OkHMjbXJ5JpTcTLa2eKvID8G/vl57B7ioVRHYvJbm+XRigQJrSrX7UQUPmjZ83Jp44BGSL/0pRfcI6y6n10sbimdPOAuTCKf3NyK3Y4ZOdzeAjmxtIt3D2HtDR/gdmpj+eTPmEkSvitG8sHqtVeNRKk1IYIYli+r9cAjQBzY8f9YIpxRABDrXSKF1dYngST1rzeZlNv54k6BnIgNEcMeQZqXC/zK/4udQ==
Received: from DM5PR06CA0077.namprd06.prod.outlook.com (2603:10b6:3:4::15) by
 DM6PR12MB4941.namprd12.prod.outlook.com (2603:10b6:5:1b8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Thu, 23 Sep 2021 01:50:57 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::70) by DM5PR06CA0077.outlook.office365.com
 (2603:10b6:3:4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Thu, 23 Sep 2021 01:50:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 01:50:57 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 01:50:56 +0000
Received: from dev.nvidia.com (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 01:50:56 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH V2 6/8] loop: remove extra variable in lo_fallocate()
Date:   Wed, 22 Sep 2021 18:49:43 -0700
Message-ID: <20210923014945.6229-7-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210923014945.6229-1-chaitanyak@nvidia.com>
References: <20210923014945.6229-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e77c32cc-e06d-4e51-a2ac-08d97e349638
X-MS-TrafficTypeDiagnostic: DM6PR12MB4941:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4941FE6F3BE6171F0F0FE53BA3A39@DM6PR12MB4941.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kCM7Jc0oevMNpXpxJMwTpDKvZoLuL/q2JRYI72085lbcTQExEcONhTnruyTt3ItD2aCEunOUacOsSh6prDbPT3PZP9LPuDJDQto6RX6J1GQ/PuOtIOWPW817ZuNws+WId1d+5GcqUVzrpJ5j2iQSFPQJ1vYEyi+GhEmhUKMsWyvra/neFZ9F1jmmByj4NMYt3aUN0PbsOvp9eYVx0qbfMHBcNfFM50Co22cQ7EXrytzTd80tKKXAVHXE1+ZVmpu5J8ouX5Dvlgk1YjMYXrLfUXPTmRUoYiMOp0AVEoJ4uOteXCHpXd3vUP4VCjpy3t/X+Pbl6dXV4BQp8uHxziLA/aVIUTmTecrh6IVYxY0AcBCtxP9xiUFJo308HqtHy+QjAFEkJTmAN0HLmqH/tEauhAspvtNcwuA2q5CRrqKPzZc43YCTZSagdhVuSfHj3r1mYGBZlPwYCTQq7+yeFpHPwrYDL1CXmlOdF20hm8NqA4GOrGD/T/NFI/iD0pBPkhUvyigoTzFqlTpgdeW+w7dkTc+2XEULhT2JyJMKKTBYtcPQyXAxHln/qySR7qcpjxx97PKSWjhoZm7N0p0nnDjfEkUKV/B9vHQ32hrRsLOuZlpyPLfpuWZP6+hDcl6pNT1cH9gIWd8pNyhpxJh4WxEoYQLCHKR615H+oeEJ3WqzySUPK9ZoIM/p5WJEc0pb0V+OkhW/zI2Dq3GShxPfezFMmw==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(26005)(16526019)(186003)(7696005)(508600001)(1076003)(36756003)(47076005)(36860700001)(86362001)(82310400003)(83380400001)(336012)(2616005)(426003)(6916009)(4326008)(8676002)(54906003)(70206006)(8936002)(36906005)(70586007)(5660300002)(6666004)(2906002)(316002)(7636003)(356005)(4744005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 01:50:57.2159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e77c32cc-e06d-4e51-a2ac-08d97e349638
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4941
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

The local variable q is used to pass it to the blk_queue_discard(). We
can get away with using lo->lo_queue instead of storing in a local
variable which is not used anywhere else.

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/block/loop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index fedb8d63b4c6..51c42788731a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -480,12 +480,11 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	 * information.
 	 */
 	struct file *file = lo->lo_backing_file;
-	struct request_queue *q = lo->lo_queue;
 	int ret;
 
 	mode |= FALLOC_FL_KEEP_SIZE;
 
-	if (!blk_queue_discard(q)) {
+	if (!blk_queue_discard(lo->lo_queue)) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
-- 
2.29.0

