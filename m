Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MUfT+bWw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aPtPvSsa"
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952501AA
	for <linux-block@vger.kernel.org>; Tue,  5 Dec 2023 08:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701794047; x=1733330047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yKmRP2pBd20CnO2EpzDhDoxm2HOQsygq0etlrrMuy/A=;
  b=MUfT+bWwtD6EpGcXuQd2kCzQsHMwFX5imN45nYoXUNjyTO/RMR5YqWr3
   W/1hkYeCxmyWNW63S16s3VlfhkXll2XEwa5dDv3/3Go1aa3aEPg+tJVax
   VmaiDD/LBt9jttVEJMhQKrWClxGInxkEUkIIynl2gzKZJ6ePbSJ8bWH5e
   hVcH4eNhzcd6RnGkQ2rK2jSxXH/1p2Amdl8RNsHzGfZY/oeAUnl5Siw5+
   7sitzIzIzj1f4T8oZHgqs2AYvHf6HiNGMqPV9IeCWSodkMydyoE/YeTZJ
   PLsDsK9gqFAUktOG6dl4OpRpp4afnR+T4KA5mlfW76zacMjdy9J1M3kvD
   g==;
X-CSE-ConnectionGUID: +dccPk2cRPKQlj68Cj4ZFA==
X-CSE-MsgGUID: msG1UzcQS26I0UnjTEjv1A==
X-IronPort-AV: E=Sophos;i="6.04,252,1695657600"; 
   d="scan'208";a="4039603"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2023 00:34:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/2TxT8PFfrbLRX5WaslPc/nsIu/OvTCHMzr4iyiZkb9Q2gDJvuCq1WuacS7RZkswAnS/nmnnJvuyitNkgWMGCSQniwMYpfjP4toKNMl1Yqxi5OwgWhW3EgAiU1U6/Fn2bGDNKmWQly1vZnNz6Pu5g074glgzortoV0Xqhu0krMGZX09NALiY8xm84KH1srCK4DeR96UEEi7/ssGvuUzg//RvOq4W6LCdhEpRNiTjBoioUP/pI0BvF4B/XwfMwCPWB54kcEp/Z9HfAISEjvjX3L3/4S2wwfqf74pSjpzcJmre1PrTRZgO/urXYEaaynQrD+wxnp9X8pkb6BzVqBE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKmRP2pBd20CnO2EpzDhDoxm2HOQsygq0etlrrMuy/A=;
 b=SqpjnMFCcehq+Qaxy+JTDPNUcrRcponESnrl09Ge698xElz7AOyd3CSVjn36VPishQi244r1xVOt+xfbS+ogAZoJdizZovmF2dcBB6jNvRBwKaG37XnRj6P79QcJBFkaQW5haP/UPeWh7eL5+PsdhmsZGQ0X6mmdlPi+wq7ehp6W2wl2iJvZ2fqlWAf94RjF2KOZHQWXYqis1ZBT5obSdT9B0U5SkKFzOBE3FkAn5WstlnujcIfza08snBYNbHZEOuzr9qz4FZeJqW7aL+HgXg/wZGDJja3pycmZ3drULitR6C+3xgeLcI6mOG68TCa5QGkoMgovn8kPx+OShg9a+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKmRP2pBd20CnO2EpzDhDoxm2HOQsygq0etlrrMuy/A=;
 b=aPtPvSsa4UusJQVLxS2cOs0VhP9PM8EPPrm/tAo+5uwCQJZ1u0hVSepVmXx//swl39aYd+qgBf3UtPmhWYDLIx7VWHSsSSnW5HYMrIRxD39HECElM22lVesNBIcDRSf4BvechNa6MXwXigP/WVqmfqphswgt/00gMdPYfrWp/2U=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB8154.namprd04.prod.outlook.com (2603:10b6:208:349::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 16:34:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%6]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 16:34:02 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] block: support adding less than len in
 bio_add_hw_page
Thread-Topic: [PATCH 2/2] block: support adding less than len in
 bio_add_hw_page
Thread-Index: AQHaJtg4sGn8p6rUckGb+cPQbK+epbCa5AUA
Date: Tue, 5 Dec 2023 16:34:02 +0000
Message-ID: <819e3e00-a658-424f-9e08-95a670dd301a@wdc.com>
References: <20231204173419.782378-1-hch@lst.de>
 <20231204173419.782378-3-hch@lst.de>
In-Reply-To: <20231204173419.782378-3-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB8154:EE_
x-ms-office365-filtering-correlation-id: 17623b25-4f0e-4475-cc64-08dbf5affda7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HAhPM60Cf4EPf4uTBH5OYoilL6xAXqYNUVHZjkgEBEgy09h++eeKlJRCnrI+k47Kvgjj3FBt+RSIGi+qZEBUovNWw2vklIP1RgW1ZE2UDdt030LuT4RCShMNzn1CfwLhSJvWexgV7eOmhvcp2N7uhf4mbMOlyItnuPdk+HQefYac+tl9GI3fIZmpN/K1FElsWtw+0MiDVaXzqKztKjQT+O2HbvMMe82D4bYqgdGwbMYLnK+UKL4h1R3SLPKHuBFpycpgsCo4A/eCKKxIp4p7kLnhXUwhX8kU7eMB07YbpCC/SZDh0OqOmS2GxgG/99D25YNKmG5gSacnRS16L+er72gtZlZ4enbNQx7FCCcomUinLC6iJO+SWwz2Xt3qVaShxK2ztUMCL8rnEs2pndcGX1w/7Z547bQlbTGKH4NgCMWWLaOff9Iaz4GZAx0sauxs9pEzdmJfBobEeh2a6bC3LEHu0dgp5XzTJFjlX+f4rKpGojR/FfOGKtoyiIjuowH2UNdfh4BIm1mhiCtlK5g8f4ZgDy8WMgePEbTv8f4Hus7Hj9muBUhSIZhWI2OkwY2+56biOA9HBrRiV2aTEnOB8mZQ3GBRc1AiB5LzRhAcppTzAwskvUCgjOWrRKxtv0PQ4i6LlCX+vOUDkHNM1xebn3mc4Rnz+NnC9IW3cVM39IPxaBRpPiXq7hWV+NIPZa/r
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31696002)(82960400001)(2906002)(5660300002)(4744005)(36756003)(38070700009)(86362001)(41300700001)(6506007)(71200400001)(478600001)(6486002)(6512007)(53546011)(38100700002)(122000001)(26005)(2616005)(31686004)(8676002)(4326008)(8936002)(76116006)(66476007)(66946007)(66556008)(66446008)(110136005)(91956017)(64756008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmIzdG1tcDB4RVdSUFU0VnhsUnA4NjhPSnZWSEYvQjhoV2lmWENzM21vaFow?=
 =?utf-8?B?ZkwyMkMyOFBQRUZ4V0dOUWV2T2M4UnhLOC9kM2dsUUVrRGR3aWhtWUVpWWRh?=
 =?utf-8?B?bk9XN2lZN3ovNjZ2STdXWC9XNDcvMm5kNkhpak5wQUwwdnpaelcvMHRMeTNR?=
 =?utf-8?B?Rzl3bWNQWXhVMEZIK0l4Qy9QeDVYTzdHVWovT3VMdDhQazlySE1UdktrZ1d1?=
 =?utf-8?B?aWJHK2gwQmIyZHE1VElkYTdQNjNITFJic0VjN0lvMmhRWW9FRkswQnNpay9w?=
 =?utf-8?B?WHlXMVU4am5JUlh3MEc1VHZUSWZ5ckhWRTVMZmo5cGtNZUlVMzFzYVRIa0tk?=
 =?utf-8?B?cFNUVERtR1Qxc21IZVZ6OThySDdTS2J1SzVITTd2RzBrUFJZS0oweTYvWU1I?=
 =?utf-8?B?bU0vdTZWK3N4WjlWbmxlNUhQcUN0UEYrTkpFUDFVanNQaTc1ZjNWamxMR2dS?=
 =?utf-8?B?WTlMSXpRV2RVUkMwbUlDSGEzMVNCSVc1MjR1cURIT0xjRHNWbjJXSnloYzln?=
 =?utf-8?B?VTJHQURPa0hZVXB2YTR2NkdIUERzcS9YNC8vNmVTbGhwTG5GT3pUZVppY3o1?=
 =?utf-8?B?Zmp3NFdJRG9SZVJKVmNQRjVBUEdCUThERW9UVWxWeFpzcTVCa3FCMHp4c2pr?=
 =?utf-8?B?SWxFVmFHSk91ZWVQSVBHbVBDZ2EyalZocEFBTEVmRTBhNnpIZldIN0JFdUsz?=
 =?utf-8?B?bDVFMTR2YzhNOFJ2SnlrL3NiZEVqNkxmVnV5ODdDczlEbG8xSmlNcUFmOHov?=
 =?utf-8?B?dUVRM0NLQTZGVUVMOUVaZzcwaUY3cXR6QW9NWDRvVzNCWDhJVGV1NmMzblRL?=
 =?utf-8?B?ZFRJTXRWajVMZitvZ0JmeVFFQjZaZXJxWEJNZktSbHdXcU1QM3QvR3AvSTZH?=
 =?utf-8?B?SWFVRURhR0VrdzFXN1E5RTc3d2IvNERzVXdvcnNHREhYM1lmZDFXdXczcWts?=
 =?utf-8?B?NzBCUnZwL3R4YzBMZHkyc3Rmei9VdFBReFVGbUw5aUpLdyt6c1FlV0NCTWNQ?=
 =?utf-8?B?MzEzamxQNWtiUUtmYVNiWWFxOGZWWDlPczBTbWJPbUFIUG5Ydzc3ME9QbWox?=
 =?utf-8?B?RTlCV3prS3VmQVpmbGxqL3JIMjdHZHlnT2J5a3Qxbjh4NU0vdksrdGRPKzhD?=
 =?utf-8?B?RVhQdFY3eDF6S3JsT1JuRkFZMzcrTUx2RzdVTmNmemNwbk5lRUMxTzFYTXVp?=
 =?utf-8?B?SzlHVHByUWNoSnlFOS9uSXRlM3JHekRRdU1Zc3ZBekdScVRSc2NiYW9wY3BT?=
 =?utf-8?B?YjVJZTNSRW9TSW94TmRWanU5SkZrbnR1MXRobDRsekQ0UUZ2N29NNmt3c2Y5?=
 =?utf-8?B?NEo4WmV3a0I2VTc0dEVqcmEyNzNQRmtBQ1Z4K2JnL2k5Y3BaWW05L0dyS1Ri?=
 =?utf-8?B?aTdtRzMrcnJ2cXpXd05qakdZdVRzdGQ0ZXM2SnZLMlBWZ2Fwd0RaMU5TSldY?=
 =?utf-8?B?MU5hWmNKc1RFVHhWaGl2SU1kTjFhSStMVCtiTFkzWVlrajRGOWozWC8vMllG?=
 =?utf-8?B?cWpiUUZQU0xNVS9ueFBTeEFKWnR0QlBlOTc1a2Vzb2NEUWF6dG96YjJ0OXgw?=
 =?utf-8?B?ekd1OTUvVEx0U3ZKa0tXbVdaNWJKckRQTWphMzJkVE55WjhqeXRIbW9aMHhM?=
 =?utf-8?B?dnRwUnlKazU3YXNUVTl0UGxXVHdvTit1bDVSZ3dSZkJvaFNXd0FCQVdOVzVB?=
 =?utf-8?B?TVU5L1JSY3RORDVJWmJ0K3pQMWF4amRwWnlpN0lhK0tEQ2RzQnBvU3NXQnlW?=
 =?utf-8?B?NEU5OVFMeG8xUk5SVWtFdHVMNjdyeUdsQ2tLYUl1S3AzNit6SWN0WDhpVjJW?=
 =?utf-8?B?R0N0R2RNVWFINERXNDlLc0pWYStzRnp5VStqNTlCOUdQNEY5Q2J2bkVOWUVx?=
 =?utf-8?B?MjA1NzVVYlczbHZpcFZEZjYrajkxSE5ieVVMSWdlbHZWMkJuOTVDa2VOYzBI?=
 =?utf-8?B?cW16SUlaQzRXSEdoeThzZHU4eVEzdEhucG8rK0RwY2dmQ3BHbnU2QllzZWxZ?=
 =?utf-8?B?eUNFTlFxaEtaZmh2Rks4Q3gxMWp3Nng1YVRkTXdPUFRJV2pBalRqMUxrckFy?=
 =?utf-8?B?aFZ1bmg4SS94SDl1dDFEVTg4VHFCU1RwRUlrVFlXejBWa3BFWURVejlXL3Nh?=
 =?utf-8?B?R2FBNWRjd2RCSHBlNytDSHlIMEtWcXZrMXI2NzBJdVFQd1lYb3FxYXo4WTlE?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBDB14FD6BD5A94EACE467547DD40B24@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TwXId+PMxTu1xQ4BiCknwlnam5rTSa/H0vAP2kVoShXw3gpYymeEV3fh86E57fBa5iqri3RattAck3X0qEzt6ALbN2uVdrU/5JqepYR/IMP0D0ZfJGIWinQBfIPmBI/eX1+m0egBEioH96ALAqmPELKy4oAIZoZZQtdYzv0jOAGEjZ2lGjOGTZFIh8HzjUReuYzWbTSLBhJpz8pSasv5trafTfSiH0kQ+3Maxmxb2CxkqFYLdNHl6PiEUq8duDilFEhd5wB6lWUXS/pguaaq2nF2f1ToUyww0H1sy/JSrsWXXYjgVsYTbBvh3fpffA1ycNMua7kT9vkhlzjVGCB1LST5+tllRU09kbr4hVEGC8/+KK8QKDzTWZZ//3VqJp2vhKYjzCK/czguEecOQK6qFA8c0fvuYZWwiAPkaq5M6PVIesDCWgFF+mPtuSSCEJge0FD/Th6+XNJ3ZkWl1CoawvrlSPQAcMzuU9dsgBwb4zODFJ7aKOKU3zYViwEOGLJVVtWCH+5IbNsqh6IVRYDB/IvgNl8uKE9cBrZaaumBQ/knPky5EvDlZKgCOjAjpVsg348kEqXK6RclIGrlD76DxIATP22bPcJhzQOd9H9Gwe6xwG6zyvPai7xkriniCXs0V9t78w5s3oK4Vu+xwQb4GhZq+7bLgF//fbRdo+Y8t4LmEQkmAHgmhmDMDs9986VgARFwGjIZmDI8traNNiqoGliRnudjSxxVFkZXxgaUirsp1sUyU27Dl/cKi75ejQi8O7tVoxTWPgFi37xk5OHUKhKN1KoIzz7qoydL02lx8RaINUSOSxGoEcq8yob5ZTkajvej7O1ROP+iS6ynPtL7Ag==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17623b25-4f0e-4475-cc64-08dbf5affda7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 16:34:02.6408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJGfyFQevYNOESnOknIx+63M7iX5jyOJuCtW4eK97VXFYhXdw0AGiD3lOmlMd8kHeQIp6W6Z1atfCyvaNCNhheG8zyniXM/KMLkRYeup96g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8154

T24gMDQuMTIuMjMgMTg6MzUsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBbLi4uXSBBbGwg
dGhlIGV4aXN0aW5nIGNhbGxlcnMgYXJlIGZpbmUgd2l0aA0KPiB0aGlzIC0gbm90IGJlY2F1c2Ug
dGhleSBoYW5kbGUgdGhpcyByZXR1cm4gY29ycmVjdGx5LCBidXQgYmVjYXVzZSB0aGV5DQo+IG5l
dmVyIHBhc3MgbW9yZSB0aGFuIGEgcGFnZSBpbi4NCg0KDQpXb3VsZG4ndCBpdCBhbHNvIGJlIGJl
bmVmaWNpYWwgdG8gZG8gcHJvcGVyIHJldHVybiBjaGVja2luZyBpbiB0aGUgDQpjdXJyZW50IGNh
bGxlcnMgb24gdG9wIG9mIHRoaXMgc2VyaWVzPw0K
