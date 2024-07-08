Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2046.outbound.protection.outlook.com [40.107.255.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9198E3218B;
	Mon,  8 Jul 2024 07:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425289; cv=fail; b=umqfUG4j/ZjvKjX+3q4Z09Is2LAr88ZiBtFkq8UA+9UI20KkqnMabs8MwyDSUPgc3E6QoB1wftxz49y27BJ9E7FN/R93vdOg7hR3ijqbXXsuY6smT5uLAWx76eYPT4g/Q4ISakFoHXeJJkAxSOrduN393I77JfbDZLMAawPf7h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425289; c=relaxed/simple;
	bh=kqDGblrZR5TcmYfQ3PTVG88M+9rwoo+bRLqiVHXnKWg=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sCWnJuajfzKlUr2vYRIBpnjKYHtk2T2Lav8RDh29jYdl/OEQ7/sNH8UAu8FMTszHHAD0fe3/hFTws6POW/zbSvWl6osnD9iJfpnJpmBS30ERklRnQXt6eVTNs+Ec+6xEpXMalz6zDVD1OxYH1W61v6G+7BNGJEYLCOU+8fVG6iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=FPxn5KeC; arc=fail smtp.client-ip=40.107.255.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="FPxn5KeC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKeWeQtzb0ozUVFnzRp4DTHAgvHfhzVDgosHsJk1VwrZNVKNNOfs3cFvDXQoWfrNTx8wKrm4glpYL7KSNdovYl5gl43dozAxnZ9MAmWBYkYx/qFKUxSvjBHmAFjGHw1cfziYhyZsqg3ih+4SQfjywlidsG9S3Enj7BIF4yMXLLe2NcNyUSN9bsLJvt0ciBIAaWiF5HDOk43qb/l+33n2ag8GP+QBVec78OhRd7PRNgtrk+ymIhMCocitXoww1mM8zfNJUgyt/RegsRmroSyWGHnfRrIuR+6k4sdiV6McbPeh9ETKbf6meG7ZLG8JQSSvLYt1jsF9rNBaUPd7UiBCHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnflAn5ZCkiIAjy5B8feMXDnMaCwpztJximcWOKmERg=;
 b=erHH3uU+exn6/yyv0n/0k6uLm6iO0d0hxllggXOrSBQaTERxAqHCmNTsBW3AkK5IQznpphAVKiGJaS3jj+c3Z0Xt2zm32awnOc1wewJY33CeCLZfhCAAv/ToI/IYoYZmuoEEyoiDPVpywjw7OJrFzfkj/tbPIj87VeOntYcBmbd0fRiuNCVlrW9NRd2m9ITUbuVUvDw65DKtQkHDXNlVcmHDgmDKAQI5ZXgQYYNwdSQTLFM5wSO/LxvcU7bpkq4g6jq3dcQk94OdyQoImE1jv2TWvpjbqrk3ZTdiJlKwGJE0T7Z6r3mzX6o3kXNpt11rVUuMdwmrxESd8MHuLaJ5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnflAn5ZCkiIAjy5B8feMXDnMaCwpztJximcWOKmERg=;
 b=FPxn5KeCMATTXkeRDrZ0+WutF7/eXukq36fyL+KUQ89TxZKk74laHuxhthe/TqgYuj8kroV9YJD0YyiFirreLSrOx+rTcRMRrKd5UYHFN/fdMe+VS4o8BFJj9o7m4uG8tfATlnP4XMhr9bfD8anl92kGgRNsLpB4CZQ+qCijStmdgDM0LK9er9lAxP/FsyX5WR7dkrTh2rUKfT7W3cuNDU6dXTiqPdh+Tl1KJi7lUF84byyibYb+yoTSAZoaKl7KHAXU8mrm6710+Sa9T+7OMUkBmPk012jjJcj9LL8vTm/Pdx1+4k3yRtSkX5/D2Hh5dzfFkvlhjWDKbpqL9aGRXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by JH0PR06MB7293.apcprd06.prod.outlook.com (2603:1096:990:a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 07:54:41 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 07:54:41 +0000
Message-ID: <6379eb83-0ab7-458d-af83-5d2ed1d8fec5@vivo.com>
Date: Mon, 8 Jul 2024 15:54:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Content-Language: en-US
To: Pavel Begunkov <asml.silence@gmail.com>
References: <20240703022807.642115-1-yang.yang@vivo.com>
 <fbd3bebc-db09-4224-bdf9-b44304bf55b8@gmail.com>
 <59c125f5-ff40-4a36-b095-b0dbf1a0a3fd@vivo.com>
 <2ee7600f-f09c-41f3-87eb-15bc68734b29@gmail.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <2ee7600f-f09c-41f3-87eb-15bc68734b29@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:404:42::31) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|JH0PR06MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 734090b1-3ac9-493f-9a5d-08dc9f233905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEFmTzJvZXg5QUE1Ry8rMzVrNXNDenlOOWk1YnZNNW9xREhPcVJTdEFCeTJz?=
 =?utf-8?B?alZiamIydEk4VVlzOFlyc284NjBGNUk2Sm1SeEFPODlKOEZKcDFhd3lYNXRM?=
 =?utf-8?B?Z0lSU3ViZlE3dHhyTVcyOG1VRENVSnUvcW15bytLMk5BOEhReHpLTjFQMkVB?=
 =?utf-8?B?b1Z0QVNYWnVNbWFkY2MvTjl6cVBDRGo5aDdHOGxNVTMvKzJBUzhQNzJ3Mm5q?=
 =?utf-8?B?NG9xL0w0N0prN1RpWmFTVUJrOHUrUlpvZDNKc1VPQ09HUjRRMXFQcGxhdHQz?=
 =?utf-8?B?TGJyeUx0OWFZNFZTME84NzQzaEJzOUJIWWNabVE0K3NIWmhSSTc2amc0eFlR?=
 =?utf-8?B?SWo4YXl3WmtZcWY5Zk9kQTN4S0l3b3hLdG5KcGhEZlhwdFcwd2MxVHZ0SFA5?=
 =?utf-8?B?U1I0WEdwTnZGT1dlNDdWK0htYjJTNWJPekhOU3pZQlF6RVhRQU1TNytoemtX?=
 =?utf-8?B?T3BKSlZLNU1CYkM2dkFtY0dnWXE2Ykk4RC9WMmVZVmtLYmlHaWVqZVcwTzRu?=
 =?utf-8?B?V2Qva1lISWlwWVRNTlB0cWo0QzVsSHh6RmxqNkNVRmhxY0xyN0ZkNDJDTHk5?=
 =?utf-8?B?RDFZTW1VVjEzRERzeWthTmRSemdEay9YVHZkR1VyVTAvSEpmMkxMTFJrbFpM?=
 =?utf-8?B?cE5Md2RxZkFTM0w0RXNISDh4R05LTk91V0puWmJDZmZVMm9scDUxQ2NZdU9O?=
 =?utf-8?B?M0EzZnBXdkoxeHo0WU52bDV4TDFpN2VEOWR3OWFmNHlmMGdlcTJ0clcrSXoy?=
 =?utf-8?B?NXhGQTFOYUgybWhvK3pTRnFhZjR2cEcyd0RJKzl1WW9TSk8wQWNxODZERmNW?=
 =?utf-8?B?YkhmLzBpQUZMWkwyRlI5bTJqL2hMOVNPWE0yZTFORVJTUDFReUZKRXRjaWpE?=
 =?utf-8?B?Q3QrSW1yVm11Sm9SeVE5c25KRnBqNWg1RWFNTlZZa1lsZ2ZFSEdmcXJ4dktW?=
 =?utf-8?B?K3pGSTBjUmZ2MXBWckdNK1Yrd1d4U2RQQXJSSzZlSjlrUU5CR09oZWZvSy9T?=
 =?utf-8?B?Yno3RW9ublpwNnphRVpyNUF6Yk1UbDcxai9BRmZCMXB2RE5YWCtzQTRMaXZH?=
 =?utf-8?B?a2N0ZVkrVGJZSlZWMGdCM3lBWHp4N0I4NEw4Y2c3OHh3bTBDa3prOEZtMXpQ?=
 =?utf-8?B?ZWdtS0dtYytWYUM0TWJGbkUvYmRxcCs5YUZRSGVOYThzVkJtQTVDNFdZSXZP?=
 =?utf-8?B?czB1R2hqdXdzcHRrTkJjd1JQano0THpYUW9JRFk1WkdjaE9FZXFoYmhBdVZN?=
 =?utf-8?B?d1BIWTNIVTFrUkxQMGxJb3FBOTN3ZTRCTmZ4NHYxUGtIZ3dBbEc1OUxocUg5?=
 =?utf-8?B?MDgvbGwwK3R2RzZKZzhUUDVhMVJqNVdlYzB4Y0FobTlyNk5Pd2pGVk9ZSHNJ?=
 =?utf-8?B?cnQwajI5RU05elVQM1cvQTd3N1dnS1BtdWx0Tml5UUhja1FFaVpQNzE4a0Jj?=
 =?utf-8?B?ZjdyRTRuTnZ0VGtTOFQvUi9WZnpPdHdCSndubjlsMzBLMGpnZ1BkVlNQdGMr?=
 =?utf-8?B?SExFZnI5eWxEYUcxU3k1S2pDWFVaTnpsUWJ0WUFCNGlRSHlsMXVUdmdFVXZk?=
 =?utf-8?B?VVBSSzdSb29FblBGSTdacXE3UTFLeGVGSThETDBHcHl2WWp0RTNQOUVMSDFC?=
 =?utf-8?B?Tm80VVVjbFA0Y045bXp5QnpaUUVvZ2UvRHg5YXZDTHFSS084NlRBVkNSNGV6?=
 =?utf-8?B?MlgxQjV2am51cThrcnF3S25tQ2dPWEk0UWdTTHVBZ3hJVGZoN21yVkY0Qk1H?=
 =?utf-8?B?aTg5UUVKaHdjWFFtQVJObjVIVnRia1g0a3Y2djY3SGlib2RIQWxYdFdjekJW?=
 =?utf-8?B?SytWMmYxYWhHVEZRT2pBQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVVvN1RsbVQwRklhRGk5K0ZqaEJZM0V5cHVpSTZuZFBNNjVYa1FUQlFLN3Ev?=
 =?utf-8?B?SklIYzZQTXVKV0FvU2srUFBwU1FpeVhvZjQ5d2tORHltTlNlODcvQ0Y3aFNX?=
 =?utf-8?B?ZmlUT0cyMnFleXo2THYvOGpiQkxwbGJvVkdKdndrN3F4L0Ntczc5dFVuY1JT?=
 =?utf-8?B?TWJDaHNZNE9IdlB2dkVuc0x6MlQ3Z1B4UHFuMHRxdXpRWGJFbWxKQTlzMTF1?=
 =?utf-8?B?OG4vKzRuR2F1NE9leUFPR1R4WXBLMkRFbm1LTkloaTh5UmdZNkZ6VHQydHdm?=
 =?utf-8?B?Vm56N0gzKzNhdHRKSkdiY0JBckJnUW9hQ1k2clV4dGpLYk5IQjR0ZldYajAv?=
 =?utf-8?B?OFRPdUIxUjBaY05QR2hFUUFKeE9lSVhtTGcxQkpQTTlhZnVaZUZSNlFLSzJl?=
 =?utf-8?B?d2tET1hubzNWM085UE5LMWtodHJwY0N4UFVCTURRanNHWFRRVzBvOXI3OXF5?=
 =?utf-8?B?UzJTUnp4KzhJUk82d3FDRDJYaTVmVmFXMzNzOSt5MVQ1bDRUOTVTUEJKMVZh?=
 =?utf-8?B?cDd3WkxQVVFmMmhKeVNFdUhWUFVLUS9oc2hlQXZlSzgxQ29qLzJDczhuVzJH?=
 =?utf-8?B?NVZkUVBndFFKMlU1ZkloQXZYS3ppeVRIc0JOK0dtd2VVbmd0TDdMUk0yWlI2?=
 =?utf-8?B?NVh1Nk5OTDAyeTRaNEg0SFVqWS8vY1VIc1YvZXZhZ05jdVdFaWk0TUt1c21C?=
 =?utf-8?B?TUoyZDlXMVBoVHY5SjByc0Y5dEVNZVJEVkV6bWZLckl3Und6VjZha0JpZWQy?=
 =?utf-8?B?NVU0UXltNEkwUDMveWF1VE9QQTFjY1hYRHF3VXVjendScXhtOHh3cGRWazRq?=
 =?utf-8?B?QVdRQm0rUEk1aThnVjJVS3YyR1F0VWlYVGFWR3l3R0ZkbFpBYUIycmt1SXc0?=
 =?utf-8?B?MkdrNm1Uc01KeXhOcVhVM2RFVnlGMnZvNGprbFFlQ25IQWlzUmtvTGNMNjRn?=
 =?utf-8?B?UUtvTVlnWlJjVkprb21RR2NxK096cDdrenZBdW1MVFU2c1piaGhWZHBxaStD?=
 =?utf-8?B?QUdxMlBnZzdzeXZYWmtVc0UyZ29mdFBScG5KVWZnTzZsOWhCZVZPWjY3UnJw?=
 =?utf-8?B?dm9XNjh5dko4dVBkMExCUGl0cis2TFdOWmZQa05RbGlzRU13NWFpMW5sT3Fw?=
 =?utf-8?B?ZjFoeDJpZkZXOEM5U2puajU4UHNZWkMzQjBpdUE2SE9xTHhvczNPcEJLM2ZZ?=
 =?utf-8?B?bmNzWE9UeGlldG1HWWRoMVExdE9NN3puSktPRGZXeDVoQUg0SVFPc2w1UkdT?=
 =?utf-8?B?TFNSY1NEUi81MEcrWXFzY250QXVITEtGZk40MDZ1TzNtemEyby92YXMvZTFW?=
 =?utf-8?B?M3JMVG5wbHNRcTJ4RUtCNjBIUFFFVVhIL0l1a0Y4dlg2dm9mRERHeFB6L0RN?=
 =?utf-8?B?RWdLSkhqRjBzdmpycENtNjVPV3JvZnQ3czZXYTFYOFhPdlEzY21lc1o3MGUy?=
 =?utf-8?B?akRyUjZGeVU1eTlLOGM2K1JVbHNybWxDbjBDVmlqUVl3QXhFazc2eHBLQUtl?=
 =?utf-8?B?Y3M1QW8xTmIzMnFSWGRUb1hZNzB6SUh5TkJGeklpWk9XQ0J4ZFlCZW5QWWVH?=
 =?utf-8?B?eU96N3Z6QkJ4cnEvYlpwMVhTUkIxNTBSbSs3SVN1N0M5SDU4eXZDajNpbGFS?=
 =?utf-8?B?QTl3UjNtV2IvWE1rbWF0WkJOUExSV2VXVWxLYmxXNEVBQnhiV3htWlBGbWQw?=
 =?utf-8?B?S0lzaTZBRmFWS0pDekZtNERKdEZ5TExyMkhrK2phS3gxVkk0K1Ztdmg2T2FZ?=
 =?utf-8?B?WWpXQnd2ckpYV3VzMkdKUnUvaHBlajdUaERvaXFnY2k3TjVqcWlQRUF4RnJV?=
 =?utf-8?B?RjBrSDFlVndOQ3hMWVc0UGtwM3IyaEl4Nk5idVZMMDdwQXM2djhrZ05SSEJG?=
 =?utf-8?B?dFpIR0t5Z1JtUUpOQmRHbUlYdE5hb2NiUFNxcGtidnlxbko5cG00Y1JabTBD?=
 =?utf-8?B?TEVPMDhEVHQyMm9MdHZVZWswQ0NVL2xkcWtadVdCL2VsT2Y5RE1IcVA2U2Vp?=
 =?utf-8?B?TzJCU0g3N25kNUZTTitpWi9mQ3ljTndwcDgzekVsWFBENEo4aGZMUjVsazV1?=
 =?utf-8?B?WVdOYnU1UHJYSGFwZ294SnFLSTRtOCtzYkQzMFR5TEJLOVZpTmtpSXNQVFFr?=
 =?utf-8?Q?Bbs3kNWHt6gZ0TsljTCz5aAJF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734090b1-3ac9-493f-9a5d-08dc9f233905
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 07:54:41.0950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgyEzHwWuVnmYUEPbNrRTPowCHwgtvWTCrc7b/xp8gruz+BBjSWpmro8XQNHt9tuDsei0/QmYgnEYyp0SaUfhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7293

On 2024/7/5 18:58, Pavel Begunkov wrote:
> On 7/3/24 13:28, YangYang wrote:
>> On 2024/7/3 19:55, Pavel Begunkov wrote:
>>> On 7/3/24 03:28, Yang Yang wrote:
>>>> Configuration for sbq:
>>>>    depth=64, wake_batch=6, shift=6, map_nr=1
>>>>
>>>> 1. There are 64 requests in progress:
>>>>    map->word = 0xFFFFFFFFFFFFFFFF
>>>> 2. After all the 64 requests complete, and no more requests come:
>>>>    map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
>>>> 3. Now two tasks try to allocate requests:
>>>>    T1:                                       T2:
>>>>    __blk_mq_get_tag                          .
>>>>    __sbitmap_queue_get                       .
>>>>    sbitmap_get                               .
>>>>    sbitmap_find_bit                          .
>>>>    sbitmap_find_bit_in_word                  .
>>>>    __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>>>>    sbitmap_deferred_clear                    __sbitmap_queue_get
>>>>    /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>>>>      if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>>>>        return false;                         __sbitmap_get_word -> nr=-1
>>>>      mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>>>>      atomic_long_andnot()                    /* map->cleared=0 */
>>>>                                                if (!(map->cleared))
>>>>                                                  return false;
>>>>                                       /*
>>>>                                        * map->cleared is cleared by T1
>>>>                                        * T2 fail to acquire the tag
>>>>                                        */
>>>>
>>>> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
>>>> up due to the wake_batch being set at 6. If no more requests come, T1
>>>> will wait here indefinitely.
>>>>
>>>> This patch achieves two purposes:
>>>> 1. Check on ->cleared and update on both ->cleared and ->word need to
>>>> be done atomically, and using spinlock could be the simplest solution.
>>>> So revert commit 661d4f55a794 ("sbitmap: remove swap_lock"), which
>>>> may cause potential race.
>>>>
>>>> 2. Add extra check in sbitmap_deferred_clear(), to identify whether
>>>> ->word has free bits.
>>>>
>>>> Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")
>>>
>>> Is it blamed right? Considering that the revert alone doesn't fix
>>> the problem, it sounds like the 2nd step might need to be ported
>>> to kernels even without the blamed commit.
>>>
>>
>> Got it. How would you feel about removing
>> "Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")" and modifying
>> the commit message as follows?
> 
> We need a fixes tag, which commit caused it? Can it happen prior
> to ea86ea2cdced ("sbitmap: ammortize cost of clearing bits")?

The initial introduction of the sbitmap_deferred_clear function also
introduced a potential race condition.
So the fixes tag should be:
Fixes: ea86ea2cdced ("sbitmap: ammortize cost of clearing bits")

Thanks.

> 
>> This patch achieves two purposes:
>> 1. Check on ->cleared and update on both ->cleared and ->word need to
>> be done atomically, and using spinlock could be the simplest solution.
>> 2. Add extra check in sbitmap_deferred_clear(), to identify whether
>> ->word has free bits.
>>
>> Thanks.
> 

