Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AC0C4338F
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 10:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C06F16137D
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 10:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbhHWKq0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 06:46:26 -0400
Received: from mail-bn8nam11on2076.outbound.protection.outlook.com ([40.107.236.76]:12384
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235104AbhHWKq0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 06:46:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrxLMcvfryZkgeSBKaWoj2YzU4Dqa66NSyOl9X2z2V24S5nw8gDfCzCe84eQAx5WpAPZznwjzykm9LAn35ci4+dy865TqgeD09Jed0cyFgZD6aXstK5c1pl9+OYL8SwmapXBxMW86R/xQU077xvDhJrEcVWUE/9o+BN/ZYsJLqul+aIbsdSLjggv/G9Snd/ABW44qPy7v3h9g7K3VkIKy2ZGwtmSXPyhPrsoCTWnozrEQfjPz2HqfzhZN1cQH8QnnMq9/rr9a0V+y5yd7m60HP+GXwML7gAQmKVaepBrx/mOB9R5++HlVEMLcKqLj2Mk7BpN4SqbJDr4nx7o8sih+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yp7Kufuo+iubLawDHuwfPE7Z1vQYJwVdF+U09+bB/PE=;
 b=AK04aGUDgBIknMfQ/MLrCCGaDq5Da+fq0qUN/UdFuxQn2XJPdVCUkbWqTqN3WJ0WD+jrUHmWKMqMzjz+V9zs8t+FMbiqvh9MGmSnDqTdpO0hNk/d9b9JqMRvEXvjqlHfELsHgEnn1+G4OF/8jYWCnCM2ueNn5v4lmsfHqFgMFuXEyGrOn2BeYUMZhJCGdyUyTn2T6Y3rCmsh2SHf0bJit+o4eiQZyMiTIQlkLidopW21JTyG9+Gk4KxlOgI2BkpHlyXoqEQhJvM5jWxoI4IFmpefUovYuNYnyx7ODp2rzieECYUqufYk7FgT0TeeYG06zc6zLGs3X4TC16pfBAeLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yp7Kufuo+iubLawDHuwfPE7Z1vQYJwVdF+U09+bB/PE=;
 b=OlmZM0zINSgbAcf2hDuKLz+tedFo+LLQ7y1Lzw0DCn89C0SDsJoTREFBF95IkfrhBgfU8ETmsL7poACAZPa6D0Ftkdq1IfOZufq0ruqp4uWdNRMxXfxGozwMS1o7The9vOIPTz9yL606yGB+pxosBvwM2wwjeKAsotwUZdlTJvaB0ui8l1kbZ1rSuIRk99Mf8ajouX8H2++/64o1aLndpO/JWpnommVmDaAxFtNAIPWMk5HJIL+QohfDyHiJrgWIcQc3vrjUWqX0Drue4AWjZBsLMvxWIDm2zhPPQcpN9XtxkR6BEr8frkD01a1ogqJ8hYKqjpgA6D2Fv+dTM5efoA==
Received: from MWHPR21CA0029.namprd21.prod.outlook.com (2603:10b6:300:129::15)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Mon, 23 Aug
 2021 10:45:36 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::f) by MWHPR21CA0029.outlook.office365.com
 (2603:10b6:300:129::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.1 via Frontend
 Transport; Mon, 23 Aug 2021 10:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 10:45:36 +0000
Received: from [172.27.13.55] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 23 Aug
 2021 10:45:34 +0000
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
 <6d6154d7-7947-68be-4e1e-4c1d0a94b2bc@nvidia.com>
 <CACycT3sxeUQa7+QA0CAx47Y3tVHKigcQEfEHWi04aWA5xbgA9A@mail.gmail.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <7f0181d7-ff5c-0346-66ee-1de3ed23f5dd@nvidia.com>
Date:   Mon, 23 Aug 2021 13:45:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACycT3sxeUQa7+QA0CAx47Y3tVHKigcQEfEHWi04aWA5xbgA9A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1833081c-762b-4957-6026-08d966232440
X-MS-TrafficTypeDiagnostic: DM6PR12MB4041:
X-Microsoft-Antispam-PRVS: <DM6PR12MB404171BE98128030D638A972DEC49@DM6PR12MB4041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htpF3+latoclk+G/sMF0LCfgJxJQIEWB0gh7AWUadsfffLzCTM7l8+Ed/oa8/fF+7NAsa1egW6PoZfM8MoR9SDcBQsaJ22nfCorI2vsxThBLBdJKDOf26oRNyFR4cH/fWYEsXt4yp6aWBNXKU+oWsC1btI3CNP0YEpxSZfo/zc3ewfANiZfas4mJHmCbZPoHz8NTZm5oKq7J2zSmh6oiDTUDYIu6ccO/crezzEi8fSRWNVChZtLTe4i+NfALJVTIGEz9s0hqQULJKT+IDRrvDfrsdmRhMq6n1lOFzFtWpp/qYcExFfD/IG04glLq306FrPaSrspTJCLMUHjhQRJotXD2/+LerfP9KoRbH8x0Vq07+MD2KayaBYCotZrlp1f2gX7/CCAS125j2DRbY8BOjcLewiS6adlq8ztqlXa4NiUMcVTBWesYZzGbfr3FyNHvzEaddwpkm5T5Hodu/wKv5RvkWdDsplk1Z+RFtUSOqqKfMqKT30SG10v8GovmY3jfxiGS/7f9H8xrJ1rOg3QDLnMwXAjXG/BSAQE1bZSLKz0fnA+wbn+rmissPS242tUDVvkaYOoR9Tyw4Z+dleY288Apm04VMwrAsszxxKNYxHZoW8xH5bGE36BOw0cr45J7h/8+H8A07rC5NwANIy+Ey0vm+kZoDiPNg292U7Ud5eAbiXlWjWPZl1CQY9d42OH76CSjaM6ddsH4itgnaktkeoYa82TxDpimSDvsJxCyuNDXESOYKIaJ70D9E/pqGaOfu5Xx+YB3jYg++nrBPGo506EX8EjZvZAj+LQhN2Il/u0pv4dTU8A9jQ378UfevfcI
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966006)(36840700001)(478600001)(966005)(2906002)(83380400001)(336012)(2616005)(5660300002)(36756003)(36860700001)(8676002)(36906005)(316002)(31686004)(8936002)(426003)(7636003)(53546011)(31696002)(54906003)(6666004)(4326008)(82740400003)(47076005)(16576012)(6916009)(70206006)(16526019)(356005)(82310400003)(26005)(70586007)(86362001)(186003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 10:45:36.5044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1833081c-762b-4957-6026-08d966232440
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 8/23/2021 1:33 PM, Yongji Xie wrote:
> On Mon, Aug 23, 2021 at 5:38 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>
>> On 8/23/2021 12:27 PM, Yongji Xie wrote:
>>> On Mon, Aug 23, 2021 at 5:04 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>>> On 8/23/2021 11:35 AM, Yongji Xie wrote:
>>>>> On Mon, Aug 23, 2021 at 4:07 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>>>>> On 8/23/2021 7:31 AM, Yongji Xie wrote:
>>>>>>> On Mon, Aug 23, 2021 at 7:17 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>>>>>>> On 8/9/2021 1:16 PM, Xie Yongji wrote:
>>>>>>>>> An untrusted device might presents an invalid block size
>>>>>>>>> in configuration space. This tries to add validation for it
>>>>>>>>> in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
>>>>>>>>> feature bit if the value is out of the supported range.
>>>>>>>> This is not clear to me. What is untrusted device ? is it a buggy device ?
>>>>>>>>
>>>>>>> A buggy device, the devices in an encrypted VM, or a userspace device
>>>>>>> created by VDUSE [1].
>>>>>>>
>>>>>>> [1] https://lore.kernel.org/kvm/20210818120642.165-1-xieyongji@bytedance.com/
>>>>>> if it's a userspace device, why don't you fix its control path code
>>>>>> instead of adding workarounds in the kernel driver ?
>>>>>>
>>>>> VDUSE kernel module would not touch (be aware of) the device specific
>>>>> configuration space. It should be more reasonable to fix it in the
>>>>> device driver. There is also some existing interface (.validate()) for
>>>>> doing that.
>>>> who is emulating the device configuration space ?
>>>>
>>> A userspace daemon will initialize the device configuration space and
>>> pass the contents to the VDUSE kernel module. The VDUSE kernel module
>>> will handle the access of the config space from the virtio device
>>> driver, but it doesn't need to know the contents (although we can know
>>> that).
>> So you add a workaround in the guest kernel drivers instead of checking
>> these quirks in the hypervisor ?
>>
> I didn't see any problem adding this validation in the device driver.
>
>> VDUSE kernel should enforce the security for the devices it
>> emulates/presents to the VM.
>>
> I agree that the VDUSE kernel should enforce the security for the
> emulated devices. But I still think the virtio device driver should
> handle this case since nobody can make sure the device can always set
> the correct value. Adding this validation would be helpful.

It helpful if there is a justification for this.

In this case, no such HW device exist and the only device that can cause 
this trouble today is user space VDUSE device that must be validated by 
the emulation VDUSE kernel driver.

Otherwise, will can create 1000 commit like this in the virtio level 
(for example for each feature for each virtio device).

>
>>>>> And regardless of userspace device, we still need to fix it for other cases.
>>>> which cases ? Do you know that there is a buggy HW we need to workaround ?
>>>>
>>> No, there isn't now. But this could be a potential attack surface if
>>> the host doesn't trust the device.
>> If the host doesn't trust a device, why it continues using it ?
>>
> IIUC this is the case for the encrypted VMs.

what do you mean encrypted VM ?

And how this small patch causes a VM to be 100% encryption supported ?

>> Do you suggest we do these workarounds in all device drivers in the kernel ?
>>
> Isn't it the driver's job to validate some unreasonable configuration?

The check should be in different layer.

Virtio blk driver should not cover on some strange VDUSE stuff.

>
> Thanks,
> Yongji
