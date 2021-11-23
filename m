Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03288C433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 16:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbhKWRCk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 12:02:40 -0500
Received: from mail-mw2nam10on2043.outbound.protection.outlook.com ([40.107.94.43]:47584
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231298AbhKWRCj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 12:02:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RG+6Qd3FLSEqSLIoAUUjgg8WypLs11lH+uZY56qE0pEN1s7uLGmuVBILSRd6j1VwigugdmmngtPNEdKH7YDEbmJFt0wORgIxD9unvOZVU/99X0RZUyJtVnuTBa5RX+MsiTzMC32TtfXwWgzG4bwCliB5RayInv0gwTv4hm08NEi9KVyjIpogBV0BtyUUPlaQCaYDHNyDGFJMVkjyNUDSukz5/oyqMViZi1x//hNpheXkCAsGWz1s8EjLm0cfKcVjcrg6D8p5SAI+yPCH2w75FuyoIjPko6v80YlgNxyClniL09ZUtAWnGtkfZ5wiXGNMxGfsKcw0rFgOh8JveB4dSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aND5CAkg7ZBIhxfhK30e7Nv9C9x8P6KyKfsFT7B/JAQ=;
 b=Ed32ZsiXWvHpQNNMK11nVSeXw0CMV3hPj62zsrT+QhdHCDzf8qy+0eXbdrIlQ6DlRJ6yrYCirYsCXGpIRUkMTncjE63c2Sh3aT99sqyvgwGEfi0f+yZG6A8heaebYpyt95/CNLwiWCw+11XYGpEi7QR3hpTb456sED/21jkj7zYwYeEdFKrlpyH6P5TF8Ddf6+gTVBOK5Jn137DB1k42Dffu36XLOVHJ/Kx4G9RXAgm1VrZeDoDJkgWSB9p+ULSi5EEsetKNAAbVHaFX8Rra3KjVUmVPpnwH4qJaGjjSAsKJKsctTwh3E7xp5hQsBt2M7l+AKW7Z7q5gpggoF5bv8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aND5CAkg7ZBIhxfhK30e7Nv9C9x8P6KyKfsFT7B/JAQ=;
 b=I7LRef2iWSPiL9KtaXHxnDW1NR8OjAO7c/YAYRVi/oNZdXG+rhVIWk1Wm/q7l8ABYoKy+nUm9yaNPPLJr4riUc3J1W//cfAGZ/Ee25EdUX6YwDOULw8pSE8QkA4d4q84x+ecabPEvCvBMNle+orKO+s23AcxYAds1Sakggam7pSSTqGzj/Q5juaT8jB2UUWJ1xAKYObcW6ihO1o66e5aZwqWCIYDzJDo5r4s9err0u1UB7ZUtnaxvfr2SO3KZjZabIEWnLqrgl5w6LzyXP2bcB+mGiJRcNXlKUWX/pyUd9OoIgLZm2mQlqTB65bnaoV2/h9nHHX2gSvd+2BlJY0t/g==
Received: from MWHPR22CA0067.namprd22.prod.outlook.com (2603:10b6:300:12a::29)
 by MWHPR12MB1214.namprd12.prod.outlook.com (2603:10b6:300:e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 16:59:30 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::58) by MWHPR22CA0067.outlook.office365.com
 (2603:10b6:300:12a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Tue, 23 Nov 2021 16:59:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4713.20 via Frontend Transport; Tue, 23 Nov 2021 16:59:30 +0000
Received: from [10.223.17.132] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 23 Nov
 2021 16:59:25 +0000
Message-ID: <b61ec216-09c7-68cb-6ff9-dbfbbc274dfd@nvidia.com>
Date:   Tue, 23 Nov 2021 18:59:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] virtio-blk: modify the value type of num in
 virtio_queue_rq()
Content-Language: en-US
To:     <cgel.zte@gmail.com>, <mst@redhat.com>
CC:     <jasowang@redhat.com>, <pbonzini@redhat.com>,
        <stefanha@redhat.com>, <axboe@kernel.dk>,
        <virtualization@lists.linux-foundation.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211117063955.160777-1-ye.guojin@zte.com.cn>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20211117063955.160777-1-ye.guojin@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f01b15e8-b860-46e1-016d-08d9aea29dbb
X-MS-TrafficTypeDiagnostic: MWHPR12MB1214:
X-Microsoft-Antispam-PRVS: <MWHPR12MB121404E5047ABE1751FD20F7DE609@MWHPR12MB1214.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:157;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EuSpZIU/GN3hV/hTviMRYdyHyYadbzc1/9kok0PuZ8wZtOX0St63wSAdzmhj/IJkNR6wWIhNRKOwpoQrd1bBHahQ5Qf1sXyO1cgHEUFdV89FrU9ZZiQpGvjyjHZGUJCh1JSHTy4tbbbgDA5kgH2Cbd2EjhqOhReHeqvqZ+Xb9E4Qf+0f/BHyLrwXUJu2jiFvncg02fiDpq+1UR7igaHEmvIX8pZHJ+lyv+NBLsq/vmCRnZjccsz/mKoZcV9SSkuo/SNFnmGYLBK5NOqyJbruu1KDZnghhARatKcYUIi0WkqOM0dOgWsB3AuRxdW/bQ9fOx3leWL/phnojgD7yf8on9ZpHvjQv+ZzFRu+KaV1xhIswS8X4hKbPdK14LWdi648zHHw+59WiQAtrVzWbwpWy14rFKgbXWKKePv200EASHcwbePIkWvTvRf3nEvEeF6Qgd7TtM5xII3EUnIBjctY3CGp55cP4V2ezvj+akiKegi7MI/p1nR6Qo0rAv7wFAB92WTWKnjAzeaEM2J/NsATdnHCDpoNAmmqeJLGsysXrU5Q8LetFOXnqIIMAmAEv0t6/z7N+b8MQTa+obcufOKNTssWKr9vB05nRIvq2ebIHHk2B4B1APnw+4aX49EwW0pjYk+577+y7+lqFyZaWGPU7BeupJ0EjZ2uz1sDiTOKO/lndY+D3EcQ1MFWyw8Se5YGzCteWCBhqxLAMeaBXOUfarXa/lvJ++lRKazR3inK8wA=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(356005)(7636003)(70206006)(16526019)(36860700001)(7416002)(2616005)(53546011)(8676002)(70586007)(4744005)(47076005)(4326008)(336012)(31696002)(186003)(426003)(26005)(2906002)(5660300002)(316002)(508600001)(8936002)(36756003)(16576012)(31686004)(54906003)(110136005)(86362001)(83380400001)(82310400004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 16:59:30.2719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f01b15e8-b860-46e1-016d-08d9aea29dbb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1214
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 11/17/2021 8:39 AM, cgel.zte@gmail.com wrote:
> From: Ye Guojin <ye.guojin@zte.com.cn>
>
> This was found by coccicheck:
> ./drivers/block/virtio_blk.c, 334, 14-17, WARNING Unsigned expression
> compared with zero  num < 0
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
> ---
>   drivers/block/virtio_blk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 97bf051a50ce..eed1666eff31 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -316,7 +316,7 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	struct request *req = bd->rq;
>   	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
>   	unsigned long flags;
> -	unsigned int num;
> +	int num;
>   	int qid = hctx->queue_num;
>   	bool notify = false;
>   	blk_status_t status;

Looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

