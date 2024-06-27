Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC6113AD8;
	Thu, 27 Jun 2024 03:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719459847; cv=fail; b=B+Ry+GiV5Ao3UqWxCLqrUUqkVjL9Ygh/KWQXe0lySSdSi8eO0o5UmxLx8Mgs4LczmcYIgmGO3sHcRwAro9pLHk2Sr3CIw3IchyEbr9zLVeIFag2+ipbVvwQVBaV5vRP8rH+v6P29q705ohZ6GQXIJBsU6+GCeclieHjKJRj25SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719459847; c=relaxed/simple;
	bh=bvcgZ90YD7EZSoIT0mECXK6hLTEXtRrE22NcL0f/zwA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c1+XOTpjkIC1nTzyeST1lALHPv+PCRWOEE5nlFhhYyHvawBFjVyYA4utkRMaX9YN7FlwmCTkrAAWi8xM093elzgJElRfBKvYnp2nFxP/tzP+FI2TvH0thnDVGaj/huIbx3UjFJFZHVB2ICDG5vljaQJ0vlKjiT02eYNpeen865w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iT8uHHnh; arc=fail smtp.client-ip=40.107.100.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iT8uHHnh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8A5NTwsoYtPhr2NQjU98a+/0sRZXKlTRKl9Vx7zgeWRyJrvTm96f3I1r1fwRr9YQGJnBFzTEsL+xWmtPgcMfJiTHEBcHy66lIMzTkUMb4viHa+KBltlemtu1XBY+V+fgBxGNQ/Gke8TcWZwZHqPO2X6X/4MGoiAakfQkWqfvwCjBf0tEznk3c5Azh7iXQ0khU3q+BYQHgyGKab3Zn1+O86qOl0GE4JRLUW8XZZjTuC+QOrODcmo0JNGHdMP6vxRmwbabXxG8tm8zDsSslzC7e4M/+WDIrUFWUkr8mjQffhu7HhowTSlJggG4YKke4T5JBYKvrR0ng5+fsR1ikcVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvcgZ90YD7EZSoIT0mECXK6hLTEXtRrE22NcL0f/zwA=;
 b=CyubnIsbanKJdn1OOKPw2phr3sspKKCP6vlFesETZb7EjNcrUK0T1ue68e6ZAH4zUfgFtNe2azmSg24XKARnLnzYr0TS6VMoz/l/PEpYtuA7gMO6iVz+RSQmMKQJYYifyAaQXPzoXdclfXSU8+ZkpuC0ndISivlN93G7kMDfBNvFboEP3j7FUImwRDMZjE7ZYqoq55lIiCN3zTu0/MBeUbPCAyKbORG2HquxAhx35nVv/Kx4NtdHhkZbNPYXdH3YLIZ1tjI5zbw0uWu1mCaZ2Eisl8Cze/QzsJ/+zX8dQlMLGTYbdL9kzCCK3MACupztomw+7SuOv5kDwArwdiNWtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvcgZ90YD7EZSoIT0mECXK6hLTEXtRrE22NcL0f/zwA=;
 b=iT8uHHnh7qSDYxXj6B0crhvpjLNOHzxqbZNy1/Z5TTPsOZHsVjX31kc97IgL3gYXsz72KknG6BcQHSw0Onm3hC9kbMGKf2hfcu1K+MV0cLbKq4EWdqz/HI4PAwNChbvC9C65rCm8ObzNkWg8x/XaFH4ovSoMMQgkuKoGMOKgjM+G76blJaOdI5uibtJrrIkLqwVUeGh5I7ihIjRvFz+n5b3YuErBdgJodusQnL3p4gLLx6D2Y1T/KOJKiRKci2nCHE1Q13wxsyUDi6gcqxAyTOWvFTu6m0TuRoDjWC2HpqEpWqKo0GFo6+UFJHRx8PNg7atMllPBi+eK9ShZkS3Zyg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY5PR12MB6622.namprd12.prod.outlook.com (2603:10b6:930:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Thu, 27 Jun
 2024 03:44:02 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 03:44:02 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linan666@huaweicloud.com" <linan666@huaweicloud.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hch@lst.de"
	<hch@lst.de>, "yukuai3@huawei.com" <yukuai3@huawei.com>,
	"yi.zhang@huawei.com" <yi.zhang@huawei.com>, "houtao1@huawei.com"
	<houtao1@huawei.com>, "yangerkun@huawei.com" <yangerkun@huawei.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: clean up the check in blkdev_iomap_begin()
Thread-Topic: [PATCH] block: clean up the check in blkdev_iomap_begin()
Thread-Index: AQHaxvbBgy7abqndM0m6RkQSqpCgcrHa+pIA
Date: Thu, 27 Jun 2024 03:44:02 +0000
Message-ID: <e629ae7f-509e-4cab-b069-54e889bd8cd0@nvidia.com>
References: <20240625115517.1472120-1-linan666@huaweicloud.com>
In-Reply-To: <20240625115517.1472120-1-linan666@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY5PR12MB6622:EE_
x-ms-office365-filtering-correlation-id: 079666b4-e125-4671-4db9-08dc965b62e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3Zxb1VnZE9ZaVZxbGIvZ1MyRC9naWtPaHBMa0RNYzYxYkpiSnE4SW55bEhL?=
 =?utf-8?B?UTJ5azQyazMxSkxHTXIwT1pSeXRWajZCT1FLQi9QeWlsODhpTXNwZk5qMng1?=
 =?utf-8?B?YnFBQWRySWZyUC9LODFpYU44K05aOTJnbTNLd0thMHVzeEpXamdlNG0yYjF0?=
 =?utf-8?B?dEQ1M3I0bXcrMzJVWDJPb2VySExxNnR0YkxiYUZJRlIyZWdZVk1KMnVONmFw?=
 =?utf-8?B?U3p1MFhXRG15Tkd4cWUxdVlWQ2lNSG5IM2lGTCsvOUlvbkFuMm1qWElTMzNL?=
 =?utf-8?B?T1dpVUowdk1sejQwTko1VUlIejhkU2h0T3o3bkJmb2dWT3JCeXBLeGFlZXZC?=
 =?utf-8?B?R20ydUhDV3Fpb0crM0FuV2ZCVmx1SUQwQ1ZuQXZXa3phUGxqQUUyVTFkSmIv?=
 =?utf-8?B?SE9sZUZ0cFNRc2dmRGIvci9pOVAyeUFXTFNaREloWGcyMkRDd1dWRkVXTGZ3?=
 =?utf-8?B?UjlNVWVPQ2lJZDBRaGdWWGkxcnduL2RHbzVselZYMmZXVGdPOXZyamhIQ3gw?=
 =?utf-8?B?VkpISEV5REFjYUlCeVA3TFNyTHRWNi9ucCtpeW50RElSdUpXOW5ETklkVXBT?=
 =?utf-8?B?NEs4aUNZMWFZSC8zNTduekFrdVI4Vit3VTdnQlhPNEM2Y0lDNWpnQXVoSlQ5?=
 =?utf-8?B?RVdCWVUzdmxWOERtODNPNjRIYk5RUUlIQjdwYTkvQnRHUmVUTnhDT3lwTjRZ?=
 =?utf-8?B?czRwWHZ4VnJFWDE0MWVZWGora3Z6eWRXdHMxN0xsUjN1UUNBeUhIeko0MGRu?=
 =?utf-8?B?dnlzVTh5V2tUQ1BJZytzV0dqaEtCRzJnWSsrUXhuaWpYejVka2VOdU9uaWIv?=
 =?utf-8?B?WGtuR3AzZmYrbm1QUFNVWjFtTVhKVkZ6ejFuZFg5cnBVWnZlYURneVBDNkF1?=
 =?utf-8?B?b29BR25nWEFlSXB2dXlXdWpuYkx6MWNvZlFqZTd5QUp2dXI5SnMxQXFlQlJY?=
 =?utf-8?B?NUNSaDJBdWZTbk0va1U5VkJSbEM2czdnTUtKQlM1M0szZDRRRlFUUVRyOU1v?=
 =?utf-8?B?dGVrZHIwWmthSWVSUmtsS2pUY3FudVhtOU1wMXhNa3dwYjhhMXBZcE5xVEl3?=
 =?utf-8?B?VDNJM3BJa3Y1cjBWN1RnZXkzRklrb3ZjTXJoTkc5Y2tRa2NQU0RGVlhpYXQv?=
 =?utf-8?B?SFZXSWJaejM1U0lKeGdLTnFmTFliSmQ5ekhLMngwM1duNUlrMWN6a05CdU1x?=
 =?utf-8?B?RW5ucWM2Rmt0bjdFZGJXZXVSYXFYZEFaTzNidTRYYXhNMXRyYW9xN0JFcFdm?=
 =?utf-8?B?eGNNc2g4dG9iaThhTnVZTXlPTzFqbk5jWkVoN0Uyb1NKNDRYdk5TbE4xOXFB?=
 =?utf-8?B?YjUzd040dEhhODdld1RTeFJBZUFrN1NuMEU1bFFhbXQ0Q21wTmhYTGNPSEw1?=
 =?utf-8?B?eFRwZVVOaE1PMko4N3lRbkNUKzhYWFY0b1lWVmVYWmpkWGpTbXQwam1RQUlj?=
 =?utf-8?B?NnBQZmpYSzVCc0p5TTdGb1VKVkJUY3p3bGU2UXlDcmZEWUkxVW9SeTE2U1du?=
 =?utf-8?B?TS9pUi9sZUp3TkN1T0JIK3BwbmpIZFBUeHMrZ2RLMzBZMTU4MHdXZmlvNXJW?=
 =?utf-8?B?NU92MEN5MHRpMUw1ckd1dGJwSVpQb1V5NlJyN1RHdytvcVA0UFJzTFl3MWxh?=
 =?utf-8?B?dGVaa0NnTU5PZ0VwdTJ0UnRSdUExaHFoU2p6SURFZitIQ3UxSVl0TUpnUGFK?=
 =?utf-8?B?ZkQ5ejJHbFBhZWlPckdyL3FIRG45eTdZc0djVFJJcjBmUE9idTJSWU5ZVVkv?=
 =?utf-8?B?Wng3NEJsVVJrVUhIN1JlRU1CVlp3SnlUMk4vRGt2akJFaVFvYmtEdERXUzBn?=
 =?utf-8?B?TStGSlRxNzRabWpNVkN3TW5wTWV6dUpTM2k0bE90Y21ZSCt4OW90S2tWaHZ4?=
 =?utf-8?B?Y0g1N1Fhakh1S3NialQzbzhHN2JCQktKS0NKM1ZURUM2aXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L1dLUUMyVklYVGdqRlZXVGI2aTFSaWFTTFdCY1lKdVdwMXhkUFdQL3hsSU05?=
 =?utf-8?B?QzR5WGZtN1BwWlU5ZndFOTlWYzlWOXNVaDB6MUh2cTQ4dElHeEV0YVhlc2xp?=
 =?utf-8?B?bHRhZkxNaWNtSGxiaFNiZU5LVGNreTIzMXhiVmRBMzRzelRFQlBmVHRYb1F2?=
 =?utf-8?B?NEhFakpBaDRMc2pHbnZpR3dTQ2xmOGJqQUxoMk9ybkdUUUNRZjBtTVY2emNC?=
 =?utf-8?B?U0xpcXMyOTd5WXBmODBGZmNOKzRDdUpiREl5STdnalJnL2NPMlUzQi9EUzI2?=
 =?utf-8?B?VjJQQ0ZmK1dwa0YyMjRGTXhFZnEvTTZlNzRhT201TklhTGZIMjllc3ByZmpq?=
 =?utf-8?B?bWRqZzlxTHk1WnhESVRFS1hsSTVDMjNLbmhERGlZMVpOaFNWdVYxYmFrblY2?=
 =?utf-8?B?TTZzZnpTZ091bFc2RnhpNC9KTXduZHNaVEZsL2hESExQbWJBU0pCeFczMDJL?=
 =?utf-8?B?Y05acitTaXNXV3BLTjFtRDZHMWxxKzB1V0lwTHVMcnM5aTJreURJWmhkaXB0?=
 =?utf-8?B?OUdzeDlTRXlCQUpPTGVsM0RqeVVlM2p2czBxeElSb3FBV2F3dWhxRWFqNnJ2?=
 =?utf-8?B?SUxNVjYwSkpnQklMcXYxUmdGNzBMRDc2UjA5K202QUYwZTZiQ0JBK3NWRHRP?=
 =?utf-8?B?UXloM3djSmVLYVFnNmxkSEtzNnEzRkFKWnE0TXFnUXN2cW1ELzA4NWs5K0RG?=
 =?utf-8?B?S1BNQWJlZzZnZlJDR3o1NmQ1a09QSDBqbUdIOHIvQ25KUmFNaVFINm9uYi9E?=
 =?utf-8?B?MFZGSUNVeXNWUi8ycnhwZ2poWHlDWUJ0eHJOaGZaMml3Zk04c1VPOFNHZXdp?=
 =?utf-8?B?QllyYWlXcThYNEJOSldXQUd5K1JZZUl3cHhzQzdUTGdnWHlhVE1Oc3BEejEw?=
 =?utf-8?B?NUs5bHl3NVlYbWZHRHFrSy9BcWJVcUkwV0NONlhkbVI5KzhNc3M0Ylg4bmov?=
 =?utf-8?B?ME8vOVY4VDVyWUFjaXFoRklvTE5rRnF2dE9lYWkvOURqdytGY3FQWXRBOS8x?=
 =?utf-8?B?NXZ1dnZ0OHVqeXZLaHZNTDlCYmxWRXFXUEtQWUkydWxiRzZEc3hpTXlmcjU0?=
 =?utf-8?B?dUhnR1BLcHhwTXdwVEU3S3ZQQjNibTlMS1BRVGdCalhQSjdKVnFNeFRqaWtn?=
 =?utf-8?B?MjhPVE1WQ2RwS0JaTjZOUGtMS1Z3NFkwbitwQnVXeU9jTVg0NkxsaERjWmxt?=
 =?utf-8?B?L1FzTmRmcnZLUml2ejFYYzVOTGo0S3ZtdHRoT1R2MzR4NHVqUUpFdTA3YUQ2?=
 =?utf-8?B?QjBzZkc2b0dmOTI0TW93R3lLZWRSd0hLZGJsZUo0Q2tMOGNzaGNvU2RCaGVE?=
 =?utf-8?B?dXZ5ZUVvbU80QkVMSnpUR21FTWpmcGxjUTVQUFg1QkxtU2ZPM2QySzl2Ky9Q?=
 =?utf-8?B?bWQyUnNVQmZzNVVTOEdkZ2lvSURYZWhRWk9qVEkxcm9ETEt2NWU2K3U3N1lm?=
 =?utf-8?B?RFZzRGZIZVpHUXI2MFN4QnQvMVRCWWNYNXhrZVdLTEU2cFZ2L1p3M0t2WVk4?=
 =?utf-8?B?SjFLbDJucjd5Vk9PUXRPQVZZNThXZ0JEeWdURUJsS3VIU3oyZVVURnplZDh3?=
 =?utf-8?B?M09IT09pZ3JFRGNSRGNvS3g0Um0xVWxiTDM3cUtjYkRyUzY3SU5TTEV0SVJB?=
 =?utf-8?B?Y2QxVHI5K0dkQmoxcE1NK00xd0JCNXpRaFkvZGkzdVNlNG9XcWZ4dTlDanlo?=
 =?utf-8?B?VzU1WHl6R0ZxNkVzZEw5Q1hVYU45Uy80UkNTMnNLTkFYRHZJSjA0dm1mRFEw?=
 =?utf-8?B?SnVNS29jWVpoSzBZUjRKMlZrVmxtY3VWOXZ1NmNsMWFFS2FFZW94dFp3NTRS?=
 =?utf-8?B?bisycjRqa045VVM0QjEwc2w5VFRid2tNa2JtczhWQWFOUUdYeWlxZkFCN2N4?=
 =?utf-8?B?UGFEdWVTTTR5eWtkQllVa25SNTcxaUlqZE5SaERyWDE4T1RLeUlDQnFCOWtu?=
 =?utf-8?B?UGFGNUhmS3l5VHRqMWxML2ZBRVNiWlJUYS83VHBXdi83S04ySW82YjZNSCtZ?=
 =?utf-8?B?QU1PbDY0ZUVpNElHTXpWTWpjUFZ5RHAzQnFSdlFHcEs5Z21IYXB0NmtiRnZ6?=
 =?utf-8?B?NUpFNUhOb1ZBMXliTk91RWpUYUFPQjF6dURmY2VnL0JuVEFOOWtLNzBPKzhQ?=
 =?utf-8?Q?2wRie5GtDIIt1UbyIsqeEj+bl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A14C1975E90ED4AB108E5474D5FADE2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079666b4-e125-4671-4db9-08dc965b62e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 03:44:02.4612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K9VZHEjVE7mjw/Hasjim9Ox0UweOzHMiQpVb0dpybi4/bkSI1qd1cjZWSlTxQY4d5xjtpZTIrImS0FFEFcs1Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6622

T24gNi8yNS8yNCAwNDo1NSwgbGluYW42NjZAaHVhd2VpY2xvdWQuY29tIHdyb3RlOg0KPiBGcm9t
OiBMaSBOYW48bGluYW4xMjJAaHVhd2VpLmNvbT4NCj4NCj4gSXQgaXMgb2RkIHRvIGNoZWNrIHRo
ZSBvZmZzZXQgYW1pZHN0IGEgc2VyaWVzIG9mIGFzc2lnbm1lbnRzLiBNb3ZpbmcgdGhpcw0KPiBj
aGVjayB0byB0aGUgYmVnaW5uaW5nIG9mIHRoZSBmdW5jdGlvbiBtYWtlcyB0aGUgY29kZSBsb29r
IGJldHRlci4NCj4NCj4gU2lnbmVkLW9mZi1ieTogTGkgTmFuPGxpbmFuMTIyQGh1YXdlaS5jb20+
DQoNCml0IGlzIGFsd2F5cyBiZXR0ZXIgdG8gd2FpdCBmb3IgYXNzaWdubWVudHMgYWZ0ZXIgYWxs
IHRoZSBlcnJvciBjaGVja3MuDQoNCkkgYmVsaWV2ZSB5b3UgaGF2ZSB2ZXJpZmllZCBhbGwgdGhl
IGNhbGxlcnMgYW5kIG1ha2Ugc3VyZSBub25lIG9mIHRoZQ0KY2FsbGVycyByZWx5IG9uIHRoZXNl
IGFzc2lnbm1lbnRzIHdoZW4gdGhpcyBmdW5jdGlvbiByZXR1cm5zIC1FSU8gYW5kDQp0aGlzIGNo
YW5nZSB3aWxsIG5vdCByZXN1bHQgaW4gY2hhbmdlIG9mIGJlaGF2aW9yLCBpZiB0aGF0IGlzIHRo
ZQ0KY2FzZSA6LQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGth
cm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
