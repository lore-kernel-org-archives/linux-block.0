Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0B85FB8A
	for <linux-block@vger.kernel.org>; Mon, 26 Feb 2024 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950043; cv=fail; b=Pm9s5k6UEAGfLZJA5cI3EQ8ZyQUHwXZE4GWrlx+5vVf0fyzELDflo6/c04MZ6vLXzXdDelVO7GgcjPwiNtCvC8dUYEBu1lPQQ1oP1OKlKBljsL4M6XtI/KO1Th097yId7G2mw2UdXDevcBciodygNWJ8EWZZEIVjs7YtC0fXhho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950043; c=relaxed/simple;
	bh=WYNGIiEvhxf43ZgvUhPkTe2T3a01L+HSnkG5mNh9KUI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a8kb6AichjPMU4P9nZwuoPOTiLaroLYA3ElwPNms2eGHBwS3Kq2tHwBW4YLMXTIfXrtaRh5VtW27OSIyHlIzwZ3rcz8i54OYtVpiFCJ16SMSLlOTqu+eC3vvW61cN4aMvo3QGK6S+rjFf+GleFOJIdmDvHwfZEittKLugiq6WK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=a6yVKycD; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mtg1tn3b; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a6yVKycD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mtg1tn3b"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1708950041; x=1740486041;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WYNGIiEvhxf43ZgvUhPkTe2T3a01L+HSnkG5mNh9KUI=;
  b=a6yVKycDHiYyhIs13KJAOOGRrdq54W3JrjeZJx5hq032NDzpjZ5wmPrZ
   3Rw9fKsXFzs3zQvwaF5H7fxK1qb9dGV0nwxBwLjWaZeUIbVdsvewHuLEV
   3dxCWktdWRCCivGg2YVgdVO6qeq/AE3OtZLRz1CAuF8r4f8pt+kM726pz
   YMZho7RBYw4o+azQgRjOeuUbcj2Qf9RK5shvCl0JC60QOz29sfSfSe9PE
   M4C3KBStoIT8Ee8DK90z83d1fZ21tl/cAYI83EcK95vVGoLB07+sTw6wz
   2sTOVlaMfpHIaBGwlguB9L2AUdyCl73CSIvFUEhx4WQKCp0FAhgKnDfj/
   w==;
X-CSE-ConnectionGUID: nCWcXcCtRB24i5MkmUGl2g==
X-CSE-MsgGUID: PwKqDnLRQlOCqKSd8cIfng==
X-IronPort-AV: E=Sophos;i="6.06,185,1705334400"; 
   d="scan'208";a="9768140"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2024 20:20:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKJyGUUflWcwRAw0pCxrlUWB33JJYkC+u8+xIKnAyevjgeEHfpms/riN70TowbUIpvrs+D4xFqRwlUW61kOQ2dk6MD3MhWlKetEFWVCH+pMyJxPAcXmvCwEkTU40eofD045VRpvNAFbVtv3JFNIcPx+VHNhKvIk826n9mzrb3pNpX0PbWdW5SWUoVFdP5U78FoaDYbH1R/uxbEWHubkOTycgU+UBcTYMHJxl6Unllhnfx7lmEhEepsXVw7ZclQVFBfdfVnwfiLMhhQ3YLhXmzlJzU8BgM/p0REIYIGNSmDTtX/9JA0muG2+SRj9GknFSq3oD52DS5SWhU/YRYHrU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYNGIiEvhxf43ZgvUhPkTe2T3a01L+HSnkG5mNh9KUI=;
 b=ddG/OeGX3HT/E1VrHzMPWHuaJMxPD6gQqfpLTzc1f85BAdQzMDR5qFWgBO0QdorNeNdzW+wHocdIyUTHUibrQiDT8CjtPCb4TvkcvdrIpBHuTQdP9aZoNN/O1qx7cQjUfulJI4wGi+vgk36JCTUSOR0IvEqFLfkO1niB/4PBVKtTyauKArf78KZN0VSNP2zLdsXjbwKmwhJzoWh4MixBful+5WpLPRT6yBvq+KCHCemNuJ7/vLKW7F+vrRVO3okRanZa/K+/a+ehFVO9nV/qHLiC1V7YJMWTgmRHO37tcuU0W6LxgPch7P2yalTs5KgOeMar97xw2J95Niyj5xMxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYNGIiEvhxf43ZgvUhPkTe2T3a01L+HSnkG5mNh9KUI=;
 b=mtg1tn3buadMev/Y1RVv2jY45z1M8F9gtoFcb2obvhuks5n5Hel6BOPlGSbXerJzNzujUzo0wXBzFHHtsJe0cyHWmpCoddKKx4E7aWkKFmwV06F42diU1caX/VhjrUHtRIKwL8xxNd2mBjmLUmUArfaGo8GMOQ6BaZcb1n9nNf8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB8427.namprd04.prod.outlook.com (2603:10b6:303:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 12:20:36 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e%6]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 12:20:36 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Chaitanya Kulkarni <kch@nvidia.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "damien.lemoal@opensource.wdc.com"
	<damien.lemoal@opensource.wdc.com>, "hare@suse.de" <hare@suse.de>,
	"zhouchengming@bytedance.com" <zhouchengming@bytedance.com>,
	"akinobu.mita@gmail.com" <akinobu.mita@gmail.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, "john.g.garry@oracle.com"
	<john.g.garry@oracle.com>
Subject: Re: [PATCH] null_blk: add simple write-zeroes support
Thread-Topic: [PATCH] null_blk: add simple write-zeroes support
Thread-Index: AQHaaIONYmhw0DNztEiOB9NduLw4trEci2AA
Date: Mon, 26 Feb 2024 12:20:36 +0000
Message-ID: <4549b888-4613-4c96-8ac2-ffe08b52da3f@wdc.com>
References: <20240226071355.16723-1-kch@nvidia.com>
In-Reply-To: <20240226071355.16723-1-kch@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB8427:EE_
x-ms-office365-filtering-correlation-id: dc0b32f9-26a3-49ce-bd1c-08dc36c55697
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5P9ZY/X0HYnoVGw3iTFIYAYBc1cj3X499lZ4INSdzywhyKFEOYbuMcv7yFvftQH7s49qoqETT7qCeqUip8TM9y92MfLOOsL6XlZ5sIdX/Ko/Xs9S6UFKFat2Ui4mp1BBok38ByfjApcF5pcQI6fo2d9BkHhlr/QcE62JVahqUgCXpoP6XOGOCZ1gqNfbcuC30rs5l8gNgTq78rLm/xqsLbSBSKjAAJ9vnmE/RGyGwRpZyEim+TDFp2WU7EF/HOCGLytVmSkrha0ixzWTnHVa+3DAeevhgdK7tO4QChsF5meBfieOAGcv64mRdEln/hh+X62+0EYE0371u8VL1tBGoAOi0Hom9lj5i9v4iqi4Vj775Fb8rQJQPLSkzx1Sk339BnBZIRSK3ddptOf34a8IrPdBIARNhVz0tnYJlX58MibRMold5Qd9QeJt9zFquW5xWkO4j+3wxkBAf4ryM7lhwYK4ci26vRtPRCsRITlRPjhTKb7sW3fd7TrWuidVPtwmIvT2T+pAf6+EWdawHqH1CAr3UZ+zO7kE26t5yAr+/Xjo1sd2NtOSADFwZoN0Zup4iFD33/DsWDIm4tUrWwjXv3EL9LKuU0Gh1RtZqvTtiUqMS1FzdICshiCkb10y+AEHfVj+3AVoc2MxIulypi523UDAAfw+DKh3PIHVd1c2W99UN6p57kB17JJYUZeNFrS39fxC/xFkj6yqcP5uayKVBg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFRFYXJ3UmJzTlE1QnN6OE5kTXlKUG9HTCsrRndQbldUeGIxYzFRRkZ5RGlC?=
 =?utf-8?B?cGZrOGo3WWhMR2hBajA3QUxMMU52bmlGazZkL0xBaTZ0ekVDNmxrUXhZNU5i?=
 =?utf-8?B?STJkYkdYZmJJUkNVcXNvYTB4YXNNTVB0bmlBYUYxeXNwalN1UTZ4bmtSOHJV?=
 =?utf-8?B?LzVLUVQzc3BhaCtwOUw2dEpKdU9Qc3lYRTB2T2ZRMGJnTThUbmk4c0J0dTZ0?=
 =?utf-8?B?WlRGN09XYVRLRXRpTUwyaTJLNmk1MXBnUFBNYzBJQk03L2xnblREcmNtU1Js?=
 =?utf-8?B?aEJPQTRBYTUwNDhFbFg3UUxUYWV3eWtYeG94Qk1wMzkzajRERVUvUHk2Rmti?=
 =?utf-8?B?SzFCejFQV2hFOUo0UVpjU3lmZEdvaEVTbGFlS3RqOTVoR2IrZEc5VGpmdko5?=
 =?utf-8?B?ZnpZZUtjb3pjOHBYQXhHVWlZQ2NJTDlWVldoNEtBSEpyVjU1L1A0OWd1cHIy?=
 =?utf-8?B?REVOc0JlZDlSaXV4dTByc25uUm5iOFlLSHN6US84WGNVQnhBYjNNQk9lOWEz?=
 =?utf-8?B?SVUzTmViYytYZzJKenVvYkVrVkpqdXhLTWpmdkJKWS9UL0k5cUxnZ296cjVI?=
 =?utf-8?B?MSs4R1hCenFLZXFVZGdtZlY0YU54QkRBMjZVY0pZeFI1endUNHJHeFdOUy9i?=
 =?utf-8?B?MEZJbXZtbE52MTBGYXJwNGpKMm5wR29IU251ZWozU0hQTFh2UGF6bGhiY2Ft?=
 =?utf-8?B?MHd5cFdOVXYxMGhRekNudHNTUnhUTGxZZSsxVG9Jd0VHZ1pheHRiTDBueFor?=
 =?utf-8?B?RVFzajQ5MG83UG5peXdkZWRCcXlqdlpaUkhLMEhLeU1tRDRVRWpPc0xFbWNJ?=
 =?utf-8?B?OUxoRnRjQ01iWEtCT0ZQb24xZXcyRHF6dXRHNlJRYi9waUkzaEt2NGRCV0Rh?=
 =?utf-8?B?T1lqTkY5Ujlub1Z2TmEzb1p0czhFMFdsdWc4d2NKcDhLR3NiYXFmMWdDcDdx?=
 =?utf-8?B?a0p0emI2QlZKWWRVTS9UdDh3V2tFOS9XVkdNOU04OTNjMWRjQm1iVnV4U2xM?=
 =?utf-8?B?Vy9QcERVc2hXcEVBUXZDWml0Y242RUlseGNoM2VnV1NEbURFMndhNXh1R0Ew?=
 =?utf-8?B?ZXVHUFQ5Z0VRMWZvd0FJOVR6RmhXK2ZHNmp5NHo0ZE5BVS9sWDc0TSszR284?=
 =?utf-8?B?M05tNmhIeTJKUEhnbzczamFqMzJOaXhXL1pFM05oVDhRSUNhQjlKQzNSQVlH?=
 =?utf-8?B?WmIzMkhSWWVVYTFpSXlST1A2U2dVbUN6UnRaZldjRXNvM0lTVjd3V0IzdDhm?=
 =?utf-8?B?THNuNGRSWEozWitRb2cyUGhNQnMyV3JDMHVxSjVjOWpCd0IrRWh4VHV1QWNI?=
 =?utf-8?B?elcyUFN5eEh3VHpOK2lKcGpSdnpMc0ZoMmRURE5YZW9LRDFxc0VNTjNCOGFO?=
 =?utf-8?B?S1NXZFdIcnl4aXNDRVNQRTlqVjBsQUVsZ1RsdXAyZEpzbXMxLzZEVmJSWllM?=
 =?utf-8?B?bWpqeDRsejV5bXZYUFhocW14cEkvM1ZMMW9zWThCR3BPeDVVQW9hU3dSTFRT?=
 =?utf-8?B?eG56NjB2MGhpSWRVekk2bnlJQzFPb2VXWGVNaXo2MDh6WkF0Tk5teThWL1Jh?=
 =?utf-8?B?VG5IQW1VN3NTK3BBRU1PcUxZWlIycjZJZDduRHdpVE9QeEJSa3NnM24yWmRr?=
 =?utf-8?B?SFM3MzZ0ZnBkdGdjTlRjaWZTQ2s1dzBnMHB6MldvL2xubzlLcjR6SWgrbEY3?=
 =?utf-8?B?MkUya1dEQS9zeWl5QzlQN2VLaWxlSlZvWWthejNLNUl0a1RsbG15a21QcEtQ?=
 =?utf-8?B?TFlDTElYWWlTa0NqZGNPVVZWMEFldlR3NFlNdUpaUy9KWGdkNDhMYlFQSk5y?=
 =?utf-8?B?ZEd3ZXl6Rlc1M3M5NXBBTnVnKzU5alhhaTgvNjBTNzZPKzMxN2tQU2tTSFpp?=
 =?utf-8?B?elVFejBtMjB4WEhkeC8vWXNYejdacUFuYThtMUZFa2lCRUdCa3VWZ0NiSGVE?=
 =?utf-8?B?K3FjNTNxYUJlUWtBWGFmTHFtQ0V1OW40WEJXdjZ4SHlMZ2ZldlFXZHUrZjEz?=
 =?utf-8?B?M2svemdKbnc1UW5ZRlV0RWdMenRjaWdaQ2psNDhmby9EKzZoNkljRzFNZElB?=
 =?utf-8?B?L3ZCTmVGYjFMbHZMU1pKZnZod3VxZi9OanAzakN4c0Rja0pLQzZ6VkJhcXZY?=
 =?utf-8?B?OERNTTRuVVpVYVU5Z2o4VDBOcEFQVUNrZ3VSdmR1UThhTTVBN01GOXd0WVpK?=
 =?utf-8?B?M1VLS1IvUEpiWjZITnc2blA3ZXNBTHdMOGhHL1BNWGRHU3dtTHM5V0ZiQVR5?=
 =?utf-8?B?YmY3NkhGOUJtaUFiNFdJbHJ0ZE9RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <348933FED6C2904D900737DB638421F2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qOUeHe5YX/D5D+RAyybJpx5Af2AqbGwMC7/ZRlYjuUwcwwGr29rVrkKSUvtg7Ah2TynnfiRt0t+ZzEFlI2QMy2SpCDKioiNpCFXVVK2R5m6caKMaqlC6Zs2YDHmdXqX7F9XS6O0HYalHoacc6EG+DxfOgSgFxTIO4+VJklBxm5mDsvfOTQidneKO24MZ/sM1N+YLoLXtNBwdYMWJa1CawKA6FCYSiP184mT8B1O9l2eR6mpaeV72dBQsTZc1R2OC2/fWeEolurK9EHiC92UFX8LsooZ9biX5t+Q5FHzLRxeZFRipkXhmluRPx0b1PslOubo2Ev4y/seeXMzglyTgMfkAfMDjarMsjl2VyvNis+5qbAtr984eU6KxaEV8xL/Y6UmlVKIQEmeeCfhOa8t/ReBprt21yZYSiwAG+F+8kSkk69ejn1GBd408lUJmmXrnfV5pQrcs9RLB2FHIBMqMwIUW9dstqcUfUFvl8XUfTRi1F5sQPbWGFFSXDo3O5ZLVsL+9KlULJHiuWMouC/N0wElQ7faXbW1BakXy7x8CfoexhMMESds47UGvzvQ6aM3OQBXTAdng3yVuDRFXI2jEiA4u+5BKgVFVccGeRgpM2GZjFW0S7+SBfiLoKEf/OnTY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0b32f9-26a3-49ce-bd1c-08dc36c55697
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 12:20:36.8887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HMkkRCaKFiLQgXQ0M7XOf51FB9BqXIJ6XBl9mxjqPCYWIgkSreHTkiOgTbNFa/5HBTX/OtlLfRD5mDAE2v5G1MoOYYoxDmAuM7FzeV3ZiO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8427

T24gMjYuMDIuMjQgMDg6MTUsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4gQEAgLTE2ODQs
OCArMTY4OSwxMyBAQCBzdGF0aWMgdm9pZCBudWxsX2RlbF9kZXYoc3RydWN0IG51bGxiICpudWxs
YikNCj4gICAJZGV2LT5udWxsYiA9IE5VTEw7DQo+ICAgfQ0KPiAgIA0KPiAtc3RhdGljIHZvaWQg
bnVsbF9jb25maWdfZGlzY2FyZChzdHJ1Y3QgbnVsbGIgKm51bGxiLCBzdHJ1Y3QgcXVldWVfbGlt
aXRzICpsaW0pDQo+ICtzdGF0aWMgdm9pZCBudWxsX2NvbmZpZ19kaXNjYXJkX3dyaXRlX3plcm9l
cyhzdHJ1Y3QgbnVsbGIgKm51bGxiLA0KPiArCQkJCQkgICAgIHN0cnVjdCBxdWV1ZV9saW1pdHMg
KmxpbSkNCj4gICB7DQo+ICsJLyogUkVRX09QX1dSSVRFX1pFUk9FUyBvbmx5IHN1cHBvcnRlZCBp
biBub24gbWVtb3J5IGJhY2tlZCBtb2RlICovDQo+ICsJaWYgKCFudWxsYi0+ZGV2LT5tZW1vcnlf
YmFja2VkICYmIG51bGxiLT5kZXYtPndyaXRlX3plcm9lcykNCj4gKwkJbGltLT5tYXhfd3JpdGVf
emVyb2VzX3NlY3RvcnMgPSBVSU5UX01BWCA+PiA5Ow0KPiArDQo+ICAgCWlmIChudWxsYi0+ZGV2
LT5kaXNjYXJkID09IGZhbHNlKQ0KPiAgIAkJcmV0dXJuOw0KDQpQbGVhc2UgdXNlIFNFQ1RPUl9T
SElGVCBpbnN0ZWFkIG9mIHRoZSBtYWdpYyAnOScuDQo=
