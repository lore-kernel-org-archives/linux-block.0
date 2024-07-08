Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7793214D28A
	for <linux-block@vger.kernel.org>; Mon,  8 Jul 2024 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720475832; cv=fail; b=hioMokSsjtop25X04gJ4Yx6mo88RIVVYmthMch3XTsX8PCl3xtCcSjEH69evQpZ4+QrGnO/ddsm/CtwpRG2xHFX4Gz0T4EwbnMl0oqPST8RiGCh8Y/CFY/qS8PfXg9qmAzStHK4iAxbWnlrqNdaTBvG+bpsxg5XHwKOWYPZMwCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720475832; c=relaxed/simple;
	bh=c0Z01cCkF+olQZnxapLxAhJZepTqbcutwJBOGDCVmdc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=soqXFAT59TVoS5B57KS2qgVJEQfvmLtiziCabyqjwnX74MPwu8WoJvP5WRRv+ewOztCsTasaKT7YU1jjVusfVP31ulC9NDQU9+oNX1ULUCwpgxpnrqPZAyC9smHhVpYQownLpJvdS3QUOcLfOqcgWL6CfLJwdEs4Xm+iUw33EX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qevZ/dgR; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qevZ/dgR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmgbAeb4UixVAzDYuNGvgc/QsWN/AnMS6X5uBINe98EJUqiFOwVmEVFO1zaNxOPGPGTFdpT2rDMIB2v3ESspTJ3GYhz6zRAiAZmUBGnY1SbxYfoynWLrgMCNLKhKCDOrbh7LvFCxzKCBkEvOLx+kaAlSx4KLMS1IH16PdpNz92JTHc+SMOkYTP45i+ry8hcWfqMR9AuyqTTqQVV2O6m3Wc8zYtizdtO01sasuvjeON89CtJg6Aq7UxaLc/3rSr7YWXDAkOrLt8G307Ac91UFAhMuVrsrxr3gpE37m9+lrDj0ua6JjGAlei2j5iGCVotjfhPYpoHu1hD+jAdh2nvWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0Z01cCkF+olQZnxapLxAhJZepTqbcutwJBOGDCVmdc=;
 b=a10q0L/fjacbxAyYavRJlqm84I8DJzv5btMy5KlSBlIqRUesaWCjO54yusqeAhSfYTokfYhPzhec9sk/T2QEUSsa4/cAdWolwnrZ/0DcgpTQn+nlVLu+Jn+0H+2Gwe2sPyKkPmmIqWLpCX8mpuWMXdgKus3JI0mXn1MAaZwp+zXEKtX9owommid7fcRQDrzs8MsOWW1Uhce3KrclDvgvgkNPxQ8UU72d5awRBNrcvQnFAkV6BzzOLeKPECVS/zoOyZHgEbr1/fgceXaM4RmeKhVdfrcCZ5lQq/CAoFDOR7uMDHycKJrqW5jbIKuZzNke6zh9jzEJjQobSI1zQ7gqrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0Z01cCkF+olQZnxapLxAhJZepTqbcutwJBOGDCVmdc=;
 b=qevZ/dgRaq4ON3XzM2cHLq0W/zU1NCZee+7G3rJ3yxMsMqPAntDas+YTd7B/VH8qeAVXZ8qiiZgTh41X2pHdIC466JHV8dBhfwA27bvMv++KaWJGeRqpe6Sm+7MGiLSNBVYYsMKu0RvNH2YrzCdELGpi0sVRXyVaMLXrJCF7BZXpK1S2sCoS667Z7CiX4WvyVU1/7PRcF5ViJW0AzcBZOYIn/FmX9WiW1qeoRjvCIBLkp1DKWoAm/35g2d7u3lSzPZjsPsdzI1OryS+3NbimOeEVv1wunoGmj47bwSQCOac/tF/d/yMiTDV75bGMgrH8YgnGMRkRxZwbIt/4F6HwRQ==
Received: from CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 21:57:08 +0000
Received: from CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::ea8c:ac6c:b8b4:c6a6]) by CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::ea8c:ac6c:b8b4:c6a6%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 21:57:08 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: remove QUEUE_FLAG_STOPPED
Thread-Topic: [PATCH] block: remove QUEUE_FLAG_STOPPED
Thread-Index: AQHazQiATv1TYdUBy0aexA70rhJTZrHtaX6A
Date: Mon, 8 Jul 2024 21:57:08 +0000
Message-ID: <9063fa4a-835c-4de8-a093-ba7fe9673ced@nvidia.com>
References: <20240703051834.1771374-1-hch@lst.de>
In-Reply-To: <20240703051834.1771374-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR12MB9386:EE_|BY5PR12MB4292:EE_
x-ms-office365-filtering-correlation-id: 893f2889-78b7-462e-c2cb-08dc9f98e98f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?STFvRG92VVNYNHRWeTBTWXlObU9QejMyNWExeG92MkJ5ZFRqOWhVRVlmdmxG?=
 =?utf-8?B?MWhRVm80TWJteEZ3clg0TWpLMytRUU5RRSs2cDJ5TkUvQWs3dnpNZzhpMzVx?=
 =?utf-8?B?dWZOcHNiMjZ3ZHlkUVNiWVRsbm1SUGlNM3dJVWF3RGNIWGpvUGl6ZnBiWFBl?=
 =?utf-8?B?ekVMZmI3bGp0ZHFmR0lRbHdnREpzaWp1QmM0Q2RYMk9QbHJpRGdhbmlvaFVP?=
 =?utf-8?B?STQ3eE1PbHN0V1grYTVDQ25yRllzMGlTNDFYbDBxeDZYWFA2ZVNxRnlWaWpm?=
 =?utf-8?B?UGFWNzFNT1p2aytpVis4ajVONGRrT00xNHdGZEtmTEg3OG5EeFhMejhGYisy?=
 =?utf-8?B?MHBCK1lidUM3MzJIaGFqWExoMnpJT0ZZMHBadllkaXJPWnF1ZU90Z1ZiZUNH?=
 =?utf-8?B?cXJ0R2pESjFXUFd6S2FhNEp0VFNDMW9Nc1JmbWdRcGxsZk1NZWVaWHpGMXZQ?=
 =?utf-8?B?Yys1L1dEbEU3dkZ3eGxkM1ZuMWpwTlFxTmsvcmorMHhGelJDT2wwYWJyb3Fa?=
 =?utf-8?B?RXMxQitLbTJ1VDhsMDB1YXZzYlFydkFnS3pjSVBhSWNacmdtWEZoam5TZklw?=
 =?utf-8?B?T3liQk9Eekp0QW50OERBckg5SHRCajVVdHpVRmZuc2hOSkNJMDZCSXJZZ1Bv?=
 =?utf-8?B?MnJQcXVRYVdNcEVoM0lrU1JzWVpaNEIvdVZjdEZWYVd1WXZEYjcrUlFyVmxr?=
 =?utf-8?B?a2FKNGNDUHZYOE9haFBCenZWNVRYK09TbklRancvWE1WNlF6cGgzQXZsb0RI?=
 =?utf-8?B?NncyckIxYUFBdEJ0MnBXbkVhVWlCcWdRalVFdjNsb3BRSElrV3RjczJueEhn?=
 =?utf-8?B?STJrRmFOZ0RMV0RkeEx2RlUxTkJPcThMSWJVTVpKZW5YSXc3emRsUTV1SmRv?=
 =?utf-8?B?UDZtUkU0SmJWUVY3MjJRSVZ1LzZyTDIzbkJqWnZsRm1LMEE2NHlwQjF5c2Zj?=
 =?utf-8?B?WVNFdnVvOWt4b3o1ZGVSV0t3SnVrL25FdUpVNFVNVFg5YStBV1lSOGJLV0Zk?=
 =?utf-8?B?b29SYTJITkpYeXF1MVJtdEFRZDJydkxyVWtvNWlONFhWaElDWWlQK3lyMHph?=
 =?utf-8?B?cTdnL1RYbzRSODQ3V2w5NUx3Z3FIOFEyZ2ZZb2hVYUN6QndjaWdWNmQ3TktU?=
 =?utf-8?B?dG9uYnZDNEpaQTBjNmx2dlFFazR5OEtpdmNGWU9SWmVaLzFWQTIwSk5OWTNV?=
 =?utf-8?B?MlZmWkw2WWNueXJCZ1dXeDBYOU1SakE2cTlmRGp4cVI3c05UTHkxQys0K3E2?=
 =?utf-8?B?L3hLZVd6SXJZak55UWxYT093WkhjdEVMODVRUXNvZ2kydFlqTWJFdjFIT002?=
 =?utf-8?B?ZmhYTlRNNTRadlZSVUVjcnhhb2YrWXJaQzRRSTdVZXlQRmhCSytUUUZveGxr?=
 =?utf-8?B?eDQ0SGZQaVNEank3cmV6cisyckJ2eGlaa0pIWGw5eitGM1piWnVBbjgweWpE?=
 =?utf-8?B?bFpTVEdwY0Y3cXZwTmJvMFNLell5cmF2by9NUWlzcFJ6M01MZzFvQU1Qa3A1?=
 =?utf-8?B?M1lkSFBrRC9LWHRkUjVab2QxMFBrenJpSWluOFpCWFpiR09icSs4UEhFUGUx?=
 =?utf-8?B?akI3YXNqN2VNS2NsZVhaalFlUWlCRWVyWWFORmFpYmdzSkFlL3VVWWNxQllD?=
 =?utf-8?B?N1JzN3NEL0FyUnNVbXk4Q2tvTmtkT0N5VVExc0NRSkFhczA5M3ZndnRtZng0?=
 =?utf-8?B?NzdSTGtpcDdMVXV6QkZZcnJaT0pFWVhJa20wRGw4Sks4M0YxZ1NtcXIrSGNw?=
 =?utf-8?B?by83S0I2VjliT1EzNngxU3lIQXV0ZzVwU2dMK2cxTU5uaGNKVkpsdzk0MHpO?=
 =?utf-8?B?NUtBblpRZG4rUWVKU2lLeHNVVnZRQXJ3ZW5VUGcrVGVpVDZFbXV2MmFxcUJx?=
 =?utf-8?B?L0RYMDlsZWNGME5maGFtT3g5WjNrbiszRlcxVUJoOTF2L3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9386.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a3VUeXZuMVUxa0xuUktzUGR5UHgwdG1jdDRVKzBybkpaZ1VCRituSW8wNEtI?=
 =?utf-8?B?WFZSTEhUb3E4ZGhiWjUxcXoyM2VPUHYzeDJKOU0zb1JDRmVUTjA3Rk9QM0VX?=
 =?utf-8?B?b0Z5UnI5emJqWm5ISnk3cndheis1UlpocTdmUm9IUE0rajJSVWFPZTk1U3Fh?=
 =?utf-8?B?aFFmZWVUZ2VKZGJjallvd3N5dXNSS0RwY0NTR3lFejhKOXdUTkxhY2V5MVBW?=
 =?utf-8?B?bmZkSzY0ajAreGd1WGppai9aTDRMelFMbWU0QW90YXN6SXdVZHA0UzVLR0E3?=
 =?utf-8?B?RFBDb3Q2TjZERC9hUU1yWlhpMGg5cnVGcndNOEpXWVRhTnByM2hrc3JoWmRl?=
 =?utf-8?B?TUpYN1lVa1RubkliU0h0dnAwRFo2THB0RTliTlZwOSt2MkVyb1hOSVBwM0Nz?=
 =?utf-8?B?TDFxcmRnaFg5NEZ2eEVTaVVFeUdYVWs5NlZkekpDZjU5QTBCMmVSVkprVEhy?=
 =?utf-8?B?dER6OE1VT2lYckVlUERBaW9tYmZvWFpUWmM1RWN0ZUxuN0pNYkpoUFFLQUtF?=
 =?utf-8?B?ckMwNytxVms5QTVBSFhXWGVkT2NINWZ4bDZudHBYaGcwVklQUnFJNzdWNE1D?=
 =?utf-8?B?djZCa25iNkFOcVozRVpvRm5rQm15Q3VuaENkamt3NlMwZ21ERjJJbGYyQ3ox?=
 =?utf-8?B?OHk0ZjFpcDFXR1BHcXlXTno2cm5OK0RhcVlmZVNQUjhmeGZDM21qM251TW1T?=
 =?utf-8?B?eVFlVHY0U1lYUnlJekNjeEg5SWpZcS9PZlRRNktCbkt3NjdqQjFYOTRLaFRj?=
 =?utf-8?B?aGhBTXVvYk5ZUHd1MVp4U1ZPN2F1ZW5mUXVUWU9nN1YzRCtvRlM3NDdERmJa?=
 =?utf-8?B?eEdnVDNLWEV4MW83SThqd1pEelZGOWQ5ZFdIYjQ0dDlKR3FSdkU2ZE9nc2pU?=
 =?utf-8?B?dUVZMldUWXk5RlVYYkZ1NjRJZ0ZyMm93TFFSdm1wNTRNZGFoeG5BQ0lYZ3po?=
 =?utf-8?B?Q2Y5TXNsZUY1bDBVMWxQUENsaDJaS292R0lScXBxM1p6YXlpL1FNcERJaHp3?=
 =?utf-8?B?QzdPbjgvSTc4M1h0S21OSzVjREg5ODkyYjdtOHVxZ2hDSWkyckZZNzdtbzdo?=
 =?utf-8?B?dGNjMDZ0cEJTQ1NJTlpvMCtJOW5DLzVacEwxWDJvYWQxSTliT2RmVWFiT1gy?=
 =?utf-8?B?bENCbFVqZzFadUEwb2llN0k3N3A0eERoaXlHWXd0QnNPbXZDVml0TWtGcDV1?=
 =?utf-8?B?dnp2U1IxSHBFQlJUNWdDMXA0aFhGYWREM3lkc1FlcDJpREQ4cmdIQnQ3VnE5?=
 =?utf-8?B?UUZHK1MwWVpEbTRQNHVSbmpLQ2Z1RWxMaVVtOTFseEEvYjBIQVhSZ00rK3VJ?=
 =?utf-8?B?U0p0d0ZxYXRrU1BPUkRneVl0K09qTUpXaFl2UjdZdGJ1VUNBbGNwWk1kWEFU?=
 =?utf-8?B?RnUyTitXeVZzZEVKbDZIM3hjSEFEU2M1eVBsR3ZiNzFleUFXT3FSMnZZdkxI?=
 =?utf-8?B?TlZKemY0Tkp1LzRwODRadytMaGV6SjBkUHdSOTFQWnIyYkdVN056YjY0M0hv?=
 =?utf-8?B?SXlKc0EzMWdxb0wvZVlPY3JIV1Q1QStaS0FUUVhkWW83Vk5sS01MY0REOW5M?=
 =?utf-8?B?MWhCQXZXSFhLc0ExVEdLdXg5a1lRNUZialhScmYyUnB5UEJxZEtUTVVkQjBw?=
 =?utf-8?B?ekp0WWIzeVEvL2Q5QjFQZGU1dWd1S1c3Y284L3VNb0Z0UXJ5TUxiMkFuOVd5?=
 =?utf-8?B?ZXdPRThlNGNJQUlmVjhaRTQwZXhuOG5QeGVhKzd1anFvZVU3ZHdkZEdBNGFV?=
 =?utf-8?B?bkRxWXBiNlp1L3RIQTBVcndvREZ0aGNJMkszMnpENGNpeFRpbmhzVnlxZVF5?=
 =?utf-8?B?aEIvZEtSYWFoeENGTnNWcktibmZ5UEx4STNLUmJRQVlEZ1pncnpZSHgzeVU3?=
 =?utf-8?B?V1lqNHlKNGN1ZHl4eW0zQk1wUWQyRk9hRzVvVWZpZGxsZEs1SStxbUFoM1VW?=
 =?utf-8?B?OFowc0d4YXp6Ym85TmF0ODd1OHVvZWdqRTcrZGtpNm1Ub2o2aGJNdzdyVEFk?=
 =?utf-8?B?QVhPZmhoSXdSbVlhYWhwckllMFpvd241ZFlaZlJTK0lJRmhEdmdyb2VsY0g2?=
 =?utf-8?B?OUdqZnJnU3VuRDhFRld4eDVOMWE5T2JxdlNkNlRweXNBdGt2MHlUM3hoRzNq?=
 =?utf-8?B?NEJEeFFNL0dUQlNBUFJYNjBGWFBUMWtRN1NyM1lVTmR3SGxCZzc5N2VJVXhu?=
 =?utf-8?Q?ZV98WczTqrcJGWk/CoJBg6rFF4h/WLA9VwsIHNVObELC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED0D36613581BB45A6F892DB85370021@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 893f2889-78b7-462e-c2cb-08dc9f98e98f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 21:57:08.1819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pi51OV9NG7F8Ii6p/4JfV0XrzTJMhezrq8+/Zk5Hz1ScMoQMxn7uvKeusYuBondUljiVMsj8QO5Hmrqo8P7C4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292

T24gNy8yLzIwMjQgMTA6MTggUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBRVUVVRV9G
TEFHX1NUT1BQRUQgaXMgZW50aXJlbHkgdW51c2VkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hy
aXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZp
ZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
