Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA818BFF
	for <linux-block@vger.kernel.org>; Wed, 29 May 2024 19:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717010049; cv=fail; b=si8rVHN0fjVPNPgqZhunsV8ymOwJOi/eC4m06iTWDfBn4QDXd0KqX61Rz+vqBZjzsZfng/vc2/qETDvHmeW61IXfl89X4piY7fG5KY27BW/U36GTKPicQXTiwmBYkqCvtwUZDnRJNB42noeFOxwXbNu9REV1l5p4WhNGpThf/F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717010049; c=relaxed/simple;
	bh=qTjZCNzcHS7+kdn3U2Ku0b/np6hgNkmlbDkUg4BwSlY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IQUPd9PrRRwwaaukKFZZ0NYQ9ZlthOliaKLI3BWiBD3KO1jsMzB5oEYQzA6n5PFFtrRVT7qRerCfpXOm+Uk5I797vAgVteB71LdRPsbvniAylnQZfIqGHDEIZMjsfLZuZ+GkdWMsMxVjm67B99hpHmrog2hMVIbvTekhBpC8q+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bNjjfm0q; arc=fail smtp.client-ip=40.107.96.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bNjjfm0q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDroB5Ts6mq52g2MEUppZMBQ0Ai3Xji23dEWdWBzlD5vGi/A+hHoqx0/Y8nOumC0QgOKQX3cO9NRTvZnX/Kx5ARAhCLHXm/W4kqRwUqm/sGT5qvtXFe8DX2LewVutdzvri+2ZsbnsqktrST605XmaPjRh/miBGhzHvJFd/ywOhLitnQaKuKXdkkh7k4clpg+RVXLx+VRpR9sEqT4zrQpAG/EG99MZBiYh0Ks+ly44ltOO5LYUSawQEyzCMWAWsEqBIE1Z5fIRVBSvQlIwrH7Qq3gGeI7Cy2q5Lq8R06quw1yk2QCC+IZTkdv0003eeoxX8fpcVopVaQDTFur039dyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTjZCNzcHS7+kdn3U2Ku0b/np6hgNkmlbDkUg4BwSlY=;
 b=SSl8LzOA3O6igcfmunI5WATnIlEOEKo8RuGNTqdtjwIxy9D0Ev802vwTB9jQwV2emERbxzHLZsxeMgrgr1DEpgMbn0bbZhpY6oOk3Me44UmRtRX2I2MBowT/xolaW0n0Sw/KazLNLdrp92POob6oVkPHONxB6WAYwFIo3zrUO/Yv7sOmLKhH0JPYu0X0AEk/qJ+qnb9qCDZ9d8i4uFrkxZv6+wcJxd2sqSfnFzdSTQ67FhgxHVLDb8IsQZ+jnzMzEu4kjr6elXhtAVNdnuN+gopikagV8xUOkWCRs1xPOLTr74z83l6A3GlS0qi/r3Ku3rFFY8y07mHMRYgX6Rv5Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTjZCNzcHS7+kdn3U2Ku0b/np6hgNkmlbDkUg4BwSlY=;
 b=bNjjfm0qHs2zm+sB50/D9Z02a8CTCaITovvcSp1R6o+W6k7UFwcb6OwayPwqBcKX1iW17vfTHZoAD582i8TBOzliWb11DUviAjspJ3JFm+EzvyPYOkazj/pBaLQ8UqKtFAmyQeMdIMMTNInH20Zy8vll2t61x5iUZUdTWH98H8x56AyofCo5rbrK5ueiGfd54Mqw9qUzkPa8OV9JTJK8+rJLmOP272YV1TWRy8hdpiAyqCXYCyQ3hfgSZYGxR0vtcbxIiRGsopPNyMdPr484BhXnjaMfhy4lORATanEYppOE9euhcT4I4JD9tINiEs5RSCO3ENvwn9mNFDPddKlwqA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Wed, 29 May
 2024 19:14:04 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%4]) with mapi id 15.20.7611.016; Wed, 29 May 2024
 19:14:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
CC: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2 blktests] loop: Detect a race condition between loop
 detach and open
Thread-Topic: [PATCH V2 blktests] loop: Detect a race condition between loop
 detach and open
Thread-Index: AQHasevOZr6Y0sN42ke/8xdhwSqBHbGulOUA
Date: Wed, 29 May 2024 19:14:04 +0000
Message-ID: <ac8696f8-b24a-4556-8a08-b59521dcd5f9@nvidia.com>
References: <20240529171516.54111-1-gulam.mohamed@oracle.com>
In-Reply-To: <20240529171516.54111-1-gulam.mohamed@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB8288:EE_
x-ms-office365-filtering-correlation-id: 5914287c-0282-4b52-365a-08dc80138180
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?bHBReXdBTXNMeVROa1RWOXdhc2xQWlRQWmtNVlo4N3pRbTFUaStxejdRMFlH?=
 =?utf-8?B?UjdramhaRGt0V2d6VVpWZkpGWVdFTkxOeko3Um43ckpBZk83UjJZVngxcTF3?=
 =?utf-8?B?Z2lPcXowOTREMUVRa3VHa3pQdmh3VTFCRjNSRGxpbEg1K2JXNVo0VHVzQXBW?=
 =?utf-8?B?VytibWl0aEtvWkZIZXdBdUJzUVpmUGxzTm51aW00M2hmeW9LTDJ4Q2QvM24v?=
 =?utf-8?B?SjlheDZYaXA0RjBITWtQTDBLb0o2WDgvSUd2c2dDTVRkQ1IvNWhodzVTMEE2?=
 =?utf-8?B?ZGdBWjN3Y3FZS1Q0MFZvZkgweUNMZ0lHK2ZYcVhkSytzemdKWGRpc2RaM29L?=
 =?utf-8?B?MzkvdFo5ZmFMcXpENFBLZkxJTHp2ekdUNy9RSzUxZW9NZTBMdUZmaEp1NmYy?=
 =?utf-8?B?Z3hFWHg3d2VkbVB2Nm9vMGhDdjZ0MkFmQzNDbXdMR1MwVmUxdlNXUDAvSmpX?=
 =?utf-8?B?S3RNQ2tzNzBCZHJZY2NOSHRmVzJpdVltRG5LZFp0UFFrUWdZamc4emJYb3R4?=
 =?utf-8?B?VE1RRjBEcytpM1BqUUJHWEJheklOaVFQdTVJbDdqQVJiNFBQQlRYS0V4VW8r?=
 =?utf-8?B?ZkNmdFkzOWVXcHc3b1c3ODg0V0QrN211S2RaM2tlc1NtZEZYdVdjRjVxR3E4?=
 =?utf-8?B?ck5UZVpnQWNaVmpZeURaM0tNdkRKdndVcVIyN3hNcCtKS1hBUWtzblA0VCtn?=
 =?utf-8?B?SGdUQVBUSWRNUnlpaDFGZ3BGNGYydFVHL2YrbTducU1IK0VvR0YwdG85ei9m?=
 =?utf-8?B?YW9hVmFTR3QrVk1HNGozK1hZdDFHZWVPVnljYVNtck0ycTdxV3ZtdFlLVEJQ?=
 =?utf-8?B?bzVqTUtqOXhnbmRCOFZlQ2RzR3Ird1hrc25QR21KWHAyaCtXdDVUMmVYRGFU?=
 =?utf-8?B?cjJxdWxKditQM3Q5V0dJQkY4Y3hGbWZva2txYkUwQThGOC8wNWgwK2V4NFIy?=
 =?utf-8?B?cjVUZGhzM2x2VFZpc1ZCalBLaEJSam56bm4zSlBkNDRFSjhTbytPejFLTmE3?=
 =?utf-8?B?RVBPYmRFaC90a1QzWlNKTEtKS2g4a0t0WWMzVkZaS1RKa1BGMS95anBtTVJ6?=
 =?utf-8?B?ZUZ1a1Y0WUJ6M1A0ZFdOMkRZU0pFZko1M3VjN2dQeG9SblB0UWlPaXRwZXRv?=
 =?utf-8?B?eDl0TnVXMURsNjhCeXZnNXRyWTBlT1JLNGFZd1ByVExNaVpnRTlrZ3VQRi9n?=
 =?utf-8?B?VDVmZzdOTEhzbGZESURVZjdobGdva0cyWUZ4MVJ3bXVpem5hR2FmV29JR1g0?=
 =?utf-8?B?VTRZbCtrTkQ0Tkc3ZkRadllKOWppNnl4Z0dCa1FnM1FTU2d2WnpwTWpoYUov?=
 =?utf-8?B?UzNEbXYyMkcvSThBMm9XVHJhSit0YmN4Q3JlK1Jnam5yZEltWjQ0Y1F5TnU3?=
 =?utf-8?B?VmMwbmMzWEZ6Z0FkNnI0OGxGUlhmTWJyWFkzNGtRcHMxRTJ3cFdtaFZibHNj?=
 =?utf-8?B?WVB5VHZpUGpGSTN4UlBmZ3ppcUxTeEFTRXFSOUhLelFGbFZDRGRxNUVkaE1m?=
 =?utf-8?B?TUJ2NXBJSEF6MU1ZOVVOdTI4czQ0MmRCZlhJRjhvaTI0ZlNHN01oTTRDbHlv?=
 =?utf-8?B?MnQ3bGpoVlkrNTVxdTlpalpFU0pNRWpKYWJmNlBrTmp6L2paQ1dzTkV5K0NZ?=
 =?utf-8?B?azQwQlZJYjJXUnJsQkpFZGxEWjdxTDJLditzZFFXQXVPSFZFUkpEZEdOUG5Z?=
 =?utf-8?B?d1RxNGNqK3ViQ243UFA4aHJZWm93Mjh5ZEpzSXVDUno4Y3A4MU9pd0FJUmlW?=
 =?utf-8?B?UXZjSitPNW15aHZNOGhPeEZxVnU0QkxuZklhSWh6U2gvR2J0Y01ZSktMNmph?=
 =?utf-8?B?SU5CUjI4aWhCMlR3citGQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1pjTFdWQnpjcGZuSG1sMzVoUkY2U0c3ZlpUVDE2ampGbnpaZmVGT1pnaEVL?=
 =?utf-8?B?OVltcHQzSE81aUVCeVN0OSt1L0I3aFVUL0xuUmM4ODBqWHdGQy9EWmxNbGxm?=
 =?utf-8?B?cGF6MXcwWVlJWStaT2d0YXpqenhYQ01mbGtyRG1MSGgwSXhYY1dJM2FMK3Qy?=
 =?utf-8?B?Tk9rWEUzUTd0TDBFQ1QwdlBCRTdBeWpPWjVWVEZLWmFxc3VLR1RMam82d3Vo?=
 =?utf-8?B?amVnalhGTk5UL2dsVkI2YVlyZXp2SFFXS0JjY3g1T1RoTEM0QjVaUlVPU0Rr?=
 =?utf-8?B?TkVNb1ZhcWNqVjhMTXM1SWt5MDUvVjJmaWFkdHhYTmF3cE5Sa2s0WS9hZlJT?=
 =?utf-8?B?ZlpXQ0hOVGxGbHFUMjZnY1I1R1pGbXhxV2JMMnQ0emcxTnRWSVEwQTZTaWR0?=
 =?utf-8?B?bjV5RTlrOE9RVncxb2tpOTMvNERzMGExZ0tGclh5SUJ2b25ad0NNcnRzV2hn?=
 =?utf-8?B?N2VnY0kvR0k4dEYya2E4OUtpdUljQ0dTZUlBaGJxQVZQTzFhL3hoUnVHcUJo?=
 =?utf-8?B?ait6a0lneThSMk5yVE9DM3lXM0V1U0U1T1RFbXExOUtxZjhQdHZBQU5QaS8y?=
 =?utf-8?B?aWJFc202cFNGN29ZSEQ3WkVpemYvYTdtQXdLdjBqRXI3RGJQb2tLMEc0T0Iz?=
 =?utf-8?B?dlgwWjd1SVYyclR5RGhvaWpoSjNheGJXVG5kanJiQmxScGRETlhGMEYvMk5l?=
 =?utf-8?B?ZG9DeGFwSjA3M29lY3dPaXdOZnFDUm5td0psaGZ5Z2lwMmhGU0pZeDc1L1dE?=
 =?utf-8?B?SmtuMnM4QTZoeE1oUHAvQnZTVzR4WkF2YlcwY1k0RHNlSlU0ZUxUeDc3S21k?=
 =?utf-8?B?VmdCQXlOWlhub21odGJYd0tVTnl1anJIT3hTQ3habTBtR3BhWEJ2c0xZQzB3?=
 =?utf-8?B?TG5MZE01SXJzZGNtYStDbkpLZEZLdVlPaDJUazNQTkRqMHFUYXgyelphKzlQ?=
 =?utf-8?B?VGpYV1crRHZQWmpVR3V2M0xOVVBLa1JBdTFqYlRGQ2lTd3VReHRLdFFMdWFO?=
 =?utf-8?B?Mjdid2xTWno3K1dHam9lRTlHcDZmUGM5a01YUFVTRjFyVXZlZ1NJTXVHZGR0?=
 =?utf-8?B?TUtQSHFKMjg1S2N0eFVLVWpJWXAzaDhpaFd5QkxmWDhtZ0NrMGx6OW1lRTBQ?=
 =?utf-8?B?VldwMU1qc29kbk05RUxPdXE5WHFhVjZCMmtGRGdqbU1oVnBRUUlNT1hxUFA0?=
 =?utf-8?B?bE4zWkNuWkR6WFNSTnRLR1J6ZXNITDN6VVJWdWIvRkVObW5lOGp6ZkpKNW4r?=
 =?utf-8?B?cHJIeGZySC9ZSTYxQnRrU3NJamJveXhRa3BqbjlvWU5oTEwxVE9OZFJqMmdQ?=
 =?utf-8?B?cW5IZHZxc0hVVTlqZUcwWG5yT1IyODRES3NVQno1ZVRoakkwenFoUHNPN0w0?=
 =?utf-8?B?ampKWlduRmpUU01zaXl1YlNaUkNpQkQrYUtadU1HaU5BcW1EM3N4eWZEd2FI?=
 =?utf-8?B?S2t6MUNiY3c2WjkrWjdlUW9WbEU4Q21kMHdzcVRxU2RuRm5tRnBlTVV0S0VQ?=
 =?utf-8?B?eG9hSExVbDhMaFptZEIxUks2RHU4L0IzdCtkcHVFeVV5L2lsbUhCUEtqQTNQ?=
 =?utf-8?B?M1ZLWmRPeno5UVA1QXIxTXNrN0RuTU1UNWlwdjJBc08xZXJYSldZekNtdmVj?=
 =?utf-8?B?OUpkdUdYM2VxcmRGUEkydVordTVlMXRLOHBDVVRUKzZzOXJZK0lTdklMWGRY?=
 =?utf-8?B?VTBsTVo4aWJjQkZqRGtHZ0I4V3d2c0JBTGRYRUZMaG1YVXloaTRHOGtWYUpK?=
 =?utf-8?B?U09QMXh1a1JlZ2xRbm56VVpqOHpobGVubFcrWTAvQ3R6eUJIWkxtdWd4ZUs1?=
 =?utf-8?B?VGJOMGNab1AxNkdLSkFDR2lqelBjYUh5akw5N2lhVUJxd3U0Q0tUelVZdWI1?=
 =?utf-8?B?TGN4SHg3VjFqT1ZmV3A1eEJvdFB4RURXbDM4azBsUjNEditwbHkwNjMrdVp1?=
 =?utf-8?B?TGt1bHllTk0vTUJxS2hkWVRTbURBUGVIbmtXL3c5aG9OWXhWYWNIVkFtL0Qv?=
 =?utf-8?B?ek1PTS9CYnA3dHFjTCtMRXRLbWtTdkZhVkFDRFdaSE9tdnZJVHpEVUxPTGRr?=
 =?utf-8?B?Rkhmby9xZk0wT0dKWWJWWTZpeklNNkFSZjYwMENNTDJJUjhyaGNxeDdSd2RX?=
 =?utf-8?B?cERCejlWTHphd2tMQ2Nxdmd2WjZLLzVLdXNpdk13VjVaZDZVdTJ5UDF1bTJi?=
 =?utf-8?Q?8d9+/KZYAgeANDYGDTMKYan3jVaJTDtbO/64Gt2QLUSB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86026B2E46A73742AC8F26A5806BB113@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5914287c-0282-4b52-365a-08dc80138180
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 19:14:04.4919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j886WkA6AUdSmQPZ9flM723sHRi/Yqj7jFWzMNHcgj8P41I+KEUye88GukfbE2vvvoZSqXRYT8tTM1oNgQhW7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288

T24gNS8yOS8yNCAxMDoxNSwgR3VsYW0gTW9oYW1lZCB3cm90ZToNCj4gV2hlbiBvbmUgcHJvY2Vz
cyBvcGVucyBhIGxvb3AgZGV2aWNlIHBhcnRpdGlvbiBhbmQgYW5vdGhlciBwcm9jZXNzIGRldGFj
aGVzDQo+IGl0LCB0aGVyZSB3aWxsIGJlIGEgcmFjZSBjb25kaXRpb24gZHVlIHRvIHdoaWNoIHN0
YWxlIGxvb3AgcGFydGl0aW9ucyBhcmUNCj4gY3JlYXRlZCBjYXVzaW5nIElPIGVycm9ycy4gVGhp
cyB0ZXN0IHdpbGwgZGV0ZWN0IHRoZSByYWNlDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEd1bGFtIE1v
aGFtZWQgPGd1bGFtLm1vaGFtZWRAb3JhY2xlLmNvbT4NCg0KdGhhbmtzIGZvciB0aGUgdGVzdCwg
dGhlcmUgc2VlbXMgdG8gYmUgYW4gaXNzdWUgd2l0aCB0aGUgZm9ybWF0dGluZw0Kb2YgdGhlIHBh
dGNoID8NCg0KPiAtLS0NCj4gICB0ZXN0cy9sb29wLzAxMCAgICAgfCA3NSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgdGVzdHMvbG9vcC8wMTAub3V0
IHwgIDIgKysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDc3IGluc2VydGlvbnMoKykNCj4gICBjcmVh
dGUgbW9kZSAxMDA3NTUgdGVzdHMvbG9vcC8wMTANCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVz
dHMvbG9vcC8wMTAub3V0DQo+DQo+IGRpZmYgLS1naXQgYS90ZXN0cy9sb29wLzAxMCBiL3Rlc3Rz
L2xvb3AvMDEwDQo+IG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4u
YWE5YzFkMzNiZGI5DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvdGVzdHMvbG9vcC8wMTANCj4g
QEAgLTAsMCArMSw3NSBAQA0KPiArIyEvYmluL2Jhc2gNCj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0zLjArDQo+ICsjIENvcHlyaWdodCAoQykgMjAyNCwgT3JhY2xlIGFuZC9vciBp
dHMgYWZmaWxpYXRlcy4NCj4gKyMNCj4gKyMgVGVzdCB0byBkZXRlY3QgYSByYWNlIGJldHdlZW4g
bG9vcCBkZXRhY2ggYW5kIGxvb3Agb3BlbiB3aGljaCBjcmVhdGVzDQo+ICsjIHN0YWxlIGxvb3Ag
cGFydGl0aW9ucyB3aGVuIG9uZSBwcm9jZXNzIG9wZW5zIHRoZSBsb29wIHBhcnRpdGlvbiBhbmQN
Cj4gKyMgYW5vdGhlciBwcm9jZXNzIGRldGFjaGVzIHRoZSBsb29wIGRldmljZQ0KPiArIw0KPiAr
LiB0ZXN0cy9sb29wL3JjDQo+ICtERVNDUklQVElPTj0iY2hlY2sgc3RhbGUgbG9vcCBwYXJ0aXRp
b24iDQo+ICtUSU1FRD0xDQo+ICsNCj4gK3JlcXVpcmVzKCkgew0KPiArICAgICAgICBfaGF2ZV9w
cm9ncmFtIHBhcnRlZA0KPiArICAgICAgICBfaGF2ZV9wcm9ncmFtIG1rZnMueGZzDQoNCm5pdDot
DQpkbyB3ZSBuZWVkIHRvIGFkZCBibGtpZC91ZGV2YWRtID8gaWYgbm90IGlnbm9yZSB0aGlzIGNv
bW1lbnQgLi4NCg0KPiArfQ0KPiArDQo+ICtpbWFnZV9maWxlPSIkVE1QRElSL2xvb3BJbWciDQo+
ICsNCj4gK2NyZWF0ZV9sb29wKCkNCj4gK3sNCj4gKyAgICAgICAgd2hpbGUgdHJ1ZQ0KPiArICAg
ICAgICBkbw0KPiArICAgICAgICAgICAgICAgIGxvb3BfZGV2aWNlPSIkKGxvc2V0dXAgLVAgLWYg
LS1zaG93ICIke2ltYWdlX2ZpbGV9IikiDQo+ICsgICAgICAgICAgICAgICAgYmxraWQgL2Rldi9s
b29wMHAxID4+IC9kZXYvbnVsbCAyPiYxDQo+ICsgICAgICAgIGRvbmUNCj4gK30NCj4gKw0KPiAr
ZGV0YWNoX2xvb3AoKQ0KPiArew0KPiArICAgICAgICB3aGlsZSB0cnVlDQo+ICsgICAgICAgIGRv
DQo+ICsgICAgICAgICAgICAgICAgaWYgWyAtZSAvZGV2L2xvb3AwIF07IHRoZW4NCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgIGxvc2V0dXAgLWQgL2Rldi9sb29wMCA+IC9kZXYvbnVsbCAyPiYx
DQoNCm5pdDotDQpkbyB3ZSB3YW50IHRvIHJlY29yZCB0aGlzIHNvbWV3aGVyZSBmb3IgZGVidWdn
aW5nIHB1cnBvc2UgaW5zdGVhZCBvZiANCi9kZXYvbnVsbCA/DQoNCj4gKyAgICAgICAgICAgICAg
ICBmaQ0KPiArICAgICAgICBkb25lDQo+ICt9DQo+ICsNCj4gK3Rlc3QoKSB7DQo+ICsJZWNobyAi
UnVubmluZyAke1RFU1RfTkFNRX0iDQo+ICsJbG9jYWwgbG9vcF9kZXZpY2UNCj4gKw0KPiArCXRy
dW5jYXRlIC1zIDFHICIke2ltYWdlX2ZpbGV9Ig0KPiArCXBhcnRlZCAtYSBub25lIC1zICIke2lt
YWdlX2ZpbGV9IiBta2xhYmVsIGdwdA0KPiArCWxvb3BfZGV2aWNlPSIkKGxvc2V0dXAgLVAgLWYg
LS1zaG93ICIke2ltYWdlX2ZpbGV9IikiDQo+ICsJcGFydGVkIC1hIG5vbmUgLXMgIiR7bG9vcF9k
ZXZpY2V9IiBta3BhcnQgcHJpbWFyeSA2NHMgMTA5MDUxcw0KPiArCQ0KPiArCXVkZXZhZG0gc2V0
dGxlDQo+ICsgICAgICAgIGlmIFsgISAtZSAiJHtsb29wX2RldmljZX0iIF07IHRoZW4NCj4gKwkJ
cmV0dXJuIDENCj4gKyAgICAgICAgZmkNCj4gKw0KPiArICAgICAgICBta2ZzLnhmcyAtZiAiJHts
b29wX2RldmljZX1wMSIgPiAvZGV2L251bGwgMj4mMQ0KPiArDQoNCnNhbWUgaGVyZSAuLi4NCg0K
PiArICAgICAgICBsb3NldHVwIC1kICIke2xvb3BfZGV2aWNlfSIgPiAgL2Rldi9udWxsIDI+JjEN
Cj4gKw0KDQpzYW1lIGhlcmUgLi4uDQoNCj4gKyAgICAgICAgY3JlYXRlX2xvb3AgJg0KPiArCWNy
ZWF0ZV9waWQ9JCENCj4gKyAgICAgICAgZGV0YWNoX2xvb3AgJg0KPiArCWRldGFjaF9waWQ9JCEN
Cj4gKw0KPiArCXNsZWVwICIke1RJTUVPVVQ6LTkwfSINCj4gKyAgICAgICAgew0KPiArICAgICAg
ICAgICAgICAgIGtpbGwgLTkgJGNyZWF0ZV9waWQNCj4gKwkJa2lsbCAtOSAkZGV0YWNoX3BpZA0K
PiArICAgICAgICAgICAgICAgIHdhaXQNCj4gKyAgICAgICAgICAgICAgICBzbGVlcCAxDQo+ICsg
ICAgICAgIH0gMj4vZGV2L251bGwNCj4gKw0KPiArICAgICAgICBsb3NldHVwIC1EID4gL2Rldi9u
dWxsIDI+JjENCg0Kc2FtZSBoZXJlIC4uLg0KDQo+ICsJaWYgX2RtZXNnX3NpbmNlX3Rlc3Rfc3Rh
cnQgfCBncmVwIC1xICJwYXJ0aXRpb24gc2NhbiBvZiBsb29wMCBmYWlsZWQgKHJjPS0xNikiOyB0
aGVuDQoNCmRvIHdlIHdhbnQgdG8ga2VlcCB0aGUgZXJyb3IgbWVzc2FnZSBzaG9ydCBhbmQgYWNo
aWV2ZSBzYW1lIHJlc3VsdCA/DQpqdXN0IGEgdGhvdWdodCBmZWVsIGZyZWUgdG8gaWdub3JlIHRo
aXMgY29tbWVudMKgIC4uDQoNCj4gKwkJZWNobyAiRmFpbCINCj4gKwlmaQ0KPiArCWVjaG8gIlRl
c3QgY29tcGxldGUiDQo+ICt9DQo+IGRpZmYgLS1naXQgYS90ZXN0cy9sb29wLzAxMC5vdXQgYi90
ZXN0cy9sb29wLzAxMC5vdXQNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAw
MDAwMDAwLi42NGE2YWVlMDBiOGENCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi90ZXN0cy9sb29w
LzAxMC5vdXQNCj4gQEAgLTAsMCArMSwyIEBADQo+ICtSdW5uaW5nIGxvb3AvMDEwDQo+ICtUZXN0
IGNvbXBsZXRlDQoNCmFwYXJ0IGZyb20gZm9ybWF0dGluZyBhbmQgbml0IGNvbW1lbnRzIGl0IGxv
b2tzIGdvb2QgLi4uDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlk
aWEuY29tPg0KDQotY2sNCg0KDQo=
