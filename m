Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F215FFA3740
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 00:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJ3Afq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Oct 2022 20:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3Afp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Oct 2022 20:35:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B8F303F6
        for <linux-block@vger.kernel.org>; Sat, 29 Oct 2022 17:35:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrPGLyax1jeqSlc/MzsSSC3XIW06MAiwXngNW2+QF+emqv7Nm2h8sTs8KtEMQBYWWX3NH8vTq3REgseylbuNlxFd2IMHEVhiAHpcWyJQi0PT2yVrwu2johPp8P1tcxSCWXqmMrTTTXuH0xRdCpnAyIDVsxDacfIdvuALkfFY1CjQQYmSzNEzOeU03dT7kDYacRfoGsxHVBVfludx2lMQclWDUIwJsb6XRNle8UTVFTy5XrC9atEp4AezyoOKoYkrfeRHW/eiJLo4ZgPQnLk2UsERYUnY8J9/gZP+8JUu6y7CWq+OQodVK5kGV8GTfNSh7MAjDlxcwyl+xtj5jHikig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnCK6zX2MKu8YV9yYHy+A/s52AWlh6xB1newAZAC7Eo=;
 b=cf8MZ6F2AHuXjKc3VvJ+ydrKrEFhZjbUAivbgi5+FIpYrJRLqPfvDBuMuPNxAo2A5W6yVnwvwhUAYpahGHv4KmC37LTtsTmPdfbfBE5QJt17ntDS0kPaBO/YBpYXNZqPmrxe/ZzAFREXX1GlGcux0ir1mHOcGN8XkR1tmRnQmJjYS75tWEKMafBFeklcQNK2tdvtlXwytsFlacpNZz32IzwN8H1/Tye4Up+H5WVOoUJpD4CvrdGIDZdaTEAw7XUQLzd6j+aoMpNRzwJBTHfq8FynpNaGFryVQRjlRs6xLowJoGQm2mDo1WpTIRJmPINsT3WL4SfZ3xN7AngMxh53xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnCK6zX2MKu8YV9yYHy+A/s52AWlh6xB1newAZAC7Eo=;
 b=F0Nby1/jzV0Es4ISEvgOWihcQ0Yop1YUAe8YBdBYsgUlcJmSLm498erH+xoOEWJKnKEntvwrK90bHx5iSEp2bddvOT1sGRHn2d6FdKFr4XwABY7Tq9Ysj4n90+QvHvcuzr4uQ1UHkM5dJIpxfYf8Pg1l56WfIsIFtklh1pheFqu0xptj+C/lw3kUJzDWgfWhPtNVafzFI/ic5RfnA1Vn4PsiazLi6oHMajy9DD4U0MNXE5Ol9rGh0kPXja42XHEhwc5aCYfeyozSCPf0rbogE760w3MEiy3MdOspKx76ehJd33a3fzKWCITc4KLxzP8gn+XTBrmpw2vXP08g7jAPxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM6PR12MB4580.namprd12.prod.outlook.com (2603:10b6:5:2a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Sun, 30 Oct
 2022 00:35:40 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::ecb1:e665:24fc:fdf0]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::ecb1:e665:24fc:fdf0%6]) with mapi id 15.20.5769.018; Sun, 30 Oct 2022
 00:35:40 +0000
Message-ID: <6cb0e4dd-a5cd-86b6-ef25-c0ef7a44c5fb@nvidia.com>
Date:   Sun, 30 Oct 2022 02:35:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 1/1] nvme: use macro definitions for setting
 reservation values
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        oren@nvidia.com, chaitanyak@nvidia.com, linux-block@vger.kernel.org
References: <20221002082851.13222-1-mgurtovoy@nvidia.com>
 <cfd01d2e-1f87-2295-13bb-c8705b3335f9@grimberg.me>
 <3354c32d-34b3-0997-3a59-8fc199e6640a@nvidia.com>
 <20221025151914.GA23422@lst.de>
 <Y1hsoZNjDMhDbemd@kbusch-mbp.dhcp.thefacebook.com>
 <20221028083127.GB1043@lst.de>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20221028083127.GB1043@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0402CA0015.eurprd04.prod.outlook.com
 (2603:10a6:203:90::25) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DM6PR12MB4580:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a239c9c-8926-47d4-c093-08daba0eabe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 34hqThTJxXyz4JADh17Rs1XKjLYhHSk72781RNzRDRWfWQuqP9MaXfP9O1PAYu8yxFpErW6HVqUkcFrLUIpnQgG7k2xiZXa3ct00CheAVcrt0w+mowf7CmMq53RxBdRtxPjwwVLRxb12OFSPVzV9wqy6nA93JXNgtH6O56ZlFdrQKi5A5WR+6nXS35VoZuyVQRR1X1F46AJqKbXibN+n5NicE3WwegzvT0HDRo1aNcl8l/+tnWrSzcZgQCR7e0uudljQWyu5I5/u/uXJxeYMB/7B2RxJhSwkVN/OEC85WnP+s3uKZ92Hnfy8n8V6SfmnhsKoXurK79OoLwrylrgG7uDCFVdZYFUyQyMzvImtm1k7udkWJrLiHZ7OBtOWubt/FEmNVCnbJoV9vlkFwLVauvsA5l1yQgST6T12BkkRspJH3aByHg/XqlCPSfU+8rOpL71kmNHTapl+8lR6o/lGvBQlafoBkV9VguAcTmV9cdDe9BpxUjL0Jl6aJoSj+FAqrAl+AzZWqhDQjqs7IqwS/l0Ggw3bgrLPS4PzPeIaiviWFAIT8WA5TVHj8qR9Cc23UymW7I330JjEErk2zorRVLxQaoRapWpnBDPbTUUHJJ5VzG4/u9r2V8yfDDbU2S6KTuuJis5FxqHfPNZOnqQKEZqSVaxPYdQ5bwNv1B8y4JaDAf8MOY7CtiqDypQ7SmhhL7+ufkJ2fU/HWbw2u3oEr3YvJkjqfiCvuRE5aJOzwq49hT2QyR2OEDS1OjKL1vvyxVYuKkhilgyJFVRp/lE7FgcjYjHlzBdEwcoUC4VS1s8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199015)(6486002)(478600001)(110136005)(316002)(6506007)(6666004)(86362001)(31696002)(66476007)(4326008)(66556008)(8676002)(53546011)(66946007)(2906002)(41300700001)(83380400001)(186003)(26005)(6512007)(5660300002)(2616005)(31686004)(38100700002)(36756003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWJuUExBejZLL2JWNURtLzJMUU0yczBsT0R6V1VJR2VVTEZ4YmtJTnlJYzlH?=
 =?utf-8?B?eHZiMUp2UWYvMGs4ZktUeGx1UEUyT3o1RUUzODJ4TGJvekUrZnVWVDh2MUtm?=
 =?utf-8?B?TGI0Ykd1UDcrVnFYS3MrdDNLSm0yNmoxZGNoMGdDQzhxOGoyK0hrSTNPbCtU?=
 =?utf-8?B?N2FwZ1FZUHdud3pDVjZvbWt5UGZKZ0VlOGdUb2tTbWo0QXF1VWg0TUMwYU9r?=
 =?utf-8?B?bUdlS1FZQXF1OVMzNUhteWZ3amVCWmdkSS9vS3Jjd1lydGh0US82Rk5INFYz?=
 =?utf-8?B?ZG14dXZKbU8vdy94S1NVdzNUWXZXS1lxY2J1ZndMeUJ3WG9ZcGtiUHlzdjFs?=
 =?utf-8?B?NksxY2tubXFMblRqTjBzOEphcTVoUHJGUTVNMWVneEZNNWZRSDlFMkZ2dFR5?=
 =?utf-8?B?T2JuTHYzUzU2aUxkYnNIMkNqdmh1RHQvb1plMGhzb1NKT3dzWjVPZTlrRkRP?=
 =?utf-8?B?TmpxMXJzTWNjRjdIZEJVTmlyenVlK0JFMGVRWFgyQmwxU1lreUJLUXZnZUFm?=
 =?utf-8?B?UldueGNiaHh5NmhHNWFja0RZcDk1SVNYN0xzdTIrMmtHYjlNVFFQMU01NE5k?=
 =?utf-8?B?a3Z5VE5iaWU1R3FXMFpSbVhtK0RpWDV5c25lS2hXcVpac2E5NXBLd2tZYVRQ?=
 =?utf-8?B?OEJYR0RYNTN1Uy9OSjBrTHRBVkNtWGhCSnRHL2IyTGE3NU40ckFpK0dIWmF2?=
 =?utf-8?B?eHRMTlQ5RVVnbUNpcDd2TWx3eDcyRVV6NGxnM0tyd0RDWGRkODlmR2pVZ1RJ?=
 =?utf-8?B?ZllyU3ppbUNrZFVQbmNkTmZKRkNybXBqUDJvQ0tSVC8xOGZ2aWk3Mi83Z0lv?=
 =?utf-8?B?b1pvUUltdllFbXpzTnZwY1FDaFJiYkZPYmdmMnVGYmRFVEljUVZlWEZMSEdT?=
 =?utf-8?B?Y3E0Wm9iblJ2ZXE3VjRLUU44RDlOWklNdjF4NWFrdHgvdWpKdCt1SFU0Mzd2?=
 =?utf-8?B?ZHVzN21TRzFUNTBpU2t1S2tWWnR0V0hTNzh0TlQ4VFVmRjJPbGVWQVJaOVlD?=
 =?utf-8?B?akI4VGxwR1ArQklXMXpNOFA3SXA2MUNSeHZuRE9URzBKSjNmVVAreDgzU1ds?=
 =?utf-8?B?d2FHbnR2dzFhTkozU2hLaXdHR2pxU0hqUTRyQ0RsWjNIWHVMdkNiQlhuZnA4?=
 =?utf-8?B?c0hoSkVMWXQ1Q1JOaFNxZHBaTi9PMk5YVXhtSTltbEZPSk00dmJJdkk3M0ZE?=
 =?utf-8?B?QjUzZk4rVWtNdkY0dVJuQTBWVzJ5WllLZWtTYytKWFlrOGFheUxyQlVDbFV2?=
 =?utf-8?B?Q1ovOTV1bUJYM1dnNXk3QTJuOGwrT2wxaGs2blJ4aFlWK3BaK0QzZXZDc0Qv?=
 =?utf-8?B?czhEZlFpdnRzRUpiVDhhSmVoTnJReDBTR1F4WFlrWm1MTWVzSm11aU9BeGVv?=
 =?utf-8?B?UmdkMHp3ZGRTdktFQzJsRVEya3VERWd0anAveGNWc2M0RlN3R29XaWYwZUps?=
 =?utf-8?B?dE92MVE5NHkyTXdxNXI1V3dnZUw3cGVEVDRhdisrLzdnYXB0T2xEekFUYkFh?=
 =?utf-8?B?Q2orNUNlWS8vUWdBV1VFSzVqWklBM05yZ3BKK3Z5VTA4ZmJsTk5CYzNFbEFS?=
 =?utf-8?B?dExQUEwvRHcxdVF5TEI3RnAyNHZVdWY4SE5ERENRMlhMcVQybjQ3OTRGY2Zq?=
 =?utf-8?B?UUt1VFU0c0JDcXJITjhXNCtuOWRCVStVYlFGSEJQWHVyQlp5T3ZaN1hWUlJt?=
 =?utf-8?B?TklLRDBnYjVQcHJ2OE5oVDJ3aVdGMDVCREtDSUVZWVFMaDM3eEpHSGJQTDBF?=
 =?utf-8?B?WitZZERLS3A5aG95dXhoUXlFSWd3MXEwVnRIbmVvYnpVU05BQnFaRTNOL203?=
 =?utf-8?B?U3RWc1ErMXNKd25tZEFFcDR3SzY0T2hhRTJSZis5ZUEreW1zOVB4c2RNN0ww?=
 =?utf-8?B?dFA5TE1oSTl0bXEzd2Rzb3EvM1l3TWVyWEhjNjFQdXA0blREUGFqQm0wWi96?=
 =?utf-8?B?eUkrdzZhdk16ZE5US3E5Ukw5N1p0NUYyYWVqR01YWFZ2K0k5eFpPT0NjYysx?=
 =?utf-8?B?Y1JTYmR5ZDFqOXViQWI2d0hlMmRibHZBVzR0WS9TZnBRRm9ZWE9IZ0Z1UXpt?=
 =?utf-8?B?clFwak1oUktHZUsyMlZQM1NYSzFWZDFCamxGYm1VL25VUXdUN3c4V0tneUNj?=
 =?utf-8?Q?MiGHIZ84Y4FzlMCgdzt/zlWgh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a239c9c-8926-47d4-c093-08daba0eabe6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2022 00:35:40.5181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qo7YQaIiZzXxH/E8Ib0EJP1MEF9qwIcjeWbtVd1JNdXtjZGQO7i1/G1HBguRyW4rMGe6Fi7csXV6VZuXo4yTvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4580
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/28/2022 11:31 AM, Christoph Hellwig wrote:
> On Tue, Oct 25, 2022 at 05:09:21PM -0600, Keith Busch wrote:
>> As far as naming them goes, if the only usage is its definition, then
>> what's the point? If there's a use for a named enum somewhere else, then
>> yah, that improves readability.
> I think it is nice bit of documentation.  E.g. if the enum is for the
> bits or value in a nvme filed naming it after that field can be handy.

I also preferred my V1 with more documentation but was asked to remove it:

+/*
+ * Reservation Type Encoding
+ */
+enum {
+       NVME_PR_WRITE_EXCLUSIVE = 1, /* Write Exclusive Reservation */
+       NVME_PR_EXCLUSIVE_ACCESS = 2, /* Exclusive Access Reservation */
+       NVME_PR_WRITE_EXCLUSIVE_REG_ONLY = 3, /* Write Exclusive - 
Registrants Only Reservation */
+       NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY = 4, /* Exclusive Access - 
Registrants Only Reservation */
+       NVME_PR_WRITE_EXCLUSIVE_ALL_REGS = 5, /* Write Exclusive - All 
Registrants Reservation */
+       NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS = 6, /* Exclusive Access - All 
Registrants Reservation */
+};

regarding the naming of the enum I tend to agree that this is not a must 
here since this is currently the style of this header and since we use 
only its internal definitions.

So I'm ok we both v1 and v2.

We can do some work to improve the confusing enums in nvme.h but we need 
to agree on the strategy before we go implement.

