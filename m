Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2B5C4338F
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 13:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9069600D1
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 13:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbhHXNbk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 09:31:40 -0400
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com ([40.107.236.88]:6112
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229601AbhHXNbk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 09:31:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdqR2cS1PSc/BvfTMkAdPT4xBv/BWZzbNFY/BHQ4CLG4+tX1ssJ/JAVQxR5a3omxRrTuFHlwsb5aJ7SuNOwwePnduPJBCEWWiAJGkku3rXZaEX/91KWJyDpyshU/TgdJdXL0xomTa2LirOgz1MxNDaSYJo2higse58heeOQFAbC1Doqqr5R1ekjXTQC4N3EhDJYCzOYkQ6eXhBmKvfoQLnAhgG8bJFfa2Hul5ez9ZiLKyGVFtbwE55C3/mcipdSQJin7RRBDW5OX89h8C/1OdAaoEMxj3PSMqH/UKnDxzTiVY14G4i+xrWBmvLHiqyYjnCGrrIfrS0AdX36MbaHeUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiixubQU2GjAepNOdhPr42fUO0OWV2GBDyBz0wYJeU8=;
 b=MiS/fWCliem7h+E7uXAJTQxahQ4on7BEJXnqohlt86xILRTHt80hXKDYi4JVrioWDABALdg4yvptYNw+8mmAEc7rLJygMXwED+eugMvCmP/9D7NCAKfR12VS+9XPXgf/Xl3/7qwAd2CIo3Hlb+Nl9M6vCZ3sh59yJufsO4ZOPAO44Ga1WPKzbjdG+MP7D0d4AlIBu6gDLLShYLRQWjtQjr6lZKXu49aYm0hE7UsndJmUvLqsTk47zceklLegJ2e0C3VPWVxKFGQDAM+W/+1B7uHyPrfSfFZesJuYi/NoZSCHejXuWA1w/2rg5tvSDBUVU90nGMwKkzxntg/YrzBg1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiixubQU2GjAepNOdhPr42fUO0OWV2GBDyBz0wYJeU8=;
 b=s+JR9xGFfigJG8F8Byc6UQBmpMX20giOC/XZW57I+KUVadPExsejkEt9FTZdGlz29BVD3seqiIQoBD+WDCLeHTgRlQs1HP9pyGP36Mxayf8wdSz1qZxoiTDBeYHQL35oUIB09Vo3iMLX+OPHf6qDPeDj5QIaEutDVIWDTAcqkGAQV09wrHFTn0C0fc1v3FXf67sFv1NzbcC6ssXG+Bfi6ACn9po5U+vjMsBetItSXy94+2ywMgQOt+XdUY8YnEtTchBzsNX+sG/RsoaxX++mT5g0J5gsC+rbQ3mKIyY01l0x3kPCvmt7TynDTLYidt4N3yQVtvADK6iEZPDc0foIVg==
Received: from BN9PR03CA0726.namprd03.prod.outlook.com (2603:10b6:408:110::11)
 by DM5PR12MB2503.namprd12.prod.outlook.com (2603:10b6:4:b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Tue, 24 Aug
 2021 13:30:54 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::54) by BN9PR03CA0726.outlook.office365.com
 (2603:10b6:408:110::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 24 Aug 2021 13:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 13:30:54 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 24 Aug
 2021 13:30:53 +0000
Received: from [172.27.13.92] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 24 Aug
 2021 13:30:51 +0000
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
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <fe2d623c-c0aa-a27e-fbe3-2c012b863140@nvidia.com>
Date:   Tue, 24 Aug 2021 16:30:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACycT3vCfydrCq8vR9-WMq+-KDJx1Z+q1saOmp0yW0TRvLrqGg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d2d7630-49c5-4b13-64ac-08d967036606
X-MS-TrafficTypeDiagnostic: DM5PR12MB2503:
X-Microsoft-Antispam-PRVS: <DM5PR12MB25038D5549C9DBC391212049DEC59@DM5PR12MB2503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SxWs7H40Re6ktutVLj+f7RgiQCcF5OT0j/lSpPtqJ0uBTkxC20uAnqqQvoDO2nh63JTHFINEQ6WxHBzs/vS2ui4kgkozkbVRABOI/cCvY1YDgrGzRBBX7doghtBjQuENncaSSAlAQpfz9kFYT/ytUn1j43Fzf2TSYXfzBhyonnDc4xdt0WPYyhPYCl4KoubwfCBOPQ2IUQyFTwHG8Bw3enWIRj3dKsIwv91RHmfWpZAYIBxTMVNvG0YZ+q7mxFBIzBegonUaFjzd5NJocsvr5uQvcMFPaH8zBn/w+7WbxaX12a5rppv0az64Wbo2uQb1FyxjDqnXld8qzoX8Pe6MWiuqcBAxhiufQVV2T2ifz+/OX2Qf+IudAZPKgJmuDpsu0lULROr/u/+J2Bxr+ndv57PW+3nOpMX1HZVcWsSKILS0rg/i2ZTEWRdo+mknan6eohbeCzNk4J5bujMGjUcZ4QSHdmWQ7uJoTELScrokWUnkBFEZ7XZKISFn2cd97o7kZOsRWDJrGEuHiquC4Rslv0ZvDMyPvwt6P8WapdUZdeCu5AovtN6CEI7qYTLKs8quYy20RK3YruT7TacCSMB1LX/61kgWy/s8BE2zKQYZe8gITRFeIw0Pds5BcO37IdUa8qXMAcipPSZnnKsxhT4RHQ502YOXmyzPh/seLqVeq8rkJFWzKgp31PxfZgL3F9sR1jrbBGM36P/ZqTYTq+QXJegD/m3xJxD39Tp9IZ+njVR7902K/KNKGrT2AqJ2qU8xVif7yydQqhDpE7TYEeW126nyAHYpnYelyAE0dE+2ywM5C4gSCnO/DpDkLZPzJjXK
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(6666004)(4326008)(7636003)(36756003)(8676002)(8936002)(2616005)(86362001)(6916009)(82310400003)(70206006)(31696002)(83380400001)(5660300002)(47076005)(26005)(336012)(966005)(508600001)(53546011)(356005)(70586007)(36906005)(16576012)(186003)(54906003)(16526019)(31686004)(36860700001)(426003)(316002)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 13:30:54.1025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2d7630-49c5-4b13-64ac-08d967036606
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2503
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 8/24/2021 3:52 PM, Yongji Xie wrote:
> On Tue, Aug 24, 2021 at 6:11 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>
>> On 8/24/2021 5:47 AM, Jason Wang wrote:
>>> On Tue, Aug 24, 2021 at 6:31 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>>> On 8/23/2021 3:13 PM, Michael S. Tsirkin wrote:
>>>>> On Mon, Aug 23, 2021 at 01:45:31PM +0300, Max Gurtovoy wrote:
>>>>>> It helpful if there is a justification for this.
>>>>>>
>>>>>> In this case, no such HW device exist and the only device that can cause
>>>>>> this trouble today is user space VDUSE device that must be validated by the
>>>>>> emulation VDUSE kernel driver.
>>>>>>
>>>>>> Otherwise, will can create 1000 commit like this in the virtio level (for
>>>>>> example for each feature for each virtio device).
>>>>> Yea, it's a lot of work but I don't think it's avoidable.
>>>>>
>>>>>>>>>>> And regardless of userspace device, we still need to fix it for other cases.
>>>>>>>>>> which cases ? Do you know that there is a buggy HW we need to workaround ?
>>>>>>>>>>
>>>>>>>>> No, there isn't now. But this could be a potential attack surface if
>>>>>>>>> the host doesn't trust the device.
>>>>>>>> If the host doesn't trust a device, why it continues using it ?
>>>>>>>>
>>>>>>> IIUC this is the case for the encrypted VMs.
>>>>>> what do you mean encrypted VM ?
>>>>>>
>>>>>> And how this small patch causes a VM to be 100% encryption supported ?
>>>>>>
>>>>>>>> Do you suggest we do these workarounds in all device drivers in the kernel ?
>>>>>>>>
>>>>>>> Isn't it the driver's job to validate some unreasonable configuration?
>>>>>> The check should be in different layer.
>>>>>>
>>>>>> Virtio blk driver should not cover on some strange VDUSE stuff.
>>>>> Yes I'm not convinced VDUSE is a valid use-case. I think that for
>>>>> security and robustness it should validate data it gets from userspace
>>>>> right there after reading it.
>>>>> But I think this is useful for the virtio hardening thing.
>>>>> https://lwn.net/Articles/865216/
>>>> I don't see how this change is assisting confidential computing.
>>>>
>>>> Confidential computingtalks about encrypting guest memory from the host,
>>>> and not adding some quirks to devices.
>>> In the case of confidential computing, the hypervisor and hard device
>>> is not in the trust zone. It means the guest doesn't trust the cloud
>>> vendor.
>> Confidential computing protects data during processing ("in-use" data).
>>
>> Nothing to do with virtio feature negotiation.
>>
> But if a misbehaving device can corrupt the guest memory, I think it
> should be avoided.

So don't say it's related to confidential computing, and fix it in the 
VDUSE kernel driver in the hypervisor.

If this is existing device and we want to add a quirk to it, so be it. 
But it's not the case.

> Thanks,
> Yongji
