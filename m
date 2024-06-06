Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010001.outbound.protection.outlook.com [52.101.128.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472B13C833;
	Thu,  6 Jun 2024 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665630; cv=fail; b=uKshnO8fIeYdT8opPeSVzSvdUdKAyEP85f/WZqmth9+YUJ6VLozmGoeYVri3hWCF6bH72Koqex2bOsSwXOHf8OBaTHG0cT/KtkJuRnTQDCfYbAy8ntztU1XY9WiHwlRbEqfW6ARv6n207TnzKeogMt5lWWp2xeqU+gvYS6lwJYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665630; c=relaxed/simple;
	bh=ruOesDVo3AawTtihxisJnxS6qG9ZBLHGoP5I5hSvong=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ozslZ2dXa+LgrlDNJ74YU+6F/c70o5i5Z/+YhKA48WvmXHVyPofnodS3mssc91MISzcMHtBl4bgwyRxb47ItmMRmhOVG1Ey1inQfsAzgyKxcQXZ7TZ9mNu72kxVWVoFqenrLQ3CySvMdzqRVTedZBSVBEpJcSamrCGNdqDGBrPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=C+KlBAlx; arc=fail smtp.client-ip=52.101.128.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="C+KlBAlx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvEje3Lp5ckZ1Sesevw9VCnl4kQL73si3xOMr//Wc+8qrwh2qVWErb1SFb4WcWWLgYmtmOcyt2QEMzoa+a+ae1uR4bKVrKrMK3nx5xm8MStczFY1odtgGDrLnb9lkiVn70HPvi5NM0zN4VX05xTmaf7GRG07ofOY1r6IHW6/OyDl9spoHpTm3jDL1wpaDr+zB3fWfPbDT1FhJgmMZaPxSp8vCGgtw4ilBSZYmxOinhXJ+SP2Az0K+erhRfNaTY3IvnHJdoJR5d7UK7J4WxUM3PEc1hIVi+FTLbZop3npyFIvTvgh3VAZcq+S7MzY5mn/NFs91VUVwPpcrWEHsicimw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uDRc+VNKJ7yXgFmYT1HDOtdAFkbe/1qIOX/z69UTok=;
 b=FDWdGbnwv9cxDW/kke8Tt1Tf5OWkMpPZUabtdOCIfdUuzAHoVqLVZSuzk2QlFlKpKYP2PHGha9kB+SHevO8BiM6non6vmqTwXIC6nUT3s+pcXDR3AsI66bWMwLqXwgHbKjbGWzDA7JBC2+ympdFMgYy16oLOSfdabKhCjME5rxjdby0AtzPmHYPt8yTcKz6RhUIFMdcbABC0EeCfCiJ3YR/n1nGekUcG6Rc3jDnYKxZpJTHPTpaIWelAqFtYNy7TiSr2cj040+hRgpvi6uTdV8nFgfUmd9Si8n0SEmNIdy175N1B01z/QGHqFrBa8YPZsaXAU4GaijBkGh5H7UzQAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uDRc+VNKJ7yXgFmYT1HDOtdAFkbe/1qIOX/z69UTok=;
 b=C+KlBAlx0ZQVDJouX9oe9dKHd9gum1uqHcedwJRb8Od0o3MiEc5r1RybgPJ0mG8YQUBSfvBK76qLFZX+DqgVV7M0YRMcmlgUVa95AUoeOe9altF7OdvO4isfYsdz6rV+8im/dBgfqlQ9Y9Qj/GBDQZ0hXjWHaS+Ut8CbT92imwASWbXW3gzH3+HnuikB7SGTXmXrwlsK/q5R6a4K0gmtNYitrncfL2VNivcPPkre54btU2+ueCm5/TircqhKqOHWq/T4fW+3gWo+to6AWYfuE70uJj4gA9vRjW0jqPar2fs21mAeUdpgWf5EjOpmjweHoAj9KMsqisuGVbUu72g8eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by TYZPR06MB7172.apcprd06.prod.outlook.com (2603:1096:405:b3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 09:20:24 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 09:20:24 +0000
Message-ID: <477a2cb7-bd93-4f1c-a10e-ae7585425a02@vivo.com>
Date: Thu, 6 Jun 2024 17:20:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>,
 Yu Kuai <yukuai1@huaweicloud.com>
References: <20240604031124.2261-1-yang.yang@vivo.com>
 <CAFj5m9KV7OJ4_KjbSkpdtfrKamoLzV6EH-mJP3=y+VvoYOzC3w@mail.gmail.com>
 <aa7246f9-f7df-3054-077e-eb21c7f423ac@huaweicloud.com>
 <ZmEpIBL2Ot5cwRyv@fedora> <bebf237c-1223-43e9-93f1-10a32c4923af@vivo.com>
 <ZmF7JsJYlUmp5xTj@fedora>
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <ZmF7JsJYlUmp5xTj@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0127.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::12) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|TYZPR06MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f1aaa2-0114-41b8-20f3-08dc8609e545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eURJbmdzK09qM3BVOEtnbjdoQlFWcTVVdExKYjdRUDNMdDM3M0I2dGpRMkxZ?=
 =?utf-8?B?QVZFQ1BENEx6Z0tsVzFyVkZyRERRcFMvVWpMamlwOVpKTDhDdWZGelVEZVpt?=
 =?utf-8?B?NkNUaDVGYU1weVhWeUJKZmNSRzRjcFg4NytXVHRiQ2FOQ0xtYis1bm5hRVUy?=
 =?utf-8?B?L3ZXYng5eU5YeXFiSXFwcnduSDk2L2FYM1dINzgvaHBVbFJ2dkllRU1JTzFq?=
 =?utf-8?B?bWhmbHlMOWYrNmFQTFNSOXdSQjkzNCszQ0ZUd3NBaUJEaFk4Z0dvc2JVVksr?=
 =?utf-8?B?c0hmN0FBRHgyT21GdUVUQTAzLzFPQW8wdWZuZ0J3RHVoemMxSXdDVFlESElY?=
 =?utf-8?B?SGpoVXZodUdKZTl5MEZSamJEckJKTWJXNlh6S28rZ1VzaDlZL1ZNc0oySXhy?=
 =?utf-8?B?b0ZSMTM0OFkxSlVaNlpEMVpFeE1JNmZMdFF2aXl4Yzc4VkV4MU1QS1FGbnZM?=
 =?utf-8?B?WUovdWsxcERLNmsxandOMVJvL0hSdzZWdHhVcW1XeFVZMitkcTJQazUySXYr?=
 =?utf-8?B?M3FINStzbkRrdnpJZmZ1cXdkOE83YjJWOEpNazlqYXR6VkFPYk1uODNOWU1U?=
 =?utf-8?B?UG5PTmhadmt6MXdVQ09oWVJSWHQ2enN4TmlCU0N1Z3R6S3lwS245VG1ISk9m?=
 =?utf-8?B?QVZLcit2UTFLMDN4akVmSmlnSkpTODNGSVhxclVoQjJYTXdjYXVKMGExb05w?=
 =?utf-8?B?M3paTXBXQmNiYUlQZTBKM29DeGJCMGsvc0ZCRklrZUc5eDltUmpWUmRhVk1j?=
 =?utf-8?B?M3FiZ2JFclhYRlNkRGZwemFXbU1YNUNMK0RlL3FkV0JKVjFEakgveUF0eU9M?=
 =?utf-8?B?WXZUc2pXWWhNY1c4Z3B4azVsb3NYb2llTGhHL0YvdjM1SGZsaWFYd3N2NEpn?=
 =?utf-8?B?VTNjTi8wVHUxWUJ2dGJuamVKR3FDOG9SdFYyQzYxQ0R1WGtjK3VyU2VNb3VU?=
 =?utf-8?B?emYvT3lzRGt3ckR4THhzeXZXN1VOakxXbXBMRk9rdVE2KzJxS25OaGg3eUIx?=
 =?utf-8?B?RDNCV3pjMjB3T2MvYzUvd1NKdDlydjVMcGpvN2VwUm9jR2xSSzRhRGZqK09I?=
 =?utf-8?B?YXBpY0xnZUsyWnIwMk5iRHJhcnhhc0c3N1JINk5mb2FGQWh5eERZOHAwTnU5?=
 =?utf-8?B?NU85YlpJclQvMXpnRGtYK1ZXa0wrUjZmVDNHd1ZtZTB5aSs4bjI4bVVKdFlD?=
 =?utf-8?B?WVhGWFU4Zk1zUW1MVm81d3hYMGdMbDF0bk8zMlVPSnN3OURKMWNISnR2NzJl?=
 =?utf-8?B?NTd3ODdyQndYbmRTMC8xTlpoS0w0YkVtOTU4M2NjbXNWZkMwTG5XVjVId3Jw?=
 =?utf-8?B?Tm1GdFV3VnlUV01vRDVxZjBDeUVmQlU2aXlORzJjTmZzY2ZTUWFOMmY2elN2?=
 =?utf-8?B?c3hrQzdlcVZYOUZ4QjR5eTdWaVdRZEs4Q3VuSGVJZGYzalkvSS8yMnp3YXlT?=
 =?utf-8?B?VGI1Q29oSTlDU216eDhzc2lKM3B0VWVwZG0yaWlCRXIwbU82MFQ3L2UvVis5?=
 =?utf-8?B?SW15Z0ZXdC9iUFQzVGh5NitMVU00TFZpQ3NwOXFhc2ZjVE1HREMwc3ZpYTBo?=
 =?utf-8?B?My9USFpicWNjZXBDTnlnRTR2QVF5L0FPSU9SQi9ETllWa1pJMGM2Mk1tZXJC?=
 =?utf-8?B?SThoMG1HZldtcnFUWEJzWUVlWW8rbnRwTnpZS25CMVZNdDdNWlYwVGdCZ3kz?=
 =?utf-8?B?bkg0QjJ6NHRFMlRVRFlpcUFWMnFuUHh2eUp4OE41aWdtdklTcUN4SUhOMkxt?=
 =?utf-8?Q?tfV1p/6SsgqZ5TCjcxVxNtMybPQDh4iaXJkZwUL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ny81Uk1PdlVHT0RSVDlyMGJMenJvcU50M3BZMk1HVGRwTTVyd0RvaWpHT2U1?=
 =?utf-8?B?SEdBZ0hKcW9jeEwxbGxtaVNYMzZuMWRGUmRseXlDcUJ5cFBTNlEyc3FCYXlz?=
 =?utf-8?B?S2tDQnlaS2VNVjExQXVNNVdHdFY5Q2wrOVNKMFpXUW4xTTZFNHZhQ0xiNGlG?=
 =?utf-8?B?c1RJYzVXc2hqbXlIdS9mcEV3UnZtL1BSRkxLanNzaGlOdE5BYURVSENVeDhh?=
 =?utf-8?B?ekZBcUdiWWdvYVpaQ3hOMFpEdG1YRituMXg1VmtyMEllWkY3dEExWkJrUzBm?=
 =?utf-8?B?OERFalJOT2M1VnpjcmcxVTh5VFZUQmhiZlZMQzN1UFBOOWMxRkR2KzBKL0t2?=
 =?utf-8?B?OWJScHNmYnFGQTgrQnRLaWo3Q29uOVhXVUJBYnlsUWZkNmw1ZzJVWUZxdnhN?=
 =?utf-8?B?R05BNHpMblI5LzJ4clBaQ08vbEtTb1czampPelFLQWYrSnZWR29aTkMxeWgw?=
 =?utf-8?B?SldOZTdjSExkTWxaMXV5ZEdFVUtwVUxaZkxmNzd0V2dNTDVIZlNyK3VnUm5I?=
 =?utf-8?B?THg2WEt0TGtvUW9kU2Q1c1l2eHBZWTlWd01wT2JzaGUyelE4YXdDSXJ2aFB0?=
 =?utf-8?B?QkhrQmlkOWdlaWlzSmRVS1RZRHZ1YzllcWF2Z0hJaWx3dEJ4V2tHWHFrYmxj?=
 =?utf-8?B?UDVveEhjeWhBZncvb1FaTjcvclNPeWJhR042R0l4am12UVp3L29WRTRpVEF4?=
 =?utf-8?B?bTZIQVNKVm1LVXN5NDZUeHBKQm1Rck9EWXdzdTlhS3Nxakd1eWZlYjducGc1?=
 =?utf-8?B?cW43ZDRGVC9wUEgyREx5MUMxL2dySzg4Y0ZxY0NHUVZMenBUbmU2UnBkbGlS?=
 =?utf-8?B?NE9FYkQrRmltMXFBd1IrMnJyUmVZVzRHN3JyOUFWd3RPcVJlbFZ0YW85UW9s?=
 =?utf-8?B?OWVhRVV1NUVlTTY2dHJlcDF0dVlteGxhem1EOTlVeS9RMWVQcTk5aFBBSTZ3?=
 =?utf-8?B?b0JoNjNSQWRLczZXWVJ2NjE1dGNJVEsrWTd5RnZrdVp0U0Y2eVFFMjV5Nzlr?=
 =?utf-8?B?RXFGblMvTU1PRnNrbUVacU1oYnpmc2FpR2lrbnNlblo3Vjd5ejVwUldhY016?=
 =?utf-8?B?Y0JJUE9JMkErTGpFZ2tWYTEzQTVDZ1JUQ0I0Rm9VVnlxZGM1eElSWEJkUGRR?=
 =?utf-8?B?N0ZNaU91NGtxaTBPMVVmMTQwNE5UWGlPZzNJTUFJaDNmczZkMDFzUllCMXdD?=
 =?utf-8?B?VTdWNHJyNDFsSXB6OEErZGZOemg0ZUR2VWhJZ1lxazhqaDNYS2ZiWGwxUkdW?=
 =?utf-8?B?aHZFYzdDMmhPSXRtYXhYRlBlSG9XL0pNS0pHRTc0Q25rRGNuNnlPb29hUFZO?=
 =?utf-8?B?cDJMME9lUVovUXRlelRWelpUUHlGY3Njc0g5cmlPM3BaMlFZcnJEOWlrS09m?=
 =?utf-8?B?Uy9sQWRBQnI5YzZva3dwcEZKNm5pKzJCRmtxVWIzNEM1eGwvdzB1MEtCU2Iy?=
 =?utf-8?B?OWJuZFNiN3U0Y0gyMVZRS0ppT2w4QytRT1FUMDRqOXlMZnladDdQa3Z6R0c1?=
 =?utf-8?B?OE44YTV1anBZYWhrQUZHRVdVMTBDdkpRbkttd2FTZVBISFUvdlV5KzcxUG9Y?=
 =?utf-8?B?ek9CMVRpZkROWmxZSXZaRStod0tqb3k2Yk9vSmJReXluUXF1Q0tzcFRjdDY0?=
 =?utf-8?B?enVYUXJVUThYazBZOEVsb1hYZ1Vodk5NQXZMMjJ6VzA0WnlXTks5dENNRlhN?=
 =?utf-8?B?QWs4eERDM1FlZkJqZHJTU1N4Tyt1eVErK2FFNmkrU0Qra2NTQmtvOUpNZzJB?=
 =?utf-8?B?U2NIVUpraUZIQVdkTm9BWVd3cTZDYmZWOFFUK1oxcWJlWVVCRjlEVXNCcCtq?=
 =?utf-8?B?WGxGb1l2TGpQZlhOcm1IMXdpRWJpYlhTTjF2SENJU3FUblFZMHgvYjRMVXM1?=
 =?utf-8?B?L2pxQlNMUjJnOGFCQjZpZ3JyWGNoUjNRTHBKaTFZczF2Tlgzd2tHS0JQTFND?=
 =?utf-8?B?c0Q4czFOV1BscGJBRUd0MmVPbE9pemJWdHczbFo2MjRJMXZMUlVqb281Ulpi?=
 =?utf-8?B?bmNwUXpzVjRRY2FzNTFmaGluRW1xMk9vaXdpNk4ycmFiWmh3R09qRzQzQy84?=
 =?utf-8?B?aGFQaVJhaWtmL3Y2bWxXUFVoZVp2OGJpWUU0dGVEMElrM3RHbzN6RkJSOS9s?=
 =?utf-8?Q?UhmUF23MYAJ1va01U4qFDfnNw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f1aaa2-0114-41b8-20f3-08dc8609e545
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 09:20:24.0502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8l5Qt6w6QYqwraRK45yc+oYcbybpPnLWamplaHBXVkeXWl0cAfqEFEQYRNL5wi7I0tI5Hh4MN53MkcIvKqD/UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7172

On 2024/6/6 17:02, Ming Lei wrote:
> On Thu, Jun 06, 2024 at 03:21:38PM +0800, YangYang wrote:
>> On 2024/6/6 11:12, Ming Lei wrote:
>>> On Tue, Jun 04, 2024 at 02:12:22PM +0800, Yu Kuai wrote:
>>>> Hi,
>>>>
>>>> 在 2024/06/04 11:25, Ming Lei 写道:
>>>>> On Tue, Jun 4, 2024 at 11:12 AM Yang Yang <yang.yang@vivo.com> wrote:
>>>>>>
>>>>>> Configuration for sbq:
>>>>>>      depth=64, wake_batch=6, shift=6, map_nr=1
>>>>>>
>>>>>> 1. There are 64 requests in progress:
>>>>>>      map->word = 0xFFFFFFFFFFFFFFFF
>>>>>> 2. After all the 64 requests complete, and no more requests come:
>>>>>>      map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
>>>>>> 3. Now two tasks try to allocate requests:
>>>>>>      T1:                                       T2:
>>>>>>      __blk_mq_get_tag                          .
>>>>>>      __sbitmap_queue_get                       .
>>>>>>      sbitmap_get                               .
>>>>>>      sbitmap_find_bit                          .
>>>>>>      sbitmap_find_bit_in_word                  .
>>>>>>      __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>>>>>>      sbitmap_deferred_clear                    __sbitmap_queue_get
>>>>>>      /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>>>>>>        if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>>>>>>          return false;                         __sbitmap_get_word -> nr=-1
>>>>>>        mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>>>>>>        atomic_long_andnot()                    /* map->cleared=0 */
>>>>>>                                                  if (!(map->cleared))
>>>>>>                                                    return false;
>>>>>>                                         /*
>>>>>>                                          * map->cleared is cleared by T1
>>>>>>                                          * T2 fail to acquire the tag
>>>>>>                                          */
>>>>>>
>>>>>> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
>>>>>> up due to the wake_batch being set at 6. If no more requests come, T1
>>>>>> will wait here indefinitely.
>>>>>>
>>>>>> To fix this issue, simply revert commit 661d4f55a794 ("sbitmap:
>>>>>> remove swap_lock"), which causes this issue.
>>>>>
>>>>> I'd suggest to add the following words in commit log:
>>>>>
>>>>> Check on ->cleared and update on both ->cleared and ->word need to be
>>>>> done atomically, and using spinlock could be the simplest solution.
>>>>>
>>>>> Otherwise, the patch looks fine for me.
>>>>
>>>> Maybe I'm noob, but I'm confused how can this fix the problem, looks
>>>> like the race condition doesn't change.
>>>>
>>>> In sbitmap_find_bit_in_word:
>>>>
>>>> 1) __sbitmap_get_word read word;
>>>> 2) sbitmap_deferred_clear clear cleared;
>>>> 3) sbitmap_deferred_clear update word;
>>>>
>>>> 2) and 3) are done atomically while 1) can still concurrent with 3):
>>>
>>> After 1) fails, sbitmap_deferred_clear() is called with spinlock,
>>> then it is pretty easy to solve the race, such as, the following patch
>>> against the revert patch.
>>>
>>>
>>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>>> index dee02a0266a6..c015ecd8e10e 100644
>>> --- a/lib/sbitmap.c
>>> +++ b/lib/sbitmap.c
>>> @@ -63,13 +63,15 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
>>>    static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>>>    {
>>>    	unsigned long mask;
>>> -	bool ret = false;
>>>    	unsigned long flags;
>>> +	bool ret;
>>>    	spin_lock_irqsave(&map->swap_lock, flags);
>>> -	if (!map->cleared)
>>> +	if (!map->cleared) {
>>> +		ret = !!map->word;
>>
>> After atomic_long_andnot(mask, (atomic_long_t *)&map->word), map->word
>> may be 0 if all requests have completed, or not 0 if some requests are
>> still in flight.
> 
> setting ->word is lockless, but zeroing ->word is serialized with ->swap_lock.
> 
>> Therefore, using !!map->word to determine the
>> availability of free tags is inaccurate.
> 
> The check should be changed to decide if any free bit is available in
> map->word instead of !!map->word, and 'shift' need to be passed in
> sbitmap_deferred_clear().
> 
> Just be curious, do you have reproducer for this issue?

It's hard to reproduce, but it's reproducible. We've encountered this
issue several times.

Thanks

> 
> Thanks,
> Ming
> 

