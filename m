Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF26C433DB
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 01:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8F8619F3
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 01:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhCYA7u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 20:59:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33250 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239444AbhCYA7a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 20:59:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0ws05138837;
        Thu, 25 Mar 2021 00:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=2el7VAaNLBMDPGx7hQyNNvJa1JgeT1lekkUK/oZqW4s=;
 b=al0wz3DbcIRNzq8szF4bQIF6CHcFRKF9c7v0p32BjOiMox8FtlRXfeWdbzPnoh9Pzzwi
 jjFlPjHgEVFV7iJ8KgSD9fHlrd7ztv3/Ge4+eOiZT7SdOweHcU6w7ZBSLf3UgcJbyUFN
 h6AH61yVprfGU1MsaP2H/yXFckI1hnH3vkefeZSqLr8JRhbiJzsDQYhRsOO4xjb2ZZId
 fjlK+xs46MptwS1sGvbYZuGmcOBt+NQOwhzWtIywBlkKe0bEj8XGxKxx5ZH3+v2ggQEV
 uo+6loR4hGOanwq9Aouj0xlyy2/sUzAR3TEVyZ26sofpNyamX7GkcRqEweTtCJ6+CC62 ZQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37d8frcpes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:59:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0oU6m102731;
        Thu, 25 Mar 2021 00:59:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3020.oracle.com with ESMTP id 37dty1983v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:59:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WP4ElPc+JT1fOuhV9S+ixUR3tktoeOSccG2oP1wHtStnFBeJPYqytkTfnYXrYN0hIsLFEquqyBQGPWpr94qjbw5dFyKHgO9k6o3SzzIIaKmo0ZewyZw7zZRw6vto4Zybg4GsrjLZPPVHaCCyXbfAQdB6CGy7gu9lcsQP48PXOUvrD4138wIqu75drBq5/UIFUqiEAEV0gkKYpeSOLINc/RwT6SSMOL3dnmIdp+D9y1lWQgeAH5U02FCxR7R2nchMNrdUOwLCSKPzYq3CKrlZTsfNv3GM0gEANGKPVdKIA86JVpeu9kTG19sUSm+Iup7xaFlZ56kp7zCCDmz7OA7mFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2el7VAaNLBMDPGx7hQyNNvJa1JgeT1lekkUK/oZqW4s=;
 b=anQU2L13SSXtH/Ay3Co5Seljy0KUJLmsqDo9DgV8lmHLfOcghzKKz99mMirmaxruVMN0ukPt0ajo441Ywc9BAPbJY/ivWJzjNpZd5l8xlv3PfCw6OFNLIvZXI3CV/ByHK9oEh8s9WOqbuzIlfikKMbsmh+wLBvo+hCizvrIEUDD5UxjRDbd7VrNTYd3C8gWLgq8cR7W0dU0Bs8jbImacc4h/r6NXvwNrjrf3HUCO6WnNKgrT2CbT4UPXFc0sdMgZ2QNHFodLjZlMYT3nU/Nu/fhZosxtpdvF5YYU5aOgAJqU89P6TeIfCMfJXr5kWm8Y8E4Nhbs7cJ2PC6u6y45C0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2el7VAaNLBMDPGx7hQyNNvJa1JgeT1lekkUK/oZqW4s=;
 b=bbTwTnZva9I6MhBt4p9oLjPp0EMOl6TqhRGNFdTJX1R7uRiBDqbSsX2x/ZxxvlWF0RdWz+hfaGjajl5MOlkgHQ4KvM7u4A2fX5JqmmNnE90ApPhx+r+q4sNnWL/40ZNTMMzWvPDr6WGj/TrSaNr7L+V+jsUjWeXrNz7X/+BynWA=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by BYAPR10MB2583.namprd10.prod.outlook.com (2603:10b6:a02:b2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.25; Thu, 25 Mar
 2021 00:59:03 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f%5]) with mapi id 15.20.3977.025; Thu, 25 Mar 2021
 00:59:03 +0000
Subject: Re: Race condition in Kernel
To:     Ming Lei <ming.lei@redhat.com>,
        Gulam Mohamed <gulam.mohamed@oracle.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Martin Petersen <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
References: <CO1PR10MB4563A6404AD789EEF93F995798639@CO1PR10MB4563.namprd10.prod.outlook.com>
 <YFvbMERoGwJPFGFu@T590>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <53543516-cdfd-5277-6897-63911a1c0126@oracle.com>
Date:   Wed, 24 Mar 2021 17:58:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <YFvbMERoGwJPFGFu@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.231.9.254]
X-ClientProxiedBy: BYAPR05CA0108.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::49) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-231-206.vpn.oracle.com (73.231.9.254) by BYAPR05CA0108.namprd05.prod.outlook.com (2603:10b6:a03:e0::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.10 via Frontend Transport; Thu, 25 Mar 2021 00:59:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 113fb3dd-0625-480d-51c7-08d8ef292ef8
X-MS-TrafficTypeDiagnostic: BYAPR10MB2583:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB25830CF3AE730DC6ECC797CFE8629@BYAPR10MB2583.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p2YrotzjgbSH0bNCbsk5Nh+BOhUlmQCRiQJCbs7Qggzl5pWb07bqbkIGOfMUjYll4/6e50B4LmDqj9I304X8oDVwbBlpWADvoITIccGvGR0XI7vTQH4970mhSp7HzRx/eUCu0cNa6zDrWy8OF92JQ1F9G7VlAILe3hqvPk9g4KGGuuOYrZOmGuD3XWPF7RHsd7HI2tnZ8OzELYMdab4epfLNGpDZGIo2dU8Q+4B2FJc8HN+wUFNRIQopCY4WX0lj/ocSMDYpQ82mocot+H66G7NjmTRHRwCujPUvHYee7725sSUpbuPw2sLoVnAuPOAUA3X4B3joCAdp3U5Tr/1wKxqpLKkPvBYeTzufI+aVoRQTvBBLIkV6DUvQi8dYBig6c8/zXbC0LJd+mkyQ6uzkg40q8avwxgI7A/taWh3VU2J4AuPDfW6B7EkL3TSyrFj7XB5Jfs8ZYVnKYDOrpKcExUpLvgvvRTwaKvjX+ZbKEkun6p+9qafjD9zPFAZUU9qDYxAvsKyrh6neJyp0xlI6rVByVFnrNXIhZYTdYi+tVIr12WIBG0NpTUTGEvZEXEsPjpOKyEbMSEl+QjQMQl/BbO6i3QFhugAj38gDHGyzY/z0lProFHljy3a119ZKXCYbe8e5xK99nel1hn+ChJlGS8MXyaxQpIA4JnHpZrkpCpR1y0StaCNfQTzH8FKhz3dez55O0+hKmCGoXBHD5WOI066HRYgqNEUSoBwFYrkQK3ek3dFf5Yyu+sEYa/r1CPsc9wLDIuiZGoAAHeU5tu4ZcqZIMD1qs+wi5cBU6vvs310=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(136003)(346002)(366004)(31686004)(6636002)(2906002)(16526019)(186003)(3480700007)(26005)(6486002)(4326008)(956004)(2616005)(38100700001)(44832011)(966005)(53546011)(5660300002)(83380400001)(8676002)(86362001)(316002)(110136005)(66946007)(7696005)(66556008)(66476007)(54906003)(478600001)(8936002)(6666004)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RGMySnNxYU4rV0NmSU8wNElKZzloVHA5QmFQYWZFZTMvQi80VWg0Z0QxNG93?=
 =?utf-8?B?eUp1SFFSY25FWWo5N21FeE9UTnNHMDFLbjFVeENzTGR2TEJJMWtoN3FOOWFD?=
 =?utf-8?B?a2p2RFJKUkVIQ2t2QTFCVjAvd1dpTDJwbnRmTHB1dVhQN2NhWkZQVDZuTHpS?=
 =?utf-8?B?ZzNQWHpld2tYSk9pTXZ0dXVXSm1BYVZubjVVUm1YZUE4QTBwN2dDT1JrNHFI?=
 =?utf-8?B?OEZZSUROZjVTdnhFanRGUXkvem83NW5aT0hTOSs4REFYaGxGRnhuTXJESlVy?=
 =?utf-8?B?c3daYTU0Zk1VbzhRMlhZR1hSaElXQWdHdTQxUFBJTEh4aVQ5R1B5UmxoV0NS?=
 =?utf-8?B?dmh4K1lmTG14M29yYjlZMzhPdW5zUWtQR3Y1VUJ0eCtERzNzbHoxK2ovREdu?=
 =?utf-8?B?YU5qK0xYR1hud3pZRFEvbysySDYwQlFSMjRqOGFrY0dFUFBkdGx4eVcxaU54?=
 =?utf-8?B?YVVEMGVYYXE2SjRKZjZHUEVKU2ZiYngxbEFYWEZXV3V1MGJDVzV6VWxrcjZN?=
 =?utf-8?B?L3N1UjNWaEJGU2Roa09rTjlsTmVkNW12cktyT0E1KzBoN2xZNk9EbWZpbWhv?=
 =?utf-8?B?MCt6WnQ1Y0lYZFhVNWoreWN2V1FKVDU1UUVpQzZzZERoZzFlZWFBbUNWTmNU?=
 =?utf-8?B?UmdVdEFtUHBXSGZ3anNJbjNMQ3pWUVZIdkgvMk9CNXJNRmE1RUhoN2pBdEJ3?=
 =?utf-8?B?bTlsU3lQVjA3ZGV2ZUswREpWbXpUZk1qUlMvd3hIQ3o3QmNqNkozQUZlTlA0?=
 =?utf-8?B?U1JRY1V3ZDd6RXlGek9RMmVNT1o3MTZ5S0dkSHliNTQvRXhNUE1HQ1ArQTFK?=
 =?utf-8?B?SmdxUnVibEFCWmgzYlRwSWtFVTBCTWV0RC9EdXdBYzR4cG9DSVFWK3VPcWxG?=
 =?utf-8?B?WG1XTEpKY3VLRVY1bnlrRWRKVFR4MTFuZFVwYVhMNnJJS3RJb1VGTzVHejlI?=
 =?utf-8?B?N1hVVGhOcjVIa096dzJPTVdsd2ZrYjMvaEp1eExDMDl5UnFkeldoL011bHRG?=
 =?utf-8?B?dDFvWXVVWHpUMmUwSE5UK2psbFFZUmk3ejFER1orSk93SWoxQWtSemc3WVdY?=
 =?utf-8?B?UDdPRnNGaEk5QW9aUUpqa3ZuTC9vU29JOTRwbkVaLzdub1plMFFzcnhYSDBR?=
 =?utf-8?B?QXlWcndiM0xvVC9ha1lQcndlMm5Kdy95LzJXbEdGNEhWWWFhV3ZiSTNmdUJE?=
 =?utf-8?B?dkIzVk5UbHBlcTVlaDFnVDRSelFzOEFYeDYwbTc5Qi9PSTl6RlJQSzl0Sm5G?=
 =?utf-8?B?cmJkaW8wWTZUQlRIVVl2QW05aklhS09RbnZaVzhLTDc1T1VnVzBQdlBVc1dw?=
 =?utf-8?B?NFcreGZnbkNmSEJmVlBlL0M4ZWRMMGlvRGVpbjVxM2V2YUgwcGVOZ3ZXUlBz?=
 =?utf-8?B?NTJXdDBqQ1ZERlM1dmRCRVozMDVXcndyMzBjdldUU2NseURUTzlsY2l6NGhh?=
 =?utf-8?B?UGUxWFhENmNZUlU2aDhWV3NLUTBEbU52bDhBMEZSQVpOZnRpTFoxb2ZoYjhF?=
 =?utf-8?B?Mnk4OENQL2ZzbXlEMVllTW5WcGVZRWtxQWt2M3pRczdKdFpvaVVhMVVDNGw2?=
 =?utf-8?B?R21NVHQvbHNmbkRiTEU1S0libGdpUEpaZTAwSHRzdi95SFNZYWowWk9VRm1G?=
 =?utf-8?B?dEtLR2VSK3RobEpqTE50dkJqT2JGVkYwMS9sZTRpVThTU2hBM2YvM091THVF?=
 =?utf-8?B?TDFybEo0RUdQSTgrZ09NV0NKait4WGFLQlRmM084c0VLc0x0MWhTS3ZRLytx?=
 =?utf-8?Q?U7eh3ntRG9jsdPxH9keLGJxN3z7K2G3Z5BPcxkH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113fb3dd-0625-480d-51c7-08d8ef292ef8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 00:59:03.5112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFQngUGKUWe34211pu84PWLidf5p3Zw5vIfOINDGxFj8OPR15FyfRUyhYtiJgehKVs72CqGJlRAC+vJNUhi2HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2583
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250002
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250003
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/24/21 5:37 PM, Ming Lei wrote:

> On Wed, Mar 24, 2021 at 12:37:03PM +0000, Gulam Mohamed wrote:
>> Hi All,
>>
>> We are facing a stale link (of the device) issue during the iscsi-logout process if we use parted command just before the iscsi logout. Here are the details:
>> 	 	
>> As part of iscsi logout, the partitions and the disk will be removed. The parted command, used to list the partitions, will open the disk in RW mode which results in systemd-udevd re-reading the partitions. This will trigger the rescan partitions which will also delete and re-add the partitions. So, both iscsi logout processing and the parted (through systemd-udevd) will be involved in add/delete of partitions. In our case, the following sequence of operations happened (the iscsi device is /dev/sdb with partition sdb1):
>> 	
>> 	1. sdb1 was removed by PARTED
>> 	2. kworker, as part of iscsi logout, couldn't remove sdb1 as it was already removed by PARTED
>> 	3. sdb1 was added by parted
>> 	4. sdb was NOW removed as part of iscsi logout (the last part of the device removal after remoing the partitions)
>>
>> Since the symlink /sys/class/block/sdb1 points to /sys/class/devices/platform/hostx/sessionx/targetx:x:x:x/x:x:x:x/block/sdb/sdb1 and since sdb is already removed, the symlink /sys/class/block/sdb1 will be orphan and stale. So, this stale link is a result of the race condition in kernel between the systemd-udevd and iscsi-logout processing as described above. We are able to reproduce this even with latest upstream kernel.
>> 	
>> We have come across a patch from Ming Lei which was created for "avoid to drop & re-add partitions if partitions aren't changed":
>> https://lore.kernel.org/linux-block/20210216084430.GA23694@lst.de/T/
> BTW,  there is a newer version of this patchset:
>
> https://lore.kernel.org/linux-block/20210224081825.GA1339@lst.de/#r
>
>> 	
>> This patch could resolve our problem of stale link but it just seems to be a work-around and not the actual fix for the race. We were looking for help to fix this race in kernel. Do you have any idea how to fix this race condition?
>>
> IMO, that isn't a work-around, kernel shouldn't drop partitions if
> partition table isn't changed. But Christoph thought the current approach
> is taken since beginning of kernel, and he suggested to fix systemd-udev.

This is a real kernel bug. Whatever BLK_RRPART do, it should not cause 
this sysfs stale link issue. After this issue happen, there is no way to 
remove that stale link except reboot. The situation is even worse when 
login back a new disk, since it will reuse the disk number of the old 
one, it will fail when it creates the symbol link because the stale link 
is still there.

Thanks,

Junxiao.

>
>
>
> Thanks,
> Ming
>
