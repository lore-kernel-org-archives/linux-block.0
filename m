Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87DF9F7
	for <linux-block@vger.kernel.org>; Thu, 30 May 2024 03:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717038819; cv=fail; b=R6mefXxLAtD6LJQnL9u8NTyWPOSxE8DvfRm1+7qiRstsWrenWLiIXoB5/9bTWxZeyO1nvBjdkadCw1/CMzpXFEB9EmIduSaVmDSTZ2+jqyihIT8m4T8IK80f73atxgKipAX+nEj+wD3SYJVpNTojfCUPvFXgHBPgPpDNi2ThbPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717038819; c=relaxed/simple;
	bh=cfRQoNIm2tfeDfnYmj1MnsAl7O+xZsgYWlEonpXz8Ic=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iWdEazTsE3KJfGFhkDGmOjPn4pwIUp286rILhZlLT1I27t6HwDMxgBJXLAcGe7zCR2/SLB55NhgEgGHlQbh/H6PvPK6GIh6QqYORaYEAjXF4F5+50nw912Rpvf/9dCXtLkrgH10WfZ8OkWPrsMODIhKxkAeH3hzlBWCK30ijMKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KVaHoQ6q; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KVaHoQ6q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqlcS+FVy/BAWGLZw4YxDFHEunM12OmztW0YhGm5cJ5Xsv782O7W1ub9MQaq8Lfi1O4Wjixh1fjPb+Om3XJUKkp+BwgXxTuR+IbZjYsJY86H9vjR4OokRhduKOfXQjjpuUT/5s1FyhO4au2JwWNNTl/Mrfmnb64j0NMTRuYCwFBkd1dAcikPtd3Py+vmDtoSJkiCnN8MqV9LUi5F79ZMDHLLR4fbgIvYvRtDdY9b2XoAvwUqlvULM0Kw/BTaoI1qrBp1WAlGXU4q1/Eqs05VGYaLoAO1IrQRhKbF2aGaYD00bsLI2bpuIJzZE4WSHMaq7bxyAOtFEeCCYiI0Olc4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfRQoNIm2tfeDfnYmj1MnsAl7O+xZsgYWlEonpXz8Ic=;
 b=S03j+4nWHSt9SVOMUsA4ir5/Mus8ToCVL4EcMaF5CwClxIdG9h9V9ZqYK1Qix+c4MT4t0O5UBQDMgqP7TKz1pNz3sES1SzDH0Wuo9t3PqQhucqOo1di3+ForMB/8GhM7xDadIm7HDDQyLtketKf+3z/F1PKLxocrVg1vIoQLtzLlBgnd9SVpaZJKaiPM6kidNzgaarED2uIJvRJX27wqr9M8F1eV7Xliauc6Iqb5lky0inlCkE/04tLEzjND5QyM6jtbyVqlSy9VP0UK3ouIZJU4oxDTn6lqZJng1I7vU3dX8Jc7gYIk2h7zFoHubbiw/1EXgE4ct0SlpPwCl4WdiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfRQoNIm2tfeDfnYmj1MnsAl7O+xZsgYWlEonpXz8Ic=;
 b=KVaHoQ6qf0yYDwraCA6Q4DY/YjtUsI0LhNkK9JlYY4d0rkZg+WTV32DfNl5H9bLSk40z1PhsTQl80wphTML2iqxLVmgY8IIjoQcINZLazbXxJWdxtLXwap6pKiKjQ0z+Cc1nN0rZr/uFa/RAf4O+34PebaMg08snG4ociE2tszT/7u9KGGf5GAWUBHKgky/ysISNBu3+9Ja47D5Wn8Aw49jYGAaFrTwShxpFXAP4mmXx+RPA99qprQIpye13VYq3h8xY0aNWD0R4br8B2wQ+FK/tSAdad0NaxXaKimD+IuPqJQIGq909tlfBY6Deilu24JAln88QW2c2MCnP5zFEvg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB6563.namprd12.prod.outlook.com (2603:10b6:510:211::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 03:13:33 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%4]) with mapi id 15.20.7611.016; Thu, 30 May 2024
 03:13:33 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Gulam Mohamed <gulam.mohamed@oracle.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
CC: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2 blktests] loop: Detect a race condition between loop
 detach and open
Thread-Topic: [PATCH V2 blktests] loop: Detect a race condition between loop
 detach and open
Thread-Index: AQHasevOZr6Y0sN42ke/8xdhwSqBHbGulOUAgAAOGhCAAHfcAA==
Date: Thu, 30 May 2024 03:13:33 +0000
Message-ID: <4ddd56ed-fef7-47da-ae65-8cb81bcc5e2c@nvidia.com>
References: <20240529171516.54111-1-gulam.mohamed@oracle.com>
 <ac8696f8-b24a-4556-8a08-b59521dcd5f9@nvidia.com>
 <IA1PR10MB7240923E1C732FA7BBE183C598F22@IA1PR10MB7240.namprd10.prod.outlook.com>
In-Reply-To:
 <IA1PR10MB7240923E1C732FA7BBE183C598F22@IA1PR10MB7240.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB6563:EE_
x-ms-office365-filtering-correlation-id: eb369832-0a4d-4e85-591b-08dc80567d09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?anR2TmlDdXErdzcvUUlLSHcyR1FqWUdRdmdETVc0R3UvNFcvZW51T2g2clVC?=
 =?utf-8?B?dXJFYlFPcW5Db3JQQ1FIVERXbnYyU0p3RUY2YWE1ZDBFSzFtTklqUWwrSkdS?=
 =?utf-8?B?NnZiY3I0UVA3Rkw2TXUxMCs3aGtrUEJYSmkxalFrVHVJeDlBQ01wMDNRNlY1?=
 =?utf-8?B?b3ZNM08vN1QxTEtjdXBSbnczYTZSOUZKWWhRMlRXUXZMbE9hTEVpb2VUNVk1?=
 =?utf-8?B?Q0xpbkY3S3JFQ3RRTEpEa1grWnAyTWIwVC9WTzVqaFZkRU9KQmJWc29SSTh6?=
 =?utf-8?B?VUNpRHVoS085ZW5TRktnazIxT0RCSkc4dXJ0ckVqTG1xUjc0SHJwZDVBeUpG?=
 =?utf-8?B?aUpwSWlmL0xYTXdmeEZnUFo5LzNYTFFlazN0YURzbTl4L1RyUDV6NWJUTm5R?=
 =?utf-8?B?VXBER0dKSHhMUzhPQ1J3SUY0VE8yMVRmbUdVbXVjK1gxeHBQd0NwYytwdmUy?=
 =?utf-8?B?QjhwaUxqL3VBcVQ1SVJvRVpxTldwcWV1eTFybTQ5ZjJNTUxqWXRLMlJUZ0VY?=
 =?utf-8?B?NHBSUVBSSm16TXFOYi9JWHoxamd3TVQrUElFMk9NNEV4eWtmNlhwRUJROXAx?=
 =?utf-8?B?NklKY2poSGlOdzBzanZHaDVkVmsvb3JkY05xcUtJRXk0cEJkdnlGUGtxUmhL?=
 =?utf-8?B?bGFGNFA2ZlZYc1VsajRpTnoxSURCM0w0NzRHYWp1N0dwdUhCanBaYzh5N2Yx?=
 =?utf-8?B?V21aQnM3dm0wVDdGbTVqb051aFVMbGg2Sk95ZHA0TjRlcTFmM1h2VzloRzlv?=
 =?utf-8?B?OGM3MUpLbzIyd3VVWm9TU1pzSWdRazlnRzFFRXJOQ2FQb1ZNcUlJRm0zQnhR?=
 =?utf-8?B?dE1hbEx3K1dsYTNRY2oxYnBEWVkxbnFUSTU0VUZQWkVOUUorU2gyNmFhUnRE?=
 =?utf-8?B?b1RkbVJmdk9TOXUwSlJWZUY1UFdxWnNtTUYvSFpJRjN6K2pJNlRCb09jMTVI?=
 =?utf-8?B?d09JTXg3NEhPS2FPaEZKS3BubmhUQ2pLeHVKK3RqNjN1QXpFWVpIektGMlpq?=
 =?utf-8?B?V2dxdzIzRncvSjZvKy9yS05uSE91dzFwS0lPandoYnFGdHhQNHdSUnpaNlQw?=
 =?utf-8?B?M1Z0MEMvVDFJaTEveUZLaUV3Rkk2aDV5K3hhTlVqWk1jVGhFV3cvaGI2YkRj?=
 =?utf-8?B?UzFRVlBYTng1VkNpVVVpUXVRcjAzejNmVHhiTTFVamRERVhrYndhcFFXSDY1?=
 =?utf-8?B?RklvMG5XcG8yeXBNTlNwelVvbHF3UHlNY0FPVHV6SGVOL0tLQzNvYTJBd1U5?=
 =?utf-8?B?YTRjdzhpME5JUWZycnd1NncxWVc2dFl3Q3FyVUtUWFFoOC9NMmgzNVdqVFV3?=
 =?utf-8?B?VXBDek1BTnRRMVJVa2V2TGk1cE1MWkg0ZVZIQ0R0MEhNcVV2Znc0TjlWb3JD?=
 =?utf-8?B?UEZkdEhTWGVQdXNQN3lQcDZzL0Jwdy9UV1NFTkIxQlNPRHg0RTl4L2NqcjdY?=
 =?utf-8?B?MXRydmxZNTYydHFua3RJaEFTcHhseWJ0SGpES2RFNk1hMjBuM2RJUmU4Zjkz?=
 =?utf-8?B?LzFMbVFuUlhsbFRYSXNmbUs4ZUw3QVBqRGNubGQyb0FkeDBhNHRlQ2RUQmo3?=
 =?utf-8?B?WlhWSzM2K0FIdjZxMmw4cy9mcVVzLzg2RCt3dS91M0dmLzZqRDlQM0I2MENW?=
 =?utf-8?B?dFZWNlNZSTBKKzhJOEtDVWcvMnlmVDllNmVQUHRLREcxMjg4Vk5sVGtVZTEx?=
 =?utf-8?B?MkNxOEpwb0NDMEc1SjBYSjJ6Z2VCOTFsSGVOWUlEeGUvbkJwMzMyamhLTGdq?=
 =?utf-8?B?TG1IWE1JZE5va1NqMjFGY09sbU5KbnFYWUF4cjN1V295czNtZ21ybldwRkFj?=
 =?utf-8?B?QTROQmc3WUprZ0RJVExMUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aC9tZTA3Smsrbkc1Qm5iS25LRnoxa2dkMjZ0dXAvUTJjTUxDNDQvbnVjbE9Y?=
 =?utf-8?B?SGUyNWErMjJxd0FjeGNPVm1WcSs1NU0zelJxb2JHd0dUM1kzaFJSaDRYSUYx?=
 =?utf-8?B?MjlPRTVONGppTVVJN29oSXg0TTFib1FYdWU5cFl1cytCR3RleENiZytaeFRu?=
 =?utf-8?B?TlZ3d2plWFZPSzVhaUJCNTlYWW9DWDRWcFovZTIyNlhOckZld2JHUmd5TjZ3?=
 =?utf-8?B?dkxVUHk0RzlmY0JvQU9TMllONklsZE9SQlBSaWdHUUt6VS9VTkZRdnVvZmVU?=
 =?utf-8?B?Wk1ya3hLUzhaYTd3VXE1b2NucWV3eGh0aWlvbldQZExxYnZwQTV0a3R5OWNX?=
 =?utf-8?B?dW9hZTlvUzNJZVNxcVkyQ3dkbnloTGRJVVlTNWVnT3Nwa1hjdXhBVWJpYWZW?=
 =?utf-8?B?Q1NGVzhCOTRJa0E0NTEwWlZDd0hPWkMrbDZRek5pTGRqM2N1NEJsZlNVeFZZ?=
 =?utf-8?B?MEJKeUZSUWNWbmVUeTFQcXYyNEEyVHh1UVNzK1JxS0hERkQxaXdVQ0VJYzBz?=
 =?utf-8?B?dElRYklxc0xuNzJWelQ0a3R5am0zL3BDZjdoYXYzYk9OVDltcCtjNGR6QVJu?=
 =?utf-8?B?RjJHT0F2Zkpnb29XMzdmZ3JDRmtJU2NYTjVhUkgyR3gwWk1yTk1GYlVYc01k?=
 =?utf-8?B?b3FmSC95dEN5WXN1ZTlpOGpDR2JtNHZxYzNxYTRzSjQ1UVRmcGRJbWhCVitw?=
 =?utf-8?B?d3lsMUY3di9leVNiOWdGZFFtaVVKQjRVNkNoV2NkdUl2b29lY1Q2ZXN0SHFP?=
 =?utf-8?B?S1dDcXlqODByZWxkcVk3cnd3NVN0QmdkLy9GQmE5SmJQQWhJY29qbEkvaVp0?=
 =?utf-8?B?OSs0NzBOUEhZeFplb2dtSEtuVVNzMTkvanBKL0RSYkJENU8xVWRLNTdmRUV3?=
 =?utf-8?B?U1VxWVNWZnh2N28wM3RhVzVTYXYwMkcwWWd6REpDT1Fidm1GT0gwOEJYNWhp?=
 =?utf-8?B?dTlyVEN0K1ZXMVFLeDViUjYvNUZRQndHa3Y1aUZjSUl0VVExb3crdGhXckk2?=
 =?utf-8?B?bDI3a2xXUm1QVEY0M3lhZktjR1RCVDUwUlNrTmlidnc4ZjcwbWFKUVhaMWgv?=
 =?utf-8?B?bzhyODFBSzFidEpCQ09pQUR2WURIWGVuVkpSKzlnaWtLaTNvWUwrQnJJWnAz?=
 =?utf-8?B?dERLc2MyQ0dWU1ZsYXI4MnBrMUJaRFllUzJCUTBSdTZJZnJmUzZGbWZNWTBn?=
 =?utf-8?B?YndrSDNCelBUbGNyVnFOOVEyTjcwODZWR0JYY213QVl1N2RBS3BCRXFVZGdn?=
 =?utf-8?B?Z0dmaERRb3dJWWF5aFdJRmZZcEl5YnRqMEFPMngrMHRzUURFR2NBL2dGWE1o?=
 =?utf-8?B?a0h6ZFh0MTRqMXJ2cG8yZnFaclhuS0ZIM1IwcitOMHVDc2hzVTF1MWdBTXhi?=
 =?utf-8?B?MTB1Y1IyQlJQTHVwbStteXRpM2xMYm8xT1Boc05OMlFQbWQrbmc2ZjFDa1JX?=
 =?utf-8?B?TmduZ2NYaVoxYVM1MVo4c1o0M2xaaW0vYTk4RHVBSVZzOGJwbzFOOWFvejdx?=
 =?utf-8?B?T2hpQUlQRVgwMTliNm16UHJEUjE4S3dTK3BPVld3WGYzSS8yS1QzOVd0V0Nx?=
 =?utf-8?B?dUljUHEyOUx4dGtUMnBWQVZ0OEhTM053SisvbmdBem9TWnRHRzMrbzN4V2Nq?=
 =?utf-8?B?QXlYdjJtS29vaUZJTDlUN29uajdpVXFnVGw0STJKQTQ0Z2FMelVERFl6N0ly?=
 =?utf-8?B?S08wWTVZdWpyNjFyWGR1UXpMVzNNeDJuODdZYm10MjZGYkhJdTdUbDh5Nmdq?=
 =?utf-8?B?UzRPTTNZQjVORURLUWpLUEgyTmU0V3ZPS0RsV0sxQmZGclJnS0VEa3NJS1hp?=
 =?utf-8?B?WkNjYjZIeExKSDJPOFFqdGlxbC9STHBZellzeDY1S1M5blh2UWVEcTJHcVgw?=
 =?utf-8?B?VGFrN0VVcXB4bFY4RWZZWWFRem1BNUF2WTc2UXlQeHFrR1RmU0xQcThlbDN1?=
 =?utf-8?B?THR3ckwzNUs2ZlMyQTVORXRhalArYUdtMW4zQi8vQlFMd2RLeGJya255OURL?=
 =?utf-8?B?eUhoRTFLV1pqQ21NNXF4Q1BXQTFRUFpnUXNMR0V6WmNSMzZ5dFgzZUFhTFdp?=
 =?utf-8?B?VFVPVmNRaFhEQitscitvV3hoOW1MeXozTVo0MFVDTGVXOWhzSE1UV2JiYjhr?=
 =?utf-8?B?Y2w1cFY1WGUyQVRsTGR6L3E1Mm5iRVRRSVlJVFlOSVpaaUFyRDVjbG5YTW1i?=
 =?utf-8?Q?9wo/PoLzxNjSxi3365iOh91chdtc5b0Kk/XbQxQjYmRZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3CAB91E364D354287E40DB8A594F34B@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eb369832-0a4d-4e85-591b-08dc80567d09
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 03:13:33.2865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nW2w01QSUEC7TjLeSwqatjSrmnA/zI9fsZj8+jaOm9AWa49C9mAIeVYItFwUEK0XFj8nWyJd68NK9hphvCVRmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6563

DQo+PiBhcGFydCBmcm9tIGZvcm1hdHRpbmcgYW5kIG5pdCBjb21tZW50cyBpdCBsb29rcyBnb29k
IC4uLiBSZXZpZXdlZC1ieTogDQo+PiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
PiAtY2sgDQo+IEFkZHJlc3NlZCBhbGwgdGhlIGNvbW1lbnRzIGFib3ZlLiBDYW4geW91IHBsZWFz
ZSBsZXQgbWUga25vdyB0aGUgbmV4dCANCj4gc3RlcD8gDQoNCndoZXJlID8gSSBkb24ndCBzZWUg
dGhlIHYzIG9uIHRoZSBsaXN0IGRpZCB5b3Ugc2VuZCBpdCBhbHJlYWR5ID8NCg0KLWNrDQoNCg0K
