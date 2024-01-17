Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE97CC13D
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 08:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478784; cv=fail; b=b35mZL36xd2evvTOIRMLyENel1B9+u86QKDh9hifgSPIeQ/zjmuStnaS86F+zI/SZ5bjZH96awO2bFlNEvkPjNg0ydYEc54j9Uw9R6acXSr8EE5lusO17WNona+rXQx51fDH9xhYaTRl+R69Dd+k/f3iLMv9TaZ7Re4E5lNM+M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478784; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:user-agent:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 wdcipoutbound:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=DhzIF28jN7yGDMjiTmnddzTaqlUBgDfxH50OHPPquHHvf5jjmpJBDLvUAEjyvD/lcbu/8mOy/5OEsSMAY2kZyBkJPg1oF4uSzf8G1KOMX2xLOqvaJFwbLPhZqmN7Kxalj1AE5CQliCgYzeWV3hxqoh2frDaGvmd/4ssfXLIlUv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZEqvg9Dq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GLyhWblF; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZEqvg9Dq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GLyhWblF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705478782; x=1737014782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=ZEqvg9DqPr51RU/WS4+W4S0TE45DALsVQRlnQVEouEpqSTPkuKbU5uP7
   OK2phTg+Ue2PLxodQG6v0GFtqufQeq5U6ddAjkN5HRc/Zn1g87/972jhD
   DvkjlZraRAUeod8ZpH3AKFSIxQxVwDDppXajvRViO3DhNwCiLv6/YgBPr
   LKD0tfDQ7zASsUWmkbRDM8nC9+qLGuFjEsTlKdWwIHJJ6Kdrq5iDTEqK4
   RjKAMjb1tF2s1qLh1n1D/0sSvvtEUADaU7/b0AFKEHBIdsnTbXh9mGd6h
   NRAFN+FTTKwCWbDsOcwBYX6tFGokw6wBgk1dRQhHD4K80fBuXe/72EnWu
   A==;
X-CSE-ConnectionGUID: RPR/IFRcTP2BDxFnv93mWQ==
X-CSE-MsgGUID: zsYP0dGwTx6zfCki7ALQKA==
X-IronPort-AV: E=Sophos;i="6.05,200,1701100800"; 
   d="scan'208";a="7288779"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2024 16:06:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxuIj9M+c/tCW/njWWgBBxp/ad6Pa63H0ZSci8BOO1bAbB2w3neUI5eDkwyMzQnzb/sgor0M6pUhWr6CekPLygpjsbCqbfK12NSoBh/J+Q6hsQTE1L4xQ6x02lJkJhoMghMGcsIoupu7WiBt2hemtkDk8qImiJ5fNwdXMYAm9TQrD6kQGX2L4+T42Dgvw+2IrRzhvgbTvS593XjZM+6YYy8egAfpF3WIsRCxIgS47qOnhVMTUmiJoJ/tkFrlcPXH1eTyvF0KO5B1b3izuw7OJglESl9M7Ms/K7FfuqmMQvqQ0VDrh3efN89LZa3lIwt5OqDa5G/RdpkGxJ8/yrLVAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=jTBgiBdE07TU7mEV5w7l4IBAn+klcyBjGsRHDkC457pFfn5IY3B/gWu8uC9wOY3X8xhjh4CkIUkk/IQiBmYye6ucoAyN7umui2vUKy+cb/pAF7cRjLe0oqJlYeVprlFRyrr8Mv2Vx/LfXsCZB1+H87y2KM8PhSF7f0Nax6w57QmAjbVRGVIlfmMK3sIu5oadM2vuYepCGaYtdF/9/76deKNc4u3XQnMZkoRsMBQRl59M3bBUIhb2GbM7931GeSaewn4VdQl5FhXz00ZiruvmF9e3DT1XYHpjAu6EbrBwvfisu+8qRb9zFRlQL62KW5p8IBAZ8CN33Y0x2X21WCtwPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=GLyhWblF+MPomLkLUf0F1FDed0iYph7+y3pd7JZSaoR4sybuBwSemepq1tttN0jbg/PLBvOhKNihXe9Yi2fgmZsCLMqnaj8RhzJ/7QSVfEPaQ02CfplYUHbp4y/YNnrXknlIc/NMbBgPu96bdES/qlHAXJ3omPXez5qQkqF6+F4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7178.namprd04.prod.outlook.com (2603:10b6:806:e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 08:06:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::317:8642:7264:95df]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::317:8642:7264:95df%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 08:06:19 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "joshi.k@samsung.com"
	<joshi.k@samsung.com>
Subject: Re: [PATCH 3/5] block: update cached timestamp post
 schedule/preemption
Thread-Topic: [PATCH 3/5] block: update cached timestamp post
 schedule/preemption
Thread-Index: AQHaSJ1JtYRA+36e9kiUm/7fS+IJiLDdpt4A
Date: Wed, 17 Jan 2024 08:06:18 +0000
Message-ID: <32fecc61-0e4e-4926-9973-1549f0e06ab3@wdc.com>
References: <20240116165814.236767-1-axboe@kernel.dk>
 <20240116165814.236767-4-axboe@kernel.dk>
In-Reply-To: <20240116165814.236767-4-axboe@kernel.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7178:EE_
x-ms-office365-filtering-correlation-id: 9e865367-e004-49c3-8e49-08dc17332fad
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LyBNCagslWF6ACbLKi5R8u0GuHeZ4w/DLlr0ixErhCMbWbDPXIamjEoFQ8/3/EqjZ8Ad/SDnBC/HTiSVa4w6b9QdLVcXiSj5GOOSKB3Hv7n2m7+pGCTMxCi6PVVgK3N+0Gt+J1HO82xNL3I1XIAlRuk1zF0GiJsMc9UKnA6k30RgfwLHwW2pylHWua7xNTR6f//3j105hYW68tZ7KdylDVe0gd1RilWGXiUm4i9kwTAV/eZdHdcObBJIknQ8Wpq2adgakjy5GrEItSycyY3kCzwl0jGanou85WQD4SkTrEecu7CTiQ5tGupLVbXxXrxBgETFUGiJQtR0HmS6gc9wWZ4PK/Vof0MKp6RiAoWTpbqOa+wUQlrHNl/zCXTYJDJBn4Z1jDTL7G+yE+CTAwoPIRkQX99lVPIpLoCJBwn0NNO0DnwwGJpvFWE2J414WY8kFCkfGAs4u/iQq/jFLBN60lW863Lc8R6Bo3OwbnWdqmMFDK5SWObo7mhEs6BP+/rVrRl1wK6WMS+310l6VebpPaGe/eHDLqltR6FB7Hh/Yj8uN4MfEg+m//q4Pq12OHPICYr6ypPrcv/G+JTRUQspbl8E7GFLIsLsca9kL5GpXWo0ZG/daP0rfAxQ5A92R3STb83sFU38OV4Dzu6eCJLoclvQuoDof9nD9eeXOSvDVN/qIt03EX9FU8UEzdVuryvq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(8676002)(4326008)(5660300002)(66556008)(66476007)(66446008)(8936002)(54906003)(316002)(19618925003)(2906002)(71200400001)(26005)(2616005)(4270600006)(558084003)(36756003)(86362001)(31696002)(66946007)(64756008)(110136005)(91956017)(76116006)(6486002)(82960400001)(31686004)(6512007)(6506007)(478600001)(41300700001)(38100700002)(122000001)(38070700009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2FUREZQY0VhTmVyd0RHdVpzeXl0SFZQVk9wcHczT1hiWmJ5TkdhT3BHYjhI?=
 =?utf-8?B?RlVtUnRCOWp5OU95Y1dTbFFHVmp1ZWtHcTVwV3VYN1RabTJXOEpCWnVOL3dV?=
 =?utf-8?B?YmZZU2JtSldNeVp1c3FqZGh5QTVPS21FeUdtRis4VnUvL1NaclJkV2tLbE9Q?=
 =?utf-8?B?dWR6M25vc2NpeUNJYmZ2ZFJBV1gzb1RmbjE5aGxhQzF4aUo1cU5TajdSM3U0?=
 =?utf-8?B?NEVaRURiWTdlVUhDWkE1ZzFnUzIrUC96TzRBNzdMR3ZpaDRwa3o1Z2lLbXFi?=
 =?utf-8?B?b0lWZDVvblVIa2didTVlSGlOWURRb2thalA2T2NYMXpoVEh1QVdVTW1kZXdQ?=
 =?utf-8?B?emNSMFVVS0FwQ3Z0alFFOHI1c29XMm9DWFlaeUc0d3VINGtpQi9oWDY2aEVi?=
 =?utf-8?B?ZFBNSTd6RmtMMEdCaUpkdlVUODI4d2FmUUx6QW9NVnhXalRWWTBWU1lMb1kr?=
 =?utf-8?B?T3NRWGxKV0duMVVMTnExL2xIQ291U2VlVHgwNWVyMFp3WEVMOE9FRVdoN09n?=
 =?utf-8?B?dmw4VkIzSFYzR2NXS1FuT2NYd0sySmFEL0NlNU1DbXFhemlTdjAyOXNKdUxG?=
 =?utf-8?B?eENKMW5LRU5UVTN0YlRlY1hnOTdWeS9nUWhhUkUyQVljdGtOenVlcndOYTdq?=
 =?utf-8?B?V0FiSks1Mmt2UWhmZWdGUTA4S3N6a0F4TXQwbk4rVThaVkJUY2o1aGxuNXU0?=
 =?utf-8?B?QVZmWDJaWHArVStSSDFCZDRlRmV3L1VUQy9EQUJnU0EzMm5mWTdYaEdPb0Fv?=
 =?utf-8?B?UEZBWHMyVHFNbVVNT0RSdGQ2MzZ0U1RaNzVmTUhYNjNqZXY5N0xNbnhkdW8v?=
 =?utf-8?B?RnNkQmV6TFpzSnZ6L1VyWGRLOSttK3MvalJ4aDdlTUVDUFFHTDZSVFREQys1?=
 =?utf-8?B?SG9NbDIrOUpESHdyZm1wenZtWjFneGFJY3ZtbUVVV3BBM080enZZcVVNam9v?=
 =?utf-8?B?Tjl2eEVaVERaQkRIVHEwM01mY0FpNzFBazB2NmZZK1Q3UXpaNkhYY1R2S3kv?=
 =?utf-8?B?eUJzaGM3STBHM241YnoxTTZNYWp0cXFpZ0k0RjRVeU90Q0svazFrUEpUVWJD?=
 =?utf-8?B?VmJENmVrUTRQR2pvTWVsdlJRN0FTbVNGMkVqMER5YWR6UXRtY2o4NGRaYk1t?=
 =?utf-8?B?NGJTaEVjUzQ2L282Yjd5TjJkK1lxYmVLZ2U1OFFGYk5yU2pOanZHUkQ5TU9l?=
 =?utf-8?B?RVNJWXZEQ2xjVjBZdEhmemZaaktUUThibFBBL0Jzb25VODNRbmxsOG8yMkZi?=
 =?utf-8?B?NEc4ZFpmWGx4b3VSbEx0M1hzMVdYTXR0cWs1YmNZeEN1Q0NUb21kRWx6ZDEz?=
 =?utf-8?B?MDVDbjlONWM2UVZWbEc1WXcrOGFodFF4dERRdGVUL2pqcUoxVnl4K3dtMnJh?=
 =?utf-8?B?R2tBemtHOWUyelVWS3h6dGFTSWJNWEt3ME1qMU51bWZYcWV0RDMrRGtVQUxF?=
 =?utf-8?B?L2d6dElqckhhci8xK2VXUlA5MUdaQkhpajFCZ3VocU9PMVY1d0JCcnpsZmlT?=
 =?utf-8?B?RFZlOWNxZ2VMekw4ek9uSDh6TFZwbGgvWG1PRHh5bEd4MVBDUHBDRXBtSEFx?=
 =?utf-8?B?SHBlMVJsYzUzYWE0TVc4U0hnSFB4NllIaTVRb04yMkN0YVB6anU1QXhXWnJT?=
 =?utf-8?B?dzk2L2FjaXNZTlRLcGczWTJyYzhZeDhxdDQwcFJud1kwUlNhUW5WanRuM1Ny?=
 =?utf-8?B?eEk4d2d6b0dlUEhyYjZBN2FkVk1pUmF0cE5weWV0bmc5S3ZodEFnamc4alNu?=
 =?utf-8?B?SEVjRjgrSld5YTZvMXFFVDdOODUvQXlMclF2T2ZUTkRjdUNvMEVDbmVadCtY?=
 =?utf-8?B?V3VTOEVORVFBOXNjTU9KYWdJWEhrWVhCM3JVbjVSMzhRWmdFMVY4M0Fpd3FX?=
 =?utf-8?B?T2ZNTFliRlJNdDFXR2ZjcERLTFlId05OeWZIdk9rZUNON3F4N21xZDdUM0Zu?=
 =?utf-8?B?dkRNSDQwV295VjBpaU9HWmR6dHBsYjFXeVRBWjA2VW1uTGtGUkNjUHNQcWl3?=
 =?utf-8?B?cHpiVUpxTXNYZnpGTSs4dzIzR1BpNTlQeTBib0F2Z3RYRkpLcEJNZ21pb0p2?=
 =?utf-8?B?YnpmZjBCKzlxYmYrQnRKUHF3S1czR0o2akhlT3U3bjlZZGVKaGpXOXI0eDkw?=
 =?utf-8?B?OWJLT0tlOTJ6YjBWMzBDTHgwZ1BtU2JPWk4yckxMZGdCUFp5VlVYYWVEZFdx?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <080B476AD5CB5D409D6459AB6D715B6B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s55v6btCXxMZ1Nv96F8/lONf+LGL9ZyMwhDQaWWM9XYT1Hpl+wxhsoLH6BzWjI5AjmFqkrC5tSH4Xeq3UsmNSSlMZppLH3nKKGrR0DGa79F8M8+kcQl2wp3wDSOAbdron0tnz9Eaagy5mOWxH6oaSKezUs55XTElWxZ4MZ55eh5WeSX6Xp69+ddnsAAoc5Q8J/c1s1j9ziT+FS3OFJdmOyrfeGOafCukDxumoFzYz+uNFybMh6RdUcXiaU5uDjvY1+NiFbxL0f+kMlAUmvweuagODvbMhgUOhhdzwzBAto/q8+B4bU/3pfCiNY20ljmoy1ItiRo4Zsoa4wy7OG8ZYBmZ+saMQ1fquQAnBMgAm3YMgeodAnzJjgFxQcfqS5u7aLdPiUcKPQatf5k8l+ZJXvWXCeS4/z/AV4hooO6V764G9S4Apflsdbg0WH4V7Pg3OKkSsW1JNaN60FmuOLm2gbeQoexTKMhHdrvTIleZY9krwe53P55HZo+vsAXryEoqyJyjvNQajChVPUJirjP6w9ni2GQePGpsFQnrFSSI472BW8o7sdQYKRhtFsmw3q40pkOC24uAzOrUsJgjaAsQ0kPdCJq/PFbRTY+MAlahlqUoUQe0WFXcJOeg5+qbohRW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e865367-e004-49c3-8e49-08dc17332fad
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 08:06:18.9974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4W2cEfOe+DOJiD1b+xERVVUQvee18TUd3xpb47wlkHHbklq1CrDrLutjUOIjKpsi5QK+7zZaWh2tAu9v4TlSQ1O7DQDOqpcpMRO2zDNZubM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7178

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
