Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B70C4338F
	for <linux-block@archiver.kernel.org>; Sun, 22 Aug 2021 23:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC57061267
	for <linux-block@archiver.kernel.org>; Sun, 22 Aug 2021 23:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhHVXSK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Aug 2021 19:18:10 -0400
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com ([40.107.223.60]:25472
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233949AbhHVXSJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Aug 2021 19:18:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRNpBIfSljd/zJ+qoUXw429/kj2tUNRkzMJO1t2FzjHGegPv/Wnul03D/huywiBaVLnPBH8J3lt2ZYn0Mv0zHkgWwlvoc8mu+xZ3UqKo6rBs2GWt/xutcxJgXySxeqFdswuYce61DiLjZXJDO6g0g1RBYmxYkSqSop4K+nBVryrj+Ztl6ncmRsaoCQKUD2LywsVpDf1hDl0Xcpn5R7pYS6fW8CvNg5DFKVw10LGkp/Dy0FhB7nsexGm6Q3mPgoH548MXQ2sltKFDACQ61mI/NpL3ntwI4jcfuRzp3hdJ0AdtBcE7TzX4idi79RSSOqfxILmr3FzQ++aLWF3K4InGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdkIo4WX9HjNgblGNLupdbC1wtHI0+D6453hAXagQFk=;
 b=f0vby5VqjQGYk8WdEY6kikeJiixC5eGgGjh2U+2uBP3XEwKCocXILi+pMh21VXn6nt8Gwwt6r8nD/JxkkC8Nu4p9mZt47bn+tnymDVrbDNDkdrUF+vBUqtX3G2AQU/mMegr1xmEVD01bu6YWXAWONKFL+ZsuxckfshhsI6pfajlI+GbjXOKjuPNoMPnKLBa04wvwLqk3UTbVkddKaQ8Hw2V1X3GugeD5G8onjKIPGjM/inrJJFCy8zFSyMfyrYHXtVJbhCJ9qIlTEwOUTVX6jZBFDzvLM7ZVZcMIDH+gpG6g8uMB0KWznI6ZWtP6WZIoSKYvLSuw8+YcnR58x4am3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdkIo4WX9HjNgblGNLupdbC1wtHI0+D6453hAXagQFk=;
 b=BSKhAWbWqF8B74meR3gIttBwM0NPTqk0zGsSfpNZC9R61vqX5vy/gdNYETblYerKe+Td/rwG8E8+ZV71eYsAIxfJFym1XyLIyOVlaXIVnLFkARmDH/1FTN3rBe80uwToxHOCd24CJRKeDkGRyvjuvBPB6O69tM5/Y/sViqswIEUTEmUekHiCsgOWLB8FSTNcjjd/3zOtvx0oQnoCaWIQIeo/xq34oY2ortw4VHUAtZ/6pHbovIPpZ126cjMw4wVapCyGxYDiUlimXboRpqRPRpNQPQavrebF9FUtKXqc5znR7lYNoU9Jcvvnb9Z9i1xwdljcbbRkQzrUrAOuiwb7HQ==
Received: from DM5PR16CA0043.namprd16.prod.outlook.com (2603:10b6:4:15::29) by
 BN6PR12MB1300.namprd12.prod.outlook.com (2603:10b6:404:1a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22; Sun, 22 Aug 2021 23:17:26 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::4e) by DM5PR16CA0043.outlook.office365.com
 (2603:10b6:4:15::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Sun, 22 Aug 2021 23:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4436.19 via Frontend Transport; Sun, 22 Aug 2021 23:17:25 +0000
Received: from [172.27.0.239] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 22 Aug
 2021 23:17:23 +0000
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
To:     Xie Yongji <xieyongji@bytedance.com>, <mst@redhat.com>,
        <jasowang@redhat.com>, <stefanha@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210809101609.148-1-xieyongji@bytedance.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <e6ab104e-a18b-3f17-9cd8-6a6b689b56b4@nvidia.com>
Date:   Mon, 23 Aug 2021 02:17:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210809101609.148-1-xieyongji@bytedance.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f93e9ee6-2a51-40f6-857c-08d965c3012c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1300:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1300A35ABA3603DAAB32A92DDEC39@BN6PR12MB1300.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AZIzszDahTutGV4OA3pXiHORDnmWCc1O2Jt86vPUZUGUFDArB+IgDKLTfKy5VhTX7DPNnShgEeo8y8S9gNTNxqrc8uYjhSjecBjNxXwBA5HQz1i9pTXAHW3wDLvRFp8FLw0iR5Mi5Zc/R6apdVvM8q3I3joE4R32+g0rGn0NHJDrcKt61BmAY4MulHaK7wZlhPGtU5I66oVhmPxG5KcjAEJNCg/UDsJS0lrmemnglDo6KitMA1hbquOMQ8ZNs5M3ubR52zitVwotKfHiKY1IwSWghwj/jiqPPXgtZfgnFIM8T+t5lVr50qQXwPyI6L64TPrpe4DSBvpzB6eSESZeimz2ukibcf+Dq0kd52dngOBZ9Rg5/K4Sf7Y+7u+6/qHPByEDZv3/q1FkIWXQloDw+4hgvFF64/nyA0lIT32t04uSdMO38uZ/8SHp3TZ/IEqeToi+qX4cPc5BhQ+skWbWeJ+pLG5oC4WKYcE6vTn5oq+CNK71EjOvEZ47r9qbPNn9UUgaINzWO8lYr+zAAaOCyzp9nyFGwhMx/a5REpQCd6c4yQldiq44exkQtwR8aESEcql+peu4T20orINXtWJCcDOyE3kYVOSOWDz6vxFgoxpcHJfgtOaFfBHtl7BGfu3+l/9EfGHiy7i3axAxPV78lNFmNAEwwATc/RXzXAJ+/9OeaRxue6Jl0/pLyTwnmTlAGWK0u7O5FTYNC4mvm/PVblBr7BReIHalppCaSG3NRvc=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(36840700001)(46966006)(82740400003)(426003)(36756003)(7636003)(336012)(478600001)(31686004)(110136005)(5660300002)(2906002)(31696002)(83380400001)(53546011)(16526019)(2616005)(26005)(186003)(36860700001)(82310400003)(8676002)(8936002)(356005)(4326008)(16576012)(54906003)(36906005)(70586007)(70206006)(316002)(47076005)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2021 23:17:25.9590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f93e9ee6-2a51-40f6-857c-08d965c3012c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1300
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 8/9/2021 1:16 PM, Xie Yongji wrote:
> An untrusted device might presents an invalid block size
> in configuration space. This tries to add validation for it
> in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
> feature bit if the value is out of the supported range.

This is not clear to me. What is untrusted device ? is it a buggy device ?

What is the return value for the blk_size in this case that you try to 
override ?


>
> And we also double check the value in virtblk_probe() in
> case that it's changed after the validation.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>   drivers/block/virtio_blk.c | 39 +++++++++++++++++++++++++++++++++------
>   1 file changed, 33 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 4b49df2dfd23..afb37aac09e8 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -692,6 +692,28 @@ static const struct blk_mq_ops virtio_mq_ops = {
>   static unsigned int virtblk_queue_depth;
>   module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
>   
> +static int virtblk_validate(struct virtio_device *vdev)
> +{
> +	u32 blk_size;
> +
> +	if (!vdev->config->get) {
> +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
> +		return 0;
> +
> +	blk_size = virtio_cread32(vdev,
> +			offsetof(struct virtio_blk_config, blk_size));
> +
> +	if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
> +		__virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);

is it PAGE_SIZE or SZ_4K ?

Do we support a 64K blk size (PPC PAGE_SIZE)

> +
> +	return 0;
> +}
> +
>   static int virtblk_probe(struct virtio_device *vdev)
>   {
>   	struct virtio_blk *vblk;
> @@ -703,12 +725,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>   	u8 physical_block_exp, alignment_offset;
>   	unsigned int queue_depth;
>   
> -	if (!vdev->config->get) {
> -		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> -			__func__);
> -		return -EINVAL;
> -	}
> -
>   	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
>   			     GFP_KERNEL);
>   	if (err < 0)
> @@ -823,6 +839,14 @@ static int virtblk_probe(struct virtio_device *vdev)
>   	else
>   		blk_size = queue_logical_block_size(q);
>   
> +	if (unlikely(blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)) {
> +		dev_err(&vdev->dev,
> +			"block size is changed unexpectedly, now is %u\n",
> +			blk_size);
> +		err = -EINVAL;
> +		goto err_cleanup_disk;
> +	}
> +
>   	/* Use topology information if available */
>   	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
>   				   struct virtio_blk_config, physical_block_exp,
> @@ -881,6 +905,8 @@ static int virtblk_probe(struct virtio_device *vdev)
>   	device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
>   	return 0;
>   
> +err_cleanup_disk:
> +	blk_cleanup_disk(vblk->disk);
>   out_free_tags:
>   	blk_mq_free_tag_set(&vblk->tag_set);
>   out_free_vq:
> @@ -983,6 +1009,7 @@ static struct virtio_driver virtio_blk = {
>   	.driver.name			= KBUILD_MODNAME,
>   	.driver.owner			= THIS_MODULE,
>   	.id_table			= id_table,
> +	.validate			= virtblk_validate,
>   	.probe				= virtblk_probe,
>   	.remove				= virtblk_remove,
>   	.config_changed			= virtblk_config_changed,
