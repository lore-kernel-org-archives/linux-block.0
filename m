Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EE3C433FE
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 14:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA5FC60EDF
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 14:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhJXOWC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Oct 2021 10:22:02 -0400
Received: from mail-dm6nam11on2073.outbound.protection.outlook.com ([40.107.223.73]:7457
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230301AbhJXOWC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Oct 2021 10:22:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AszFgiZCB0EhnDaL6PRf/y43mrUnDb+IkY4CsLlX5RhnUILgG2wuVFtgj9/O+LMUYmDYAQMAWUgAbU5zECH016T/AUchXsqfnI7x2cQ1sa/gBnnBjfPo8a63f9TlnGY5LKBVIQWcQeN6o8pVxSQFGgHSpL+KQattUuX9zTs3t90C5Kc00WyT2Ijed8Nn6wPhW3mJFGlQMuRw5PqvntKgRar3suAnw3d35KZbrIeis/NlcjiDT9IfvQTRuQ4/90BW2auAkpASPJ/cO43Qj+wrzXY/CzlajlSRhbM3DT+z6jTDY8V6iygrmWks2sG1x4eGOS2xBrRK5rlIOaW/fB00tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B/i2bOAbDYGZh/a/5o7p4YKAwI3OKIwSN7jo1KrOBg=;
 b=UPwQIv34lLXNA0PjAftf9YxTKWpwlChY6egMrjsgFXWZ+oXgjLeG26/sK5Br8ufB+XUmgC0H5RYNoy8yBLzvEvwA55T6wNEC13AJjj6Ozr/zxe7Y7N9S/0PfRakVRShJqtcnYnhetDC4aNbauf+MjdECbN4GV/LsGm00aH3+BQ2AhN8OMkXcR9vxTt6XxkcvuzkTMmdZc6qfMBVyVahK/tS8SYkhPCvawqvPbS8SExFtrVB5Ssgx0TWwY60UZKKJyfUhVJtv5l4JdmhfLwOO1b+Y77ZObYxa7gHKfZAWwo44bcF0lf+7jKzvVzXrlTnh0J5cBG1R/ARyooa6gIH/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B/i2bOAbDYGZh/a/5o7p4YKAwI3OKIwSN7jo1KrOBg=;
 b=D/fkzjXbfAWhK0ez5VlkR82djRVxAsj8ysAjmWemaVQOMTSKPX3/xyo1VyRW8PLnxvERBCZKXdzeeb1jmWRnl6LHdBwm0vf+cf2wBd8BelfI33w0NQSr7KzTBwQM92ZIaWZPAx1NaDzlo3dNXfLbIjgKfGUH3k589YUuH9pNOQlMVAgafGL0WpXQQjchY4pphhMd7KZVyCRYSH5TG04wz2u2J64tAxumsM6YqH37P/bZd3qFyFdO/0FJH+HsAVtj5WwXbOHuyP9v+jrIcu8i1s+4RnEwLCYzpho6cEbhkwZlxUgkazs8aINBqg4pl4cHPSciiLd6LOGaFHrRBinlEg==
Received: from DM5PR16CA0003.namprd16.prod.outlook.com (2603:10b6:3:c0::13) by
 BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16; Sun, 24 Oct 2021 14:19:39 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::b3) by DM5PR16CA0003.outlook.office365.com
 (2603:10b6:3:c0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Sun, 24 Oct 2021 14:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 14:19:38 +0000
Received: from [172.27.13.118] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 24 Oct
 2021 14:19:36 +0000
Message-ID: <855eb993-074b-24b9-a184-d479bd0b342b@nvidia.com>
Date:   Sun, 24 Oct 2021 17:19:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] virtio_blk: allow 0 as num_request_queues
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        <virtualization@lists.linux-foundation.org>,
        <linux-block@vger.kernel.org>
References: <20211024135412.1516393-1-mst@redhat.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20211024135412.1516393-1-mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 291d7a3e-328f-405c-59fb-08d996f9508d
X-MS-TrafficTypeDiagnostic: BL0PR12MB2465:
X-Microsoft-Antispam-PRVS: <BL0PR12MB246576C8E0EFA53044E9A4AFDE829@BL0PR12MB2465.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zkFYMfnIlD90olToPYstr1C2cDoIkjX7eMyHZ4iHR/A79saZRUjj/hQyuTvgQRz8ooW7uNeAZJ9tuPXsAI3cjVV72dv5xycy/FqK4ROKsQfTXF9QiFUFfwYMrKMAN/AWULZ58rQkHv316B4vf/rOxGes6/T2DrRuEC/MtPFK4avcaMbA54TEAX/UYBEWfz8wDvIp1iswQFd+b7D5+9KcOvx7+6X8GdmvwfuvoVAbg14H5p/ZqowF/zBUAY0LSk1hDv+YEQdJxNbZ67kfzOuW7x0uXgagqi4u7G8Zi6SFW+kOApdABxhHLlHW3ecRlFY+3sYzrrgwGL8+J5Wpnf2XPrqA6j/DtXvBeqI8uG6fF9mbzNtn0SdXaStGRICX3qkKZSNXcETpHV6/DmopV0IsPI8OxzIf5BHu3YMIalnA2Uq7VOoCDOzP9Py94Tarkp2fje7FvU6VCALbB3FxfLumXpSgKU5X5DRGmQJ+iVY9Ov+e+eihnwnQO/vL2/q6xhgZtQIsT1kGXfTHvxPSwuV4erhIaSe4feBXfvUS5UN6EKDzoFAbwr1I0MUVUnhKEATf1Fc9R64F3AUAYCRM0nz8BCwmIX+RIOPBOa9Gq8j4mmD/fQpLTlW6zQNzTI8AlqklN08BOOtNL0Ob6iXC/TJKw6nswJ+UdMyL02rIBT3CURE/Zf8WzwC4Uw/PLvIpjMUYa2AutrR+qcD7pl8Gw8zXxoJll7or22+IlYcPGolVri8=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8936002)(36906005)(110136005)(2906002)(70206006)(316002)(426003)(336012)(54906003)(8676002)(83380400001)(36756003)(6666004)(2616005)(508600001)(7636003)(356005)(36860700001)(31686004)(4326008)(5660300002)(86362001)(186003)(16526019)(26005)(70586007)(16576012)(31696002)(82310400003)(47076005)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 14:19:38.9561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 291d7a3e-328f-405c-59fb-08d996f9508d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2465
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/24/2021 4:54 PM, Michael S. Tsirkin wrote:
> The default value is 0 meaning "no limit". However if 0
> is specified on the command line it is instead silently
> converted to 1. Further, the value is already validated
> at point of use, there's no point in duplicating code
> validating the value when it is set.
>
> Simplify the code while making the behaviour more consistent
> by using plain module_param.
>
> Fixes: 1a662cf6cb9a ("virtio-blk: add num_request_queues module parameter")
> Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/block/virtio_blk.c | 14 +-------------
>   1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 6318134aab76..c336d9bb9105 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -30,20 +30,8 @@
>   #define VIRTIO_BLK_INLINE_SG_CNT	2
>   #endif
>   
> -static int virtblk_queue_count_set(const char *val,
> -		const struct kernel_param *kp)
> -{
> -	return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
> -}
> -
> -static const struct kernel_param_ops queue_count_ops = {
> -	.set = virtblk_queue_count_set,
> -	.get = param_get_uint,
> -};
> -
>   static unsigned int num_request_queues;
> -module_param_cb(num_request_queues, &queue_count_ops, &num_request_queues,
> -		0644);
> +module_param(num_request_queues, uint, 0644);

Not the best solution.

You can set the param to 1024 but in practice nr_cpu_ids can be 32 for 
example.


>   MODULE_PARM_DESC(num_request_queues,
>   		 "Limit the number of request queues to use for blk device. "
>   		 "0 for no limit. "
