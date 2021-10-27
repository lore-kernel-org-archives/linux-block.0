Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79299C4332F
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 08:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A62360174
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 08:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241103AbhJ0I7G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:59:06 -0400
Received: from mail-bn8nam11on2065.outbound.protection.outlook.com ([40.107.236.65]:53985
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241115AbhJ0I7A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Oct 2021 04:59:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSmA/3mSuQh6kBsresacvl9eZva50WjrGZ9YaiibZjEPWj8cKk7ctI25MLXsC+vKpJYOptYGkA6dBh1lTiu4I4mdHeG6ai6X9PGd0y68FI9Dh/8/+YNZ0N4OjFMF6han3GfBGQ7sRlkzmApnq9e0jXX7Z/0VlBSRf8aNTIOeJopmhC77xyKgSFYqkLU8JgyUBlqedpPniOWnSCZxW1rSJ98PuYP+OFxOg3WiNBJQr/vQ7kcCFn3WBqJMTdNcQewGgAtlf9JSG+QPlUtlf61H26yuJwCF3Y/vl8COVJwDNNv1NEOBNGQ8UPgkgHh/u6B+irH1Y2BTx0zcFdTx6HF+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdQqzO9ul9tPwXV7ZTGPNb449+haI+SMYCgcUU7C5b8=;
 b=ExMMDOurYzkDkzqqQ0WleA8G9P7ekdw0GtwuftHBbLKSFT6ssxBBiCtDoHveuN0j7+PSS8p6TYwa+s1o+HP4slWANxu+0Wf40QkcMFOtEeJGMVAH+leNB5iUcVLEROAx1DMuUtfddMeV8KjMDHWZgBd8ypwLwNTUC/3+bQBT6yAjAdiKIuVxHXjUVzBG1ocmtwvsU7uT/63gS5I8xFvebhTYxdRakHGfAziNdXsji82IDWn1PLvdbgXZv9XbRiQwqksCTUv4g5hriF2TmzsfXPBQxblfvrlyQha8FS9t48t6wmFunfIp2KveJFoUTArws1hBA3K5i6sGYn7b7MuIBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdQqzO9ul9tPwXV7ZTGPNb449+haI+SMYCgcUU7C5b8=;
 b=Ivuqi1MVm5yHyWf0vdAsjgBDSYQVo2dOrfI/GX7klMcOLHk6pT2eS5WVHWNzf2dBakXw32bxUG1Yrpan1iReG5T0JsRSiQRznlU5SZzzAkrRxZLdIxNvD0HnKlkZtVmRpF8A/CfIdNRqb5rIiDnLN4pzNgC8w3A+nQ+gFObiuHJfhi+5dsift0F5vnx6bl3VJUmaKrgNDujqevf1DwCnhjr9g7TS42plBAdr6uO/oVg1vq5najTiWit/GDbVXj+fa1BE2kLuwmL9dHeGOhJfPE9yvEo8JQg4WkthiCt5ILmaTlKMPkzjpNRwJvudFuU6hHqfzIv5kVSFe0pTpG3HqQ==
Received: from DM6PR17CA0010.namprd17.prod.outlook.com (2603:10b6:5:1b3::23)
 by CH2PR12MB4937.namprd12.prod.outlook.com (2603:10b6:610:64::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 27 Oct
 2021 08:56:33 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::8f) by DM6PR17CA0010.outlook.office365.com
 (2603:10b6:5:1b3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Wed, 27 Oct 2021 08:56:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 08:56:33 +0000
Received: from [172.27.13.210] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 27 Oct
 2021 08:56:24 +0000
Message-ID: <29dbebdd-185d-a3be-6131-c9a471dc8d39@nvidia.com>
Date:   Wed, 27 Oct 2021 11:56:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] virtio-blk: select CONFIG_SG_POOL
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Feng Li <lifeng1519@gmail.com>,
        Israel Rukshin <israelr@nvidia.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211027082433.52616-1-arnd@kernel.org>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20211027082433.52616-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6f5a8a0-a1c8-4962-cb3c-08d99927ad15
X-MS-TrafficTypeDiagnostic: CH2PR12MB4937:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4937E59809BBFA9F2FD23A52DE859@CH2PR12MB4937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PsN2rKMjjve2BqcoaKzBGCX/P3Pa53kcPJKr/RTS42SL+1xzaTDSVF1vjWg5h4ZPIiqfCsUtfDnYiK0X4APjK24IyJ2vvwbbMwz6hjkCgQSUuwyGEeoRhAXCyWfNRBAA6OFyp8n/jw18YEB41NgiIZgQZdlmlvcd2rcNH8aYiX+laxfvNhw4gWfFSZTpXzFGeY+Eh9oBwiSCCLMBkmipAya1G/Z3dl5Z6GtfKDrbIXYQ/Y9s1O9u6/eRrO2MSbl028COPesXVz2Ui6SdRb0oJJdH+/et6CDaN3WT8fWu42rgyhU5+WiuAp/YWo0+IKSHW/6DTy4U7u4XtYR9+gFHuTEGd83KPxfET+KBPJXaLSYgQDm/FXFZWtMZXUNBQmPwsI8mGltpGZdd4Mc58Tvq5YOvmPyKIEpUfOnz5/z8z8BZS3Y4rY9uXPai8Duen+nGni0DRCz937aCRLNefRiuEHYEhaeRJpUuUIr7UtOyTVsqc9ZqmnOmfEDIOIMr7K1VQaVtd5eFXLSeEEEewCcBSVfY31p9G1kKA+Np44FIChSmA9P+U27GCxKknnxUexzNedwPegBIHd18T9EvvX+ccLCFZk6dS1ZnzabZi7IPBulmry3ncl8DKTJevFx0k4bpgVPMtQV2uCLigLYmXl2hcZjRCvPi4hLEr6XcKcR3VR7g8V+dmyxjfoHizbl8atRp3pVVXouWZdWCejZihQjkY4x+IE/G8RsotFy1YpJobRE=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(7636003)(86362001)(70206006)(83380400001)(70586007)(31696002)(26005)(5660300002)(53546011)(36756003)(4326008)(36860700001)(356005)(426003)(6636002)(16576012)(316002)(47076005)(82310400003)(7416002)(31686004)(186003)(336012)(8936002)(6666004)(110136005)(8676002)(36906005)(16526019)(2616005)(54906003)(508600001)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 08:56:33.4387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f5a8a0-a1c8-4962-cb3c-08d99927ad15
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4937
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is strange, I've sent V3 with this code included.

MST,

which version did you take to your tree ?


On 10/27/2021 11:24 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Switching virtio-blk to the sg_pool interfaces causes a build
> failures when they are not part of the kernel:
>
> drivers/block/virtio_blk.c:182:3: error: implicit declaration of function 'sg_free_table_chained' [-Werror,-Wimplicit-function-declaration]
>                  sg_free_table_chained(&vbr->sg_table,
>                  ^
> drivers/block/virtio_blk.c:195:8: error: implicit declaration of function 'sg_alloc_table_chained' [-Werror,-Wimplicit-function-declaration]
>          err = sg_alloc_table_chained(&vbr->sg_table,
>                ^
>
> Select this symbol through Kconfig, as is done for all other
> users.
>
> Fixes: b2c5221fd074 ("virtio-blk: avoid preallocating big SGL for data")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/block/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index d97eaf6adb6d..2a51dfb09c8f 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -371,6 +371,7 @@ config XEN_BLKDEV_BACKEND
>   config VIRTIO_BLK
>   	tristate "Virtio block driver"
>   	depends on VIRTIO
> +	select SG_POOL
>   	help
>   	  This is the virtual block driver for virtio.  It can be used with
>             QEMU based VMMs (like KVM or Xen).  Say Y or M.
