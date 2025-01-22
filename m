Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C4D214A73
	for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737568164; cv=fail; b=d85voOqJqXYf+k3GmpmjWYB8NDP65rZ5gDy8GDU6sYHlGMsOXWpp7nZQlAmO5nBtXwEiEL9r5ZU71i58ii/XablN1nZuPSpU9gKXI1ObLgjqYqZ0qlUaQzrjXmgh2ddWt9Cg+VRIIXkq+9L5vEzddDY1B2LePD2GrDag151S6hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737568164; c=relaxed/simple;
	bh=z70qleklwRm43DZlTQI+xc7QIet74HS0IHklTK6jNYc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y6Pxejs1IeyQowRx4oURmUFBMZppgfE4w1Ho2lh6FJnNBjV0l/n8eCX39Tnm8KUPvwjfKJWmIIM4ocVEgzpAHEtniWU+374U7n7QQw2A0t3pc4s0qvgxUyDel2UMpWovHJahs+hoqn0Qk8A4nqgllqBoeM6NfDVcnO1rRFTeUIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CWuTm9qa; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CWuTm9qa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGDtZ9obMR535fus9H5Ppaz9b3Xt66dZUYyZtKPK4slB18cU+AFQrpfc10hCNIfxgDB/3+a2WX8oFP8tyiO0eafUuoGR2W4hKzTSd7/uwT3k/edUiwCOAU76DPYgHlLHIrek7Seviamy/nTd8nG3K71XijeFIE4HSkr33DwWxkAFLZDnWoB5rAFZAb4AS+QcLFs5iDC3lkKZ0fTolhh/lmkJTfdYxBmWK22bbWZQFU4DftQOP8LsspXBGqlsW4r3m7JPA+q869Tcs5c+Ad8AwKtQT9oWnOvAFh/0vfJcukzvtpToJHm/wGstlY7SVT08y7h+rufm0oVwp4BvktJMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z70qleklwRm43DZlTQI+xc7QIet74HS0IHklTK6jNYc=;
 b=MrUgCs2562oDvzc9RpmKl2D8ipcFPNggvU1EYqkkUdS485kNFXaznQqzWk41pSO91/4zSt4RXN9fJzOvFa+vupfnkRYfmR0nu+AF7iKajca9FtBEi5BPhHFanDVnb7/KLDALKC0Pptn6tjnad60twSN4UOEGyVK/N2VEEgOHW2XvMlKjmrc5nCYR0QuK/JsG5xP6WgGkmzAAKxoyoHKtVfaBFeQhMeyR3qNAW7b/KS8l5FY1vhuh8kQIJsHAc0EuhUh9JwbF9UusMVRNP/q+RCSaRcjGi0CniO1JucN7NvUR+GuADVWQKLwL9e0et9BaQRuQRezUmWF5xW6InriVmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z70qleklwRm43DZlTQI+xc7QIet74HS0IHklTK6jNYc=;
 b=CWuTm9qa6YZ1xSVixVre1dcNnkd2ngGcVENUlRoCjL3FOEJKTsLyiEOhlznWuZ1NYMVWOuoVajQBM8lALZYUNftO2gbd27/xC6frVswwJ0/7JcRpYM6Irz7jgMlL6T9Ui01u6GU+seDY2dCNHOJEZ3bW+IuIwwtYX7wFt3Omj94=
Received: from IA1PR12MB8311.namprd12.prod.outlook.com (2603:10b6:208:3fa::12)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.16; Wed, 22 Jan 2025 17:49:18 +0000
Received: from IA1PR12MB8311.namprd12.prod.outlook.com
 ([fe80::ecc:e2bf:cb33:468f]) by IA1PR12MB8311.namprd12.prod.outlook.com
 ([fe80::ecc:e2bf:cb33:468f%4]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 17:49:18 +0000
From: "Boyer, Andrew" <Andrew.Boyer@amd.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
CC: "Boyer, Andrew" <Andrew.Boyer@amd.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eugenio Perez
	<eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jens Axboe
	<axboe@kernel.dk>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "Nelson, Shannon" <Shannon.Nelson@amd.com>,
	"Creeley, Brett" <Brett.Creeley@amd.com>, "Hubbe, Allen"
	<Allen.Hubbe@amd.com>
Subject: Re: [PATCH] virtio_blk: always post notifications under the lock
Thread-Topic: [PATCH] virtio_blk: always post notifications under the lock
Thread-Index: AQHbYTG5PPtb1U4eCUarxpU24+zL4bMOWgAAgAAcSQCAFH+oAIAALw0AgAAEfQA=
Date: Wed, 22 Jan 2025 17:49:18 +0000
Message-ID: <6BD82C41-B1C5-44C6-B485-9648C0ED964B@amd.com>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
 <20250109083907-mutt-send-email-mst@kernel.org>
 <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>
 <dcbce68c-f448-4bbf-8db9-c3cd3231b5dd@linux.ibm.com>
In-Reply-To: <dcbce68c-f448-4bbf-8db9-c3cd3231b5dd@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8311:EE_|DS0PR12MB8271:EE_
x-ms-office365-filtering-correlation-id: 1f28eed6-5739-4be4-001a-08dd3b0d184f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bFlhcm1sd1Z6OWMrUXgydW55cFplREQrcVYzaXFRWFpYNUV2eFFQb1VEcFV0?=
 =?utf-8?B?OEZ5ZzE4TmVjQVM5Zi9raHVsRFFPaE5UYkdiTjhvNnVHdkNDaHRMaDgwR01i?=
 =?utf-8?B?V0tUU1VKWjB2K3k0WWJod1FQL3o1VTBBbTUzUktEaUc4U3UvaS9vVUxhL3Fv?=
 =?utf-8?B?TFdHMWw5anUyUW8rTnM1alZUREV1bUs4cXhNWWVPWDlXSm1WNXI4TVkraHZT?=
 =?utf-8?B?eUJ6bGJkUk44OE1Oa3l3VUthUStKVnloR1RQamYwTlJJUGlTWUV4c005Zkd3?=
 =?utf-8?B?WEtvdEdLQjI1NUZJeUN6bzZRZUZBSUE2dGRLM1ZxMlFmaWE3djNyTHNIRHV6?=
 =?utf-8?B?cTl2Qnl6TFFtbTZHUXFpeXdmRXBrKy9ST0xkM2ZDcXp3YjdWUkpQQmdVTko5?=
 =?utf-8?B?Y3U0TzBJYTZpL2xEMnZnZlc3cUVYdWJPOFdzQ2ZaU0pvcy9DcjJPSTVFT0hB?=
 =?utf-8?B?YnlQcWJkc2Fkekl1cXlObHJScURuMnhHb3gwQUhEdCtQaDhxNGQ5MkxYNFlP?=
 =?utf-8?B?V2pGWlVpcVlVUnF4QWhuUUk2Wkh3azJOeW9rNTJzNTFGbzVuTDRCd24zRmZN?=
 =?utf-8?B?MWdNcFpoWnlDSy9wZXg5aldxbnAzbmh0Q2JTbzNmYnNxM1lPRTdwWlRqWVRy?=
 =?utf-8?B?TXRjbHFhZzVkRjVHdk9QZ20vNTBJQWs5NEd4MU9Sbk9scHFmaDVZdlNSdC9N?=
 =?utf-8?B?bG45cGlmcFpRQWlaNjB1OWRlVmJ4ejNaMVFaSytXSVRMVGtQbXk4MnIzMmtH?=
 =?utf-8?B?V1lrMkhGNlhGOXVJdWpzNXlxSENsUHg3Nmt6TitCa2pvdzIzb2FwTHBvdDZu?=
 =?utf-8?B?T3BWL1VPMEhwMlZvbXBKVUxDR2N6c01BNkFWMGZ4WHh2ejJiTGNoWXRmZHVa?=
 =?utf-8?B?NHE0UXZEcEhYYXIwOXpGWE90MXlrK1RwRTVKNmwvdW96ei9JN1o2MTBnTVdR?=
 =?utf-8?B?Y00zMVk5dHZZZVVsRmY5bXV3MWNqT3grR2JadlR2Y0hxVzg5T211TlZtVkJZ?=
 =?utf-8?B?b3d2UVdhU1E5aUh4TjFjMFVmTytUWEp3NHZkQUg2V2tJaDMwSk53ZzRtQVJP?=
 =?utf-8?B?NHZyNG9CUWo3ZGlBbUZ0Q25hMDE3ODRDMjc4Uy9OVXBIZFZiZDZuTHFBUnpp?=
 =?utf-8?B?aHZRU2JMaWgyOHVxcUl6M1JtcEx6Vll5dm92TDM4enE2SlRLVGhDdUZva05F?=
 =?utf-8?B?STNleTh0MlBPRW1rWlB3Vm45MU5PYTZqWU9TRnA1SWQzc1JIdWpwM3Vqakty?=
 =?utf-8?B?Q3dYM2h6TU52SUZzY2JBYitFUmM4STR2MFZKR1RHWFpJZkFma1hHQjYyQ21y?=
 =?utf-8?B?Qk5rblZReEp2SGJLaUNyS2Qra0NMdy9YSkM0UVE3UjBpRmJONjJJM0VBOGwr?=
 =?utf-8?B?S3U5Ny9rRk93Q2ZuZ3Z6OGZkMWcyazRoUStnM2NJQ0lKSXl5UFlzdHlnK0hH?=
 =?utf-8?B?SzdkL0VDZHJvcmpFNWdyLzY0bjFYci8xbFdpVDNXRmFPQjFTREpyRjAxbU9v?=
 =?utf-8?B?YVBBcDZUOGppU05DR2xPNEFVNjk2TXVodkVHS3dqUFhIaTRVa3FhaEh6VmxQ?=
 =?utf-8?B?b2RJQmN0RldLNzVDQ2NrS3hNKzlzcHZ6MGh6Um5Rc3JJcWpFUGQ4RWo5Q3pG?=
 =?utf-8?B?V25JK1Z2LzhlMlYvQ0tUWHNFenZIQUJ0TmpUTEJlUmJSWFpBYjRSdm54Zmwx?=
 =?utf-8?B?bnNRbTAvWVZjY24wbjE4eHVDV3dudnN2T094QVpYMG9ReVhnKytMeDVGTFhh?=
 =?utf-8?B?am84WjdrMThPWmlLUHMraFVCa3ZKeGc5cWlyRzZneHg2cGNCcE9oMGFhL2p6?=
 =?utf-8?B?N2h0Y2dtSmtxLzJKR3NCd3Y5SHVrYmlqNExyb0dwQmh1NGFzM3MvZHFDM3RK?=
 =?utf-8?B?MFgvV1lwek5VSzRoVmhBMTZxa1VCUVNRM1dFZnhnZ0xDeERWNEFrUFpWSkc5?=
 =?utf-8?Q?vsCwX5MNpkH0GcxXmRgy3J6CwTqTdvjM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8311.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0MrWnZGTzRDUStCdll4S3JrN05GaEd2WXRiOGszUkhUNnVlMnd0d3NkRmxC?=
 =?utf-8?B?TDRrT05xU2d6eGVPTStIUzI1SkovUUFEYS9nRWVxeU5MY3poV2xhOEJuR2VE?=
 =?utf-8?B?a2pXZzlQaFJWcWM1UndhT1BDdno1MkFhVkg2MGVleHZnRzV6REV5bGYyZDhu?=
 =?utf-8?B?aURkblc2Mk9zS05DZU1jeVE4dnR5YlpwaXZiYzRYR2xwT3ZROGxSeWVjT25Y?=
 =?utf-8?B?cmM2NUNpY083MXRzT0VxYU12aTlwRE54OWwrMHZWTE1zemwwMUpOS05Vd1NO?=
 =?utf-8?B?RGNBSitXTkthYzJDTnhxbHA4QWpUL1VUK2pKY0orcHpFTUIxSXVvek9ISENu?=
 =?utf-8?B?OUp2QU0wdTdES1FRWGNac1Q4R2lDQVowc0FaeTBnVDJyaktkTllmVFpOZ0xn?=
 =?utf-8?B?RjFJNSs4akxqZkxrNFFTS0J4ejJOMzFDOXczYkZRbDlsQVVFT0dZeW5teVJH?=
 =?utf-8?B?SHNDaHBGQzNWbmhGSTh1b0ZXd3lEd0NoYkhKSjh4bVdrVjhMSkhpT3Y1VkZo?=
 =?utf-8?B?c254N3hxZEZtNWxFZ3c4UVl6SlIrNTVoRGxHaXNNRHFlUzg0WVZzU1lOR0tG?=
 =?utf-8?B?QUVITG9Ya05JczVlZmVTN3dESGVEczJFKzUwa1A2TGc1LzhXYUlXenBGWVVL?=
 =?utf-8?B?YkRwVXo4YUJta2JXSFZlVTNJR045SVo3dkVUeEVobFFCM0hXTzVCWVlKQ1A3?=
 =?utf-8?B?N0xOY0NvN3B0QUJHWHEzNGpsTko4ZmNNcmxkMWFVK2d6SEZIbjVhS0hhYzNq?=
 =?utf-8?B?a2NnTkxVZUtKdllRczltLzJOLzZyOW9wUXFYajZ6bHdHOW5aYk9zTEU5bDY0?=
 =?utf-8?B?YnFTN01Tek1XQ3pMd2Flb1JScFBzRkFocnp2VlNTTjdybXl3b3U2WnE2MHJS?=
 =?utf-8?B?MzdwektZZzlpVmUxSjhaa1E1MzR4UnlrUFRBWjdkTG9CeXZTdG8ybFc1MmtE?=
 =?utf-8?B?b09ibFQ2OXVPQ1QyZFE4amtkb2t2eWtMeHBqbXZ2STE3aW5KaVkzRzZlV0JB?=
 =?utf-8?B?ZnVLaFdLQmp0cmNxNVlZRDhhamNKZlF6QVp1VlJKUU80MlNGcjR0RzhRZUVN?=
 =?utf-8?B?WXJCYW5oR3FXYkJJeUdlUkx5Sk0yZHI1aUsvZzZvM1JTeHBCdTNhb2ZqZ1Y2?=
 =?utf-8?B?bjBHb21XeFRhMDEwM2IvN3c2NVRDQ21IdmFKMlNxZk1ra0R0aUdGK0RaMWhT?=
 =?utf-8?B?MW9qZ1gweEFzVndXdXF1RlZybk5KRlM1U1lwQytoRTZaM1M3YU9UYURKS1NZ?=
 =?utf-8?B?N1Q4cWk4TXdzRFdSMlJlRjNUZERNMThkOS9zMEoyaFhERzkxZkNxQmthSmdK?=
 =?utf-8?B?dlRJSk12T3pldW9Tb1ZvN1FRdTV2VFVIV0hlb0tqMVd4Qm5iWlM3dW1YR1Zv?=
 =?utf-8?B?MUlpL3RISlpkczlhWTByWEZsYkN0b0ZaWlRuVlZPM2o1dy9SblJoWTh4Qkxp?=
 =?utf-8?B?Y01rZWpYdWNKc3lOMGpjek1EazVvV0RSS0RzZmtTTW50d1I3OFg1NzdZNXAz?=
 =?utf-8?B?cUpSdDNVOUJsMXUrL2pLdEZna2JveFlUS0dJOWo3YTN4T3g4S1JsbjhtRTN2?=
 =?utf-8?B?dDdBSktwQzhqMks5aG12UktFN3RsbXdvSDBMVEs3aUlmUUdGY0xZdXlhSXNU?=
 =?utf-8?B?OGp2SEZBUjErYU9tR29hMVhaekFBdFJ6WmNCV1NMek14ZUVoeFFPWjVxbHpB?=
 =?utf-8?B?LzdKY0E5RlhnczZoMkFSQ0ZkMTk3c0pIeGJpekpSQytMN2NOOXNsVmFhZ2Fx?=
 =?utf-8?B?ajZrbjYxTjI1YUhFZ3k0N0Ria25BWER6SDZEc2prMW01TXFBZHo5ZVVFL3ky?=
 =?utf-8?B?dUF4TFNYWWNzdWlWSnhXdW1jRTYzWEdJRU9tN3lLMEduR3VXRWZKcUV2b2lF?=
 =?utf-8?B?VzFLS0VrK2pRRUpKalU5aVA1VnRUVHFqbDVXL0hURytpc3N3L0M4SmthUWdw?=
 =?utf-8?B?R3RzcmRaR1cvMHdqL3ZRU3FrclB6MWdCeTBpNHd6ZTV4MTUzVXZZUjE1Szg5?=
 =?utf-8?B?TkZTdWZhME1ydHIzRzljWHJJSU94alk3RWxYNXVRZjdlY3JJaC9UcUNnZGxK?=
 =?utf-8?B?NkJ3djJLVkdpQWtyN1NBVlNneENLZGJEanpCdGdoRktkSENkeTlxNi9HV2VP?=
 =?utf-8?Q?6c7Fzj+0rGLudIo6DSOWP1EOj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <979DC52084C25144A497FA640E8656A1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f28eed6-5739-4be4-001a-08dd3b0d184f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 17:49:18.4713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IopqmiSlY3BT2pOlovn6Q0dYuHvWyxZfWxWS7kyK5OEMySrXMGS5Bb4RttXCneDv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271

DQoNCj4gT24gSmFuIDIyLCAyMDI1LCBhdCAxMjozM+KAr1BNLCBDaHJpc3RpYW4gQm9ybnRyYWVn
ZXIgPGJvcm50cmFlZ2VyQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPiANCj4gQ2F1dGlvbjogVGhp
cyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIg
Y2F1dGlvbiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNw
b25kaW5nLg0KPiANCj4gDQo+IEFtIDIyLjAxLjI1IHVtIDE1OjQ0IHNjaHJpZWIgQm95ZXIsIEFu
ZHJldzoNCj4gWy4uLl0NCj4gDQo+Pj4+PiAtLS0gYS9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsu
Yw0KPj4+Pj4gKysrIGIvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMNCj4+Pj4+IEBAIC0zNzks
MTQgKzM3OSwxMCBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fY29tbWl0X3JxcyhzdHJ1Y3QgYmxrX21x
X2h3X2N0eCAqaGN0eCkNCj4+Pj4+IHsNCj4+Pj4+ICAgc3RydWN0IHZpcnRpb19ibGsgKnZibGsg
PSBoY3R4LT5xdWV1ZS0+cXVldWVkYXRhOw0KPj4+Pj4gICBzdHJ1Y3QgdmlydGlvX2Jsa192cSAq
dnEgPSAmdmJsay0+dnFzW2hjdHgtPnF1ZXVlX251bV07DQo+Pj4+PiAtICAgYm9vbCBraWNrOw0K
Pj4+Pj4gICBzcGluX2xvY2tfaXJxKCZ2cS0+bG9jayk7DQo+Pj4+PiAtICAga2ljayA9IHZpcnRx
dWV1ZV9raWNrX3ByZXBhcmUodnEtPnZxKTsNCj4+Pj4+ICsgICB2aXJ0cXVldWVfa2ljayh2cS0+
dnEpOw0KPj4+Pj4gICBzcGluX3VubG9ja19pcnEoJnZxLT5sb2NrKTsNCj4+Pj4+IC0NCj4+Pj4+
IC0gICBpZiAoa2ljaykNCj4+Pj4+IC0gICAgICAgICAgIHZpcnRxdWV1ZV9ub3RpZnkodnEtPnZx
KTsNCj4+Pj4+IH0NCj4+Pj4gDQo+Pj4+IEkgd291bGQgYXNzdW1lIHRoaXMgd2lsbCBiZSBhIHBl
cmZvcm1hbmNlIG5pZ2h0bWFyZSBmb3Igbm9ybWFsIElPLg0KPj4+IA0KPj4gDQo+PiBIZWxsbyBN
aWNoYWVsIGFuZCBDaHJpc3RpYW4gYW5kIEphc29uLA0KPj4gVGhhbmsgeW91IGZvciB0YWtpbmcg
YSBsb29rLg0KPj4gDQo+PiBJcyB0aGUgcGVyZm9ybWFuY2UgY29uY2VybiB0aGF0IHRoZSB2bWV4
aXQgbWlnaHQgbGVhZCB0byB0aGUgdW5kZXJseWluZyB2aXJ0dWFsIHN0b3JhZ2Ugc3RhY2sgZG9p
bmcgdGhlIHdvcmsgaW1tZWRpYXRlbHk/IEFueSBvdGhlciBqb2IgcG9zdGluZyB0byB0aGUgc2Ft
ZSBxdWV1ZSB3b3VsZCBwcmVzdW1hYmx5IGJlIGJsb2NrZWQgb24gYSB2bWV4aXQgd2hlbiBpdCBn
b2VzIHRvIGF0dGVtcHQgaXRzIG93biBub3RpZmljYXRpb24uIFRoYXQgd291bGQgYmUgYWxtb3N0
IHRoZSBzYW1lIGFzIGhhdmluZyB0aGUgb3RoZXIgam9iIGJsb2NrIG9uIGEgbG9jayBkdXJpbmcg
dGhlIG9wZXJhdGlvbiwgYWx0aG91Z2ggSSBndWVzcyBpZiB5b3UgYXJlIHNraXBwaW5nIG5vdGlm
aWNhdGlvbnMgc29tZWhvdyBpdCB3b3VsZCBsb29rIGRpZmZlcmVudC4NCj4gDQo+IFRoZSBwZXJm
b3JtYW5jZSBjb25jZXJuIGlzIHRoYXQgeW91IGhvbGQgYSBsb2NrIGFuZCB0aGVuIGV4aXQuIEV4
aXRzIGFyZSBleHBlbnNpdmUgYW5kIGNhbiBzY2hlZHVsZSBzbyB5b3Ugd2lsbCBpbmNyZWFzZSB0
aGUgbG9jayBob2xkaW5nIHRpbWUgc2lnbmlmaWNhbnRseS4gVGhpcyBpcyBiZWdnaW5nIGZvciBs
b2NrIGhvbGRlciBwcmVlbXB0aW9uLg0KPiBSZWFsbHksIGRvbnQgZG8gaXQuDQoNCklmIGhvbGRp
bmcgYSBsb2NrIGF0IGFsbCBpcyB1bndvcmthYmxlLCBkbyB5b3UgaGF2ZSBhIHN1Z2dlc3Rpb24g
Zm9yIGhvdyB3ZSBtaWdodCBmaXggdGhlIGNvcnJlY3RuZXNzIGlzc3VlPw0KQmVjYXVzZSB0aGlz
IGlzIGRlZmluaXRlbHkgYSBjb3JyZWN0bmVzcyBpc3N1ZS4NCg0KSSBkb24ndCBzZWUgYW55dGhp
bmcgaW4gdGhlIHNwZWMgYWJvdXQgcmVxdWlyaW5nIHN1cHBvcnQgZm9yIG91dC1vZi1vcmRlciBu
b3RpZmljYXRpb25zLg0KDQotQW5kcmV3DQoNCg==
