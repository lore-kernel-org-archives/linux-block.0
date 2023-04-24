Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B593C77B61
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 09:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjDXJRp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 05:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjDXJRo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 05:17:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C4110E5
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 02:17:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQA12L6w02vk8sD/GyV8fbFZxunJFkmSU5CHW/arY2+AjptgYo7I7KCaJqGT046KKd2ij+nZCMXbEEcOnDP8zrbrlfjKRfFpxdvqy5+f4vVYPXOHdKcvM1kI2n7mjvoAU1OcJKY8o1oXd0Uh2OAiyylAPlMtbiN/FDut+mZbpcTsAozZBj+/V8RWKeDJJcAEA+j4VVxdeXpFheX5dekvE3pgkvadaHSESkT5ztfpjz8u7+6bPswVcturNNMoxi0k0UUUt6H0I1bV7BzVedGw6xO0ImD7V4n8kEh0CkCyCiywoyHPSLqma6qyd8AfEL7iQwzvxmL2or/yMqjE5p6MGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ijw3juk4YmBbaxblSKDIyd9EK10D+kcIJZQrcAd9NA=;
 b=ItJWvU5jkZlwIOsppt+74v0kpGcDcWwUdFWjsxj247bEM7wrtakKqtmOMYFzRPZdhK5sI3oRXFLZt1kRSP2hMt7LAuxV52L8J4u0iVnjeGV3C6faSr1S20kDKo93v/m/cWLQ3Om7FXsyc5rKk2EM+n3iEW0Li7jEuiWmJOXM5yh7aCRcLguk6ih0DIcODWLSxGyTupUGD7d3cnPqW2tfMGJR05dO9K3fMz9SjHlrEUlfvE0rT0fwrCrzAD0ZBMBwSgHgBdM6BFuxqZRF8xhYFjH6VJL7iRudKlb1aYhHwRDoDydQJi3ey6mTlAUgoG+BbPaghC2WjOXMYgVKG6j9jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ijw3juk4YmBbaxblSKDIyd9EK10D+kcIJZQrcAd9NA=;
 b=AgoGaG4GS+SEkF/ewQgMJID9vvH9iEeULVpC/m+i0yBjPai7U4TGBhyZnun1DKIzAUK/Bvjm/JM67P53+eHD+azXLn+LQtCdWLYM6jWPThLRGyWKSE8C72g2HicoI3WUyPrw/M6FvEo0DLIfflvhxEkfzT+NQF++cXJhlTMZEiQuRLl2Bkxr/N1Jwbvi1uewHPpEOucgzyuTz9njpZX9VCOQckgM6sMq9r4qm0VcRLS6f0KbkEsPxWDkThDFH5Pg8IzjL0nwbLC28x1sWvs/kieATnnPoKkRzX7eC4sY52/KZA4o3eyQ5ISFSXnCnvwdo8hfEv67tu1hmyijSTeQEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Mon, 24 Apr
 2023 09:17:40 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%3]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 09:17:40 +0000
Message-ID: <729e6964-78b6-cdf2-b7e9-0ea5562a10e2@nvidia.com>
Date:   Mon, 24 Apr 2023 12:17:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 0/2] Fix failover to non integrity NVMe path
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>
Cc:     martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org,
        oren@nvidia.com, oevron@nvidia.com, israelr@nvidia.com
References: <20230423141330.40437-1-mgurtovoy@nvidia.com>
 <20230424051144.GA9288@lst.de> <5b7ca121-2b85-ddd0-d94b-1739cc5dcbec@suse.de>
 <20230424062040.GA10281@lst.de>
 <9b3da2c2-b158-ff4a-e7e3-62e49f366ac2@grimberg.me>
Content-Language: en-US
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <9b3da2c2-b158-ff4a-e7e3-62e49f366ac2@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MRXP264CA0037.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::25) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: e23ee406-7ef3-46f2-10b8-08db44a4c098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z73/bdcCueiPCuqiH5bW0fypeBC3yU+7piQs2qTsY5q01uZGULeMerpgAQ7OqDXoptnt2tdpU4Jkka65S5NdcwM/oJwVbXwX26rPRW4oney8bqFis1zL00Is8bGgo0MkPtam2lpJ/2h7wnL5jx3wN6tG4JBNqWC0djzvBiTB4T9dBeiBdzS1OBS2SsdoDZmjTPvowKkNSZQDWVsbxpoPaoxxnPzyofXIXPXctAftzy+mGKCa2a3yy6MlzTXvTN5AB4QCjnZx85uF+zQoOY4UyKFTiuBzb6pxBvMUO6fycQDH6JSiM2f3wq3IxCu5PT0NJBWf7CCsljspP0Fnu9tj5AJEOUmWjhR8CaTlEcyidbwCwLqXqRTGhPpgTb1lklNVXb7tPjs3/D4eEBnylHWraqsuvppz/DYPwPhVdRx7AZZoq1hzskKw2qWyILD7lhgtVN+kOKlTnZfsXxhvXVWg+83lyx4DTuuOf4MrryzklVfp5BNWN7U1VJzTp+BzTkPaRLPbj/NRnw1al9PSs45nL/2VleQ2j30mw++/5Cn/HXzuye2qFZH/KbWx9Z2XFpMi6B2Crx/Snp2j2lIQbsZcJe5cipVMD8JjsKDumuODbBDQ/Nvm9WSMYCIoyF0x1KTTvHkk/GBfbayBdWVJe8YT1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199021)(31686004)(66556008)(66946007)(8676002)(5660300002)(66476007)(6506007)(478600001)(86362001)(41300700001)(4326008)(8936002)(6486002)(66899021)(53546011)(316002)(6512007)(31696002)(110136005)(6666004)(107886003)(186003)(2616005)(2906002)(36756003)(83380400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXFJdkVLTEZnK0Fiak1kTUdweVB4UEZwb3lpVlc4SnlxYi9hZ2szSk5yV29i?=
 =?utf-8?B?RExQRk9WMFg3OHBOdmRtaHI2N0RJajlFUHpsNVgxS0VVOVRlZUttZ0xsdHBP?=
 =?utf-8?B?SVdwRjM4STIrSWVoTkhnNWJ3bjlQNVhLejd1QUZFRmYyNC95MGxCNnY1UG05?=
 =?utf-8?B?bW9BaG5YZ2J0UXR4K1JYMGU0ZE9IWGJoNTYrTUdYVXR4QU9GRmJRdXJENjFq?=
 =?utf-8?B?TEJYNllya3ZqQUtnRk5mU3E2cS9MUWoxYm1IQTVzUkhGaGxWWStsR0MvcHN5?=
 =?utf-8?B?WlVNSTFhdUhKOWpnMkFxc3FMcDdFUlFRSkxBd0w2TW9xU0p2UjdnNDRSSmdB?=
 =?utf-8?B?ZmhiMm4yTXhhaGZ2L2doOGk1aWhLNjlmR00zS0pHVTBGK2tzdHFTYlpOUTAx?=
 =?utf-8?B?OU91bGxKSTdVV1ZmMDRTd1YzVTQzWUY3cnVzWFY5NEhYZkJvUWMwQjArbkdQ?=
 =?utf-8?B?T0xHdzk0RFQvdXp0S0MwaXFEekNZTGEwbU9QcHlScTdPckMwOGZEUjFURU45?=
 =?utf-8?B?RGpZbHpPMGdvU3kzblJQRGtXVXRrVXdGRXg1THhQU3ExQ2g1Yk9tQ0FJSWZI?=
 =?utf-8?B?TVBsVTdxNStPQUJKQkt3bkQwdWpMR0dhRWlDTHVKYWJrUFoyTXRsM2Q0eWhp?=
 =?utf-8?B?b1QzMUUzY0lwVzQrSm80VGUwUS9hSFA4TWtzOWNHZWRBdmc3TjdObzdnUk8r?=
 =?utf-8?B?TXhHODJlS2djc0U1N1NMSEVlUUpVNUtZRHZUNUJYd25aS2ZKK3RNeWNCa2Qr?=
 =?utf-8?B?NXlRUFlpck5FeGlTTEJjN1NPbm9reiszMSsydXpUUlhBRE5xbDg1Q1ZEdWdj?=
 =?utf-8?B?MWVhVkk4RkRKWDdLcFVyNHErcHl6Y2hjMWU1NDZYNHZ6ekhUL3RSQjIyOXQw?=
 =?utf-8?B?cTU3bUNQQUZXWWJOaWNwdTVoTzBia1JvejVwdWdCZDByVjd5YjJHYTg3Q2R5?=
 =?utf-8?B?bFZaSVd2SklPMDF0R3ArQ3NhRmxiazhrVUFFZUxlU2tmVXhJaHdzQ0pnU2dZ?=
 =?utf-8?B?SE4zcEJxT2NlckFJUlQvZTNRQ0pUd3JjMldDRWpXMFY2NFpzMS9DMW94WThX?=
 =?utf-8?B?R3dzRFZTNUxnd2hPZitVSFVYaXNGUXJKMkdoeTA3b3psUkkzMzJrREhBMFdS?=
 =?utf-8?B?N3lvbGhpdy9EU0x4N1M2Qk9MNCtOVHcxWFQ2Mi9JUDdmYk94K3FFRXJLemFi?=
 =?utf-8?B?ZHlPMXRDZ3MvMU84RHNPd2ZtV3Z1T2NXUlVFN01zSTVCaXlua21EZXUvUTd3?=
 =?utf-8?B?a2Jpc1IyMnphS3pvUExYYVhFTk5WeVJrWitGdndCby8vU1lVMXBvZ1RRcjhZ?=
 =?utf-8?B?WkIvY1RscXU1NFZGN1YxMDVIYlREdmtybnd6RUYwSUdKcGozaEp4MmpyRnRX?=
 =?utf-8?B?d25KZzZPLzZwZU1vb0tXbkZESllodFRid1h5Q290R0hvL2tsUjBFb2VPd3J6?=
 =?utf-8?B?NW5xMjhsYjN4MWlxOG42NmlYaTMvLzZlcTJ2VGNEeW8rT1pHbnJCMTVKQ2Fv?=
 =?utf-8?B?dWE0SjJwa3Z3Ui9HOHBKQXVRb05JbGNmK2ppTGM2a1ppUkRoZ2d1UXhlK3Jr?=
 =?utf-8?B?WlR3ZzQyYkZMUDFHV1FCTlo4YXBTWlFENm92WGJWSzM0M3A2Q3krdjFTMkNk?=
 =?utf-8?B?VkZ6VE5aT1dSZlNPSU41cjVQbDBtb3dVOXpNSTBydkRPRUxFeGkzZFVzamwr?=
 =?utf-8?B?bDE0cVZJWkJmTDdnUG14VlNFZ2NSYjBnbDYwYm1Sdm9BVi9pcklDaHhCcDhh?=
 =?utf-8?B?ZmVKeDYrdlhGbVZNVUw3T2srcXFmNWtLOGdVRWx5bDdrU0ZoWXB5WXltVnh4?=
 =?utf-8?B?T1N3czY4VEpEem9nWU9uQllqbkNGWll1VEdTa3JFaVFjZ1h5bnMzODRERWlU?=
 =?utf-8?B?UGNLMVd1eGsxV0xzdVhhRHhaMjQ1TGFRSnVFV2oxTGxTUFduRFdSaXFVcnR3?=
 =?utf-8?B?aDl2SVc0VUpQcEdaMlVNcHZYNWViUzZTWCtNa0NPdDVTZnJkcE1KVXZqU1Yy?=
 =?utf-8?B?MWc5OUpRYXVqYktTUXI2aWVpQ09ZQW1xd2Yrbm81dEFSa093Snk4ZTc1SE9I?=
 =?utf-8?B?ZjcxK2wzaU93TnBrWG5iSkZNN1R6aStDNHgzelh2cC9CZ3J1aXZoRStGcFpq?=
 =?utf-8?B?dm5TQzR0dURnN0xJSk44SklzN1pUWFlBT2pGZFhNaE1NYlhnT3ZFTUxESTFx?=
 =?utf-8?Q?eh3ciJBuNy1gWAF02LMe3fXqCQMu+l2OPPynPk93+ASA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23ee406-7ef3-46f2-10b8-08db44a4c098
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 09:17:40.2029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /re+agv8IqDtt4sYHKX9Z7dNdY05LcCYYaplDEJKa+YXJ3lXEZ4TalLb0QKC5D2l7lL0gmtuWwGHZ4JnGC8krw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 24/04/2023 11:53, Sagi Grimberg wrote:
> 
>>> Yeah, I'm slightly unhappy with this whole setup.
>>> If we were just doing DIF I guess the setup could work, but then we 
>>> have to
>>> disable DIX (as we cannot support integrity data on the non-PI path).
>>> But we would need an additional patch to disable DIX functionality in 
>>> those
>>> cases.
>>
>> NVMeoF only supports inline integrity data, the remapping from out of
>> line integrity data is always done by the HCA for NVMe over RDMA,
>> and integrity data is not supported without that.
>>
>> Because of that I can't see how we could sensibly support one path with
>> integrity offload and one without.  And yes, it might make sense to
>> offer a way to explicitly disable integrity support to allow forming such
>> a multipath setup.
> 
> I agree. I didn't read through the change log well enough, I thought
> that one path is DIF and the other is DIX.
> 
> I agree that we should not permit such a configuration.

I'm not yet convinced why not to permit it.
The spec allows this to happen and I can think about scenarios that 
users will want this kind of configuration.

We also support it today (with the exception on this bug).
There is a special PRACT bit in the spec that asks the controller to 
take action upon each R/W IO request.

The Multipath is not related to md IMO. One path can generate/verify md 
and other can raise PRACT bit.

You can also create 2 paths from different hosts to same target and one 
will have ConnectX-5 and other ConnectX-3. The fact that these path are 
from the same host is not so important IMO.

