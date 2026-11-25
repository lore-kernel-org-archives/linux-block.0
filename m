Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795647687;
	b=PJ+vr1WworpTJRPO7JyEFYetaVOU9uOF1X7qIBMSvd7jRy2mnYME/xU83CSPRfEtc2u3
	 m1n5FwlwQ8vlKNOAvOBQJ9mlkkUuLSf4dv9b4j/XPrq0qnq4oY1l6abbz7nnvmQ2JyccJ
	 AP4QaxZUp36N9a4sVaB0OKv0amC2qbCVZS4Vc93pyEPbhzdQjK3+AaEOj0YI4eHVXNFy4
	 nmIQKfvUvw0KzH9+SDr47LXLyugvTX27r9jrMT44EVrSRvAjDFmJu43mT80CnLuHawNxQ
	 zi9VEPGOCq0v2pwdTI2PZ8oVxdpuc7IJUPSvZW+qrPNeMvYL8mU6NVXlNL+A90s/fGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647687;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=nYbeGIkx9Hd9PEe81riOCNEl7eGQWN+3fkHa0xuGgOI=;
	b=YIKnvpWz/D2VkPg9sVwZmaj6Rt2usAiMxmkzW2XaCi0nZItlPoz3Rs6DShrtd+m2NMar
	 oS1lpZNf0C5ZxUnWHSvE3XZhCBK7d61Vso5Aw2HNBICXEVpbR93QyqMy4xJaOlsADl5PT
	 /TQKhepe/uJWgrNpuGKoRMGduWbxo5M+jH0I+Z9HeFPgZkVlBd14etFkId3898PsOfntn
	 iMgSVpJsDhvI9ubnlFDrDowkA7a4pmnM1Ecw3DJtZZa2KjnJWXC1MPw7sx+9BvX2ZLj+S
	 iEPFcIoPT7bUuEwyxe/+ChOBYrlCIqB2lHKT6+JKK2pytL37fDrKI17P/oja2yG3fAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=T0QgFaga;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.59
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013059.outbound.protection.outlook.com [40.93.201.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97C1606A334
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 23:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A97C1606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=T0QgFaga
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hp10L2bdz3vhmEH/6iUIOJzrnlZIMZ3lq2y8/LzKiciENpm7Zdf8NesWxKHBh+7bo4NTY+5U8WiqOLGRn5Fs5sIi3DB4aisKpC3SsIUkgFm1qp/U6GPVEfvp9AOqWqsaenPBJr9+PjJ5rTN6uTycsH38hkrTKp8w0e4PhQxlopPlus6guZ5TwmY1fAhs8sJgKMUI08brEK2SpEAGULuXZt05ID7wXs2iWAHxR14R3hRyYIQXxDd4zyXtpSWaQXikcdL9dEg6kVWeG8PGeEygIVuOGK/hU2WwtG059BXWjO0Zw+qDmgF3oKTNB06J1RGzk/5C+GPmlRF/gmYyQWAI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYbeGIkx9Hd9PEe81riOCNEl7eGQWN+3fkHa0xuGgOI=;
 b=HGkLat1FZ/+l62Atzz+z0mZ3/MqWs92jmCIJsuvBMpe6APl9cQ55nfTYNjOAMw1k55mxYS3wDcIYNuR81m4TzzYkm5DDQqL2+9vzLdhEWHSVUNXRD7N1YR4EFXIyideMv+kz3fBY8i0so4fTeIOeLsDld1MDf8rcbBxBgY0986izIyA0g5YVjn3nslaHLb3Ws3+fKTUAOkslpfvpAA8BGvENjH1crdJdku1v0d35Nvg0AdyXpQzVchuQxvLA/miKACiex4aU5Dw4QzSN5dfickQeq0bOJzAU1WWoGUye3EnAtjMe0HIEbgKecvgBU6ZvRC+sJAv3J2SnK0Jr7pMgpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYbeGIkx9Hd9PEe81riOCNEl7eGQWN+3fkHa0xuGgOI=;
 b=T0QgFaga4MhPtoTamp8APEPFqMI0VKY6grrw5F6HHNM7LmcPvhd+Uy/dCyi5686zINiwx1QrZNOiGlwQOlSgl9CRsUfMxHrxUc+EFcVbPD/8NeMZaFepSjeYDB77UBZU+0riCsZvjEjoHCGOfReHa29xbmPHx4/YdcOpOOjkctBJtRYG/jwf7nrsApl7+2aTmW6mkcg40DM3cxbyizIMKg37KIUChVCI+cgFx6gM6DHW8rOnCtlbE8lD2zspfMi1f1z7VGjvikbrRvsMydfSspQESX6jhldB61DdUiI+sMHYDy1DvVUpJopRm+dISAbz4CJC33sfX9zCSJTQMftraQ==
Received: from MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 by CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 23:00:03 +0000
Received: from MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee]) by MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 23:00:03 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: Christoph Hellwig <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Hannes
 Reinecke <hare@suse.de>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 3/5] blktrace: record I/O priorities if requested
Thread-Topic: [PATCH 3/5] blktrace: record I/O priorities if requested
Thread-Index: AQHdfBjQSDzfIyJpdEe5qKTLzIwvYrc/aTeA
Date: Wed, 25 Nov 2026 23:00:03 +0000
Message-ID: <fd0d063d-ca8e-442a-9a18-50206ebdc5a2@nvidia.com>
References: <20261124133553.152463-1-johannes.thumshirn@wdc.com>
 <20261124133553.152463-4-johannes.thumshirn@wdc.com>
In-Reply-To: <20261124133553.152463-4-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4159:EE_|CH3PR12MB7644:EE_
x-ms-office365-filtering-correlation-id: d13f8f1b-b8b9-43dc-764e-08df4b47d718
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|4143699003|18002099003|22082099003|10067099003|11063799006|56012099006|261022105027099003|261026140227099003|261028144727099003|38070700021;
x-microsoft-antispam-message-info:
 QuHUjNu+2JSclISt4nx3BCe4DOGGGODb47HPcMO5vc66Zk2pdwrAvKk/Rnw1lDJwk6h/+BZpqUwgrSWVV4tXGureIF+NwRDcrMcrWHe1AN7JPAGEIEMmQ7Gh+9ekfeVi+7wE6urRuFcxP5LR0eMbMkFuErxe+qF/pEg+gH1ztf32CZS+zRxPcYIVCy7yugONBp4q/I7o5T+X3ZXGrhiz/p6xYDMOw4yq3HYeqVsepQdvuYW7i02ivcn+pPFERZMUXvb1dqGgHnH56xWbe5uYKbs4u45ZczQvJbZ+XW9Gt/1pt3acBjH1Uvrk8O+pIW7VXruQg9CGyYIUu95YmXthgAP4tFe0FGtLPfIqieih28VK7IBAHfnHMkXUQzCGyqExdcjh4SN5z1icl2stTsQRvBP/vFPG+k8XGjpkfyQbxivf+4KOv1XrsAYqwUXluQCixes5kQja8mHUl4rPp2O9jrqjBgpkqBVaUVffggHD1g0W6VlpGn587hJSTUNZeNMgzFp11/ZZ7Itag4tESlqYZPnunJ6oDAn07257+RK7oKpgvdhQr1B/OUNvWv48WBxXjUWPgBINIENIp+xWjqlFCuk2IljhAn5/xGOPM/zRCd6TX/DMBGWqcCSdy83DCBhcxbaIKBxxgIjI2GQOIL7G+FikNl3fK6DGdBE3jaS2PFH5jkBHODVZJ1gZPi3ZIi74jF2Xc8TJ6xYBqZKrzsHwd0s20SuGrGyLBoO17CDrCcQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4159.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tk0wQ3pVcEpzeUFRU0UxSEh5MUcrWVpCUyt5eER0cU5CaTZXMjVJVlJGZVZz?=
 =?utf-8?B?cHVYQkNkd0djSjl0QUNGcytNYUVMVGUwTDVQbmlON0diYUJIOUx5K2J5bUVB?=
 =?utf-8?B?RE9IRnppeGZoeVNrNHNyK3BFZE1tMHhUK3N6SWszNkg5bFYrTlVld1lmVmpn?=
 =?utf-8?B?N0lZT2R2YWlrT2JsekhuSXpKRXNQOVBpOGxQbU15WjZJeWFlOU9ueWJ3NVRK?=
 =?utf-8?B?SG9naW5CQS9YblN4MmtVQWI0ZVVGdnMyalJ4dmV6bk9WeXp6NWR1b09yZDRW?=
 =?utf-8?B?QzdNbCt2YjVXRnBRenJRcHBnUHZlamNETWJ4QitXVXdLdStIcTlTeWxaYTcz?=
 =?utf-8?B?bEtEVnBDWHJGSXMvSWV4aUVMOUgzcVE1cGQ1V0JaQjhRbzN6dGVGeVlaeFRh?=
 =?utf-8?B?Tk85ZHEvQzdsOCtMVEE3R0dJMGluRUVDRlIrMHZJd0VPQ3p5SUtSRDNZK25Q?=
 =?utf-8?B?ZHZEMUhxWkh0bTRNZEhEWGs2eU9RWXJvenhwTFVObjlESUl0YjlEL0FsK2VE?=
 =?utf-8?B?eUphQStaRTQvdnd2Vyt6N29nelNZREVtSFB5d2ZzUnB4b2o5REU2d3VJMnYy?=
 =?utf-8?B?YWYwSy9yczNmTUJOeGlZbGR1THkyUmJPTTRSZ2d4QmlhSkZIcUFHUW11d2lw?=
 =?utf-8?B?NXEyTUJiWVlQbnl1Q01UUCtudzBWMWVlYXI3dzNyRkhkOGl0UGpKN0dVYUo0?=
 =?utf-8?B?NnZBSnBqemJ0RVZlbTl3R3cwL0ZZQXNZejJlZXlrbmo4WGpWSEpJbXRORUpi?=
 =?utf-8?B?bVpRYy9zSGRLZHRtZ3RYNEYwalZBZ1QxdUZEamRwSFpqL24zSEhORXRLVmZs?=
 =?utf-8?B?MTUySitNRjVuN1JqbE1VMFcwNlpaVVlPR0ZMemRVVWxxVVo1ZlJqeVhHY05y?=
 =?utf-8?B?cXllUElUeTMvdUNBcURLeU5LUVNvRlh0MWg5VDMyZDFndTJOTE81SVN5NWRJ?=
 =?utf-8?B?b1RLMzdrbXViaDkvK2xxMTZWdzdGYzJNaWRmcGFlUmtuWjB5aFFGcmhRbldU?=
 =?utf-8?B?bUY0ZCtSM3daYnZ3bWo1Z3BBN3cvV0JPY3c5enltVVo5dnp4Y1EyMmJ3bFNr?=
 =?utf-8?B?dmNoQnNEUWI2QnMyNnBVRXlCc0VDRTNLZDBwN3RaQlloWE95NzdpNjdXQmQr?=
 =?utf-8?B?Nlp1SitQZ1QwMlVOblltV0xtaWFtWWJDWVB3aWpES3hJWVZtclpTV25ycXpB?=
 =?utf-8?B?ampmNlpRbmM3NVpiN2NaYnZ3ZjY4UU9aQ2p4S2tIWGhjYURjcVFESkRTUlZ5?=
 =?utf-8?B?REx0VmpqUkQxYXhGb2JnNTkraVRUeWpPOXA3dklsN3BnNjVxTVhRQ1RoWkp6?=
 =?utf-8?B?TU1GMTBoUW0zYm9kT1ZFTGkwOXdORjRQQmRZc2x3c24vOHY2M2VxeTRTYUpu?=
 =?utf-8?B?WngrTGJvd2p1T1Qwc1gwUlF4SmFxVWhtdkRma21CL1Jtdnc1QlZrWG5ONllv?=
 =?utf-8?B?TCticW9pS05nemFGMnQxaWlSc0RHM3hxc2dQdGVYd3lFWFBxSy9INnlwY291?=
 =?utf-8?B?bGlaNDl2MWJDaTZNaDZPOVg3K1lUQ1FJb0dvYkhLbVRNaVd6cDNPbXRBVVVF?=
 =?utf-8?B?TVc0SmF2NkpZNmwyak13WGEySUJXTXo1N0lMK3pCMGE0Sy9rQ2ZPSEl2OXg4?=
 =?utf-8?B?UmFabGFFN0NudDlMUlgvT3NtK3BMQVhpNmVNd1RxWXNRakRvVnRFSnJWLzRn?=
 =?utf-8?B?a3ZVVTdHNWtQQ0Z2QkNPU2h6N3B4TS9EalhLdW5GYnFqaEJDa1BCbjhzRDRT?=
 =?utf-8?B?R3V0Y08rM2xwaEo1bUNKK2VXYW9YSm5aMGRhVUJtTmpIU0RLcy91c3BQNk5B?=
 =?utf-8?B?Qy9Bck5CS1A5WEZ1TXdJbjRhS0NRbWo1Uk5tQkFwWDZoRlJYbHRVT3JXblYr?=
 =?utf-8?B?ZGROQ1RVU3RRaUhUYnZDZkFucm9qNjdFSDl1WTk4d1JkMzQ1RUpDMlFxd2ls?=
 =?utf-8?B?MS9oMXFES2RqZVI5R1RwYmZrTENDZTU1NEQ1TTBYYVdjdFlGMnY2NmZ6WW8x?=
 =?utf-8?B?ODlSU3h1cmF2UGo0ZWZQMVNsY3E5K3pqalRzbVJYN2djbzdMQXZKSlJXSEdU?=
 =?utf-8?B?T29XSHpVcXhNVXhPSmNDa09idXdvZnM3N2I4ZXpLNTU1RFlnMmhOa1d0VTgr?=
 =?utf-8?B?NHAydjJKU011MHkzVVBaRS8vdkRkTkY5eTBaQXdaV0Iza1pkNlZyVlZYT2wz?=
 =?utf-8?B?TjAxVkhLMzVVZWJocUV4NWRYMXlUZU1vSzdpbVdCeGgxdS9HNlBMbTUxZW1D?=
 =?utf-8?B?dVg1NEl4dUtFa1FOSTd6TlVwdjhaOEdzcHpqYlk0RzE0WE91R0o3cC9HVCtM?=
 =?utf-8?B?VkpNYy9XTU0wSG5WUXA4YmRRTlN1T0pzeHdGZjhYRm1nTFpwd0NtZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E7319075BC8C146A1D4B9E1D42928F2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4159.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13f8f1b-b8b9-43dc-764e-08df4b47d718
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 23:00:03.3312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hOrtn2o5oAsBaGvUnliB9v+ETsk8wysYwiNExgKJnX/xDQbwOaZ7fGTxDuEfsMchqdJ2s7ovegpTkyNVqSfErQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644

T24gMTEvMjQvMjYgNTozNSBBTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBBY2NlcHQg
QkxLVFJBQ0VfRkxBR19JT1BSSU8gaW4gQkxLVFJBQ0VTRVRVUDIgYW5kLCBpZiBpdCBpcyBzZXQs
IG1hcmsgYWxsDQo+IGV2ZW50cyB0aGF0IGJlbG9uZyB0byBhIGJpbyBvciByZXF1ZXN0IHdpdGgg
X19CTEtfVEFfSU9QUklPLCBzbyB1c2VyIHNwYWNlDQo+IGtub3dzIHRoYXQgYmxrX2lvX3RyYWNl
Mjo6aW9wcmlvIGlzIHZhbGlkLiBPbGQga2VybmVscyByZWplY3QgdGhlIGZsYWcNCj4gd2l0aCAt
RUlOVkFMLCBzbyB1c2VyIHNwYWNlIGNhbiBkZXRlY3QgdGhlIHN1cHBvcnQuIEJMS1RSQUNFU0VU
VVAgKHYxKQ0KPiBoYXMgbm8gZmxhZ3MgYW5kIHRoZXJlZm9yZSBuZXZlciBnZXRzIEkvTyBwcmlv
cml0aWVzLg0KPg0KPiBGb3IgdGhlIGZ0cmFjZSBibGsgdHJhY2VyIHRoZSBUUkFDRV9CTEtfT1BU
X0lPUFJJTyBmbGFnIGlzIGNoZWNrZWQNCj4gaW5zdGVhZCwgdGhlIGNvcnJlc3BvbmRpbmcgdHJh
Y2VyIG9wdGlvbiBpcyBhZGRlZCB0b2dldGhlciB3aXRoIHRoZQ0KPiBkZWNvZGluZyBvZiB0aGUg
SS9PIHByaW9yaXR5IGluIHRoZSBuZXh0IHBhdGNoLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2hh
bm5lcyBUaHVtc2hpcm48am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoNCkxvb2tzIGdvb2Qu
DQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQoN
Cg==
