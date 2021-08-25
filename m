Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDF2C432BE
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 10:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C39361103
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 10:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbhHYKJl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Aug 2021 06:09:41 -0400
Received: from mail-bn8nam11on2047.outbound.protection.outlook.com ([40.107.236.47]:22240
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237065AbhHYKJl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 06:09:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X88mdaZfE3hNCBqqy2QAEoGQMyw0jiiKinLn3Vz5O+uARIvhZHJbAYz0cgCFqK8XKO63C5227LxDMpUSZJ3zEIf5O7Gj16mQL8RC56cysA+jaPWcJppfA44OM0pkxFP/wk0cY4s5oiWoZWmD3urbPRXsldoQax4oFQOlMBefAAfYNEOkRF1vZmR/hUrfPItai6ZqF6A5/pO0ZIV3OPgzewbNrNFxt0s6GoKn2tWr6FJUvL4OK+4C4BlJXM364JwH4cCt165+GoAHdoFRJsWT5rQPz3UwV+3NNcAHjx142s9TRUH7kCzaIGjT8Q5VqMHHJVjOQdeqTKIE0Cv0DSWQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5+e4dtjeqEZPtU6Q3h3hJGJc9GZv/XaAXZgPfEJI0E=;
 b=bo+TetzqL+cSC/HvLrO1mEbiiQrCba5hs2vQduwQ3ji/LlOoZn5Mxj8zbXVq9tji/Mfc0eUtCcEvwHs2Cy6BXcfFanAFUcyZz6sZbjfTypUFYWxNlFRjFwHuEVIMkP8GoWwlyPmgTLkt46Ofkwcp5Z9FSenX5BcMuN4OWRFwnBQNYIyIefX9hDpyai2ZWE++Puz5KuMa6CY7M6kqyeaN0M57gGkzyXHlFswoKYXiY6cTPPbcoWJpjUxJ8HiJ8E92KvjXsxQp01Q3tIYxOSdOtAmFgESP4sNplAJgWlmpmZfirE1GGy3G1GyTyj5u99bRt+u7iUC5f63Ga1JfgrFZjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=syzkaller.appspotmail.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5+e4dtjeqEZPtU6Q3h3hJGJc9GZv/XaAXZgPfEJI0E=;
 b=niV/zClxUZTRwMB1+4pQ3Xy52RylnDBIlqC0rX2I307XUM4d7K6WiraChs22pYOtrBPKskqzLHAdqHnGjd/ENcYQ4iQyQTvEBkQH2LTPvP7mEK2WlGfrtyEXdFFdbUu+7cTl7r17gIYVcrd2uUm/6BnwOrXlTZE0K8MfMt8ABQsjQVOSEZvgJHeYosJDGqqFGY6I80DSMEy3QmOUo0563vVaC720dQiJlxTl+SLk00uMslL0/PhVAmqgnZwRkDuidk65RpVjwXNao3IVI2VAGAL74+k3ovSghFvyIw+rcSWpdUuyGcsRIBAfeyzzwDZrNNbpgV9hfCNiHjpXXsKFlQ==
Received: from DM6PR04CA0010.namprd04.prod.outlook.com (2603:10b6:5:334::15)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 10:08:53 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::65) by DM6PR04CA0010.outlook.office365.com
 (2603:10b6:5:334::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Wed, 25 Aug 2021 10:08:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; syzkaller.appspotmail.com; dkim=none (message not
 signed) header.d=none;syzkaller.appspotmail.com; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 10:08:53 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 25 Aug
 2021 10:08:52 +0000
Received: from [172.27.13.182] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 25 Aug
 2021 10:08:50 +0000
Subject: Re: [PATCH] sg: pass the device name to blk_trace_setup
To:     Christoph Hellwig <hch@lst.de>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>,
        <syzbot+f74aa89114a236643919@syzkaller.appspotmail.com>
References: <20210825075438.1883687-1-hch@lst.de>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <b6387427-d944-2de6-fb75-4529ac721908@nvidia.com>
Date:   Wed, 25 Aug 2021 13:08:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825075438.1883687-1-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e5f30e0-0b65-4eca-ac43-08d967b0579f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4383:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4383DECAD16087C239A96E92DEC69@SA0PR12MB4383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:304;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GtXryIundd0cQoOipIDIuAlS36COiWYLRtpih5lEqFiQiBBc9KMmeGXYmwgUkutLa7ukhKhHRu2UuZ/3KjIKmrRMmXf4RTRPHJAvqXaMy12Y5CnKiqqs3JXY4DOgsNR+jLqV51R5vGOny4NcwEJo7XsmppyRYAgSCNO4JuqtjXArJEeSZfM2uu5AGP6+/U3C/uU/jPhBnuIN9KPYYAD7jX0QUD7XfDWmGDx5q0WF7g/px5iGU36pzHjnVz53Z+oU6+6iSNS5nm+Ekqr1B5UfY0z31aS6qdGFqVLYCyU/7YaRRc/RG79B1Xm5dv3YQI0+pEOYKVcGgm5gBgpAkCp6S9UDIR/hFgq0yxVIwOYcgjSiyrTusLFhHDkopzvWEGahqxkyKBTw1gXL0XhuYbxMGdOBeVh5zBP1fX0LnRs3St8cIVGGjbieU7fwsCdaIY+Oj6TwIsiu1nN7uI8oCCnxSXi2naHZby0bn8qby8twL8jzV2VbREIC5TAeHdUeKWYpaMYatY9VEFEHmD/oJJq+AA3NX5QhgPh3/ToqYjaXProqb4SwuB1k3vQHTpisocF4wwVGLf/r+pVmEaSkoLNh1wqnslG/iaB+XEkB6vNEvoYAPbvwri7OiQBt19JHp2rdvIDlDK0BgbK7+lxZ4vL6Ynf0/OikoCEpdh0QEHKdEZEuz++HngBO+aZ7zXaWubnwoIEqm89rZUy+WteoMNaTKl/oBs1xNBtAj0fmnL8Ov4s=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966006)(36840700001)(8936002)(110136005)(26005)(16576012)(8676002)(70206006)(83380400001)(316002)(478600001)(54906003)(82740400003)(36756003)(86362001)(47076005)(2616005)(2906002)(356005)(7636003)(70586007)(5660300002)(31696002)(31686004)(186003)(336012)(16526019)(53546011)(82310400003)(4744005)(36860700001)(36906005)(6666004)(4326008)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 10:08:53.0513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5f30e0-0b65-4eca-ac43-08d967b0579f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 8/25/2021 10:54 AM, Christoph Hellwig wrote:
> Fix a regression that passd a NULL device name to blk_trace_setup
> accidentally.
>
> Fixes: aebbb5831fbd ("sg: do not allocate a gendisk")
> Reported-by: syzbot+f74aa89114a236643919@syzkaller.appspotmail.com
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/sg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index 477267add49d..d5889b4f0fd4 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -1118,7 +1118,7 @@ sg_ioctl_common(struct file *filp, Sg_device *sdp, Sg_fd *sfp,
>   		return put_user(max_sectors_bytes(sdp->device->request_queue),
>   				ip);
>   	case BLKTRACESETUP:
> -		return blk_trace_setup(sdp->device->request_queue, NULL,
> +		return blk_trace_setup(sdp->device->request_queue, sdp->name,
>   				       MKDEV(SCSI_GENERIC_MAJOR, sdp->index),
>   				       NULL, p);
>   	case BLKTRACESTART:

Looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

