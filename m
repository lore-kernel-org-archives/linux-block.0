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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA43C433B4
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 21:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC146613C2
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 21:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbhDUVac (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 17:30:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54290 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238736AbhDUVab (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 17:30:31 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LLATug040204;
        Wed, 21 Apr 2021 21:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=qjKaTsQN/mUIe0jMLq2SYhh+OnrXf+HXY1FRghKTPoU=;
 b=fAI6tjQ8JeCehfoKtPyWpaGc4EO3jT2F/Gqm4NWzBm/1MMNpVPQDdkTAa8Eo43pge2Ke
 9ak3aL+IQe2vGI7yQQ3TrmkMnEFXbziILFXe3A0wz+2ElQD7dizCXebSWajXxi3MmUXI
 lYpfMUqho5fZV3+u0HFBdz25TuyJltWhfiNGnjJQNStMlnFdBjPepm5jnyJWdko5RJHO
 WnYMf2loK/ifS7u7mgwFpVYCI8hTg+BvPBEVJXflM/Z0Q0foeECBGN42OsC4/yaqWS9g
 Q+gVwme4073Dv4Yu7B7dKWo3KsWiRwu28N8OVYFdqPTmOw2oG9ud3fi6+p2S6GQpxlYw mw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37yn6cbp27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 21:29:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LLAY5T170179;
        Wed, 21 Apr 2021 21:29:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3020.oracle.com with ESMTP id 3809k2ghcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 21:29:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HITLhOMiooT1Gjeoibqumw6ojEDa1YK/XqS8XblOpf9A/oNeLT95Usmrx3TnGIpH9Z6cGHFZbG1LtFNYoaMZmDzj9UTvY8rIP+ykY2bwKTElh5coSWc84aJ/+pQv86//67qFT6HlDxz6E8W+/JXTgTvMl6EathBDR5ZOH5CWHHnJAHxXb5KussUAXgru3LmQOQFO2trrGAAAu6Zi9cyrKLKd2lFkM91Yo8mur4KvXXDwcg0Fyk3Yo00ebTGddU719NY85+jMHAaouDsdxWhWJySqiN8HK2OhTeg4THGe1GOKapYgVI5IXk128LG6sBPCRKhDEHhWT+rnO9AG8b4BXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjKaTsQN/mUIe0jMLq2SYhh+OnrXf+HXY1FRghKTPoU=;
 b=YB3QK08SfF/ywUt9y0k0tlkLv0BOiyVBoVIfwpD67wxTpBZ23lq9LVbaqCRbcr+yB25gG9T9RPf+jH4cG3mfte+T29ozy4lR31rgznM94AqTzapIzA06IkN8DuSfDzotJFeiFjlUP7Qv0nM1tHuNL3jwwrXBsKJrC9JWS8HEwUWO5fWzKT2dOwb2i+U1B3ftEjAYdlH2LqbOBF9BqnreDxMuXVH4cJSvwtVHZUN03ktL6NSEmioGVthix3Dd9hiEaykxoBYbtt0BEv+nrC/O6ShAHXE6OTXDiwYMF1NGaORHliqchwuX3VispVK8Q7yWPKbhy5vVMn3s78cfahp0dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjKaTsQN/mUIe0jMLq2SYhh+OnrXf+HXY1FRghKTPoU=;
 b=QTMlsO0IgZWkcxAM6SXhBuDy5XiQ+U+rgFRcYDrl6oxHldlbHXf0I4TBYfaWa+rM2+sESEOkIsOrSuzkT3QS+Gq+DDQYuiM25TW7B2FkQNc7B5KHFjxBKGHCGqAA/dltWEbWygYRim75GZaYmGi4IDtw7aLC5854VTYQ7zqH2l8=
Authentication-Results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by BYAPR10MB2630.namprd10.prod.outlook.com (2603:10b6:a02:b1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 21 Apr
 2021 21:29:47 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f%5]) with mapi id 15.20.4065.021; Wed, 21 Apr 2021
 21:29:47 +0000
Subject: Re: [PATCH] block: fix io hung by block throttle
To:     "axboe@kernel.dk" <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>
References: <20210414211830.5720-1-junxiao.bi@oracle.com>
 <20210415041153.577-1-hdanton@sina.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <d5663d72-d939-0fc6-e37b-fdc9c1b39741@oracle.com>
Date:   Wed, 21 Apr 2021 14:28:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <20210415041153.577-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.231.9.254]
X-ClientProxiedBy: SJ0PR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:332::30) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-153-243.vpn.oracle.com (73.231.9.254) by SJ0PR05CA0085.namprd05.prod.outlook.com (2603:10b6:a03:332::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.15 via Frontend Transport; Wed, 21 Apr 2021 21:29:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce0aa76f-7185-4255-18d3-08d9050c96b1
X-MS-TrafficTypeDiagnostic: BYAPR10MB2630:
X-Microsoft-Antispam-PRVS: <BYAPR10MB26303A9CE6CAFA55A9C3F8ABE8479@BYAPR10MB2630.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y7m5Cbtm7FRruwLUS62ud64yz6hUWWjcGzJH5cqd567gnuCR1yzR3mFgESUJfQniU3OUODmmmzu9qIC8odxgxCsemvIypetbMvtV4qzLSUgfOZbza4xnNjbwXzS2ZO5fpAnPHs3D/EPdmgIE994hK64WyF64p04CwS4cEhEsFG3af7Mw9fL29X1qIjYqNilxfwPebZCy3cKbRsBT+8q1vJmhrOWcdUv3HGeLe1qg4jfekuW9+xWaioMd1FWkUy3m5m0AlQ4+ftB3jwwyca1IZb/SSQFxzuFzwNzgoxnCXQbhIFN2lYkTVX1BLpnvpp6xgkuxo0pJUuq5xpBEeeROZE4KrsksVf3bxEZHF6lMkgT65UEmJB+JXtbqtzufJ55T2RCIf7d/KVo8U3w9yy5LQHbIwR2H/YVAvN1FuTNyWKuGMV9aHw5YgA3xLPvsVL7GXrWiekDqTmnkmfv5tfsoCYK8b3axZo+wBdMTBSIqtr426mP4Ni/N5Hrh8TOsB7kllpnq/ccUoWOsOGNc8AP4L3jJxa9rJniWmCG1u3Zw6lgyWmoGsEGEZEhwZI53wUHrcpqG855NuttsxurZ0k5U/8UzMf5aHGA4NvvVOE8BS1u5KnXfQbzVJgELXeYBajZYJfd1m1YVH16rozO/c4uYTpiGomIzlpWA8w08379ZPNxyFmEmPb0v1l7HWNVKMHqL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(346002)(366004)(376002)(86362001)(38100700002)(6916009)(31696002)(44832011)(8676002)(2906002)(31686004)(66556008)(6486002)(4326008)(6666004)(478600001)(83380400001)(66946007)(66476007)(53546011)(7696005)(5660300002)(186003)(8936002)(16526019)(26005)(956004)(2616005)(36756003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?T2xacklicUxhSUlqbVowZ2hZRjZvUEkrZG9NQ0R2WngzRE9xWW1ZOERaMzJm?=
 =?utf-8?B?bDBUTndkUG94TDRhTVQ5VE1BVHhGQXUzMXhDYUoxVmZjK2xNN2VQQTd5UEdF?=
 =?utf-8?B?VDRucmcrYnJ1c2JOUy9Qazh4UUpPY2pxUC9WSmxXQlMxUHdhVkZNUlpVbGxQ?=
 =?utf-8?B?NWpPMmxkcWpPbmJ3Z2ErOEFrMHZEd015U3I1Q2lpdmI1cUdwNjZvZmFkRHFy?=
 =?utf-8?B?ekxLRHZRWFlPTzdFVThCa1FlNWlCSC9ieEcrTWp2b25SdHV3WVlGUlZ2Mk4w?=
 =?utf-8?B?dmpWcGtqaENuNHBCdjdpSitmOTNLRlFWMGNNZHNDRlp0aDNBZTZXN3VmekV6?=
 =?utf-8?B?QWp1MVlUV2pBUzNqUmtHVGYxdXkrckQ2SVBFQURtczNHbkhnOWVWV0tiSW5J?=
 =?utf-8?B?WFJlZnV4RW9ScGFZdHJNb3Ivdnc2OU1IbkhuVjJKWnVPMEVYZDRpUFErakZV?=
 =?utf-8?B?V29jWmF1RzljNHFSNS9DNWpVSmtrUkVoT0Q1cjd5V2tZNWt0STloY3laSXRR?=
 =?utf-8?B?QmttcitZUkhNcm4xbmhxOHpOb3Q2TC9TOUNBbXVXSGRSaTV3Z0UvRTZTVHA1?=
 =?utf-8?B?MTl6L0FsdFJhQUdQaWVIUnBLYlR4S283QllWZEl1Q2NVU0Q5VjF0R2wrNDlY?=
 =?utf-8?B?OVU1dTU3eTh5N2pyZXpPMVFuUTcwTnd6TTNPZGh1bVV0cjg1UmNUa2JlRlJD?=
 =?utf-8?B?S2N4VEZJcnpFelVlVFRrV1N4YnExNUxMM3I3dkw1bFhudXB3TjQ2SnZQaU9y?=
 =?utf-8?B?N1FMcHFXZ2F0SGViWVd1TEJHTnVCaHJSaDBqTCszbWFFWWJ2dWMxTEQ0cWVR?=
 =?utf-8?B?aVhNTTlzbVh4UUVoRHZ3NHZxSEFCRXhqbk1IVlh6QkZ2bVFhemxsTGp4VnlR?=
 =?utf-8?B?cmUxdy9wVkdvZDN6RnpvNGtkUjZWM0JVM3J3ZFFVeWlRYVFLdFFuNGJRSjVM?=
 =?utf-8?B?K1pUZnlJR2Y5K0xKWTVsOWJFR0VPT0JQWStjMm9IRTNuZytIR1FpSEZaZ2JU?=
 =?utf-8?B?T2FJWnNXWDJwRzU5cHZxZ3dtV00rODl2Rmh3WUJXSlcxck14Zkk3NHNaSDdu?=
 =?utf-8?B?M010Tk13ZmFvbk5YT1BadERCNjZ0QjRSbk9KWktkSVR6M2RVUzB4Ti9kUzFw?=
 =?utf-8?B?VFg0bUV3S2R2cTg5VzluTmJ2bThyS1VFclQ3WVU0ODVEOEJneHk2TnpBR3FZ?=
 =?utf-8?B?d3BOK2YrWU9xZ25YalArSHlSMjJTVkdMYWJrNCtxbHRFU3ZUakp2MnN3emFr?=
 =?utf-8?B?ZGVTWnl1bG5KSXBlRWpHNVRTNjNRbTY2QXRDWDVMOFJ0bmI1MWZ1NDdIRFJx?=
 =?utf-8?B?RmJzZTE0Q01XeEdOTjBLZ1I4b0xaYlNPL0dkanRWWTl6cENWNGZnWWNSMFEy?=
 =?utf-8?B?L3V2TTRibzdNUGx1YW1QcVZmYlVqZFRseU8yeHoxNUlGY3dTQklGalR1eFhT?=
 =?utf-8?B?MDY4MldYeFlIWUYzbWcyT25oelBSbkVtZ2ZXRG0zMXkwUVRoM0hhelRTYUx4?=
 =?utf-8?B?L1M4QmZrZGF5Yk1kdjFYd2l6TnN2ZS9NZWRVVzcwVnVtWExOZ0JaV2NpSXdX?=
 =?utf-8?B?K0lOL3g5bjBWZTdHU0VmZEFSMmthcWMxQ3kvTHpuQkFZaXdwZEdiVzBIOVU5?=
 =?utf-8?B?cnByQXhUODVCcWxpUk5HT0NhaThyRG0vUTRUZG1nTVJVdXFOdzhkNTJ3T0NJ?=
 =?utf-8?B?UFEybXJXd29GUHBjVW54ZXBoblBNbnNCQk4xbmh0M2dRYm00LzdGek5NUU1T?=
 =?utf-8?Q?4ZmUfCmoss9NhQU2z88ICSi2nd2O+7l2YnpfP1i?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0aa76f-7185-4255-18d3-08d9050c96b1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 21:29:47.6944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6o667wzVCJmgqVp/E113lCbWdQVokFMI1Gv5uTeHogOLSPIl9WZ3+ymUDrEN1tF5XbuFZFD+n1+ZhdW+dC+x2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2630
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210142
X-Proofpoint-GUID: JNbFyRqXuUxEiZAhig3BhHvZkGAq2Y4c
X-Proofpoint-ORIG-GUID: JNbFyRqXuUxEiZAhig3BhHvZkGAq2Y4c
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210142
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ping? This can cause io hung.

Thanks,

Junxiao.

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
>   	} while (1);
>   	finish_wait(&rqw->wait, &data.wq);
>   }
