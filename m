Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E115C433ED
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 05:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA4556101D
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 05:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhDOFCp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 01:02:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44048 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhDOFCo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 01:02:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13F4wdZA001629;
        Thu, 15 Apr 2021 05:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ltxT882Mx0QgzRqsC/MVGyHmsWJPQxVNdfz7jR2pvco=;
 b=xrkkATByh/+a8yHRLB2L8c8DKjte6Eu4/lbAfKitpj5viAx7Tn0gC+aK2jeQfxud+cIp
 NBu9GF6TaLDDq8AAzGGPlSPLrhuR1BgNlrCDVVIGykOgINVGf5MONFdHzvicCAWE/JLV
 2VoInbNRDr/zIcr3Mt+YRwAmM4zrSgYP0tzcvXEPT+GdUZBWVcU0UQlnSuYamsJqtK5t
 27yzwIxVXhKMXTuTWR9Fgw0nH0alRulysUPRGxfPOnKrc0/rAb0HXFxdiko3JB4M6th/
 XGMba9XdiSUSBKIxY+1SBAAqKj4UsAN8e/NVkXVb8P3EAYiPlZY2xyf3sV/WfYIbUxB0 Jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37u3ymmfxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 05:02:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13F50ZMJ109040;
        Thu, 15 Apr 2021 05:02:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3030.oracle.com with ESMTP id 37unks1nk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 05:02:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gm53J7m5TJmXTZar8B8Tw/8+pji93DGsOp51+iyLdNUnmlhDjACO94NNfseiaDtBOClFmo9Ng+pAdCm31fxh654POIscjRJuvveTuZVo6iz5UZnPKPCMMSeNzN3pZ/9/L6aWzrT0kFp8DkKLCHAQ7AqPLyUwdbErUAW4dvb/jiHmDMy49GKc1+pUc85EpWZjx5WX+woTbe77twimvAuJACwVEi1/RJFC320gxPCVPzr8laigFdwI8CB9xp6qrb2NpBlcbgTN6vS8PP+DXIdGSZDl8/6QNQqVr9HClc8xvduB8wKI007l6kC5mVxetf2jLI8TIqLxF66Ulk4PmQsevA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltxT882Mx0QgzRqsC/MVGyHmsWJPQxVNdfz7jR2pvco=;
 b=Cg9zOSckAYLJK5bwu56ypR41tvSesqaGtwX5YGIuMCVwr+62xTnZTJdkKfwnzBGlt6ntIhqlxgOqBHE8tl1gw5NwvICAKgc++s7E1wrwZW9Qt8Fut/MEUqav+fXs6KIiJPi1dD2A1PnB5b0aQFwcmPmJSZAw14wbj27LQmzXhasClx/Twl7uBs0cOLGM7nf6xhwW1AJDTCIKW7kmEVCWcGS50qmBKGMpq/Jjsvkm7sqoxkL7pCZTSfhoipssVWA09bfbp4NtZP30IfmOoXcOChegqb5aLrOSM4XIMy3Gv4z+TKeh7Ckf8VgQbLFdDvBX/YtmPfeipvz5W0Pr8cyxoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltxT882Mx0QgzRqsC/MVGyHmsWJPQxVNdfz7jR2pvco=;
 b=RZWEMJYRL0J4GP3jD+j19g8D0P3uIOJxeocH85Pxs8XsSzNP889qgQHK4UuVJ25JDPKXfdRPWlX9NIBl0tkOihNhXqOiO0CJ3+jjPY06HEodw43mdrRGtPXJPJYZWZKk3QyGlOGF/HKZGAVjGMMhVxDTtNqBnHD/6rKqZ1HWZms=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 05:02:02 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f%5]) with mapi id 15.20.4042.016; Thu, 15 Apr 2021
 05:02:02 +0000
Subject: Re: [PATCH] block: fix io hung by block throttle
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk
References: <20210414211830.5720-1-junxiao.bi@oracle.com>
 <20210415041153.577-1-hdanton@sina.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <583320af-7fc8-b788-7b17-dbef7a476667@oracle.com>
Date:   Wed, 14 Apr 2021 22:01:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <20210415041153.577-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.231.9.254]
X-ClientProxiedBy: SA0PR11CA0164.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::19) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-253-187.vpn.oracle.com (73.231.9.254) by SA0PR11CA0164.namprd11.prod.outlook.com (2603:10b6:806:1bb::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Thu, 15 Apr 2021 05:02:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4ce7a63-a322-4c4e-5e4f-08d8ffcb9b85
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4576:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB45760F03395C7CCDBF2EA8A0E84D9@SJ0PR10MB4576.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +CCYq2FyZh4PsZpc7CnSI60WnFvPjimy6delyctCICmg3pJrNJ5vgRucOKMA213UniP2evPm1mt05BTmgazH6CRQ4sbL6aN4rxyXHSx7f2f4rK0oNWB/VU7t8eXJguS6X39McKNBvSaT6GPvP45dF4HrMZ906xcm7CPrJTO9P98KaAHMaz1YoePUXBnbGbaSlsN4+y6B8AFOTGgwxnVsUwfJ86ukxAFU1E2oDHLPVAZlTCqS8SJMElc5PTFaffNOktwWxHCdjvurUnF/FXlb5MqqkqM2pe6TNgkrIKTsUTmHz3d/CjaXdjAu4jGod9F3nuZlbm7n6J6EA7+GZFDEhy9NwSrwXYfxWBhYaxBWKxJaWEr+yt1vTIVcodMAs5Bfj5dDSU2cJH1rwxKxePP/0KWigdni/95UUnCDUkVITq5jdUSIGGYSi/eCJf8bIlW1/eqvRwcV+r8rLOZ6pDAsIuftGX3B/6n+1vPKtwtLx69OIgO04VBAwmfHAzEzyFzPFGmJnCg2/et3gt83sqsmFxl42tfWdCy+Q3+OHPw4JU0Bhlw48HsuOLX3SP5EYujgHWT+rU08G6W8dW6RYQXK/OJR2TXNT+12XmDcoP48d6PmKBWOzugBX6ZJdPj2Bk5L5u/s/iIDiJhmt/at9mWEi7vPfPIhnk0pA5axNXDx8KoHDlRuPOBBFCVu9tul9E7l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(366004)(396003)(39860400002)(6916009)(16526019)(8936002)(66556008)(66946007)(53546011)(316002)(66476007)(956004)(186003)(86362001)(83380400001)(8676002)(26005)(36756003)(478600001)(38100700002)(6486002)(31686004)(31696002)(2906002)(44832011)(2616005)(4326008)(7696005)(5660300002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bUlVaE4vTkN0RE1keHB6dmZhMHNzVjlGRUg5bGdwUm4yM2VYZTI4RllNcTVp?=
 =?utf-8?B?eDFpQlJGVnBtL3U0L3FLUFM3RkJGMHJOekFaN3NEMTlFemlhWG1tUU9VcVIw?=
 =?utf-8?B?cCtZSUJxdm1nbXdlZmtKa0J2d0pyWWRHcmVmL3JJV2FhYjNlY3NIQ2lsMm5N?=
 =?utf-8?B?U0V3aXRZTHN5aEszYnpNUWNuQm05R1Fsb3VDMWtaMFppUzdCTDRJV1RkYkZ2?=
 =?utf-8?B?aURFcDFXTUpLYjZnMGtCWkkwZ0Znam00bktBWG5nRlpXOHY3bkZHNm5RYXZX?=
 =?utf-8?B?QlFmbVMyc1ZwZlZlTmJPNkMxK3UxcU51S2MzRDdIdjVweUJwY2Q2TXlubUwy?=
 =?utf-8?B?dzVtU2I3SkkxcjNpdFZDek9BQllkRDZ0elF4aVh0QTZiV2JHUkl4L283cHZo?=
 =?utf-8?B?elQ1dVdqeC8vR2w0N1BtT0xMOEtidmtGY0tlSHpUcGJxaTNmZkgwRjZ1RGE1?=
 =?utf-8?B?cmJpb3g4TE5mN2lsa0F2RnQ1M2Ira2twcDUyUzRzdldoTER4YUZ5cnoxb2dx?=
 =?utf-8?B?elF3MVYybGxQZkpMbk9JL3FzLzBBQUZDekEyTWg3SnU5ZGlKTFdxYzNIMzNR?=
 =?utf-8?B?SlBDbndYT3gyZ3RtNmo0UkNpTkY3bDFINGVMemxScWJaYkl2ckVqSUFxMnFX?=
 =?utf-8?B?M3doSzJmdld1UjVNZ0JsRkR4WUFSNTB2M1NYWGhVRWUySTRkMVBWTXE2QUJr?=
 =?utf-8?B?a1hvc2FyWmZ2T0xDN1h0VHFOR0ZVNHUyNUZMRnpSc3BKbVFENDBjR0U1eE1R?=
 =?utf-8?B?NWdVZGdIZVdkWnl3UGVXaUgvMzlHNDFFU2hxS3o4UjJzNG9mdjVFTzJpREt0?=
 =?utf-8?B?R1lKZXBUQnV3enJ6djFKdit3N21tZkxQclhTZU5tQ2hyS0w1aGs4NVc5VUtV?=
 =?utf-8?B?STZISnZxTkJGU08vMEtuQ3c5SmUxZmREN3llaEJ4dStVWHNUTnJHVGQvdXly?=
 =?utf-8?B?a0FTcE5TdkZ0N1p5MkFJNWZRcFd6SU1Ud3hhNVB3d1Yya0hFeEE3Z0hDVENj?=
 =?utf-8?B?TVJmT3ZSMjZzOHJaWUtVK1E0SG8wR0pRcGxFaWRiYWtMN09NUnk0RytNOUVr?=
 =?utf-8?B?MnNTREo5dEVTd3dEaUVabVdJckVta0FFcnp0aDZXVHZXZjc2blJCTUpicmtU?=
 =?utf-8?B?a1VBck01LzFaMjFSOHNtL1RMVDZUZlI4SW1rQjJhUElMVXpkZWVsTStqZUJ5?=
 =?utf-8?B?Z1kzMmUrcDVTNkdwTXVjREh4bnluSlpkbXBvVXN0SVVxb1hUamRLUkhjUG1G?=
 =?utf-8?B?QlpSSVdOTnFySjNVMkdweFFVWmlaR2FQU3NsV3hiQ3hCS1hXTnFTWW9idG9D?=
 =?utf-8?B?amw4UGJFamllMDZJSUs2NE1VaHBhYlNxcVNaQyt6K1hwV0tQUTdDd2VpS1Bx?=
 =?utf-8?B?T1lwNFRYSTJHTGNoTTJtQ3JBVGlKZ1Z0b3Q2Yko0M1F4L0l5c3RzQyttQTNM?=
 =?utf-8?B?ZkozVXBoQjJyaHNhdTFxc2QvQ3BDTDNtbmZGQ2Z5RmVINy9LUnJyK09Vc1Vw?=
 =?utf-8?B?d2hRVTQ0NStyOTlzc2dqSWpCLzc3b0l2QVhYWk4wczNQeWh5UmNVbVpNWUxq?=
 =?utf-8?B?WktCbG43MU0wQUlxajQ2aVFmYzdUcUhFcnMyT1ZHZ29EN3VTUUp6QTlidStB?=
 =?utf-8?B?UnlRTDB6QjM0UGhxb2Z2eW9oRmNKdWppTmJqRS9mdmVxemo0NS9FR3lKZkdP?=
 =?utf-8?B?c1pCNXo5NE1ROHpBa2VEaXFKUkozZlhsd1ZjNFlaWW9VcmIzWVZmdlYvbDJr?=
 =?utf-8?Q?f4++1vsTYD3BMMFGhBz8R5jl+vGkf3UBUgyFxOU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ce7a63-a322-4c4e-5e4f-08d8ffcb9b85
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 05:02:02.6364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpGUlgS3WzJYuX5oO8aGak7rwwK74+t2k4GpYGdl0xbU8MCqKC1j772VNkHbjnZHqryL4GRrzj3dxgsc0HgFmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4576
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150034
X-Proofpoint-GUID: -jKW1N0F6vwKZHYwM9c99xyLXgfSTM0Y
X-Proofpoint-ORIG-GUID: -jKW1N0F6vwKZHYwM9c99xyLXgfSTM0Y
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104150034
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/14/21 9:11 PM, Hillf Danton wrote:

> On Wed, 14 Apr 2021 14:18:30 Junxiao Bi wrote:
>> There is a race bug which can cause io hung when multiple processes
>> run parallel in rq_qos_wait().
>> Let assume there were 4 processes P1/P2/P3/P4, P1/P2 were at the entry
>> of rq_qos_wait, and P3/P4 were waiting for io done, 2 io were inflight,
>> the inflight io limit was 2. See race below.
>>
>> void rq_qos_wait()
>> {
>> 	...
>>      bool has_sleeper;
>>
>> 	>>>> P3/P4 were in sleeper list, has_sleeper was true for both P1 and P2.
>>      has_sleeper = wq_has_sleeper(&rqw->wait);
>>      if (!has_sleeper && acquire_inflight_cb(rqw, private_data))
>>          return;
>>
>> 	>>>> 2 inflight io done, P3/P4 were waken up to issue 2 new io.
>> 	>>>> 2 new io done, no inflight io.
>>
>> 	>>>> P1/P2 were added to the sleeper list, 2 entry in the list
>>      prepare_to_wait_exclusive(&rqw->wait, &data.wq, TASK_UNINTERRUPTIBLE);
>>
>> 	>>>> P1/P2 were in the sleeper list, has_sleeper was true for P1/P2.
>>      has_sleeper = !wq_has_single_sleeper(&rqw->wait);
>>      do {
>>          /* The memory barrier in set_task_state saves us here. */
>>          if (data.got_token)
>>              break;
>>          if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
>>              finish_wait(&rqw->wait, &data.wq);
>>
>>              /*
>>               * We raced with wbt_wake_function() getting a token,
>>               * which means we now have two. Put our local token
>>               * and wake anyone else potentially waiting for one.
>>               */
>>              smp_rmb();
>>              if (data.got_token)
>>                  cleanup_cb(rqw, private_data);
>>              break;
>>          }
>>
>> 	>>>> P1/P2 hung here forever. New io requests will also hung here.
>>          io_schedule();
>>          has_sleeper = true;
>>          set_current_state(TASK_UNINTERRUPTIBLE);
>>      } while (1);
>>      finish_wait(&rqw->wait, &data.wq);
>> }
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
>> ---
>>   block/blk-rq-qos.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
>> index 656460636ad3..04d888c99bc0 100644
>> --- a/block/blk-rq-qos.c
>> +++ b/block/blk-rq-qos.c
>> @@ -260,19 +260,17 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
>>   		.cb = acquire_inflight_cb,
>>   		.private_data = private_data,
>>   	};
>> -	bool has_sleeper;
>>   
>> -	has_sleeper = wq_has_sleeper(&rqw->wait);
>> -	if (!has_sleeper && acquire_inflight_cb(rqw, private_data))
>> +	if (!wq_has_sleeper(&rqw->wait)
>> +		&& acquire_inflight_cb(rqw, private_data))
>>   		return;
>>   
>>   	prepare_to_wait_exclusive(&rqw->wait, &data.wq, TASK_UNINTERRUPTIBLE);
>> -	has_sleeper = !wq_has_single_sleeper(&rqw->wait);
>>   	do {
>>   		/* The memory barrier in set_task_state saves us here. */
>>   		if (data.got_token)
>>   			break;
>> -		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
>> +		if (acquire_inflight_cb(rqw, private_data)) {
>>   			finish_wait(&rqw->wait, &data.wq);
>>   
>>   			/*
>> @@ -286,7 +284,6 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
>>   			break;
>>   		}
>>   		io_schedule();
>> -		has_sleeper = true;
>>   		set_current_state(TASK_UNINTERRUPTIBLE);
>>   	} while (1);
>>   	finish_wait(&rqw->wait, &data.wq);
>> -- 
>> 2.24.3 (Apple Git-128)
>>
> No wakeup may cause the hang.
>
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -287,7 +287,8 @@ void rq_qos_wait(struct rq_wait *rqw, vo
>   		}
>   		io_schedule();
>   		has_sleeper = true;
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> +		prepare_to_wait_exclusive(&rqw->wait, &data.wq,
> +						TASK_UNINTERRUPTIBLE);

 From rq_qos_wake_function(), the process can be waken up and removed 
from the sleeper list only when it get the budget. Looks not necessary 
to re-add it to sleeper list again.

Thanks,

Junxiao.

>   	} while (1);
>   	finish_wait(&rqw->wait, &data.wq);
>   }
