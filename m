Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F28BC433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 17:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242233AbiCNRF3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 13:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiCNRF1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 13:05:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF7D1D314
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 10:04:16 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EFScww011211;
        Mon, 14 Mar 2022 17:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PWCT3UHiiNGvIPu985RvECJxcUv4eTU795k52rkB1qM=;
 b=YhpoDdnaLIC47DZf7UAQPym+nyX7XpuTXsfaTwkdRf6bukUxCb9kXI9i4Zb8JVunSXpc
 MZoQkSJ6RNqtiRy/jKlmsBzwMPQdmzuWAQa3yx7NK1OEOGXrTzk6p7Av1MIZFUXWE/x3
 1814psV8mipupX6tXqzuiBId3Dh+2LVT36f8tEyUDzxjKfyGM5uA5fFpyvjpbAclLqZb
 sp1ZmZMIUqsfrotf2+FgdPOivBP3cYOfB7RfKeVpAhp+yPSnD2T+8aQPl8aoMdphry3i
 CZEKrB6DZi5QioQX2UjNKDnvkWRbrp4hdvhs5eWQbRe+UkeyihEWQ/bFs5ES4NSBqyPB Ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rgv22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 17:04:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22EGp0Zt018066;
        Mon, 14 Mar 2022 17:04:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by userp3030.oracle.com with ESMTP id 3et65nwkqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 17:04:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju4yAefHIDq8YTI0dauSs7z9NwxLyrDkBhcjKBOZzUbMOy5zgfbC6ArOVMDY0Q0O5RCg4fRe8ZB9schBbAmj5lH+rZQ9GXLEpqbCnKw8rrABEwlMaST8Gx10j0hzwXYefVTrGM77JCHkR8n4t+tqi++nz9vbS8nMZNyk/qoqIP2jfLXv0LjIvFPDJpn+NtWtTMP9av5ADZpu3W2qOHgfB8RUxdOMj0t2u3LxMvrJq3G0apQ3WnuqYSJukXLSGXBMONp0HpEPw4etz2EVWEQ+il9m9XwEHupM/XD18xcdcmGXLvuQQ6ys0qyeQa6FFRA+7x+SR2a805o5eM76IpKGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWCT3UHiiNGvIPu985RvECJxcUv4eTU795k52rkB1qM=;
 b=kBN5zcfCgcmd2DYYf299oPgMfoCKTz0GIsb8UdNpiv3GOaxf77XVst868DLMErV6VxSszAVHrmcAzCQwdJ79jnp7WY1bD0vKd/Zgr5J2ez94fDU8/CD/i1TpYHt/LKCfo0Eu8pkxmPAtc2eGDH/YXfh+6DiCG3wMEOkLK7/OY+F7zL/FdQchxpqhFwY9S4YeL45N+dJNWdGBs7mRla7634aQXtw3MtjbrbAiElb9Lw2BwFaamMZ7B/BD6Kj+hAmrNf+nWI7TuRYxuvd8RX6cshRE3oBd8Akep83IHtxk9S4CjRUAbfBnjs8rOqip9hTWFIye5nZDyOllWO98pZKIPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWCT3UHiiNGvIPu985RvECJxcUv4eTU795k52rkB1qM=;
 b=NcCaDlOl696ZbsvFqQJ5DZyGZfMqgCD482/TUxI3ImlegxdxTPKlEee4cjIYA1xoS3ly1TnuqVPA9w3xzA8bXVyGsOgHo1PUAXuVXb2I6EsdZA6SMBc3LTWmgMDq7KJXpo7N2Ejk2M4CVH6UrBFAdRJ/sogctrQQcAwDNXOrOSA=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CO1PR10MB4499.namprd10.prod.outlook.com (2603:10b6:303:6d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.21; Mon, 14 Mar 2022 17:04:08 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3dd8:6b8:e2e6:c3a2]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3dd8:6b8:e2e6:c3a2%12]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 17:04:07 +0000
Message-ID: <49964bde-da7b-24be-19ae-9d14c72ce631@oracle.com>
Date:   Mon, 14 Mar 2022 12:04:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org
References: <87tucsf0sr.fsf@collabora.com>
 <526a8360-d7d3-1211-087b-c86d5a68380b@oracle.com>
 <57af4fe0-9042-729a-18e9-839a5f0a84ac@suse.de>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <57af4fe0-9042-729a-18e9-839a5f0a84ac@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM5PR06CA0084.namprd06.prod.outlook.com (2603:10b6:3:4::22)
 To DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81043d52-24f4-4af4-d14f-08da05dca6c9
X-MS-TrafficTypeDiagnostic: CO1PR10MB4499:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4499CB770A29FCC7DBA98959F10F9@CO1PR10MB4499.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pzhBVmuY/RU46EkorOS6MNlHTKOOgRXO7dXTTlmT7ne24iD8esthkYn47wGmFWB+R4wpJJ0pXIEvADipU806Mrkl/1Sn8Sts8qkmt1uZ7b4tSfrhzhe8V+zNHwpfZHjw4Oot922zf9hZK8Up8CK20I6ye07pNhtBeiXqelLed8qYcpMnyb5DVMDk0gpDZgVWlE5uxiImY/Eb/2ALRbVOJAdrFhtTwGYtWY50g/Va2HxqnGy99sEwWA/z9rub0x5yFJFgYFv5JACWqVzlysTt5GPdKUxuQzyceV8X4JKlvF8H1dS/0s09FtNLLMFRLJOMnPvptUkHvc16ZJeFsMZ4yLBVkUUdOfUhIR+FpdEweh6K9slMviuUTf2sp8wvjS0B5LYhv5fr6WGz8qHiSzuCxgwCiEkQtPdSpby8ykA2p/UFKPwmS/unxrPEa8uHzwMi4f1ukZeZ2Z8ASOWBLU/q4JjB2su/GWlh2Fahh5GbgOr+uhReIkLZuCbzGuZPcTFl4vV3zWFjz5lNzQE5lrQWIYd6Wgn6dCouKlnIwRhDrgRbZPn5TmKNNjcYmVQpQ+U7IASWHP48Qu/xLezWlS+mOHognBETl4SZS7+Y3dcFTkuy1DutBY8RJFgpG8AVMMqg1wZABExapplEjVPEAUrRb0aHWakw+519O0OelkXeSGYH3hdag5Gm7v9ok5Y3cQkAwmzKLsjCklNbqHAW7gQ1SKKeAK3vNuiWkpHbKVu/m8K7yJ7SnwgxQwgsUpW2SrGw6G56CBXve1o49IfN10QBuinAqIM2M4N41bXNczfcwl04D6H7soW22qEoCstb7tCP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(31696002)(5660300002)(6512007)(31686004)(2906002)(83380400001)(36756003)(8936002)(66476007)(66556008)(4326008)(26005)(186003)(8676002)(38100700002)(66946007)(53546011)(6506007)(86362001)(316002)(110136005)(6486002)(966005)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDVzNjlDZE9XNk1iL0F4eE0xaE4wendOYyszenQrSHNLb3ZIaXBpNjRpQ2xs?=
 =?utf-8?B?ZVkzNnFjSUhFdlpUTklBVW02L3Q4Wm41NngwY0NiZlZwZE9WRWF0dk5SNkRW?=
 =?utf-8?B?bGhsLzV2R2NlZjJ4QzlYQ3NpZVowRGMzUWRtNnlNc3J0MnNzKzhlVXpxekpP?=
 =?utf-8?B?KzIzNWhIdUgvRFNXTkpiUUMwVnFMK0I1ODFDL1hodDJvSVpXMldvSkFHR3pY?=
 =?utf-8?B?UWpRUGI2d00zV3RKaFNudVNtODlQT0w4ZHRMMGdSQXdBS0YrUGxsazUyZ3Ns?=
 =?utf-8?B?eW12WDVtZ2h5RWlPUlNCOEorbFRZSUJpa3lVTTUwWUJidGNVeWFCRm9vaXc0?=
 =?utf-8?B?dUthYnNoaEhLYVJHKzYwNlVFeHdOUEpmRjlpUDlVelhmLzlkejRsNTVmREtM?=
 =?utf-8?B?eUpkNHNmMzU0eVVFYjNOY0MrNDBBL25kOVFqaU9wRENYNTUrQXlRcy84ZzNV?=
 =?utf-8?B?Ulo5TmxHUm1TVFJsN3ZhT2JOQ29FNTZ3OEcydnM3ZlpzMXBKSlZXeHpBV1Rh?=
 =?utf-8?B?YUsybnBIcEdEK2RXVlYxVlZuR0wyUmprU29KaFZ4a0pyb3FGbGkrRHhyMXJI?=
 =?utf-8?B?VnVxQTdOY0VGU1RkY3ZwMG05eGM3VitabGpienFpZ2NKVnNVb3RDb01tdGxn?=
 =?utf-8?B?cTRQZFpreXIvRy9va0xxVTc3aG5zQU01d1A4YXhQdTBRMDQ5VCt1aHprZHNL?=
 =?utf-8?B?WnZIZUszZkdFWWxjbU5MRUUxbEQ3ZTIzWjJ4TFZjL2FSY2FzZTdoNTdqVnJw?=
 =?utf-8?B?UDY3VEZxc3J4TFAwM0F0Y3ZYSW04MFY3TFVxZEFLblk5dFhOZ1FWZnVTUVN5?=
 =?utf-8?B?YVl3NlVkNytUK2R3a2pnK3ZQQ3JhRmc0NGNzSDF6YkFXVW8rWXA4V0N5RER3?=
 =?utf-8?B?eU5XSkNpM1d6TVJmNjNsM045NzJudDc1TlNFbHlFOEh1VHVHNTMzaDVSNkFN?=
 =?utf-8?B?UnhOWkN1ZmowakFzVkZJM2hZTlVlSHk4VEdKVGtqTFhiOWh2LzYvWHphYjRa?=
 =?utf-8?B?VWFuN2hmaktGV3I0THA2Ykp6OVRhWnBUQ2FWanpqN0RNbGhoTzBwOHl0WUZC?=
 =?utf-8?B?OFNhZ1dkQTEwTUhvZXNYbzZNZERvczJKKzhxYWZIM2NXcjFBNXpNV0J2eU9o?=
 =?utf-8?B?NXIzMVlHRUVhaU9YbVhMallLUnBBQ3pRckdEVGswbkd5NDJJQk9mZmU0M0FO?=
 =?utf-8?B?cnpJYk1YeU5NNENqWDdOTlBZMU5rTm01RDZhbWo4OTZ5YjMvekRicUhNNHFn?=
 =?utf-8?B?cW1pRzBNM2lMWk15VjNUa21ObGNvOHJEemdDYjZJWDJnM3d0cWkzRVJBd0x3?=
 =?utf-8?B?QWsvUDZmSXVUcnE4eStZN3JRQnRXZ04rYUxFVzBZTmNVS3ZaclJZMXp5Rmtx?=
 =?utf-8?B?TmM3R3Q1bkJwS0k2RHZvemFtMlZ6VGpqZHJ6V0hzNkpYRWxtTks0Mi9MS1pV?=
 =?utf-8?B?RmloSnNYOUY4bnVSSW45NjRVcjBlSi9xL2RrbUJialpETStOK2FLT2hKYTg4?=
 =?utf-8?B?Mlc3K1kvT3dwcGRyWlV4UTVjbkkycXFnMnhmRytodk5BS1F4VkhVK1IxOGFU?=
 =?utf-8?B?ZTZIcHkvSGp6U0UvQ2lINlN0bzE5OWlqazlhQ1krTVBaZERxNVFOS3FwQXNS?=
 =?utf-8?B?UWd0QVZFbE9wV0QzRkhhS1JPcmpyQ1VwUjZRM0VwaFRoUkRDZEdYQUNFc3hh?=
 =?utf-8?B?RXA2VDdPM3dkSFB0OTA4RGdFUk1jRzJOMTlhMENzbFFDY3NhNHliWnNobldr?=
 =?utf-8?B?NTNMZHMwN2FrTDIzdUUyWlJKSTVzWFAwWVd6cTZPdVhHenVDN1U3dXVwZHhU?=
 =?utf-8?B?Ymg1YWpZN2F3Mk5FWksvZU1CNDJTWFc3SlcxZFhKZEw3dVZEajA0QlF4cnBY?=
 =?utf-8?B?ajhTRVljTjZxR2l3dzlSOTk3MEczLzJvakhHNzdpeldhd3JYTC9ESjNrdlNp?=
 =?utf-8?B?OE54eWNlbC9LMjkvRm1yaVNSdW5ONWtEYmJwb1dpL2tDODdsSXl4SnJ1Y2hI?=
 =?utf-8?B?Umd6Rkg4R0xRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81043d52-24f4-4af4-d14f-08da05dca6c9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 17:04:07.7409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N94lB7XW20EU8TaS9tQfFORE0ViZyBng/aSz87nGGNjKANO+qbe5BRwSCDwkKM8emvim50Oq8fgtG/uYFs4IAkdiXFYWF5mNZ3EGt/hA4Jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4499
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10285 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=994 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140104
X-Proofpoint-ORIG-GUID: MkFYv5kpAyjSBusCQfgGxV0X6amI-hpb
X-Proofpoint-GUID: MkFYv5kpAyjSBusCQfgGxV0X6amI-hpb
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/3/22 1:09 AM, Hannes Reinecke wrote:
> On 3/2/22 17:52, Mike Christie wrote:
>> On 2/21/22 1:59 PM, Gabriel Krisman Bertazi wrote:
>>> I'd like to discuss an interface to implement user space block devices,
>>> while avoiding local network NBD solutions.  There has been reiterated
>>
>> Besides the tcmu approach, I've also worked on the local nbd based
>> solution like here:
>>
>> https://urldefense.com/v3/__https://github.com/gluster/nbd-runner__;!!ACWV5N9M2RV99hQ!YY39rbV9MpaNUtr7ElzgcG1TyPznVEt1yppLwAGkq32-Fw9rQkqB6FzcaHiwIdgXp00K$
>> Have you looked into a modern take that uses io_uring's socket features
>> with the zero copy work that's being worked on for it? If so, what are
>> the issues you have hit with that? Was it mostly issues with the zero
>> copy part of it?
>>
>>
> Problem is that we'd need an _inverse_ io_uring interface.
> The current io_uring interface writes submission queue elements,
> and waits for completion queue elements.

I'm not sure what you meant here.

io_uring can do recvs right? So userspace nbd would do
IORING_OP_RECVMSG to wait for drivers/block/nbd.c to send userspace
cmds via the local socket. Userspace nbd would do IORING_OP_SENDMSG
to send drivers/block/nbd.c the cmd response.

drivers/block/nbd doesn't know/care what userspace did. It's just
reading/writing from/to the socket.
