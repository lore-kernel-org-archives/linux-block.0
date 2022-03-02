Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5626CC433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 16:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbiCBQRX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 11:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiCBQRV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 11:17:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A011CD318
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 08:16:38 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222EqU3i004667;
        Wed, 2 Mar 2022 16:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xkksMd5ZSTeDQv7UqeaklkcgUr16KgjAtZPU6x1/pd0=;
 b=WBFX9CGnBduVCNagVcywdxKxy0C1hTsotfkkON9ro4CobVV96QNbCMwTi2LEP55+2ncr
 Co7SAp7R6iROJwMyleZ/gFWt2eXKwFSbF1Cv8bvP4fzUzZ9NKNmJ1mStrqKzPKfulr/U
 jop2cObSXcrTuaRxGQF3zdXHMs3doQ0gDAeOBxgQpYgJxeRibeu0DMQP/kazBeU032hF
 o8342g0uJ035hgIATw4ZVgZ935wMePKOSAG0CZ44mAwtZPjLNzZpqZ38E8xhDK92dqcx
 47Jrh7FodibvYgKm4oXk0OP9EDbvet/oxFkG4nnebe0mskbzEj8PG+4qGd2Z9RMlIY0i sg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh15ap41p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 16:16:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 222GBNqI171885;
        Wed, 2 Mar 2022 16:16:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by userp3020.oracle.com with ESMTP id 3efdnqhbx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 16:16:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDqvVLC6W9kYdmLzYvjD0H/Tv8hN90yme8Qw67nxgD+rc8gd9h3mREG9NH2yv0VgSzHHc/SD3sMCD1pd0xYNDVmMA5jnij+X+ZXRFgRzN5JmryYHMaI97gf0rIjEpulykMVybtZFMDrmUmCf1/1aPW0GNwyyT/DL1qp8jBciSrB6xlAvJpu/aiFleSJkBx01ycjg2F4cECvx/gKKpocVcaj6ACV+buMTHP8rlV6W2dhSEgT2sS7NZExs37AD1ZA24Ia6YTVaFU9h9fpOrI/C3gtOoq0lC2gNtoexY1EUm6uMY45nYJfO3gtf5B2j6psBlYE+keneAg4GN55epWb/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkksMd5ZSTeDQv7UqeaklkcgUr16KgjAtZPU6x1/pd0=;
 b=Ebz7QDD9GNe59r5cZM/V8mmgKXem136SSucSQbzF1TO1LvIyCfncx6k+X4RKWmY8OR3ZVP+mNrs4ASB6pCadtBjlck/X/k0p+Bs+CQJEhTgYuph+kd6vuKuMEAtLkO2Ul1N0bq8m6vYfGiJaBX/xPqFiuFaDOLusH2KTm8c2ywqSgwJvPsCnYJHrFw8uJHhhkJkJMCRfY0CA7/YM5votijn/gTqM9xys8JKS4WIBRHfGj2eYhN0qyRbMD+ArLJgWIorHf+KKAfLbBc11AjB5NzVoguPG7GY6/hqD3Il7j2SkuDdSQ3xEQLZnEUfe2xdprMfBc+h2wVboLTaWL6aWWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkksMd5ZSTeDQv7UqeaklkcgUr16KgjAtZPU6x1/pd0=;
 b=f0HliDnmu8Ms0RXiXtCbOeHaYDbIix8ccCUek4XEL+u+CmMODBuo4r8bcMr2H3SNpun8LWsMoBFwSt/CnEuX8yPOWikzx9lueb/iJk7v3lsyaVbKjg2VRQhc+MPZ1Fssenybrrb2YyEdc4xp0UryM28PkbiYvf520vplhiWwHlE=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CY4PR10MB1862.namprd10.prod.outlook.com (2603:10b6:903:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Wed, 2 Mar
 2022 16:16:27 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3dd8:6b8:e2e6:c3a2]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3dd8:6b8:e2e6:c3a2%12]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 16:16:27 +0000
Message-ID: <45caea9d-53d0-6f06-bb98-9174a08972d4@oracle.com>
Date:   Wed, 2 Mar 2022 10:16:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linux-foundation.org,
        linux-block@vger.kernel.org
References: <87tucsf0sr.fsf@collabora.com>
 <986caf55-65d1-0755-383b-73834ec04967@suse.de>
 <b6bb4435-d83c-b129-c761-00a74e7e0739@grimberg.me>
 <87bkyyg4jc.fsf@collabora.com>
 <e0a6ca51-8202-0b61-dd50-349e6f27761b@grimberg.me>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <e0a6ca51-8202-0b61-dd50-349e6f27761b@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR12CA0013.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::26) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed885012-e51b-4071-3a3d-08d9fc6800dd
X-MS-TrafficTypeDiagnostic: CY4PR10MB1862:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1862B2E8AD33A6A800ADAE65F1039@CY4PR10MB1862.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yLRMeKGMLgjhVr7rxjGm/9YlxM54k4VB1dzprysuoKcbwzXyaRuxgKKZXeIOqKzqCJOF2/53GkcWgJM+bcVWRWvIgZBotPW4oKtpNxQZqpgDfnL9vcarfMnmKvSPKQwLGxwp5N+x9JKzzEmZjo60LEI2k7/JJgaHwEXPnTsa0ETWDy70b0X5fMwAdHuUGwtYM6JUJI8e6o4nM7vXXuKrDra1nMtxI1sIpmgcSi2UocWKyD/jX+/YOd8SUj2qar5QQj8lfKpPK+/5VnJo7bylKKRM3cPykb3Bikr2kuNh5mcu9y/rwAuosH1qHoLWEGGyEw+FRk6XNbdN8xRNGZXGRGh6Y/Z+JE7HBb7YoryKMel8uUQnKJb3MECgRIF9SMo/telM0sGZ691Np2UDdkL3ne5OzSQCmkckP8EziIlu05Fk8HLsGyLO2VPBsFcAsgF/khzO+7B8AE98kQFtrwVeJSCWRL0EbXd/paVApxmzRqHuqQlvSUOnda6712bwD/0FzoqJG6KEMsZtHiLSa4OMqIoimwt54Qtu9Gj6TWeVHqsm4SxyXsfSElQMlDJcavGQAN0qXMljC2jfh2BDYOKpHpyiXlw5dVk5ueDB0UqYSU8lGCn6kyugUKYDlqeteEyMtxZZik+s5pY4+Sx2n4IJICiV9y4hl5AKSa7AFpir645voL1Lc9tTPZiq+cp7CpJ9tZG5a9HCM/QeDAJmEh3bjW8UHV6gEPwtVmgEA7J/8s8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(31696002)(4326008)(8676002)(66556008)(66476007)(6486002)(5660300002)(66946007)(36756003)(38100700002)(508600001)(86362001)(8936002)(31686004)(110136005)(83380400001)(53546011)(2616005)(316002)(6512007)(186003)(26005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2hWNm1TMXhRSno4QUprQXIvOUY0Q1JKWWJLNkZHOVRnUGFxajdyTHd2YkVm?=
 =?utf-8?B?OXcxUmw1WWRqV201WkI0S0tMc2ZPSFZIZUpLYXF5UkdjMStSS1VuNXV3MzJJ?=
 =?utf-8?B?Y2xKVGttUytuaVJiK0FtRHMzVU5yL3d1c1ZYOHErVmVxZUhGaWcwR3RxVGdU?=
 =?utf-8?B?bkhCOGY2T2NydWJBdHkydFNhVnJiRytRR0JQU0dWOHMydHFPWlZxQXFxaldP?=
 =?utf-8?B?c1VRVFNGVWVwU3FPWmI3MkFYS3N1REJZNFFiejlLVThBZ2IxaGlEd1RPaGxV?=
 =?utf-8?B?ZGRLU0IyRzlEeHI3anZscVdCZzdNZUdnODVvTVpiaWpWc0QxTk5HR0VvOFgr?=
 =?utf-8?B?RUlLUkpFK1ViZlJIcnVMYk02VmVGdlBrN3c1MWhCbGsxYTJHWFhlbnFuOVhN?=
 =?utf-8?B?dERJREhmak91ald6R3h6UTRwcDU1RXJmRjQ1ZGNBcHFEQVJNbno2YXhrU1U2?=
 =?utf-8?B?eElwV056VlRJNkFQZzNOOHVFUnFZaEpBa3Q2V2YzVWt0bDVBYXkyM1Zpakh2?=
 =?utf-8?B?ZUpXZmhPT0JWaE93VEdHaEdGa2pvcmk4Rytib0tMTTlsdmdXdVl6MTlCWHVW?=
 =?utf-8?B?K1pPSVU4MXVtUmtXWGxGN0pLMTNmTHVLTnltaVdmbWFYNGZLTXFVbUdUK2lq?=
 =?utf-8?B?bHdHZDFWS003dHZCNGhXT3Y3SG1JckNTQ3ZUL2dQYTJxcFdwaXBOSms2YU8z?=
 =?utf-8?B?enk0TGJvaXQ5bXFiN09ZUWVPSzNiSC9XS2R0bmlOeEdxTlFMQXNLZTlMU0JH?=
 =?utf-8?B?emYwN0hzYXdyeGRLZEhVdlA3Ti9PWjBDNEl4dERqdTZqdHI3Slo3RmpST0Qw?=
 =?utf-8?B?a3I0RXRzTEtjcGdZTjZRVDZLNmw3UkdjVXMyUjVpL3huR3ZjaDJNUm52R0Yz?=
 =?utf-8?B?TG1HYTJRakwvcXpCekExQ25tb3p2RVc3Y0xWQ0RyZzdSM2YxMVlDTHRaL2M2?=
 =?utf-8?B?V0FGU3h6Y01kYUlNbmgzSmI1RHhPUW5sUFhRaFFpaXdVczlWZjh6SWxDckJx?=
 =?utf-8?B?eHpvSmk4SWtHdEdkc0tURjZUak9IaU80ZTRQdkdNK0N1RjlvczZtcVN4aDJH?=
 =?utf-8?B?MkJlL1dydWtEYnlURGJpQXZJTFdOa0k0eTR0c0FacmpoMmc1K2N1dEtIZlhz?=
 =?utf-8?B?OTlSckZLMEpha1VWbXpQMjNKYUl6RTV5d25yQzlSUCtuWWNKQ2tIRkJWWjY3?=
 =?utf-8?B?Sk1qaHRRMGNUTXJ6WTdVK0RVcXNSeVFaajROQmZYQmFNQ3JWQjdHRU8wbk9M?=
 =?utf-8?B?M2l3TkpYY0lmcmdtTG56UVo0ZGlpKzIwZ3B3ek8za0VDSHJNZkt4M3E5WDBI?=
 =?utf-8?B?cDh2bkNpejNkVUtWZnRvem1RRGthT0E5alJ5ZG90alJQYXpuNWdZeXF0dUJV?=
 =?utf-8?B?UVZPVWp3cnVDNGRNR09YNDlwbFF4czh3dXowTG5JWWVxcWRmMFREL3lFeFBD?=
 =?utf-8?B?YTRjMUYrR3lTSjdVSU9uYXB3ZXJFQTNOdk0xZkllL3dIUDZmdFdJdE00MCtS?=
 =?utf-8?B?Ky9vWSs1QUtTTUdlK3V1QjFma0NVM2hXSlhMa1ZiMXVra3JvL2Q2bksrdUgy?=
 =?utf-8?B?cllDd1BSVm1BSXRnaU51QW1JNGVXZmZ3TGN4dk1QYWptQ0p3ZWFPMVVjbk41?=
 =?utf-8?B?dVIzRkJQMlJzVlg3TUdFVHRxeVRxb3NHSHd5SlV6bXRsVS9OUGtFSCsyOUdw?=
 =?utf-8?B?Z1o2d1diVjVOTndxOWRFenJYUmxEelRuaXpHcjljQWZGNEZPcEVteXZ6T3Fu?=
 =?utf-8?B?am1qUVNYUWVLd3BMVThxeEVJcWREZC9MaUFGRHVPazRyRm5lUFRPOFlsU3Zi?=
 =?utf-8?B?K3E5NkQrRWs3VkNBcnhIL3lQMmRVdDNKcnFsQkVhM3Q3NEpxdVVRcm1pUGJ0?=
 =?utf-8?B?QWc5ZW4yZHIxNFpBRlNwVERZZFRTc3VtRkliMXZTamxSc0REaU5uQlY0Z1Jo?=
 =?utf-8?B?T3ZjNE9JMFFsUjJLMFczQm83V2d0Rk0xRmlNUHp5NndOa2N1bFVPbVkzMzZL?=
 =?utf-8?B?azVIcjNVSFpna3poSjZDMFFHemdGZTlyRVZCbG96ajh5NFVDdkhzL3lmTFdo?=
 =?utf-8?B?L3ZGRHBDakxlOUF2OWJCTUhyUmpjZktWZUk1NmQ3UXp6MjRTVkk0cXU2VXE1?=
 =?utf-8?B?dVl6SWQ5L0lkUDgxcFU1VTNOWUFlSmJSOFBxMWhZRnpHYjhWU2ZTMkdSSVdQ?=
 =?utf-8?B?SHlUWFVNdDFobDdQM0IrUnpxRXltRTB6djg1MFBLZjN3Z01SazBETGJiQTBB?=
 =?utf-8?B?cVhnVlZSeXNFZTk0QVpvdHgxQWpRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed885012-e51b-4071-3a3d-08d9fc6800dd
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 16:16:27.2026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcfODAEz+OhfMV/kxQFtMA/cg+fqFpM4b5FewxS2veL6ilxfopXXqhkQLmt1xPak7DWtwH5IJSX8RNJLH9AC9gON8XcEBHHvOtELYK4wv6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1862
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10274 signatures=686787
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=966 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020072
X-Proofpoint-ORIG-GUID: IdSpt0oZsbUrLM9K3_7lQ5phSd6AYHHX
X-Proofpoint-GUID: IdSpt0oZsbUrLM9K3_7lQ5phSd6AYHHX
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/24/22 4:12 AM, Sagi Grimberg wrote:
> 
>>>> Actually, I'd rather have something like an 'inverse io_uring', where
>>>> an application creates a memory region separated into several 'ring'
>>>> for submission and completion.
>>>> Then the kernel could write/map the incoming data onto the rings, and
>>>> application can read from there.
>>>> Maybe it'll be worthwhile to look at virtio here.
>>>
>>> There is lio loopback backed by tcmu... I'm assuming that nvmet can
>>> hook into the same/similar interface. nvmet is pretty lean, and we
>>> can probably help tcmu/equivalent scale better if that is a concern...
>>
>> Sagi,
>>
>> I looked at tcmu prior to starting this work.  Other than the tcmu
>> overhead, one concern was the complexity of a scsi device interface
>> versus sending block requests to userspace.
> 
> The complexity is understandable, though it can be viewed as a
> capability as well. Note I do not have any desire to promote tcmu here,
> just trying to understand if we need a brand new interface rather than
> making the existing one better.

Ccing tcmu maintainer Bodo.

We don't want to re-use tcmu's interface.

Bodo has been looking into on a new interface to avoid issues tcmu has
and to improve performance. If it's allowed to add a tcmu like backend to
nvmet then it would be great because lio was not really made with mq and
perf in mind so it already starts with issues. I just started doing the
basics like removing locks from the main lio IO path but it seems like
there is just so much work.

> 
>> What would be the advantage of doing it as a nvme target over delivering
>> directly to userspace as a block driver?
> 
> Well, for starters you gain the features and tools that are extensively
> used with nvme. Plus you get the ecosystem support (development,
> features, capabilities and testing). There are clear advantages of
> plugging into an established ecosystem.

Yeah, tcmu has been really nice to export storage that people for whatever
reason didn't want in the kernel. We got the benefits you described where
distros have the required tools and their support teams have experience, etc.
