Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BB6C433FE
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 11:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5717E60527
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 11:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhJYL7f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 07:59:35 -0400
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com ([40.107.92.59]:59923
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230168AbhJYL7e (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 07:59:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5ssyeNaFdXTgAMjvZ8J+nnYbPf2+5vo5rQ6v2GdXywASmrAp+dHxMaFLjMXk5Gu7fcgoD+Ce/J0KIXNPXdS17kDdfQm9pez3XZRQRTp7jOA8wnyKD7TnwcEIFeH93w3wdXHKrWoMO0qFL3fmy01ld9aKkYlY145Bvo6emtW19WGdXWSWI44TDQocQZGuT5HCh2ZzrgrwnlabSDpcw/4pXUP5qR0n3TPZ4+cO1SkHeMeqvYC9C383/XhbOiCYpqnBEBWWFDFu1aXLPRWG5z3t1Y/pECKywNfXZgLTdNea+uxojbU7iFTmv7oHSBbT0zshje6eEPv+Wxqd79httJKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2HnO93UF9RCx5y1A/BDNej+gcK+kdG45Qkb4i974Uo=;
 b=AWn5MTbZbB22yQHhPhE/u4y0QJ5G6qVsbHqJXKI4QJwYzfg4p1Tqb/EqnEGR2Jz5gTHlGtsDjO6Vfwn3vxYMhOXi6oQPYSN4UWVK2Dr/irqDMnAx1GnxexyAx8k9Xn+YkmahPZPnkHC4sm8npVTPTz2OlfroLjw9pe/rwhTD/5ooxXkhqnPINAx+8i3AvbIkjUgXFWdKpX0lMqICEEYmgLPe+y8u5MMvg/4jxUTRrB3pEFL1LpKVRQueqvPtadYLDJTjizOqRbquBD2T3GCCYTyqiOo/iXh/4Hc6LROiaZpSZDERcDNvMzKg6ExNHNq5i5niZTZcDhGReTkZ+YiJlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2HnO93UF9RCx5y1A/BDNej+gcK+kdG45Qkb4i974Uo=;
 b=mpNJCgH4prA2epG9rnW2nZRbiuq3FGOiGLj9GhUX4aOJPGaa+f6wAHS2gcrXoWgOlrZHur93EDTZsJdf5S7gNMuzlzPzuZhdc/lqgSFwcWWRjDxhYWkgt3rASohST7Xuc/KqgrXDyLzx1GOIqP0eZJov1WJqU2Hq/CzmBR7PE0FipoopABlRrs5+tRSb06zLDEl3GEYyUS/Y3ycnY7D8KkHQ+d7m6g34hDn6sbX6fTuz5tsbHg+8pFhpW/QTjUnwtdklKx0XZM5HVGV6a0t1d1lFwRkgV74LIFutermKSyCFR3I9pkKWT5SUIvmvldMVmtjeiCgAKeklPB/if5c9GA==
Received: from BN6PR19CA0118.namprd19.prod.outlook.com (2603:10b6:404:a0::32)
 by CH0PR12MB5316.namprd12.prod.outlook.com (2603:10b6:610:d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 11:57:10 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::8) by BN6PR19CA0118.outlook.office365.com
 (2603:10b6:404:a0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Mon, 25 Oct 2021 11:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 11:57:08 +0000
Received: from [172.27.13.250] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 25 Oct
 2021 11:57:03 +0000
Message-ID: <d7d4fd40-0fe3-6e4e-d9bc-2caf17e1f122@nvidia.com>
Date:   Mon, 25 Oct 2021 14:56:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH][next] virtio_blk: Fix spelling mistake: "advertisted" ->
 "advertised"
Content-Language: en-US
To:     Colin Ian King <colin.i.king@googlemail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        <virtualization@lists.linux-foundation.org>,
        <linux-block@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211025102240.22801-1-colin.i.king@gmail.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20211025102240.22801-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ead4ba4b-b246-4e2a-4412-08d997ae92bf
X-MS-TrafficTypeDiagnostic: CH0PR12MB5316:
X-Microsoft-Antispam-PRVS: <CH0PR12MB53164D3A5F81BABB9B3A7AA5DE839@CH0PR12MB5316.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pptnXmDLCtXG9u8xIAxJ0POFLLdG5MFgF2+ltIOFom2EX7ACtQca3Q454CXKqD3te2qYRhKoB8hchNb6hz2I8BBD+vcTRxRtZGm6NW92pQV3BkO3PYELVQSIUQlmMjHzyI9+CmlyY/WW3R+AR+PeGKuY+iSXZeJDdtkyirahsaPk9eZxsFhQutQnflvA5eEcQjK1QAu3z+V5YVqEMo3N4wCiyCkHxDomn4CBpwmZ4ggIPWBXmuITBuGMGLLeaihBk0gGbShANDLZ7Mpp1stqqwYrwarGZKMYedYD7Gx85Yd65lmvJO7Wa/EDQHzPfoIQNsXXGp+HWUnbzDWchJuRsilt/1OEdQTNJrgPxsQDcycoakN5V6S7+oqL3xDDc2PkCpA/l4eAz5Wh4mCh6HLrgjskAQ/GU0ef2xBCyTsnQvjyLXPg80/asgXrZ71NL3Fe85kMaeO+B+8WY/HqUuVVMAXEwApEL87p1KwapBYlFmhdm3bAmVghY/Jn+SuJ7fahkSaawxTxj90miBAn6z/t22boSBW4gby8ozbILTKjalytmjMxCZyi4IUtYlb9uwD0azXOBn/Pw798JFflKR/T2KxdjAF5VvtFfQkzPXreTuIkrkd/nzF2icTPuKz7se2sjLDOlouKgE6xoTrvMy4QVMKP8zB2/lx3csMWoGwA09rZXp5ULXkJbrv0CH1sUhhM1yFgcF7/ylqV3R/k0NBRjbj19Gah1s/RQX8FyTcsgzo=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(54906003)(316002)(16576012)(7416002)(4326008)(36860700001)(70206006)(2906002)(110136005)(336012)(26005)(8936002)(426003)(2616005)(70586007)(356005)(86362001)(47076005)(8676002)(31686004)(36756003)(16526019)(5660300002)(6666004)(31696002)(53546011)(4744005)(7636003)(508600001)(82310400003)(83380400001)(186003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 11:57:08.9908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ead4ba4b-b246-4e2a-4412-08d997ae92bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5316
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/25/2021 1:22 PM, Colin Ian King wrote:
> There is a spelling mistake in a dev_err error message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/block/virtio_blk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c336d9bb9105..9dd0099d2bd2 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -560,7 +560,7 @@ static int init_vq(struct virtio_blk *vblk)
>   	if (err)
>   		num_vqs = 1;
>   	if (!err && !num_vqs) {
> -		dev_err(&vdev->dev, "MQ advertisted but zero queues reported\n");
> +		dev_err(&vdev->dev, "MQ advertised but zero queues reported\n");

Looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

>   		return -EINVAL;
>   	}
>   
