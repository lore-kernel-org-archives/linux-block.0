Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CDBEB64D7
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 09:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjF1JYS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 05:24:18 -0400
Received: from mail-bn1nam02on2078.outbound.protection.outlook.com ([40.107.212.78]:54530
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233401AbjF1JWH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 05:22:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXbaExzfv+yWiZCToDWmDU80OkXQVujtQdVg66s6MUxLYFgLKvEe+yLKmvacWM5Oak9hdpKCHK7I4ym62Ps9td8ySV2ki/OLljj+MNf+j5hFW0Ege9i94IgNl26iympdLT5fMIOubNVhhVHTiIH6oyXeJaBXs8PsVyoSIms9ui3hL8/1kbFheJUo5ClnydL+1TpJMJ/fcNx9wakg1s3n9R8+VpffwOxOwGsFXnZLw2vbSAVrttVTIoPj+681BPg0eN8PcOXgl+x4RzEAV+photm7qW4Rpkcmn10AtsUoDdGeOUivKztYIT5eJ5pf2GB/cgXeIa3xlvQpIHG2rvlTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kchWhN9DCbW5RhUrBJeS8J/R3u0Qz2k+r2o1FO+Ke4k=;
 b=nUzPiOOwjcEZsKm6Ew7GYhAY8Ky9w3XWzkQIIzNeIQaI9tR8JXNaVw/g8X2njEhPFKAPzrcZi6td1Bj3U/B/u/XOMpavl1F2Q9ALmVeG9G4F2fglq5yEOuO4a9ZxqHsMw2yDTZW6goUtds/voqeOumFC1cVpEp6961aAH28mUNieGK3+2P2tBMyxocQQORi2tjneW6rWnRZmoPaThDn4zRsJUF3ty9yWH9AxuAwji3hZNaUVU5d3SJIz/nBjgPHuIpQbrT5CVxD68l/v6Urai1vprN5UJZNF/p3s4uxz7hqXIKBxjFnpcvJ4Gtc4WjkqBsUm2MMDf7jLUkfRaX5EfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kchWhN9DCbW5RhUrBJeS8J/R3u0Qz2k+r2o1FO+Ke4k=;
 b=pAmJZwKzjCeza0Vay6GJgraon+Q7sqPYiA3mNMiXUTYiiOCOvU/w5e+j8Ks6QEVUcuT/ACBumyFjmjHJODlgYRC6lE9E6rdFInaMc79gk9LKsuXrSa5lfMUq/3LIzewDxI9zKHPUStjvgXEspUufcpyy8WCVoFqucNEhr52dkP9pgZSIE/JfPQsPH2k79yj4FcmnZwQP/FqL6EkbuZAoQhrRsSe0qL0RaiIfMkv3okTkKHcXNpOK6zfc3xsKUDeyb+L/Awk6JxfvFMRcx0AEbKHc/VMy3Xovp6FCSpO9Qj8hQBbNxnaQQyfdDb+xx0twWkzMNIH+dv03r9P6avpM1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS7PR12MB9042.namprd12.prod.outlook.com (2603:10b6:8:ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 09:22:04 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 09:22:04 +0000
Message-ID: <d5d9bd87-1d5b-d66c-39c4-e35c0e5ddc48@nvidia.com>
Date:   Wed, 28 Jun 2023 12:21:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
References: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
 <4b8c1d77-b434-5970-fb1f-8a4059966095@grimberg.me>
 <8a15d10e-f94b-54b7-b080-1887d9c0bdac@nvidia.com>
 <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com>
 <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com>
 <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
 <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
 <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
 <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me>
 <83ef44fb-fcef-4b61-9de1-bc24e3c0f4d2@nvidia.com>
 <000e3d0c-0022-c199-1f8d-97e191345197@grimberg.me>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <000e3d0c-0022-c199-1f8d-97e191345197@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::14) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DS7PR12MB9042:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d210e02-6a87-4a63-57f6-08db77b92312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o1rzizo/9aV9AqJsyE3YVlJX0LFkGQv90KTcVF6rVWljddlgdsYYNlaV4AegTN5tShMxQmsgkcaymJik9Zta2E1NjJUtwNKgB55lzAbErrF8nOq6MG7a0H8i+J9O1qvAwF83Kc9QfAin5E/EpQ8OWFWV8xC/PT0ufFtwesEURMPNfDdVQsNllXJYvgmfLKxe1CVqFFTR0Q+V1wKzyAaNhfOvmehAuI5ZPG4eBO7IgDRjvXKhMstI+c58uT2a3Rjy6pn1Hb//w3p31H6q1/pAEGjN7vqdHYLOE3G3byhbYsff7aBKSqMdZN5rndFUb11kbEY/OEglKPqESbeH02e91pc7XEE33OBxXKLGqQOILm1qSyTts8EVQgMMbbQDtLW8znupMk/XWqEqnXI/QzBHEp9a9OBO6he9bR5gAQgFojqQQaCwV71yPEWOZA2h3SpgNamDkomtbCOg+OknvpNycQKT99HdZyWarkt964FT7ALG7wX/V+bz9e/mQmi10onmkCCWqAENyeudH9z428wXVAFb5n7G1/Yw5llm3aUIA++aNMayahbphOSGl6r25wObf2Ho1x6NE54gJ4gBZEVvmCJsVPSrIUMVUBpXCZwDDVSurNzZsURjgCNrdlB9GwiuDMTigeKcmFYFTKCPzTnx+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(478600001)(110136005)(54906003)(31696002)(86362001)(41300700001)(66476007)(66946007)(4326008)(66556008)(4744005)(2906002)(36756003)(316002)(6486002)(5660300002)(6512007)(53546011)(6506007)(26005)(186003)(2616005)(31686004)(83380400001)(6666004)(8936002)(8676002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWtybDY5bHg2VTZrZzRGZ29NQ2poNE9kQ3Fza0dKbk5kbVd2L3ZFVTNucjd5?=
 =?utf-8?B?RUdhR1QwaHdtSEJBWjRxYmk3bWl3M3kxS21iL251bmVsbjVGeW5TSVJQZDdW?=
 =?utf-8?B?d25XYlFoZldxUGo4dVNNTSt3ZTdaL1A1L1NTL1AyaEtRNWpuM0lqdTZ6Yzhu?=
 =?utf-8?B?ZDZhNFJxL3NMREhSc0JDVSs1YjNVREZGM21wYzAyUHJUUW5NY3RncEsvSUJp?=
 =?utf-8?B?ZXNEOFVmT25KWUNFYURFSytCanNBbVpGTXhzb1F4Ym14bVVuM0VPcURSYUN1?=
 =?utf-8?B?dUZ0cVBQcUV2U2xtQTlYTVo1ZVRQcWg0MUxvUmFEQ3ZkUkt3T21yaUxYVStB?=
 =?utf-8?B?RWJlNGZRT25EOGM4eHZJYUUxUSs0LzE2UVJCRFYxdGsyR1hQVW12Mjd6bDNB?=
 =?utf-8?B?RUZIRzBWN05kbU9CU2NadFFaU2IrQzJRL1lhaDY0eFB1U1R2ZFlzMU5aUTBp?=
 =?utf-8?B?MFQ5bStFZjF6Z3o3KzZ6NnJoSVZNc0xwZFVIby92dTY0QXBpTWZvaW5TM3Z2?=
 =?utf-8?B?ZS9wQkZXL3FKcVBDYnA1Zk5rckt5QzNXOE41UlNoVUYvT2tHbmhmak5QVWQz?=
 =?utf-8?B?OGVzT1NkOTducDBETGNpRWkxVnR0S2lhdUt5dHByY2FjKzRyVk43WVRiYy9p?=
 =?utf-8?B?bWJyaVZpR3ZvWDBzYjFtVHdoUkpWSjNCS3o0QUpjb1Z5bElBWHFFZzh4Unla?=
 =?utf-8?B?eFdwYmdac1g5NlJSTC9aZGZKQ2NUYy9UY2p5ZWpvQU5RVlJaUUVRc3IrRC9O?=
 =?utf-8?B?aXh0OVlQdTJtWURqZEJrbmVWMk85Y0xpYkh2bVFLVklBaXpQaVU2UmR0KzdV?=
 =?utf-8?B?S0xjMGhPY2V2V3VHSU5CY3BGSTBrS2taVFNiZmU3ZGQ2Z2kxMDRwd0EzU2V1?=
 =?utf-8?B?b2N4TEtTa05ESHc1RDYveUxZSDNTMGMxZi83N2JCSG1uTWFQTlpwMDUwS1hm?=
 =?utf-8?B?TVZITzFxUGpYelhzRkZXTmthVXgzYmtEbnk2ZFBUTkRZWUk4dnpNTHo2VnVw?=
 =?utf-8?B?RWsydjVmNWJyOGVCclJJeUU3TTl0dEROb3V5ZzZsNTZCYlUxVjNrY0oxTmtW?=
 =?utf-8?B?SSsxUXFNMGdhOU1DRUozdDd6V2xmZkpBbzBGY1JpYk5YRzVNK2Z1UjltaUdu?=
 =?utf-8?B?S2xaMS9iMGlPQmVPMWFVWmlFQXFqRHY3ZStpYWR1VWJtU3FhU1pwM0NEMmF2?=
 =?utf-8?B?eTFNUUp2SnlNMVpDTHA3K0ppSmtvSlgzSWsvenB6NHhoRzVqWU1teHFRYVU2?=
 =?utf-8?B?cmsxM1dNbUFiNmZTOG9BSDJDRzZuS25TTmlrVjZ0dzdUUVJHaHNNcHhoNVJo?=
 =?utf-8?B?M0YvaWNhUVc0Q2pldU53YXJoV0NWK0haSlI2eHVkK3lXcS9PS1grSUxOaVpK?=
 =?utf-8?B?REh1bi9vekJ4UkVaNytBQkFJNzluZVBpSXgxa0hCRW5ORnRsUUpDYno5aXlL?=
 =?utf-8?B?bzQ3WmtNYkJTNDRsTmdQK2J1VGhVVDRCR3pvZXNKQ0VDeldaWWZoVlJ2QmQr?=
 =?utf-8?B?MDliZ1ZYTUdKVUFuUjZJdzNTeUFRa3ZmTGxoT0kwMCtsTHdGS2g0TUxyKy81?=
 =?utf-8?B?YmsrbHZIYWxwVEZFd3JTOGp6SXdGYmUvc0QrVXU5SmVoYUh5bm9Dd1dWQ2px?=
 =?utf-8?B?WmhzVm1oTC9pYzRPdEhqUjBqcmlZSE1xbE5NWlFyYlZRZ2lzK0V4SWZDd2ZV?=
 =?utf-8?B?NzNjNlhIVkZNQnJQZFJOaGMwNE1CVDdtOWl3NkJrSGdnaHVSck55dmJxWCtE?=
 =?utf-8?B?bWtVQWV0eEZPL1ZDS29ma0RzVTZUWElETU84SzFaOW9jQXpxdnFqNC9MNlJR?=
 =?utf-8?B?RnQwNnNYaTFBSVY1NEJvdC9La3duTGFDeDJ3dXpCb3A3bWJVbVd5UGw1RDc0?=
 =?utf-8?B?YlBxKy9MVmNYUUNVeVVPQjQ1QWw0NmRxZ2h0TFQyUUhPb2VnS3N5cVFjN3BO?=
 =?utf-8?B?U1M0bTVROHpaUlRCZmZrRjN3UlFGZHdtTHVjbjJ2aGtvR2tsMmJmQWlOQnNm?=
 =?utf-8?B?c1QwQlhGMERjMmhmcWhRa1lVWmpYNUhpZ1I3aXdiRnlic25wOFhTQVU0OVZu?=
 =?utf-8?B?SUZFSEJvU2ltNEQvMDJGOE9JbDRGSzY1ZDE0ZHdDMHlhU05WV1drUGowNGdQ?=
 =?utf-8?B?R1VwbXF1dGttaDZueitCMjBldlEvTVhrdFZNOUhqVFpGYkJXZks5NjJUVUtH?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d210e02-6a87-4a63-57f6-08db77b92312
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 09:22:04.6858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/sq5XY1DLyNGxCcSAU8CzOvvWR5c79zJDLh9TCnIhrJbgFgMfAebOONGIOonMGmsbDP9yrH7Y8bCa71FY1Cyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9042
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 28/06/2023 11:14, Sagi Grimberg wrote:
> 
>>>
>>>>> Yi,
>>>>>
>>>>> Do you have hostnqn and hostid files in your /etc/nvme directory?
>>>>>
>>>>
>>>> No, only one discovery.conf there.
>>>>
>>>> # ls /etc/nvme/
>>>> discovery.conf
>>>
>>> So the hostid is generated every time if it is not passed.
>>> We should probably revert the patch and add it back when
>>> blktests are passing.
>>
>> Seems like the patch is doing exactly what it should do - fix wrong 
>> behavior of users that override hostid.
>> Can we fix the tests instead ?
> 
> Right, I got confused between a provided host and the default host...
> 
> I think we need to add check that /etc/nvme/[hostnqn,hostid] exist
> in the test cases.

Right.
And if one of the files doesn't exist, generate the value.

Should it go to tests/nvme/rc ?
