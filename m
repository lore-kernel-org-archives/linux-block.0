Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36257C432BE
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 08:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 240EA611C8
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 08:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhHWIHv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 04:07:51 -0400
Received: from mail-mw2nam12on2084.outbound.protection.outlook.com ([40.107.244.84]:35008
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235382AbhHWIHu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 04:07:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJEgl2UpRZOOiIYS8euS95dlwtmT8zpd3W5QhuLzxEE4MYohM561DRdOXcWZUCb/7qBb8E1bLNndEn8ctlhFDT8kK6Vc9lgvp4Yed7OrSBj0kCjKZC1rFuRd+u7bSfEacMwfL1zhIQxIIABm2vIdc9tWGd5XOX/GgjF5bkzrphWW78OHE5hyvbawWaDv07wlXTg+sltB0+6Qlp0eYI8zQayvxzg+uYQsoDexKl6mXfapPswOu954aRVdOaza3z/nKxe9k257yOzzaBD3tDAh4vBgnu4pE9b6rbaqJ6w2yg4F6zQ3eYtYz3tbiVwgSo7RDeTmxlN35QgNZ89ihChC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhdselU5CoedNTOIQqE/3jjkl/DQt8KPniAvNttP8Ds=;
 b=MqMStXkcJex2ZatZvyJopReUfZgQDMZxuBLDHURol/LanGfNOYb3+rqJtZJmDH9S7r5hcGHVG00SSuzWgy/6FatLu0q+iEppLDaK1KAuLNar2/EdEWBCGr8FqcsHobwVdRmYU5PiKfjkZ2qB2R33MPEVAyIEmSPe893RnI2t2zSzpCoQYMMAfvq4E8E+1F+aGKebhgcrxswMpXm7rB64xCeJvY95Nbb+9k6bLPPAEtqqImt7cCQeUnWDSm8SgBgNRE285jLyHZq6VwkwF3HQ1naXYKbfz+mpSsTJVyzSoutcegtjpqjQa6gwzL2fMKw6JLseRlUS74vKcgsyX7Bk6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhdselU5CoedNTOIQqE/3jjkl/DQt8KPniAvNttP8Ds=;
 b=KjlxNXMRSijpW9iZAmaIR2ID61hhrbCuJTkAZidIctbdHXE0upJ+GxfWH86sq+VGvBbnKgm0enz5wcQSl44kR2XN11EXu5uEobzda0GXtZfDOe1YgXj+bYbkKW8Hxty7w046d2qeIHFrOb+Ifnx1kwIUuHwolO5rCVBkHpsNdxYgP2idnDbqAVH7G1IAZc7NuwD2ioIXNl7MdO0VDgFxSbJIV2ni3MhIPR0cQWX/oLYWtBqMiQ0/cD95/mXcllJejOAPXUVPVrkEzsSzeAd8UA5fpKsPHeIajKy28WIaDGKSYTo1cTKgWygCblzznOmpF7dt5PBin1v2Lor+tFzrCw==
Received: from BN7PR06CA0056.namprd06.prod.outlook.com (2603:10b6:408:34::33)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 08:07:07 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::aa) by BN7PR06CA0056.outlook.office365.com
 (2603:10b6:408:34::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Mon, 23 Aug 2021 08:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 08:07:06 +0000
Received: from [172.27.13.55] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 23 Aug
 2021 08:07:04 +0000
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
To:     Yongji Xie <xieyongji@bytedance.com>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210809101609.148-1-xieyongji@bytedance.com>
 <e6ab104e-a18b-3f17-9cd8-6a6b689b56b4@nvidia.com>
 <CACycT3sNRRBrSTJOUr=POc-+BOAgfT7+qgFE2BLBTGJ30cZVsQ@mail.gmail.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <dc8e7f6d-9aa6-58c6-97f7-c30391aeac5d@nvidia.com>
Date:   Mon, 23 Aug 2021 11:07:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACycT3sNRRBrSTJOUr=POc-+BOAgfT7+qgFE2BLBTGJ30cZVsQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: face7966-76ae-47cf-d853-08d9660cfff4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4376:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4376BA92FF7322DFF40192FEDEC49@MN2PR12MB4376.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D08sBf67f3LivzQ121lJ7PumLE6dFZAkzYGRW70uxWCCBwdWNyqi6urKC+g18z+wR3U7nC1+RKHm/my9UMzXm3VGBKd0pBuFQqLBhkirKAPP+1p76cvNt8P9j2GjievhfEy3VQav2yVmkdOQXlbZf8EUc05isk56RbXEe31sVKpk390Mj2pPkFvJWI4cx8ZLb6FlmPfh6Id/qyS3oAPA2CYgenDk7DVAEQrrFJVry4rHabGvS9nmlz1V4pcZoU0M0bZE41k3U1H8UFEjvD7AAvL1CD5iKEEsaOB6mQsYJ9NRscCXlCs129C6WfqAA8xcbZoLRifgTKXzuJybcFbsRQK2etMr54eEE+v4+DoUhu/4+0gNF55AZ6kWgW3McogFJtLfG8MBkt8ezhtH4nLAwGJvDDwXr1AKfxVtuc2S9p6Xk7OAFPYgwElTYS0yv+O+PgIHlHYFxwststUCuXtYCl/nf2O2rG5+nQDDaFB2ReuaafjeL2ohcrA508QgNPEAnp0P9Hm2PjTi0T2Xh1OzndUyDWxMTqr8WTKAyQlRzVTLAnh6pa/F2u0Op5pLU+QMQCFHw+jfcfNvH0nlE9Iq+zAiUTphGrVzH4jMU2c4rS5Dej+9+p+fp3H/1SpSdR4akp0GZo6ABeLBTAqYPOaysW+Xxs1zqx9B/zFrYL33v9uaBcy9CacTyhChrOJDoROxTQxut7hs2XFwdlcz7tQFSKGO6oDIeZNXcdXsdbQK4exzLXP8Jbs7CDAM3prCOdI81dSZ6LMpFBTzqDGe3jc0tdiu0vGQ64J9aKGNNewS1IGUUQGmteVzHevRrbNNRVd6
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(36840700001)(46966006)(70206006)(82310400003)(53546011)(83380400001)(2906002)(6666004)(70586007)(86362001)(7636003)(82740400003)(36860700001)(356005)(16526019)(426003)(336012)(4326008)(26005)(8676002)(8936002)(966005)(16576012)(478600001)(54906003)(36756003)(316002)(5660300002)(31686004)(2616005)(36906005)(47076005)(6916009)(31696002)(186003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 08:07:06.7913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: face7966-76ae-47cf-d853-08d9660cfff4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 8/23/2021 7:31 AM, Yongji Xie wrote:
> On Mon, Aug 23, 2021 at 7:17 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>
>> On 8/9/2021 1:16 PM, Xie Yongji wrote:
>>> An untrusted device might presents an invalid block size
>>> in configuration space. This tries to add validation for it
>>> in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
>>> feature bit if the value is out of the supported range.
>> This is not clear to me. What is untrusted device ? is it a buggy device ?
>>
> A buggy device, the devices in an encrypted VM, or a userspace device
> created by VDUSE [1].
>
> [1] https://lore.kernel.org/kvm/20210818120642.165-1-xieyongji@bytedance.com/

if it's a userspace device, why don't you fix its control path code 
instead of adding workarounds in the kernel driver ?


>
>> What is the return value for the blk_size in this case that you try to
>> override ?
>>
> The value that is larger than PAGE_SIZE.  I think the block layer can
> not handle the block size that is larger than PAGE_SIZE correctly,
> e.g. in block_read_full_page().
>
>>> And we also double check the value in virtblk_probe() in
>>> case that it's changed after the validation.
>>>
>>> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>>> ---
>>>    drivers/block/virtio_blk.c | 39 +++++++++++++++++++++++++++++++++------
>>>    1 file changed, 33 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>> index 4b49df2dfd23..afb37aac09e8 100644
>>> --- a/drivers/block/virtio_blk.c
>>> +++ b/drivers/block/virtio_blk.c
>>> @@ -692,6 +692,28 @@ static const struct blk_mq_ops virtio_mq_ops = {
>>>    static unsigned int virtblk_queue_depth;
>>>    module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
>>>
>>> +static int virtblk_validate(struct virtio_device *vdev)
>>> +{
>>> +     u32 blk_size;
>>> +
>>> +     if (!vdev->config->get) {
>>> +             dev_err(&vdev->dev, "%s failure: config access disabled\n",
>>> +                     __func__);
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
>>> +             return 0;
>>> +
>>> +     blk_size = virtio_cread32(vdev,
>>> +                     offsetof(struct virtio_blk_config, blk_size));
>>> +
>>> +     if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
>>> +             __virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
>> is it PAGE_SIZE or SZ_4K ?
>>
>> Do we support a 64K blk size (PPC PAGE_SIZE)
>>
> I think PAGE_SIZE should be OK here. I didn't see a hard 4K limitation
> in the kernel. NBD did the same check:
>
> static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize, loff_t blksize)
> {
>      if (!blksize)
>      blksize = NBD_DEF_BLKSIZE;
>      if (blksize < 512 || blksize > PAGE_SIZE || !is_power_of_2(blksize))
>      return -EINVAL;
>
> Thanks,
> Yongji
