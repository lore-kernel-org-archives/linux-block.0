Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011023.outbound.protection.outlook.com [52.101.70.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77242BE043;
	Tue, 16 Dec 2025 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765879376; cv=fail; b=eM4iufqHEx0U55XbosrEaZP6uTF5dvKD3QGm5TsAB8E7N1Eri5J2WPcLmuIxa+Zf/LjRFdrho5zpmtwP2YpxoRddAxlXPlxXL2DLUPWcEwlhitQjmM7BP4nbuKGuHYeDK1bJz/uyG0BPFT2x3hFdMxeDkSwlm9QAWgN2ASGbnaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765879376; c=relaxed/simple;
	bh=LGY8CGVWQ9GCtdx0z2NV0QNczqIOQOwz0drpzGV5B5w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X/5T5AdhO6Y1I5QGlhXgbHjscYyc2vFNLa3Ybyr4eyx+msUxoL9P7IeG58bYBye0GbVu84YuKOk1JJ6/JFwA9Zj2YfHyqfX0HhbCwGTZxYg5qjHWRPs+q+LEk0jAbpzBJDEySt88S70a+oPN7Jzhg1PsPepDvmls+/amVpBLJ+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kuu9Nx40; arc=fail smtp.client-ip=52.101.70.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kuu9Nx40"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzutKAM/e/g1nl2cnDYrWWw5o4W/fROlbtCyY1omSNOkJ+QyG3acLFAOME8+9vkJPeQxq9ExHFL5TpxF9HXM/JBSsf5NBr5HtyOTJqPdmsFJbIhORHSQ9/KgGFAUGum65iZM4mreHPFR0nQF8G9dDXH6aW+CWY5DvLZWSnuL0QP6fLqJb/PvtBrxnHaO0JvkmtJx4N66/UdNuGXYvPLPoT2K2DTPAbvr4Xz/gGd04YxjaZjUF7kLCV1SZqoBwjtxfYMqwYo4CBZGUXRYnYpciBNmfF+sVmsVjSOBTlFVnYSYFzqO0+jERUxLJ40wNoHaolvtdhLkjKLwzKax+/63kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGY8CGVWQ9GCtdx0z2NV0QNczqIOQOwz0drpzGV5B5w=;
 b=XFNYWNpeiB+SflVqH0d5kk7KkQReTQJqCZilvTFePbDs5U4xLnoRStOVGEHJ7kph58cqzoV3UL5y32Rae96lIq9blO9NiFtsYkabLzdnhCwL6yre9e61e9Yr5qujbDtnZQEL4tx3Wtlj7yYI0Lb45a9K5xnOIhF1JhZ+som8OUy/LWVe511DLn+jnH1GJkYI0CZgGQ4ZTgP0864kcOpq0AuTmDLIGZNjOT3hAWcxDohRbyuG+YHbxKYGSPGOe1v0PjfVBBXBuhyATRQe0UJ59yO7aofdUBiucm9g/L1wYHZVdbpLkhyQ+zPYAFnxvmrPC44NYY4+CenQBxtREUed1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGY8CGVWQ9GCtdx0z2NV0QNczqIOQOwz0drpzGV5B5w=;
 b=kuu9Nx40rVm3/V5QoFE2Re9SBiljuNLwAfU4sc5rVK2mma6RxzugEE+e5EqRNAii8x79QYpf5QUSza9NCOPOWbMk9RJLyV0Prv3vuxC+I7WyUygXZ+QcosFYFVRnIOPuLxO0pDDtN/FZr/dxAseUmW/55mI7EJFLkgjDDiO44yX1tmxHhQqZwX9bpcEfkXivxOwNKnxS95qKexUjaRMPxCVUKqpJ8PAGO/0hsjOWYFBpYR8ExLVzxJPYWC+N147eeyPmPafkvqO29sLfV6kaZrrBvl721vGEvOPUzAm7Yrlh1fkxw0jwAH5LLgAvhvZysd3szxXFe04ChmeOtzXztA==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by PA4PR04MB9294.eurprd04.prod.outlook.com (2603:10a6:102:2a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 10:02:50 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 10:02:50 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v2 0/2] Optimize secure erase performance for
 certain Kingston eMMC devices
Thread-Topic: [EXT] Re: [PATCH v2 0/2] Optimize secure erase performance for
 certain Kingston eMMC devices
Thread-Index: AQHcbawhD6Rf3BnhREuZdyf1tcRjsbUi1jYAgAEfUsA=
Date: Tue, 16 Dec 2025 10:02:49 +0000
Message-ID:
 <DU2PR04MB8567C09C52C66C59C9CA6607EDAAA@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20251215102010.608421-1-ziniu.wang_1@nxp.com>
 <CAPDyKFoLmo=qDru67rj63gQwMjLqVKS+wEQecukuC+3Pz_CjDA@mail.gmail.com>
In-Reply-To:
 <CAPDyKFoLmo=qDru67rj63gQwMjLqVKS+wEQecukuC+3Pz_CjDA@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|PA4PR04MB9294:EE_
x-ms-office365-filtering-correlation-id: 633fc308-40e5-4c11-5f07-08de3c8a456e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVUvY1BxeUxkYm84MC8rZ0lsWWcySG0yT3h2YVI5N3BsYU5LYmtxSDJucE8y?=
 =?utf-8?B?YVN5SnNTQzdkQUllRHY2V29MRzFhWG5RVnc4QmsySnA1VWdITHpBYW1kcjVx?=
 =?utf-8?B?TXlQY053SUNYRytoYUdhMGZlTmNGS3B6MDVNWjNWVzB0akZheWd0TE1meEZT?=
 =?utf-8?B?d1YyczNqdXhXSkFzVzhITTduTHVPRGRGUUE5QUU4UGNQVHRoWThUV0hubzZ2?=
 =?utf-8?B?dVZTKzM0NjBXTHZVZHJKS2JBVTBQYlA3Y2JWUEgybTBad1lQQW56dmptZmNw?=
 =?utf-8?B?U2N5QzJNbXZnMzA5S252ZjZSR1NHSmRvVkF2OHl4VGNsTytKUU9iQWRLdmpm?=
 =?utf-8?B?TXZDbXZJcjZQaXo1QSt6VFZUbTdDNzlCYnc2OStIOVBlOUJYOGZXUFJhOTdp?=
 =?utf-8?B?U2s2WDNENnJBdDZqOVNhRVpvVko2REVHdHp6NHY0Q2hvZUh5YjNXS1dKczF3?=
 =?utf-8?B?VE1veWxNVk9RSlFOZW16M3lqMWUyblljZU53YWhvZzl4VEk5ckxLZzNySGll?=
 =?utf-8?B?aWhBalNsNWVyK0tLWGFZaHJoVG8wcTRybTRsbm9waExIV3AvS3AwU1hWQmwx?=
 =?utf-8?B?UGJjbkV1L3MvaVlDekx3SnRTMGx2Q2JpbUtDTnlONGp5WWZ2UjlVbEJONWtx?=
 =?utf-8?B?TXFHMG5ETk9UR0xIMlhkRWlvMmJSUTYwb1QzUk9vOG5DQVpMeVVwYy9lYmZR?=
 =?utf-8?B?NHJZS3FESUtDdWFiQ3ZHR2FKTVZYUFM2bXhKOXMyaytBdENJRnBwUUR4REpt?=
 =?utf-8?B?S2pQREsxTTByYjBubG9JRmJWOFhVL3J0VjZJNFQ1aFZ1bFpZak1zNGNtTWlW?=
 =?utf-8?B?b0N5c2ViekE3SmZibEdpOHdIMko0UzFNRE9SaHRhaTA0OG9CZzEvZXp1WGFC?=
 =?utf-8?B?cW5KdkNVMUdBcTNzY3hHTmhValF1Mks5YmtXc3dUbDdvQ0NUZUZwVzJQL1BK?=
 =?utf-8?B?a05ERjM5b1pKUHZGS2FzQ0hyM3Y2VjZwWFVwOEpPL2VrNFNhU1AvYXByVXh4?=
 =?utf-8?B?ZmpTK3k0QXY2VFY2aSsrclFrZ2JCTUFqRm41T3JUeGlubm9EeUs5a1h6SDFO?=
 =?utf-8?B?UEhXbDRuR3hsK3Zkb2xMeGNjUlBRZktMVjdBVW04TDhTZnZVWjcxOFFIOXM3?=
 =?utf-8?B?cnBWT2RxekFkZFBydjJIYlVvL1czRExkOHFEUzNHT3R0SFJRRkM4TmxHanpN?=
 =?utf-8?B?dTVuZ0N0d3N3MEZySFVWdHpOOTFDYXQ2T3JadXlqRGl0K3R1d0VwTDhGUC8y?=
 =?utf-8?B?cEJ1Mng5dHVkdWs1YjRPeEVNSFJpZHhESXVObU1zZWg1WURtaEZ2Q00zZ1Vh?=
 =?utf-8?B?ZWRJYzk3cDc3dDFYd3VvMWZOU3g4eHhadENuYUdhUzJ5VUNsRmVUS3dSYStX?=
 =?utf-8?B?NjA1U1p0NkpMZzFzcjhrSVQ5SlNnaFlmRUJkekRxMjNOTlliamtzM2ttS3gy?=
 =?utf-8?B?cHNaZlNzb2hqb1Q0SURwVzBTbHZRdlc2c0E4V1RFNFNCWkFNeG00RGtOM29G?=
 =?utf-8?B?eThKYmVKbDFDT1pXbjRIalFnNXVWa2hNY1A0S2tVQUFxMlI5eDJpWk1TMWV6?=
 =?utf-8?B?dTd5ZHlORUkxUE1hQ1BQZjN2V1VpSXZGb0ExZElhbTZaVWJTVW5QNnZmUXB2?=
 =?utf-8?B?aHdMVEczK3FOWWM0UU1SQU9zd0QybDZIYWRWeUlYUWRqdC9SdTc4Z2s0ZGVR?=
 =?utf-8?B?RlFFSTA0bVd5YXJlNGRPV1N4U3NmMmdXbUlDTEpGa3U0NnhaNUdjODhlOWM4?=
 =?utf-8?B?OTl3WlVUN3lMb2ttdEFQK1NPTEUxM0ZZT25NUHBsN0xMUC9SK3Z5Z0ZyN0Vi?=
 =?utf-8?B?QkszRXZ2alpVMTdOd2lYQVM2S2xtZnZLNGlqNXdpZ2RjSStVL2I1Z1ZvMi82?=
 =?utf-8?B?Q3VLTkp5RC9GR2pXNE9QYVhta2NTdERPUEl0VlRreVZabGFwTHdoZFpZcERS?=
 =?utf-8?B?SGlwQjJGbVA2NUExV094cDdLQ1FuT3d4ZU94aXhCcDBpMGVpOC9VZWdqcHEx?=
 =?utf-8?B?WjdHenlEZzBSVk50QjB6TWtNQkRYL1pYMlV5Q0J5RVV2YW1rUGZsZVZmazZE?=
 =?utf-8?Q?R1e7Eq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akU4a1JlUFkzbDlRQUwvVG5DdUw1b1dzdkVLVGtycyt5MW50SEVzL3dMUmxh?=
 =?utf-8?B?Tkt5eVhuc2dHQUZIUlVpRHZCbytZdGZhT2s3M2VtMjBxWEgweVFkeFNaUXF6?=
 =?utf-8?B?VmlUTzE0eEVoK2tUdk5qYVN5dnQ1dmIxbTJTcVA4bW9VazFTMzViN3BHMys1?=
 =?utf-8?B?V0psU0d2TGZ2Yko0RTcwZkRuK0JtdVJUMWR3VGJqb1AvNXBMRGRxbnhuZzBh?=
 =?utf-8?B?cktkb3o3cmIwQWczU2VtallxbVdWSG0yOFdDbFFBdWZCdjVCOXl3QVNNUGNJ?=
 =?utf-8?B?Vm9ybnFLUElNKzI3bnlKc254NWVVQ01xcXhmd2JRd0thcXhnaGlHLzRQYjFh?=
 =?utf-8?B?V1RyeEovaXFsTGxNZWRJaktGLzNUVjZmeUozNW9xUDVIck00TlpqNDBDUGto?=
 =?utf-8?B?TlZDZ0FtWGdUbXp0dlBoNW45dUgrenB1NnBGb1RoTVZHN2xsWGJvNVEzSCs1?=
 =?utf-8?B?WlRQRG5DMjBJYVU5bXp1UXpUTVlkaFFIbjFOWUxDcFJhU1BEUVdSc2Q0eVAv?=
 =?utf-8?B?N1BOQUp3Y3JGRkR4QzY2MTlkZmpvU1M5RzhObzRSUVNHNEREdzRUcENKSm5F?=
 =?utf-8?B?MzQzUW9JYWRFYzgycmw5SzVtMTdPTGJlVGY1VmhxK1k1QkZFejhLKzUzNGRZ?=
 =?utf-8?B?RTdWc1E0c0pBS2svRGY1aWwzdlRhVHoxY2dIdzVPV1RzMTBac1VNTTdNV213?=
 =?utf-8?B?NllPR2VHN3FMdVpyZ20wbE9iM2dEQndYTi8wcHAzWFFuMFM0dkNFd3FLWE5r?=
 =?utf-8?B?WDhnRTlZdVJMUUN5bzFzWEVKUFNjVm1CQ3QwNzIrS3pNUFVLMUN6bklnclYy?=
 =?utf-8?B?N1laV2VVMVhBdHpDM1Y3K0Z4ZllQQUR5THVySTZtQldIZllRL2gveDl5QkE4?=
 =?utf-8?B?QWpjcjUzeFpmN2c5WmZySUEvaS9nVGhTdERLSER5VmFLNWIxWU1HQUMrbHBv?=
 =?utf-8?B?RHlLOFVrczVyZFYxeEZmQUpjd0l4dXduQXVHdUxzR20rR3FwbVFybU9CS1hX?=
 =?utf-8?B?ODhhNWlvOVR4NkZqVHVoYW0zVHZzYmtHSllHRTluQysxanVHRlZxV282bVQr?=
 =?utf-8?B?UWdpTU0rTEJzYkRFNHl1UHErVGppVVkxOC9mUW5SWXA2QURjc281aW5hTjNH?=
 =?utf-8?B?VEtxQW5CdW9iOVpxZ2pROHlPR1QwVjZqcm1kZURkc1J2TU5jT0F5c09qSG1s?=
 =?utf-8?B?VDJJbzVHYmZ0dlFXVzYrY1FiNVhyd3ZVMlZQYnMrOTJNR1MybGlJdm9FazUx?=
 =?utf-8?B?c1dkdzNRYnowc01iSCtkRWlLVWNBVk8rclp6bnpvci84aUQ0MnhGU2xFWUVs?=
 =?utf-8?B?WUxFaE00TVZjMCtpRkRhT2ZNaUJiWk1oekRSemJQZGdOcGhVTlRzbG9jOHc2?=
 =?utf-8?B?RDl3WFplYzJ3ZnJWU0xJS0RzODFiRy9lbXFibmY5TnpFcUdEUDd2SHZvQjBM?=
 =?utf-8?B?SmhEeU1JcTRVUlFUMnV6U0QzOXE1d0c4SW1menRnMHlSZG50d2k5QmQySmdm?=
 =?utf-8?B?bW5tZGJsUWtXRktuTkdLT0ZHYXBuMDl4YjZpTUVLOUQzdHBCTHN0ZCtVOUJ5?=
 =?utf-8?B?NUZwbWZVZ1B5VXlRdkxoeWcrelFkd2c2c3hnZDNiUjhpR21jczNqQmVIbDJ0?=
 =?utf-8?B?U05LSFlicTVxWXMwMFRXMVhMK0ZuWlNUbk5VaXpJdm84ck1QNDZSaVNCR09U?=
 =?utf-8?B?amFGa3ZZOE5iRHFFbSs5VHJtQ2NoKzNxWjl1VWIwQWRmREdaYmNWWUNqMGY4?=
 =?utf-8?B?ZTVWbXFNci9JbWZqMVpzdmU1SnQ2dlAvRlN5ekl6YVNLTWdTR3hsTW95NENm?=
 =?utf-8?B?a0pNaDNJSUNnVkc3TEZjbmgwUGNrSWlJaUh5SUNCMkVUdGhzemFxWE5QeHpP?=
 =?utf-8?B?Vm00QkVLYStpak5GRkh3bDd3NkFONEZLOElXZ213V2VGSm91Q2lQa0ZXbkFK?=
 =?utf-8?B?N1UzcDNxVisxN0krMjc0cGRMU2pNMEo4VlRackVNYjlyTk40OXVUN1NqOXpn?=
 =?utf-8?B?KzEwVFErUXdPZ2pXbjBXR1NxTzlWY0p5Ylp3dW5ieFM4RzByWDBRSklxSElB?=
 =?utf-8?B?SHNHdjNnemUvd1k1YUxPQU5Yb2ZreDJZVkYveEdueGJzMlBwRGJVU0piVTZU?=
 =?utf-8?Q?ss7NwVwEdBdefK+kotHNUZZyV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633fc308-40e5-4c11-5f07-08de3c8a456e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 10:02:50.0404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gBPe1wdBwYEzp7mJbiDUtgjbqoq4tAp8aeptEyDx3ffYsgPPwi8Flz2bQNOz45huYhc89+Gci4PmNTkvLImP9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9294

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgMTUsIDIwMjUg
MTE6MzggUE0NCj4gVG86IEx1a2UgV2FuZyA8emluaXUud2FuZ18xQG54cC5jb20+DQo+IENjOiBh
eGJvZUBrZXJuZWwuZGs7IGxpbnV4LWJsb2NrQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IG1t
Y0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0
cy5saW51eC5kZXYNCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2MiAwLzJdIE9wdGltaXpl
IHNlY3VyZSBlcmFzZSBwZXJmb3JtYW5jZSBmb3INCj4gY2VydGFpbiBLaW5nc3RvbiBlTU1DIGRl
dmljZXMNCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0
YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBX
aGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQNCj4gdGhp
cyBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gT24gTW9uLCAxNSBEZWMgMjAyNSBhdCAxMToxOCwg
PHppbml1LndhbmdfMUBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IEx1a2UgV2FuZyA8
emluaXUud2FuZ18xQG54cC5jb20+DQo+ID4NCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBvcHRpbWl6
ZSBzZWN1cmUgZXJhc2UgcGVyZm9ybWFuY2UgZm9yIGNlcnRhaW4gS2luZ3N0b24NCj4gPiBlTU1D
IGRldmljZXMgKElZMjk2NCBhbmQgSUIyOTMyKSB0aGF0IHRha2UgYSBmaXhlZCB+MiBzZWNvbmRz
IHBlciBzZWN1cmUNCj4gPiBlcmFzZSBvcGVyYXRpb24gcmVnYXJkbGVzcyBvZiBzaXplLg0KPiAN
Cj4gV2VsbCwgdGhhdCBzb3VuZHMgdG8gbWUgbGlrZSB0aGUgZU1NQyBpc24ndCByZWFsbHkgZXJh
c2luZyB0aGUgYmxvY2tzLg0KPiBJIHdvbmRlciBob3cgInNlY3VyZSIgdGhpcyBpcyBpbiBwcmFj
dGljZS4NCg0KQ29tcGFyZWQgdG8gb3RoZXIgZU1NQywgMiBzZWNvbmQgc2VjdXJlIGVyYXNlIHRp
bWUgZm9yIDFHQiBpcyByZWFzb25hYmxlLg0KDQpVc2luZyB0aGUgZGVmYXVsdCAzLjVNQiBzZWN1
cmUgZXJhc2UgY2h1bmssIHRoZSB0b3RhbCB0aW1lIHNwZW50IHNlY3VyZSBlcmFzaW5nIDFHQjoN
ClNhbmRpc2sgU0RJTkJERzQtMzJHLUkgMC44cw0KTWljcm9uIE1URkMzMkdBS0FFRUYtQUlUIDQu
N3MNCkxvbmdzeXMgRkVNRE5OMDMyRy1DOUE1NSAwLjZzDQoNCkluIGZhY3QsIHNlY3VyZSBlcmFz
ZSBkb2VzIG5vdCBndWFyYW50ZWUgdGhhdCBkYXRhIGlzIHBoeXNpY2FsbHkgZXJhc2VkLiBXZSBw
cmV2aW91c2x5IGVuY291bnRlcmVkDQphbiBpc3N1ZSB3aXRoIGxvbmcgc2VjdXJlIHRyaW0gdGlt
ZXMgb24gdGhlIE1URkMzMkdBS0FFRUYtQUlUIGVNTUMsIGFuZCBnb3QgY29uZmlybWF0aW9uDQpm
cm9tIE1pY3JvbjoNCiJTZWN1cmUgRXJhc2UgKDB4ODAwMDAwMDApIGlzIHRyZWF0ZWQgYXMgYSBz
aW1wbGUgRXJhc2UgKDB4MDAwMDAwMDApLCB3aGlsZSBTZWN1cmUNClRyaW0gKDB4ODAwMDAwMDEg
KyAweDgwMDA4MDAwKSBhbmQgVHJpbSAoMHgwMDAwMDAwMSkgYXJlIHRyZWF0ZWQgZGlmZmVyZW50
bHkuIFNvLCBpdCBpcw0KcG9zc2libGUgdGhhdCBTZWN1cmUgVHJpbSByZWFsbHkgaXMgdGhlIGhl
YXZpZXN0IHBvc3NpYmxlIGVyYXNlIG9wZXJhdGlvbiBmb3IgdGhlIEZXIHRvIGV4ZWN1dGUuICIN
Cg0KQW5kIHRoZSBlTU1DIDUuMSBTcGVjOg0KIk5PVEUgU2VjdXJlIEVyYXNlIGlzIGluY2x1ZGVk
IGZvciBiYWNrd2FyZHMgY29tcGF0aWJpbGl0eS4gTmV3IHN5c3RlbSBsZXZlbCBpbXBsZW1lbnRh
dGlvbnMNCihiYXNlZCBvbiB2NC41MSBkZXZpY2VzIGFuZCBiZXlvbmQpIHNob3VsZCB1c2UgRXJh
c2UgY29tYmluZWQgd2l0aCBTYW5pdGl6ZSBpbnN0ZWFkIG9mIHNlY3VyZSBlcmFzZS4iDQoNCj4g
DQo+ID4NCj4gPiBDdXJyZW50bHksIGEgMUdCIHNlY3VyZSBlcmFzZSByZXF1aXJlcyB+MzAwIG9w
ZXJhdGlvbnMgKGxpbWl0ZWQgYnkgbWF4DQo+ID4gZGlzY2FyZCBzaXplKSwgdGFraW5nIH4xMCBt
aW51dGVzLiBXaXRoIHRoZXNlIGNoYW5nZXMsIHRoZSBzYW1lIHNlY3VyZQ0KPiA+IGVyYXNlIGNv
bXBsZXRlcyBpbiBhIHNpbmdsZSBvcGVyYXRpb24sIHJlZHVjaW5nIHRpbWUgdG8ganVzdCAyIHNl
Y29uZHMuDQo+IA0KPiBIbW0sIGlzIHRoZSBwcm9ibGVtIHJlYWxseSB0aGUgc2l6ZSBvciBpcyBp
dCB0aGUgdGltZW91dD8gV2h5IGRvZXMgMzAwDQo+IG9wZXJhdGlvbnMgdG8gZXJhc2UgMUdCIHRh
a2UgfjEwIG1pbnV0ZXM/DQoNCkkgdGhpbmsgdGhlIHByb2JsZW0gaXMgY2F1c2VkIGJ5IHRoZSBm
YWN0IHRoYXQgdGhpcyBLaW5nc3RvbiBlTU1DIHNlY3VyZSBlcmFzZQ0Kc21hbGwgY2h1bmsgbmVl
ZCB+MiBzZWNvbmQuIEluIGNvbnRyYXN0LCBvdGhlciBlTU1DIHNlY3VyZSBlcmFzZSBzbWFsbCBj
aHVuaw0Kb25seSB0YWtlIHRlbnMgb2YgbWlsbGlzZWNvbmRzLg0KDQpBbHNvLCB0aGUgY2FsY3Vs
YXRlZCBtYXggZGlzY2FyZCBpcyB0b28gc21hbGwuIEZvciB0aGUgSS5NWDhNTiBVU0JIQyBjb250
cm9sbGVyLCANCmhvc3QtPm1heF9idXN5X3RpbWVvdXQgaXMgMjY4NG1zLCBhbmQgdGhlIGNhbGN1
bGF0ZWQgbWF4IGRpc2NhcmQgaXMgYWx3YXlzDQpjYXJkLT5wcmVmX2VyYXNlIC0gMSwgd2hpY2gg
aXMgMy41TUIuDQoNCj4gDQo+IENhbiB5b3UgcGxlYXNlIGVsYWJvcmF0ZSB3aGF0IGhhcHBlbnMg
b24gdGhlIG1tYyBob3N0IGRyaXZlciBsZXZlbCBmb3INCj4gZWFjaCBvcGVyYXRpb24uIFdoYXQg
bW1jIGhvc3QgZHJpdmVyL2NvbnRyb2xsZXIgaXMgYmVpbmcgdXNlZD8gRG9lcyBpdA0KPiBzdXBw
b3J0IE1NQ19DQVBfV0FJVF9XSElMRV9CVVNZIG9yIGRvIHdlIGVuZCB1cCBwb2xsaW5nIGZvcg0K
PiBidXN5LWNvbXBsZXRpb24gaW4tYmV0d2VlbiBlYWNoIGNvbW1hbmQ/DQoNClRoaXMgaXNzdWUg
aXMgZm91bmQgb24gSU1YOE1OLUVWSywgdVNESEMgY29udHJvbGxlci4gV2UgZW5kIHVwIHBvbGxp
bmcgZm9yIA0KYnVzeS1jb21wbGV0aW9uIGluLWJldHdlZW4gZWFjaCBjb21tYW5kLg0KDQpJIHBy
aW50IHNvbWUgbG9nIGR1cmluZyBzZWN1cmUgZXJhc2luZzoNCldpdGhvdXQgdGhpcyBwYXRjaA0K
WyAgMTI2Ljc2MDQyOV0gbW1jMjogc3RhcnRpbmcgQ01EMzUgYXJnIDAxMjk0MDAwIGZsYWdzIDAw
MDAwMDk1DQpbICAxMjYuNzY2NTMwXSBtbWMyOiBzdGFydGluZyBDTUQzNiBhcmcgMDEyOTViZmYg
ZmxhZ3MgMDAwMDAwOTUNClsgIDEyNi43NzIyNDZdIG1tYzI6IHN0YXJ0aW5nIENNRDM4IGFyZyA4
MDAwMDAwMCBmbGFncyAwMDAwMDA5NQ0KWyAgMTI2Ljc3Nzk4OF0gbW1jMjogbW1jX3BvbGxfZm9y
X2J1c3kNClsgIDEyOC42MTYyNDVdIG1tYzI6IGVyYXNlIG9wZXJhdGlvbiBjb21wbGV0ZXMNClsg
IDEyOC42Mjg1MTFdIG1tYzI6IHN0YXJ0aW5nIENNRDM1IGFyZyAwMTI5NWMwMCBmbGFncyAwMDAw
MDA5NQ0KWyAgMTI4LjYzNDI5M10gbW1jMjogc3RhcnRpbmcgQ01EMzYgYXJnIDAxMjk3N2ZmIGZs
YWdzIDAwMDAwMDk1DQpbICAxMjguNjQwMDg5XSBtbWMyOiBzdGFydGluZyBDTUQzOCBhcmcgODAw
MDAwMDAgZmxhZ3MgMDAwMDAwOTUNClsgIDEyOC42NDU4MTFdIG1tYzI6IG1tY19wb2xsX2Zvcl9i
dXN5DQpbICAxMzAuNDU2MTg0XSBtbWMyOiBlcmFzZSBvcGVyYXRpb24gY29tcGxldGVzDQpbICAx
MzAuNDY4MzkwXSBtbWMyOiBzdGFydGluZyBDTUQzNSBhcmcgMDEyOTc4MDAgZmxhZ3MgMDAwMDAw
OTUNClsgIDEzMC40NzQxNjBdIG1tYzI6IHN0YXJ0aW5nIENNRDM2IGFyZyAwMTI5OTNmZiBmbGFn
cyAwMDAwMDA5NQ0KWyAgMTMwLjQ3OTkyOF0gbW1jMjogc3RhcnRpbmcgQ01EMzggYXJnIDgwMDAw
MDAwIGZsYWdzIDAwMDAwMDk1DQpbICAxMzAuNDg1Nzk4XSBtbWMyOiBtbWNfcG9sbF9mb3JfYnVz
eQ0KWyAgMTMyLjE5MjMwOV0gbW1jMjogZXJhc2Ugb3BlcmF0aW9uIGNvbXBsZXRlcw0KLi4uDQoN
CkFwcGx5IHRoaXMgcGF0Y2gNClsgIDI5Ni40ODA4MThdIG1tYzI6IHN0YXJ0aW5nIENNRDM1IGFy
ZyAwMTI5NDAwMCBmbGFncyAwMDAwMDA5NQ0KWyAgMjk2LjQ4NzIxOV0gbW1jMjogc3RhcnRpbmcg
Q01EMzYgYXJnIDAxNDkzZmZmIGZsYWdzIDAwMDAwMDk1DQpbICAyOTYuNDkyOTk1XSBtbWMyOiBz
dGFydGluZyBDTUQzOCBhcmcgODAwMDAwMDAgZmxhZ3MgMDAwMDAwOTUNClsgIDI5Ni40OTg5OTld
IG1tYzI6IG1tY19wb2xsX2Zvcl9idXN5DQpbICAyOTguNzEyODY1XSBtbWMyOiBlcmFzZSBvcGVy
YXRpb24gY29tcGxldGVzDQoNClJlZ2FyZHMsDQpMdWtlDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4g
VWZmZQ0KPiANCj4gPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gLSBSZWJhc2Vk
IG9uIHY2LjE5LXJjMSBhcyByZXF1ZXN0ZWQNCj4gPiAtIENvdmVyIGxldHRlcjogdGVybWlub2xv
Z3kgZml4IChjb21tYW5kIC0+IG9wZXJhdGlvbikNCj4gPiAtLS0NCj4gPg0KPiA+IEx1a2UgV2Fu
ZyAoMik6DQo+ID4gICBibG9jazogZGVjb3VwbGUgc2VjdXJlIGVyYXNlIHNpemUgbGltaXQgZnJv
bSBkaXNjYXJkIHNpemUgbGltaXQNCj4gPiAgIG1tYzogYWRkIHF1aXJrIHRvIG9wdGltaXplIGNl
cnRhaW4gS2luZ3N0b24gZU1NQyBzZWN1cmUgZXJhc2UvdHJpbQ0KPiA+ICAgICBwZXJmb3JtYW5j
ZQ0KPiA+DQo+ID4gIGJsb2NrL2Jsay1tZXJnZS5jICAgICAgICAgfCA5ICsrKysrKystLQ0KPiA+
ICBibG9jay9ibGsuaCAgICAgICAgICAgICAgIHwgNiArKysrKy0NCj4gPiAgZHJpdmVycy9tbWMv
Y29yZS9jYXJkLmggICB8IDUgKysrKysNCj4gPiAgZHJpdmVycy9tbWMvY29yZS9xdWV1ZS5jICB8
IDkgKysrKysrKy0tDQo+ID4gIGRyaXZlcnMvbW1jL2NvcmUvcXVpcmtzLmggfCA5ICsrKysrKysr
Kw0KPiA+ICBpbmNsdWRlL2xpbnV4L21tYy9jYXJkLmggIHwgMSArDQo+ID4gIDYgZmlsZXMgY2hh
bmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IC0tDQo+ID4g
Mi4zNC4xDQo+ID4NCg==
