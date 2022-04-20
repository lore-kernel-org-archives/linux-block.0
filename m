Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98785C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 04:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbiDTENx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 00:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiDTENv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 00:13:51 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9762C167C3
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 21:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgNX+2Ot8bQDSuKVs3skgDerByQHiL4Hr+oXjatQ8VVgcV1hivYfXg/3OsbyftzVBnFL3Tlycgl9zQ/JMQXMcuVtKcWqS9GXNsW57eKRW+OU34PsTzJiuvic13bMzodtnMvXs+poCntZgvprAhewYk79DavAjnheTX5fANENWFnllPYTD+rWnGLGlskuSFc1WGvH593YBbenXSD76D4NMI2LazuvFdGVb0SUMAwKikKBceS2LEC+Y7zxYphSWmag+LRQ0UW5hREvUN+B7b4vfeqC3i93Y63wxUMYbopeSs/6q5IHhd9+3GsHFJHWrRNvbdQBrkR7ZS/IDv1g4Y0NrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tvb2nwxAElf8EUHio/V5rZOr8ao3Uduw/wW0im5/74Q=;
 b=Z51nAsIaI6wEBt2KefOkojSzJDTX8exttw1Ehq6gQLLuRuer4DgSPscX9/o51Yi59vxbfdXAlsMKzMI/s1SqE1FHONAQSHCKVHtMhTYS1AcEwmFKe+piEuLmMnZZY2l+ojsKesiDbqKMmYVpqtH4lpy+8Oyud0JqHN20YXXQOybCXZzu7ZO3wAcw323rmlW9DElXtLOpf92slCl54DSI54rvg1uNqzc/rIP67ruf8uQkvKBsQsQ0rUXl0biaAJTmsaFu86yBA3HpMmxmC22q60V1O2DpTg2s6a7GDpaRQ8jdF4Vpx1efKiGPloxLX8ahEarLxvxQedWy6YFjvt8qcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tvb2nwxAElf8EUHio/V5rZOr8ao3Uduw/wW0im5/74Q=;
 b=Xy1BdyhAki72/VYdZ6Rldx2qWIh8sLjAN6D52mV9kx4EpdbW46oioZMuqeIVccSav5PqKi7vUe54WNAa2OjWSYzxB3qMSSE3UYWC8gNx71GYgj5qjwStqySJWB9ZmHLMHTq20Rb3X10ZdqUg9sW0yEWhfB3dSPthTbd3lE1R/3MYKSnXqo0fA70ITelBelvSTf70nyK7z3qhp+wMaa4ZCg4K8/ZqoA08GDpCMfa8urW8zjPXHFJAVCWIRhSFemx4yyH7+WVNcNyx4jAkc/GLvTUUo8xNUq4rBTXL+OvOXwNAM4rqiTCP8l2Bx4+zkPaeIPsaeSjiO8x2LJjh0S+KFQ==
Received: from BN1PR10CA0004.namprd10.prod.outlook.com (2603:10b6:408:e0::9)
 by BL0PR12MB2531.namprd12.prod.outlook.com (2603:10b6:207:3f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 04:11:01 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::ef) by BN1PR10CA0004.outlook.office365.com
 (2603:10b6:408:e0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Wed, 20 Apr 2022 04:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Wed, 20 Apr 2022 04:11:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 20 Apr
 2022 04:11:00 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Apr
 2022 21:10:59 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <pbonzini@redhat.com>,
        <stefanha@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-block@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/4] virtio-blk: small cleanup
Date:   Tue, 19 Apr 2022 21:10:49 -0700
Message-ID: <20220420041053.7927-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a168de30-ab7e-4695-0469-08da2283c7d1
X-MS-TrafficTypeDiagnostic: BL0PR12MB2531:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB253157538D758DBA2D82BCAFA3F59@BL0PR12MB2531.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tg/vT/LvEc8JPsvwTALal9KbzS+8X0wg38UEAOQx/4xJpknbrKfEzauTEpMBkt+52h3F9u8XQMZn47fdJjrtI7053WDMMMnZkclSKOBEy8clIf1zkkP/c+vCjGw+uQFnf/dQir4Iq123PcjhYztx7f9dAVupWfxOjxZ2hABosCfrE9bnCfwvJM9HvlIb1CI93ZM8uVrMXV6R+ZbcXeL+N8z/dqfLal8kruHP1j2h03H92ZGAdPuWXcJtA+SjlDxbC9aP23Ma4+QDYLYVyfaar2WWWgQyyV4Wrl2ca9F9lz7f+rZQRu5CO9TOChy25IK6SbNeLZNUDXNdWorgshYR21YxxhPFhZZpAY95wj3JbK+S3oHd+6fT9EMpNmVzcHzEIasnz13jJ2k/L+CjkPg5GL0Pkz4XJEkBMbEGeix8r9dBX/HjTs4CEXmSyvtYO3Yr94QsfsXnvUVtT24AsRT06LySIBX6oeItGRG8AFTEtwWGE4I5GR7FoU1K+Dp8JIByn2F/kQuqIHeFRbrqiN1XhkxbxjApT8r84dAP1AiCVhfEDp2mb6isJDfkLuIwoLRb/4Z1ytwkfpSNtU/lK3cZkuRtcwVYjt1nG66R23SeFCcPuapep//dpIJrVCjyV/teV1m5gd/tNzbzCQSSUR0tWSvIkWta7SyUkpajjS7PoI0qPyGjVyaBF94DZWCg9p3oL1H6AwKUYPrtbbCc91zPsNME7diG9mli3+ZGLGxAFBI=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(70206006)(16526019)(110136005)(36756003)(4326008)(70586007)(2906002)(186003)(356005)(426003)(336012)(81166007)(5660300002)(2616005)(8936002)(508600001)(4744005)(47076005)(54906003)(316002)(40460700003)(1076003)(8676002)(26005)(82310400005)(83380400001)(6666004)(107886003)(7696005)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 04:11:01.2895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a168de30-ab7e-4695-0469-08da2283c7d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2531
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This has some nit fixes and code cleanups along with removing
deprecated API fir ida_simple_XXX().

-ck

Chaitanya Kulkarni (4):
  virtio-blk: remove additional check in fast path
  virtio-blk: don't add a new line
  virtio-blk: avoid function call in the fast path
  virtio-blk: remove deprecated ida_simple_XXX()

 drivers/block/virtio_blk.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

-- 
2.29.0

