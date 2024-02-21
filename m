Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B24D3A8E9
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499549; cv=fail; b=j0F4wRIFAqNlPY94NixC8/L4Lp1e/PqgX/TmDGoZWcn9G9oav21jk7Jh/1a3l7vly+TPgvXb2zePrED8QF/ZKams95ygE6VUWiqI3KdJG91jsNFhrFb9kcfGrioXTui4pruo484ET9aKrYt8msc8o4jerCAlQ7GgBBi4akm3gSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499549; c=relaxed/simple;
	bh=5Rbwi0u8ADkLrcLKRnT9qYjucWGElTi9NWy8daoyuDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YV75aydf8WQ/WeQrfo63H5XnEPuzSVr9TGnCtJD23UKyMDXakl2dsSYL8wdMRST5I10zRjSbxXpaV4m5eRbGz9WRh1d/f9Hfs0/xhgMtLF45AcImi+URTga6h/M2ELVX6xOUqSR0+D1PFVMehgwkoIHVJNyx1APoffm67azszHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oEK9/UI4; arc=fail smtp.client-ip=40.107.212.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oEK9/UI4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CasjoMwYUK0GWqGayVbLrw3rE5iMuPgpEXNQ2eMYvT33tw0prhPHrX4HKsPqHsCxIbR3ZWx3BEsPzcbGpgXVeyIJteoAmMH8hbxCKgostBAVaz4d5QTZ7DzgN4EkL0mXvu0k9TXoNqHmu9HOCo9/UWdsiJB9K5YwC+Zy0hbtl/1SAMrVJCBtg4HK8zNb+SYTkU67WLk81lmE95sSTgaBt3mX8dwRBgrebQ/71EZvksfmUNkbj7cmIGVptsa60KHkv7OaLhzlVpIPmIFCdCv/VLf9Ip4RJr1tIrPbZFZCAEphAjrUrvA5n0YIkCiGsYGfVJ920MPzWd2HXfGUn0dE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Rbwi0u8ADkLrcLKRnT9qYjucWGElTi9NWy8daoyuDI=;
 b=D/eaKSReS77jmw+AVXIaaGhebKjanNAkV4muN7Rm64xnq4654ubHHh60nHobL22zm2vX6BW18gtK9rePRVMXomRzc5NKZ+1gwIV217IE9h3us2brMA7qfMdCVGsTFa6PtRw3GgZAbRTkvYSDc0oZhnWS+ZSCfOaDe7YOiZY1ta3h/PQ6fPFZKYnMuZhFzsYuswCSgvU+VQkCJve5AciuWxTQGG3xLfa6R6+btG3w5ZNXFjDtIc5ZNnALO+nLT/eoVJoW4K/FS4mPEf65bPoYF4w4NBpCGdXqJVQQDRafHzYWluCJCgXE9kilWNU7B0MPRfw0C6Cl30UHsAgnzQ4QzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Rbwi0u8ADkLrcLKRnT9qYjucWGElTi9NWy8daoyuDI=;
 b=oEK9/UI46LlYyA7E17fGK5NKr9oV9o2ChqJYk/qW54njNZrtvgYPgYObTywIMQhYpJCDtJHU4wVMTKSXcpFtsXtCzZJJitP9couQVmlBSRhLZZXKBAjIxbbl92Dn31RFwJ79PJdAlxyFtUo71Sh4fSVDOyYM2lzPqifW4gN5gcmx6pWcKugAVvydnl92Bu3Qrklmv0NOc/pc5EMF4L5deiM8tt3TorUnzMcYbsTKkTqnNjBTJbFUCs4Xj7QMImhBDdba/0YYByOB3MnwGL09LlRPmf5hoFz7jUI+BNok4T/65yw6B19sVIaW0jHo3ofOffv99OnVmHquBnl1FHKMXQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ2PR12MB8035.namprd12.prod.outlook.com (2603:10b6:a03:4d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Wed, 21 Feb
 2024 07:12:25 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 07:12:24 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alan Adamson <alan.adamson@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests V2 1/1] nvme: Add passthru error logging tests to
 nvme/039
Thread-Topic: [PATCH blktests V2 1/1] nvme: Add passthru error logging tests
 to nvme/039
Thread-Index: AQHaZFSjxpQO7u4QgUWICNWj9DVuRrEUYfkA
Date: Wed, 21 Feb 2024 07:12:24 +0000
Message-ID: <9f3559c4-9b98-4cee-b7ff-8851fbb34cd7@nvidia.com>
References: <20240220233042.2895330-1-alan.adamson@oracle.com>
 <20240220233042.2895330-2-alan.adamson@oracle.com>
In-Reply-To: <20240220233042.2895330-2-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ2PR12MB8035:EE_
x-ms-office365-filtering-correlation-id: 4e84723b-9bfc-4cc3-694c-08dc32ac745d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AK2cnyJOVgR4XKzIL03BAgfGlhYrfqTrYzEBV5yxOWqmkQry7OF0t86gq5TSTcGeZoekAiHTlZLSXCBW7DmXdbhdNa99mlOxAid5lvGN48PHv00j3gm6yHmnVnfCZZrgXxl6vQM0p/srPDwpCKAV7meWKvDH/aVXGKQaMtJK17NmYhMZU1FwvXP5qQNcMrKZFJJWao6/UN3BaIyvMmSLyI7LKi2HsNW5788fgnM702qNtdD/mawak2CfeFV4bPDTE3WL5rtei9XKKncofdOZssxnSpzSexOkRGbIc9szMau4qyqYdmfO+CMaYm/qALyEUFS4xs+qmh6zOQNYpTP9wR0y59Bz4/0uXAwwC5irejdD/RKa1+vhzVHDcr7SMnAt+X/OFCSytte9fPoNR5TvfjYelzmX9C8wdcnRlpC/1B8fqENr2Ks+gfn1VvwBMTOYxz/Btb2j36EMZPo/ZRS2otKCY1p5t/OLMK5CNWEMForrb819e/0k+eCukxp00SFncASlQ619DqwfjZ+wnWmsNNF9KhhPrtp9SGFVKH7D2UoqeQ+WbnL/aMyoNT5N3saMKp8hQKEWWRsZQ/Dnuyl0uvrRvfudTfBRnYYoeUxGXIbc77Cl8EpYubRpOswLOV6g
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UVNkSlV3TURBcTZFRmRhUXpYeG9WZVRuV0tWeVp4bjN5UFZuZlZWR3R1anlQ?=
 =?utf-8?B?MUpEMjZYY2FYN1NtTElCdjBCUmZzNHUvY09vbjA0cXkwbDlYYkVFa1NPMG9o?=
 =?utf-8?B?ZWJQTkFOeEUrUVhKeHZ0K3BNaXgvUUZsYUU5QWs2Z1ZDOWxjeXhKcVB3VGE2?=
 =?utf-8?B?RUF4blJ0bUxteDhqNy9RRWhJM202RnU2dDF5OTFTZ1FzVWdrcWgwcEltanRp?=
 =?utf-8?B?V1hSQ3ZCSXhxS3hzRSt6ZnRYVFhyTVN5RmxJanRCdzR1alA0RnplS1JxNFIv?=
 =?utf-8?B?MEtQL0hWeEkyemJGbVRzTFltdnNNbkJpdDRJVk1qWGJtK3dBajA3TWU2SkFR?=
 =?utf-8?B?dVpHclJPVGIydEc4aW1kSE1lakFEMHUzRkVXOGNCaDFyT3haV1p0Q0JZODR0?=
 =?utf-8?B?dUNLRG9HNmdranNJc1doVkxBUkVzRjFkQ3hlM0NNK2dPVklzcUZMSmgyQjBX?=
 =?utf-8?B?RzI0ZkE5MUdqRGNiSEFZOE01d0d3aUNUN1YxMEVMN3RJN2J2R0RHZ2lNNlA0?=
 =?utf-8?B?SzhaSURUK1ZFb2daYlpobHZXZURBd0d3UEo3NnkwUWQzRGJmanB0bzBkTDhB?=
 =?utf-8?B?VVo0bEZFb1pWbkFjckpVanZVcHA1ekRSRDB4OGZBWFdhRkY3M09sTCtPYk9t?=
 =?utf-8?B?OGF3VWlxaWs0bUFUWlcrY0loUWpra0duVVk0TUR4bUZHMys1dWd1bHBmUnZv?=
 =?utf-8?B?WmpUcGlSWlBmZ3piSGhhWUJoR2dXeTRKU2xWUnRFOXluUmF4U2VjS1lwcFM2?=
 =?utf-8?B?V3RCNzR1SkUrd1hXSUZVOWFnWWw5bUdhbGxzWFBqdUdqMzY0cWlkRVhYNnZK?=
 =?utf-8?B?S2ZrSUpVQUg5dGhORFZoemE0c0VPaC80RDZ6dFVIRTJFOG0xUWluN2dTSXow?=
 =?utf-8?B?NzdCZEYwckZ1YllNQVY5OXpOWWhHWEp3YTNjS05vMlF4eUJRUjZOalJjQ3kw?=
 =?utf-8?B?ZDg3eTIwcXR5Y0dBRlhFRGw1TVlYSWdhNGltcldkWGh5SUZnMWpKcm9PY3N5?=
 =?utf-8?B?ZU0yR0paSExmalZiMVoxOW9nenhmTVpEK21JYmVhbng2akFMallGYVdYVTZm?=
 =?utf-8?B?TlUzcng0WjBPWGtKem9NVG5aaUVla29UVnE0eTBFQk11U0ovdnE5UXpsbmVJ?=
 =?utf-8?B?RktxZjJQUDRKVTNIUWVkclZnb2djWUxVQW9YMzBqdzhpZlBGMXQzb1plYW5h?=
 =?utf-8?B?MUpHWXlMdVJYKzZqMWtVTytoTTVEWW1IQ3pldU1NYTk4SmIvZ0FuRG5lYm00?=
 =?utf-8?B?ZGt2TlNKbUNubG5PMlFsbkhSVy9wWDk2SE1OVG1wTjNxWXNvTDFVSjM4czZJ?=
 =?utf-8?B?cEZ1ZElVejIzUzJ3VVVJNE0veE5sSFFMMnlxeGNzMllMdVQza0JpUjhJUnIy?=
 =?utf-8?B?aC9XN3lYZFB4Z1BsMDAxaFAwakF5R0JwOVJSWWVRMENhTGI3QjduL01iNkdl?=
 =?utf-8?B?UUQ2clVpdWVBbWg0RXIzR1RLN3JZVnkzRWVJWmxka3oxcERWdFpQZW5LMWFq?=
 =?utf-8?B?czdCbEk0d095aHVrdUxvU3lQaW5GZm5QUks5eXExa2hMelNYcU1ybTBLRzlY?=
 =?utf-8?B?Z2Q5ZkJYNmZ4WFJWR3gxcCswTlZibnRFMWxicnNuM1FPM2Q4dHZHbC81TGx0?=
 =?utf-8?B?S3Y2b1k5NDU5WWZXTjhndGhmeXBxZ0h4SlM3SDNIRittMzFINzAxOExnNnVJ?=
 =?utf-8?B?b2RJQ29HdG81SnhQSVRpRmwyUHlQdCtRdnZRMTBhZjZhVHQyOWZXa1pnVU10?=
 =?utf-8?B?UnVueC9PTThNZlA1QUozVDFlWlhqWGx4bzFpeFU5K0lEZ09zM3g5TWxVNDlP?=
 =?utf-8?B?TFJlcW1WNDMzRnNkTTV4bDdFQ2hqWmxoTnF0bHdyVXF0UnVKTXFwd1pCMU1E?=
 =?utf-8?B?NVFZYTNqUkd3TGJmaFJUdFl1MHFWUUhOY2NFd09tRGVjR1o3TlF3Y0dMQm5p?=
 =?utf-8?B?cXRwTXZET1BhcnNCTDZsS01TbzdtZUs2Y2tSeDYybm5FeXJBRitJenBocDRj?=
 =?utf-8?B?SWttZWxWYUJCWHg0eisrYUJKalVHUWRubnIwUmp0SVY0cU9NVHZQdi95dmgx?=
 =?utf-8?B?cThUUFM2UG1kaEJobUU0N29Ic2wyVXhEcFJnbXUrUzAwaHBiUm9JbGJiTE5S?=
 =?utf-8?B?WTZyYVJTNWY3UnJiS0dVaFIxVFZKV0dBZlpucTJtZEVFdjE1QkVkdVZFN3ZO?=
 =?utf-8?Q?lhQ/RcrZYbtyvYc9r5VIy3Rhv5ebdXlqwez3DjTkNCDj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D233121B27178E498DABFC0B8065A1B2@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e84723b-9bfc-4cc3-694c-08dc32ac745d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 07:12:24.7268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h53dTNie2lU2bCfSiLF57oZmQ+MMLPG02+UItlcHQsS8GE39CPKj/uqBpo4rxQngL5fysYoa29ErwlONkTJ90A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8035

T24gMi8yMC8yNCAxNTozMCwgQWxhbiBBZGFtc29uIHdyb3RlOg0KPiBUZXN0cyB0aGUgYWJpbGl0
eSB0byBlbmFibGUgYW5kIGRpc2FibGUgZXJyb3IgbG9nZ2luZyBmb3IgcGFzc3RocnUgYWRtaW4g
Y29tbWFuZHMgaXNzdWVkIHRvDQo+IHRoZSBjb250cm9sbGVyIGFuZCBwYXNzdGhydSBJTyBjb21t
YW5kcyBpc3N1ZWQgdG8gYSBuYW1lc3BhY2UuDQo+DQo+IFRoZXNlIHRlc3RzIHdpbGwgb25seSBy
dW4gb24gNi44LjAgYW5kIGdyZWF0ZXIga2VybmVscy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQWxh
biBBZGFtc29uIDxhbGFuLmFkYW1zb25Ab3JhY2xlLmNvbT4NCj4gLS0tDQo+DQoNCkxvb2tzIGdv
b2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
DQotY2sNCg0KDQo=
