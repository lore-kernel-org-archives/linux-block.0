Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572F3C76196
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 16:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjDJQRo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 12:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjDJQRm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 12:17:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2182704
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 09:17:30 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ACexPn012676;
        Mon, 10 Apr 2023 16:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gkiwdmTtyu9no4XPpmfBFi+4KITI7INrRjczRVoY6es=;
 b=WuuZR+uVuSVzfTHYYY7Nd/F0xA11VLiLmsqIgKa27fB2UrI6walHqP8wR56Qm0TjxHu1
 4KTYJ2lQQWB+5lCecLaps/VVhLkxjitpXzzoKFzDo5Tn/rI9OKZQGlU1rNSeJG3/C9Au
 YtoQQJJnWsqzTF7MOOiV6fWX8/nG6bTHT/N/CyKjNzOuAHZKUSVZx8bY8ysPGHjjBQUC
 pKEEbk5pGlJlrFV5wjMNNh2t36ihRiwqQrAHVcv1WCPFb+B4lY5xW3sDj+MhWBUexYKO
 pWx4ioxdTvPoEAKJcS3YacVUcYW6np+cGkyv93BU+F/d0g503uxao/1b2ZqzzHtI7+2H ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0ttk7f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 16:17:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33AFsTnu001746;
        Mon, 10 Apr 2023 16:17:19 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwe5e2nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 16:17:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvH5RYROg754hs3tCBtCaA420uWp5s+F+aMN/Nz9BgGCv83BlH2zI1ac6dKgXGfBjZKaOJmIsCx9VAgrHCW9GCiuY72CD+doG1wjRer10A4gLhBu6UcImqN5QOmgRFViHlwD3/YL+Ik05Y/d9ALaMGLmdSMVhFdNyfitiHeCJsAvwKlwnoNv3g+PB3L1gm1hN1dzC9rnUFjhnDLh6c7wgzbu49PRWHYryWf8OMXvTIOnMJDMLZ7zKEsqAqQ1W5X7fvOPYXrL8uQsSIvZG1gx5AyIMBziV9lAj/ffew4J4xd+Cj/IcGv2CzuPvCXMXw/2SNbRwSzMemGsrczjeNKtKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkiwdmTtyu9no4XPpmfBFi+4KITI7INrRjczRVoY6es=;
 b=UVdZoyqrDjvdZKa94EpIA4u4C2V6hWVb2qX9g1MYaxQpq9gRgBj2jnGcnP9IGOIZxUybgM2uTg6YYxyagLyyMWFeULpGr9WyrVnST1jCz6d0EKalgsBU1v5J5QEAnkJXj2XvbMYD4ZDTjdbRk1BlaxCcBzpoU4NiDXOm8802VZTvKW/wZSTkEvntRQUPGaQ/NBwyZ/KxxWF6SHMiVyyQUcisv9X98qTlLm7VnS8SifAFurHrR+FY9ojT2sw0d01+OHpRVybf0SBzP/HffZU5C8l2Q5comeqoS0g8KjBt7xEj8gXy3pI/54342tvtFjOJq2Ba15TqgYFeUen+FGKgRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkiwdmTtyu9no4XPpmfBFi+4KITI7INrRjczRVoY6es=;
 b=fMa+WMSJZZX93GIAbfBKUYlujDHj9KjXsN9tlZqssDtQfD5duGQlUD19XkaNQwELM011MJtdAdFgpIYexnCpwtmqQOup266tNZX3sR5hAlqzw3alGfmCcBoUkxxf7Q1WrfZ+GXPFFgNEXe0iFu+KDwRtH6u6kfLciA/2/C0K1To=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by CYYPR10MB7571.namprd10.prod.outlook.com (2603:10b6:930:cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 16:17:17 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::e206:6854:c7ed:225c]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::e206:6854:c7ed:225c%6]) with mapi id 15.20.6277.038; Mon, 10 Apr 2023
 16:17:17 +0000
Message-ID: <0956aee1-5b35-79a5-0ceb-fe6263bc39e2@oracle.com>
Date:   Mon, 10 Apr 2023 09:17:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: blktests nvme/039 failure
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <5vnpdeocos6k4nmh6ewh7ltqz7b6wuemzcmqflfkybejssewkh@edtqm3t4w3zv>
From:   alan.adamson@oracle.com
In-Reply-To: <5vnpdeocos6k4nmh6ewh7ltqz7b6wuemzcmqflfkybejssewkh@edtqm3t4w3zv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0501.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::20) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|CYYPR10MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: 29019eec-a890-41d0-8e87-08db39df0d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4RgbOrs5TE2CbiiSZK/zA+XFoBHQ2lCUGk9FHyLNLSCmx6eb+y/FKYeS57RcP/ieCAMMDQex8U843J8D9M8u/NYN0i9u6hfulpMKhHXeePOa2u1mHohslRbxVso11bVw1dFi0b+O9y4HRAJXdB2Be1v4sP0QaZc2j0zj8deGh8WTAOT8GFhOVOJidbcNh2tzSXQYwPhnJKj2viOKiW2+11iubWIEe3S3sY3T5xJ8wxgkr1R8LtuPgtUyxhpASytoFQAnIMnjdb0FcrJMyRFGF+iMCbee3SFFwbHQMjNvoRhnN/Z3pH6i9qLV7DfAIgmSJEMraK/t7Uo7+pV3RHrkA2DOOTNKtNNaSYrmQS0jycJwDGHCh9cROwzPxefaZpvoS9QImLmcUEHTSADglAgNYo4lFnaeFImjsovTDIZpLgY00dLoB+obNta1mGPJnu2kPgdHqvIUcli2Xm/yWVQ4ezZkHoeVoJ7H0f3cxWX6C9z06V+Ngp7OctURLlk1Ak8qel3oPolChKQESzKo29ke2WBxG7olq5+lgGIVXw2LEx7Y8JrhuPlv/wOH959WatySfvE2a0Aw8mdx1f9FmRDQf3oh3koxCLFGR1uCh5MbXnFKnPCyRoISEoa3R2DY0NCp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199021)(31686004)(6486002)(66946007)(478600001)(66476007)(66556008)(8676002)(41300700001)(316002)(86362001)(31696002)(36756003)(83380400001)(2616005)(26005)(9686003)(6512007)(6506007)(53546011)(6666004)(8936002)(5660300002)(2906002)(38100700002)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0dhaTR3ZGI4dm51RjRrS0gzaTF3eGFTRWRTQkl4bUxNUFZFWGJDZXVvUENz?=
 =?utf-8?B?R0hvQ0pLeDVEOHJNajJIVXZhOVA5MGw4MGdHQ3ZzMFM2SkJGR2FVZ1pVTHJx?=
 =?utf-8?B?cndRMEVlRjBWd1ZQc0tBbk5sSjRDZysyU2JvelJaZnY3MjViYjNTZlpHNEJl?=
 =?utf-8?B?b3dnWnBUdHhkYXBPalYvMklERDZveHNOVktwemFpWFQ1OVgwTDlaZWRSc1pS?=
 =?utf-8?B?bisrSG1lWnJ1K3JqS0c3a0h5OTlBcTNkaDl6ZzlaQXNlTEcxd3JCcWZrYU1y?=
 =?utf-8?B?Q1B1SjNPV0w4ckxlTHBPTkQ1Vm5BUjlqNSs4YW9rN011TGUvWlUzR0tsWVVn?=
 =?utf-8?B?b3Ztby9QZEN4N0J1V3F6cFZTUFV5STFCRmtWZ3c0ZWp6bnl3QUNjUStQcG4r?=
 =?utf-8?B?TlJvbHpEWnhrOWNXVnAweStnVG1ub1ZVOUN5VmZ3OENvTUY0bU5HRlNURml4?=
 =?utf-8?B?dnNvTnZ0cm9Va01vbmNOb3NOQ0ZIYWVXdnVOWjhBb29wR0QvczVHWm5OQk93?=
 =?utf-8?B?S3dvU3J0QkVqZmMrcDZnZUxwVVlKNmpxd0UwZWtnbXlrSkY4SE4wTURoUDFv?=
 =?utf-8?B?VFpnRlRicWZDYlBkclV0bFdzZkMwWjhFWXFabzN0UHhaNWs2VVlJWk5kSDdR?=
 =?utf-8?B?bWFwRXo4bWdUd3B3RDhadVlNR2w3RjJmVnA1RVAxT1dzdXF3V1NxTlBvZktS?=
 =?utf-8?B?LzVZdTV4UTVQc0owQ0pibnhaZktEZFhCU0R1ZjlUQ3c4Z0xWK21yK0srTXo3?=
 =?utf-8?B?N3JnMGNuU0NGSTZYUWV0VGRHNHduNTZyMWQyaTZCbWN6aCswVXdZSTRYOUk3?=
 =?utf-8?B?aVpIZXdpRkJsNXQ1NFFUNWQrTEs2RTh4ZWd6YTNNZ1E5WTJ3ZncrbDkxbnVm?=
 =?utf-8?B?NXBkM3AramErR3ZRQlk0ZjJYdWdGRDZmSzhjRWFJcDQxT0E2eGNKYm9pS284?=
 =?utf-8?B?MDFReEd4Q2pzdnUrN2FqSUlKNXVrUkcrdVdIeEVudkYzWDhCOHZoeXdCeHpS?=
 =?utf-8?B?elc2dThmbnJ2T3JnRmtyQWVieXQzY1RwK2NyRi9RMGU1MTlGN3ZuRmVmRVE5?=
 =?utf-8?B?NTRGNXdHbWp2NU5kenVCeUhIZDVDNWlCWFNNNzB5RE4zZ0NPZmxpOEdkWjB6?=
 =?utf-8?B?OGF4UDhWK0YvNUJEMk42VUsxaTEzYzQ0QzdBZXNTQnhKVU5VME1jamhXWStS?=
 =?utf-8?B?K2dUS2NQSk0zWDFQckFROTZuak8wR2c4N3JOek9KK3JtQkZKL1Zpa1Vwc25i?=
 =?utf-8?B?ZDYvSW96Vmd1OUhlblFLcGNieExNS1AwV3RZUWZyaGZFQVRTaXVtbG53ZU5D?=
 =?utf-8?B?SVBEc2R5QklSSnU1R0JDcWdHSEFnRnF1bTRVRy9jdUg1cWgyVVE1bW01WHNw?=
 =?utf-8?B?YVI2YmJzd0pHaEsvRVBERVJHWTYxM1RpeGhJKzdmcjAxVU0xQ01odVZhV0Vi?=
 =?utf-8?B?Mm9UdlgydFpVeGRlOGNrcmtZK2pUSXQ3eUFublFkdjVVWGgxMXc4cFdyVVNy?=
 =?utf-8?B?UmZsWkZKek1aSWRlbnRuSktOMnF1UnZBYmhDSnVZWGlMOHRyMEwvUTBORUx3?=
 =?utf-8?B?am1qTmlacURmVFo0OG5FamhwZ25JQ0xDRnhHcWJjZ3hERmpDZTI1WVNreUs3?=
 =?utf-8?B?THQzTFZtYlVEem9EaFVIWDR4SmZib2pZZFpTOUx4MHVqQUd5S1drZTJrMlYx?=
 =?utf-8?B?VTNjK0xjRjVUQjNPaHZwZXdxTDRiZnU5UG1FY1BtL2VoVUxrdmU5a0pYV1Ny?=
 =?utf-8?B?c0h5Tnk1VGRtdlVyVUhJMDY1cmxwNEFpLzdOWExXR2FDQ3Q2TEZtRlJmb1F6?=
 =?utf-8?B?R3R5bHhFeGM5a1VZUzA2VVVGUitZWmZUSkFRODNZRXNWcElVNjBGT3ZSZ09S?=
 =?utf-8?B?dUhCZ3FUczg0QWpXNHJnUVNYYnlaTG0xeXNXOEl1RE9hNzhBc3BDaFZxZE9p?=
 =?utf-8?B?ZHJiM08wL0YrUlpVTEYwWXdzZHE1dVorNGk5UjlIcDkvZnVmRlRwRXBwVFV3?=
 =?utf-8?B?aGVidXJudnlPbVc2UDBDNVdBcTVUUWhTOVh0S2VmdjB1WHY4aHlVdXZjTWNO?=
 =?utf-8?B?U1lFcmJoL2MyUEtHSUV0V3duZER5K0lHVkdjcjBMNEU4RWNvQlNrMlNtRVh4?=
 =?utf-8?Q?xjqSmGJzG7XCQEox4cxqMEG8/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CCNxuvlHFLIoHMQKZSyUmedr8qHa3A7L8MnIdgWj3C+L0tm42S04DIUMitmlciddemyQqFqYRAQ3SAgnsLPqC6hNseCewJwAVZ6ZkyiNzVDHbqokvCZEcoPkausEoW8tte11i4n2NjaYTQ3mV8jChO133QZnP9I7qEMI4d7ZLrpUxUul/DR2Feh1aIYhH/RQdJMj27h80wE6ZoQEt945TmmLw0WDoVvoPJvMB+Z45e0slEwIWRCenWCC/kzgID9Ou4RHkWCz39LO5649wyB0Q/pqe9FMUi0motKb1QYT2rKc7RKNG84TNdDyAAx0Tv6pXCUWSHmqS+Gq9EW04lwmkij5aSBeWHSnqBFyWc7FJf3eJQ5+HL2pHeWuVFWikfQhH1B7ls2N5Zis44qvMkf3A8Rph4Nsf7N4VUKatHkwftJ2qroXstaJi5CITw5FHHAwJXInD5EYxzprkLAYULz4Aklpqrmwl1wrCsJwpuyxGMjPsiIOFbUeUL5YYwjGCWgNwa9canhX/sEZJWFfoBv2srvBCRcEWv4WRDwJ9HjYSEQaNURe7NblP5/kHiuM4ZiUwgIQQh8E1VqRGA4mi5WGxa5GWMzCywY3zvFTTcQX3gkjOGbv/A+frgYlw8jXNzJ3Pr+XMy32Ytpv0vuJw+OxHYLxpUHSEIixsQtRytZRYP9POcx3EEjJCgXqr4xkNK6iAHuRdA5x3bOg7zMoGiTPxceKa0dDJUuwkax6G+b0zv8cxVnIfOCXipruGpOi0DfjVYgJkiqEg3SBKqZIpI2FOFZo8h6nB+0UEOjy+z0P30yIBr5WWa0FgCpywyzNLfVxIG5jpf6ZyIvOlk/MM6dkbUr/Hk3j8yfP7X9iD+8Gk9c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29019eec-a890-41d0-8e87-08db39df0d3e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 16:17:16.9478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9tVuhAWpgS9Zd6tHSnbeQTPbR16YI6mOJwYL734daRu/JNQsfIidEzplaqpdeDDSoAW/xz98Mwb3bHM9KBwZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7571
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100139
X-Proofpoint-ORIG-GUID: N3p13jacKaMVE003OUpJIKhjc3_z7bQI
X-Proofpoint-GUID: N3p13jacKaMVE003OUpJIKhjc3_z7bQI
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/10/23 4:49 AM, Shin'ichiro Kawasaki wrote:

> Hello Alan,
>
> I noticed that recently nvme/039 fails on my system occasionally (around 40%).
> The failure messages are as follows:
>
> nvme/039 => nvme0n1 (test error logging)                     [failed]
>      runtime  0.176s  ...  0.167s
>      --- tests/nvme/039.out      2023-04-06 10:11:07.925670528 +0900
>      +++ /home/shin/Blktests/blktests/results/nvme0n1/nvme/039.out.bad   2023-04-10 20:15:07.679538017 +0900
>      @@ -1,5 +1,2 @@
>       Running nvme/039
>      - Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR
>      - Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR
>      - Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR
>       Test complete
>
> nvme/039 => nvme0n1 (test error logging)                     [failed]
>      runtime  0.167s  ...  0.199s
>      --- tests/nvme/039.out      2023-04-06 10:11:07.925670528 +0900
>      +++ /home/shin/Blktests/blktests/results/nvme0n1/nvme/039.out.bad   2023-04-10 20:15:09.114539650 +0900
>      @@ -1,5 +1,4 @@
>       Running nvme/039
>      - Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR
>        Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR
>        Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR
>       Test complete
>
> It looks that expected error messages were not reported.
>
> I suspect that the time duration is too short between error injection enable
> and I/O to trigger the error. With the one line change below to add wait after
> the error injection enable, the failures disappear. Do you think such wait is
> the valid fix?

I saw the same thing Friday evening. Let me take a look.


Alan



>
>   tests/nvme/rc | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 210a82a..7043c23 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -652,6 +652,7 @@ _nvme_enable_err_inject()
>           echo "$4" > /sys/kernel/debug/"$1"/fault_inject/dont_retry
>           echo "$5" > /sys/kernel/debug/"$1"/fault_inject/status
>           echo "$6" > /sys/kernel/debug/"$1"/fault_inject/times
> +	sleep 0.1
>   }
>   
>   _nvme_disable_err_inject()
