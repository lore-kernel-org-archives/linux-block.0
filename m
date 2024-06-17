Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2103.outbound.protection.outlook.com [40.107.6.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F58B4A09
	for <linux-block@vger.kernel.org>; Mon, 17 Jun 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718640363; cv=fail; b=uSm86HjhTJkUpETG+LnETzP8Qi3A4LMcsgrepgI3PuUYUErFmfy3rmAwFy0WxvIOUdVfU5I/kjoOtqi1kuydgBt0oDqJeTh9UbhH4jBD0RETe22e/hRG89EaZ5UY1FP5niDogO/QiDXjlrTYoFj0csBlsrPMUlOigMhn+8BdTZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718640363; c=relaxed/simple;
	bh=JxmO4QFnxcBegrTZWsnAOxnQv3MhK6BsN2mNclphgMo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HhRg/8GrHrLbZ03eL3KATwkKDiIVGuyw9muaLu4YIVGY+oko6N1p1RPDbxc38H/i7AwdayyCjJk972/qiSVhDXM7Z/RnewjvRghySEAP6TcbMvb5da9c/bY7FJgI961xpXdaDBPAyWnm3cgE1cdq9wwL3U3kRkewMYpR7IH9YNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com; spf=pass smtp.mailfrom=volumez.com; dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b=gSjeC8AA; arc=fail smtp.client-ip=40.107.6.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=volumez.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b="gSjeC8AA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pb/rVaxatQwWjwqDqneske/bW0om2v6dxVOEkKriGEi/Vouzrdy3W5DftCKIccFFuTOPkXM2mRqpXwK84bB9f32A1Dugqv5F7FTMWiqi2bDoLkytYLpJwrNOOXHoO0ngUYrmcv1xV6gBvdAyQY0/MWOAEqu6B4hLJvlvEdvOhpIj+Vsz7oCGCpx5u1C0gt+HPeNIQIwptzcgcSker9C5hNLhmgk6MRxoVYOb7vQWBAQ4vyT7L5Yn1/PrhJ1LXEMTZyY1ZVNgW7czKgHjjqlZa7+LQTBEqg0A7dqjuy61PgxjWk5qiJmdNFq98ocLt8bk2DBeCY9KoBG8iSRhP9ONrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suODURwtz+81rCUze4BkLdIZJJ5PSeNwkzlzNwKa1s0=;
 b=O4BxOCj5aBDltW1fAp5IMTNN8EUT+hL0Xb3LtFA4QfDK2aouUbarI5Yt1/mnVsNntt7fQY1HrTr32DGFKnREiRIYeeZWjNwK7axdkfiJNDagIdJ10+z/PFIYBw8BP6nMQxTkriXXesTcULneSp1x8/LImFAm4yxB6oNq87sWEsn8+CFCWDF1MNyLwZu7J7a0kN8aotNhi3lsPyQikC4kWDZPPC2tsr35koEuBoz3o0nNydRvAXLLl99ZMumvfZSjzL/2E699yZ9+0PSAAn4mFeqT8UN0JNFpZ3PAqHUgD+sIoFqysAfFxi3eis5gC8SZipSrg22AbaA1rhI8QEcspg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suODURwtz+81rCUze4BkLdIZJJ5PSeNwkzlzNwKa1s0=;
 b=gSjeC8AACUebCNVxlDWfSYFPd8t8P8N/tcobIdevGgbyTN3s3yC4EP5Fles7SLSTKrE8NCzyOQMpUdInHKPJ/jd8OQhW4xCU+DvJr+ClnrAX4qspmLKIgjv75lbh+PykVwCL2OjjN5CvYKLYE2HWu2yYfSfXfCN2/VsCFz9ww2K8Fi8VQtT60hEUxJd8zxfUHph1MghA6rg8Z1JagC4QGvbBWgNXMaiLK0oiWDJmq8In7na2e0p60yiX5GCqnNMy9UUkDQGvQrJEPdELet99apvxeBZrPrVAytRdChqUzxjODIbU8CrbMVtWVpG+ZqChktfiQnCbzzPTBTPf89wwWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com (2603:10a6:208:cb::11)
 by AM8PR04MB7395.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 16:05:58 +0000
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb]) by AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 16:05:58 +0000
Message-ID: <34ee55e8-a23c-4e7e-b897-cfbcc8337136@volumez.com>
Date: Mon, 17 Jun 2024 19:05:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] md: add regression test for "md/md-bitmap: fix
 writing non bitmap pages"
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20240613123019.3983399-1-ofir.gal@volumez.com>
 <cnaunh75p4p45e4hgdaeaqry6whwdc2pqatil5v3oxjitwobda@p2oqftzlwv2r>
Content-Language: en-US
From: Ofir Gal <ofir.gal@volumez.com>
In-Reply-To: <cnaunh75p4p45e4hgdaeaqry6whwdc2pqatil5v3oxjitwobda@p2oqftzlwv2r>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To AM0PR04MB5107.eurprd04.prod.outlook.com (2603:10a6:208:cb::11)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5107:EE_|AM8PR04MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: f8bfff50-f19b-468d-0fbc-08dc8ee75fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUhRUnFxeDcyYUxrWlhYYTlHOG1rWmhKMkpDUHNiT2NKTVpNZXp3ZlRtaTB2?=
 =?utf-8?B?Ymx1a0VQYlJHekdUNDBBalptWmNoeW12VnhzTXc2bzNSZlN2dUFpVUNOS1dQ?=
 =?utf-8?B?RWI0bENQdVR3R0hmNm4xMWxMeU9TMC91NXNYSmxpUHRWZkptUEtNVm1TeVBL?=
 =?utf-8?B?bHN0U3pZdmY2Q1JFRlRkdFR6ZVM0WTV1UnVBQ2JWVGNsdlRlTVRSUzlBMWw1?=
 =?utf-8?B?QkVKRmNBTDJ3aThqVTlBZExLU1A1dENPaG1idHBDcnl4bjlPOGljekhXN016?=
 =?utf-8?B?QzNkeFlEdFZrR1duL2kyWXViY2JtRVNLY01xSXNiSzNoc0lLM01zQ09yWEMr?=
 =?utf-8?B?QmovdFZNMFNjTHl5b0FEWGJMU2FyRGJydEFaZHB3aTBISWdCbENNZWhuTVJy?=
 =?utf-8?B?RFBWdFhRRm50ZTF4OWpDZEw1TmJBOExsc0J1TjFvRnUxRFQ1VDdvWTBkdXgv?=
 =?utf-8?B?akMzbllBbVMraHBMVHppZk9zTXpMdE4weFY3cFA3bTk0cmtFY1V4QXlONHcx?=
 =?utf-8?B?WkhjZ1VlRzRNNzdtS0liUFNnUVNaYy9DWkQxRUJrbktkSCtENVArWFRmQzV6?=
 =?utf-8?B?cEJ4Ly9KcVJKSUxMY1VMaHJqamxMVUp2cm5BRFpjREdXVE9jUjF1djBrODBO?=
 =?utf-8?B?bFhpNFpicTdhL25YdXRydnBHcmQyMDZRTXE3cW9OOEFCQnpOVjRobDcyUW1H?=
 =?utf-8?B?dkhCN0s0N2tLUEIyY3FHSG1Xb0dZSFlUanlCaW94T0tFMWxLZkgxZ1RucnBN?=
 =?utf-8?B?THFwQzVuUElqdHBLWnErZmNWNi9YK3oraG9FSmd5N3V3amV5OGVia1d4SGRp?=
 =?utf-8?B?S0R2TldVaTlzZXVhM0lGVVQ2OHV1UytHK0NaUElxa0I3TTJ4Z1JrK0hIa0Z6?=
 =?utf-8?B?RE1GeHdRK0tkZkpJZFFWM3BwcGticjd4T3ZCVEtheUkyOGxtalRtaEh4cDNr?=
 =?utf-8?B?S0c1VnFsWFNOM0N6NzM1Ny9mN1I3TmZvc0gxNXBwa0VranNMTFFsUzJoTXdX?=
 =?utf-8?B?VGVRUHRhVUF2WWovOUdtZWxlVmRoUUErNjJwVHNMcVdNU3MrTkkwNWFhYjJZ?=
 =?utf-8?B?MmN5eE5YQ2JZUm5XMUp3NkMrM2xXN3RMbkNNR2wxQW1DTFErSU9HNWNRS2c2?=
 =?utf-8?B?NWpQNlZWcllVQnRTYzZ4RllyV2FrK2duOERHdTFjR1dkallMRFEraFhEY0p3?=
 =?utf-8?B?SFphazNLZkx3RWpTRU1yTlduSHI4YlpuR3VjWDJpQnppSEY4TEgveThyaW9t?=
 =?utf-8?B?bWhOWGE5QWZJb0ZuUjJFOXh3VWovWjhjbHgvZElZN25UZHhrdXVwdGIvVHo5?=
 =?utf-8?B?ZVZnUUFNN29UOFRBemhrK1Vid2JRSXowa3JTVG5FNzlmalpoUVk0cmJBb1F1?=
 =?utf-8?B?RWw4VGJVcHE2cHlGaVdNSUZKdFI0UmdpSVh3SUFCTHVlVkxTbmJRL2ZjVU05?=
 =?utf-8?B?eDJnRHFsaEJRZjh5MWZnSUZHUytXS25TWmVKQ2ZXdnZHSUt4REIzM1pDbGRp?=
 =?utf-8?B?SlN5aDNsQTg2UURZUzJ0MEpiWE1aV05WTW15YVh4SHU3aTB5MngyZy85ZUVY?=
 =?utf-8?B?cGZpTDAxZVdJbHN3QjIxd1ZkSFg5VlROb3pwRVN6NmlMZnNGcUREcDZZdjBS?=
 =?utf-8?B?WkV0ZTJoWnJTdjlDd09iSWtnQ2ZLOUtGV3kwVzFtc0hjOHdsbVI2UFllblpo?=
 =?utf-8?B?UjR5MHdMc2RmL1QrSGxUMDU2aTJWUE91a3QyTDl3SXpmUVo2Q3J2bUNZRm8z?=
 =?utf-8?Q?jas/ZnGcp62vlR6J7vj69pWY5Bw5f80eCVxhtFE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1NVYm4zdTQ5RkpnMklJLzJyUU00VDhNM0haSU11MGhoYVY5LzZlV3dZbEJl?=
 =?utf-8?B?V1BuMVROSG90eFdRUVBpSnppODQ3M1c0Lzd4Y1F6UXY1SDJlWCtVcmkrQ3gx?=
 =?utf-8?B?UnhoNXVzZDZleThYeVd3TVl4ZU5MRXl3MjRuMkdQUDZ6TXcwVVNEQ2JqSFNy?=
 =?utf-8?B?ekVCOWg5elpBa2xxeSsyYjZPKzZVM3J6eUxYZVZQZzdTUitGRmRsb1laT3hv?=
 =?utf-8?B?QlNIRTc4eW4raGh3UGtmNkxocTkvNlIyMi9OK2xlSjZob2tmUnZOdE1oRWVv?=
 =?utf-8?B?d0RxN2dBN3NsQUFYZlQrUmFnWXgzYURSZVFZVjFNZm1sLy8rYkF6YkcyOHZx?=
 =?utf-8?B?UXB3SjZ3eTBoZ3RVeVMzbyt5WWs2NGpaSW8yRm0reWpNYlVxdDMzS2tSZjZY?=
 =?utf-8?B?TTgrSTI0UFZjN0l2bWNBTHE0OWd1dUVSajZPdFZjL1RzTjMxOWkzVlIrU09J?=
 =?utf-8?B?SGZqRVBqMVg2NW8yR2tIL0lGcTNZQUtwTTdZV2U1cGE5alNoSm44MVZELzJS?=
 =?utf-8?B?TUJwSzJMaGJLUjluTFlrUDBUZmIxdnlNZ0dzeTZ6a3N0TlVrbTBlRkNsdGVN?=
 =?utf-8?B?L2YvazdRM3AyRVQ0ZVorZFNacTRjYUdzT1pWdkVCejRqa3UyTlRWanJrWmNp?=
 =?utf-8?B?RHlpQjRWcXpEN09xcXh3WXpuZ04vRmFyNC9MQ3JGKy9INGUxTDBLT3Izc245?=
 =?utf-8?B?T2JocldJdW9UdGc0djZOK2lWWWpFKzdrWG9xeC9XL2NQaXdBSFBzUE9HcGVy?=
 =?utf-8?B?TjVJREZmNVl3eEw2YUhab1M5VE5WWG1HSzN2WTk2ZUllT2hIYUpQdXVhZi94?=
 =?utf-8?B?V0ZFcWRZOGRFejVmMlFlSkRLQnZIcStNc0VBclhGRkFoYjRLWXZsRnF4Ykgz?=
 =?utf-8?B?R2pXTkhWM1hUS29Jc3Vpb2R3Z0JYRHRVMkIvR3huK1M5Y1NGNUt2c0p3WnJO?=
 =?utf-8?B?d3R0Nlc1bTVPaFBTY21oT1ZiRS9zcGZTL0FkZGZvRTk3TXpIWjZtMjR1ZWJl?=
 =?utf-8?B?S2pudFJxVk9LU1k3bHd0TmpYMjc1SWRJd29TQTdtcXh0ejRGNVdxZU1aWUFZ?=
 =?utf-8?B?bkJKSnVQaFpBS0xsUjd4cFdXR29xZlI1K0xSV0FmYzd3OUNIYXdYSTcvZUd3?=
 =?utf-8?B?djBXRDlwYmZ5WjlJaDlWQ2dkeFJPcm5qZWhkQXVnR1lWRWVSbTVJaTl0Njlk?=
 =?utf-8?B?NGZSY3R4Zzk0ekxrM25KanJxTGVDdXhlNmJMMk1qU0RScjJ6T09nV29vR1cw?=
 =?utf-8?B?eDlLZXVrZmRqUjJIWTB6NHV1Z2xkeFEwUi9PMGNEdTB0NkR3Uzl2OTRlQ0ZK?=
 =?utf-8?B?SnJBSVJYRmlGTkhqYWN1WkxhaXJiSTdTOHFuSkJrR2IxMzZlbENKKzJXV1dZ?=
 =?utf-8?B?bDJGTEFHVEFON2lodGNhODhYUHFLMTB0MXZRNUZxOUhkbFJGN1A0bmdRcElk?=
 =?utf-8?B?VXFSazNsUnlHNG8ya3ZBMGZvOFNHTWdCVjF5UVZSME1IZnhNMkt2NTQyYTRK?=
 =?utf-8?B?MEttVTc5WngwcWMwWkFveVBJZVNqQm1mblFCbHBiUzJMTjNzelgxTTNPV3Jv?=
 =?utf-8?B?VzZZNzRpQzNOOGw4RkFmLytxY3pKdUZMM0hCL0ZmZis1U3VMQmNFMTFBNE9B?=
 =?utf-8?B?Z2QzSWN4K2x1ZExpZmtMTTU1Yk55QUpmK3N5RlFGQXlWREhvR2hsNHgyY1Ji?=
 =?utf-8?B?dXIrZmZNZjIydWFmdW1hSFJ1RFBZRTAvQ2NOT2tKY1pnaWZVelgwQ1dJa1NK?=
 =?utf-8?B?aWlacEpINTcrV2Qvc2kzZy93TU9aTVd4VXhyZi9XNGJXQVVtbEwvMDExakly?=
 =?utf-8?B?WUt3TVZLVndOOTVTcWkrcExOcGE0Q2lGdEQrS3hFdHlidTFkUGtaS25ZODg3?=
 =?utf-8?B?UFUxYTVRNklrMyt0VG1odmc4azdPNWM4U2Z4cDdtYXdtMkZ4Qms4Sks5UjAy?=
 =?utf-8?B?WmNUWFFCOFd3SWpKYWF6OHY1RFdsQVFwMTMzQ0c2NVBrdkFBQ0l2TlVVNGtW?=
 =?utf-8?B?QXpIZVIyaTBVUDE4UlNKUnVwaElla2h2QkdoS2NOdUFDQ0pYL2VUS0V2VkdP?=
 =?utf-8?B?Y1ZQSWwvVHREbUNNNEtMUzhXdHF5dVFXTFJRMHd2M201Y2l5UUNtalpJSjkv?=
 =?utf-8?Q?Qozj9JJNZi9Awu1+UFbwcIgU0?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bfff50-f19b-468d-0fbc-08dc8ee75fdd
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 16:05:57.9911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvC+4lgPZKml7Q37tqA/++M5yO8XgY/gdeA6lwOBKlYQ535C4V+dp6pLqOl4FXHyAnsZlVXKTjZmE1uUuW4z+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7395



On 17/06/2024 14:32, Shinichiro Kawasaki wrote:
> On Jun 13, 2024 / 15:30, Ofir Gal wrote:
>> A bug in md-bitmap has been discovered by setting up a md raid on top of
>> nvme-tcp devices that has optimal io size larger than the allocated
>> bitmap.
>>
>> The following test reproduce the bug by setting up a md-raid on top of
>> nvme-tcp device over ram device that sets the optimal io size by using
>> dm-stripe.
>>
>> Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
>> ---
>> This is my first contribution to blktests. The tests hangs when being
>> ran on a kernel without the bugfix. Should we wait for the bugfix to be
>> merged to upstream before merging the test?
> Thank you for the contribution :) If the bug does not cause any hang or failure
> of other following test case runs, I think it's ok to add this test case to the
> blktests before the fix gets merged to the upstream.
>
> Please find my in-line comments below. Later on, I will do trial runs.
Great!
>>  common/brd       | 28 +++++++++++++++++
>>  tests/md/001     | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/md/001.out |  2 ++
>>  tests/md/rc      | 12 ++++++++
>>  4 files changed, 122 insertions(+)
>>  create mode 100644 common/brd
>>  create mode 100755 tests/md/001
>>  create mode 100644 tests/md/001.out
>>  create mode 100644 tests/md/rc
>>
>> diff --git a/common/brd b/common/brd
>> new file mode 100644
>> index 0000000..b8cd4e3
>> --- /dev/null
>> +++ b/common/brd
>> @@ -0,0 +1,28 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2024 Ofir Gal
>> +#
>> +# brd helper functions
>> +
>> +. common/shellcheck
>> +
>> +_have_brd() {
>> +	_have_driver brd
> This _have_driver() call checks brd driver is available, but it does not check
> brd driver is loadable. I think _init_brd() and _cleanup_brd() assume that brd
> driver is loadable. For that check, please do "_have_module brd" instead.
>
> One left work is to improve this case work with built-in brd driver, because
> some blktests users prefer running tests with built-in drivers. At this point, I
> think it's okay to go with loadable brd driver.
Ok, applied to v2

>> diff --git a/tests/md/001 b/tests/md/001
>> new file mode 100755
>> index 0000000..d5fb755
>> --- /dev/null
>> +++ b/tests/md/001
>> @@ -0,0 +1,80 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2024 Ofir Gal
>> +#
>> +# Regression test for patch "md/md-bitmap: fix writing non bitmap pages" and
>> +# for patch "nvme-tcp: use sendpages_ok() instead of sendpage_ok()"
>> +
>> +. tests/md/rc
>> +. tests/nvme/rc
> I want to avoid cross references acoss test groups. So far, all test groups do
> not have any cross reference to keep them independent. How about to add this
> test case to the nvme test group?
I don't mind to add it to the nvme test group, just to clarify the test
checks a bug in md. The bug is "visible" only when the underlying device
of the raid is a network block device that utilize MSG_SPLICE_PAGES.

nvme-tcp is used as the network device, I'm not sure it's related to
the nvme test group. What do you think?

>> +. common/brd
>> +
>> +DESCRIPTION="Create a raid with bitmap on top of nvme device with
>> +optimal-io-size over bitmap size"
> This descrption is printed as blktests runs. All other blktests have single line
> description then the two lines description looks strange. Can we make it shorter
> to fit in one line?
Yes, does "Raid with bitmap on nvme device with opt-io-size over bitmap
size" sounds good?

>> +test() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	setup_underlying_device
>> +	setup_nvme_over_tcp
>> +
>> +	# Hangs here without the fix
>> +	mdadm -q --create /dev/md/blktests_md --level=1 --bitmap=internal \
> In the past, short options caused some trouble. I suggest to use the long option
> "--quiet" in place of the short option "-q".
Applied to v2.

