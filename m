Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED93BC4338F
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 22:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2DF060F4C
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 22:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhHWWcB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 18:32:01 -0400
Received: from mail-mw2nam12on2086.outbound.protection.outlook.com ([40.107.244.86]:36193
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229760AbhHWWcA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 18:32:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIjCFa+OgAJqx1h3XPuTqYrtgjn2KM53iNPsN5tylhXX4DCY2PKa1HJP1uF7lG6uEyJq/nOGtMF7mSLIcuvFNrFfZo3DEtyOS8B3j3yvxSmm2sfdauGYZxJbD7kJGzkFpgJei+MYOClcNgKPZU08ulgJPBR5HhGm6y2wLsTBMxVFOwtwo5H4lX5ZNzJ50xt/u92t7xdDz76UROuWdm2vXEDyTOYxvgly0sc3L48WNX7MP1J1p8zfG9BZaiXPFnvFgvCtT7UuLv9ow+BGajy9rfACdAWZ5nWWnUfLzjFTsXjPQNhcu8wa5BwKAgHsj8ohmkLRrDR4dXmAPBDReTeP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TomfH4lnNNRczpdPZu9K6StUDQXO27kkWoOuagf+NdQ=;
 b=etsWDKgjYzGRdWWf+vYHugk6OABxu7KUMRuDu4iGmTMrzCZXd5n/NZ+sp0YkkyGj/SpaG8wCRMGdHGo8W8qRnaatcA7UlFxH7/jUk4irAaD32UWXXAi/KViPQ9yhH/cvMCkEaLl77mshBjmIyMXqt1quD+MdVc2X2I1uamsOwc0TnX6DgzWOe5wDpS7WIFEYRMA9ujp3tXLxTtOzkFcvXO5crWpWk6rcYr4QP7xDszEi638dAXu1qwdMC+FRyi3ofEGspPkSo4x7M5c302PMfrs6yKfylJIt9pMj02oOxQvy4Ttu5SRK2fuhOp6zyk/Q5QTuLGWMHk8Ac0Mo11wCnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TomfH4lnNNRczpdPZu9K6StUDQXO27kkWoOuagf+NdQ=;
 b=kMXP22/h/8KdVko9lV+mfDTwBUF5/2lS7qdb46KInLEGM8esffODEa1w2LQN0hlTU/Fr39WlIpH03miqNPiGxfmZdImS+immIdMEz4N4RKYLo7e8tKu/yllTQWOibI1gNu04ApPEfBB5cflLg6mkUOU+uBYl5H7uyWuo+4CgyxFNXvgNV4pJfdCBMTN2X3XtcCSewAuc77haD90lwiR0gsS4391KOOEuRZjmiXjExfT7nn5Q0dT82IzD1OBZOLVFlrBc8Hp/QlPELyrxRMFV0R5/d3+LYm+t1OVGZkGK56pNpXycbbwnu7tYa1yCG0csZrAkHvHvntBuKRfE+gnsog==
Received: from DM6PR03CA0079.namprd03.prod.outlook.com (2603:10b6:5:333::12)
 by BY5PR12MB4801.namprd12.prod.outlook.com (2603:10b6:a03:1b1::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 22:31:16 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::a1) by DM6PR03CA0079.outlook.office365.com
 (2603:10b6:5:333::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Mon, 23 Aug 2021 22:31:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 22:31:15 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 23 Aug
 2021 15:31:15 -0700
Received: from [172.27.0.198] (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 23 Aug
 2021 22:31:12 +0000
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Yongji Xie <xieyongji@bytedance.com>,
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
 <7f0181d7-ff5c-0346-66ee-1de3ed23f5dd@nvidia.com>
 <20210823080952-mutt-send-email-mst@kernel.org>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <b9636f39-1237-235e-d1fe-8f5c0d422c7d@nvidia.com>
Date:   Tue, 24 Aug 2021 01:31:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823080952-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ee8a483-ac08-4b6b-dc4b-08d96685b845
X-MS-TrafficTypeDiagnostic: BY5PR12MB4801:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4801113B750352B33DA64AEFDEC49@BY5PR12MB4801.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2qWfUSeX2vnZoNeQlYRMjGPU0C0duWgQdsgT9EdVOeqybyP9Xn8fSqq+3dxqhWQfykFNCSr2llg7qljOJZC9Y1jQ7D7PQ59LKK62wiOswZxlA652dB0WvR5Qc/NTQQ8xEIeGeRWUD1EQ1OpPNSxGEN1/AWNrs12fotS7zt32YRztt8M48yC4CfxozKAx+bZrPrhpgPgR1r7X73gHxMrcEi4wurjZbqYGiaIKN9Xz/czYZI+g/vQaf81PO+pvBGMEKl4utVL03DJ05T15MjW42Z9JcnisSPHF85w1JsorjB4KvsU2Xf07xUK5993MgryT/pXNaUgyMnKZqAPG7S2YnOPDknWB7yAfIBeMAlBNbbWILZ4aDjdqh+zD0O7ZiODgDq8frogOzHB4daCU1FLu+jvF0H8zR9wc4xwsUxF1ZzVpi9SuJBKiKn6QDUJMccXxRpf8+6h1MxToyxaGy8j2xgT0Z8zU+BihEU51G0oJEh4Hmjsnoyhg5q8a3jBVHeIxUUMEQZkNaHeRnXGEQ8U3/nI1u9SzkacLgiqQOWwZhObfEbv7ud4RSLe5rt31uBlfWHB89y0pWltp8h7tiWOXZmx9mzAxhSdcEKDwqitZ+F3FbwwxJnmP6cJXdxVqKpHwMLfZMyL6iHD+JzrfwaHBa5RNc/FLXkyfirqVvs/nrDWojdJcR/E/tgYg4d8cGHxtqEx3nojmlx2EnqVZYffErsvwJRKZ/Hb4IPlJzftJDiZNjn4a3G5oswHIdew58paWrVgoeTS0HWBbDs8xHqWbeVJImD6LKhSqAMjISHp6jKnvKkhNz38UxZABwkJ+SK4T
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966006)(36840700001)(5660300002)(356005)(47076005)(7636003)(82740400003)(70206006)(2906002)(86362001)(316002)(82310400003)(16576012)(36860700001)(83380400001)(36756003)(31696002)(16526019)(70586007)(4326008)(26005)(8936002)(186003)(8676002)(966005)(53546011)(336012)(426003)(2616005)(478600001)(31686004)(6916009)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 22:31:15.5316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee8a483-ac08-4b6b-dc4b-08d96685b845
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4801
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 8/23/2021 3:13 PM, Michael S. Tsirkin wrote:
> On Mon, Aug 23, 2021 at 01:45:31PM +0300, Max Gurtovoy wrote:
>> It helpful if there is a justification for this.
>>
>> In this case, no such HW device exist and the only device that can cause
>> this trouble today is user space VDUSE device that must be validated by the
>> emulation VDUSE kernel driver.
>>
>> Otherwise, will can create 1000 commit like this in the virtio level (for
>> example for each feature for each virtio device).
> Yea, it's a lot of work but I don't think it's avoidable.
>
>>>>>>> And regardless of userspace device, we still need to fix it for other cases.
>>>>>> which cases ? Do you know that there is a buggy HW we need to workaround ?
>>>>>>
>>>>> No, there isn't now. But this could be a potential attack surface if
>>>>> the host doesn't trust the device.
>>>> If the host doesn't trust a device, why it continues using it ?
>>>>
>>> IIUC this is the case for the encrypted VMs.
>> what do you mean encrypted VM ?
>>
>> And how this small patch causes a VM to be 100% encryption supported ?
>>
>>>> Do you suggest we do these workarounds in all device drivers in the kernel ?
>>>>
>>> Isn't it the driver's job to validate some unreasonable configuration?
>> The check should be in different layer.
>>
>> Virtio blk driver should not cover on some strange VDUSE stuff.
> Yes I'm not convinced VDUSE is a valid use-case. I think that for
> security and robustness it should validate data it gets from userspace
> right there after reading it.
> But I think this is useful for the virtio hardening thing.
> https://lwn.net/Articles/865216/

I don't see how this change is assisting confidential computing.

Confidential computingtalks about encrypting guest memory from the host, 
and not adding some quirks to devices.

>
> Yongji - I think the commit log should be much more explicit that
> this is hardening. Otherwise people get confused and think this
> needs a CVE or a backport for security.
>
