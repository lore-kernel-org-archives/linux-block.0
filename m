Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B605C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EFB560FC1
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbhIWBwT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 21:52:19 -0400
Received: from mail-bn7nam10on2054.outbound.protection.outlook.com ([40.107.92.54]:27195
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238851AbhIWBwS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 21:52:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCl8YMLOQm5saCGdARuMEGnEJ0wh0s6SZ/3nuGJqHTUHcMtuan3bh4xI8+4EL/ky5IgHjq9818mYt9lbY1D1Yu8wNVJ7ynaI/HTSwkD6LfUAkYK0/DOpejiEqXBtmUNrZpoemdHuM2W05g8+jEpQvqz2CiFrHh4n0fVTQL0B3hKdaJN8FmRmzhZLnATesIak1t5U8ZgXsxvE6SZepvQpQGu/spo85EtPAw86klvAWlvE0xVbbG6jnkWFDyaVUMoEuTEviPj3E/Jq45Y9LsC9mnwK5OJYJjS2Mm2mt1Xp+fpDKZ9+f1f2HgE1GJaQa6eIVm8/HdqE9UXw1NQjNLlyaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nX0yX4mUHKisQ5aNL2ia0giEMlIMY3Jgr0TKfmnzng8=;
 b=dqx4YHH4P1LL+jlt5krb3KcmhQQJDBRQuVH7Qez5X3sT056F1mxpCVJC0yKye1gD4JA4iO5+qid5whEP+vl8+pGtQUNOyXtEa3/F+afFhneVvfri1YaCjhCWiAkTM4ikIcRADGfRk/LToo0BT1dLzqV/jkLGci45rxdriKeAQnAiBEDMY9fiaSr08gfvgDY4z02QWkYkFcv/pORJVsgwYp5L46UYIMb9JN+fZE2yNJf0/tYNyL0TPRtkV0DHFMBjsY0n8ut9jAfuPm/TSbzfTQ1DD7KScA7i68BgsCqE2gXPB1bJbWYPXR6zz3Ni4danq9muOpHmUNZSXbbU78yabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nX0yX4mUHKisQ5aNL2ia0giEMlIMY3Jgr0TKfmnzng8=;
 b=eN681u/zqqzvm876L5Xz0ZgLfiIGSigaxc96UxJfdHSj7jM63Npu5KUCBlB2PoE4gdcdoWVKkg9Hw7HOj9jKQ6yFiFWrtaXPTvc/MUA7KzIo4rN+pfTF0x36hS4hwlyPPqgZlsvRWrAm0X4cKcBirmShy/kIYqdexJd9QfrBak5ghQrTarbdB2i0bV0cwvJxoBH3F2eXMHFhKI2pfVCjCxX6hSm8hI0ITXCKD7SMhYwlYQDKqBG7u2jAlmefGoQD8VfTq4a1lhzLAPgab3cOCeumlYQqEKW73VgussaAUZ8esHoLDfRmeZBN5dYZRhya9sPcj/TXoYhhGUgSfOgi8g==
Received: from DM5PR21CA0007.namprd21.prod.outlook.com (2603:10b6:3:ac::17) by
 MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13; Thu, 23 Sep 2021 01:50:46 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::94) by DM5PR21CA0007.outlook.office365.com
 (2603:10b6:3:ac::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.6 via Frontend
 Transport; Thu, 23 Sep 2021 01:50:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 01:50:46 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 01:50:45 +0000
Received: from dev.nvidia.com (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 01:50:45 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH V2 5/8] loop: use sysfs_emit() in the sysfs dio show
Date:   Wed, 22 Sep 2021 18:49:42 -0700
Message-ID: <20210923014945.6229-6-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210923014945.6229-1-chaitanyak@nvidia.com>
References: <20210923014945.6229-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a59bf51f-80c4-4a12-136b-08d97e348fd6
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:
X-Microsoft-Antispam-PRVS: <MW2PR12MB25550BEBE8E127AA90370B29A3A39@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tmdr8a5h4rOwD2enYgKHohbzv37KTI6JwjiH/ad/qJ8akCZYZi0ks6cSnQc/S9OuWkWR6Xa1q4n9PrxQaNblehYi1F2ZrecQ9OIBy3UalVP47T1wjPOwmJt8tY0C7y7cXJ/Nktuq5E88X0nzUsoOXgM+opAjDlMLDN6USEZrnVmsHYwooY8k6FUuJmZqHxJV+XeZhNmu45m9JTophWwBn3SgoEjdHaUO/ihPRnwJ6LW2DYKv+Oetxbzx1YxBBJrQxJVTAAjzSY9AQdaJ+KMvMijfGredMnPmF4YQKWZSfkwCQ+6QiAHYnYv50fX6jVf/T4doVghV0/wAmh8tTCfY0dRYu7NrpVjFfigNmdbkan77NCyrAlc8CKqs00wFNMGGExpEpNTPP8TqPbEOduBcdmtZKo3AgIqMkTUu0VDXM6Bb86c8sjqQyQfjx1P5bNT1NU8J8OHuhlNk3cclPgs2QBIQfkjPUfKDa1kIOxZJ74YFYOq03fJxtl1odsTYxoQiqrGKTZ8tjQWa2D+6Rw5+dnHbzA9DOuRNTF2QY2e7008u93m83H9DmvHcVZQhrI/aL01uWIOiMd3jMKQl2Mgl4tBYvxf9jwcuXC1XuVGSSc8PBRLMKMU0TyknHcNB1SvsDt3qrgp4vVHOTB72ofqZY+xeyU8ZWtTLn/yFiir76eKlAaWuw8kfiPFgDOgi0mGeC9DvtJyzJ2T6B3YtJOx9g==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(316002)(82310400003)(8676002)(70206006)(86362001)(36756003)(6666004)(36906005)(5660300002)(8936002)(7696005)(4744005)(336012)(2906002)(36860700001)(47076005)(426003)(4326008)(16526019)(186003)(7636003)(26005)(356005)(508600001)(2616005)(1076003)(54906003)(70586007)(83380400001)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 01:50:46.5037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a59bf51f-80c4-4a12-136b-08d97e348fd6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content and it's possible to overrun the
PAGE_SIZE buffer length.

Use a generic sysfs_emit function that knows the size of the
temporary buffer and ensures that no overrun is done for offset
attribute.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 63f64341c19c..fedb8d63b4c6 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -882,7 +882,7 @@ static ssize_t loop_attr_dio_show(struct loop_device *lo, char *buf)
 {
 	int dio = (lo->lo_flags & LO_FLAGS_DIRECT_IO);
 
-	return sprintf(buf, "%s\n", dio ? "1" : "0");
+	return sysfs_emit(buf, "%s\n", dio ? "1" : "0");
 }
 
 LOOP_ATTR_RO(backing_file);
-- 
2.29.0

