Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FC73A1D2
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 00:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773793665; cv=fail; b=tDwqXXoCFkPcOD9oeHt0cjWaQJ3x8ic9oZcXPthQ5aE19fjb29xKzicgs3bVHEvbXyzv52Ws5jO65qy6wilryK0xo5fxK3Ujoaq0lVZqV0UI3bpJ5MAnCszZV7hUXpU+yqeDugLY/vRY2bfmLAAsymhKVltyC4Mc+HmqDu1PjHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773793665; c=relaxed/simple;
	bh=ggW6MGlyJjv0mGGiYFeLAoPseqNC5iHN8gUoG88RmfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ucOIm99gQF8eFLnoWSrwtR5eLuvPx0l/krTNuPvEPbr+aQOpDpXLArV7gOWkrz2ynv3/tgTYPiOrQDypdNst5WmIYUr9IBVHZK1a4tI1+q5sIT2yBY9gindJuqL4EwxCFlyPdsXi8UaKsPCtkTY4rCVC2UBdhp6B82h3KWKfpRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V+oOtkUO; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V+oOtkUO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cu2bZC2QLWMcUBxwHyghus8LFh8Cq1akuIwAVxDU8Wk92x/UZ6rwAZw31g5/3ugLEsdy9Dgc1LndCDeNV7JX0DKWSahanAWUsCEfgfBK9j4pQ8pSK3y5Q5lidW58Povehr+rBbC10F8nZRGLElu8xtpMug1H4lvDg/UZ+MlyDXOb59Yjrr1CqLgY8MzKJZAmkdEfAKhrs82kmxTSmqp//vqO8HsBbAoRT+GTsu9hgiHlbz+l4/gAXyVnkgRavuH8rQ3LRkFh6CWR333+2LgOirfgbRDpHtuC0e2MNx6rz2cPZeMkmfAm27bQPQMGsd81y9PnEovWoEvguztLGeeXew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggW6MGlyJjv0mGGiYFeLAoPseqNC5iHN8gUoG88RmfI=;
 b=hw0rsLB5iyIVxmTHn2uWgTBR3BSjup50D0JbSA+/IUqPbaf1+ZKA4mvmAjMYqh1Lu2gt5XggafoDHnuLUG4q4upDh6o4Tj6CTNk4eY6xb8ZiBKvhpbHY6CkBuJNARkwTiC4jxANCDuEMbR4026cGPKTEVs0GFRZOvRw4H2kfR+ZCkP0QFZ9FB+7xBcamagMQp+n51wcHoaYEcKa9ws4PYcU8Yqg8NGEqlw9AKK5veOEcujUUdewJo0EPrdgvw2USEkUcnHHxpYZprQyVAbpcUuqNIzE2Kq5MpIZJ/K13MCD9zKG/AgNvZYWby5T0zN2EHZSVwaE4H1tS+yEMA0KOyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggW6MGlyJjv0mGGiYFeLAoPseqNC5iHN8gUoG88RmfI=;
 b=V+oOtkUOuLt9f51Zkvle/3uRsp87bprbXFoBe8ZOMChmGQQ4MSorpJzeN9vWwjQt2K2o4OUiZdOWbebOu8fSXmzXzeEwuWsqpDih9A7qi/cymos7eKob8XmknGrGnrm3KtPKbGs9PBgXmes8caQupCEholo5378wdeMic31aDYMJUH9T1Okes0fnsKkO5gqqU0+KGUzMr0Hvt9MDNDk0+5gDoyK9WRLAsY25dmSBDfYC/NQasaM+uC2llIQ4YgtmKwlYg1F/iKww9TkDVHwvMjZRiCwujes4Gh+DCkU1OgodJezUY2xRbvi8Pr64hQ+wyFHZLk7hiC3/6EdWm4t6Tg==
Received: from CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 by SA1PR12MB8986.namprd12.prod.outlook.com (2603:10b6:806:375::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 00:27:42 +0000
Received: from CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::edab:eb80:ee7e:e9b7]) by CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::edab:eb80:ee7e:e9b7%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 00:27:42 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/3] block: remove bvec_free
Thread-Topic: [PATCH 3/3] block: remove bvec_free
Thread-Index: AQHctV/WL63TJ7KQDE2OdhzK8BwGfrWzcVCA
Date: Wed, 18 Mar 2026 00:27:41 +0000
Message-ID: <469e7185-bec5-4cdd-b3c2-83270a4e74f4@nvidia.com>
References: <20260316161144.1607877-1-hch@lst.de>
 <20260316161144.1607877-4-hch@lst.de>
In-Reply-To: <20260316161144.1607877-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR12MB9386:EE_|SA1PR12MB8986:EE_
x-ms-office365-filtering-correlation-id: ab5c507d-53f4-4697-a3f7-08de84852b05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 dQ+9G7j1kP93f3U8OCN+ZMXXSUg2TlFiu7sUcuebymhRWoDAtNVglVObAVwYv2y7LiHMIiiUNMVg+NS3kViGs8+2qS8t11HtXzasw9tySYv2V3V5NeoGWlzK92XcPsDGAqxeY8MNeZDx1Ahi25GLXICnqcAhjymzaRS+tVm3dBV3pEbl3WW6vZlWBjq9pIRapy26ZB85wg3pvNpTrBBWh8cY01z7qrm8xSjxarQh8YmU79OlFeOi/WSZjUSl9Vc58OgxDfgCTOtc6uS+4uD9Bk6q8ADD6WzKbaaThC/FXrFU1TS0NZ0YQjtWFdKouttVUg/7FScEvZqHW+DOe125T2pPdEuzErCg6ffU78AjwYNt0bVGIJTWgC0Y9i3x5emwpxaeBn0602lzsasSjRtddULIZ9jRUGAz6cpSTk++dssFf6QMYA0bG+JPAejOZeSNQ4htqg39QFIVG7fp2agnxnYU44DOTl63wHSsT+7lE/pIWT/5wBzygytLLV/4tJkYoulR6Zo0PdnRG6f5RYlad2RT3FOQm9evdBLxe5zTtDi9AvogBjySMY8cX0RVD1ITsGJaXxbii5sgRjGKIUmShNfbW4kDvDt7QyoT7IhiC8p7doqucxdFIGTwvKWVQ7W3ISKk4/7LiRq9pt/9nPs0jtCMZKQHq5zU+GLF0f8r8M7KU2k4oime9qxN6bzEwYOoowsOOyA7WRxnzD1YU5FYTOd37rr4cCsY/C52Ak1aJg95T1axi44Dzqm1d+ex2ydiMtuFAcBYTbMwzcCzoQk+ktGyPEBVQVOGWSoqOuEBldM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9386.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ajJ2aEpHemh3ZWg3TmFlK0VwTFAzWEowUXFPM1Z0N2h2U1hBcWxNTVNDck9j?=
 =?utf-8?B?bE1UVDlHSi9tRGY1Vlh0cVU1Q1NYTkhIcjR6aU9yemtaVm9TcVc4ZFo0VFpV?=
 =?utf-8?B?QU8zSkFGclhud21rZ3dKK05kSHhiZUE0THl1S1ptSEpIcXVCcmIzaGsvb0Nj?=
 =?utf-8?B?TUxQbTV5ZGRMQlNzUTJOeHowbFgzcTNqa2w4czlWOXE0QjdBbytnR0psaXpo?=
 =?utf-8?B?M2d0SGppc2ZPWGJOK2tWU2ZJRW1kRlRKdkdHV25yQWdKcWt3QSs2VXE5NEZM?=
 =?utf-8?B?anN1dStlcVlvcUVWL2ZJNFhKNzZCWkFaanc3dkRFWjNTMnFtZjNoUXZ1dFNZ?=
 =?utf-8?B?SSt4OXdRZmJ1ODFmaUIyaVZNQ0F4T0swWlpaVFhsdTVNN3kydmdoeUtMQlV3?=
 =?utf-8?B?MFRFNTg3UGhFK1BQUk5pS1lrN1R0K0VIVVBoQ0s5VkhHb2FrOVN1OHFsL3ZI?=
 =?utf-8?B?YXppVzN0MitSNFF3ZVFjSElPcS9oZTdMUmtLV2x0NlN3bDVkZnI2OHJ3ZU53?=
 =?utf-8?B?UWNRTXlMK2cyNXljb2tMcTlqTHhBWDZiM2Eyak9rYkhOVnBYbEY5N0NnWW5L?=
 =?utf-8?B?cm5wVmF5TitrbVhmQWsrQ1I3Y3dWK0N6aTVCUGtVeWJuUTMyUi85UnA2UlVD?=
 =?utf-8?B?ZG5DMkFXc2JvQUJYb2YwbktlWFFocHBzNTJBQTNxNnZheVVkdndnSUFZSUVv?=
 =?utf-8?B?a1B2eG1odnhPN0VYQ01SWlg4N0tlNm96VTlnNjNhTGkyenE0VkV5aUJNcjFL?=
 =?utf-8?B?M1VxU2Z6QXFESkgzeWFpR0N3WEpkdkl4Skw0S3ZMZ1V3S3ZKQm9FRHNUZkJL?=
 =?utf-8?B?TjlXMVFRWVpza2x3M3M4a05Rc2lLT29vY1pYSlc1aCtyUG1jOEk3ZzNLWFlN?=
 =?utf-8?B?UWRrZHRSVVQyUVQ3QUMvOWFxRlVkYllzZ29GdDZCQktoajdZMjZlWi9ueEhz?=
 =?utf-8?B?amdJa2FSNElha1MwYzRtcDU1d0lyZnBkdVdwZnJxMEFTNkNQcGxnbk1xRFMr?=
 =?utf-8?B?bkRSU2RmUldQbTQ4L1p4TG9BNUozeC9ycWgxczZnVG1GTStmVldud3V3ZDlS?=
 =?utf-8?B?WEt5OHpyQ0VKOEs3RmpmTU12d3NqVzF4cGllaUcwaVRCekI2emFsNCt6N0Y2?=
 =?utf-8?B?NldubkgraTRva2pEemcrMSs1MlI3RmFNQTBsUUhWK2hwTXhmeUhoU1pIVFhR?=
 =?utf-8?B?TStpbFgyZmNBVktKYk9zYVEzNE5mcVprcm4zMmlzYjR0UVIvOXBBblJOc1R2?=
 =?utf-8?B?dlZvQnpaSGJaUkNSR0VLcXZqclBHT3RSY0gzM0lmNERoOWRObFgzNEFVNVlD?=
 =?utf-8?B?Q3dOZ25qbnJBejhXR1Vsdzg3aFM2RGRWRkhmaTZYYXBqbEFnVTNoMUNqb1pZ?=
 =?utf-8?B?MDVwcGw1VExSMUxyZEh5aWlkUW15eHZ0WkpYY0o4THE5dFBBdUVGVW5Zb0N3?=
 =?utf-8?B?ZXI3RFlUSWxoeFp5Q0o4NHlUaWtlLzN5Q3crcmhXTmJRbmQ4MzNiRS9Rak80?=
 =?utf-8?B?bksvMGNBcERsOHYrNnpRV0ZJaDFqY083M1lKM1VGTnVpTjdlVE9GYkR0dS9B?=
 =?utf-8?B?bHQrRzM0ZzlCb3ArWEdyVlhnNEg2bnRsakY1VW9ST3JreGZhSHc1dXhEMThs?=
 =?utf-8?B?aXJIVEt3ZTVlNzVYSmxPUWducFprSDVqejVqL2hHeVFUdVpsWDY3aFM2dEx3?=
 =?utf-8?B?dkFhTmhtOWF0OE9aRlBOaVp2QVE1RUJWRm9ESysrZWNuRExlNmpVRVJaU240?=
 =?utf-8?B?OUVLZ0V3c0o3UzNObk8xaXYwQk41L28zVS9EK2oxcGczcUNPVUFGK1F3TlFi?=
 =?utf-8?B?SlFJaUpCREM2VzhmU0pkd1hpc0dqd2NFZjE5RE5scE1rdEV6SXUwb3hiWEVx?=
 =?utf-8?B?Zk44YXA2QzNhYU0zUnBWK1p5MWZJZEhyS0ZpcGc4WFArQTVwbUhYL1hyM21h?=
 =?utf-8?B?Rlk1eWJyNE5VeTNlR1UxY21wT2RVNnhTRDF1Vzh2MnRaWFQwYlBocGprWU85?=
 =?utf-8?B?aGVZTHRPRm0zUUVlU1FrZWlWVDQzckpxR2tZZzZWOHpKSTFVNUZtd0xpSHFa?=
 =?utf-8?B?Rjd6UEgralgxRU1pRjlvTzE4bFNYOWpvVldveDJSUmRsb3NHeDF1anpyVlRn?=
 =?utf-8?B?cnJ2YjZpK3V5VEZYS1ZHRUsrMFkxL2JnQzk1QnhDSXo0K0Fpdk5kOTVCNWJ5?=
 =?utf-8?B?RDhCWFN1aXg2M0Vta3R6SUZjeUpUdVJ3OXA3bHpnSG9kbnpxaE1ZWTR0OGJP?=
 =?utf-8?B?UXJ0RTc5cC9EWjVSSksxVHB5ZEw2Wi9KV01UZ1RReXVrbDVGYVowWUJXOFlF?=
 =?utf-8?B?eFR5SndXYUI5dVNUNXkwck8rRkJYcjF2VmM2L3UzcVhMN0xzbjJOOW11VkFr?=
 =?utf-8?Q?EX0W/YNuYn9CBVgb5DewpGu3NE7zSYZskvFQVBBjvBvib?=
x-ms-exchange-antispam-messagedata-1: modFYxTNPdE1mA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6D7FE80451BCC4BBAD9C97523E90FE7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9386.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5c507d-53f4-4697-a3f7-08de84852b05
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 00:27:42.0224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w9uIPDpW7B3RM95N4X7xm6UPmEkUIAbVERkd8/h8kumM1lEapLy/P9teoHoQixRX/EhC42ukHlW9qB+qVRbYMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8986

T24gMy8xNi8yNiAwOToxMSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IGJ2ZWNfZnJlZSBp
cyBvbmx5IGNhbGxlZCBieSBiaW9fZnJlZSwgc28gaW5saW5lIGl0IHRoZXJlLg0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZzxoY2hAbHN0LmRlPg0KDQpMb29rcyBnb29kLg0K
DQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4gLWNrDQoN
Cg0KDQo=
