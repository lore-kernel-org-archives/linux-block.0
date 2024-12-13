Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE5818BC3D
	for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 07:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734074829; cv=fail; b=CCmX40R4v6la98Jc9DJVTKJwLcv48YW61FyNUXV20FX+AlQU3tqdwZH6R2/5+66zjlfErNLuMLsTzMEoJLuAAndDyXuKgVxY3nO1WF+cyJbvrEPFv9Cp/h0fHb+c3SdMQ09ADrLC1G35bdy777Srom4CPx5GXzZ/2CokQgXg5zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734074829; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mNIqNi1leJOJ2GN+QvXVkD8ssMbjZNRxYPvy+ChKEulG42bTtE7stLnlhGHwkM0NSHQ2F9yy8lVYTZCpu+x9nwYisD1vPFAbwMf+vFRdMbJUiptDbB0pUS2ib+cjqseoCh61o7whnr7Nyagy60aPYVIpjrnzSD2EWIr9O0XRvOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UTUzzpBE; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=OtxDbuNW; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UTUzzpBE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OtxDbuNW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734074827; x=1765610827;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=UTUzzpBEO77xP6hdilo1b+rZOzjRwinstntk+KmjZSty8WPlTdEtu+JQ
   OFtVAjO00XgO1ilrKFQwVDjTnCzgpJpAXL7JDV831ubWb8RLJPGrxzsD9
   4EAhRbMZ11w9zahl+nNhDLssHwJwhsXjzjFrqGkzanQUe9Jey4ZU4uFdB
   nFTIxoSJhV33W11sUoh1xJjLvH2WGmfUpCT7iA/dEwPYmIO4cI7kf6QqO
   Wkwqe9VmToKOZsXRAiNp6UgpQ8zEv7JuPS2Gf+zxfsqKYZ3FlK6yL6SQE
   uLMi1WGWhrCZcSus9BA1isLXIHxWz/xpa5L2cImg63ZKQXdF2Np8E+Uiz
   g==;
X-CSE-ConnectionGUID: dN2QCxLNRWSxHz69TIwaLA==
X-CSE-MsgGUID: I/PJ6ge4RsC7V3HITD+lEw==
X-IronPort-AV: E=Sophos;i="6.12,230,1728921600"; 
   d="scan'208";a="34794490"
Received: from mail-centralusazlp17010006.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.6])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2024 15:27:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2dJN/sctWaP7H4Ojmf9nT0eSIeEgGXC/HvhGaF+z684nPA77KgyEiS9Sl4+8e6S6QV0PITIImXZFSjM3NvwZ65n95jVwtquBHnhg5AaJ4KiFpHNtidbTh2vGW60sOBJ424T73ySHHLF1NdVuuP1RiVNFXDchhNb4ShK+KaZ+0E8qekyZH1OHbR7ByO4eW/vGuK87UzBchxFIREpTRQSywn0cPG5S0yPWj50y2mfghWZMF2+w+DWeks5eqBwmgMBq0s4smbifo7mmO/ham+IbUC5BR5i6lu9hX7l9dGuULXidZXIbirtXhISEZUtT/AEEquX43loKvm7zovfCBk7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=unK/C9JDdsFOeeshDm0/2ssa7inXPuWOnyy4N+suhUljKKjl0gOZ6poKCvyQ22vHvFmDRbUEb89zX9IsMdVmjEbvvJt8u6yVu8daJ6Of451YmCb+gvdsepAwMYXaCNs57p8pGuuG1og4bUcBsZZqJ/6teQMLqxR0xWvorgLUqRkEgXbBiF/Ic6Cid68sw+E3s4pYzHin+cQijNgd/Vf44+xIhwWGJ07ULdKbsutZS+lc6+lpV9Znqg0cOKKyY13+LU9rly8BsjGM+Dwl/9t2z4Z/dUPeZX0WGhJvPijPVgVQ8yo87PyPDOUuZOutwOw+TCDoF2Rlj2YqLrD1/P7zdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=OtxDbuNWylWEZsAIa82PQTBzIU6PyxZbKlZs1I5Z3Ik/x6PvsFJIlTLNN3L3wbYlQw9StuJBRpOXoNUTmP8x4i12sHae5nugRolYW+z6LadqIuBJKMepV3ACtZhCFn3M5Hvg+nKoNRfugpvuynPs8/m9G+VC3cJrfX4afNXCdQg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB6546.namprd04.prod.outlook.com (2603:10b6:208:1c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 07:26:59 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 07:26:59 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, hch
	<hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 2/3] blk-mq: Clean up blk_mq_requeue_work()
Thread-Topic: [PATCH 2/3] blk-mq: Clean up blk_mq_requeue_work()
Thread-Index: AQHbTN0Rn4VAw01eskOof5bUfLb5NrLjxxCA
Date: Fri, 13 Dec 2024 07:26:59 +0000
Message-ID: <09c2013b-e47c-4287-a6d5-64996a709654@wdc.com>
References: <20241212212941.1268662-1-bvanassche@acm.org>
 <20241212212941.1268662-3-bvanassche@acm.org>
In-Reply-To: <20241212212941.1268662-3-bvanassche@acm.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB6546:EE_
x-ms-office365-filtering-correlation-id: f1b697b2-382f-471d-029d-08dd1b47882b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UHN1OXFVNEFBZjExRlJCV2hWSTIwWVJaMFpIVy9NTXRneWlaSVR0azdOSTQ3?=
 =?utf-8?B?cTRmYTZtQWFTZnZGTVN3ek1Rays5T0xHckVibEJ0VnY5VExJNGlieE5udWRB?=
 =?utf-8?B?bHhWc0RhSjVwRjcwRy9GMWZYY3dEUEtzdU1EeWJkcUlNWklyL0lraUJTRE1p?=
 =?utf-8?B?REQrQVNaa2RWM3kvVVc2WkJZNFdINm9nLzJ0eHdtTjlOY3Ivd1l3TWRoREhi?=
 =?utf-8?B?VFNzSGdMWHM5c3B1aC9JRGUvUHl0cllMNGtOdm84aHcwL3VmaUo2bnVhSHh3?=
 =?utf-8?B?VE1zVlRzcnJXOWdNRTU2Q29VV2h6MThWNDI0ZjcxR2V5bFVlVUpDMU9DT3dJ?=
 =?utf-8?B?cjJPNUlhUXBxYWlqZWIzcGw4VVI1aVBKS0t5TGFUeno4VjBacmhIdG4zNFo5?=
 =?utf-8?B?S3FmUDhUMnRCWkFBd21jVk5BeVAxK3pOcmdtcVp1NkpHVkhKcXZSWnpKMXQ4?=
 =?utf-8?B?Z3hiM1ZmLytLL1VQVkY2Szg5UVo1R2FCS1pPZXlhV0xCTWJXazdnSXB2Uk5k?=
 =?utf-8?B?OVVHM3FuOENmMENYMzkwaXpUVG1EY2NkelRmc3VNQkhzeHhqWElNdEZ3YnZa?=
 =?utf-8?B?T3V2Ri9Tb0FRUUFKVHZOdWZvSm5kSXJSVWNPQTFha24yTExEQWt0MVhmbWwv?=
 =?utf-8?B?SGR1WTdLRmRjT3FCaFVtblp5VUg5QlRYaG9WeE5JK05rbG5wQXpNbkhnZHVz?=
 =?utf-8?B?Mkt5WjlsaXF5b0RsdGFmbXRyNE96bnpKeFl4OURmZzI4ZmY5L3RkeHAvNGNB?=
 =?utf-8?B?MnU0RHRUcXJHWTVqOVJuZVBRaTVRWFgvR0pMaW9lRi9seGUrbUNEejZJYXRt?=
 =?utf-8?B?bVNJWXMwRHNVQzhpSEpiMVVmTEwrM3Bscnp5RGxrL2ZZdUVLYVQ5R01JdDQ5?=
 =?utf-8?B?RTBBUi92MngzNXI4SDduNG1FVmFUOHdxNFRPa0xRSUhPSWNCc0RTTDRrZUxO?=
 =?utf-8?B?UldXOEtiVTY0TnJVTEMxTDRQOFVIMVh2dlo2b08vNCtySjg4N29KTnUzVnpN?=
 =?utf-8?B?ejhxYjlUaFFITFloMEpnd20raWFTVDN1V3RMQSt4YS95Q0czWGNKaTlXZ2Fa?=
 =?utf-8?B?azVleHhjMUgxdFNCbkxqRUJqbFhsempaaHAxTlhPWEhKZm96VTFVbTdSOFVX?=
 =?utf-8?B?MXhldEY4aG5GKzZpT2FOdGVMMkNyRFNmaXJwRlNjNjVsMEtoRXRZSldpSkZD?=
 =?utf-8?B?UWxIMWoweGFXRmdoZUZnUkJkeUFuUGlnaExJeFIxR1Q4ZHgxdU9jeEZNbWps?=
 =?utf-8?B?VlNLZzUrTG51YVQrQ0d2RE4xNjNHWGU0RS9McE9zL0N4WEcvakVpa2hNL0Jv?=
 =?utf-8?B?ZGJGQnROcEdJd0F5NURVMDdNMHNUeU9wT0tNZ0RlWUNoMlJNQlR5OXFjWlV6?=
 =?utf-8?B?OUtNK0VpWFdsdG50YnprWEZaWkE0cmQ3WUdsQ205eEozdXVxY1NOa3BKOXlk?=
 =?utf-8?B?THhJMVliSmtCbURoQUxvMXlMbHIrWExFeXYwMXhRRXM2YzB5NzhMdklNbUZs?=
 =?utf-8?B?T3JMY1RJL1BLaWxNZTV4MjRpdmM2bVVGOEpEVUJIMmg4ZlloR09ETlhqeGc5?=
 =?utf-8?B?MklFSFh6VXNydnlNYTdJcW0zNkR4ZDgyQnpvaHA5eXFuWWhZbGJoU05SNWxG?=
 =?utf-8?B?ZmZrQUNYb28zMEpxWjZEakxBZmFBa0dod2hiMUl5ZXQzZTBGNFBzMFFENHJo?=
 =?utf-8?B?UmMxajg3QTN6YXJmUEErUWlQYlhiT3NhR1Zhc2VJend5L3FMMWZnc1NaOGxh?=
 =?utf-8?B?alJ3S2NCZGcwT0tGclpsQkJkdGZNbTVOdVo0a3dtNW1lejJ6eHpKejYwbjZV?=
 =?utf-8?B?by94Qk50RVZEalpoaHdaYWNBakl5Z3F5WmQrWkJvd21PL3plUThHQis5WUda?=
 =?utf-8?B?aUtweGpJalBQQ0t0YnpHM3Y2c2tFYTRZNTNKWExDOHdhaVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SUtYQ3pid3pRYng4Z3FqZUQ5ejBkRlNuRnIyR25rcVRyRjZYb3pMYXc4dUlW?=
 =?utf-8?B?clRlWlJuZzdYVkRzRk1tNTBYR0Z1U1hlS0Vwbm1PZjlqUkFSS1dPdEpmR1Fi?=
 =?utf-8?B?S1hkZU1yQ0RBbVFwOWdkSyt0d2FSdkUxTE1nbi93eUFLS3h0TlFyMjl2alFx?=
 =?utf-8?B?SFhQeE9ObnpSM0dUQy9wRjFIYzFURnM0R3hvYUdyUWZjZmVEaVNXMGxHSDdY?=
 =?utf-8?B?TktrUXcxTkxKZlhYNm5VZ3lWY01rSjZ1TEpDSXZxYTFidSsrL0sydnAxODBP?=
 =?utf-8?B?VFpOY3hpSVBjM1RIZkdlSEk3Yy9FZkVaejhBTG9rZXE5WFlVNlJkUFpJbml2?=
 =?utf-8?B?UjhXdFZXV3pNUHpjN25Sc3RTMHNLckpReHBvc0wyblRCek0wSXJha29lRmU2?=
 =?utf-8?B?MnB5S2RmSWFaaVhjWTcvYVQxQkwvVm12RS9xV2RFWE5HaUgrcXNpNXNHVUpM?=
 =?utf-8?B?dzJUTm1HODEwMkVxNVZqR1lnVStNditBdlQ0STk3U3JyZ0E0WnRFK1N0TU5E?=
 =?utf-8?B?Vkh2UnNINWVwV1BZc1hrb1RZMDYxQitIT2dxazY5WVk3VEZTRzhwS3FxTjFq?=
 =?utf-8?B?MDY5QzN5Q0xFa21UZ09DeHREalNvWjRrQ3BIYkJKaDdBWS93Tzh3VG5oUm5t?=
 =?utf-8?B?b2MvVEV0andRV0pMQTBSRG96bUcvYjZCT3lMV2pxTWlBOFN4R2ZJQ1R5Y1NC?=
 =?utf-8?B?S21lN0dmaDBBeG02bHdHbkF6aTE1VDNKYndyTmY2VlRzYUd3MExWWnlGL1JX?=
 =?utf-8?B?enJrTGlyOTBOQkx0RFZaT3pNLzYrVnhVdzRFUmlrL2VsT2lIU09XVitLYlRv?=
 =?utf-8?B?Y1h4RmRaOUpQZ2NVTk42NW95RkJtcDZIMlU5a21LcU1jMTFKb3lnYjdkaVhB?=
 =?utf-8?B?N2t2VnVQeisrM1VWSDJPWm5zM0dhRXNKTnNRMm01bTB5VGU3bDkyaTJNUEYv?=
 =?utf-8?B?VE9JRWszNjhYeE5JMy8wL3NxeVIrTVNyNTlLY3g5RkZ6cUFLcVdqdVB5NitI?=
 =?utf-8?B?MC9OTFlLaDNaNnkycjRJZmpSMEduZllBZ0F4QTJtakkwUVZpcXdTZXdmWklT?=
 =?utf-8?B?dkg3bVJxeWE5c00zSkxNR2UyRWF6L0hSbHJHc24wakVqeHNjc29Nb3JJbUpX?=
 =?utf-8?B?S0pnbHlpTXJlQk9lUTVaSzh6M29TTEVhS3JHTzJ2V2RSK0RFQmNaSGdTVUNU?=
 =?utf-8?B?aitLbUxremVEa0N6Q0dHUkdaa3Iva3VsYzVuSUJ0YmdVNlhDNFRHT1JPSUV1?=
 =?utf-8?B?TVJ1QllQTWRFRG9DbVFhbFN1NTJDVm40Y1h4OTNUdk1YamhZUThTbGNRYW16?=
 =?utf-8?B?YzhNYm5zVDAvOExoZmJOSG01SytZRjlZMHFMMHRuZkxaaUkySkFyb2xjZW9w?=
 =?utf-8?B?SXExZ015UGptR3JlQ3FXdHdydWllZjVqRW9YRjh2RFFaNjVmWUlrQTdYVHoy?=
 =?utf-8?B?elVYNlpxRitscXY0ejBhb2RsRnJYOWRGV2tMVUEva0lsOGVVUkttRmFGYzVI?=
 =?utf-8?B?WFZWcXJzTC9DdHVMQUJ0WjNvd09VMm1USGhvdkxLV1VPbm9JNGFnd3J1QlJT?=
 =?utf-8?B?eUZJSDA5TSs4ODh4dk4xVHZLK3h5RGtEcWFhZUQ1QVRYRXlvbDFieFlkR1Bt?=
 =?utf-8?B?SE9icUw2MDZBZjFhdGJyLzFvRnp5TFRyRWdDZWdCVmVpSisreHk4TUNOWGc4?=
 =?utf-8?B?NU1iZyszUXIzaGhGN0Z4RlNDZzdhdCtoanFwVUQ4TGdjZ3JKemczcnZjUHFt?=
 =?utf-8?B?ZEdnejVhK2p1RExaOFUzb3VMdGlSbCtqOU9VZHZud0FTK0gvaTNGT2Q5UHRj?=
 =?utf-8?B?M0lvRFQySkFiUWlHZWxzUGhqMm9md2pKMXhqb1Z6UHVNcVEzNkt1OExzMWlM?=
 =?utf-8?B?ZVJta1Y4VVkrWU1iU3N0Q25ZRTJ4S3grUjN3UFBDSzRsN244TUlncjMzT09v?=
 =?utf-8?B?Y1V1cVBhWjlCb3VSV0VUa0RCcVgxZ2lFWGVZejBJYkRyKzRDZFN1dEhrZUFr?=
 =?utf-8?B?MzRwdElSYkVhMk1yVmEwL3o4MjlXaGtPZVQzd0JvbDJQdytvejFPNW5lMERX?=
 =?utf-8?B?YmZkaXVZblcyUVN0OG0vdHRidWVURVpIZHNTc2tYd2poSGJxSndlTkU0eG1S?=
 =?utf-8?B?ci90NmxBZzB4TG9vN2UxblBTdVlqMzBoUVU3dThSZ3daYmtQQWVaM0VoV2E5?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AFC550C56AB304BB5994017F4900FC4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0DhC5thXSvRt+rTlBRYolmNLeF0dMl+z51AYKFgkvyZBifJ6m2oKCpDDO6SpChofN1gsGbjXSyk5NnVP+jxElO4Wmw5HSuY9hL07NDXDJ8i9nI6gdcngd/Hnh9KqI5fNlX83sLd8RoD/TeRk7lw+WZcTpE0K/oXs21fLycJqKRJuBVyVWeQviB9wVTG7qMr3zNLZHbv1cBP87dqTd4DSDPCqWKUhVptuv3Ppk1Iewc8ybwrfGmE2ABtyw5n7M8DfuexdwSfyz5tZ4zpgRg3gOnRmvj4mJjkF1JelzHGvcFNZiLBXa4nNCVais8S55vqTCqZXSNE7DdOjVzCNmh0LkQz9ItBNa8NnUjtjPVVgkFO+MYhRDsI4QRDBQNJ5rPW0W0ZZuhznoJRr6ngR/llrU9gDoUxTuJ7f/6g3ehrgMLVG6/igEw7sUzv66BaV3yOXv0fIU2sX9j17+oo1fN5oXe9PjyVMGlZ82L4Z3ku1NBF2rjiqV2TwiKUv+VonuzmwHTQ9R2ahNMjTpxTpOFidO9Mbe3sEob0Ev22Y3NT2m1sddBVE4R1GopkiPvWTq+XyZzlD4LaXZD8oO1phKmndjUIoA1LhOLdI589nIw7k3VW6FwBE7HIHnQH3G6Ccor/4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b697b2-382f-471d-029d-08dd1b47882b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 07:26:59.7501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kXLy5fgmnS9+7BckO6xdeLhx46LDHUw0B0K5wQvguTN2H1eqn4WeZRY3aPzzOgL4Utq7Fv8VzmUgi3u8y1m/gFM4EpIuQOEXpHGfK0XrKxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6546

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
