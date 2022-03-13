Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAD5C433F5
	for <linux-block@archiver.kernel.org>; Sun, 13 Mar 2022 10:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiCMKoR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Mar 2022 06:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiCMKoQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Mar 2022 06:44:16 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229686547
        for <linux-block@vger.kernel.org>; Sun, 13 Mar 2022 03:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=je4dl3hUluEkZG5UzKrNOYT7kkVuDzWLnivvUTSQvuoOwDjFqOiVKlhKR3rVhaKbYsAeoqhiEsGCzOBHthTikzBmaorLTrB8if2DpmT+vRpUPoNh4CE04hZ07De2qM4sNh/yPiEykfzMSqeEISNoeqxiTgjoXlB/s+NGi06/6/NtkhTKNZY4Kx9kBYhVyZSbqPySz0wKG0LNqPyvHwo1xLikTMT1/9+BWj52V/JpV7oqSnCYTJgmN5favFtKGSAyG3lwFwMzVZgEiOO9wElWtifs/H2kWKKsOQRvvPWIzP6QpCwb0oAuaAMtfdJI/+XzXUDtaG79ZH2r3rQlNMdMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0cZ1sNZvtn7gGHuWy2fnKcWwt4aQkPduIIy32hSg/k=;
 b=IAzwdG5ixgP5vSTKhFhXlcCnsdmK+F2UB5dfYJW//1eE4ErPk6O90oDxmRuWint/7kukwwDW4+aVcD6o+pjk0sfDYzJr5MdV33K/86aS9+haeUvlUsoNDxQ7iwtQN4tWWabcXwtwxfc3RiEadvVN0+o8S5TmsRWfMyXGU0GCfmin0+ycXrkfpXUFl6RljnVoLin1P7yXOOVcZuD55QpVbs+1TbP9id0gZJocThDVt+jUds3t68vDAOX1/QNikH8EIX/odDLQTR+t70MT2PyJ/bSg5fVS6shitsXCGn1oteMsp03YlT0Hbj4DP7BhJi3OJoiCLJcZazVNDNTqSL1pFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0cZ1sNZvtn7gGHuWy2fnKcWwt4aQkPduIIy32hSg/k=;
 b=qTXgtXgl6IiRAL9dsRRDhoQGLAF664ui2ik2zppSGvlEhxeeWN2ozBOfMxoKh16qCvIqfodhshqaDc2oAsoKt13DB9uDAWwzreydj7nwSH1OK8KGrA44F56avb5/Fq3GDEp51PESliqjQMW9JzaKHErnzk269H2zVojK3vRKi9EsYyceeQCaT83EJbrsT7XH0Ot0oQfCA1tdL3jQStU6yK+HGT3wADkmiuOkJPu1HdunNayFQNq3f8CSzJAB024N3LQDTEtspprrgelkdumaESsMhO6h8/c9C2Il9+UStn/EyM+ayUW54JnMjkRrahRcEP7ZmBFAMjgfU+uYxFvpog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Sun, 13 Mar
 2022 10:43:06 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%8]) with mapi id 15.20.5061.026; Sun, 13 Mar 2022
 10:43:06 +0000
Message-ID: <c851906c-c619-4e87-3272-9c41ac256052@nvidia.com>
Date:   Sun, 13 Mar 2022 12:42:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] virtio-blk: support polling I/O
Content-Language: en-US
To:     Suwan Kim <suwan.kim027@gmail.com>, mst@redhat.com,
        jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220311152832.17703-1-suwan.kim027@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR05CA0016.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::21) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb942fdc-c311-489b-94ab-08da04de41c4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4357:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB43576BBCCFC4143C0E2A19DFDE0E9@MN2PR12MB4357.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3LGgZ2hv9cKc0vmtE2L965aGVXiAG70IvJ769Q2QH0tRkbly1CnBDPVsgUC2g3xs44kMWgDDFL8qO3JS0DTS0tVWYJHrQAH71bGklOc6RUllY0jojijDfbzY9VfrLlCibHSBawKfwnreYrZHvnxe3UIJPLuNpfCRiga9cLlf7SkVTsfNe01GrafMpEmiYIbyrGQzdE4kItC8hMiBH+dAKL8sF/5nGpFplxj3UCQr2pcbn3FL4N1eZYcSKAAA+vpePO8RMpewkemCw+Q21dgQjceLNRSgkx762aDDQv5qpBFH1vvxEQrJXtvoE6Ivag98BCSLirWHXBhBOI0p8GQ6CmPTvn9kI4kHqnqymdUKMqR4lkjQ+lprMHjyRUERyov3rlaovLkdIKaXbTexRaoZ5TX1IyAJjm3g/oOtNoscLboP7gzEnF93NP92JQtXszR8yqi5BwoV6+4x9ZXftWy0kVI+RBjbrKPU3r6vUpOrr2Tc8pGr+dgJDpBRFs7HS4U4ViT3mk7sP7U4v6i4MEQ8h/zgf1UGmilRiYzT9eoETk4mP3oG20uaChpnt3VzBVFy16HEF0upDDTH9DDpDJw0ILSpUiXckW1Ppipt+uGKzYobcS3LVCKyGWAkpapkNsJUWON4CWJrevhVE2I38ruhi23PKHGPkandYL7Q3AcHM7apQ73pzdhUcI1D9cBpC3VsaXZ+g/B7UHN42Dy0pf8RPoe5WF1xPrkXbpRc8haEbqZNP05sEePN9giX9xHUSbt71CsRENXx0rYQY/4SoUqCQO+Z/6Z2PyX8isLFXr05wP7lpJtqxyvxi+vIwy+iVLt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(8936002)(5660300002)(966005)(6486002)(316002)(31696002)(66556008)(186003)(4326008)(8676002)(66476007)(66946007)(26005)(53546011)(38100700002)(6512007)(6506007)(2616005)(508600001)(83380400001)(2906002)(31686004)(6666004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm02RW9vWnJubDNveUlPbmZjQUd4WHZpakNwVEpJQitDMkxkUnZ5Y2dVREs1?=
 =?utf-8?B?STZLcG5wSjMycDJWaTIwSjZPVkxJdWsvcGRTQk13cnNIV3kzczZYelFIcmRW?=
 =?utf-8?B?b1pjcjMrVzlyNzhXRUh5b2dDQlphTm9od3JXenhOUzQ2Q2xHdU81Vll6ZXpL?=
 =?utf-8?B?amhqTnFCTys1RzAvZlFBZk1FQkM5SU0zRFlUVmZ2WWVvdkRhVG5VRVVkb2k1?=
 =?utf-8?B?OVhGYlRtdHkrNnYrL09vZEdvRzJMNFk2UFNpUmc5RGErdjVMWTFqSVpvSG9Y?=
 =?utf-8?B?eXJvaS9uQWw0SmdDL0h4bmhDVEZtZ0FvejlVOGp5OCtYMS9ldUhjZTRWZzVl?=
 =?utf-8?B?MVRORDlXZ0xjNy9IZFlQZEEzTVRBaVFpSW9ndDZ1V1JHT0huNVlwQnZGS0xD?=
 =?utf-8?B?VDAwbjBNZm9tbGZhRzB4akYxbThaTUIxenFPczM0KzZqRWNNSWd6YjhQRGJv?=
 =?utf-8?B?RktXQ1FQNGxWaFl2czdaWGJIbEJoQ0RkVHhxRjVPWjRsR2ZDai9mbHNZQVd6?=
 =?utf-8?B?VlVtSlBXWUswbkl6ZU12K2Y2bFN5ZDhvWFd5aHlaQ0loZ1UzNzJFalI0SVZZ?=
 =?utf-8?B?Zi96OXh6ckZudUR1L3RTOGVUTWhiZDBtS2drc0hpSDFiL2d3ZFVqeVU1dG1k?=
 =?utf-8?B?ZVNlZlBFNGtzcXdSV2lEd2poYU03WEtMZU5BNkdmSVZPMCsrWTZzOFd2aU0x?=
 =?utf-8?B?SjNIUTRubDVVbUdCdTJrWjNad2Z3SGhqSEg0Z3RRU0o3SDg5Z3lmZWhXUmRi?=
 =?utf-8?B?MnpIQm1xYXRQeHdiL1VkRXNVaExUcFZSbllsbVExcENqS2cxSmRIZWw2SXNt?=
 =?utf-8?B?bHMrOHFGQ1hqMXhzVVJiVXF4aTRuUk1FclQzeVhvdGhVdWNsMzUyQXc2Lyta?=
 =?utf-8?B?WlJpc3VOazNjN1M3YzZZZE4yYk51TUlLejZ2SEpMKzhjZVZRMWJJR1VsTDFy?=
 =?utf-8?B?YlJZdVp6V2JSWXhqNm1Eb2U4eDBIRHJZUmgrK2k4NkRDbzh5RVJWMURuODBx?=
 =?utf-8?B?bXdBVUdyZ1hJc1FSajhyalM5aWpvSjhWS0xLaUY4T05KbUtmOXRKS0lEOU41?=
 =?utf-8?B?QUt2VThiZW8xNlp6eHBiRm1ERExGckZYUzZta2wrVDNTdGkrY0FTVmI5dWFB?=
 =?utf-8?B?SUplc2JMUGpQSFBENDd1N25RazhhMXJ3S3pxQnhxUGZQOGc5Y3RiWWtmZkVw?=
 =?utf-8?B?T2M0NHZ2UER5QVRaNGJZM2RuQlVScXFjbVduNm4rcnJUbk1QYVlhbzlKUUV0?=
 =?utf-8?B?eTN1WUU1OWNZbjdOQXdDSkhramt4c2c2ZkRGcTFxVWNTdjVnRForU3UrQVFQ?=
 =?utf-8?B?T2p3QlF0MmxPaUhLZE9pSkNZdndIM253SnA3UDU4YmtsWi9QNWFjTEdTanBE?=
 =?utf-8?B?YnFRcno5ZHFDc1NEeFlyUFJNRFlsQlFsVGZ3U1Q2U2tnM1d4VkZ1OHpiaXdp?=
 =?utf-8?B?bXQyZld5dWo1a3QvbGVGb2pha3hPZWh2M3ZyeUsycTJzdTdvV3hlTGRIbmtp?=
 =?utf-8?B?TWV2YVRpeVJUVkNrYXpGUU45VGEveGtJVDh0bjVWM2RhdFFHUDhVZVNkUlpy?=
 =?utf-8?B?c0xHNHlxVm4rdDBvbjNqbGpTMWYraWhVSHRyWUFSTUYya2xIWjlZUTV6YU15?=
 =?utf-8?B?SW4yVy93SUsrQ3V2MFJ2cSs0UENFcHdFNG5BblB1VHRDSTJVTG53NllkSzhu?=
 =?utf-8?B?d3UrTlNVRnBhUTNIM1R1YTUzV1RlL0xlOWdZWk43cysyNUl6ZXZUcDgyL0tt?=
 =?utf-8?B?eldnVTRSYzJocUJybFZieDg2UDZ6cmp4K0NWcERuVWQ2cUxtcTJaZ0FsYUJS?=
 =?utf-8?B?Y0RINmkwL29iWlVUeUZVc29wVXNNNEpXL3Jkc1hia05qMnZLVjdhYXVOSW5T?=
 =?utf-8?B?cmF1Z3FuLzJkcWpPMmpiY21vNHh1SG9hNnZ3M3VrNDB3bHY0RmticXN6Q0tC?=
 =?utf-8?B?d3RuVW00R3E3OWxGdTZsdTZ6WWsxYjBBTkVWZGx5NVNvcTVOWXk3L2FobmN3?=
 =?utf-8?B?RVRkVERvK0pnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb942fdc-c311-489b-94ab-08da04de41c4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2022 10:43:06.1186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agCoDKWL+OXqRSyEj7ALVl20fcLZKemgSiGUpkf+kk4UI18FcuvEZ3Pj3J01yONmCzQCagvUO92fAd3LQA8new==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/11/2022 5:28 PM, Suwan Kim wrote:
> This patch supports polling I/O via virtio-blk driver. Polling
> feature is enabled based on "VIRTIO_BLK_F_MQ" feature and the number
> of polling queues can be set by QEMU virtio-blk-pci property
> "num-poll-queues=N". This patch improves the polling I/O throughput
> and latency.
>
> The virtio-blk driver doesn't not have a poll function and a poll
> queue and it has been operating in interrupt driven method even if
> the polling function is called in the upper layer.
>
> virtio-blk polling is implemented upon 'batched completion' of block
> layer. virtblk_poll() queues completed request to io_comp_batch->req_list
> and later, virtblk_complete_batch() calls unmap function and ends
> the requests in batch.

Maybe we can do the batch in separate commit ?

For implementing batch in the right way you need to implement .queue_rqs 
call back.

See NVMe PCI driver implementation.

If we're here, I would really like to see an implementation of 
blk_mq_ops.timeout callback in virtio-blk.

I think it will take this driver to the next level.

>
> virtio-blk reads the number of queues and poll queues from QEMU
> virtio-blk-pci properties ("num-queues=N", "num-poll-queues=M").
> It allocates N virtqueues to virtio_blk->vqs[N] and it uses [0..(N-M-1)]
> as default queues and [(N-M)..(N-1)] as poll queues. Unlike the default
> queues, the poll queues have no callback function.
>
> Regarding HW-SW queue mapping, the default queue mapping uses the
> existing method that condsiders MSI irq vector. But the poll queue
> doesn't have an irq, so it uses the regular blk-mq cpu mapping.
>
> To enable poll queues, "num-poll-queues=N" property of virtio-blk-pci
> needs to be added to QEMU command line. For that, I temporarily
> implemented the property on QEMU. Please refer to the git repository below.
>
> 	git : https://github.com/asfaca/qemu.git #on master branch commit
>
> For verifying the improvement, I did Fio polling I/O performance test
> with io_uring engine with the options below.
> (io_uring, hipri, randread, direct=1, bs=512, iodepth=64 numjobs=N)
> I set 4 vcpu and 4 virtio-blk queues - 2 default queues and 2 poll
> queues for VM.
> (-device virtio-blk-pci,num-queues=4,num-poll-queues=2)
> As a result, IOPS and average latency improved about 10%.
>
> Test result:
>
> - Fio io_uring poll without virtio-blk poll support
> 	-- numjobs=1 : IOPS = 297K, avg latency = 214.59us
> 	-- numjobs=2 : IOPS = 360K, avg latency = 363.88us
> 	-- numjobs=4 : IOPS = 289K, avg latency = 885.42us
>
> - Fio io_uring poll with virtio-blk poll support
> 	-- numjobs=1 : IOPS = 332K, avg latency = 192.61us
> 	-- numjobs=2 : IOPS = 371K, avg latency = 348.31us
> 	-- numjobs=4 : IOPS = 321K, avg latency = 795.93us
>
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
>   drivers/block/virtio_blk.c      | 98 +++++++++++++++++++++++++++++++--
>   include/uapi/linux/virtio_blk.h |  3 +-
>   2 files changed, 96 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 8c415be86732..bfde7d97d528 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -81,6 +81,7 @@ struct virtio_blk {
>   
>   	/* num of vqs */
>   	int num_vqs;
> +	int io_queues[HCTX_MAX_TYPES];
>   	struct virtio_blk_vq *vqs;
>   };
>   
> @@ -548,6 +549,7 @@ static int init_vq(struct virtio_blk *vblk)
>   	const char **names;
>   	struct virtqueue **vqs;
>   	unsigned short num_vqs;
> +	unsigned short num_poll_vqs;
>   	struct virtio_device *vdev = vblk->vdev;
>   	struct irq_affinity desc = { 0, };
>   
> @@ -556,6 +558,13 @@ static int init_vq(struct virtio_blk *vblk)
>   				   &num_vqs);
>   	if (err)
>   		num_vqs = 1;
> +
> +	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
> +				struct virtio_blk_config, num_poll_queues,
> +				&num_poll_vqs);
> +	if (err)
> +		num_poll_vqs = 0;
> +
>   	if (!err && !num_vqs) {
>   		dev_err(&vdev->dev, "MQ advertised but zero queues reported\n");
>   		return -EINVAL;
> @@ -565,6 +574,13 @@ static int init_vq(struct virtio_blk *vblk)
>   			min_not_zero(num_request_queues, nr_cpu_ids),
>   			num_vqs);
>   
> +	num_poll_vqs = min_t(unsigned int, num_poll_vqs, num_vqs - 1);
> +
> +	memset(vblk->io_queues, 0, sizeof(int) * HCTX_MAX_TYPES);
> +	vblk->io_queues[HCTX_TYPE_DEFAULT] = num_vqs - num_poll_vqs;
> +	vblk->io_queues[HCTX_TYPE_READ] = 0;
> +	vblk->io_queues[HCTX_TYPE_POLL] = num_poll_vqs;
> +
>   	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
>   	if (!vblk->vqs)
>   		return -ENOMEM;
> @@ -578,8 +594,13 @@ static int init_vq(struct virtio_blk *vblk)
>   	}
>   
>   	for (i = 0; i < num_vqs; i++) {
> -		callbacks[i] = virtblk_done;
> -		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
> +		if (i < num_vqs - num_poll_vqs) {
> +			callbacks[i] = virtblk_done;
> +			snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
> +		} else {
> +			callbacks[i] = NULL;
> +			snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
> +		}
>   		names[i] = vblk->vqs[i].name;
>   	}
>   
> @@ -728,16 +749,82 @@ static const struct attribute_group *virtblk_attr_groups[] = {
>   static int virtblk_map_queues(struct blk_mq_tag_set *set)
>   {
>   	struct virtio_blk *vblk = set->driver_data;
> +	int i, qoff;
> +
> +	for (i = 0, qoff = 0; i < set->nr_maps; i++) {
> +		struct blk_mq_queue_map *map = &set->map[i];
> +
> +		map->nr_queues = vblk->io_queues[i];
> +		map->queue_offset = qoff;
> +		qoff += map->nr_queues;
> +
> +		if (map->nr_queues == 0)
> +			continue;
> +
> +		if (i == HCTX_TYPE_DEFAULT)
> +			blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);
> +		else
> +			blk_mq_map_queues(&set->map[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static void virtblk_complete_batch(struct io_comp_batch *iob)
> +{
> +	struct request *req;
> +	struct virtblk_req *vbr;
>   
> -	return blk_mq_virtio_map_queues(&set->map[HCTX_TYPE_DEFAULT],
> -					vblk->vdev, 0);
> +	rq_list_for_each(&iob->req_list, req) {
> +		vbr = blk_mq_rq_to_pdu(req);
> +		virtblk_unmap_data(req, vbr);
> +		virtblk_cleanup_cmd(req);
> +	}
> +	blk_mq_end_request_batch(iob);
> +}
> +
> +static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
> +{
> +	struct virtio_blk_vq *vq = hctx->driver_data;
> +	struct virtblk_req *vbr;
> +	unsigned long flags;
> +	unsigned int len;
> +	int found = 0;
> +
> +	spin_lock_irqsave(&vq->lock, flags);
> +
> +	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
> +		struct request *req = blk_mq_rq_from_pdu(vbr);
> +
> +		found++;
> +		if (!blk_mq_add_to_batch(req, iob, virtblk_result(vbr),
> +						virtblk_complete_batch))
> +			blk_mq_complete_request(req);
> +	}
> +
> +	spin_unlock_irqrestore(&vq->lock, flags);
> +
> +	return found;
> +}
> +
> +static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
> +			  unsigned int hctx_idx)
> +{
> +	struct virtio_blk *vblk = data;
> +	struct virtio_blk_vq *vq = &vblk->vqs[hctx_idx];
> +
> +	WARN_ON(vblk->tag_set.tags[hctx_idx] != hctx->tags);
> +	hctx->driver_data = vq;
> +	return 0;
>   }
>   
>   static const struct blk_mq_ops virtio_mq_ops = {
>   	.queue_rq	= virtio_queue_rq,
>   	.commit_rqs	= virtio_commit_rqs,
> +	.init_hctx	= virtblk_init_hctx,
>   	.complete	= virtblk_request_done,
>   	.map_queues	= virtblk_map_queues,
> +	.poll		= virtblk_poll,
>   };
>   
>   static unsigned int virtblk_queue_depth;
> @@ -816,6 +903,9 @@ static int virtblk_probe(struct virtio_device *vdev)
>   		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
>   	vblk->tag_set.driver_data = vblk;
>   	vblk->tag_set.nr_hw_queues = vblk->num_vqs;
> +	vblk->tag_set.nr_maps = 1;
> +	if (vblk->io_queues[HCTX_TYPE_POLL])
> +		vblk->tag_set.nr_maps = 3;
>   
>   	err = blk_mq_alloc_tag_set(&vblk->tag_set);
>   	if (err)
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> index d888f013d9ff..3fcaf937afe1 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -119,8 +119,9 @@ struct virtio_blk_config {
>   	 * deallocation of one or more of the sectors.
>   	 */
>   	__u8 write_zeroes_may_unmap;
> +	__u8 unused1;
>   
> -	__u8 unused1[3];
> +	__virtio16 num_poll_queues;
>   } __attribute__((packed));
>   
>   /*
