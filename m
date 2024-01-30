Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3644A823AA
	for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627161; cv=fail; b=hzAemqPuBi9234Sx3wutZtTmx8IHNCBHJfZZ21GMlZORf8snNjyD6Qedeq6+Bjoo0MdCqJ6OxjaMZBXIBg2r0f4ApCPuEZrzgi/UGmwAce62zcs8YJP0RvuUQXaEmTGs/otgIBus/e6oOKon9u/F3/ggU0LbLYqXyQvilljjK7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627161; c=relaxed/simple;
	bh=Ta4eipQ2yAVPmuo8SxIHwq5jP+9LhOzRk+WSn8slZBw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=st5B5mM1XI627eA9PT4wYlEl2p03m4flu4ajUF7XBuv8Yej4TdxrO3PGzOURFKemYvosDw0nFontDfxxUK9AkRLMQH3zGj/LNB7l0UToeL1uG5kdvHPwa6yvVputVOmqckPRzxsVswjV0+/JPY1QvYF/okwXjs48+rxkXKA81AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jtzc7Tqk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=er8OUQ74; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jtzc7Tqk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="er8OUQ74"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40UCA4aS006895;
	Tue, 30 Jan 2024 15:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mWOKow2eljOD0IVUDvgN741whMJ8RugySI390OdwXUU=;
 b=jtzc7Tqku/RWNr6qp4C/1bzTexJPIlgO1RvAhDg9Cw44ZeyhvfoStsDegJ0ZLszD2JgK
 yQx3F+9VLz0dCOqT2VkzbEIPbTI5JncX756CQTD2i8WXB7ZW6JU3EBurm1uNaroeMQhS
 9GXCf7S4JYOWDtmRwLFaN+tqfCJoCp0enAbxNETbQUjNXMh+lgBVxwUxyj6IU6YD26oO
 ubIkxqktKLb4F17sAEhTxQkim9E7BfwVAcaVar5hm5R4SIBULhnXW9foUxxEJtzRWqwg
 1pP85IVZwnfMzgEGTNJIml4lJP5yLsOxfvLBwpff29Je/Hs+KW4Oz/zohB0WvO7NtFN0 +Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrm3y0c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 15:05:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40UE3hAD040271;
	Tue, 30 Jan 2024 15:05:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr97evtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 15:05:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4EwztTqIO10gYZalT6X+H3wt1fGI7AIcePOH/Jaz1x3z/NwG/GMXiezwMjaI4wZIjNV0t4CifwCMZcWgiN/ry2jjl7Vgy4VKK6C6MRTSKv4ptgy3ISgPoKzKctjeC7CMy93JRCAq7fk51FgCed4SblzkLkXRZzw8M4JfRxPS8nEYj9wvhCd3FuHhMW1JJqfILeEXJBndeTqJLsDCVpdV5eYh97nleQUIzjdWaoQanxkrVFp1Vv/hho5PD45222j3v+klllTZgHSBOxEZ7RDWnHJEa2+dnOI5nzqYwH8KxGe/179efdyOXpkcMJ1iqkbuFs0rDqhoONewJUKDROohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWOKow2eljOD0IVUDvgN741whMJ8RugySI390OdwXUU=;
 b=VqqWT51XFUR9QfYJ8ruDYRiyYJOQHnufb2L3QDWWqXsR5Hn+GDTYccdRAjHuaYqhdQSJ/CYwQVy46PbSywPI9rfOdPMbtonfaTIVwpGzvao/vsxU+MmwgyHz4wFY4a8pyORO4Z/x9XzoKNDoVNfhE93XvkAd2PvBD4D7k/HIARKxoBCPgSN6WIjJGz5wHT4sUQfLTh5ycmzjaf8lwbCtuY7c1HjDmlInUS8ISzOiLwqiJdFZ+RtW28KoCBkxzxxqBDymb8iIF7Rdgzk2/KaE+jEjmpJsRTXMUqLNdAG8pABnOr0aBFUsoir/8lCqX4OuCKofspzyjL53zUm3s1CnUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWOKow2eljOD0IVUDvgN741whMJ8RugySI390OdwXUU=;
 b=er8OUQ740ZotvqIB1AKzFnijNoyGIRi/Ck9l6R9j8hgZg/mX+A3t64w1vnnS83UB3sVZ506XGGbCaCEcA6Dnc2S1NlAVBgU8vm+b/7CcPp6dmrZcfOj5Crnk0LdjITYI2JTYMqP9k9fqpXfiYt0meR4wpq71CUYRlsW+4Dbjcoo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV8PR10MB7776.namprd10.prod.outlook.com (2603:10b6:408:1e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 15:05:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:05:21 +0000
Message-ID: <5247c6a8-5afe-46ec-a068-6c20195ee5ff@oracle.com>
Date: Tue, 30 Jan 2024 15:05:17 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] block: add an API to atomically update queue limits
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240128165813.3213508-1-hch@lst.de>
 <20240128165813.3213508-4-hch@lst.de>
 <c489e14c-aea7-4d76-88cd-f60026477c68@oracle.com>
 <20240130144144.GA32125@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240130144144.GA32125@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0139.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV8PR10MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2af081-fe59-4d53-9857-08dc21a4e107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6CXSUSjZfuHlP2b3QMedrUJOYZOTZM626k40fVeUw419WmeiOn+MaHimWGOtBGodimw8ARcxgQOzmEJfyQNw+FGGelp4tgwdm6Cbe4WMe6VEF6FK7aTjqxxCiT5IJ3T+hLnHS0O38zehrfC7xidgN6uBjnHwlUFWdgae2OHthUPuFiwxD+bGmPGaUt/HQfZ51cHBdWfnXZV4x4BaOd18RL+/ghAP+WO64M0uVvKqaLJJeCcoaOwgcI6v2W7TjBycyR9Oj/q5OQem9fkqanZT7W5QbSF6hEhL+6/44+Gn+pVhHNUp3/rtUSZL3576EPeUb9G/wPO61Oup6R34jfUzY//ad/5p38dtLd2iwSV2ymKZmbAVA0Lyxaxm3Zd5h+ZFV3Zgk3CC/pY0aoA/Vl5UOyzkOfc9sPoMVj5GGIvkGqIlpiOFQh1koiuCy7UuOXmI1UZAL61cVvoSlHe0uuWx6X+r+RozmTPPcSY4iCwXQx38Cjk73xJyST5nQKL56pT66s0take3KdHPHdogjM7p6abLJMIsjkClPtRc+Gx/LtJcQCevshVqI+zEYDTelkkxp67ft55eHTyFFHOlz4Ysfeip9bqQ/IytWsmPreibMQMeRjOi8ONRHgAX+1fENLVYUyC8w/pm8K2yDfYjPbo1Xg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66899024)(36916002)(53546011)(6506007)(6512007)(478600001)(6666004)(83380400001)(2616005)(6486002)(4326008)(26005)(8936002)(8676002)(7416002)(54906003)(15650500001)(5660300002)(31696002)(6916009)(316002)(86362001)(66476007)(66946007)(66556008)(4744005)(38100700002)(31686004)(2906002)(36756003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eW5KTWVyb0NxTHdreUE2Yy9Sc3R3Y2k0MUUveWc4N0o5Q1JKRDZCeUZBamd3?=
 =?utf-8?B?NnhzVmJNSXRRMkkyZ2NsSCtIajd1alVOdmk5YnZ6ak1OOHpvV0tMRFRhSzY0?=
 =?utf-8?B?ZFhrZVp2VEtQMkhKT01RT3J1NXpEM2ZmNWpSTVdkNSsyNE05WkUzNVA4V3VZ?=
 =?utf-8?B?LzVKdGZncWg4T0JHRmN1dW84VW5GNldmS0x3N0VneTd2M0dUMU5zbENkQzhn?=
 =?utf-8?B?dkFnUGpNQ0RpWHF2OGpOcUlxQXh1eXhZTHMrWVN6RmlocUhOVktRWE1XN011?=
 =?utf-8?B?NXJZQUlLQjhxQVBVaDBjdHYrNlBYRUNrYVNoc3U0cUpXZW5zVEhPY0QxemNs?=
 =?utf-8?B?YnNpWGZudENqSFpiRy83S2luK056WVpvRU9EOHA4Q3dSZzBzN2VoZVJnLzBH?=
 =?utf-8?B?eTZXK01UTExhTWRDem9LRHRvSVgzdDVES0oyODgvVHphemRYSnJBekRDQWVD?=
 =?utf-8?B?WWNrWXJJWUt6S0FLUHpoQWJLeVZRMThubEpMWVVmWGlpajlqSFNNWmhVNG5n?=
 =?utf-8?B?bVFkWFFhLy9QeFB0SG14Si93SlpGNWhsRnUzNDZyQS9XUnZxVnNRWlJOUHly?=
 =?utf-8?B?bk1QS0ZDSS92YXBmR0pLc0Q3Q0JsWlhIdUJhMzM4QktCSVVwdk8wT041dFlN?=
 =?utf-8?B?Y0l0TVc3Tzg1bjdUWjFma0llaXRPbm1FREs4ZEwybHk3dE5JWGFtMkcweHNQ?=
 =?utf-8?B?dmtXQVZtMDVhYzIxNThCN3FYNW9ZcjlzbWFHK2d6cDlGMStIVWdmdUV3T0Fk?=
 =?utf-8?B?ZnE3aFFsekNUWU9QaHQwd1k3STlZZ043WUh4eVVlYk1lMUlWTVEveENPOTlU?=
 =?utf-8?B?V2ZNLzlPMGlnaWRkK1dzL1FzRlVMeWU5ZWcrMUt4eHlvbkM4Zm9KWG1oV0hC?=
 =?utf-8?B?NXczWFU1N2Y1aVZMUGZRcEU3dFFBc3FueEYvUkRpMEtkMXV5US9pNmVyemQ4?=
 =?utf-8?B?MXlhQlFDdWp4ekN2U001RS9MK3dxb3A4Q0xBVzNkZXdIZHNXeGdIa3ZZU09J?=
 =?utf-8?B?N2IvT1h4WGxrWTdOcURkVHpJWHFEZHgwNkpxNTlNWlNUNnlBN0F3OG92Wm5x?=
 =?utf-8?B?aGZyOEx6RVQyV2pwZVlVdG4raFBySGxQUGhIcHFHWUdnZjJKblNiSEFQdm1m?=
 =?utf-8?B?bmVCa3BjUy9NVVVmbEV4QmloV1REa25STGk3aTR1SGtqMUJEbzQycm9LNmJS?=
 =?utf-8?B?MEtPblVyY0JVWVlNWXhsaWNMbG02bG1TQWoydzlTTVk0R3cvbHg3WjhuK3pN?=
 =?utf-8?B?bE9UYjFzcVdNUzdTKzBjdWxScmsxR3dtWC9OVS9zcmNzMmUxTCtkN0lGOTZI?=
 =?utf-8?B?bTgrT1pLTEZyTExSS0hNSU8wNEoyTDJRS3BMdjVOYUQxL0RHVjNER0hrSHdl?=
 =?utf-8?B?OTZWSHh0NDVzRFBNYmhRelJJdjVIQ2xveHQyM2gwUzBPemF5SGJuRFpCQVBo?=
 =?utf-8?B?ODg5anFuQk50NXd4TzdkNzFOTDh0VXlzNEt2dVlOTkx6eW1DN0xYd0J2TFpt?=
 =?utf-8?B?OHNxTXRiY3VjM3h1Mmt4RndZQlI3bFFIMVh3WUtXTXJPUWxlYlFmQXVsQXRm?=
 =?utf-8?B?b1pGL003dnJmU1ZVek9GUUc2dUFoU2lKNmdMbGJWTHZWVmhnajZOVXRUWkFq?=
 =?utf-8?B?NnlZTUt2MjFyaWlvRCtSbWxjc3dxYlp3eGpLNUgzRkl1NUpTeTcvTldpakNG?=
 =?utf-8?B?dkd0SHljaml4OVFFVmJycHJwV0xTTTBiZncxbUcvaWw1YTRPZHE2d01FT0Fs?=
 =?utf-8?B?N1RZNUkrbmppSWNXS3QyZ0x6VjBEMFRINFZFNFRRRWg5cFA4WXl4Y0FBbDFx?=
 =?utf-8?B?eTlMRFdMNVllOWJTYjVwaktFYkxFekhhQ1F2bGRoa3BkNmxHaXNpUjZuVWo2?=
 =?utf-8?B?UVVpYlc3amx4VCs0Q2NJL1IzQmVCU2w2WTFDTmZrdE92aThFYlNOanhIU0tK?=
 =?utf-8?B?WDN3bkkvUWtVWDJaRkxsOUhxR0dQVk1paURFRUlIL3MwNmd0cElJbTRjemF4?=
 =?utf-8?B?NFlISWxoRUtWbUt4RGlEM2QyVUVUNUM0ZjZQeGVFUm1xazlzMk8veGVpTG9P?=
 =?utf-8?B?Sk9EblkweXN0bERKVitFU0Nha3R1SkoxVklvbTZqMTlDQ2RRb2RmTHhSN0hS?=
 =?utf-8?Q?SO4aio3hXJmNBFBRSVd2OKa2h?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Naq4YZhZ9/dtWJx6PMGOfQr4E80bq+0WKv9F/LM6gou37znrldwr7ofE0nEyd8lfqCeZ2TYHwAyWW1A0nOF457lyLXYJuHmR69x0BtLrfhhuvaWGnIKwS7Zf8V8Pc7ghZEjct/6Wkq30WltBJQ9E3+naMXg2GNY3JuQSm9h3ZLeYiOH53v+qoMm32UE4vm7ELTJ/6iInXLk0CKu1jhX8CP/g6LQqN/2nxIJ9Zm8Ak4HdQY/1lCvG4Dl6VAT0OnRUD9XFeRyOg03GIRZNNs4Lio/wTDSnXhp+NcImiuB4PMkpFDqOytpy9MeDRZTJaneHn8unIY5kn/qF1ickCl87Sgl1Mddqj1Ir+DRpqy57VrapmyJN69UKFsRlj+Cwt9R8xEyzmTRH8XxK0trH84+f9muiAT7PB6IitgdzMOhMbOIE4LGB3YjDLyi07m2OObtaIyK6yl6tgBoJa9mHvKN4Nz2GI39z1k2Vo9eMfeXjF5lxDG6e9lM1q+ljWFdPSdeSrcDpaRbeKdQMxnPoqLTRiDX3FCdeYrzoRQkalTnwLhwnqLU+g/tO5offBO4fTCLGTpop6wuqGbieTmXTehoPqknnhtQV7OpVRfZn0daR9PA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2af081-fe59-4d53-9857-08dc21a4e107
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 15:05:21.5758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JV04Vh1/wI6ixNzia5WZYAah8FOh1l63ZsIABYi24zB9yuST97SLW5M+yKgHc2oA7nGRshEQjb+3M8b7pbJzVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7776
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_07,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300111
X-Proofpoint-GUID: APL-G7O6k0l5xBmjqIS-1JzAqUchlOyN
X-Proofpoint-ORIG-GUID: APL-G7O6k0l5xBmjqIS-1JzAqUchlOyN

On 30/01/2024 14:41, Christoph Hellwig wrote:
>>> +	/*
>>> +	 * The actual max_sectors value is a complex beast and also takes the
>>> +	 * max_dev_sectors value (set by SCSI ULPs) and a user configurable
>>> +	 * value into account.  The ->max_sectors value is always calculated
>>> +	 * from these, so directly setting it won't have any effect.
>>> +	 */
>>> +	max_hw_sectors = min_not_zero(lim->max_hw_sectors,
>>> +				lim->max_dev_sectors);
>> nit: maybe we should use a different variable for this for sake of clarity
> What variable name would work better for you?

Maybe max_dev_sectors. No big deal to keep as is.

> 
>>> +	/*

