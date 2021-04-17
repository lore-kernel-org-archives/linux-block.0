Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7A9C433B4
	for <linux-block@archiver.kernel.org>; Sat, 17 Apr 2021 21:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D74461210
	for <linux-block@archiver.kernel.org>; Sat, 17 Apr 2021 21:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbhDQVj0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 17 Apr 2021 17:39:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42710 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237106AbhDQVjZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Apr 2021 17:39:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13HLTfhn005999;
        Sat, 17 Apr 2021 21:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Od6uj5kDS0gcS8iiB47Xd8v0dBpC65Xep77/dw8+DSA=;
 b=xLKam6R1W0t3Y08u4rtVB/1hvW6Wpv5ZuaA3L3m9dmx1WifRcAbKWM2UNuGXe2+7fDcc
 Q/Uir12fvJtb9LIUIhOObSwyLsVOpr4tl+sm2VDgu3xT0VUYjQm89XEROcUE0/EtzKtU
 C7KtiUtc5Yz4P+vix5AbGrrOuS5XJO5KgiSW57MAVtR7E7vtGZhsdurJdT2fzBjuZKoa
 Ar0yenCc6YwYbNZS42DkZFV75pE7mYZi84TZMuft5I9yTZeO7zHTU43BaPswhpTlojrM
 PFwj9uUu7bnL16SOQxQuoU9fiphfZn4hLgYQTWOqv8C6J/LP0NreahD1d/Qy9YSTz9PH vA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37yqmn8s2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Apr 2021 21:38:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13HLTv4n196324;
        Sat, 17 Apr 2021 21:38:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3020.oracle.com with ESMTP id 37yqg2adh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Apr 2021 21:38:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqXDb76p488Aux8CZtDkY1F9/vUCTcDeY6OJCXPb8xxAC6dKoyb7AVid5skFxvXlmx4vlqbSZOkxlgzPKvM0P9LVn/Xn7KnMYvL+d/3KSqesoLpnC50nSb98YGgQ+IcMi2B1oGHhfDASHsJK61kjGpmOkFnq8t3SYYqpSFZzVZSUvN+0EMJqxMMhD/TBITGQUbyAIPf1uStd/T8f/xm5jGiFdCOsx3mVYsP0bVAsgk3fRvo2jrJEZUZtgtGBglvkTxlJtDna/l7cr06K9phJOgivbhWcCi3Ckx5YlsUWLTWcPKFspRliFQ3uBUac0WFVxLb2QnYHTnhL+a02VaPt4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Od6uj5kDS0gcS8iiB47Xd8v0dBpC65Xep77/dw8+DSA=;
 b=a/8QlZJPHi3uAb751xHwQNbi3XWLA/8pA90Fbmyu4UsFZLrcFQOC3ZHZ98Ud9GVCssn7A8nh/PtYLNFXxikeiM1fkz23yUDz7UjcXEZaqrIzYB+YABl0WQPQ4ieoSQxVnEd4c3iuDkg4Sstyvy9UJ+GMhy7XHkKml3pbtf4zdu5iFTpzQ/m9B2dJycEXLlSg4aqpdejjanmKXElWeGAkGEWxnGzV0IzhWBAKh3I3upgbjFCw+TKgpdhWRO3ktYyO7ucIJHhPSmWJFpQfm0nonZN9BHE/EfzYJt5td3ZIkImRMya90GtJ4W2Z3UCSlD3AmL4lir7hzfalKCJIKCg0Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Od6uj5kDS0gcS8iiB47Xd8v0dBpC65Xep77/dw8+DSA=;
 b=xE9b3tcVTalksCd+8x+XkfC1FPbwibh5+Vcwf4yz9jdpS/HdW1O8g/3zZGRdqivm8jMLlC6YD2fqYnvBL22P7jlW8Kg9PjiievFRBXiiH8tLD4poqOSx3tA0uBljsEi9H+IsHS6NE506YkOEEMH0YjD+gAac5MQzwCq/NcUuInI=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by BYAPR10MB3702.namprd10.prod.outlook.com (2603:10b6:a03:11a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Sat, 17 Apr
 2021 21:38:49 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f%5]) with mapi id 15.20.4042.023; Sat, 17 Apr 2021
 21:38:49 +0000
Subject: Re: [PATCH] block: fix io hung by block throttle
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk
References: <20210414211830.5720-1-junxiao.bi@oracle.com>
 <20210417101008.4132-1-hdanton@sina.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <0f3ffdbe-b893-7ef1-de69-188146b977c2@oracle.com>
Date:   Sat, 17 Apr 2021 14:37:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <20210417101008.4132-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.231.9.254]
X-ClientProxiedBy: BY5PR17CA0062.namprd17.prod.outlook.com
 (2603:10b6:a03:167::39) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Junxiaos-MacBook-Pro.local (73.231.9.254) by BY5PR17CA0062.namprd17.prod.outlook.com (2603:10b6:a03:167::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Sat, 17 Apr 2021 21:38:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1128c74-2904-46c1-ab3f-08d901e92fec
X-MS-TrafficTypeDiagnostic: BYAPR10MB3702:
X-Microsoft-Antispam-PRVS: <BYAPR10MB370237BB1CFAD3B49B3FACF3E84B9@BYAPR10MB3702.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WJChqIpZz7oBGWZr2ILOGki0KPKe3MT/k3+ji6+DtIKRLdyh5TpTT03iPLMhM9A06vchyQz+ZNfKHjX07bBMDf+O0W5JKs3vASiZW66A1E+fQii/OE/8mNYOhA+RFnSzSigSTMUzczNR6am1r7HcqIBo3y6ECx4cnTf2gzUg4rBfmSL/BsFL0JC3zGgzB+JPbwWJQCiI+aTvlawhydwXwo6CvdtblzL/YlnxRMo1JekQSicdwdrruSAxP4R3Vx/QHfcaawAmGht4SCfDeyNyzfgD0E7D7Q1boc0OF6pz94AsRyovZjscHZR3VLiEAy6ZP33W2QTCuzHzBFdmzvgvn7iVt3Z8AB4d5Y1FzSDp64+Sy67vi9PGSR36v8xsdhScnmf2T+rgWY8S0853XVoWMn4NBFJwrDYVUWJNN+E7XVW0K3g4diGn9FDFUu+IdWzp3/xAd8I6GBbk7K+tODg9elQcewp6NOHDhkAKPS8AO/Ui8+J/k31ld+R957mF4hSNPwSrgqD66JfDp2g4KMyvV+L35+cziWv3Xm7IFYXLKMEJbzAr4LoJ1ACtUwswpAsuJn18XrJqUOtD2E0IDBO5nnP8Ei9gzb2n+1QMM1TKwifshL1wZvvSBqx38vC9NuPOsLrjBTfl7Tm06SM5gsCORSia3PPw04y8xvI6ZTrGno6pBeN5WoyHBTkVL5wPxmRh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(376002)(366004)(396003)(5660300002)(6916009)(6512007)(8676002)(6506007)(4326008)(53546011)(8936002)(66556008)(66476007)(31686004)(66946007)(38100700002)(6666004)(31696002)(478600001)(6486002)(36756003)(83380400001)(956004)(44832011)(26005)(16526019)(86362001)(2906002)(186003)(2616005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aURCdXEzejRjV2NhSGVnZmhzWm5DanU0WDAwQ3FNc1NMaWFQbTh2ajNVaVl4?=
 =?utf-8?B?S1JsZmZ1dFNVZm5yamx6S3FabGlxOWt5MXhEMlJTMVFRaHNDeHI3RkJJN0Ew?=
 =?utf-8?B?YVlody9VbHhmUi9lU2tjUllYc2taYTNxTWRHTmRwUTJ4ZkFwOWVOUGtkRXpO?=
 =?utf-8?B?d1FjbFRpb0hoN3ZWZnBoeng4WTNCUFNxK3BNL2ZnRzlFdzRYdjYvS1AyenIx?=
 =?utf-8?B?SElrWWhCS0dFL0VTYmFaUlJpZ0s4a1IrbW5wWmRscGhWY0pGMGZ6UVY1MUZD?=
 =?utf-8?B?dkkyMUcrM2FkOHBPcU5VV0RZTlQrUCtoN2ZRaXR3Vkt2cWkxbzhaMmp6MjRF?=
 =?utf-8?B?bDJ3dkpIakZURDVRanNBMnlrbllxaG5GdndMTTlYaHNGRTdWMkhGNjMrU0Q4?=
 =?utf-8?B?b21yQWRMc3FsaUhhZHBmVUZUcFo5SVc3ZHpvS213dnBPSXArdVJwT0VMY1BS?=
 =?utf-8?B?TUFXd1pyZXVJOGVFVnUvS1VISllMSUtkM3F2RVk1ZTNWYklSZ0tCNmlaMWQw?=
 =?utf-8?B?ZTBXTFBZV3locEZSa0J0eFZabGFqN2dOaXlUaWY4ZVdOTXRqSTdNUmx0Y0l6?=
 =?utf-8?B?SU1mZ2IrQ2R3V29iTENVTXJOR1ZsSGNsbjB3c3pxeGtzNGFmQ2N0WnNqZmM5?=
 =?utf-8?B?a1hTdStncWsrY3UvSFRycS9sZlBLNlhlN1lXMitLMWJwY3dhYTE2QW5vTk00?=
 =?utf-8?B?cUZ0ZWt3V3U2QktsTmJsaWJVSzEycnRaR0JmcmVaajJWMmlleSszeWswM25q?=
 =?utf-8?B?TThzWkF4ZnZ5Z2JZUndTQ3BFblBDelIraDl4MHpiV2wyU3FaV1MwMlRRQ2p5?=
 =?utf-8?B?MnZJcjZTWDM1cnVnNzJTYkZWYWlpMURCR2F3aDJ2T1BCZ3lOTU1aTWM3clY0?=
 =?utf-8?B?QWUxL2crbGw4MHBkZGtkQ1owTVp0bzRCUVhjRmo5NzFMTVpjelVSR2w3MTh0?=
 =?utf-8?B?c0MyNmEyRVdvTERWTjdwZ2Jma1NsQVU0UUg1aXhWS2pGdUhBM05aOEFXd3k3?=
 =?utf-8?B?eHo5citHeTVHdDFDMWlaQXl0NGxiYTF1SWc5dWRmQU50cERhOXJ1dm5pWVFq?=
 =?utf-8?B?MHFrS2ZsejF6RktpTHJzS0xXVUwzQXVySDBaZUFYemhGU0lWNDgxc0hkTndp?=
 =?utf-8?B?bkxUNTR1OXRadVpZMVBzajJ4NTJLbnVUK3p5bXp0ckQwSFBVMkplQXN5MG5F?=
 =?utf-8?B?eVhteDIxaXpPMWdXeTl2L1pZa1V2THBYVGx4N1IwSXh6T0NHM3FOd1lKeU5O?=
 =?utf-8?B?alV6YTJOaEFsc1lyY2VvVEtHVVpNTHk4Z29lSXNyenVHbGZoM01mc2EvRTl5?=
 =?utf-8?B?Q0dFeDY5S3hLSW1sdmVMbGplblZtTWVZelg5R2lOandyK0JIbThicmpPbVJC?=
 =?utf-8?B?TVgzYk9jRDBVRTQxVmk5bGUzMGVUaHRIcXcrNCtjVTUwT1puNUtXNUxMOEhD?=
 =?utf-8?B?SjkyZGFGVDRlYmRseU1LVzdwK1pzeXNRd1dVWWpGdVg3NU9WZW5DZTBOaTZt?=
 =?utf-8?B?QkMzdWdIZFZsUzRqbitXcjRMQmFhR2tyRHU4WmUzL3c4VlhlcFY3YXVrcDJu?=
 =?utf-8?B?MVhwMUVrQ3lJUDlycWprWVBqWS9nYlJCMDJEMW80czVjM2RlMUpXb1dMTnZn?=
 =?utf-8?B?MndUYkNGVXp1dHZqTGFEQU0weGNtMmNDOXhuakZFNTdzOU5VL1BqRGUwQVJh?=
 =?utf-8?B?TUZkaWgrVTNtZnNITU9lNDEraXM4UEN5RnZvV1FzTVJFZjl1WnA4aEpIVUxa?=
 =?utf-8?Q?QADtVzHLNEf5sN4IybE/cUlbxo4Sck+1165rG/S?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1128c74-2904-46c1-ab3f-08d901e92fec
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2021 21:38:49.4106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 988+IBs2U8FgIX8JMqeQ3rkJquwmRg4gDNuM5YBSJEyxy45/oIUTMmVDckcoQOltbbqFcmYuMG9vZ9khBnlr8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3702
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9957 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=929 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104170154
X-Proofpoint-ORIG-GUID: dBJdfzB4Zl2qG05f5g4_NhHTIqaCXdvw
X-Proofpoint-GUID: dBJdfzB4Zl2qG05f5g4_NhHTIqaCXdvw
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9957 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104170154
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/17/21 3:10 AM, Hillf Danton wrote:

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
> Simply removing !has_sleeper is not enough if it is mandatory before
> acquire_inflight_cb() without adding something like a mutex to sieve the
> concurrent sleepers out, see below.
>
>
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -260,19 +260,18 @@ void rq_qos_wait(struct rq_wait *rqw, vo
>   		.cb = acquire_inflight_cb,
>   		.private_data = private_data,
>   	};
> -	bool has_sleeper;
>   
> -	has_sleeper = wq_has_sleeper(&rqw->wait);
> -	if (!has_sleeper && acquire_inflight_cb(rqw, private_data))
> -		return;
> +	mutex_lock(&rqw->mutex);
> +
> +	if (acquire_inflight_cb(rqw, private_data))

This function is to increase atomic variable rq_wait->inflight. What's 
the mutex for?

Thanks,

Junxiao.

> +		goto out;
>   
>   	prepare_to_wait_exclusive(&rqw->wait, &data.wq, TASK_UNINTERRUPTIBLE);
> -	has_sleeper = !wq_has_single_sleeper(&rqw->wait);
>   	do {
>   		/* The memory barrier in set_task_state saves us here. */
>   		if (data.got_token)
>   			break;
> -		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
> +		if (acquire_inflight_cb(rqw, private_data)) {
>   			finish_wait(&rqw->wait, &data.wq);
>   
>   			/*
> @@ -286,10 +285,11 @@ void rq_qos_wait(struct rq_wait *rqw, vo
>   			break;
>   		}
>   		io_schedule();
> -		has_sleeper = true;
>   		set_current_state(TASK_UNINTERRUPTIBLE);
>   	} while (1);
>   	finish_wait(&rqw->wait, &data.wq);
> +out:
> +	mutex_unlock(&rqw->mutex);
>   }
