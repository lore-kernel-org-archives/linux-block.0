Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24381C61DA4
	for <linux-block@archiver.kernel.org>; Thu,  9 Feb 2023 19:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBIT0V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Feb 2023 14:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBIT0U (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2023 14:26:20 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8550C6950E
        for <linux-block@vger.kernel.org>; Thu,  9 Feb 2023 11:26:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LglJXtN6gBd0qVEAf0Wdl7gXzw+okzauN8QqxhKbhMRjZ4mLCe0yFlEcWK2eSS7Ri0BXAq9luCcg6ZPR+ssg70HPFpAd+ZOs0to9wW/3riiwc3tuCMpImjgE8170kPRkkiouOO+/gYsjvsKR5kbp8fqH+TL1kaA4AJp8ejskw1AnpAOOTFhqs4ybNpTcbfoyQsdsk/27bN2PlVMo5BVAo8FmShMpZJPH3Tujz04xStqnnsz09izKTDDYudzlfYspcKegVF9oxBtcMXkdRWPRE7lYucXMiFiG/eYxQldTp7vfYAulJW/2TWbn+wM9lTPdg8NhWmWl1v7gL8yf8pUASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDh13CPiCpAbTNjmiOLwI5DZGODbLzwGQ0Fm0JO+430=;
 b=Pue6AgP1Q5BmoOJna/GjMmb3ElvRgH9oX+wp9BXS7QdoHtLg+/Du2k1UOGc0Xt7lNhoU15f31tzB41ry0XpAsCI1IVMm5gidCXHOr6ax8gkFb1b3EX3BsCvLxLhL9X4S/c2ZEU8kzV8NwHjto1bduF3lDBzD4vtMYkI7VXgU0GhsolyjkBnZ9wgxe1/W4o07DtHDNQVBoXTr1dUPMvmLI/2gkYKUCL33zhilb36VKmk9RqB8p97D0Ct1CCTbp2pyJ3mQ6vLqNYDJdpLfls7/pBqwzAQlUEDOg85W0HMVMQl0BOLZ4ZxJlRZVdXlqgmVLmHhOKVBPwtN5X1TXqFvHTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDh13CPiCpAbTNjmiOLwI5DZGODbLzwGQ0Fm0JO+430=;
 b=oEzi7jicj0mDlJeN0msTX5qNFCOAF1b2Z9lBzHNIoFE7DaFP35iZfABjQGXqaUtG9+t6UBI84rrxgZXlDfH0E3xAP8LvDugKeSoKuSr/86sWeUjNnNSMYdXL53uVSX60vDCbN2ttuRINELDkAiGrRd01cBVCp/5rs1CN5G/GHdGV/+Pj3tvk6GdyULqtQdOgNaVjM0v7Zdq+6faeg/PZxrtrRF1x4MSrzS9aEmG5eW93e+kVLClwXFePTrxaRVS2FPAy+gjNkVWK3kbferjx7Q1oeUCsRR1X65ZQlRoSBSoefLVmNOvN3m9u077u2DvkT9DQLYJKa0ydx5ZA2vnUkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 19:26:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 19:26:14 +0000
Date:   Thu, 9 Feb 2023 15:26:13 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [LSF/MM/BFP ATTEND][LSF/MM/BFP TOPIC] BoF: NVMe VFIO Live
 Migration
Message-ID: <Y+VI1b+gztQE3rOD@nvidia.com>
References: <a0ef2710-43e5-b856-f9ce-e6f1ba99df51@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0ef2710-43e5-b856-f9ce-e6f1ba99df51@nvidia.com>
X-ClientProxiedBy: MN2PR16CA0056.namprd16.prod.outlook.com
 (2603:10b6:208:234::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: abdde7e8-4ce2-40ea-ee2d-08db0ad3825a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VrUrC+o7t/p4Sr4SIxWV6/q3d/L/+MsL7lzE/SNhDIh+ih1R9CYbf407cH5a7KOBK1ekrvpvigcPQd5rAR2SpbtFFP3dFvWHQkTA/je1XfG3CDU+uIDmmm3D30ZAfL7j94mKCVpTpjMuRXJigUyknI74HE14hSjB4zAQLYT/R1HBVzFKrX8kuVs3z/NPfAux0kvheC0Vo38hDWyHmO5LSn1vVISgQuciZa4F07QBFZu6F86kcPrtkKWU/suZjJ7G6cpGqGPh1FH/lbfGQorBHvvcaD9XHDNvmtdZh2RIF3mHcdQvxPdvsPFH3Iwmz4JcgGDufolE1ZlHBCxHiWzuRKJvkbtIclD6zjLxanvzARktQ3RTkNytnRkAozv2QAo+wWUcKRZVWdVe0lTtIRBwHS9E/qMZyP5GwaF9aEYKH313RhrShc7KL3uZhc1KcRSzf61319dNyLm03wQoG/qGT1H1R0MNJJtbhcR6Cfz6e2jgoqLSDlyCi9d330e2TaMpe/HanfWRE9aiwv3Hjf6up1gx8RWWAEROT8RCJTwBL11x8mJ+1Xrcb40X8nvhVG8iv57zvKy7WFaMsZUy/1v1+7UV0HTyfdM4u17I6ygP5jxx7bwVL9URfZgEi2FStyHAykcs07APO0HxweHVwcPuPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199018)(4326008)(8676002)(66476007)(66946007)(66556008)(41300700001)(2616005)(38100700002)(186003)(26005)(2906002)(8936002)(6512007)(6862004)(6506007)(37006003)(316002)(86362001)(478600001)(6486002)(5660300002)(6636002)(4744005)(54906003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X4s3Gb/mtnkWx6dxRZ9Kbv1jicGAjrYGJYDYCQtGgNP/Jnbfk92OvBsT04gb?=
 =?us-ascii?Q?T9gLjVnKdMFU+JBWzrDJpIhRwMo+d7OGY/RxMKiZ62xhMe6hUq27pC5zasUM?=
 =?us-ascii?Q?VtnV0LrK2avHBNQldSlshfIwJKCwuy9wOAp0ZwP0a1cnisFaLFAIUMr38mk6?=
 =?us-ascii?Q?sE0pqR+4C5EBF1uRUkWLcZ0Iw4iLLOKqths7vxuMZnCU1Rblk978Xea3RSZV?=
 =?us-ascii?Q?u1ONkCmJWLcoAJhlfK2NuJjjBI0jt7MyPZPZaWstXk3lFGkGAOuNo9N4OxHn?=
 =?us-ascii?Q?2hCvcogRQdVOpK0zrxDOgWHFnZ5SUwlvg+uGmz5enZ5p7hDrA8V5GcIuJDxS?=
 =?us-ascii?Q?eAhJ0CTxjTayx2HwCAvhkW45syV3hePMeWfkcO//rhL7B9iN3DurDpn12xU7?=
 =?us-ascii?Q?09ru2ZbtNF41HoOSkdkr0fzk+WdqXrBGSDUU7m3jEKqNy5KU+KRqc1GjBHSW?=
 =?us-ascii?Q?KrYSLlDXdSuodrP75PADVTHn4lk5R3K6V+rVtBgVTDpyt8qm7BhHLTp911sj?=
 =?us-ascii?Q?4jFYiEqUD7c5nCwV3Vh25xwpn6wePdW1EQwQIh+cSG7xbnA3lFlH/hgR7OqI?=
 =?us-ascii?Q?9E6WFV8bLo9ThZNC6Zly2UIUa/bNTFdLsTHzZYK93FyzzjPXQbDDwUs/egm7?=
 =?us-ascii?Q?n22RvKW84Kt4vhD2Df1wsuEpMsoeuDLinfQ0NJovwBGeAGisDJNwK+srQUsO?=
 =?us-ascii?Q?6kYGR+qxKRIRxLHsaKhj4kYMwCR3PSdkIIXUWCyhhjhe3WFMdD/YBLnPDysu?=
 =?us-ascii?Q?8tfDIP3WLyCc6ELYQAmkZ69ERMiFUKarO6QbSehnACVc0pQ/jjhVOcfJuRyW?=
 =?us-ascii?Q?1HyLwmMvmFRk32sgSCn9ecXHsDqJou8vDv4BKSF/tv/6I/PrXdEoJmck2ZWz?=
 =?us-ascii?Q?ti+PinZhIkCIkhch9ayuP0EufPQFqpB/ynZtZd2Iuk1BqayrcxULsSYql+MU?=
 =?us-ascii?Q?x2D2F2uLo7iJq56C/n6Z1xpDFG1hPGTAxsBhG1TQEhpz2eWMfYqkfnIFsqcp?=
 =?us-ascii?Q?Ya0B/yEHdX0MlV3rd0TiU474K3RdF+0AAcaxsDwFo8dbwOCdLz1d1ElOzmad?=
 =?us-ascii?Q?W9G3xBJMeZz0P1sP7DtWR+u6GAVBEioy8OqwAvH7senWyjO9HXwDdiYiaNf1?=
 =?us-ascii?Q?ZSoCqokEQSUmEcI8T1Bp6N0jQT0sPvokspL4m+fF3R8gXC3IP0E2Vi8x2s+2?=
 =?us-ascii?Q?+0ev3SaRTvmHSaeGO+RtRVJD+sGNcg05m+M+4K+tn1ntTdRJlvsPMWJ0XQ+0?=
 =?us-ascii?Q?X0kolYThQmXEwkW9UQ8Qf7w6JlWuCpkCL07vQlwRrJNOXV6FNtNBxbWkYWT7?=
 =?us-ascii?Q?1A2aF/NEMFiMxJD4AXfoosr1ikF52tSOP68wcRcb8o0tTrOL7AbDjXMJd6iW?=
 =?us-ascii?Q?dViWjR1lSRW9cATe91VR0xayRkO02sUMBwbiMbYD5Xli+0P6mEVQMR+N20I3?=
 =?us-ascii?Q?GZH+IeQ/ZQ3uYO6GDYs6gyjLFBUB3U/vExgJqgJjnQ/so7yyAcQfh8gk9E7s?=
 =?us-ascii?Q?8VJtdHcc9LLv5bZPzFxSZJNqj01OXRUJLXpAF4gfkjIjsh/NRA6CimkDRuL0?=
 =?us-ascii?Q?RBSDMZaumX8u7QIE2nBKoSmwikAY5KaZsHCeWCn0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abdde7e8-4ce2-40ea-ee2d-08db0ad3825a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 19:26:14.5212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdcjn+GU5gpQqo32qlZKS0dmRTsW43qYxUw0E8jY3XfnWyjEA6Kbl/6CniwlRFWm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 02, 2023 at 02:13:38AM +0000, Chaitanya Kulkarni wrote:
> 
> Hi,
> 
> Since I've conducted NVMe VFIO Live Migration talk at SNIA SDC 2022 [1],
> there has been significant development in this area in the NVMe TWG and
> on the mailing list with RFC kernel implementation posted by Intel [2].
> 
> Although RFC implementation is far from the actual implementation since
> there is no support for the standards for NVMe Live Migration
> commands, it did bring up some interesting points about how the
> kernel implementation would look like especially between VFIO and NVMe
> subsystem.
> 
> I'd like to propose a BoF session for NVMe Live Migration and
> discuss what are the kernel side implementation issues we need to 
> address apart from the discussion we had on [2].

Sounds like a good opportunity to discuss the Linux side of this
implementation.

By LSF/MM we should be quite far along alot of the migration ecosystem
work in kernel/qemu/libvirt/etc

Thanks,
Jason
