Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDF454BC7
	for <linux-block@vger.kernel.org>; Wed, 14 Feb 2024 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919696; cv=fail; b=BeS32Gjo69c1d+jx25PDhXgEdzR8Gtz8ntOP9XIkcCAr7BSDWEUBCMIxFHmTCacOo4ekBw3Nwp18LC5kKF2b1cprs+E/jvF2T0qejoq4Ln9FMB422+tue5KwVwOz2wJ3CfwO0g+AkcOrbV+XsNCqMARq3ULSK4wM7e0TB8gVBYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919696; c=relaxed/simple;
	bh=AMGotsqNeTx/ubHImRGkrUNQ7VIPAp05xnXyHmBTtPI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b/5kf/JIDDnK3C8HUL1vVHrzj+k1dw7yuQuzM/dhql4ehYFWukZ2zQA/3sMDGZ8+yZBj1wbi96Seltp4a7R2TZY26vHMe8pOqrVqciMiq/X4lJZOcYuTOuEiLVH6r2SDEdxYyqFeURXoG0zayJ3aGmj3JQdh6QK9sc+JW8uqOz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iLKEjMs3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IrNzD9t5; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iLKEjMs3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IrNzD9t5"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707919694; x=1739455694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AMGotsqNeTx/ubHImRGkrUNQ7VIPAp05xnXyHmBTtPI=;
  b=iLKEjMs3VsrjWuSZUaH7J2zS0htxOfWldd505YJLFO8fT5Gdc2udlkal
   YnCWfqGh41MEjbMSTc837L5JJ2OgLvvgLEfvvnuDIArLMWVwjGeijRhyf
   Grr4F3wKu/zkaYyE1jpFwm4wuAxPkIMZauY+rmFOp31I2DUvoCljFO4gE
   ASzaqwlfwg7S6R8r1kII2vNjl9WsmynlG+62oFUPe04eOUur+fZAwxy8n
   u8wwkvDhDFgwsHojalLZeXmYKWEw3hUBmdF0VrtrBtyWF4qwywL77mwXa
   isoXX8NrGD8fYXGSVQwVUU5AIR1xl7HwNgrGntF/JGWKpNQEcRKIybRxK
   g==;
X-CSE-ConnectionGUID: Tw0jMZunTvS+OVocK2lNCg==
X-CSE-MsgGUID: jMaY5zWpTIqDtR4ykfJ0lQ==
X-IronPort-AV: E=Sophos;i="6.06,159,1705334400"; 
   d="scan'208";a="9283945"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2024 22:08:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6qQ9tqrH/8Dgfns+RIQsp3PijJeY/alrx8IZqPw0VsCCDqBwuL1BoqYwygBK3codtVpmRQ0E1vde3tgeNrtT4JAkgsZ/ljHCyjFt8nZcw5UWd8duCmaSJTcijIYPEVGvuVU+hDHAZPJXjQBMnKTk+VqukbJB/cp5MGB1zEfQDqTLrRu2f6Wpz8TLN1ceY/ceVjmeRhbPE7VdFnkfd1F/m0i3FMig6dvCX5xrcUCmfI1yy2G9Eglk0xSQKB0t+phB105S8HE9dtyLL579IYfy3O9qzXB5QO9keFWbt1AgHXGzLh2MqrKlDmlIUBkWiaqlrHbeS8wzpihJD+KbtQSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMGotsqNeTx/ubHImRGkrUNQ7VIPAp05xnXyHmBTtPI=;
 b=Iuhy023f/TjJ22NT2k6oBXKjqfnB8s35Q+FNzmemw0ez2VkVRScXttccmcFnotZVgCXXGZIF/C/JHPTrqzx46ELEgTwYIuRZ8x2uvmJRBl6zt35GNNNf+KHrHfTkkRrABxvwu4EyqCOw2jG68J24n/YV761gtK2P5kQdqmwNhODWajoHyZxsDjiwF9TGKr3lQQi8Jy+FPCXx+kMAxFEkhAoqM92H2bJKYCmaZrhIX5I14re36DDauXkuHK0BDTEw0ySato8y3X9oMBEx1a5chnrzhlS8ZG+aOBdJFNyzRYUZa4P7F00IXcAllTQW4zjPr5OPi2JnsA/2QnOzikFujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMGotsqNeTx/ubHImRGkrUNQ7VIPAp05xnXyHmBTtPI=;
 b=IrNzD9t5cVDWcuwRq0IUEK40jSNpCZfe9Covors6AL8HghYJcDF80yhmK2Zi+B8KzUG2P+ulesB+6jv/4uQ63cbHIpsp5KeBAyWLthSU8qXf5iWcPthTqMK4imrgz0Mt9p/Htaysz0hnddvRzHdrtApTaGZQ5aR3j3LoFEy7HxU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6642.namprd04.prod.outlook.com (2603:10b6:a03:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 14:08:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::73c4:a060:8f19:7b28]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::73c4:a060:8f19:7b28%6]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 14:08:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: drop bio mode from null_blk and convert it to atomic queue limits
Thread-Topic: drop bio mode from null_blk and convert it to atomic queue
 limits
Thread-Index: AQHaXyvvp1lt7KTriUKhSbPvxxd/kLEJ4BwA
Date: Wed, 14 Feb 2024 14:08:04 +0000
Message-ID: <e1f8344f-c155-48f3-b4e7-e23d9dca83d8@wdc.com>
References: <20240214095501.1883819-1-hch@lst.de>
In-Reply-To: <20240214095501.1883819-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6642:EE_
x-ms-office365-filtering-correlation-id: 495f28d8-2eb6-4d01-27bd-08dc2d665cfa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ycWBokhyQC2Hg7mMnUbdEspIaGdB0LXNz5/Z6MWp3zZe8NzCaeixMQ16PQY+iRDHS7wiVUtuKT+wO94vW1SHgioGpJi5T8PJFwnG8jWEAvFx9xIa04TM980JaeD951mjxh2hYlehbHjB0eKc2Vr2xE8aPgd/WOr8V6DEdVqrjnkHFCCejNvPEC8ca0ETIIN+yZjO/QKNxuKe+g4xvf/NzLx3XS2epSMuZC8BcxbZ7odm+9rdWMB/Ul4xM1c1JxLudXwoqz4ilanKfanV8UjWmcby2YVsziKN+nnstCNIauLzVbeiXd5QRz8EcM7koOl/pc8rjonz+fzCb7aWIxfcXqEaqsJ90xcFqGeJR/Rt/Sgki+vp7SKlTN94JpQsboJ4M7laRuketxrLZJyWlP3lceIz6/eFlCHg/bNk00zLnKc37/SED2C5ZL9dMHjsIPYdPic5LVQpRjp5Ik7eL839DjkWDbuG7BxOBcigEhyXag36EayNhVuvtySELS21puM836FOX1VM0us75uyTSx3x610WV6XwR5oi7ulyFriCXplzpWxqBPJLKhFfeJNF7pSz6HSFthrTc6WGHzQsGC5/3Beh6rPZP9qrm+RSHrQ2OqLfnm8hFDErF+c/Sy4FMYkE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(36756003)(66446008)(38070700009)(478600001)(66556008)(4270600006)(26005)(76116006)(8676002)(66946007)(6512007)(4326008)(5660300002)(8936002)(71200400001)(64756008)(66476007)(6486002)(6506007)(110136005)(86362001)(316002)(558084003)(82960400001)(38100700002)(2616005)(41300700001)(31696002)(122000001)(2906002)(19618925003)(31686004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzdxWkM4V2NaTnJoTUtMcUwzOXQ2dmJZeHhVYzJ6MEFmbEN4NE9RUmN6a0Z0?=
 =?utf-8?B?ODN6eXV2ZzA2K3JJdnY5U3QwNTFTRmM4MTNna2gzaktGMXdETEloMmR3RTIz?=
 =?utf-8?B?QVB2bmQ0VnNBNzNjbmd1RnhxMGxtV0lFK3FycUl5V1RYdlhrSytRYVc4WEl3?=
 =?utf-8?B?eDMyV3NZR1Y4TElkdUl3RXZnMUZrZXFDOTh6a3RxVGFUaDRBdkM3bExmTEFw?=
 =?utf-8?B?WXB1QlFmbXVvN3BkWEtTSC93VjVydVY5UUE1cms3ZE5HWnArdzFZZzRZeGpC?=
 =?utf-8?B?cnRoTFl6NWdLOVBuV2xWTGpmOWhabnlYUXZzcmgrZlRQQWxWTEVKMmduWUlT?=
 =?utf-8?B?RWIxd1R0cGY4VEQyUHpOODNDYUR1UkRxZDlqQmFkTUpNR2xYc0VrTjVEUHE2?=
 =?utf-8?B?V3UxcEFBYmxraXg5R0hqWkpjQnJCWml5MGtaS2ZZV2JxRUZHVWYyOE42N1VT?=
 =?utf-8?B?UlFQYUNTZnA1NWlsaHc3eEs2YjNnUkJ4eXNtMXg3allZMXpxUkVaTlUxZUc2?=
 =?utf-8?B?VCtaOStqZnZtWENVOEJ6YWFRNUIxdG56SVNUSk01UVhTQ0w1dzJNTkEwcW9u?=
 =?utf-8?B?cjRyaGNpYVZCVVpGSHNwUE5NOTZsMU9yU0lHS3VpSXBSOE85SENKdENjWmxP?=
 =?utf-8?B?cjgvckR0ejdoV1NxUFJLWU1hTzJwTnNrTkVMMEQvdGlpSjJuWTBsK0pUYW9s?=
 =?utf-8?B?SUw3Y2dlOGRFK2Q2YXNQVXFMYU43cXBTVlJuTG5EY0FNcUlyUlZyM0tJQ1BS?=
 =?utf-8?B?dVp6a2toYlN4SldtajZsdU1yOTFFcytlaUlNOWhSTHFUNFJ4OWF3M1VQdTU4?=
 =?utf-8?B?RHhRQitnMFpuMTk4K1Yxem9WT1JqRmR6M0JHcGRaZHZUTzQrSWVoeEhTdUZj?=
 =?utf-8?B?Tm9kRU1jM01Jcis3QmhQMTZJRk1QNVJoQkJ5TFZmQ29wR1JSR2lvMzM3ZmRm?=
 =?utf-8?B?Ri9lTUV5OTZCSUs2S1NtT2U5YU90QTdwZWFXMW1xZ1dSZVdrYVZqLzg2ZTVR?=
 =?utf-8?B?Sm1EU1UrTWNuemxSV0hsV2trR2Y5V2lJeWhja25OYWhQMzV3ZUtuWndzYUI0?=
 =?utf-8?B?RUhKM2ZnbGJTOVE2RldVNkNhUnNMakx5OW55QzNRU0hPN3JoZml4MGwyb1M0?=
 =?utf-8?B?djhlanVaaUZOajVzdmV1alFCaWU4YVBBaFBDQ25MNi9FNFVJcXJrZndUbTVp?=
 =?utf-8?B?OFByMUpHN05iMUxTSzFuQXlvM3orM1FSMEkvWWU1NmlkdVBjcUJ1azF3V0FP?=
 =?utf-8?B?cjdQcUN0OEo5V1FxYkdNWGFwQjVUdS9RYTV4MEZjOHlhWmRlUFovZ2VZRVlL?=
 =?utf-8?B?VnRwbndVdVBsR0pzaHEvQUorNWZrNW5FbS9Cc1ZyTUxROUcxR0I2RUlYSERx?=
 =?utf-8?B?aTVEYnNMSDk2RENYdHdHaDQzeFRsS1FnUGxENUk5RmJLUlhVa055ZUwvN2k5?=
 =?utf-8?B?WGVqUTdFbUFtaEptR0NhYXVKUmgwenJRUmFYQi9iVnE0eG5QTGhDYnhMcTh1?=
 =?utf-8?B?MEJkZmRoVGJGRGsxVjU0T3ZwQWFlVTAyRndOMHdRTVE0VlFJNFduWlVDT1cw?=
 =?utf-8?B?TTFQYzJNb09RMmpSNzhXdGt6cEY3WE9zNExUN25kZk1HMDgxNHJFcUtUQ0Zw?=
 =?utf-8?B?WENoUmpNR04rcEh6a0JxZWd0Y1hnNVdFb3dxNUIvREJrNVJvc010eUY1ZS9l?=
 =?utf-8?B?a2pmQnBHR1lWWklzVjVDWUhkVEEwMHJGNmliaDBKWjFkUTJlSC8rUDhlYWxM?=
 =?utf-8?B?VUR5Qk1xNVNtdzVudHg0S1NBbUhwRkJnb3dJZXRKLzI0Q3liQ1FkWVR6elJ3?=
 =?utf-8?B?TEFoUmdOQ2pOdStEZGJwKzRDMWhoRmhhVHlISzFYYmFJTU1mdUtRaXZqOVNL?=
 =?utf-8?B?QVNmNkhWaE94SXVIWWNkTkorWFR4Z3A1WXRiOXdXeVVNNlZzVE1YWjhEV0Nk?=
 =?utf-8?B?dFFIZzEvSkNLR2xqaXFEd0MyU1l5cVVJU2FHT0poZGdZYTVBTkZ0c0pBa2do?=
 =?utf-8?B?VWtuL1pVUmJNR0dlREFmcng4b1pWWnhJN0k5aHNUcW1DU0RwdHl6ck9vWGwy?=
 =?utf-8?B?SFlraDJPWFBncWJpcjR1bi8vc0ZidThaaXlqNXlzSFVmS2d5TUFYcjBPU0dI?=
 =?utf-8?B?YUlMMGsrb3lSRHNlOHNkKzYrUEFOeXVPWlRCanluUEFhejBmYks5SEtaVlpj?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8324555BBD67CA47AEE2657DED2AE281@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gTKgV3EoQFMrYz66CnRRswU9NG0WlHa+ol+zjBaR3N1dwXX2mbaALQwbDhCucuOoRUsldTEdaySx6gEQLRCAgvTwPnXcuM95qcj2VfTmyfVOkBoWOoUNzmaowjz53IP8rl3O0R3Xa0AM/7gv/1LM/ADJgFREu/WcMkUZ2J8GgZ79+b1qBGVBS0uFHtL+RDgyi4+G06qjm1DYuLe+5k5zAd0B6dhzQkuq71cYILGRzkDHrQYOJPfoHJ/ssxii+21lTE4EKee0C36QBja+oPnjmmXKY3rVJXwSAvN/BYf9c1tcbSdP83aPxjvGXrZygh8eJeG1/8afC4OqHn7ld/FtZ3osUCV1I82HdATUFkSNLmLFw0I4YedTAJFv6Fke6KPoAEKtT7udA/LlTPArHn+9F4nv48mRlftfMCSjaDmdGFFNtGp0YfiyZzQRK8ZfFrSXFwOFzzBCTpN9StG/mU7jZtz5qpn6/lEjo+7HeWa4VgEPPcctYgpxDn3w3fhzSv07ROxxMGgkrBGjHMAUR5uJFlWCEbHrZDRAMAmCPFZCfd/wohqjeW2B98hx34GhgwNdxdVsBF34zv2GJjHz/dkwEbpaEcvBJdKbbzzzVnZGVirCv3onuwLqgXYYMyemhLuQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495f28d8-2eb6-4d01-27bd-08dc2d665cfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2024 14:08:04.9006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sTYtkS6xg0cj+KGYN2a21wvA2xdt03Gq6GxpbXfD+I/XlGpl7hx/tQK/MHgO0abJlw6wFqImN9RgKm2yraV3/AAN4x9K6uHhE2LntIC+sSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6642

Rm9yIHRoZSBzZXJpZXMsDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5l
cy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==
