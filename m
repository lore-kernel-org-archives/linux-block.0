Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2073.outbound.protection.outlook.com [40.107.255.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7572E136E26;
	Tue,  4 Jun 2024 07:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717484624; cv=fail; b=EtW/TP7cNOJsRAzgisczJEpAnYaFbeWigLnN7jIck53I8IFZR2byZT6+++P5uulufvfM6jw0GTK11JWTBs3kc1avr7YYeu9YectgnrssAQtPvnR4MTi+G5CZ9rNtfJjbG43NqSSdYNUmHg4rCLxNxWxzhwUN5Zz69pAkvgIQJIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717484624; c=relaxed/simple;
	bh=KyJBp6ACqnhNBSgFQsGKo6UQAZsa40rmtEslNj3s5A0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jVepDWGGvJb4Sx31GHnOiJPwuMoKQxZhW3/b0fy0fLzuh3Dz7mRMJUx38Puvtb/mG5MfiPc8Z5p5d/YnwHzlU2sEkUjwBZhSUqApAZlek25HnLLSJSB99I7EGk13SmzFJZFGKHtpmCWqSIELWkDJVdY0Q+cgn0cL5gbRk2I9JOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=iK1CbvxB; arc=fail smtp.client-ip=40.107.255.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="iK1CbvxB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SU82i3LbT4RK6MAlBKSuhBYT1Ki1iJYdS2Aq0FqEFapCseReQL49pUP98UU4bzv69LbLe6i4wMpbUHjINK28V3VktpgmBNfJF3xrVG9bWQr3JuVuH/L2F6aF37dUfkfr/xoRJ8YnFHSy/aYWwf5rr15F+D2gopqi/kRu6xgqzGM67P/ptItfCyJ6D/W0kLWoxh3DlQiZ/Mo5ySKSrj964mMtcDV+R40pxdWIOyzs1RvHqctA9dS0eXGRd7aVR/8cWPzARMZsP+mHsK4mjpyVxDvKoE2bUGWBHmS7vgWJzwmcbu9GhLEbWqNgqQ+tNNFi+3BKBLEvCh3ZHYipaGzSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnYltsDpKX9YqCFsC3C6odHAsZdWSluY3zhu21UTPTY=;
 b=P67a61aP0m4Vse5McL70CXtx4UaToow/AhUkP5Tp04fE7GMB1AZs03wZ8IFscXX1T54HpHFpwK8PcXvGPElyavrDyseuPvrK2+ipzwwy0EUJFpjdY7z2ocBdRAeimRy3Z1K6E+Ir8/JODBFdQQb8F9AdRhhpanMW223OT9khH7WWNR71loVilNthm8Ws2W4MeQDiEcAKizDPmnvuTj8pIWfoUc4n4Y3NJYaSTGzgz/a/fmNiYtC+zvmXc75hli/Ygd0o3A9xxsddODJjujEmoxNlYe6o6r3wayQfXgbztdOaF8MWPODbc2TqaFUk+THmm+jd6nY+FcthmDAs5ZT6pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnYltsDpKX9YqCFsC3C6odHAsZdWSluY3zhu21UTPTY=;
 b=iK1CbvxB3tbiVw2Ykv9cQ6UElZzHxoWT3Gx/5WTQdXgwTHbdCYYeGSAvnDHUz9jjdDy86Zd4fo5qnNgBk6/0FCbu/87c7njCj0m5Cau2dHqptXD5I2gp/Ux1lfMn/wVJIJ5+JMN2pJ+40L8J+gKmvoFtzWuCbli0UinUAlKrJr/ShULzFvzZEEpbdmHYwavoG5JMkOvlgjbIFZJIJpAV1VRUdb7w/pqw+Y8iiRlhp3cfIKCvJgpA04hxMFueqlB1UKBIMj/O/yGOW030wUZs1g4Y5hK0nh2pWXPziWoW2nmqYFkFJk5VqCO1q2FDnrTzWyR0tsNfKQHFeg4MFUk1yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by TY0PR06MB5548.apcprd06.prod.outlook.com (2603:1096:400:32f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 07:03:39 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 07:03:38 +0000
Message-ID: <e1cdf579-007b-415f-9e4d-3fadd6f97b36@vivo.com>
Date: Tue, 4 Jun 2024 15:03:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20240604031124.2261-1-yang.yang@vivo.com>
 <CAFj5m9KV7OJ4_KjbSkpdtfrKamoLzV6EH-mJP3=y+VvoYOzC3w@mail.gmail.com>
 <aa7246f9-f7df-3054-077e-eb21c7f423ac@huaweicloud.com>
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <aa7246f9-f7df-3054-077e-eb21c7f423ac@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|TY0PR06MB5548:EE_
X-MS-Office365-Filtering-Correlation-Id: 00cb5f90-c5a4-4ea5-e972-08dc846475d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2MwbVVRRXVwSiswNFgwUks1bTAxV3dNNmVzMlZ3U1FEV05aSkxPN3M4TGFi?=
 =?utf-8?B?VnNYbzY0QXlVVVRYOVlHYXFYLzVlOXRpd1FlU3paM1piY2tSbGNNSGQ2TEV3?=
 =?utf-8?B?eTNoNlQ3YzB5UHFLa0ttbjA4b2VodmNGM01DZEJyMFBXQWhQK2FaK3ZnSnJR?=
 =?utf-8?B?d0g2Vk42VEZCVm5KUkFXR0lBaDk0QjJSaFdLK0VsSVYrajRvRU1haW5YSXFW?=
 =?utf-8?B?dTFmUGhDMytETTZWQ2hXVTVMWUVLTGI3T3pSMzg0c2pybGhSSmF2RG42bnFD?=
 =?utf-8?B?SmlYVlQrckh0OGFrazVoTVhXZ1NFOWlyKzhWZjRwdTArbHlhZlB2YWJ3c3Uv?=
 =?utf-8?B?bm1yU0pqbzZMaHo4a1Foa3VWT1ZhK25HdTNNenZ5Qm16ZjZlVlVka0JPM1I5?=
 =?utf-8?B?cDcyemgvV2ZuaDNoY1FsMnZDWGwwMkNHWjJUNzJoOVl3bUZzZzhmUmp3SkU1?=
 =?utf-8?B?a1NxcWM1NUg3YWVqK3M1cWRkcWF1cDdCbE1ERnZaRUNhOXN6TzZRRXNMU3J2?=
 =?utf-8?B?ZzNjT0I4ZnhXeWI4QUUra0NYU0VWK01JVkJweWt6dEZTMzNCT3NhUTM3Rmo5?=
 =?utf-8?B?UWhrMmp0V0cwUnkySTJXUWI5aVhNNmhIK1F4dmlOVHBBTk1JR29mV1V4UlZE?=
 =?utf-8?B?TUVEa2N1aHUyUU1wVGwzODhPYXBtOGdHczZ0WEdyNjhBVzR6MDF1UnpXdWZS?=
 =?utf-8?B?SHNyNUtBaG9ablpuMnd3WGVMK3RBc1dzRFFqVS9hNnZHWlJoVFd1TEtSNlQ2?=
 =?utf-8?B?NVNPWHlzRjBWWEZac2s3VUdNbzVHSVhHR1Z1anYvYTZlS2xDeGppRGozay9x?=
 =?utf-8?B?M0tFbFJ3MlRHUk9haUZPQkpwY3NJaWw2SXROVjV4aUZETy9wU0dFVjhZdEh5?=
 =?utf-8?B?OSt5MEQ5Zm5HRDFxWTc3NXFWUUFvSmJHRjZ1VHMzS3pHMjJlTmVUYjNiRmIr?=
 =?utf-8?B?Lzc0eHFKaHBuaEY3TkFGMklIVjU1aGpXdldjNkRENXkyRUMvRWNOYXdXZmhX?=
 =?utf-8?B?WFBvdXJ1dENXbGgrYktLR254UUdXUk04dGxiUWdEWnFDZGlTRDZCbTYzSEtl?=
 =?utf-8?B?SHJ2VCthKzJxUnRDZjZ0T215WVdEcUFqK0N3WDJoa25JOEphS2FtY0FBc1Ru?=
 =?utf-8?B?bEdHMmtxemRTWFUyZUNEOWlxTjFZTE9NNTErQXJ0eUNvZWlZVnpGQThuS1I5?=
 =?utf-8?B?SVZidktXWFg2R0ZnUUM2NFFqbUExZnZzYlM5d281NGdzenZhc2g3TWp3dDI2?=
 =?utf-8?B?aTlqQUIxdDJPdEhROEFKek9TYUNTVVlWTGFXaStCb0dhVmtxMEU2eGtmQ2cw?=
 =?utf-8?B?a2FKbG1NWklnQ3F0eHdoM0VVTE5lTVlFK0RXRDl5YitiWWNNVjQ4VnROQTRi?=
 =?utf-8?B?UnlXeGw2SjlBVW9YRUFhS1NQRjBkV0FjQnljTndRelR3Vk0wM2ZnMEIzWGVn?=
 =?utf-8?B?OUF6TWNUd2M2NDRmMTdDR1YzdEFrK2pqU2NEb1Ywd3B1UE1hcE9jaVNYNy9L?=
 =?utf-8?B?MXJiZ3JnVEZsTXJ2Zk9DY1V2ZWl6YytsbjZxRVR6VmxZWkdHUytDY3NieE1y?=
 =?utf-8?B?Y1BqWHM5QlVlYjFwVEZTNHFMUHZ1eTM2Sm81aWZHRlJERzFaaEJsMGpGSVlP?=
 =?utf-8?B?ckd4cStkc0dGdTdJMEhWakxtNHdJTUhReGg5Q3JBMnNqc0VyNG1HYzVkcmRw?=
 =?utf-8?B?QUxxRW8zMU1nTG5lZUxHK2JFdHVVWC96SmgyWVFhTFJVb0p3MFVtUUZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K25xTjN0alJPaDF3ckdYYWV3NHlXYjRad0tGdDJHYVQ4RnIyejA2WGxmSHBB?=
 =?utf-8?B?akR0L0g0dHhSZk9rTC9RcG1TYUg3bWNObzJheW0wTjRhM2lzRWRvTUliUGlv?=
 =?utf-8?B?Q2s0ajFXSTdXK0xRZTJpbEZ5TjlxdERqVytyajlCa285aVBsei9PdjNtR0pm?=
 =?utf-8?B?RHhXeEw2T0k5ZkRsOVovUkVKcnlJZzR5OWZQWWFLc1ZYcUhCZWdsS0dzdENy?=
 =?utf-8?B?VmF1UkNlME1LN0FNVnB6bEU0U1BudE5OTE9HWWwzazIxeWsydzQ3dmRDYnA5?=
 =?utf-8?B?WFhFWjZKSTBpanpQZjVoSHc3blZCeURVYTU2OWl3eDNRT1lFOHQrTk5uRi9N?=
 =?utf-8?B?aGpueWoxUjRQclR5eDh5UnVRRGJjVTNqbU5jaWZVMnZXVVBCN2VSNWFVMWZT?=
 =?utf-8?B?LzVwaSs1RDNURmFpTVlmR0d0RjZBcW1qSXh2MTVKaENDYVA1VHFlajNEeHZL?=
 =?utf-8?B?bkN6U2hwZklQK1V5VWp1elk0Y1VKaXJRMGtoY0kyZjdNSS9mSzZIV2kxQ0dH?=
 =?utf-8?B?eFF5NFZldXFxd1V3YkkxMFRSa2s0V2xuZkFGNGRkQSs1UTVsVFVxaGZjNUl2?=
 =?utf-8?B?cy9oSGcvRldNT2tTOHltL1J6Z0JyY2VtdkVscjNwZzVONnNxWE1ZU2pxdXhS?=
 =?utf-8?B?d0F3R0pmNHk3cmlwMzVJNXdnSlZZaGsxSGFtSGI5MkwzVXVoSzZFUmxVU2xl?=
 =?utf-8?B?Vnh2QWpJcW5IT3Z1aytad1lJSEdKaUFqUzdUMHNFdUx5QWEwZW0rRCt3cWRC?=
 =?utf-8?B?dzFHeGZzVHRWbHBnUXhMSWJtUXg1TGpBQzM4QUhpY2plZHYzc1duQTJlSWNE?=
 =?utf-8?B?TThkOTkySHRubllPUU5hWENzNTFNREtsUkZpOVRybDhadzhFZnhsQ2FxanUy?=
 =?utf-8?B?T2ttUGxFRStNbFc3dytCK25GZCtxSmZwQk5Rb1FQYk9VaTg4dlVCWGx3TW1G?=
 =?utf-8?B?Y1h2UGlHMWQ5ZTljb0hhZkhwdHoyOTdoenJSQm40OXJLUm1Eb2xQVUxXZ2hP?=
 =?utf-8?B?MWpkM1R2TmQ2amVXdWNTb3FPTm9md2hGeXVaQmQxY1lEd3hQT3lGUDFRaXdE?=
 =?utf-8?B?eU9IM1NOclQyZTBXYng2ZExvR1VtNXlhOWM5aytFWnhqdGZ3SC85bzdOUUlk?=
 =?utf-8?B?SmtwQUZTZHo4QkpqTVJDMUZjL1N3K09HeVA0SHNUUjIvZ1JYY1l4VlN3emJ5?=
 =?utf-8?B?anBWSlg5WGI0bm1qbjR2YUlpMUNUanQ2U3BDMkxMZ2ZEdWYvbUtXd0M4blJL?=
 =?utf-8?B?akcwUlAxZmhlMEtEU1VFZ3RWWmcrblhpWkkvQ0FKQkVaRUVvaFl5c1NXbXN0?=
 =?utf-8?B?QjV4TFN6ais5LzVObExSakdocXkvQm84SnQyVnBZRTl2MXZ1S3JESFRQd0ds?=
 =?utf-8?B?b3QvWllVZHhMaDJQdXZiOUp2M1IwS3o4SzY5QXNSQXkwU1h0TVB4TmVHaFQy?=
 =?utf-8?B?eXlyT3dvYkFQVk8vbE5FdmlHYitDVnVKK3NCRzNCRWhpVERqWFdOWG4rbW9K?=
 =?utf-8?B?SHowUXd1cEUwcnVzNzR5U1RYWXkxSUt6M3ZJOWF6czlNdmp2TmhiWmFNcDFM?=
 =?utf-8?B?RnZnM2pJNWN0dUpzeHVTU1R1Z0hkVitqbGJWYW9Bb3NmTTZzK0JpQ1VVcEMv?=
 =?utf-8?B?SU1Ha2E2WVRpUGZWZEw0NlF1SWpHcTRDdHduRXdjZ2I5YzNFZ3RydzhLcWVO?=
 =?utf-8?B?Z0dub3J1TC9yL0t4SktXcFM4VHYvZnJQeW9pRkRFNkhaM2NrLzhVYWhWT1pi?=
 =?utf-8?B?NnVUVDEvVDlVWGlmVm9McXVXUzEzMktQUnZJSFdFQ0djZW5pNkhMSm5SbDRx?=
 =?utf-8?B?Y0RldDRVZHFwVHBWUlJMV21yWDVSN21LV1Q2aUdSOHBDRWZ0ZjBmdGdHdE1q?=
 =?utf-8?B?dk9WOXN0ejF6cHZGREdGVnUweHFUNnh0dW9BTXZ4QitYZHNCZ3IrU3N0ZGo3?=
 =?utf-8?B?ZXpPMnZ1cllsUXpMaitLWGJMcS9ya3ZOdHJpNXp6bHAvNFV1cDl6bmlhM3Z0?=
 =?utf-8?B?TXZWMEQrTzNZYW5YS0xhQUpZemVCOFJTU0hSSlBDK3BSZzREK3NWajBoUTFM?=
 =?utf-8?B?MkRES1hwSHdaaFdVZTRIc2p3VHQvQjhNc0twbUFiWVladm5iS25DMFpCOTdU?=
 =?utf-8?Q?O/5dK0e1jolrHKO/7y3Fy66rG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00cb5f90-c5a4-4ea5-e972-08dc846475d3
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 07:03:38.9013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qP3RD7jOqB3yMLZuBqjZp840b0+lLA5GpWrvSiXMMhH8ORaIUT2h2pPncUMcf1zo8Q2gTh+jXiMYTymNI0/LYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5548

On 2024/6/4 14:12, Yu Kuai wrote:
> Hi,
> 
> 在 2024/06/04 11:25, Ming Lei 写道:
>> On Tue, Jun 4, 2024 at 11:12 AM Yang Yang <yang.yang@vivo.com> wrote:
>>>
>>> Configuration for sbq:
>>>    depth=64, wake_batch=6, shift=6, map_nr=1
>>>
>>> 1. There are 64 requests in progress:
>>>    map->word = 0xFFFFFFFFFFFFFFFF
>>> 2. After all the 64 requests complete, and no more requests come:
>>>    map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
>>> 3. Now two tasks try to allocate requests:
>>>    T1:                                       T2:
>>>    __blk_mq_get_tag                          .
>>>    __sbitmap_queue_get                       .
>>>    sbitmap_get                               .
>>>    sbitmap_find_bit                          .
>>>    sbitmap_find_bit_in_word                  .
>>>    __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>>>    sbitmap_deferred_clear                    __sbitmap_queue_get
>>>    /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>>>      if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>>>        return false;                         __sbitmap_get_word -> nr=-1
>>>      mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>>>      atomic_long_andnot()                    /* map->cleared=0 */
>>>                                                if (!(map->cleared))
>>>                                                  return false;
>>>                                       /*
>>>                                        * map->cleared is cleared by T1
>>>                                        * T2 fail to acquire the tag
>>>                                        */
>>>
>>> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
>>> up due to the wake_batch being set at 6. If no more requests come, T1
>>> will wait here indefinitely.
>>>
>>> To fix this issue, simply revert commit 661d4f55a794 ("sbitmap:
>>> remove swap_lock"), which causes this issue.
>>
>> I'd suggest to add the following words in commit log:
>>
>> Check on ->cleared and update on both ->cleared and ->word need to be
>> done atomically, and using spinlock could be the simplest solution.
>>
>> Otherwise, the patch looks fine for me.
> 
> Maybe I'm noob, but I'm confused how can this fix the problem, looks
> like the race condition doesn't change.
> 
> In sbitmap_find_bit_in_word:
> 
> 1) __sbitmap_get_word read word;
> 2) sbitmap_deferred_clear clear cleared;
> 3) sbitmap_deferred_clear update word;
> 
> 2) and 3) are done atomically while 1) can still concurrent with 3):
> 
> t1:
> sbitmap_find_bit_in_word
>   __sbitmap_get_word
>   -> read old word, return -1 >          t2:
>          sbitmap_find_bit_in_word
>           __sbitmap_get_word
>           -> read old word, return -1
>   sbitmap_deferred_clear
>   -> clear cleared and update word
>          sbitmap_deferred_clear
>          -> cleared is cleared, fail

Yes, you are right, this patch cannot fix this issue.

> 
> BYW, I still think it's fine to fix this problem by trying the
> __sbitmap_get_word() at least one more time if __sbitmap_get_word()
> failed.

Err, after trying one more time __sbitmap_get_word() may still fail.

> 
> Thanks,
> Kuai
> 
>>
>> Thanks,
>>
>>
>> .
>>
> 

