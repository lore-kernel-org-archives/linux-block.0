Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012008.outbound.protection.outlook.com [52.101.126.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBB929B8DC;
	Wed, 13 Aug 2025 03:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755054328; cv=fail; b=g/jg0YmTwpMmuiMcWmGVYT/ZGCLSSb3XUT4vVtoqMMqIGg3N2eGoNa93kEYJNgxt5sMdVmEivs1m5Usbe3It995CwAQY50pIl7xH54J8PGBUaBj0YyeaZM/pS3Bvj+f1SrZzYa6Ou3sMMi/xFfm7f7hFu+50Rgw9hoT65ae996E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755054328; c=relaxed/simple;
	bh=rEqJPjpN+m8tvYEQJGu60Xf8hGBdMIIM7F4dss5SmM4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uqRggEJMDB05LWnSh9nfM/m0jHxVEcOnZPnguFgin5GXri3VNrz3O+MDbkUqG4p34l9sj9AXOf8pT63IrWOsEJvL0wRyVMINhcdeTlo8aXNM6Eocbvn3/66KiyPTMRHa5rijSizhkawRluJVVyzTqYMRxeuPMEW6G0rf53cM8jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Z6+Zoz73; arc=fail smtp.client-ip=52.101.126.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Z6+Zoz73"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Am3wMFJPHdSpTJTphYktz16nAoSsdCuWCT9UDyP5koCTIu6K8LAtYic/3UGpBrVPFaoqa1/UtkNNw/W7CwEGey/Ak8bf2KrTS/K+FUMnOikSdALOBfbDLi5svHpfaVvz0OxDSY2Hk9JRvgXngDcxXhQnarXZqwxYi1nQ/tgXIE/DXEODGoM+RMDyMfEYJQsLq/1qywm/Qsm9KjTA+5jjUnRe+6Y80cv8IYWqccikhz6Rwxh8L6dl/g3+S2Y2JM5MZkbxaq6zRyz5SHQOreSmxZ9w+KaThPlLLU36jVMKD8uRuVbttodyAz+1z/2VVA1H9PMXnjHwPs0KaJXpS/jpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEqJPjpN+m8tvYEQJGu60Xf8hGBdMIIM7F4dss5SmM4=;
 b=aavJPwJnLAcqVUGCYNe9akzGi7eb3iXlX8kU1fx17T4tBPR0++WcEvbMRc2LARMp/qtAYNrUSuOuCLzf8QKUgPa0PSXH2V7Rt2bS7vxxFOOvmlLr1p0XjcWuvEXKdUhIzj0XQKw9YgRG+xU7Ts4Zp+rlppJ+FXQwD1X8TX8hQBVXyU4AtVnfYILYystmwxsPzUsDSZhRog1AKwJtSc8pKT9Yr0aazrT91F9/6xYzmCa5tl05w+ZrA1Zd5T/8g4wTOoIq60ARCBP484XKCQWus0TEtGSLPt6jvl+/xc47nXxQ8KKr/MdfgRlLSDYlm98SaJkNcRl2jPh2AZiJ6S86sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEqJPjpN+m8tvYEQJGu60Xf8hGBdMIIM7F4dss5SmM4=;
 b=Z6+Zoz73uE/V24RZFVEaC3CtE0nDfH55kI5GDmP2POLekz5e6qPS3NiRyHw4iKwjjjMe6s8Pn4bK9BSzeoUV0sGR6kZscrLcPau9PVESgp1vrxDWLTn1E/iy282B81kpMNbxR7BzYvA5pOdfquwbWv2s6OCt8oMVfm3OhUG0yOfalgAqnk4K1HFkBEsSMimpiQ4K/lMzpdOG70d0aJ3F7u1CpvQEpY8lsCcwFtfZUFwRkTsYCBbnjgPUSjSo12+zGYmSusZVEmv9IfZLXD8NdmU710e/QiuynoVjC9RO7P7TOAoEudXQSrhou5GUlzzWEh5qAU4qPD+3fSv+Ra25bw==
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYQPR06MB8063.apcprd06.prod.outlook.com (2603:1096:405:2fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.24; Wed, 13 Aug
 2025 03:05:23 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 03:05:23 +0000
From: =?utf-8?B?6LW16KW/6LaF?= <zhao.xichao@vivo.com>
To: Bart Van Assche <bvanassche@acm.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: fix "prefered"->"preferred"
Thread-Topic: [PATCH] block: fix "prefered"->"preferred"
Thread-Index: AQHcC2oH1LrDw00moUubBpQBj6pdQLRfI9EAgADDkQA=
Date: Wed, 13 Aug 2025 03:05:22 +0000
Message-ID: <5da8b922-7bc3-45dd-bdbc-84cd2c57d899@vivo.com>
References: <20250812091803.94751-1-zhao.xichao@vivo.com>
 <475fb909-cbd2-4de0-8044-8fc5b0a1b400@acm.org>
In-Reply-To: <475fb909-cbd2-4de0-8044-8fc5b0a1b400@acm.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR06MB6020:EE_|TYQPR06MB8063:EE_
x-ms-office365-filtering-correlation-id: 3a124d5e-1874-44fa-8699-08ddda163e60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|42112799006|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M01jWXV2ZkFLMGxScTJkSVZCaVBNNC9zK2xEVXdYaER0VGJxSW9XbEJEa2ty?=
 =?utf-8?B?MHFRclMwRHplSzVqaXhoUk82azMvRUZibnRwcmpkMEdsQnpmOTdGNnQ0RCtW?=
 =?utf-8?B?RVYxZ2VTZmVPMWs1VGdoTVYxMkdqQlRBWjRDc3J4WGovMUtTL0FmbVZ5aHF2?=
 =?utf-8?B?bUFmUzk0bHk0Wnpqa0t5QnR6aDl5ZHJhMmNtME1rZE1DSk4zNVRDT3I2ZktO?=
 =?utf-8?B?eGRtMVpwUFJyMFBkTVFFcU1janJIaEI2cit6SGZoa3FMRCtWMk02djBSdCta?=
 =?utf-8?B?NjE0U0xMc3Q5QkdiSnA5WHpmdWxaZU1weTRid1VXdVhOZithOVdOQ1R4UDBP?=
 =?utf-8?B?K2lCUnlhZlIrcUEwbXR6ZnRFcTB2Y1lIYURvU0ZMNXh5MVExOHBpMlgzMlB2?=
 =?utf-8?B?Qk5ZTjdqaWd0OGg0clA4VkJQN0hVWlFZb0t2WUJ1YlJDKzBZWkRjZlNWQ3do?=
 =?utf-8?B?cTBJZS84dnYvMWkwYnJURGhNWXVsTE9pWDVOajRIZ1p5TlAwU2RlRGJPaTR0?=
 =?utf-8?B?dnF3K2hLMGdtSUZsN2RROGkzczlUWlhMOHY5aldMalNONUlJMDlwQlBaQ3NZ?=
 =?utf-8?B?OHFmOGNkclNqWE53QVlDTTdqbHBma3lCQ1E5RE9xSzBaTVBBaFlxTU5SZW51?=
 =?utf-8?B?ZTFxbmRCRHQ4blhaQWlWNTJVQVBKRGlqRU94VWtQRVBHZjk3MFBaRlVHYmFJ?=
 =?utf-8?B?RFYrcDJPdiswZ2c1K2NPWTFxWWcrQmN0bys1T2Y4UGozVlZlQ3lBSjNmQjZx?=
 =?utf-8?B?RUNPRDlLMStYd3dIUytpZXNDdUNwaDluMGZiWGxQQ0pNQVp6aVZYU2hZRTUz?=
 =?utf-8?B?V1RmNmF0SWRZQkJuZ3JpcTBVVUVDYkNJVHprejN0dHNSUTA3THJkczllbHZ4?=
 =?utf-8?B?UzFhY01WT0EreE5rbU1WbjRDajYvN2pseVpON0pXdjBaRlp5LzRnZzJua1ox?=
 =?utf-8?B?VmlaZXZ0RjV3LzhHMnk2RFFFbmhueG4rWkF0Nnlpd2k0eUdmQk9sRnRzY29R?=
 =?utf-8?B?NExHcFY2M1l2ZjlLMy9vcDJyZnIzMVVKMENIY2xPVUF3VGVqYjV6WndrYTJW?=
 =?utf-8?B?V2VHY3RFNGRGMTM5andramlEMFJYekIyendUOWg5REdBSDlyc1ZpaG5OQjh0?=
 =?utf-8?B?bUhyeUNZeENuUzFEN1dIdVNtNTFoaWFFN0R0REl0dDgrV0FnVDRsS082TEw2?=
 =?utf-8?B?VFoyaVRxb2ZFcUZmdTVSOExxYndCYXk5YWlxcFBaenZuTWF1cktPc0MzQjYz?=
 =?utf-8?B?MXJyWXFvQVFvS2E4OFpNZEtDRmU4OFhDb1Q4VkZFeGEwODdmUnA5Z08renda?=
 =?utf-8?B?czU5VnRYM1JlMHQvRkRjRDR1bk9mWkJpZ2U1NTZ1NGJGRWpPaTVyTnBtUXF2?=
 =?utf-8?B?Y00xWUdMVStGV2x2R2NUckxEb1UwK3VDdDkzb01sQkVRSWlzYWxGYitWeDdR?=
 =?utf-8?B?S3NmSklHY2tQRk0zZHoyVnV1NWNIclJhdFFDUmhLL3gxeEpuVGx0dFlVSEEr?=
 =?utf-8?B?NjlhdHN1ajg2cFByakh2N0M0bXlydU1NZ3BJaFZOZEh2aGNER0Y1MmxjaXZB?=
 =?utf-8?B?NHJ6aXJRd3FTWU1vdFFnei9ZbDY2MlhEVWZ4d0h3bU5vY0Y0dXhNa2VqTkJ5?=
 =?utf-8?B?ZGNSUWpxMm1YSTN0blFWZzRhM2MzUU9OYngxVEpBS3I4K3gycG5uLzVRYUZK?=
 =?utf-8?B?Nlc3Qll6WkF1UUhMTWxNQWlteTVvSk1tS2x0NndOTk41YnV1SG9OallXYUU1?=
 =?utf-8?B?UkhzT1dWa29adGRSRVhkZmNPQTlpaHN3MG5MWWJITGV6MFlYU3hNazZuQ0NM?=
 =?utf-8?B?ZU40dzZ3Q25VTUdldFdJaTg3RVRqemY3RjBQL0NaOFphSzFNT2dzNlo2bVZM?=
 =?utf-8?B?cFhOY2JycmdxKzVpNnpmVGgwZUR4YWNtUE1DWXloeEJWMENEU2VHdUEzd1I2?=
 =?utf-8?B?R3FyZCswQjgybEJLMWN2RnVYSWR5NHNNTE85MEJKMGNBUkc1VGFMcHZqN0hC?=
 =?utf-8?Q?Pm6/KA9vjKui38OHW7H6mBB3fqLeCQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(42112799006)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OHpDRC8wQXJBc3h4S3U0cGVKczdoYjJ6LzZYN0tUcFE3RlozVDlOZ2pvcG0r?=
 =?utf-8?B?cW9VU1N1Mmt0UkgreDlPVG53RC9kMkYyRWZhRytkTytCWDNsa1Njak9rQisy?=
 =?utf-8?B?MTd5ZFVWNkpyL2RSVUhLNVVsVUI5WjZ3cjY1YUlET0FCQm1SbEpwTW8xdU4z?=
 =?utf-8?B?QldMVHR6RE0vNTJ1UUloM2NwNXZUamx3WnZhRFhrT2VIemlCczB4cmlaRGd5?=
 =?utf-8?B?VWhNOXVRUUtyVWRwdG1wNDBuVHFTeGxzLytDRWpRbEhyQTRNUndyLzgyYlNz?=
 =?utf-8?B?Nmdic21iL3VhV0taandIREhDS25FNmhEbDFFajBqNXdzZXJpT2MxWDVtQXN6?=
 =?utf-8?B?ZlJnbnRSWWJhU1JNNTI3TjlzOUNiT1F6N3JBbVRkN1ROSnFwNFhhRDFkWmk5?=
 =?utf-8?B?NHdWb2JIVjM5c0NjWFVKWFBmdGgxMUJ2YjNPa3d1STA1UFhnMzE1ZTZEQU9G?=
 =?utf-8?B?WVJ1MDBhTiszWkhObVhTbm1BSVk0dlNwb2NtaHo2ZGg4U2xza0paYTVTSzZT?=
 =?utf-8?B?ZVc5dDVsMll3NEwzclhGbjNWVjM0cUdzdU9mUGp3UEhVSzBRQ3dPZFlCSmI5?=
 =?utf-8?B?TVExN3F2S2NxRm1HVjc3OGp4U1NwTk80ejhxWkNnQlVDSTJnQ1ZhUktWeU41?=
 =?utf-8?B?ZDBhRFQ0V3lmLzZoYXBEYnI1cFRralNMcGlHUEJuVmpMNWx4SWJna3VBSDhi?=
 =?utf-8?B?UmhhSlRVSmt2Z0FQdkV2dFlHSE5qTlZRdlFmd1ZYTTJEaHViQ0h1RUMvMU0y?=
 =?utf-8?B?STR3UzVHdGpVaTN4NGJIckFad3BDSDFPQ2pvKzBDcXVqcm1mUUh6MnFTL0R6?=
 =?utf-8?B?M2Jkd0FIOUp3ZVBNdDhkdkVKVDlIdURtR0d0bUIzeCtLTjUrNHZBSHV0alhU?=
 =?utf-8?B?b3ZjNm82SVlJSVZjclVvZDFsMUNNNzcvd3kvUnpYSkQ3R3NrSjZhUmFtQ256?=
 =?utf-8?B?aHIxZ01HSzY4WXRwV0h4UTAwVXFwTkhCM0RzMGh6MFZVMTZrMEh1MlYva2pH?=
 =?utf-8?B?d1B1ZnpzNTV0eHdlaW5NNmx3STcwTTBOT280djFreGMzMDd4YjlrMTBHaU5C?=
 =?utf-8?B?b0RqZ3grRVZxSWtqblZpSjZkRWFSZzdPWjVBNmF4b2kwREJUZEN5OWRzeW5D?=
 =?utf-8?B?am9GcUJSZGl5U3dMQldGTUFNaGpWYXVLa3VETnkvckdMVllvOVZVU3BMWEVF?=
 =?utf-8?B?SExXdDFVZlpYWGhOZ0FZc1BlWTM2TzNsekNJQ2tYMlNyT3Z5ZWduaTcyNVJE?=
 =?utf-8?B?TUlhM3IvM2dYSFBMS3g0NUkrdlVrM3k1emovM0R0cEFVWTRxaThCMmpvODIx?=
 =?utf-8?B?TUNrdDViY0Qwc3YrR1ZTUm1Eb3NGbllGUXFVVUhsK2h3QmNhelJBNXNlYTN4?=
 =?utf-8?B?bnR3a3Fxb2ZYWWc3UDFjSmUwQXdyLzFxNXcxTmhiMS8xV0VsZ0F0QUJDNHZS?=
 =?utf-8?B?bW8xL01CYUZxcWg4Zlp5My93OXExVm83T0JWOUQrODNCb0VVVDhJb3hmOTRY?=
 =?utf-8?B?OUROL0lOM3NzSHhWWDhnR1BiZStjUTNiYkRSNlVxSUtUZDV0cm83bmpsMGlM?=
 =?utf-8?B?andGeHU5SEYwS2Y5S3lTSXI3RVNBbERvR29YQW9VR0ZFV0dmakVQSFRTYm5m?=
 =?utf-8?B?Vk1ScEFYTlFTeDVnQU9CMXBVZ2xLVTUrTE45ZzQyNlczU2laM3VkM0g1TW1z?=
 =?utf-8?B?SDErM2szVEptL2NYcGpoZHpiZDRVN3hXN3dERFBPck5GMDdUd0s2VDVnSDFm?=
 =?utf-8?B?VDhlVU40b2RYaDhiV0lFTm0yWWpyZkVwRERNOFFTREx2dlRaa2RaQUxwRDVm?=
 =?utf-8?B?Q3FFN251TXMwNkQ0cThXLzAzVTcrTFRxK2hac2RhZmxsTUVUZTFEWm4rRjdh?=
 =?utf-8?B?dTJoOHlNRVowMTdET1dzNDdnNFNiOGU0OVNpb2VkRzBWNXU4WEhmbDBuenZV?=
 =?utf-8?B?ZkJyTmhVdElBdUQ3UjRWbHdPRzRIYU4vYmF6WjFXKzQwLzlpamVWTUh0VllH?=
 =?utf-8?B?MGxiWDZ2NmdXeTRCNStQSGxjdnJqMkI1THlUc1BoQXpZVFZvZ1Jpd2lGdEtt?=
 =?utf-8?B?WVAzRS96Z0ExNHhEYy9tWFZDNjVlVFcwcGtTVzFHNHlwVkN4cTc5MTFKRTlP?=
 =?utf-8?Q?vF6Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33DF2635A0107540B162613E7FF5C556@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a124d5e-1874-44fa-8699-08ddda163e60
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 03:05:22.6843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TCzPS2KRoHKFzky/NsP/vAI7wb4AqCIaXJcmzgtM67LhLN7R2hgZ+ccV4MOHEeHcfwt+AexHLibobTUHVUasjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8063

5ZyoIDIwMjUvOC8xMiAyMzoyNSwgQmFydCBWYW4gQXNzY2hlIOWGmemBkzoNCj4NCj4gT24gOC8x
Mi8yNSAyOjE4IEFNLCBYaWNoYW8gWmhhbyB3cm90ZToNCj4+IFRyaXZpYWwgZml4IHRvIHNwZWxs
aW5nIG1pc3Rha2UgaW4gY29tbWVudCB0ZXh0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFhpY2hh
byBaaGFvIDx6aGFvLnhpY2hhb0B2aXZvLmNvbT4NCj4+IC0tLQ0KPj4gICBibG9jay9ibGstbXEu
YyB8IDIgKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1tcS5jIGIvYmxvY2svYmxrLW1xLmMN
Cj4+IGluZGV4IDk2OTJmYTRjM2VmMi4uYWRiMjZlYWI2N2Q4IDEwMDY0NA0KPj4gLS0tIGEvYmxv
Y2svYmxrLW1xLmMNCj4+ICsrKyBiL2Jsb2NrL2Jsay1tcS5jDQo+PiBAQCAtMjM2MSw3ICsyMzYx
LDcgQEAgdm9pZCBibGtfbXFfcnVuX2h3X3F1ZXVlKHN0cnVjdCBibGtfbXFfaHdfY3R4DQo+PiAq
aGN0eCwgYm9vbCBhc3luYykNCj4+ICAgRVhQT1JUX1NZTUJPTChibGtfbXFfcnVuX2h3X3F1ZXVl
KTsNCj4+DQo+PiAgIC8qDQo+PiAtICogUmV0dXJuIHByZWZlcmVkIHF1ZXVlIHRvIGRpc3BhdGNo
IGZyb20gKGlmIGFueSkgZm9yIG5vbi1tcSBhd2FyZSBJTw0KPj4gKyAqIFJldHVybiBwcmVmZXJy
ZWQgcXVldWUgdG8gZGlzcGF0Y2ggZnJvbSAoaWYgYW55KSBmb3Igbm9uLW1xIGF3YXJlIElPDQo+
PiAgICAqIHNjaGVkdWxlci4NCj4+ICAgICovDQo+PiAgIHN0YXRpYyBzdHJ1Y3QgYmxrX21xX2h3
X2N0eCAqYmxrX21xX2dldF9zcV9oY3R4KHN0cnVjdA0KPj4gcmVxdWVzdF9xdWV1ZSAqcSkNCj4N
Cj4gVGhpcyBwYXRjaCBjb25mbGljdHMgd2l0aCBvbmUgb2YgbXkgcGF0Y2ggc2VyaWVzIHNvIGl0
IHdvdWxkIGhlbHAgbWUgaWYNCj4gdGhpcyBwYXRjaCB3b3VsZCBub3QgYmUgYXBwbGllZC4gSSBj
YW4gaW50ZWdyYXRlIHRoaXMgcGF0Y2ggaW4gbXkgcGF0Y2gNCj4gdGhhdCBtb2RpZmllcyB0aGUg
YmVoYXZpb3Igb2YgdGhpcyBmdW5jdGlvbi4gU2VlIGFsc28NCj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtYmxvY2svMjAyNTA4MTEyMDA4NTEuNjI2NDAyLTUtYnZhbmFzc2NoZUBhY20u
b3JnL1QvI3UNCj4NCj4NCj4gQmFydC4NCg0KT2theSwgaWYgcG9zc2libGUsIHBsZWFzZSBpbnRl
Z3JhdGUgdGhpcyBwYXRjaCBpbnRvIHlvdXIgcGF0Y2guIFRoYW5rIHlvdS4NCg0KWGljaGFvIFpo
YW8uDQoNCg==
