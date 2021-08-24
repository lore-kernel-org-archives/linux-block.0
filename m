Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B522BC4338F
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 10:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CACF610FD
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 10:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbhHXKMV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 06:12:21 -0400
Received: from mail-bn8nam11on2087.outbound.protection.outlook.com ([40.107.236.87]:35905
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235367AbhHXKMM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 06:12:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FILKJ3T5hhwMDsKUM6xnv3y7/qGWkeA5ud1T8xI41zYvTX7PLBNVI6tuSc7fNQ8W2awlkBPn77YGyIwgK7emEnyAMKJ6veb7zRV8PigCXMeZaaYRbMPcy05Vn5RHhkIe1XU9oHgXQKCwXF4ceC1SzEYCX782cf+CAoWUNxT5RTON3q36JssR5tjaD5U+9+ySI8QTFhMbcCwofJvpmraQv1OR/DOMfBmOMwavwXvVhXKaO92nCOQb1nA61fpiyTs8Z9ug30buhkuv1HthTm7kyitzDMFbwNoyIr06FgUInGOFntKXIQHRA6hMGjh7OTEee9ZXWRGKx5IGrN4Tg/yt5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3prMT+RPiczw4nq0GabRiYBIT/qyTvvLs5H/4/rpEw=;
 b=CSmCjknLym1DMmD+Vp6TkC6Q70rfCWLWWn5mgt3Nc4ggTVQgLuaRP13+aBbP2SNHlF0YvCi5ueTf32tXcIauDQeGj19fB65dDybYWmZYFGhua8Nm7sCgYPiRUrLdjKcrqjmpWn7v4Lug7Mqr1axoDWWXM51TA66B4YmI6ZlRJmB/Z1gG46XmNDFHEmFHhyGez9BDBb44W7QTUo37+00+vKQw2BSEvoWiiXJiiKm4axm43lfg0gTDsdUoO5cqnoBaJBkmZajBX0o65PEqQw4lsqzmtSMlxMXl85fwmEuV5fu2BmMwHK+S19I1HSac/XYWOi120hVfbP7Jwt+KgciN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3prMT+RPiczw4nq0GabRiYBIT/qyTvvLs5H/4/rpEw=;
 b=BB9xp8Pb2sk+tUvDDar/u4VeaoCcAJY4aSzbzl+jgwjwd7U/VEjWCPpX09qQF+LCTljxtOY4QacAoQNL0mTpPPgC8QboapnJvYk6lpr5Kn85YWfgPe+ujGxEGFhEHzx5iE4oW/cCSeeO6Ly1oIySY69h83ce0iLm6xdk+To/JVhURLB3zacXLxG8JPSQ9pNcrwGfGdw+iRcmPH16i61TWHcJAbKNE3wBBt3Rwxs4VPnVFqTP22MJEleea5tMIoMeXzhi7NP5IaFvdEKt3D151ZveZHThJFXNhfUdv7+CHEvshF0ieofh8V7UVwqLgfvll47z+a8pyAc2IeUrivOxDg==
Received: from BN6PR11CA0064.namprd11.prod.outlook.com (2603:10b6:404:f7::26)
 by DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Tue, 24 Aug
 2021 10:11:21 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::3f) by BN6PR11CA0064.outlook.office365.com
 (2603:10b6:404:f7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Tue, 24 Aug 2021 10:11:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 10:11:21 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 24 Aug
 2021 10:11:20 +0000
Received: from [172.27.13.92] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 24 Aug
 2021 10:11:18 +0000
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
To:     Jason Wang <jasowang@redhat.com>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        Yongji Xie <xieyongji@bytedance.com>,
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
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <c238448b-9915-a4fc-4ec8-c807a06b359f@nvidia.com>
Date:   Tue, 24 Aug 2021 13:11:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACGkMEuc0C0=te3O6z76BniiuHJgfxHnaAZoX=+PCy4Y7DxRow@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2aeb0558-0fd5-43b1-35ee-08d966e78573
X-MS-TrafficTypeDiagnostic: DM5PR12MB1884:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1884AE8BA5F316D8780A2EB3DEC59@DM5PR12MB1884.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LxloboqHAb9YVS4LfS7RwV2FSBlP5dPPrQST/3GvmKkTv9/jD9byAwiiszdPHZ8Rc0E6EHJg2l7qfIgPrY+ijheqbFTiafEZVsvui8KiE4eIemCosoGoCVScICXEIQ2Yh+laxoWpeMwKb7mmqEAXOVlza++4SVKn13eatq9TvDeU1cYJkMuyOvvihzib6gNHGfu+2SaYJASmC0ylLrhY5YdXztrXXVExVrcJAmJYoOXc2a/wAf4nM58KYqDNum/vH+zmzZv5/jIXIMGEh6Pa2m1SfVvd5S0JbQchvYVYzvrfmcsNnWDqJU7i1bFcBPlrjkQl2Fyhi6DKEwkFseB43kG8YOUpcMtxouLuttMQ6QPEapAzBrWluTCuh37YTRa7Icv59pBRTQKdq8RjixP2ORNOyarI4oWKi9JTi18xa9doaY5Ycd5upokSoRY6fpcdW36ktskS8QvkXL2xYWMe0gRWmXBGyCxa0bsMjqpZiMuQjgAo01Jwp/3WV1yC6DZvL/PdlQbSwzOUpbZ6X8srkohwRsm3l+Qtw1O3mXCFoM0KqFiu6bX6MeFOblnM0hk5b/yf8MzPOpBUgJuMeECsk5W7nPwrPzoOp7ktyLLu5l4W0WXebHXd167WsQuW17KFffudh23oSwmKyRZExgUHaC3vk2ZW732i7jabFoPvce3HNjCIzq1uq4BjxY2dhuwjhBP0e+D0oM2T//C3cQosVJY4wsI2DxS1Ccjd2YDoadlu6iS5q+efOQAhEEUE0T+SuuB68bsbuu/H0hSXWIMDrjPqThseM8+8BCzD6LNT/kkZkRuJHAiq20qcriDv6lGM
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966006)(36840700001)(6666004)(5660300002)(82310400003)(4326008)(966005)(16526019)(2906002)(83380400001)(186003)(8936002)(2616005)(36860700001)(70586007)(47076005)(8676002)(36756003)(70206006)(26005)(356005)(316002)(53546011)(478600001)(36906005)(7636003)(31686004)(54906003)(16576012)(86362001)(6916009)(426003)(336012)(82740400003)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 10:11:21.0515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aeb0558-0fd5-43b1-35ee-08d966e78573
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1884
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 8/24/2021 5:47 AM, Jason Wang wrote:
> On Tue, Aug 24, 2021 at 6:31 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>
>> On 8/23/2021 3:13 PM, Michael S. Tsirkin wrote:
>>> On Mon, Aug 23, 2021 at 01:45:31PM +0300, Max Gurtovoy wrote:
>>>> It helpful if there is a justification for this.
>>>>
>>>> In this case, no such HW device exist and the only device that can cause
>>>> this trouble today is user space VDUSE device that must be validated by the
>>>> emulation VDUSE kernel driver.
>>>>
>>>> Otherwise, will can create 1000 commit like this in the virtio level (for
>>>> example for each feature for each virtio device).
>>> Yea, it's a lot of work but I don't think it's avoidable.
>>>
>>>>>>>>> And regardless of userspace device, we still need to fix it for other cases.
>>>>>>>> which cases ? Do you know that there is a buggy HW we need to workaround ?
>>>>>>>>
>>>>>>> No, there isn't now. But this could be a potential attack surface if
>>>>>>> the host doesn't trust the device.
>>>>>> If the host doesn't trust a device, why it continues using it ?
>>>>>>
>>>>> IIUC this is the case for the encrypted VMs.
>>>> what do you mean encrypted VM ?
>>>>
>>>> And how this small patch causes a VM to be 100% encryption supported ?
>>>>
>>>>>> Do you suggest we do these workarounds in all device drivers in the kernel ?
>>>>>>
>>>>> Isn't it the driver's job to validate some unreasonable configuration?
>>>> The check should be in different layer.
>>>>
>>>> Virtio blk driver should not cover on some strange VDUSE stuff.
>>> Yes I'm not convinced VDUSE is a valid use-case. I think that for
>>> security and robustness it should validate data it gets from userspace
>>> right there after reading it.
>>> But I think this is useful for the virtio hardening thing.
>>> https://lwn.net/Articles/865216/
>> I don't see how this change is assisting confidential computing.
>>
>> Confidential computingtalks about encrypting guest memory from the host,
>> and not adding some quirks to devices.
> In the case of confidential computing, the hypervisor and hard device
> is not in the trust zone. It means the guest doesn't trust the cloud
> vendor.

Confidential computing protects data during processing ("in-use" data).

Nothing to do with virtio feature negotiation.

>
> That's why we need to validate any input from them.
>
> Thanks
>
>>> Yongji - I think the commit log should be much more explicit that
>>> this is hardening. Otherwise people get confused and think this
>>> needs a CVE or a backport for security.
>>>
