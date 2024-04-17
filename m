Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6932132C39
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346978; cv=fail; b=eBoJgQ+BZ1VZZGP0zw3fU/vJ0tHIcv6DS5gyPr72qsnxt6f4lbcFMH/4AS5RS3jiB17nCI1hevrnxxFdEc2yBm7ksY/w+uoYjr0OBnQdFv/yZw3mqjLnWoRaiLOvCa9byp+6LWihdbCy2c+q/8JblWTq6zxVxvAS0azLngnxS9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346978; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HLjJW9Z1daIinsaVQAmLu5BMgMFCmi8qxahebIW4T1NY8GyYHs+r+XaywK++Xxxvr+T7qDVmw4lz22xRmb4K0ZAQzH681PB0K+/Re6qH21FmdRzutnRHmjerbomjirnemfJ8dOxHwLhLOcNcbKjxgqZeeRuDTgr/ciJ3MM11940=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lCJop9k2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XqhBGqpN; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lCJop9k2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XqhBGqpN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713346977; x=1744882977;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=lCJop9k2kFBAfHfc8AJIYkid0s5Vd/UuIsiDiVPtvVgHGIn/LHyUsPaI
   59Gi7RDhWDY1XKIkjN63zvEFDggmQOXUe1zRSkET/mmDxvzYr6aJDIhpR
   xP8NOM5bEo6eYVvTgxhC9kKJcsPT5aYiBomvRjRI1t93loFt6ReZyKTFM
   gSMYGAbOtVpSWObgGdmY/zLIXos8h2pPryEtC8HWcCFzV/3J0SlZKAURt
   nXnzFjjkSXinKJ0uZZTdgK/t+RRZiRHt8YgE9eL5rzNNSH+FkRVibL51b
   US9s4bpmJAdyZghz2mzUyHvvjgIhYHh/gOT69w/lR+mmbtmnPjc3DoRG/
   w==;
X-CSE-ConnectionGUID: s70i6m3zQ+ud3YbetlzOcw==
X-CSE-MsgGUID: TwfQ/39ORgKhwp/Dtm0cjA==
X-IronPort-AV: E=Sophos;i="6.07,208,1708358400"; 
   d="scan'208";a="13641444"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 17:42:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3Vu6bmQnilYA46c3Nqb/3QwtSeWTQ93cjgS+ALC1yR9mBZpK/lZzFDpTPLB/4qoOb/apmGVPTQraYG8RqMRXULM/R092B7FAnm8icnZAc30IHLmjvTHPMr+QBTqUvMA12X06u+URbheqrTpZMgKnApVDAjIDuRwnLtRrq+534ItVoildRpzYpunWP9bETU3hRLmkWabkAYMQSGrNX3Jdjqhcs+XNL1Jc/MXpLwSNC2fTK8PSTzkeNpG55v2YtD8uQ3rEQ1yuBkfK8OJxh93/Hair/sWh183xE+42mPeP+ZgsopWTQ20J4CcKRQ+9k/mGwaYNHmBzo6q+3QdX29Y9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=Mt9MOiEQinzpQ45U6K0n58o3uJCq9QoMUuf5iYDjY5Y9l4vhnmH0oUqaL5cdVceewtRbQLCflg0pHf4TXsWXNZslpBTR93WJVn7WQGnj7AszrZoxzq/TqnU0bsItmEcyN4B5Mr1V7md3hrIC/9PcGnU0HbYCdX/xI1nuZNHo+b3t9//JfngHoNRAvMO3I0WncrNPgKYY+ABVSDGQppypRA0eYExT7nK/BeXnP8GoDfsAJSjRnB5/emzUpWu1lqh+S0jeXqWU/iusXmKAh4WW6dmjWkozLnUknydIV0phiWvKsq/GQIIu3smInVfM717LSzB2DZCma0l7AXBd4JCV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=XqhBGqpNU/DFaRnmEE/IjBuKApyWfwSfrdyUNFLKLPbodxpMoOqyq2jjTe3UrMnBac+vXRwqne6isn6RAoqVFmuI6aplmbcdTSvC+cozhsStNMlaJo7Z4x1+V3D0n7LQde+cXyOu4vuDD2WQORTmPWLCtZcK0B0T7tssPucVQiE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA1PR04MB8886.namprd04.prod.outlook.com (2603:10b6:806:386::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 09:42:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 09:42:46 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/3] null_blk: Simplify null_zone_write()
Thread-Topic: [PATCH 3/3] null_blk: Simplify null_zone_write()
Thread-Index: AQHai+37qdofqwiqd0+RY0+X9QMiVLFsP1gA
Date: Wed, 17 Apr 2024 09:42:46 +0000
Message-ID: <a00ee491-46c5-4dfa-80c2-27b5b11d207c@wdc.com>
References: <20240411085502.728558-1-dlemoal@kernel.org>
 <20240411085502.728558-4-dlemoal@kernel.org>
In-Reply-To: <20240411085502.728558-4-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA1PR04MB8886:EE_
x-ms-office365-filtering-correlation-id: 17a3c2e4-962a-48b8-0095-08dc5ec2bd13
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 r553Qf72TzfQYNvXXUpfbCbj49018+M6TV9M3m4Kt1d7z5124S6cOA6ERwp282oBE7EpFQRyWIQFGSKrkRdB8e3cHpbErSR4PVzGqfOhsiZGviHn58N5fqkCGEyMQcc5/yTHh/tqwt0ziXduipmXqqLaYxFGp2pcjxIi1t0z4kWFUWCS/uPp48RQz/Ecb/nDmG+R9NtPtDyMIo624qLLXK+8+ykoJoczzxbjt6SxltAo4ZRU0kGRALRRPcfbwka3IHfxoLHYRNqmSvZ4X2ybCX7WfTcRyf6FPW6ElQQsr4metc1qVG2wt6NQCGIkSbKpTLtoYvINwAivRjJx8/8o/+Hs1p2YJRiblCCfyiBBvKCuK/vjVF/iXMW0EZItMN3RZ/Rvt9NBNmL0t6A6BFbEzH0dppxe46P32QMILDgY4MBtk3WDBOYD0zddYYgFY2LUAkIUczxH+OLu/1hCiX9Da2m/QHek5f5JmAVe0x5Aso8+VH5VU9GfFQkeIsXbBiRGinswPYp89F8nNrNUnMH8sJxiCVV8VBpIDJsAAw9xXDEVchF3T0du8NiMpwxFSlRiz4IxjjT58bsypWhq3Ycottu7EL0SIfORKRYPHGSfs9fa1wkbys8nB37aGrw5Csvh4EV1/Jw1bFH4neyurTCYUHqaFG/ZvxCNmkg2Nzfxcz0BHmgvfGoyZdtsuPBrGq9llGtrY6Rc7RI5gwCjV+fGYniNuRCF9lKv+RdKYeIy6vM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFdrdjRCWFJ0anVidHFmWjR6dXk3N2pTWERqTDRaTTJxN0Q0ZEl1alNqTGtF?=
 =?utf-8?B?ZFFtc09WNXBWUGY0Njh3ankxZUdzZkljcWZOWjNlblEvTWVCZ0M2RHU5dTlq?=
 =?utf-8?B?UGJLTnVKY3VSaTArNTlEUkZybGxpYWg0ck9iWFo3bVlBOEpOaDQ1NHpEdkNk?=
 =?utf-8?B?aXJSbkxMTW4yU0t0T2pDbG43QlhMZGN6cUlYY2NYc0RoK1Z2cXBOYXVEQjhI?=
 =?utf-8?B?bDJCaU5nL3FES29iVDRGekhZN0NvVXZ1TzRyR3F1aVFjclRxcW9HU2VPL09W?=
 =?utf-8?B?MEVCcS9CZWp6TkNYbXlXN3c0SldST1EzYnNaWDJGWG5QRStKM1BGd2hGblE0?=
 =?utf-8?B?Ny8wazAxN3E2RVNudDZtcmhvNmVjbm8yNHhWUmU1TVV5ZmRPaTFtdEprcVVh?=
 =?utf-8?B?MGFqS21xbHI0V1NmQWdraFQzRmhuVzlhbXgvcTNCVDl3Uy9IRHJ6T2czSmJR?=
 =?utf-8?B?NllpUWMwUnZuZVE3MHZrVDcyR2ZhMnUva1VSL3hYRG9lK2ozWlpYdmY4MU5r?=
 =?utf-8?B?TjBQcCs2RkMrTjNEcUozQ2lBVVgvU1lDU1lZSjk4dXdlbEdNQ05pQ2lqeFNV?=
 =?utf-8?B?WDlUMmRQYjZkRklQeHdla2tpRkJGbjllVitaWGFReStRRnpXZHZJQW9yQ3Nx?=
 =?utf-8?B?WTlKNTByMWhFa0ZVTVZ3VnJ6MlZZdnpIUkpGNExTNkduMmNsRlNqM2hOcHZx?=
 =?utf-8?B?VjMvMlhHb09TUW1oZnhNNE84NFYra2RCWnpYOHg3N0h0OFpiRXZQc0RtMXdP?=
 =?utf-8?B?dGhYbTcxdnZYZ2k4UDlYL3lTeEFDcE42NmdVdldoSnd3cFcvSkhyMFMrL2pa?=
 =?utf-8?B?cndicFpObXl4QkxOUlowV3ZGMFhJSVY3OUhlRnVjWk1mbjZPUmhxNHpWZWdY?=
 =?utf-8?B?STRWWktYUjBwZGtOMXgvWkJWa3NiYzZHQ2Vkb3d0U0tpYXlHMTd0Mks3UjBu?=
 =?utf-8?B?T2VXOEg5OTlRYWwwS29yUitYb1pxZUlRMFJSWGU4cXVvM1B4WEY1SHRjNita?=
 =?utf-8?B?OHpJQmFVcmZHODM0eEFQVCsxYkxwbzFZVUsvYklhOUxkanVBTXU5NTA4eWxD?=
 =?utf-8?B?MGZNRnRVcWdIVVpQV3pTMGQ5ekJjOE1nMHVjdHVJc2tUSEY3L1VmZW5ERktG?=
 =?utf-8?B?QWpKSUp4QVFaNXcxUDAycDUzVWVLWWdyWTlBa01wUVM0K0dXTjJqcUx1cGlY?=
 =?utf-8?B?U1Ribkp1ZE9BUTVGVmxLSkpLRHlIVExyL084Vm5aWERYRGw0alEvTyttZzAz?=
 =?utf-8?B?OXRrQ2JNQnVhWXJxRDZHOU9IdnA0NDJjN0dBOC9iNVZkWlp2cWVGSG1vRG1N?=
 =?utf-8?B?QVB1NXZnYWVvRWo0cUYvbjRNRG9LdUtYbFo1SHV4eS9JcE1QMjRoZ3NUTFAy?=
 =?utf-8?B?MXM4YmJLWW9PZ09ZWjgwdmsxVFlvM1NHZWJEZXA4L3lpRW1uLzI1UEo1TERa?=
 =?utf-8?B?emE4N0ZscXFObVNWTEFpcW5naTEvbmxRaDR4U05RVWl6ZEJ0a2JuT01EdlU1?=
 =?utf-8?B?bWFaM1d4eFpZTXVhTFBsemxzb3RqWTM3VnZQVVNkbWNCRGRLcVBRekpBVXR2?=
 =?utf-8?B?cmFxTGxHVGVpd1lkYTUzS1dvUlhuS1pYSGRGSHhkNHNnUEpKVlJIS1RsK0dW?=
 =?utf-8?B?SitlcUN6REQ5LzBnK3JJVlhTOEhCUWhOZGlXMGlMV3U2YjBKTStLTFpDU0NJ?=
 =?utf-8?B?Um1POVkwU0FwNnp0cDFzdDMxaWhncGhYcWlOMGtuSEErbmRKRFd1U01Nd2NH?=
 =?utf-8?B?bGc5NjFWOEVXVWhHOXo2V25lbVpzRWdTZUJLdXorcVJWTkFONmtiaTFzQkFF?=
 =?utf-8?B?TlhnNW4zNDRrU2RsOXk2UjZGc2R3L0xwSXRGUlJHSm9kRC8zYXozT3RWOXpB?=
 =?utf-8?B?OTBlSHpHcGRMbDBHbVZ4WXFaWUVTb0Z5WUtaOGJyamFNK1crQ3U5c0Y5RTVW?=
 =?utf-8?B?RGNSZGZRL25Ta3ZsQjFLanMzRHYvMEc4cTdaWVNzZkZWZUZqRlpJaWNmeGFn?=
 =?utf-8?B?cGVINGpmbHc4RmNWYXFxQS8vbGdyNjkwS2V6SzhZQ1p5WklzSFVTUnh4QTcw?=
 =?utf-8?B?WTcvNFAySzdDSndLTGVCdEVNZ3ZmY2hEOUNGNyt1bjdaNzFiZUJFZEljZUVO?=
 =?utf-8?B?M0x3amdadExndEcydk5rNGNtK25iOGwyU21CTndCdlJPcHl5Q1ZzeWNuQ3ZP?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5B85B368B51BC448DFD8D603E3BC667@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g2zKpSU6ymHZkeS1e+jiRsRPtx/N5BbLNER7SAYSx8DgE2b7O4HAsRgQo+c3VqGvAoCruTmgF0AiOyPvmPgVEGLAasFsw+M0IC91BZjJm/m8KjKW92A4CE+c9/AvUgyocylunGHbZg1rd/3UFPrJ//XgwudBcR1fX0w8IbQbIiEb7mqcGLpvi7h7yVOva/DEH8LKbGxNmnLNiyk5Z3TWiMpedhOW2WWHNu5OhPTAgArRLEF+vKH7dt9/XJpuVjjUXIs1RS9ImKtXmQ5XC0jgA3lSYeyXxPsh+oW8WgSA4LzFfrjMb3rtbCxiAwKx4OBw8jnbl6JglSA6sXBWNktroYfm/oX55SrF90OsiZA8I4h2VXv5b32/rWHlZOSEl8TAlqR/C/zDUV9KRaWicNHQa9NBLZ1SCqHEuugP402+db8UPZaUq9H+px/rpiAvLgESK3CqX7FVPl6Cf5KcmBFKuBTXD+Vvcs6/tTeMUEBCUET2UIZKqZiGf8Wt1cA7NCdYzdoSox04i8VUyEebvfnMb7NYqhk23CMzCYvFWXQq2/s7+po3IFpoKMOs7SVt7HmhOd+W1vPk2/ezBnCwmraS/Bf7q1XhMI3c24FWSl8/aUnUXjr4QyMvhJGu8NQhr/zL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a3c2e4-962a-48b8-0095-08dc5ec2bd13
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 09:42:46.8152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v6bBF8D4GycKGs0IqlGG6YBHhZm6om7raDbrN5SWu+DHwyIpw1rE8VnQDLhlGO4cHjZ81KY9IatFPvP1aZlz2dMQ00Isy5uS9N14jkP2nIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8886

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
