Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EB0433D6
	for <linux-block@vger.kernel.org>; Thu, 18 Apr 2024 03:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713409753; cv=fail; b=QGOmDf6Le6C5YvRtotn3ki4cyCDWV0fir/GJgYgBzg4EXs97taVMBRtMvUXbwEbm9Gj0BF12QPb+OXQvBvkU6MPNsL9jWjrvTvHhrMMIkFS4DMRjJXV1V1DtKfZtfmL3cw28AnKFkoOmuOdNEhhR4CpdeNsnt57vhKJXhzYuW4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713409753; c=relaxed/simple;
	bh=17s6esxKQk+IEm7b51i+3Bcrpqneu++OCTzsYCYU6oY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CBGHXchueLi9gJbQxP27pDgRPahSWP10gonNd5Yjv1aU9p2xnUFnW39YJbGmZDByEwEkPzaobqoD0krzYzzgmfYXns7SWuMlVK1DPnnYt4IpZzaNQZ7rWaP1WLDK6zYPMpgtMH5tvqLso0yiv9X37S6Mk3a0eiJHKCMCISaM4Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l9Z51S+F; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l9Z51S+F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjszRD8acwn48iSZrajlA0AOBQeVaCfm0fkPDwm7P1jhIPPz8X/D5NMQQaLwpMb8Il9ubXxFPYVrevoN1KRBgZgk5wiwUFh6Gm8L3wAWBCoZsAHrc/XnZA/Cc009bB5gfVfCjEN7/zqn/puOBPtokZgZEmj3GVc43HjeNrYjxDTOry7tkofMn0DEBJDhYyxinzd5QgNH4nd0TmE+2pHi756EgBvFRlKqojvd0Xb7cVhg0hkkrKcWMN+atcDszwoQVbD6nju3JZDpHVpNAVOLwOOU4/6jTXlZ3aLiGASf2D4RMOkCh9BvIovT75vORYaWGSPV2Dx50sqj/+R/J24GoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17s6esxKQk+IEm7b51i+3Bcrpqneu++OCTzsYCYU6oY=;
 b=OuIfWNIZ+JgAC4gTchWl1Zi5q2Z/6tquS2IlQi5918ZEsBxPCp90cZS4Ve7K3QRewVCn7GKAxN72/pmsfrCj/KroctWB6CaUONEqTkyQj6oopzIsxk2pBcya3gxZE4vezFz6ZOTZvj/OhahO1bwieWlSwCmlRx/mnTqwki+6PMmDDqgrW9GkWBtDe3MLHwpxNUkrBIdUDq67eLjlgDPeyosWn/ECAm57nBhJC5eO/m1YMBHeax6YvJJgHrknZTa9ZdeG7X2hVSttuC6I7MtP37J/bKJeUT4XdZndlSfTG9F8yPfr9v7zX0gn/2BvcLh0cHLO7KpZejPNvVvqrVlCtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17s6esxKQk+IEm7b51i+3Bcrpqneu++OCTzsYCYU6oY=;
 b=l9Z51S+FFcWYmkuWAck33uwDVkGmZ5Pjrx8Aw2xELYWudSzCUNxTaTSZk7GHPoRYyZTsQp8Awo3a4fwtS7ncwHZPKUSzGsD4TJxc3PlzBxxVhjOa//M9oQgrLGExbQeVDNLVvaMFIC3Ir061KUUcPoxEJFzbB7kWhF7yvAQcdh4cXnYeZKc3T3hCgb0DVg4/xtMFAp9BuBZI49Y78mAKu83qMsR8PxRDXcNbgocIiu3xodmSYCEqNR8lDGZ147XEFxs+peFewRCJG1ObxCCo85Vj5qW6MQcmbUMVJref1IiGZqwP819V6FcT6R56OADyb70hhalIuvD6dR8nhNZwpA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 03:09:09 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 03:09:09 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Christoph Hellwig
	<hch@lst.de>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "saranyamohan@google.com"
	<saranyamohan@google.com>
Subject: Re: [PATCH v2] block: propagate partition scanning errors to the
 BLKRRPART ioctl
Thread-Topic: [PATCH v2] block: propagate partition scanning errors to the
 BLKRRPART ioctl
Thread-Index: AQHakNaswdo78fjr8kywxezbCBcI2bFtSYyAgAAQVAA=
Date: Thu, 18 Apr 2024 03:09:09 +0000
Message-ID: <a32face6-ff74-45b9-873d-f703e29052e9@nvidia.com>
References: <20240417144743.2277601-1-hch@lst.de>
 <qesqv34uides7nrgyz3wom2baonvte3j6alnpdrlnvbpzechrp@4v4j6wqut4q6>
In-Reply-To: <qesqv34uides7nrgyz3wom2baonvte3j6alnpdrlnvbpzechrp@4v4j6wqut4q6>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB6212:EE_
x-ms-office365-filtering-correlation-id: 7e700fa9-e64f-46ac-8b01-08dc5f54ea4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /xlN7XNECosjYdrFGuqFDlu2sLDCirSEudCnz4pnS+zkDnwHl7cKkgTMun0zXUKO4hzIlPugA7eKK6bmkyDDVKU3xxXgPFLEKk0w2vZYRNGHu1ruR7XnitOUTcNlENXeocgg68r4xO+9yrC9mllgwvwAFeUx3/3eK/fPmhuRfKG5IaT1ydFh0py+6Z6VYuRUTQJSCLCuq86W1277KtKaLrJHfLlYmZwIQ13bKTwIMCD1WRGLN7WFeo4/2pT44SoKuNtM4XSsxg8kmM8EWqno6f/AxfU4wDRYgsDal0IHnpsWWMi1pJa6j7B9BzqZFI5purL2bgBIrkulh6CvoMLrcHfgK0YvC388Fid8vHlWRR1XHlEnrNUtu5RcJpxjgDXNJGJMjcVzwTNoC0Y8FxN/sTXxQmvtEEssLol6A1Lv9fk9KjW2fe8b3sFARXIVlRSWCabZCxVPNbnVYpZyLYxUnPS/0CLWLEOyC+Fac56A8I8lEeY1RPCF0mNIWTPROGaibM4yQSXygCcOpixQe2+HBzoAykAupjSvRhMTrfmY/k6xNInn4DHy+BSvmstPdj19yXrFs7olGtakwA9GzlqKD8XpZ7JiRrVo6LSLu5AjyuVOWYhpfrBiHPzjghUp3ohAZdlkznqZAEDA6eBZlnAE+HUEvop1wGh5av6zr+LEdbPEJfBZk5lMBCQll0FStIEsAQUgt++jtL2XbNhAIBf++hShIiE2VMOu6c6K9p7AVao=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WnhFMEw4ejRRcU5tK1NNakd6dVRqakp3NU12Vk5ZdnpMVHpUNFZXNWZnSWNV?=
 =?utf-8?B?N05tZkNRV1A5cW5ZWVN5T0FhTG4wTlQ2NUpnNHRoZHBIZGUzSnFIcElBSjdu?=
 =?utf-8?B?SXFZdjJYSmJsQU9ENmFFbEtDZVJ4cU5FRE8vNnd3c2RNbWk5dHovZEs4Mkts?=
 =?utf-8?B?NUxHSHgzWDBCK0xJTm1yako1S3RuaTVud1pBWHNTekxtRm9pYkoyRkdmWjR1?=
 =?utf-8?B?UlJMU1dOQ3R6Ym5NdmxCZERaaG9aVm5ad0J6L2VGVWdvVFJBSDJNd2VOSHpL?=
 =?utf-8?B?NVJXWTBlSmlrT3h3VFd5VitIVE5mTHhMZHpFb3pscmVML0w5Rkg5R05aaHd2?=
 =?utf-8?B?S0p2SDBnQTZvcnlFc0tpRnpydVFjRFNRdkx5dmo3REh5bEM4MWxrVms2NktO?=
 =?utf-8?B?VHp2TGxQM3pycHNVTWlvdjMydmxFdzVoamtwYlRTd2FEQUJ2bmVab2xkOHJ5?=
 =?utf-8?B?cU5uQ2orNC8vWjBCK3FYQkljNisyWXBwdzN0UkRUN1VENXJjdnpHVm44SGNu?=
 =?utf-8?B?L2RSdXZKQTdTVkROWFc0Z3IreU56d3Q2TlB3ODg0c2YxZWJlRndkalFMNlI4?=
 =?utf-8?B?dy9BdWlPdkdMUUNpbG9SQ3NGNXZkclFib3gzcHFBTkNMNXVPNisrN3BLNnln?=
 =?utf-8?B?d3U5WS9wWHk1TWE4WnBLS0xjaVIzME0rMUs3YzI3ZmJ2bFVwSEdnNXdvQnRM?=
 =?utf-8?B?Uk5PamNFU0JxN0tVT1hCZmh3VjFJMURaMUFEZnFjRDR0Zlo4aFhOdzdGU083?=
 =?utf-8?B?R0FEcG1rYTZ6MTFQVGZoM1FrYXI1dTFOM2h3TlA3K2pITzFHaExUdmJndE10?=
 =?utf-8?B?aldoS2NWQnBadS93bWIzTFBkNG5WNUJrNURoZmhtUU0vT1NMKzY3ejI3ai9C?=
 =?utf-8?B?SHdHMVhPcDNNRmdLd1k3K2JGRWN0LzFDRUtPTTNMMDJUTlc0MkM0MnhvZC9P?=
 =?utf-8?B?L2d0L1JaQUt0cDVReVgrMjBCdFBTVW1HcmdiR2pRZDN4ZGcrTFNYRGoxREZi?=
 =?utf-8?B?MStIRXpzd2xWMlRwRnJYSnNVT0JjVndPamd0N0N0b3Q2N1d3RXkzWlFKRDVB?=
 =?utf-8?B?MGs1WnlwTFdTVUY2VGNwU3NrdGxtMVhrT2loL2RFRDZiQkFxRjNLZHo3bUpy?=
 =?utf-8?B?N0E1alN3RE9KbEtwMllUSG5oYWhtTGs1THNkVFliUWtudFpiazVEeGVyc0Fm?=
 =?utf-8?B?L3NKYWpUL09TOWNDNitJNm45QUdMSmNXLzNNWkZUODVBLzRpcHN5ZFc4d3Bn?=
 =?utf-8?B?dnI1UzZJM1JjSjlQSXZZdUFPKzFNckFXbXhCcHpVZmIrV041L2ZDd1Y3ZXhs?=
 =?utf-8?B?MjJhSmxkNG51ejZWMHlGUTNNVHFpVFA1R2VRZk95K0lHd240QW5lbW9RSnIx?=
 =?utf-8?B?YVU1a2s0UExPT0NuRDE0ZXBHa0YrZHNldk10RUVkYm9MLzFaaXR0UkdFTExM?=
 =?utf-8?B?clBDOUFySnFqSnVTanlRZGJkR2xEYWNMWWNza1o1eDZjcWtpOVp4SVlIbmVZ?=
 =?utf-8?B?VWdSeGtMSHdyUnRaVWFlVXVuam1qOTU3eWIyOWpxM0tmcGRpZmtWUjhoTWVi?=
 =?utf-8?B?ckNmK3lXbW9BTi8rdGlvcjJ3K3YrNEJkcitZZXNEay9CVTBuamRQbWFqK2cw?=
 =?utf-8?B?cGwxQ2h6U0swOU9OeWRGalp1dFdydUFZRlBtN2o2K1R0YVo4dmhlNzZkRmlQ?=
 =?utf-8?B?M1EwYUptM1B5RFJUR2s4MjdiWkg2b0tHUjZ1TzdGbUlYa1ZYd2ppM1k0TFN1?=
 =?utf-8?B?MUpoSFg2OUhsazJGRUp4YTNUSmZjYTdLQ1IvSlozZm1FdGZ5UVRmL1pjV2pK?=
 =?utf-8?B?WVRjNXo4K2pGRkpFd25iWldlcW5pVi84SlpYYU5xVDdvWWhxa052djlyRlpz?=
 =?utf-8?B?WnE0QTJUTGRRQU1PL3QvTHllK1hqT3F1S0Q5cThLUGNOZGMyL0lLUG1VdE5V?=
 =?utf-8?B?eG5uUjNZd3ZnTWVBaW9ycEhnOVhXNkJIU3lKK2ZDNzhRSUh2QlZMaG5nQnUw?=
 =?utf-8?B?R2FLY1lVZjhTdnNLc2JycUJ3SE9WbGpYcnltWHJSbk96NFo1RW1VaFFGNTlG?=
 =?utf-8?B?SHY1a0xrY3kwRkl4QnExZ25GYldNdVNURjd4V21obHFuQXQ5OVhnQ3lKTWFy?=
 =?utf-8?B?djVwTk5tRnEwQmdCckExbmlIb28wckQ0TlBmWXMraTJUYlV2WVN6MHFjNzB3?=
 =?utf-8?Q?YQSfiIVmDB9s1JeZsdrCy6mGrBvdfqsTYCUm6p+E9vsV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26CBB89A9517EE4AB01776373F29C9AC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e700fa9-e64f-46ac-8b01-08dc5f54ea4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 03:09:09.2262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zAzohKFUVjGpF2brpzknsXdKxddkum3JpYYi44DaSez3dnieWEWMK+xku1+gCb+0/NK/5PwpL1USBYzwCXJVxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212

T24gNC8xNy8yNCAxOToxMCwgU2hpbmljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gT24gQXByIDE3
LCAyMDI0IC8gMTY6NDcsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4gQ29tbWl0IDQ2MDFi
NGIxMzBkZSAoImJsb2NrOiByZW9wZW4gdGhlIGRldmljZSBpbiBibGtkZXZfcmVyZWFkX3BhcnQi
KQ0KPj4gbG9zdCB0aGUgcHJvcGFnYXRpb24gb2YgSS9PIGVycm9ycyBmcm9tIHRoZSBsb3ctbGV2
ZWwgcmVhZCBvZiB0aGUNCj4+IHBhcnRpdGlvbiB0YWJsZSB0byB0aGUgdXNlciBzcGFjZSBjYWxs
ZXIgb2YgdGhlIEJMS1JSUEFSVC4NCj4+DQo+PiBBcHBhcmVudGx5IHNvbWUgdXNlciBzcGFjZSBy
ZWxpZXMgb24sIHNvIHJlc3RvcmUgdGhlIHByb3BhZ2F0aW9uLiAgVGhpcw0KPj4gaXNuJ3QgZXhh
Y3RseSBwcmV0dHkgYXMgb3RoZXIgYmxvY2sgZGV2aWNlIG9wZW4gY2FsbHMgZXhwbGljaXRseSBk
byBub3QNCj4+IGFyZSBhYm91dCB0aGVzZSBlcnJvcnMsIHNvIGFkZCBhIG5ldyBCTEtfT1BFTl9T
VFJJQ1RfU0NBTiB0byBvcHQgaW50bw0KPj4gdGhlIGVycm9yIHByb3BhZ2F0aW9uLg0KPj4NCj4+
IEZpeGVzOiA0NjAxYjRiMTMwZGUgKCJibG9jazogcmVvcGVuIHRoZSBkZXZpY2UgaW4gYmxrZGV2
X3JlcmVhZF9wYXJ0IikNCj4+IFJlcG9ydGVkLWJ5OiBTYXJhbnlhIE11cnVnYW5hbmRhbSA8c2Fy
YW55YW1vaGFuQGdvb2dsZS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdp
ZyA8aGNoQGxzdC5kZT4NCj4+IC0tLQ0KPj4NCj4+IENoYW5nZXMgc2luY2UgdjE6DQo+PiAgIC0g
Zml4IHRoZSByZWJhc2UgZXJyb3IgdGhhdCBjYXVzZXMgdGhlIGZsYWcgdG8gcmV1c2UgYSBiaXQg
bnVtYmVyDQo+PiAgIC0gZml4ZWQgYSBjb21tZW50IHR5cG8NCj4gVGhhbmtzLiBUaGUgdjIgcGF0
Y2ggbG9va3MgZ29vZCB0byBtZS4gSSBhbHNvIGNvbmZpcm1lZCB0aGF0IHRoZSBjb3JyZXNwb25k
aW5nDQo+IGJsa3Rlc3RzIHRlc3QgY2FzZSBibG9jay8wMzYgcGFzc2VzIHdpdGggdGhpcyBwYXRj
aC4NCj4NCj4gUmV2aWV3ZWQtYnk6IFNoaW4naWNoaXJvIEthd2FzYWtpIDxzaGluaWNoaXJvLmth
d2FzYWtpQHdkYy5jb20+DQo+IFRlc3RlZC1ieTogU2hpbidpY2hpcm8gS2F3YXNha2kgPHNoaW5p
Y2hpcm8ua2F3YXNha2lAd2RjLmNvbT4NCg0Kc2VlbXMgbGlrZSBteSByZXZpZXdlZC1ieSB0YWcg
ZnJvbSBWMSBpcyBtaXNzaW5nIC4uLg0KDQpoZXJlIHlvdSBnbyBhZ2Fpbg0KDQpSZXZpZXdlZC1i
eTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
