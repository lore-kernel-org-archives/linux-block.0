Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99721C4338F
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 13:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726CC6127B
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 13:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbhHXNtK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 09:49:10 -0400
Received: from mail-mw2nam10on2073.outbound.protection.outlook.com ([40.107.94.73]:48512
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233711AbhHXNtJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 09:49:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKT0EVuPuGPczEdLWDIKvRY6nbysmu/ShtehKmtzoknZI4AKxjoYaauAWSP6hZBduODpJpmnSt4FdJ3oVEcWfR5Sp4F2+646TJ5ZyGHDvo0lG/rujLRVq1q2a3DtERK64Cy3nld4s0rzvtcFvddb544hPFa6LCD5tKzDACXCRpZnS0RyjGIOISIZiXfEiRVsQebrzygoQz7NQDc39HH1Ma0OvJC264Tvg5beI4NCcuAiVj0YCzcbHgJ1QaW9fr9PUj8oLTPBipcPxGP8HNH+T0Dt6aGnGLQStuTfkXsf6Pg2HU4J15ol3ZXKCjpW4kHsu13kQIoBHO/UlNcUrlFspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+/LslqD/j1OTyG2jVWzRvs6rGurw3uarOCdm1l6Qg4=;
 b=IAmAsEI+umlMXvuGNEliGz9ct5u9ca4PwYV8k/oU0S16LCILy4yna5SZrXFYqEu6fP+zuuGzPnjgxCDMkPykHFKyjSREFeW+R0FnyRBiGUkzUO3w2SqFBljuCCU82wMy5nOg54mi3gg7waGPv6cW/UrNIB86UZGqCrzW3D7yrYwn9uONzwI7MkjuFNkgIqRap05MVpzRaXhl8z5ba7wP2pjKR7WVqBkdz5iwkBVLslV/a4yvRLiDiY1X+HIZSiJdCVybxPaiidpZZwS1872JP741BjXkOgss4EhsY1EX2+CVKM89JBPVc3ag/FXugp8/bRy4i3GdP/qpy2Hau4B13A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+/LslqD/j1OTyG2jVWzRvs6rGurw3uarOCdm1l6Qg4=;
 b=svwkPbMpbUcS2t7oe7Je1QtQpOb7gIjLEbOZ48f4Fp13ApQEJFUMF5dXJACV3NyHpl2iKHDrTgwSUs9zP3OyU/NMUFVIKOGhL0LqYc9Zr1pkjpz3zStNq9I8cP+OafZalrDxjcj4uE/w45eQTZCGq+sp50JIyXhyN3JQq0fHy19lmmqbbAYC3uZ/TYxzCH1WFHhttrO9+4EIh0GA1PtE9dADEix4BQVYNSAnGNiPF43ODDhCRri+l6wDO7GAyjqomtHfG4zTstm8udZRWN1CLcoK07dVzeI96/ChVijvDb0os9UyU6Q8+jeriV08pMXjCAOH2aCRgdDblL8fgI4aBA==
Received: from MW4PR04CA0274.namprd04.prod.outlook.com (2603:10b6:303:89::9)
 by BN9PR12MB5275.namprd12.prod.outlook.com (2603:10b6:408:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 13:48:24 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::ce) by MW4PR04CA0274.outlook.office365.com
 (2603:10b6:303:89::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Tue, 24 Aug 2021 13:48:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 13:48:23 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 24 Aug
 2021 13:48:23 +0000
Received: from [172.27.13.92] (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 24 Aug
 2021 13:48:21 +0000
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
To:     Yongji Xie <xieyongji@bytedance.com>
CC:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
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
 <6d6154d7-7947-68be-4e1e-4c1d0a94b2bc@nvidia.com>
 <CACycT3sxeUQa7+QA0CAx47Y3tVHKigcQEfEHWi04aWA5xbgA9A@mail.gmail.com>
 <7f0181d7-ff5c-0346-66ee-1de3ed23f5dd@nvidia.com>
 <20210823080952-mutt-send-email-mst@kernel.org>
 <b9636f39-1237-235e-d1fe-8f5c0d422c7d@nvidia.com>
 <CACGkMEuc0C0=te3O6z76BniiuHJgfxHnaAZoX=+PCy4Y7DxRow@mail.gmail.com>
 <c238448b-9915-a4fc-4ec8-c807a06b359f@nvidia.com>
 <CACycT3vCfydrCq8vR9-WMq+-KDJx1Z+q1saOmp0yW0TRvLrqGg@mail.gmail.com>
 <fe2d623c-c0aa-a27e-fbe3-2c012b863140@nvidia.com>
 <CACycT3s=PBbwsFYtQ+afuXgoKLZYsCXaR_fu02TyfmYKOP9GaQ@mail.gmail.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <f1ab7957-b170-9bc7-ed9e-c4cd7a7c448b@nvidia.com>
Date:   Tue, 24 Aug 2021 16:48:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACycT3s=PBbwsFYtQ+afuXgoKLZYsCXaR_fu02TyfmYKOP9GaQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf035dc4-731d-43a2-47d9-08d96705d7ba
X-MS-TrafficTypeDiagnostic: BN9PR12MB5275:
X-Microsoft-Antispam-PRVS: <BN9PR12MB52752EA2DFEFFB72CEA23A56DEC59@BN9PR12MB5275.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bvdu2fx8h6Hs3tvO8CsxPvlt4JKVViGfpUsT55HL/OA3lXQRhyxowIla/+E0jwje18GZy/5zG3Lny+PyQ+3tmFdfXiXrLCWbm/dGECjAfMkMVNGwRVZkzblmshqRSyMZjUaaA/vI71+LaGtprYGu4S1z9opQZiyyvKWRvgp4qFYk5e7084cLEcrd6MMCr+xlrIgUHtXMQ+4WMPukzc+ort5eVHtJ0yCviP7+R89uxA/z0aSqSdR4xK0BJfqergBChvtySwTI5goh2FfkL3+E2KYT/UkDww42CHv1aPip187tNttMQJFIkuPB55IIDT4zxwqZ85ZP04WX8JxH/tiuEPcFf5HLGTFgWbFLwx/WOMxaOp/PkXe5pXE0J3gCwPdB6iMbGVBBBsm6PtGf/dlZAYZsC8Co8eKH7LcvCO8xNthILYvrgPDBwfy2nB74TWrK3ntXo+xFAQYLAbA5sB37xNtMyWpVMnXncfU07VFwjmjzM2oscAU2vUsi+HQWMfUkR6aZxS8l6qrJcdBb8PGhCRgjB9cqwdzSUpbn2p6QOC1AYdND7ey7bxNAgsD/ZbhYOfKTMGYA78M+cIX86f2d0dJCCZ95Om7kvOlC4w40MDnt7yRpyEvaJyB3kU+opcMT4CCCrTFOCyrepjUMPVl9QYyj2rW2mzmHY9Qm9SNdABgoyE2oCjo21r29By1oCgvSbkRqZn+A9Q1J4GjQLkGnxDbHr9WRfwr5NQqU3/WOrjuDmrv85zZreDVPcHvUNcViBmzo9b8F4+n6c1wEAQ6quo9gDOTCPfz4sX5RJB7+2RN07n1e/QQJhdYOeWuAJGos
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(46966006)(36840700001)(82740400003)(186003)(16526019)(82310400003)(8936002)(2906002)(316002)(26005)(8676002)(2616005)(7636003)(36860700001)(31696002)(4326008)(36756003)(53546011)(426003)(83380400001)(966005)(478600001)(31686004)(70586007)(70206006)(6666004)(54906003)(5660300002)(16576012)(6916009)(36906005)(47076005)(86362001)(356005)(336012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 13:48:23.9453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf035dc4-731d-43a2-47d9-08d96705d7ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5275
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 8/24/2021 4:38 PM, Yongji Xie wrote:
> On Tue, Aug 24, 2021 at 9:30 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>
>> On 8/24/2021 3:52 PM, Yongji Xie wrote:
>>> On Tue, Aug 24, 2021 at 6:11 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>>> On 8/24/2021 5:47 AM, Jason Wang wrote:
>>>>> On Tue, Aug 24, 2021 at 6:31 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>>>>> On 8/23/2021 3:13 PM, Michael S. Tsirkin wrote:
>>>>>>> On Mon, Aug 23, 2021 at 01:45:31PM +0300, Max Gurtovoy wrote:
>>>>>>>> It helpful if there is a justification for this.
>>>>>>>>
>>>>>>>> In this case, no such HW device exist and the only device that can cause
>>>>>>>> this trouble today is user space VDUSE device that must be validated by the
>>>>>>>> emulation VDUSE kernel driver.
>>>>>>>>
>>>>>>>> Otherwise, will can create 1000 commit like this in the virtio level (for
>>>>>>>> example for each feature for each virtio device).
>>>>>>> Yea, it's a lot of work but I don't think it's avoidable.
>>>>>>>
>>>>>>>>>>>>> And regardless of userspace device, we still need to fix it for other cases.
>>>>>>>>>>>> which cases ? Do you know that there is a buggy HW we need to workaround ?
>>>>>>>>>>>>
>>>>>>>>>>> No, there isn't now. But this could be a potential attack surface if
>>>>>>>>>>> the host doesn't trust the device.
>>>>>>>>>> If the host doesn't trust a device, why it continues using it ?
>>>>>>>>>>
>>>>>>>>> IIUC this is the case for the encrypted VMs.
>>>>>>>> what do you mean encrypted VM ?
>>>>>>>>
>>>>>>>> And how this small patch causes a VM to be 100% encryption supported ?
>>>>>>>>
>>>>>>>>>> Do you suggest we do these workarounds in all device drivers in the kernel ?
>>>>>>>>>>
>>>>>>>>> Isn't it the driver's job to validate some unreasonable configuration?
>>>>>>>> The check should be in different layer.
>>>>>>>>
>>>>>>>> Virtio blk driver should not cover on some strange VDUSE stuff.
>>>>>>> Yes I'm not convinced VDUSE is a valid use-case. I think that for
>>>>>>> security and robustness it should validate data it gets from userspace
>>>>>>> right there after reading it.
>>>>>>> But I think this is useful for the virtio hardening thing.
>>>>>>> https://lwn.net/Articles/865216/
>>>>>> I don't see how this change is assisting confidential computing.
>>>>>>
>>>>>> Confidential computingtalks about encrypting guest memory from the host,
>>>>>> and not adding some quirks to devices.
>>>>> In the case of confidential computing, the hypervisor and hard device
>>>>> is not in the trust zone. It means the guest doesn't trust the cloud
>>>>> vendor.
>>>> Confidential computing protects data during processing ("in-use" data).
>>>>
>>>> Nothing to do with virtio feature negotiation.
>>>>
>>> But if a misbehaving device can corrupt the guest memory, I think it
>>> should be avoided.
>> So don't say it's related to confidential computing, and fix it in the
>> VDUSE kernel driver in the hypervisor.
>>
> What I mean is in confidential computing cases. An untrusted device
> might corrupt the protected guest memory, it should be avoided.

This patch has nothing to do with confidential computing by definition 
(virtio feature negotiation are not "in-use" data).

It's device configuration space.

MST, I prefer adding quirks for vDPA devices in VDUSE driver and not 
adding workarounds to virtio driver.

I guess this patch can stay but future patches like this shouldn't be 
merged without a very good reason.

>
> Thanks,
> Yongji
