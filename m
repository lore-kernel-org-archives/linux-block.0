Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768CEC433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 17:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbiCNRN3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 13:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiCNRN2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 13:13:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAD43DDF6
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 10:12:19 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EFSium014849;
        Mon, 14 Mar 2022 17:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sSBocGx8iutLOmptFqOpn2osHvsdzDhtUQxa4s9yoCQ=;
 b=K8ZaqL0qG02TabHutQCmQmn/PvBTaiUtva36PzDWhDlsjxCgBvb03EqaGDG2L7zk5v8E
 62b/upjMlz3NX0gpkc6475iym3u8oGQHe+QcBdU2Y4uUYM1vRmyd9RkF7Wii1HAIfzKY
 fJWXGVppISGKKgRz0BZUxGVQhVdaQS2dWoC6c8Q3fNrtVf+S7xcfGKURd2nZgEFn4UK9
 HxpGVT73xSG1yr66hN5CMqsUAsGqJcF6uyhzgvKpO6amB4ULL/DbxjHhZF5xNBrsnwsH
 zj1WgAAmLbZotWXiu4A4QvQnW4qK6A+LvtrsIr02t6jrV+UbZAu3B8WAzyoZlGZWQ8rW 9Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et52ps0h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 17:12:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22EHBX4R079458;
        Mon, 14 Mar 2022 17:12:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3020.oracle.com with ESMTP id 3et64jcexx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 17:12:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyZqFZB1KUUEOUhOOdngzIY4acshsR++ZLJFhyDQSwJWCZ8k58CAUjJK0ZHFUiB2/E1aV6Z3YrKK0c+wjMK1fb3JWVteecOxEroF1nWuL73NCdjcIuGNGNuHUIVLDzMQhh8E24PVDLbmP/d+FtMFf+Wz81JUq/XgFszYfjnCKPGre8YGh+DLMc275W4CYsgY0VCSfEqlzJdGFPnCPo5e9FKY7UTRW2p4ySwFjCYEmzLVO+cmz2uk/w7CfKOYh6SnGyhlyl1cLm7Nstu+dQU9KLQxKaah6kIky/x1ZYAbnvQjpGJqGmHfUOJYhF8V76rzzxy1M6zIyz/wxJoFvibvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSBocGx8iutLOmptFqOpn2osHvsdzDhtUQxa4s9yoCQ=;
 b=ir0dkzvpPj3+MZ34Tztx98RiXguPkEPD+JiNoUGKhhzrJL60OmISTOx+OQuuZQIoKvZ2IoVCC6SQR+FVq1r2U6TsOOSkIyWiAa1zTIojrkWdv4DyEMh9So8x1JwQCTj9jhcfWFUrRuCGtdkVyY/iS2yVxP2xIt9JD17ddn9DtyCEvBR2kGAiyeTFnYToGwhKw277eE7HYov09Zo6wRF6K9YAtKBuncHHooOJUIJ4eFHTD5TIH9yczl1VILYVad9+scK/uKQLgwFb7xk9Zi9aMgjvPtkdAh25UJ6KYd3gmqXsTSBwOWa1HI/lZ0Bk9x0HHzZHraftQydxmS6NsfFHKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSBocGx8iutLOmptFqOpn2osHvsdzDhtUQxa4s9yoCQ=;
 b=BQSD45f4+cvA97WfKtUTdUqX+ace81PYJQTc8ie/f/4Yso3E/HQhePsl4p3VUPJ72bsBH8oWQAjlEu43gl7QVBgLYGlAZxaEeQc3lL4p8KQRcF3bSHVO2j1nlQOgF/xxKtbWniQVOgTSKKwmthGUCTOYGucGPL/xaqNf0GiH75g=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CY4PR10MB1957.namprd10.prod.outlook.com (2603:10b6:903:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 17:12:06 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3dd8:6b8:e2e6:c3a2]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3dd8:6b8:e2e6:c3a2%12]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 17:12:06 +0000
Message-ID: <50379fbf-0344-7471-365e-76bab8dc949e@oracle.com>
Date:   Mon, 14 Mar 2022 12:12:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
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
 <45caea9d-53d0-6f06-bb98-9174a08972d4@oracle.com>
 <6d831f69-06f4-fafe-ce17-13596e6f3f6d@grimberg.me>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <6d831f69-06f4-fafe-ce17-13596e6f3f6d@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM5PR12CA0064.namprd12.prod.outlook.com
 (2603:10b6:3:103::26) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c03992d3-5c03-4c70-a11f-08da05ddc3e3
X-MS-TrafficTypeDiagnostic: CY4PR10MB1957:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB19578105DADE14F643FFBC0DF10F9@CY4PR10MB1957.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VvesIIyL2n5img8mxrFiNrp8vhamP67uCm4b7KXBya9DLmkw6GCq7R8SIbiz9QDYAcSh/7ru4oK8QV/oNySQ1SyuXORQ4dYClcEEJ3HV7GYkfPdYKde7fN6gnFfsYCmXfPFNlfPqtSC0IDzgnZk27pbULxTJ4iloPTPmiNqwZcCAiDBrjhh+m5u4tux1O0l7FnBgjOzCr745M/X54jh1dQsk5/BhK7sOFCLdYDhcHuqBGPQ/P2fjj32qGQmJHRVi6/fyEIzDvx7pKGNnFKYBJ1Hnrh811bYVfNa8Try9PfwPI8DvCK+tCuJysokTZV98DSEcg0OE2qEupwQ0VJyI+CBS+q6svYQhB04L+SH8w6EjxX1lierfBqXNYEbyS1yscPlczT2yWYVofsxEk9y1oI0SUwPR3tZzhQbYYqfqycldYDWi2GgL9fJF5//fSs8TBywLDoiOfDg/yOOtvGoE0Vo31r3IbKA8FoOaRWyPNOU8JnA/o0eR2YvF91j1g8nNg4YGTAuqiYxLSr8GgZC+Nl0YSv+hXHGIgQrWFHLGdJXfhuYD0Xjjen52Os6VtEZ3Jw1X2tOOxr385btr6Buy6t/RG9Iix1r4Ci0cM7pOJ14RtsOZI7/GZF/hMHvBYa+Uwl8mhfC1niyZoEbBZvUItfFu5gcyz81UDdOeXuVc/UolvKISpC53+z49CZGH7eo2eJ1kcM0nkHZ2Pf0jIjo0lkNDj769upIu+O2ZxDdUwVsdajsPB4gi/1A3tcFnS6xweUBBAdi3xg0EjTbEGunMwhwPC0WS87D9iisXz1As0ZJ3qsOl3DJqWcHsfniMrlOT1RHAXIZR2xDZz1KAc/eJJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(5660300002)(4326008)(8676002)(38100700002)(31696002)(86362001)(66476007)(66556008)(66946007)(110136005)(6486002)(508600001)(316002)(36756003)(53546011)(83380400001)(26005)(186003)(2616005)(31686004)(6506007)(6512007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk9PZEVySG1FZ2k1RWVTY0hWdlhEaTBKMkpWL3puZ0dhcnkvVXd4SzhVWW9m?=
 =?utf-8?B?RDBTblFZUWVDUURMYndDT2dDUEtBMU02cGlZWFoyaFYvTVR3bTBNYzNyTGh0?=
 =?utf-8?B?WkorMjZaODU5WVNreXA5b0lseEYrUW40UlV4VG92bXdja0dMcFNnRWRrTFk3?=
 =?utf-8?B?NFhFUkJpbExISHdqMS9tTU1iSlQvNDZHeVBmaDUrdmdHL0MzaGkwbm16MmdB?=
 =?utf-8?B?c1NaZ2xZM3N0eHc3VXQ2VzdQakw0VUZNYkdVU2gzUnZQUThoK0d2ODlTUEsz?=
 =?utf-8?B?TzR2Z2VCZm5wczBXMWNTdVArcVMzOHM2ZWZDUjNXTW4wWVhnNzVsbjNkWFVD?=
 =?utf-8?B?ZnJodUovZFNYOG5YTER4RWFZK3hQZEpCb2pEdUJKRWdDV21DWFQxSi81dUVL?=
 =?utf-8?B?dW0wRVF4UHNnVG9RaHdSeXA5TWo1eXg2UFpVejhlZytrR3BmNER6cmhFaDM1?=
 =?utf-8?B?ejZ5M1FPVW42U0hBMEJSQWxLT1BOZ1hmcks5TWc0eGJPU3RGWFo4Q0dGVFBV?=
 =?utf-8?B?a0FGT1gwaFhCVTVwcU85VFpaYmhaOEM3R1lWU3Y0Sy9KMkFiYlY2MVBpdDlS?=
 =?utf-8?B?OWRQSFZCaGpJTzRnOEZWQnVTejdmMmtMT0g3eEF3Ri9QQmVCWGc3SFNDcXVN?=
 =?utf-8?B?ZE1HTHNvR1Y1ZDJENHovNjNYbmZLdkg1NkVFM2JyNkFDZFl6dWlrdy9TQTFX?=
 =?utf-8?B?SzZEQTdCeC95NC8rV3Qvelh0RWVQNUhJVEJGcjRXVVZRWHpoNVBFNHNJTkk4?=
 =?utf-8?B?Y0hXdGpxN2M4Kzh4aS92NUdyYS93ZnorNFRmdUVWaitWZWY2Nm54aWVvN1hs?=
 =?utf-8?B?bXc2VVRvYjdRMVoxd3BXMVdIQkFpWUpCa3NRZ3l5RnJJeUsvZHV0UWN0MTNt?=
 =?utf-8?B?dzJvTkd4cmxQempFS29LeVR5NHZvd214SlVpUEdjTS9kektYdURYRmlaQmtq?=
 =?utf-8?B?N3dYdFZ2a3FaNDJFRGgyTUpmSnRQVVJjQW01MEtyblZSWlkzM0xEZzltMHFo?=
 =?utf-8?B?SjNTSFlTUkE5Yk5RNjFjSkFWd05FS1BkZ3FyaGk1NEdsZ0x0S0pSY3NRREta?=
 =?utf-8?B?VHc5SUFGbHkvem50VE1BckJRdE1nYjVsSjI5ZWtnWndhMDdrUHlQRXVPU2dC?=
 =?utf-8?B?QWlnalpDNm1hNG1EMHd6WjIyS242dG5DVUljekpTMnRUY1FYcGVwMDMrMWxx?=
 =?utf-8?B?MmxIN1UvMHRRbXZZMElscU1ZTjY1aU9Jd0dGN0FmcGxUYzFNRUNRL1U4Q3pu?=
 =?utf-8?B?dVRvL1Y4bklTMUJjREc2S3EzbEpWa1h6VjdZcWhxTDB0SXdZd0pVM0lzODY3?=
 =?utf-8?B?MzFoLzZrUjJwYzRRQUVjMVdVV3g0Q1Fpa2JmZXM3V3o2OVVhOUpXQm9CUDls?=
 =?utf-8?B?TWpnNHA4ck1Ec2wwWjRZVU1hVkcxQ1NQc3ROaGtPcWpEeXBWSmZSU3NmZGxM?=
 =?utf-8?B?dUtrS204WHJ0dEtJQzlxd1dQeHR1SWpoSTZmbEc1c0lyczFzbmZyQ0FJUi9l?=
 =?utf-8?B?YmFiVTdYYmFxRWFUUE9FUjR3b2Z3dUROMmtYSkFCdGV2QzljeUZPU2YyNGxG?=
 =?utf-8?B?NlpTcWlwSlZZUjBvWDN0TDRDS3JjVUZ4L01Qb0k4TmtMK1FVeDUrWXhTT1hF?=
 =?utf-8?B?ZTJic09YY1RFYVptSVdzSmYrcktiWVhzNXpLNHYrZWJGczNPNGhndkwrMUNq?=
 =?utf-8?B?M1Q0dXVndUZrRitPS0h4RVRYd29TNVFiRHlrYkl0THMyOS92M2FqaWVoblls?=
 =?utf-8?B?TncrTzVFNDFMYTNyNVVvckFVZWY0R2tPTTUzZFFMTzMxTTZOUTJKY1pRdDBL?=
 =?utf-8?B?dWE3dnYzeThPL2dXczdGZWkrVzhKQlNQVjJVWnZTRHFCSk1aRzEvWi90S2hZ?=
 =?utf-8?B?c25vK1gyenpIUGFYZHBWbCtYUW9keVU5ekplRXZ4T3Z3Yml5Z2NuSGVzcFN5?=
 =?utf-8?B?T0J5cWdvU3Bra1kwSFdyRW5ha3gyTUdmdmpaamRSamlJbzFaZWJBLys2dUpI?=
 =?utf-8?B?b1A1emxrK1FBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03992d3-5c03-4c70-a11f-08da05ddc3e3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 17:12:06.0138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYJgLJdWoLopUzRVGOejoSQm6URdOApDO2AzWGC9GsQFXbu3R+AGXuGdUFjyGFek1EJk9JUC7goOpv38g9mswisCjbjkvjjxDxjn6sIfJc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1957
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10285 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=635 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140105
X-Proofpoint-GUID: mxWzug0eAqAow8XddGH-qxUsfpAO8G-j
X-Proofpoint-ORIG-GUID: mxWzug0eAqAow8XddGH-qxUsfpAO8G-j
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/13/22 4:15 PM, Sagi Grimberg wrote:
> 
>>>>>> Actually, I'd rather have something like an 'inverse io_uring', where
>>>>>> an application creates a memory region separated into several 'ring'
>>>>>> for submission and completion.
>>>>>> Then the kernel could write/map the incoming data onto the rings, and
>>>>>> application can read from there.
>>>>>> Maybe it'll be worthwhile to look at virtio here.
>>>>>
>>>>> There is lio loopback backed by tcmu... I'm assuming that nvmet can
>>>>> hook into the same/similar interface. nvmet is pretty lean, and we
>>>>> can probably help tcmu/equivalent scale better if that is a concern...
>>>>
>>>> Sagi,
>>>>
>>>> I looked at tcmu prior to starting this work.  Other than the tcmu
>>>> overhead, one concern was the complexity of a scsi device interface
>>>> versus sending block requests to userspace.
>>>
>>> The complexity is understandable, though it can be viewed as a
>>> capability as well. Note I do not have any desire to promote tcmu here,
>>> just trying to understand if we need a brand new interface rather than
>>> making the existing one better.
>>
>> Ccing tcmu maintainer Bodo.
>>
>> We don't want to re-use tcmu's interface.
>>
>> Bodo has been looking into on a new interface to avoid issues tcmu has
>> and to improve performance. If it's allowed to add a tcmu like backend to
>> nvmet then it would be great because lio was not really made with mq and
>> perf in mind so it already starts with issues. I just started doing the
>> basics like removing locks from the main lio IO path but it seems like
>> there is just so much work.
> 
> Good to know...
> 
> So I hear there is a desire to do this. So I think we should list the
> use-cases for this first because that would lead to different design
> choices.. For example one use-case is just to send read/write/flush
> to userspace, another may want to passthru nvme commands to userspace
> and there may be others...

We might want to discuss at OLS or start a new thread.

Based on work we did for tcmu and local nbd, the issue is how complex
can handling nvme commands in the kernel get? If you want to run nvmet
on a single node then you can pass just read/write/flush to userspace
and it's not really an issue.

For tcmu/nbd the issue we are hitting is how to handle SCSI PGRs when
you are running lio on multiple nodes and the nodes export the same
LU to the same initiators. You can do it all in kernel like Bart did
for SCST and DLM
(https://blog.linuxplumbersconf.org/2015/ocw/sessions/2691.html).
However, for lio and tcmu some users didn't want pacemaker/corosync and
instead wanted to use their project's clustering or message passing
So pushing to user space is nice for these commands.

There are/were also issues with things like ALUA commands and handling
failover across nodes but I think nvme ANA avoids them. Like there
is nothing in nvme ANA like the SET_TARGET_PORT_GROUPS command which can
set the state of what would be remote ports right?
