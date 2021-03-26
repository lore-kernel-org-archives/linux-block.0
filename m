Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D055C433C1
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 13:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471AB619F9
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 13:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCZNBl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Mar 2021 09:01:41 -0400
Received: from mail-co1nam11on2075.outbound.protection.outlook.com ([40.107.220.75]:52736
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229908AbhCZNBW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Mar 2021 09:01:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHRTVWewyP618ehpfqgTlx4wR34XyHKRrLoqtQa+tcQQZfuEDFDx9t8OMk9O2wuTi9eB9ITqF+vMkgo9LpiiUcSHLDLXDhzjd6FfD1Fuv8Vrk32rEDclhe0OTU+WsRyF+6h8eGsOv4KwxNnjODLeopqGenRFfJlJ2JBhS0o18pxVsKVqGclZmCi9/PRFx5/VUBSqiwKbJ0aP//vu2kj3poV/h5QoMR2ADMAr74Mwem5W73yi6TRxUPQnChNDSSfQyFxsMwWNK6BAERmsO2jHuHxgB9X2E6KDH6wWGznRjhSGt2xZAGPMoz+zENJlPU+VLjOhO3gUJWWhKkh90SkzpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwEGeKiMZTWwgm6VRn1xyEMJulvC/ZMU2u3U8Pi77LM=;
 b=DBCoqsJtHqjtIwXKS302XLje40KY+rBtIcQTG/zb2k1R1CanxU4/KhZbudhvyL/khK6m4LINIX6TLTVTOHW3rZVMR4d5DnXEUX39AS6jU0O+2OzcccKyUuLW18PHX5j60tDpS5qnohJMqr9WmVMGM1ctmPJ6f/nZVSBlYQrYL5VBxvYRohcr97uyt8MwrqdLTbnIUrbj0Rluc30ZqTv/9x+bcVTFILt2pAKUDhgMaYL0BP+ek0/tQ4PDWJnUo5ENOCF/LsH4RO8Pydxk0BQlteTSrvfjH8bc2uBKoSvOdyL/kuXvV35LDw66Vuvei6P/49gYSirZw/ioOtPFKHbQdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwEGeKiMZTWwgm6VRn1xyEMJulvC/ZMU2u3U8Pi77LM=;
 b=evOkxau2Oyc6u8szUtn3ABFDligKwZmisFFG7PXgvu4tylrh90ob2Zimqr3mBqPiR3Ywtc+7Ce+CQ/sd6ObJVHOysfnpjiqkDowRMXx5fzC5miYcjL+ypSoqvbl9K7aIHw4WNskQU0husePRuF4W8uuFWTHrF+ei65j6hGJB7uY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3478.namprd11.prod.outlook.com (2603:10b6:a03:7b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 26 Mar
 2021 13:01:19 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.3977.025; Fri, 26 Mar 2021
 13:01:19 +0000
Subject: Re: [PATCH] block: export disk_part_iter_* helpers
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210326121059.597172-1-yanfei.xu@windriver.com>
 <20210326121359.GA14989@lst.de>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <36934d10-bfb2-032e-813b-a514ee524853@windriver.com>
Date:   Fri, 26 Mar 2021 21:01:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210326121359.GA14989@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:203:b0::24) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK0PR03CA0108.apcprd03.prod.outlook.com (2603:1096:203:b0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Fri, 26 Mar 2021 13:01:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d2a566b-608d-4e8a-c7a2-08d8f0573f7f
X-MS-TrafficTypeDiagnostic: BYAPR11MB3478:
X-Microsoft-Antispam-PRVS: <BYAPR11MB34785863DD3F6D8F435DAA49E4619@BYAPR11MB3478.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iOmaR5Lx4/qPaSLEyH6F8FGjdzXJz7FyG660Ok1/gCBfBW5Rfuce9zqb6EsmsKLdhuw2eosWq+cGG3T2rcJSYGLPCbQh2f24/qkT8Q2xb8k5G54VyqSFQT84rjvEPqv12z4g/SSfl6ID+3uZCEhhuDNOsMAgTkhQqqrd0TRnZnzY9v9+GtjfvXBqzsToKWsbfRBBz+UhyPJN21ti3d0VOtgHJL9+AQIU+dLV/TLR7s/YAudqxiEtpRygmyVcIV2z9B82uRcGp4DjmUWRC8GcvbZkYUof1/z7B5DhUhEVpO/67VY5TXa4MDAC69Fa0M2ElnQ4eR7J18JIXXy50zuVzuS/m+jvziBwfwmKpyh9RD2k4dMuXNC/V3AbxIW3GGQhI/2xbCYG90MeoNJ/WcWpbEaIMB7Lw/4KP2rXa5gamz7/7kK5Kj/udXvAXDZrpATEm/8l4lIsNJccu+cAekbRgh6FUZCDmvH8XIFEqDIyJq4NeqTcnIEtJ2fanVgMZbAbiAvpZdhgJzBmJZNWirErMf71zqUJYftaIDC6L3YHM7ORAzEwLNKcIwM3JULTidW407nELSkHy/iVwk0vDtIwx3Js//6le+IQI8mjNPzV3M4mzfIjftWqNIVf3MNJ0RhiWovtg7eZ8J+oEqVfFYZANR9/dOs180Yuza1TIgeE52d7fGpeWsGjq1Wtjinbh5HZICrYhIB2y9prFm29UBHjw/ayorLIAMW/gSH5xFUvTR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(366004)(346002)(136003)(396003)(5660300002)(52116002)(316002)(86362001)(83380400001)(6486002)(4744005)(8936002)(36756003)(8676002)(16576012)(31696002)(38100700001)(6706004)(16526019)(4326008)(31686004)(6916009)(186003)(2616005)(66556008)(478600001)(2906002)(6666004)(66476007)(53546011)(956004)(26005)(66946007)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?elJzNDZ5N2pxMCtsRXdTUjZ1RkhsV3RrQkIwdUQxdThyY1hnRDUrK2V0QnVK?=
 =?utf-8?B?d2FFM2wrU24rQnZTK1BnakhVY1dUcDIxaWIrejlHREFWdnRuMS9QVC9hLzVS?=
 =?utf-8?B?Z2VWNTZVbWNTK1NrNS9XVVNndnMvY1pGeVgycXNmdE1xcko2QytJVHJUVFQ4?=
 =?utf-8?B?UFNGN0lmcCthOFlOcU1CMXlzdHZyWFE5R0N5MmdNZERhQWRvV0RMeVFKbjJy?=
 =?utf-8?B?a3AxMjhkME5ZeENJOG00K3VrWTFxR3ExRGNYZmZsdGlUazVwNzBhWEliek5a?=
 =?utf-8?B?a0NpaWtkQTNiZzYxMTRKRGg4VlJuTVFlTVdycHhpSGFINVQ4VFVySk9hZ0Rs?=
 =?utf-8?B?d2p2NWxkamhabUlHemRZaXd2T2ZIaW8vcFZuYnBJZEFJUUlCaXEycyt1NWpa?=
 =?utf-8?B?US9VaU9neCs5cnIyN3RLZ0lYT3RMMmxGWVpqOEFiYUtPc0w3UHRRcnJEV1lY?=
 =?utf-8?B?WHUwUXBaUWw5VUY4ZTdFeDh0U0RJVTExUVd4OTBOY01CSTlVdzRoT1JtSUZM?=
 =?utf-8?B?QTdoWUlBU0VUK3B0WWR1a09QeW5IYzRQenJ2TzBMUDhLYWJhWVpBUFZCTzJK?=
 =?utf-8?B?L2p4c0NUeFpCUXlRTTN5YVlvTVdWNjZXV3ZGM2lnemJOVEhKZEJCcVlaUytS?=
 =?utf-8?B?R1pWK0ZzenpjaFlac040Z1BVZ2lFd1UvMkdYOGhGRkEvL0EwbC81YjNPcThj?=
 =?utf-8?B?enR4VXNLM3haVHNLV3p1MmhDRlFFblVzL1Q1OHRUdGVwdHJhaXl6L3ZIYnAv?=
 =?utf-8?B?Um15ay9QTkw3blZZRGNTbmxJSU9wOWp4dzdPMUtkSndrT0Z5WEtNOVJKR2Fn?=
 =?utf-8?B?aFlUdk9ZRktaeHQ0WllKKzlCUVNjc1dUMzdXMUpJQjJ0Z2pvMWorb3htdWdI?=
 =?utf-8?B?THNMSlgwcHNmZVNXUTN6dklzQ0ZWTEY5YUFPQzJQTXRsRzJKRXZCN2lXYzIv?=
 =?utf-8?B?MEc0Q0phWXBsVWF4OEZBZWVQelAxM2ZqZVYwemErNjFZdmN4MUtyQ1F1TDF0?=
 =?utf-8?B?dDNvczE5SUpBblBmaGhiLzc4dUNsSC9laG8vSUNMZEJOVXk5YzVlaEcvTS9k?=
 =?utf-8?B?eHRsakNRUTl3Z0xwdHBHaS92M3JUcmY4Z1VqY21DLzlYVWdsQ3VTR0tNRkR1?=
 =?utf-8?B?VlNQblFhMVl3S0ZTR0NqL3YvNlQvdHZSQThZYVJES0N1T0tvQ2J4WjEvcHdt?=
 =?utf-8?B?cDZhRURydWJIZmpxWnBWNzh2ZFFYbHg5ZWFzcUgyY2doRjVKODVzdG5IbG1H?=
 =?utf-8?B?SUpjNG10aTNudExTL253ZFQ4UGFKNFNLYk9IRWJsQzBCTE05N3ZYVnZpc3hM?=
 =?utf-8?B?RWp5Y2xkYlJHRHI2TSsyVzJxUDlkbWgrQm13UDFzUkxEVEpud0gvOFl1UU42?=
 =?utf-8?B?VTNES083ZllXemx2NDllOFM3RCticFU1RE1jZVI4MGxKYkpabjlvNE1CNHBC?=
 =?utf-8?B?dXZaaVRoZjhsME9tVTBGU2NpOWJEZ3dNMnE5QlhBZXl1YmpMSzVpTkdYbjQy?=
 =?utf-8?B?UFNTbktsRFlINWQ1WnkyRWNwVUlTbEQ1L2U5WStSbHZVNU5EMXBZalNFdWt4?=
 =?utf-8?B?VXM4MllZd2UyY2ZMeVFmcHZLOFRid1lxRVFneEUwaFppRitPOEduZ250UmVq?=
 =?utf-8?B?aGR5ZVBXZlgxR1BGQjJKT1RuZExMYU5odGpkcXhLcDRHTC9OVkl0Yjl0UENB?=
 =?utf-8?B?RC9kYlVrTlJSeTRoZlFlTHBrelpMTmlTVmV3VjFjYnkxWnRoV1MxV2JjczZm?=
 =?utf-8?Q?im1PQRgPLm4M2LxQqUBrWXywdTm2An9HCw9AxXq?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2a566b-608d-4e8a-c7a2-08d8f0573f7f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 13:01:19.2374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IoNHX3Uze+GWqpy6sRjMg7bbaVmuEyd4idyiTJhLJh2lDp7R/r1RthyiWtvZOek9MlsLpxhZ0wXIkyM8dpZ+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3478
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/26/21 8:13 PM, Christoph Hellwig wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Fri, Mar 26, 2021 at 08:10:59PM +0800, yanfei.xu@windriver.com wrote:
>> From: Yanfei Xu <yanfei.xu@windriver.com>
>>
>> disk_part_iter_* helpers might be used by other external modules, like
>> lttng-modules. But it was unexport in 'commit bc359d03c7ec ("block: add
>> a disk_uevent helper")'. Here export them again.
> 
> Err, no.  We never export things for out of tree modules.  And any kind
> of driver code has absolutely no business looking at the partition tables
> to start with, modular or not.
> I see. Thanks.

//Yanfei
