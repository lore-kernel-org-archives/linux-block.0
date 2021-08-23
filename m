Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FCEC4338F
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 09:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 402C061262
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 09:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhHWJF3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 05:05:29 -0400
Received: from mail-dm6nam12on2051.outbound.protection.outlook.com ([40.107.243.51]:63712
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229699AbhHWJF2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 05:05:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOwMJIBK1EZ9KNJhpeb+jBduH7XSsBuKdoKQ1MdzvN42E5S0eeo19SZn2ZIh2zdIK6LiqVNLOz6KKNgJP2B/0GdKHJCuBpcOaieSDgBMKLuvPCr+Jsjk0xaDWgkIuGfqMZ6Jp6naNSBGaUpTYu2L7Hx8sRQiSdDOAjecljN1LO6R74m2SKCdpeWLuees6REeZkHLT6IlILjctOJinOH5dCafXYHT+uWBKNFxDsaAke//ZIgUvtidQdWwP3P3y/KHsAcyqNSX+lV+rNMNeV5nQCo2MvJLL1OogjTlf8H0gYhbXMprU2nGJua5XiwFTN1hl4w2EAgwuJVBSHysMFu4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SfvdNG+Wnk86dkBb9fC9eVANOWy6qK5XHbmtqZmgx0=;
 b=mVlGjW3x6a/1lPq1yXxJ+tYMaeSPAiHLsZynIiCvwszpw/T30NDk1+GwA+N4uJ6SjM42ff+p7fw0oMU58VA8CEPxcx2Z8M9ac1oONS46Vj3aEIVASUPM1mZj9aMX/wpyOvY93OObERiQ1teEdSOWYpLQT+2RC6XrzIkS87SF1Em2SD5mMHUDLSqjexeQp8mX5hC52NzvrXGkwM6Rhoo7T+8siXyCNDTtA4h0Ak2WIc/7rgOcXHqCXEqZzAU0tkoWo+9OcSg5qH1xtU54XlpBBDDmoxsrrIoyIX4iD7IFE22ri7oMXZgcnZ4m6bdGKz0tRw2FRAcxJ9aSMLu/VgYN3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SfvdNG+Wnk86dkBb9fC9eVANOWy6qK5XHbmtqZmgx0=;
 b=MuU0eVCL3r33+xlc/NhKo5g1nL4TLwO2LX6ELwYxVM8TvegtO1KWeNoeINyX4V5C+kee98gfzDBRZLBAlVMiI1su+yY7wyeWmtfjJ93Zj/7YBIWufH2is5ZHAyyEa7IKWSJSgbPerm5qU93xeuSJgNyC1e96EkfmuO95GKecouBzRXcMuMbdBYPrEnRTlK928p007GVFVsG0B9NCZP1KF4KXQtLuJFJlrxU5Cu739ve8it8kqWQfdad1ldDc4+FMZ0JbVlIhdvMZLhM5I+8I/li362JP0OaVi5EXON7g0aVhxzXUmmEd4Npsbs5wDWTxtlKdpn3eUvnnEOy6qKbHKw==
Received: from BN8PR15CA0038.namprd15.prod.outlook.com (2603:10b6:408:80::15)
 by DM6PR12MB3180.namprd12.prod.outlook.com (2603:10b6:5:182::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 09:04:40 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::c3) by BN8PR15CA0038.outlook.office365.com
 (2603:10b6:408:80::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Mon, 23 Aug 2021 09:04:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 09:04:40 +0000
Received: from [172.27.13.55] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 23 Aug
 2021 09:04:37 +0000
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
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <06af4897-7339-fca7-bdd9-e0f9c2c6195b@nvidia.com>
Date:   Mon, 23 Aug 2021 12:04:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACycT3v83sVvUWxZ-+SDyeXMPiYd0zi5mtmg8AkXYgVLxVpTvA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 311b9ea3-c640-435a-b9ff-08d966150a72
X-MS-TrafficTypeDiagnostic: DM6PR12MB3180:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3180E89594B2F9B8FC998FBDDEC49@DM6PR12MB3180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XAyDAKZz8pNXIrxeJw7r+fuqI6pA8OZW+vYfsn0qLBrac8TEY3UxPKUtGU5aBOgh7d0H8w4ZynvGn4bT4955gc0ZZROpIY8u4Pw3eC06UaGyay9Tt201H5zyGXrDFNDEtDHKCYX2rSjd/Vx4N2lEX58QZ2+moVo1ZwsuPu+89lvC6ZxQOgpZZeCev7A/cumM+YI7V2CdzLRTiz1pXg7g27GLpyMqmX7U6ciZab+V/7a7c2rgyUOlnSxdjuzZ5IDA2z1jw7bY26e6PkFk6a4TiGYBs4rGTZQcrO4k8QcVPECe2Wu7t3c9tPF41wQukaR5Tx9W3qdK48cYDvpD7V5kL/vcP1KUGJ+3AOWctYuJ90sKtpPMXZbjF1UKVdfCCsPW3Nz9EXfHLRj85Igr3P02bIUPSvhUs5kz9GTpPg+cWvfn9ujOzJWz2n4XUNz2Ak/4xMbhEFA6oSqYqAqGrqz7h10F77NhznPAGZsIhvqnR+XmrmjU1UJK+amTC2UMisvQBsvldolT/Z1idpzDqGGlJCUN4a9ujwbOnYXq57/tRLkntdPsCdQsL6Yn7X9UTkFNLUxruMl2jBk+hcUQovGbtLJU5NwUmu208DAi1989x4PJ/pj8Fr+II1W1yN2hb2rVZbexbWRdoSTwO0wfM+qC/tyXmxU1HFjEHR3A5Ta0UBJa/SfpIzPslXigR729ZP7cVDI/Ywo4pl5m+4gLBaZJWpDHbRUAabdJf6Vu/cwt6Mz45A+cXfP/uRnNSlDHI4QmPCX/q6FsVd0eE0dr8A4lv4Uzm1dmcvVs1EsHGuEF3xc0P0Ay5WpSx+8+brxOQmR
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(46966006)(36840700001)(47076005)(53546011)(16526019)(186003)(2906002)(6916009)(31696002)(478600001)(26005)(86362001)(31686004)(8936002)(83380400001)(966005)(5660300002)(8676002)(336012)(426003)(4326008)(36860700001)(82310400003)(36906005)(316002)(7636003)(16576012)(36756003)(356005)(82740400003)(54906003)(2616005)(70586007)(70206006)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 09:04:40.3564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 311b9ea3-c640-435a-b9ff-08d966150a72
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3180
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 8/23/2021 11:35 AM, Yongji Xie wrote:
> On Mon, Aug 23, 2021 at 4:07 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>
>> On 8/23/2021 7:31 AM, Yongji Xie wrote:
>>> On Mon, Aug 23, 2021 at 7:17 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>>> On 8/9/2021 1:16 PM, Xie Yongji wrote:
>>>>> An untrusted device might presents an invalid block size
>>>>> in configuration space. This tries to add validation for it
>>>>> in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
>>>>> feature bit if the value is out of the supported range.
>>>> This is not clear to me. What is untrusted device ? is it a buggy device ?
>>>>
>>> A buggy device, the devices in an encrypted VM, or a userspace device
>>> created by VDUSE [1].
>>>
>>> [1] https://lore.kernel.org/kvm/20210818120642.165-1-xieyongji@bytedance.com/
>> if it's a userspace device, why don't you fix its control path code
>> instead of adding workarounds in the kernel driver ?
>>
> VDUSE kernel module would not touch (be aware of) the device specific
> configuration space. It should be more reasonable to fix it in the
> device driver. There is also some existing interface (.validate()) for
> doing that.

who is emulating the device configuration space ?

> And regardless of userspace device, we still need to fix it for other cases.

which cases ? Do you know that there is a buggy HW we need to workaround ?


> Thanks,
> Yongji
