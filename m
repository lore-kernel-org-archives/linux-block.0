Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C461A4A32
	for <linux-block@vger.kernel.org>; Tue, 18 Jun 2024 00:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718671710; cv=fail; b=CJj+wKQp/fnlC9SkxIEvQjD7ObtvEs1zJp2dXxiIqMYkQWfipFFm/1nsvUr+wt3maPOA/EYJklg4VgrgbpLvFRGlLxwUhLMvpGN29jfBJrTLjQAy8fDkhun2Rq+QSuOZryIowi6KPbKYASyFCXFDkvOf2aS/5Anf4nSdfORQKDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718671710; c=relaxed/simple;
	bh=lWXYGL3YGA3NSMPHGMMXFgGV7t+mYxG3I+Hj8jnZu0s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eA36ylci29M7oLV5aLL3CKL29xG1xy5v/T1L4D1RSWFWXuIVPsAVAcI65v58tT7CVsf7JWL3nu1PrIIBL8+C1OCTSyRuoSIJ1RNXxp9UpnX+2+clHnkJsYoswNSn/cEUfTYvRpqgFv0PAFILTnDiU8X7xSrMgsHH//3700sSEnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=abvqLs5f; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="abvqLs5f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKvZ0wbgXREbi2az+n2Zt7C2cxdFr5u/DVn2A2PFinEp7Jbw9FymDo0udpYq38QBgdo9oq49rWeNe+nXWNv2Ug6UAHhQ8+vg+pq5j+kQny8IyvqVSdFz6qXDbA/NXMrBo2GUuCMc6TCA0FMrT4YOehsHaxXiS10RL+lg0W8Xd1UCcsbkl0AlYIVmHM8neQ5rDqN57EG5uw4QW4TOwxQytkKytJWQeBSWE6fg0U0yhB+wECmnALn8PF7u9FDxQ9MqN8kvWlzMs6UCww1qNQg3icqbZsUSHDU6WMX1ePx4HATugv9pCxuF5gxvprza6i739eHcPg3eJM0lntMUufw2tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWXYGL3YGA3NSMPHGMMXFgGV7t+mYxG3I+Hj8jnZu0s=;
 b=GxwF2VbelmJUs5dvWlIBcIWdYVuBC3L7VgKR3xUKj+FYd/WHGEabLNJ3C7/LWR0EPFM5bd3Lk29vc4z5qH7yi7Ska5IFbn9/9igEi2dEDGWPnRrR8pMkvslo+woHSjEufG2EZsQBt60paVQ4nT9UsKwMw5mF+YiFuaR2N7Pf0u7OYmTQTvIbIx2AQndZLdQxoG0LS8akvnVZELWDG5ikiBsvZ0b16SLRnVDhpdQsd0SJZeUksfgeo0ZeMnm0IbCRZQGUjRX/YGb+EHlvALj8362ljBphgWTFzSb46ncsgzYEguzAEguxTkxvxATDnZWcNew4+DxPdSPs64C8lsHinA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWXYGL3YGA3NSMPHGMMXFgGV7t+mYxG3I+Hj8jnZu0s=;
 b=abvqLs5fSsOGJ0QlSWq/nOZy0xRsMi+DIQh/pklszw8PfWpWHQi73fjLwSfL7WvZK31SUvQy7/fTps+SylRZ5k6zV3GE+vTBhssi6wzTKONEHhyf8sk8AffjniZNAZc8oDmWZhQRZ/lX8vHxKgW+fCY7sACDItysMjEOb8ZRuJc9/Zu6bRBjMJdys6lwkseQcD4pVXt8eU19ve5rNWY4m0uz/MZ2uyKYxU4YaRkVKDtH9ijpIYJ7uH2ZD6rjnxFOBPhlBWuvr1xCaJ5zDG6Sw3MGjHaSLPVBvhbVZZW+YGnYWmXG44owRtXEf9EFO0OEsV9Zl312zoIJt0X2ODYZ8Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB6022.namprd12.prod.outlook.com (2603:10b6:8:86::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.30; Tue, 18 Jun 2024 00:48:23 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 00:48:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Cyril Hrubis <chrubis@suse.cz>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: Christoph Hellwig <hch@infradead.org>, Shin'ichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2] loop: Add regression test for unsupported backing file
 fallocate
Thread-Topic: [PATCH v2] loop: Add regression test for unsupported backing
 file fallocate
Thread-Index: AQHawK4GJDrYsKlhYkO0SS0aJ+uHmbHMsRKA
Date: Tue, 18 Jun 2024 00:48:22 +0000
Message-ID: <7e01d8db-0cdf-4a9c-8214-56f9f35318df@nvidia.com>
References: <20240617120018.13832-1-chrubis@suse.cz>
In-Reply-To: <20240617120018.13832-1-chrubis@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB6022:EE_
x-ms-office365-filtering-correlation-id: 4b5b5888-1022-4601-7662-08dc8f305af0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkNDdlRMNFVHblRYaVFPWXJ2UEYvMnhHZzYyMk5naDFqbFFsS0VibU92NVAx?=
 =?utf-8?B?RXhId1JRN1Q0VGlPWTF6blRFYVZGZnRDRHNvdExDYWN3K0NxZGVkN3pjZEEw?=
 =?utf-8?B?TEpKd1MrLyt5S1hRSXJzdnNyTDdFSURNUTkzRVNOS1pPRHlPVWs0NHBwRjdj?=
 =?utf-8?B?YTBlMWpoRVVoaTNWOWhxZ2hCU0lZb1ZnMUE2OURVWDlnYnQ4QncxK2JhZ0dp?=
 =?utf-8?B?UmNCYU1vdE1yVkc1ZEtyZUhTT0dFVE1uNldLRnN0N2xaK3Q5SGRWRlJkYkV2?=
 =?utf-8?B?bGIrNzRIVk96N2RmUm9xWnJSa01zWEhOeEUyMExPYTNrMkhpNDRxUldWMm5W?=
 =?utf-8?B?amxPVnUvV2lRcUJIYms2QnhkU0RlOWYyaUJtSk5tYW1TOUV4UFVpYUVxSXBQ?=
 =?utf-8?B?VTRNakI3NjUrcUNnSnhjbW80L25JZDFBL29jYXVCaXV0cTVyZGZZZXVuNURl?=
 =?utf-8?B?ZmtCVHhVMDZiY1U2bk9sWlArK1gyVGpsTGV2ZksrT2tFcjZ5eTdQQUpJOFV4?=
 =?utf-8?B?QXdwbDBWbU9NV0phNUI1N1YyWkdtMm9NYll4V2JMRUtkb09kN0pFNi9scnNS?=
 =?utf-8?B?d1cvV2Y3SGFMcUlNZFBQcVdLM252MDMzOXFBMktuU2JublBHOGRIT3ViditQ?=
 =?utf-8?B?OWV6Zk5DZExmdVNuWUZXOXAyWjlLZUZrWklVRWVTc3NDVUNHbG5WSVdDVnlE?=
 =?utf-8?B?bHFlNTNSaTgwOWNCZWw5ZzhVUHJJakgvMDZMVGhKdE9rQ01WbWxiK2JaN0x3?=
 =?utf-8?B?V05jNEJVZ0ZIcnRNa2pSRUZrb3hSeU91TjlyQjA3TFdYS1VybEM5MVFXTi8v?=
 =?utf-8?B?aGVIeGYwYkkxWlE2WThYbGVhQlZXMk5iQURJN3V5SzBKajl3VmZZQ2ozRmVy?=
 =?utf-8?B?WENYcU1yVmo3a1F3UGVYemVudFRjdjVTeE8wWlZrZ25qemxreWtuWmdzUzh6?=
 =?utf-8?B?aXJ1SnJNc1JaWUozbWF0R2xVZkRzMkplRmFpb1BpbzZYTllHZGozb1VvREdy?=
 =?utf-8?B?ZEo5ZzJTc0V2V1F3b0VqWGNsWUpnOXRacFVIVlBCYmtVRlRMQ0RYaFpQand2?=
 =?utf-8?B?QWVqV0VVS2txRjZ0YU8zMHFUbGFCMnFvalZzMjIxN1NrV2UrL0VPeHhPQmhP?=
 =?utf-8?B?S1hsWHVBekVqdUx5bHBLY3praDh6NmdidWlKZ0o3WGltcUFwU3FUcU5WaTFo?=
 =?utf-8?B?Qmw5bHNqVHlSaU5sYUN4MjRXMVE1S2VnZmNicHNXK0JxMUNRY0JlemdIeUN0?=
 =?utf-8?B?RHV3T290dGJESkllbjJnWTR4aURLS0g2aGF4NW4weFlTNnhXeTBWaEgydzQ1?=
 =?utf-8?B?RGJzTlVLZjB1cmZDVDRFVVhJZlJCQzRHdTgyVDU2ei9oek1YejA3a1ByUmpY?=
 =?utf-8?B?NzN0VU4razF2VlVtZzlhRExKRVNNaEN4TzVERUR1NXltSzlmQ2hzTHFPZ3g1?=
 =?utf-8?B?NjJNdVh0QU00bjUzcEdyTlZTemxJczdvbGVJaElDWGtnTjRzMXFwREJkRmJB?=
 =?utf-8?B?YUVwMTMwMFpIU2NWdzl1dWxseUJocmtRU25ndjFIbmI2QXZiQ1BZWjRwZWxw?=
 =?utf-8?B?OGd2ZHFhR3JIdURha2ovS3I3YkZ4d1RtLzFTWmVKNjBhMDRrMzRzZkdpZW55?=
 =?utf-8?B?ZGJKa293WTNaNndLS1pLdUs4NUdlSG82SnhZNk5uZmkrdTBZTXFkRGxDK0dW?=
 =?utf-8?B?WVBpaFd3MmpXOEorV3hweDlCN291K2QydEgzYWdlTUYrVWMrM1Z3UlB6Y0dR?=
 =?utf-8?B?QjFlZ25ZcEJVejkvMUxkblYzMWRyNDNNa0JCYllyNGMzcXBmKzNHd040anJx?=
 =?utf-8?Q?Xy8Xmmm32NlBoU3bSzNxhfTO6fTOA4fkBxNhw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDVGaC9KMGFtVjNoTUpldk01dnpwcnZYZ25rZDUyb1gvZ3AzakhYWTN4YTZj?=
 =?utf-8?B?bDRVTXZTdmFyK0I5d0lKSXRpN1BFVFZpcUNvU0dhZlJ5RzdEOHdYaUliaXRw?=
 =?utf-8?B?dzJqTVh5NDRQSlJTcUVlUUtPTXFYeDlNMWlNVTdFdXozQzNXZlNWWGxMU2J5?=
 =?utf-8?B?alhtSGt4eUNSWXV2SEZsd0cySVFBd2p5Y29EWWFoc3V3aVFzelJhRTdSam45?=
 =?utf-8?B?Zm1LblRQOURyQ1Q2cHVuaEIvcVFURDNlTWZYSnBKc0NwcTJmZjlJWHBHZWNs?=
 =?utf-8?B?RkpBVzJJNUQ1Y2NsbG05b1dBYTZMVU0xZTB0UTFGdXh3RFpXdEpUb1RkNmVK?=
 =?utf-8?B?NzBLRE90UXlkN0JZSS9INjJsS3p4K3lOK1Jxc3NwZkk3ZWlCNkc0UFhaVndm?=
 =?utf-8?B?RFFNUjlia3h2S09ZNklmdVN6TzQ3VlNOTHRvcWFCek9Dcy9kYjMwTE1OdjFJ?=
 =?utf-8?B?Ny9NeG1pQ2lHMnlNOTVudkdEcVVGM25SdnA2Ry9NalI4cFZVbUZudFZQS2pk?=
 =?utf-8?B?Wm40ZStHdlVQS1huSGoxZTVTTU5VRllaKzIrUXd3R3FyYW5FYXovSUJxdm9j?=
 =?utf-8?B?TTlJQjV2RFlvSGVRMlR3ci9rUEppZ1V1YmZlRjM5djRLOG9VTzJuQjdHL2lM?=
 =?utf-8?B?YTNYWlRGQ29iZ1ZJV2tiMVFxRmRCRkEzRnlwZXYwd3RvYjJScG1TbUczZHo4?=
 =?utf-8?B?RUpGUzV3MWhnUXdqVzhkVGV3V3RuakJnRE5oWlFzdllwSFExYU96U0l2ZkN0?=
 =?utf-8?B?RWEyV1R3OStmQlFwYis0RmhKYXp4RlVpeElTaTFqRGdNdVpHb2R0S3B4c1Bx?=
 =?utf-8?B?RThOUXNEd21Jd2VmbzR2ckpSMzhmUlpTYVU3VUNucXhaUituTFFRcUdsK3E2?=
 =?utf-8?B?MkErSjlNQzJ5UEFIT01Na3BUNXg2VnZlQ3FWaWdrK1M4dC81VDI4eWZTVnVU?=
 =?utf-8?B?NENWWVV5Zno2MHpCVWZycjJWQXQ1MldNK3I0R2FIMkpJaWVaZVZRQlU2QmZK?=
 =?utf-8?B?REJpT3MvdDh3dXBnSTUyaTNweGFkTy95Z0JadEtXbDJGcWszRGlBVHU2dHU0?=
 =?utf-8?B?dkFsTUlueUtybW8vY3Z1K0VyeDBrSXhBK1U5SXc4VENML2wyTTZ1UG5ROVcy?=
 =?utf-8?B?Q3UvUWtKbG9uSFZDZnZuc2ptUzZydlNqS0Y5RnpZb2JlQ0ZSWHdSUU9zNU9X?=
 =?utf-8?B?WTgwL2VmcU83VGd4MFNVZ21PMWw5Yk85Zzh6Z05kbi9tWFc3MVdjblhmd3lC?=
 =?utf-8?B?OU8zZVJpOU9jK2JveGlzL2tnTC8rVE05eEtKalpKdHhWNE04b2Q2TVJhMVh4?=
 =?utf-8?B?U3JOSW12cjBjK3ZSNzJzOHVmamg0Um5MTWpPWjJOWmRKYW1lT2hOOGx0bmRW?=
 =?utf-8?B?K2VycTB6eTVzcEN0OUFvcEpXTVlIYjZJZjJBMDJ4bTZoRXVPbENEL2dBcUJX?=
 =?utf-8?B?RzVjVkdZZklKWjVTblpaOTdvMDlVYVpKMmZ4SzVRU1YyWmxrYmkwOHAyN3Y5?=
 =?utf-8?B?OGcyYXlEck5QbjhPbDJoN0NTT0NseFhUYzB5ZUJaclQxMHZRVTBKUWxUOVpW?=
 =?utf-8?B?RjAxZ2o2S0trYzNiS3JtU3U5NGl6ZExBdmVwaHVWYnVaMXNCN2RUWlN5WnZm?=
 =?utf-8?B?cDZRc0pmcG9wbXQ0WGw0ODlRaWFETDZaU2lPa0wwWEJPb3paSUE4bWRGMTNm?=
 =?utf-8?B?WHBaWWlUTWdtMUFEaHBZcVRpS2R5NFFDSUpvVk9GUUtBK05idWJvWElJSGhM?=
 =?utf-8?B?cU5TdkZGc245WVV3N3RETHRudjk1a09vTEt0TU8wWkxablhqY2FjK3JvRHFE?=
 =?utf-8?B?cGFMaU1EVDBLOXZ0YWhlNEw1TTRBbVRsK2I0SXZQUDFhOXdwa1VFS0FPWFNt?=
 =?utf-8?B?UnJaaXZjMXdaaDNMOXMyWWVTN2Y4WEVDRWl2VCtwT252YWsyYmRRdmNYZS90?=
 =?utf-8?B?cHgrZ2Z4amdOU1lWOVUycUZtWkNMYzQxUTQwR3RKeHd6NXphYmdRd3lJcEZD?=
 =?utf-8?B?TDNaNEx4MzdyNU1wQ213RUg4VDBOVmFMMFZiWG5EMCsxT3UxMU5BaHpncDFt?=
 =?utf-8?B?c1d1NlhrVndkdnJDYlIrRTZuUGZYcUdCTnphSjBOMGlvc0ZNb0ZxTC90V0tC?=
 =?utf-8?B?bE5zQkJkc3o4UUJrakVnWGs2UGc0aGVEQVRPY2pBa25kSzRNdk5rWHlJOG9T?=
 =?utf-8?Q?vHKBsPXN6WOYloltG6xbx/u7cPTLuqtSogsBw3U8v0j3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26A501154D954B46A0FD3C7121A70321@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5b5888-1022-4601-7662-08dc8f305af0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 00:48:22.6656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /s9ZGm5DCEGEsZQpJnHOGveAztnFFkdGLFVHa3TRBtGjjoB2Grg2YLejywpLk78vrOrlRuMkRa/NYaF0LGK/1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6022

T24gNi8xNy8yNCAwNTowMCwgQ3lyaWwgSHJ1YmlzIHdyb3RlOg0KPiBTaWduZWQtb2ZmLWJ5OiBD
eXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4NCj4gLS0tDQoNClsuLi5dDQoNCj4gKw0KPiAr
CWVycm9ycz0kKF9kbWVzZ19zaW5jZV90ZXN0X3N0YXJ0IHxncmVwIC1jICJvcGVyYXRpb24gbm90
IHN1cHBvcnRlZCBlcnJvciwgZGV2IC4qV1JJVEVfWkVST0VTIikNCj4gKw0KDQpuaXQ6LSBzcGFj
ZSBvbiB0aGUgYm90aCBzaWRlIG9mICd8JyBiZWZvcmUgZ3JlcCB3b3VsZCBiZSBuaWNlLCBjYW4g
YmUgDQpkb25lIGF0DQp0aGUgdGltZSBvZiBhcHBseWluZyB0aGUgcGF0Y2ggLi4uDQoNCkxvb2tz
IGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQotY2sNCg0KDQo=
