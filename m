Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BABC433EF
	for <linux-block@archiver.kernel.org>; Tue,  4 Jan 2022 12:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbiADMQG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jan 2022 07:16:06 -0500
Received: from mail-dm6nam12on2050.outbound.protection.outlook.com ([40.107.243.50]:55200
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232527AbiADMQG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Jan 2022 07:16:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVsu1cvtxiR5yr8lnCkziIAU1RRac7CiVm76XdjImh0qBkG3SIf6UrowwLkmHHl4YubN6O42kyxnJFIYnopXJd4C/szIvx7rkzGK4sRdN/rR61eo/DN3TT8nTpbamopXEG8L02/1JENHOEJ8mq0IBhTYZvTGjfXbmR59Kfst4hv7qRDIfGSISLJJJZIkTD9ht1iaqUCTCzmnbh7rkXvWgqpVw02iSWzwBc/K2+1qQseXMVxQrzjVZIjl1DmBTVsvBxtmh8xc9Vdv/rwCrRd6EJUkbC5Pta43oLT/qEODI20su2Ir/FvXtq4BhdLK7cIyST1G4ipkXqU99b1kD4at0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/7M9FGTvpcyNRsgwn6N873hzGiSTMBzsHveuE3FhgE=;
 b=MRLq2A4XwvoqDCmuNrsx5UpkmGjjNHQrbUQljDirceR7BAn4ows8/bZmeeloldZ6gD8WCDm7lJwB5WsE1IZHjBrM7QYqzip9O5vgx+6GPsbJIHOl+0B682buphRFrGcZhvIoJA6mPOP4yiPMyMMvBvJ+YiyiLV6o4yZg/TADx1tkwMvWv2lx7PcwxMUYv7ROuwOTAv1fh1Tao0YSwF8EI2cqEotJE+qrwqgk6r+ioGoeYkyIcqV19rTTuHpV3JSdIqHToTphtBpzccvicTsFsMBcs48aKkdeB/bYovMj4C/hGTem+S4s5aV5z1O7rGNJFli8wMmZfdTAvm4DgXzMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/7M9FGTvpcyNRsgwn6N873hzGiSTMBzsHveuE3FhgE=;
 b=tYoMJ9MPZmjEeZg2yYiYjeE0CV0VMqcdxz7fERTa3GzYg22FKo0Xv4mpvDj6U7tRuUgpqoxCpkf0CYcpcOrD8Tfp2ZKHIE/JAubixHQkBWKj07Mis/iyLiudJHcsEpjrMHQlbRSldhgh0YHUe2rSLYZ+hUC7yuhTdl3cNUi5PYK3i9M2BGepmVWe9cuga2y7AK3avOMF/bAw8xIBlxcsFEIlMJgqe6oJ7Ppo39R4M/7NcdOe50gSffd54vAtR/yMaP59QIL3fFGdF5nmzrMWnxTuUkl1jABCUqgWc3PP/HL67jO75PC8JKTpOdLLDAn8QFjREWnyfqAg9d+AtF5oqg==
Received: from MW4PR03CA0175.namprd03.prod.outlook.com (2603:10b6:303:8d::30)
 by CH2PR12MB5561.namprd12.prod.outlook.com (2603:10b6:610:69::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Tue, 4 Jan
 2022 12:16:04 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::d) by MW4PR03CA0175.outlook.office365.com
 (2603:10b6:303:8d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15 via Frontend
 Transport; Tue, 4 Jan 2022 12:16:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4844.14 via Frontend Transport; Tue, 4 Jan 2022 12:16:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 4 Jan
 2022 12:16:03 +0000
Received: from [172.27.1.130] (172.20.187.5) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Tue, 4 Jan 2022
 04:16:00 -0800
Message-ID: <ac74ac4c-15f3-997e-ecd2-5e704a5b4573@nvidia.com>
Date:   Tue, 4 Jan 2022 14:15:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCHv2 1/3] block: introduce rq_list_for_each_safe macro
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        <sagi@grimberg.me>
References: <20211227164138.2488066-1-kbusch@kernel.org>
 <20211229173902.GA28058@lst.de>
 <20211229205738.GA2493133@dhcp-10-100-145-180.wdc.com>
 <99b389d6-b18b-7c3b-decb-66c4563dd37b@nvidia.com>
 <20211230153018.GD2493133@dhcp-10-100-145-180.wdc.com>
 <2ed68ef8-5393-80ae-1caa-c00d108aec8c@nvidia.com>
 <20220103181552.GA2498980@dhcp-10-100-145-180.wdc.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220103181552.GA2498980@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52678014-dfd1-4651-cf96-08d9cf7bfac8
X-MS-TrafficTypeDiagnostic: CH2PR12MB5561:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB556133E09444FC15CE9FF511DE4A9@CH2PR12MB5561.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HxqsF7biSVvjMQ78gqf8OIuyfCpNT9BMT60sCLIESJipm0cq2Q9kqZ0jjPWzqR6tiCdEmQQt735h0++ImIN3VqLxWJiKBX1IF5hUc/1RT4tW3J3EKz27Jd+3lauaQOOvsRueIpqzYpxS6bykEK/n1zvggyjEZKS8hWL9YZr1eDbyO3TN/cNdfr6tA40Pe8jr6rxZdYmvVQrldnimdHVUVqFbCyqQH/5pGQ12PCxuelOwSW2uM8MnhrNKkEY5mwlek2RZ0nUen4x0X5h7i4FCmxGG991xjSuLeFW2s5NQz9XxuvYeF7MC1cRCSbibDAylENYGQltCx/6fbU2JV9RRUNSuhh7mBSP6eQSls4GKz5/3HX4dsLRdD+pjkustzIn1Fu8TRKyXgddDwysptwzAQLeIxoN3GbSEKWomehMw+OQ7u+IyWI7I2/JNt0ajiSs727A6unfE1QA+XN0h/wqxvJw6V7D+eZFRTuqs50nQRbgnkvvb0AGuOmd+op7M4WtwOkjVZyKLs5oHD5oDTEdS6tjAcipGPh65cZD1H0vQ12Znq+phZamVbQjS3UQ/+K5uHTtwb8wczMoNPdnrrtXFGYa+4wuC5OpTrpmlhSfcgwrUW6vrs7YJ90axzGQ5/E/lfLiaLP11aZ8ilL7vzBdbRyVvhxgM3YdXEehIblEC8CDN0oYbZHnp2VtuzbFJzlOXSzNufYU46PM0oz2z3SqWOe1EVNDo4cviFNSTX8sv/rAcoX5L0oQna912NbxY/gEafr7JW4pyhaoGuoEogJq16PhivXBY7E8PS0hmxsR4+fVJwSyLjOpifO8OZH/+DFN3ktibFBghWBXYLqYwe8jgcQ==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(186003)(16526019)(26005)(54906003)(356005)(82310400004)(2906002)(336012)(6916009)(53546011)(5660300002)(426003)(2616005)(40460700001)(81166007)(31686004)(47076005)(8676002)(31696002)(36756003)(86362001)(508600001)(70586007)(70206006)(4326008)(316002)(83380400001)(8936002)(16576012)(36860700001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 12:16:04.3933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52678014-dfd1-4651-cf96-08d9cf7bfac8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5561
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 1/3/2022 8:15 PM, Keith Busch wrote:
> On Mon, Jan 03, 2022 at 05:23:08PM +0200, Max Gurtovoy wrote:
>> On 12/30/2021 5:30 PM, Keith Busch wrote:
>>> I think it just may work if we export blk_mq_get_driver_tag().
>> do you have a suggestion for the NVMe/PCI driver ?
> The following tests fine with my multi-namespace setups. I have real
> hardware with namespace management capabilities, but qemu can also
> easily emulate it too for anyone who doesn't have one.
>
> ---
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> index 5668e28be0b7..84f2e73d0c7c 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -41,12 +41,6 @@ static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
>   	return sbq_wait_ptr(bt, &hctx->wait_index);
>   }
>   
> -enum {
> -	BLK_MQ_NO_TAG		= -1U,
> -	BLK_MQ_TAG_MIN		= 1,
> -	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
> -};
> -
>   extern bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
>   extern void __blk_mq_tag_idle(struct blk_mq_hw_ctx *);
>   
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 0d7c9d3e0329..b4540723077a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1589,6 +1589,7 @@ bool __blk_mq_get_driver_tag(struct blk_mq_hw_ctx *hctx, struct request *rq)
>   	hctx->tags->rqs[rq->tag] = rq;
>   	return true;
>   }
> +EXPORT_SYMBOL_GPL(__blk_mq_get_driver_tag);
>   
>   static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
>   				int flags, void *key)
> @@ -2582,11 +2583,10 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>   		 * same queue, caller must ensure that's the case.
>   		 *
>   		 * Since we pass off the full list to the driver at this point,
> -		 * we do not increment the active request count for the queue.
> -		 * Bypass shared tags for now because of that.
> +		 * we are counting on the driver to increment the active
> +		 * request count for the queue.
>   		 */
> -		if (q->mq_ops->queue_rqs &&
> -		    !(rq->mq_hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
> +		if (q->mq_ops->queue_rqs) {
>   			blk_mq_run_dispatch_ops(q,
>   				__blk_mq_flush_plug_list(q, plug));
>   			if (rq_list_empty(plug->mq_list))
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 948791ea2a3e..0f37ae906901 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -268,21 +268,6 @@ static inline void blk_mq_put_driver_tag(struct request *rq)
>   	__blk_mq_put_driver_tag(rq->mq_hctx, rq);
>   }
>   
> -bool __blk_mq_get_driver_tag(struct blk_mq_hw_ctx *hctx, struct request *rq);
> -
> -static inline bool blk_mq_get_driver_tag(struct request *rq)
> -{
> -	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> -
> -	if (rq->tag != BLK_MQ_NO_TAG &&
> -	    !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
> -		hctx->tags->rqs[rq->tag] = rq;
> -		return true;
> -	}
> -
> -	return __blk_mq_get_driver_tag(hctx, rq);
> -}
> -
>   static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
>   {
>   	int cpu;
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 50deb8b69c40..f50483475c12 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -992,8 +992,9 @@ static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
>   		return false;
>   	if (unlikely(!nvme_check_ready(&nvmeq->dev->ctrl, req, true)))
>   		return false;
> +	if (!blk_mq_get_driver_tag(req))
> +		return false;
>   
> -	req->mq_hctx->tags->rqs[req->tag] = req;
>   	return nvme_prep_rq(nvmeq->dev, req) == BLK_STS_OK;
>   }
>   
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 550996cf419c..8fb544a35330 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -1072,6 +1072,27 @@ static inline int blk_rq_map_sg(struct request_queue *q, struct request *rq,
>   }
>   void blk_dump_rq_flags(struct request *, char *);
>   
> +enum {
> +	BLK_MQ_NO_TAG		= -1U,
> +	BLK_MQ_TAG_MIN		= 1,
> +	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
> +};
> +
> +bool __blk_mq_get_driver_tag(struct blk_mq_hw_ctx *hctx, struct request *rq);
> +
> +static inline bool blk_mq_get_driver_tag(struct request *rq)
> +{
> +	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> +
> +	if (rq->tag != BLK_MQ_NO_TAG &&
> +	    !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
> +		hctx->tags->rqs[rq->tag] = rq;
> +		return true;
> +	}
> +
> +	return __blk_mq_get_driver_tag(hctx, rq);
> +}
> +
>   #ifdef CONFIG_BLK_DEV_ZONED
>   static inline unsigned int blk_rq_zone_no(struct request *rq)
>   {
> --

This patch worked for me with 2 namespaces for NVMe PCI.

I'll check it later on with my RDMA queue_rqs patches as well. There we 
have also a tagset sharing with the connect_q (and not only with 
multiple namespaces).

But the connect_q is using a reserved tags only (for the connect commands).

I saw some strange things that I couldn't understand:

1. running randread fio with libaio ioengine didn't call nvme_queue_rqs 
- expected

*2. running randwrite fio with libaio ioengine did call nvme_queue_rqs - 
Not expected !!*

*3. running randread fio with io_uring ioengine (and --iodepth_batch=32) 
didn't call nvme_queue_rqs - Not expected !!*

4. running randwrite fio with io_uring ioengine (and --iodepth_batch=32) 
did call nvme_queue_rqs - expected

5. *running randread fio with io_uring ioengine (and --iodepth_batch=32 
--runtime=30) didn't finish after 30 seconds and stuck for 300 seconds 
(fio jobs required "kill -9 fio" to remove refcounts from nvme_core)   - 
Not expected !!*

*debug pring: fio: job 'task_nvme0n1' (state=5) hasn't exited in 300 
seconds, it appears to be stuck. Doing forceful exit of this job.
*

*6. ***running randwrite fio with io_uring ioengine (and  
--iodepth_batch=32 --runtime=30) didn't finish after 30 seconds and 
stuck for 300 seconds (fio jobs required "kill -9 fio" to remove 
refcounts from nvme_core)   - Not expected !!**

***debug pring: fio: job 'task_nvme0n1' (state=5) hasn't exited in 300 
seconds, it appears to be stuck. Doing forceful exit of this job.***


any idea what could cause these unexpected scenarios ? at least 
unexpected for me :)


******

