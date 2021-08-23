Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155A7C4338F
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 09:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9E5261372
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 09:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbhHWJjT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 05:39:19 -0400
Received: from mail-dm6nam10on2065.outbound.protection.outlook.com ([40.107.93.65]:48225
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231861AbhHWJjK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 05:39:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKLpV8cdufFM4DJ7b8mJ14sixGfvdRXd8Y/jlbTNLM4kmknDaT058s8pEYxA1s/PRcQjTKp758FtVFTPxcUwnT4L0z2hTODCVVjToaUT1f337WWt7W/xS6cDPlfpnGUqIv1S3JDZOjiGTxhQZ0JfGeEeutTanltxvcBr0kxui/RAjMTTuliWgWkZLz6pF1rC/am+WBggAWrpLP3KECeDOqaiwuXovQmNStrMk+nNKT2PsQ/Rou102i2f0Bke997MrEKDrjjG7YFFNJxAC//Tzz3d3S3VV2yyzCMi2U4vjNHaq9NHoyKwUmf8YqirvD65Q/5Y5Z8xnHWgpaIboSYmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cJTBj3vKpdv/iOv2dqQ/6m8/qgBxn9Q55bE6l82Yi4=;
 b=QzKrqnJ0uXiFNwJ/UU6fUyvK/O2TPz1CYoWSOEtU9tncOhkGdfFacQ9XNyMToCZftRNm8xVwf8bK4Gc0UHZBgcbyJ8gTNdOciIUuEiwnp7TLEnwzQ4TZMgly1gpWh6pDg9rlb6FZgwX3Ctzhw1IA6ZWZQXWPQM6Ft+N93noXVbtIryXghBehUbtzwpaZys9187a1vSs1vqG/JfUAOtgdY6gylPCWrrylU4LThjLgjRQAm+ICdzY0A1p3BuI7ihUu2dD3WRSioOHE5wZKs7CGVA396S4EPn39FXR+4xgvdzNUZLwtgs4hLck1T4zHnz5shckWN2wohNMcl9PYh9MHvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cJTBj3vKpdv/iOv2dqQ/6m8/qgBxn9Q55bE6l82Yi4=;
 b=desf+af3xV2E9Qrn8ROh/YhQGVIV3sjb3Fkezjnnpmy9928ZULq8rVUtbt1PXH5QehYZii4rt6c3Q26xlEQT0/ghf/5d8gGi0VtTU0cSmso8b2WKHqCvEvTQQ18JgG1xO1CQG/sTzFNpJkYkb/VOuWYuv0QMKRh5qBWqlaClgk1LOZrz6ChSKcKI0k8OnTx4Koc55PdCa7qKzTG8rwVhPP3Y9H4JviOoJZnS8jIphTbyHz15/Fvgsn65kM8Qf+yiaeoy2gGM9K5oGIDXiOoliYf7wwRUFJevP6nedGDVg4bRXllH+nUBFUUijY8IIS5MsGHxJ8MycRoyDMY0vWgJGw==
Received: from BN0PR04CA0153.namprd04.prod.outlook.com (2603:10b6:408:eb::8)
 by BN6PR12MB1683.namprd12.prod.outlook.com (2603:10b6:405:3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Mon, 23 Aug
 2021 09:38:25 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::ac) by BN0PR04CA0153.outlook.office365.com
 (2603:10b6:408:eb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Mon, 23 Aug 2021 09:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 09:38:25 +0000
Received: from [172.27.13.55] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 23 Aug
 2021 09:38:22 +0000
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
 <dc8e7f6d-9aa6-58c6-97f7-c30391aeac5d@nvidia.com>
 <CACycT3v83sVvUWxZ-+SDyeXMPiYd0zi5mtmg8AkXYgVLxVpTvA@mail.gmail.com>
 <06af4897-7339-fca7-bdd9-e0f9c2c6195b@nvidia.com>
 <CACycT3usFyVyBuJBz2n5TRPveKKUXTqRDMo76VkGu7NCowNmvg@mail.gmail.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <6d6154d7-7947-68be-4e1e-4c1d0a94b2bc@nvidia.com>
Date:   Mon, 23 Aug 2021 12:38:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACycT3usFyVyBuJBz2n5TRPveKKUXTqRDMo76VkGu7NCowNmvg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e807ec34-6721-442c-5b1a-08d96619c173
X-MS-TrafficTypeDiagnostic: BN6PR12MB1683:
X-Microsoft-Antispam-PRVS: <BN6PR12MB168326D3B163C7810E5BEF75DEC49@BN6PR12MB1683.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vcW8EI4bejsIde0EYSoNBUotwoH8hJan/ndKb6JvyHOV0GiKf8zBNL+Vgp/cn9s/umnLc6zQlO6wwHxMt1ceHo12FbWB87clniwFI5a1+pUR/GgZ2NtoYQIbLKXHppdnUe1XlRfBdwwP6hniMCPnR7D46EkNy12hYDmjSesof50mGUNjD/bkqsHo8ATByFFT2TxIf4FDGRZUoCv+v8VGZdRgI+/w5UQY0Suaa88YHtnAKDJTrOyouzqi4QU6IQhK6124U32Os7g+ASokjnZHXK8pq/upcleheWRjFeOUojldOD0JM3JpsOujOZDlZBK6AiSjdIyv0xG1zU39RfwguRUS8ihZlnUofgiQEPRc8NFKVnXLrG0Gy0aHywffcMY6ya+GbkugouoW32zxtP5MguNDS69wvAmuGeV+7C567/eoz1eGB9UYiempD3sEavwNfS7kV17WJe3Efp9fpCHQIhdFZwy3jtPdviiSL8Wm5ywjt12l87pcDhM3nFXElQf8cu0wcLN6xB+A3z/imMCCRdUQpHpG7EaZy767t98Qv9CXKo3QAzT1FnUMaKWxV4MmoCFqVwMTb22bBovW0k+AJUl3k67IkzPMNGcTUzGT727545MPEIf13QlAZBdlowWR2swTNRqm5i5xflzkV7E91pxWX/A93LGqSPYBSqhu82wXuxQdLh/qNdrDjHmLSGqd8XKvV4081wxaXEmX4Vs6nPB5q+XhRUbSZpDroaTxSsnxqaM8IIH6ck9DGML5Xs0NWpiYkiPRAyfQDEqPBvx+9IQm3/C+8S0rYREe3u/jDcPMC0fMHdhceRLgdRefMVf
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(16526019)(186003)(8936002)(426003)(36756003)(26005)(7636003)(70206006)(508600001)(31686004)(966005)(6666004)(356005)(53546011)(8676002)(70586007)(4326008)(36860700001)(316002)(47076005)(16576012)(54906003)(5660300002)(2616005)(2906002)(6916009)(83380400001)(86362001)(82310400003)(36906005)(336012)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 09:38:25.3834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e807ec34-6721-442c-5b1a-08d96619c173
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1683
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 8/23/2021 12:27 PM, Yongji Xie wrote:
> On Mon, Aug 23, 2021 at 5:04 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>
>> On 8/23/2021 11:35 AM, Yongji Xie wrote:
>>> On Mon, Aug 23, 2021 at 4:07 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>>> On 8/23/2021 7:31 AM, Yongji Xie wrote:
>>>>> On Mon, Aug 23, 2021 at 7:17 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>>>>> On 8/9/2021 1:16 PM, Xie Yongji wrote:
>>>>>>> An untrusted device might presents an invalid block size
>>>>>>> in configuration space. This tries to add validation for it
>>>>>>> in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
>>>>>>> feature bit if the value is out of the supported range.
>>>>>> This is not clear to me. What is untrusted device ? is it a buggy device ?
>>>>>>
>>>>> A buggy device, the devices in an encrypted VM, or a userspace device
>>>>> created by VDUSE [1].
>>>>>
>>>>> [1] https://lore.kernel.org/kvm/20210818120642.165-1-xieyongji@bytedance.com/
>>>> if it's a userspace device, why don't you fix its control path code
>>>> instead of adding workarounds in the kernel driver ?
>>>>
>>> VDUSE kernel module would not touch (be aware of) the device specific
>>> configuration space. It should be more reasonable to fix it in the
>>> device driver. There is also some existing interface (.validate()) for
>>> doing that.
>> who is emulating the device configuration space ?
>>
> A userspace daemon will initialize the device configuration space and
> pass the contents to the VDUSE kernel module. The VDUSE kernel module
> will handle the access of the config space from the virtio device
> driver, but it doesn't need to know the contents (although we can know
> that).

So you add a workaround in the guest kernel drivers instead of checking 
these quirks in the hypervisor ?

VDUSE kernel should enforce the security for the devices it 
emulates/presents to the VM.

>
>>> And regardless of userspace device, we still need to fix it for other cases.
>> which cases ? Do you know that there is a buggy HW we need to workaround ?
>>
> No, there isn't now. But this could be a potential attack surface if
> the host doesn't trust the device.

If the host doesn't trust a device, why it continues using it ?

Do you suggest we do these workarounds in all device drivers in the kernel ?


>
> Thanks,
> Yongji
