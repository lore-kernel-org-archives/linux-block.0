Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3681C433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 15:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925CE64F53
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 15:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbhBDPn0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 10:43:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51980 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237463AbhBDPnC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Feb 2021 10:43:02 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114FStvu011343;
        Thu, 4 Feb 2021 07:41:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=KVv7A6/wTfqSEEVoZQgK4sd1YCVTn9sePCvftEIN+G8=;
 b=nqEYWkuqacn1tP3Q3Uw2PAYrxnkzPBYsbkNatKfjv3ZQtRdbI+OL9qqeC/ipe659zHXO
 zssAc3xZfCjy1LoriolHd35x+3ffmA4ODoRx5xGqUtILk15JjNb+Y8qul1u/NqKNRcy5
 Im6myFqQNqR03PNJzimuEkejonM2qcwyznw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36fcs63cuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Feb 2021 07:41:59 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Feb 2021 07:41:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SB/NgCwDXbckXjK1CpEafIianMO5jiAbeWg1ElM/rcUAh021/F+2EjaclE+lmX9+VC2Rhtufs0imt5xU2eZ2qglHe5PNqZde7TWz16nfEyvhsK7WmDAxKHaWFHdDpLGz6dCkhOwiS8d8P882WYz4NHH2XWx8ha4xFPI/zGVeispbaz+QsWZyjxUwVbPIyRg5YlOnH6V25DVxia31fHxCZWwY6Crgna+gA/3+HfIE7W77fY2Yo0noY3rtalxjEjNcC7lNx2XC6nhWaCdfpI9b8HHw3ovLW1/Yj1l5bnb/uBT6ol9WXDGs6RHxHgb6JhM/4oRIcwbSVOMudUtrDF5udQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVv7A6/wTfqSEEVoZQgK4sd1YCVTn9sePCvftEIN+G8=;
 b=Pzm1O6Fi+8+MqrutQF2HuveofQuZ0pWlqWrnmt3yh4gFfBOLfUxDWUZ0P07QGHrQy3yylLY3vmH3Mgzqfp4SBUQEgwh4j+SxxarsY1LnUKljv8zVQ8axsLMEkQVGnkhZgni7zVKZRgUgytiWQU/E6fAEtOrqR3hYuzWjizgK/1m7hnB7pgm8we61Y6U/qfrvjR67/e9aAnYKXVE3GclPTlXkoWjn3rMko1gMWWOBupsnRAvf1GYXJ1qJTkMLrUo+Q/zgivAAxeN+Rz7ubYkRhC9hL3DsQIhl9n7uj3qViykSwBpBHgoc5RbBvrxc+A6xpucIcvFBJRKILq6nqQmY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVv7A6/wTfqSEEVoZQgK4sd1YCVTn9sePCvftEIN+G8=;
 b=U30G3wkkbsClQZx17Np4fhNcwT7LKWa5gjI1nhqgoeQAuMQeEZskPKSZR6lQEVOqV5nyWAZ2tq0hwRKDkeLQ+5ASnOLWGx6Q63CcZ0VG+A6V4ITTVD4MHYzVZd3dSn18yUjqFLU5nQNExZjxeCLwStmuxHZ6IeyjPNmzHC+uwJI=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB2566.namprd15.prod.outlook.com (2603:10b6:a03:150::24)
 by BYAPR15MB2455.namprd15.prod.outlook.com (2603:10b6:a02:90::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Thu, 4 Feb
 2021 15:41:57 +0000
Received: from BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::684b:6f93:49d2:73eb]) by BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::684b:6f93:49d2:73eb%6]) with mapi id 15.20.3784.023; Thu, 4 Feb 2021
 15:41:57 +0000
Subject: Re: [PATCH v5 1/3] blk-mq: introduce blk_mq_set_request_complete
To:     Christoph Hellwig <hch@lst.de>
CC:     Chao Leng <lengchao@huawei.com>, <linux-nvme@lists.infradead.org>,
        <kbusch@kernel.org>, <sagi@grimberg.me>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>
References: <20210201034940.18891-1-lengchao@huawei.com>
 <20210201034940.18891-2-lengchao@huawei.com>
 <3b75b43c-638b-b5ac-eb5e-e37314d25ce1@fb.com> <20210204153014.GA29736@lst.de>
 <70bdb0b1-c7aa-af25-4b28-f8f6675c73ae@fb.com> <20210204153631.GA30261@lst.de>
From:   Jens Axboe <axboe@fb.com>
Message-ID: <4e9b9999-497c-4b74-468a-1fd4504c49ff@fb.com>
Date:   Thu, 4 Feb 2021 08:41:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210204153631.GA30261@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Originating-IP: [65.144.74.34]
X-ClientProxiedBy: CH2PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:610:5a::22) To BYAPR15MB2566.namprd15.prod.outlook.com
 (2603:10b6:a03:150::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.30] (65.144.74.34) by CH2PR08CA0012.namprd08.prod.outlook.com (2603:10b6:610:5a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Thu, 4 Feb 2021 15:41:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47270eb4-dac8-450c-4287-08d8c923679f
X-MS-TrafficTypeDiagnostic: BYAPR15MB2455:
X-Microsoft-Antispam-PRVS: <BYAPR15MB24551FA8AC0ED63674E87B36C0B39@BYAPR15MB2455.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Wanzk67oqvGp1c0X4ljfH9b7XVU4NAPw0Ntwlk7EkMuNtUuFdCfRUjtQbSwLm4S63jt3ym1W8VkM2avEQ90I/6aq5z9OO4g8KbrYUGCCMAb7O9QnjHALpOZB9gDZk3c9Orh0spW5NjOsecEoQK2Tx1HdL1YtulzlldS2yVBceUd9rUucIznew344jAzZAMf282Sk5faQyslM0NcvL+yHPvVfi1WLtVUDNVN2roJAkhXNIkScuaiBcfe3EwT6Xx1MyCt+lT7OyPHtz/H8OVKaKTxQ6JI1FhzrkEMsUcnoC7TTDXgINMNFFhp8ysc0+AedpTRMRlEe7REySfEMkVL5HNp02joHMa/nEbIUhfMveCDJYE9sFQfJo6fz1L8WcsN4Nju6BnLL97UsP7llDhVAyT1bh/IB50Pdp9bdiETnKY1n6Oe7B0bueppNtDDhJLWXsyrfhM0fEvHbMk5TeXpH/toY+O54FCMqhqR4EDkBadYxKjf+VPpZiOzVjjzgHtKmgfUGIcziC1O7RP3UaZiPA7gBx9kRPXqUNDt3/0d4URie8oP+CB5eLnojtj5we5Wynp8t6vFyHzhK3YZKRPR6xl8/e2hJTtlt96H+lMFc5bkyLmITVB3sAA9bM28ZT2bl1wVrYTk+cnL4T/mUJyGIZb95Ub77KBzgRqzGby9BclrDUCfWV4Wwtv2u9s0ksjX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2566.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(366004)(396003)(346002)(2906002)(16576012)(86362001)(31696002)(8676002)(5660300002)(316002)(36756003)(956004)(53546011)(2616005)(66556008)(31686004)(16526019)(6916009)(66946007)(83380400001)(4326008)(966005)(478600001)(26005)(52116002)(8936002)(66476007)(186003)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R3U2aXAwVjI5UXJlSzVGcEEydldIVG1sdUdnK0FlZDA0K2ltbmhCbjZORGxP?=
 =?utf-8?B?b3lnSUxWaXhmME8yWldoMVpMbVBQZDVrckZZdC9UWWI5Ry9WeElLbC9qTzRx?=
 =?utf-8?B?alpuWVBpOGZnd0U4MjlySjBkQ3o0YWlPRzM0bkgxSXZjc1VQdlFEYmFzSTcr?=
 =?utf-8?B?ZHQxckt5NkRFb2NIdmd1Nm9jeTExSkh0akJ3dFdmQW1rSzdaakx3WUFOWGZP?=
 =?utf-8?B?Q3NHajZ0NEFXSUdHY2JFTm01L2FyVXFsM1RhQ0Q3NDVCWXBoMlRlc0JjOURL?=
 =?utf-8?B?SkxIbkROOFFDclFadGxtU0hxczF2ZGczWmM4RlorcTAzOGNGSURUaDlhempT?=
 =?utf-8?B?dHhoZmFVQW92RDlpQ2JmTFhnTmxDclU3OUlvNVdQTG5jSm9uN2I3OWVzV29H?=
 =?utf-8?B?b2kzL2tzUW5jOElBbWhHQVNwVXJpNnErZ1NCc3EzdDBtNW5mMHdJRytXK2Nu?=
 =?utf-8?B?TXhRZ3RiS290MDN0ZHk3SXhQYTI3US8wWW5VTGhmQ3U2Y3VzOXZYRUlIWUdF?=
 =?utf-8?B?SlAyRGRvZGEvM1dkMDhJbm9zMWZIRUEyRnZFQUU4RXZsenVranZTUmdNTVV1?=
 =?utf-8?B?VlFKbkR1L3pXVzF4aUxKMWhYendnQmRDd3p6eUpqdW9GRi91RU9SOTZuQ3Nw?=
 =?utf-8?B?TUdEQk9rL3ljUzU0S2JlaWlzUC9DL3RFbHpjN0IyRGpyUlJDUEIzSFN6cWl3?=
 =?utf-8?B?dzljOHlYZ0RrVzJFaSthbEpkVUgreWxkMkw2dWVmbmRZRWVTTG5ZQ3VUMENJ?=
 =?utf-8?B?RDZOV3VnUVhpdFRzYzlLMmtDSktkYSs2ZmgrSUl0a28zMm9QL2Rka1Ntd0d4?=
 =?utf-8?B?ZUxXSnV5dkhKYlZJVHV6YkZ5YzU3UkhlOUd0U1RKWlBtSG5UV1JmSkNyUklK?=
 =?utf-8?B?WjFURGwxSDRrODdYb25Dc1RsQlVYbk1ZU3ZRZUVpS0I2aFRHTEx1clo1MGpv?=
 =?utf-8?B?d29SQ3IrRmhJenpGNDFVRkdhMHpxSW15UjlSSFNkemwxRzRrMXlzK21uYjZ6?=
 =?utf-8?B?RllYTFpXc0YxTlV6Z1hSazltR3ZUd2crdnBWSFJIR25CaVdQMEtzRmVJV1E1?=
 =?utf-8?B?bjJlMitOb0NnMktMRnZaM3A0UWJmMHd6RlIzL1JKaUtBSUFMN2wybHdQZzV4?=
 =?utf-8?B?VXRZSzFtTWx0dmRId2toUzgzMWhxa2tBNER6aEFUSVl2eVE2VWlsTGhZYlFk?=
 =?utf-8?B?VXE5bnNJV0o5WDdSbmRucmVMQm1JRDJnZ0VHYy85RjcxTkIySlJ2MzFudXZv?=
 =?utf-8?B?WFphRmdZWWRYaG9WQjhNSkh3VXhNM2k3QjVaVXgyZVU1aEN4a3ppT3VwRFRz?=
 =?utf-8?B?RTd5QkZHZSt2YTFheDQzYURaZXhsekxROXAyTXExS29XeW1QdUduUmtPbGx5?=
 =?utf-8?B?UWFPWVhpa29MYkR5djhVUkw1eW41VTAxSU50R3g4QzhPQThyYUdWcTlONjht?=
 =?utf-8?Q?ocIS1IEQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47270eb4-dac8-450c-4287-08d8c923679f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2566.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 15:41:57.4982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNm83iNhC+PRHaQpGfW+wU+coSdFFA1vgVW5PZRTrgW8jcoIA1KErJqcKz0mZsyK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2455
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_08:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/4/21 8:36 AM, Christoph Hellwig wrote:
> On Thu, Feb 04, 2021 at 08:32:17AM -0700, Jens Axboe wrote:
>> On 2/4/21 8:30 AM, Christoph Hellwig wrote:
>>> On Thu, Feb 04, 2021 at 08:27:46AM -0700, Jens Axboe wrote:
>>>> On 1/31/21 8:49 PM, Chao Leng wrote:
>>>>> nvme drivers need to set the state of request to MQ_RQ_COMPLETE when
>>>>> directly complete request in queue_rq.
>>>>> So add blk_mq_set_request_complete.
>>>>
>>>> This is a bit iffy, but looks ok for the intended use case. We just have
>>>> to be careful NOT to add frivolous users of it...
>>>
>>> Yes, that is my main issue with it.  The current use case looks fine,
>>> but I suspect every time someone else uses it it's probly going to be
>>> as misuse.  I've applied this to nvme-5.12 with the rest of the patches,
>>> it should be on its way to you soon.
>>
>> Might benefit from a big fat comment on why you probably shouldn't
>> be using it...
> 
> I actually reworded the comment a bit, this is the current version:
> 
> http://git.infradead.org/nvme.git/commitdiff/bdd2a4a61460a341c1f8462e5caf63195e960623

Alright looks fine, as it clearly states it should be used from
->queue_rq().

-- 
Jens Axboe

