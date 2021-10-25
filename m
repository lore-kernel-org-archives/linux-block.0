Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A765C433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 08:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D6460EE9
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 08:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhJYI1t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 04:27:49 -0400
Received: from mail-dm6nam08on2064.outbound.protection.outlook.com ([40.107.102.64]:29217
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232153AbhJYI1f (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 04:27:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlMUXsHeISHn4jgO9oLCaYMHNSoIs0rZaICmL5jtN0MnrvLDJbt28HiLxXBnWexB3YizoW9g4fZiEAhhR5Io+Ay07OWljuCPYqd14VvJOSEDyeRdRiy7Gw9lQJug5KmqNBUeVWbb4pnehG57TywJHpwFiFGPv3DlzRITWhAaNR4FgIYScn5ZZalzU29EcSMKtcztP8YbpYhesRSBQ5xDU+CZHQxEC4vNd+rvHVR67ykHmXOgaXZ3AqTTyc969ReE3tj2pOxmmxE674apFS7ZgrzKqghDlr+iPKpCnxs8ii+EANnqxFRqWjHkSmm8S719ZsO5QUVfriqM+N4sVK94wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1vRWj+OyVxzzd86oK+EOA2kXN2Kf3mxEsc/hvmWBB4=;
 b=BJ4CqEY4cXj9BYtu3qOUS7utWYhK+WVtzfM3urtnmsW1SMQ/it4ZDItR8hm4mVDi2lDvLXT2c20e3MI6GcGa5stupi1gdM6G4hqyPjXPLafZvBj3fau165nDj1eqYIkghwMRTouz1Jpl965/+6XQXZ02TwnTFHBEXMHYLLbONgZsxyTp1hmR+EwwHIG63qpXcOefQvEODSSLEfvzGHpsSbvnH7G9vOrohSRc8Dbc2CVTuRGLTJjhA79W00hT9eZlOXTNCDBRKL/OihyO3xku0AE2VVYVnnhEqsX7q19XYEAdW5JsEFjiSXeHYhHYqDyPTZ174kSEK2T2AcgMKTBNGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1vRWj+OyVxzzd86oK+EOA2kXN2Kf3mxEsc/hvmWBB4=;
 b=bJJyUdIpNZxLBbnoHEidjMYYaVzIqTHdaAMSgVh0CECgOLbbeLMNu7JMx+hSbkN7+JxCfZR3fOQMAP68b09mO1xYc8ehydglG7hDUzjp3Hoz002lYpWfg9H5nkF3W6mE5NvRrf3jKBDcz8ST9hMTGgE0qCMZKZR2tT9ID8ViCgs0EES8Bd4VQwjNolppnvtgR/mYAuYiZlfZpbvvKoI2hqZELaTZCJou1SP4ViVICXL50cv66f5IoacHUNVI5yoHKN+7g7cwz5G+hyzIVNnWlrXwD9hhK5pR506SkfpDlLX8tYmsEVl4zRlxHlm+3oBXj+65QfKiBCGGVOqCdgiRuw==
Received: from DS7PR03CA0015.namprd03.prod.outlook.com (2603:10b6:5:3b8::20)
 by BN8PR12MB3395.namprd12.prod.outlook.com (2603:10b6:408:43::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 08:25:11 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::6d) by DS7PR03CA0015.outlook.office365.com
 (2603:10b6:5:3b8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 08:25:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 08:25:10 +0000
Received: from [172.27.13.250] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 25 Oct
 2021 08:25:02 +0000
Message-ID: <ed3bcce8-ede4-f4a3-d0a3-91662d5aae4e@nvidia.com>
Date:   Mon, 25 Oct 2021 11:24:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] virtio_blk: corrent types for status handling
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
CC:     kernel test robot <lkp@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Feng Li <lifeng1519@gmail.com>,
        Israel Rukshin <israelr@nvidia.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-block@vger.kernel.org>
References: <20211025075825.1603118-1-mst@redhat.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20211025075825.1603118-1-mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5bab908-2a4b-42eb-d842-08d99790f619
X-MS-TrafficTypeDiagnostic: BN8PR12MB3395:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3395E36E96D5A73A8D8C8BA1DE839@BN8PR12MB3395.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNONlf3yWGPqVaFnYql0LT2/he91/N7poRMVhX6DDFZ5CHmkYJ+YUaSj0hsAq9e36GVLbhg+LIJUZB8/OpYJ6xkiovlwsI7ZtJhtIHqfZEke4TytmbDe2Y4o2hZmzgt3DacOAksOqrx/MrzEm3hdKtMx6lvH1Pg2C9Wsr2H2+SIdZLcxXUSa2/QrfFINeDh1Iw/GYJOXkw1RZXbKd6Vbc68w9dog2nlF8cPJV4z566AHA+LANv4fnds2X8S8kM8EW0wuCc8TYehvJaqLbOR9jMheZ0Hp6/HjJZkXunghGBy8kBZVBHOOqvzmZF6sx9t4lmU0zCfvwkDzgQO29owNNWHLb8SwwF3U4nuaPTb9WxXSF1VhPCUvm5Zv9bIMihkFYA8GDMtZ0iCShCwfoBfNf9touBBWO+tA8IwSpJqTu2MQLP36WJCsFHF8Yg+h/Kqek/LFJXswOfaNF3GZxt5wqlfLpFkj/ebvMMeeeDKfyLXDpRAh4kgjwDB4L4rwzALEktNAGn6FXkCa9pUev1JlXigtGmXf+TTAMMJLZsn90aoWPOoRQ1LhiIjq0wUWzs00dJgh9OlJ2kp0Dj3JfLBdeHaqge1Iow2bKRZUUgv8fnmFjyCZEKOw7CI9yh2b4HTRgEItjAqYtKeVhdvNHulcf76+hdVolc5PE1XwHXGMkUiDEF4e7uolqviQ1rgX+zJMKZUFqyqkbVwj5936phXGc6qzlbGystNqbKP3Dl8UMoY=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(53546011)(336012)(36906005)(6666004)(16526019)(2906002)(7416002)(47076005)(31696002)(4326008)(83380400001)(70206006)(70586007)(316002)(2616005)(36860700001)(16576012)(8676002)(5660300002)(54906003)(82310400003)(110136005)(508600001)(26005)(356005)(426003)(7636003)(86362001)(8936002)(36756003)(186003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 08:25:10.8500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bab908-2a4b-42eb-d842-08d99790f619
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3395
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/25/2021 10:58 AM, Michael S. Tsirkin wrote:
> virtblk_setup_cmd returns blk_status_t in an int, callers then assign it
> back to a blk_status_t variable. blk_status_t is either u32 or (more
> typically) u8 so it works, but is inelegant and causes sparse warnings.
>
> Pass the status in blk_status_t in a consistent way.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: b2c5221fd074 ("virtio-blk: avoid preallocating big SGL for data")
> Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/block/virtio_blk.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c336d9bb9105..c7d05ff24084 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -208,8 +208,9 @@ static void virtblk_cleanup_cmd(struct request *req)
>   		kfree(bvec_virt(&req->special_vec));
>   }
>   
> -static int virtblk_setup_cmd(struct virtio_device *vdev, struct request *req,
> -		struct virtblk_req *vbr)
> +static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
> +				      struct request *req,
> +				      struct virtblk_req *vbr)
>   {
>   	bool unmap = false;
>   	u32 type;
> @@ -317,14 +318,15 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	unsigned long flags;
>   	unsigned int num;
>   	int qid = hctx->queue_num;
> -	int err;
>   	bool notify = false;
> +	blk_status_t status;
> +	int err;
>   
>   	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
>   
> -	err = virtblk_setup_cmd(vblk->vdev, req, vbr);
> -	if (unlikely(err))
> -		return err;
> +	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
> +	if (unlikely(status))
> +		return status;
>   

Maybe we can compare the returned status to BLK_STS_OK. But I see we 
don't do it also in NVMe subsystem so I guess we can assume BLK_STS_OK 
== 0 forever.

Jens/Christoph, any thoughts on that ?


Anyway Looks good.

Thanks for the fix,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

>   	blk_mq_start_request(req);
>   
