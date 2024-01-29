Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A635D745
	for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526842; cv=fail; b=qJ0sXqqnGH3wd6X7SaSjEQeqzGRZ527kvcicoVfA6kPn4/2DbXK8gIa+JsW2Zekdn+ra5xXKHOAv7F6s8gNEEOY8vb7eyHZE+jlfQaPP9KZB3Re+NdfG7Sc/cVkVdNfM+N3t1KUDUQQE8wrzRnc8LncoDrB2DuZS7UFNtWP/iyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526842; c=relaxed/simple;
	bh=6XweYhY20PAEJkYXSlXC7n+DrR9Wvx6/VD4dRvlpFZ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=He012Fps2GVLomeSFAskDYT/aM3WwkIqHjIaUtPifqu64EWRfg00L9/aaNplqLrOPP0TdJCdsvL9H7RDGkHmE52vGrmjrMWZ/1v2lvwVfGtW9nqvtgna9iFFTm+Uitvnm4A630IOT7pOBS0I8gSJYxO0iB8ysu2NYlHMzR5Ck9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G0xqMNVy; arc=fail smtp.client-ip=40.107.95.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G0xqMNVy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuCP+4mXXcsko7wW00TS1yjrUVsnXbXFfzxPvbFlicdE7ER7jTD9X2pknNOyCXA8pYkZ9g9u/BVcfj5FCGfsy0XPSTb+4rj9JfdOLLmVnJ54ersxbvA9n3lqsEIQ8rja0q6nteUPOLPyj+jszNhicWsPjs2b3Q0qK+OAveArHcRPdRodbbGBjeWfmEJzDhyZ+6cgX3SoBeKztm+QGcPdUrgU/boBlThprW+vklpkrRUvbhYJzpZPGYvgg6cIxvLyQE8dMUV8m5ICEIQI2dkN/rUY6R8c3CfvbC3wxpH5lSdyaBFN+E0aX3ThJhdAnQ9n7CtMMU0+eUXOPGyb9ycWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XweYhY20PAEJkYXSlXC7n+DrR9Wvx6/VD4dRvlpFZ8=;
 b=LeZZAs6mBz6NSENBLyOQ5gqtZWG9OmbdGOmqY8Al3n0T05eJEVg5LNCYEaSUa2+UNZRjamg6TVW3Nx8wH6QFUuuDaCaZAo/fVh8UgLDmph5t8FPV77reDdbXxawrK0wF5vYjpIB8/DagFKEyGyjQfz9Mkygtr6YGmQxosBuj499sol6ZycktDWzro2vokaLqdDOaDsz1Q1hTetvZ+CK25BMljIUBCsKKp4FHEMbWBk/+8xAVUxU1zvDpupZxZR0V3v9Z1zOKnhQKucX7ue0XHTX9CjJLXETcZnHRyUqZlppSrgYc4hFFNNZir7EFo8yhyt3ofbd8Ubht4Q7dywbWzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XweYhY20PAEJkYXSlXC7n+DrR9Wvx6/VD4dRvlpFZ8=;
 b=G0xqMNVyuixNY2A3BBRj0AW9URiCW1da/D2oqt6x0VRaeu0sNGrBNLJ+I7ZhYSmg6yWlQ6WCoqZ+gZ//W2bk3omo1x7GoMeMOsDByW0LvvqdwFvpu1B6XBDt3xiT0GJ7V171pWKF4LAb7s/Fki6OeotvAncMXJZ8PmSpM3XOREcdnhcx+2MXKjVnvscmBp4s1DB7hpAgrCQh0KWi4UKs0GIx3SSFTe6nFmzVU2k9TaFpU0JrRQgrLO0zKQHFPx4YRH2LxL/DN8lsUZ1ZEiEVNYjxrEbFG8EhAcXyWfRUJuDkHCCMlOCpLIzfGSAh8UZ2mf3bXELswE3q52c9DQXUHQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 29 Jan
 2024 11:13:58 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 11:13:58 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests V3] nvme: add nvme pci timeout testcase
Thread-Topic: [PATCH blktests V3] nvme: add nvme pci timeout testcase
Thread-Index: AQHaTk9e4i/cjK9iXUuT16SWhY6WWLDwq+KA
Date: Mon, 29 Jan 2024 11:13:58 +0000
Message-ID: <863833c7-3414-4012-a138-3d44ea44dde7@nvidia.com>
References: <20240123225547.10221-1-kch@nvidia.com>
In-Reply-To: <20240123225547.10221-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ0PR12MB6925:EE_
x-ms-office365-filtering-correlation-id: 3fc54f76-1f15-489f-28b9-08dc20bb63a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IG4N6Y6c1CdnZ1np4wfQx3j1zJocIwZNH2UwcpB1FQfWYmQGLt8TbKORzjYGleORLrB7RJUsd0jTAr3gd/URVjt/OfzvOorAVxeMwlEA+8CgS/BxuCUjMNdaiZGy9Om5v3M2UEbrKlderjg/xBDOHcEE+J1mGIScQTGTEEEmys8TNoSvffm8MWoJXDiOjC3udzrjTAyJ0jQKgWNvSJcGoEzCKLc4j8PYMxHE5jNSOWg9n2x9emocP2aF85u04/bvHQrFCTW9+dUpJH8UwNDZfVvB9inXfp6Vd2YGMn7JWZyclzz3VpT1q7M66brmqzcVkmwM06j7AZcD13YjGbjZDaeCcFmEsgTMkzvBzbPtUkyHOz+WJT2ZpKsVbz3BVNQdjsHB7ZhNM+2B4vhV8H6YQB3ngRSGwrZ0TuQwjAzmYEucP4+5L+yjsJNs2IBZjsF0BevCe1UJpsHWnJzWmPBN04OfctShKMkw+HnVmwk7z7Cre5Xm1jthwyBaGhJH0n18tD33OdnL+eR5TXS0r/VRXOxWR+KBWr9KK3Tozi1ADe4yjKTOq/tvSI3i4eyAKXi/rLN+00TGczmANTFKVSlyWXaNJMLsnlqEgkD1r9UPE+Ryzgm956kofkqzcTA4ovq7GSX17VGZBeVdLPoN5/Su6TkJKhCzaT05Iw7PNY2rjWVNMrPNFwJX/c9uk514LJmq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6512007)(107886003)(2616005)(38100700002)(122000001)(8676002)(8936002)(5660300002)(4326008)(4744005)(2906002)(478600001)(6486002)(6506007)(53546011)(66946007)(71200400001)(54906003)(64756008)(66446008)(66476007)(66556008)(91956017)(76116006)(316002)(110136005)(41300700001)(38070700009)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVY2UU9oTWZoQjRrbEUza0tOanJtMVNBQXFYL29CTGpGTDE4SHpsTVpmWXRH?=
 =?utf-8?B?clNXSm9sY0R0NStWWnJ4NHFpSGpCN3l5WGJyTUZIc0hwM1pjVEJOR01xREZs?=
 =?utf-8?B?ejFWS0RpaVJOc2FTK1h0VmxZVU5BakVZM0JMRlN4Y28wR1NtVGVSckIyLzc1?=
 =?utf-8?B?b2t5ODhhSXZlU01kWWhsdDJZUDZveWZsT0dPYW5WVlVxc2dVanBsckNyVkpE?=
 =?utf-8?B?RUQ0Mm5FRURRZmFURFJiZytYYWMwYTNtWjJHUVhSSUVvdm9NUi9WQllMMGxF?=
 =?utf-8?B?ZXg5Q1RCVko4MHExV0VGNDJIUGptN3h6YzFpalZZMXNiUVEvdVVyV3R0Z3l5?=
 =?utf-8?B?aGF0bE5zZEF1K2NnQlJQbjBBN2lQbVR2eW1jZWI0Q3ZEUjVMQm5IZiswWkFZ?=
 =?utf-8?B?UFFpSFZ1aE5qZGZyRHdaWXl2bVNaMUZZRUlpU2drVW9BNW1BbllpRVJpTEFp?=
 =?utf-8?B?NVZEWkpoTmxpbjU3Smc4bUczdU9DVVVncTdtN04wQkhvaEtFelVjWDNxY3J2?=
 =?utf-8?B?UVZOWXltdVFOYWRDdGFSdERQMWNqekkvcE14SmdiOGJ6VFRSdmZOdklKLzh3?=
 =?utf-8?B?dTI5bkh2ZXdubS8zY2tyUC9PTmp3TGthTllIaDlmTGVRZEp3RUh6Zm0vR3A2?=
 =?utf-8?B?QzhiQzFjZ2RYSW5TMmcxbmM2bW9RQ0VUeklkSjE3ZmlicWZ5UzBiOG9DWDJo?=
 =?utf-8?B?SnNJdE0xdmFqc0tGc2MwbVBDcjRBc3hsRVRYVUxLSWJmLy9BRnoyUlVGck9S?=
 =?utf-8?B?Tmo3dUZoSDVuMlZXWkIyNzNRcG1GNnpVUWxUdnd5RVhCWFAzbzllME4yZ1Qy?=
 =?utf-8?B?anQ1S3dwZkVPNy9BYnE0a0xma1duWmtXNmt6NjRjanN6bGpPcCtyTlBBZlNv?=
 =?utf-8?B?eHZSWnRPYkEyaXp3aVEvSy9FTDNoVkFDbGxEajRPRTFUSWppZ0hRQzVIMWhP?=
 =?utf-8?B?M1pFK1hkTEdHVStMMEJHU09HUzI0ZXRVZHZtc1NQeWpmSnpHaU9FYzNtd0Va?=
 =?utf-8?B?S1NxT04rUFk2ejZaVmh3L2F1NmI2NHpPc2w5QzN1c21QcFIrLytWdXZIQUM4?=
 =?utf-8?B?aWVDbGJ6WUluVnUzMVU4RThFMUpzT0NHck9aL1d2eGFkdHEvOUc5cElhekNU?=
 =?utf-8?B?aXlDajB2ZHNvbWkwK0JNRlU4SGMvRXcwMzg2T0lBZWFqaUZPQzlkN1hCK0U3?=
 =?utf-8?B?MDZTTXZRSmZOQzBOd3ZiSTJKMHl5Z3Nvb0pyMkdQczFYNzZIbGpqaDJpTWhY?=
 =?utf-8?B?c2RPeHZCK3hRVDROVEY4OFYyTlBSUUxpcGp0UFdiMkRoUk8xWkVMVkFWajA1?=
 =?utf-8?B?Nkc3WDcrNmprRXkzNkptUEJMSVZYcytyQjBzM3VGU3gzVCtIbGQyY1Z6RUhS?=
 =?utf-8?B?Znp1cGhuRFV2blJjSWdORTMvWmZQYXR0aUYrZDVxSXovNHhQQ3RiNTE3T1dM?=
 =?utf-8?B?ZUMvZ21OUGtDWUlSR1orYzB4RGtyQ0R0ZnM3bHI3NmdXRE4xYjRkci9oa1lv?=
 =?utf-8?B?OC8zMVBkRDZpUDJoSmRyMnVoMGlNRi9PdDJFbU8yUmxaWHZhdE4yOFZiUDhH?=
 =?utf-8?B?QU96NHpCRzQrbE1Xc0VWZFZ4d3o3T1laUFFmVTFsOTc5YXFPYUR3VG9DT3d4?=
 =?utf-8?B?Q1QwTHBUamV0WmNUMk55NFBBQ0tkbi9pNmhnZnRuRHVmSTZOeFZ4UUp3U2RB?=
 =?utf-8?B?ZDVGeThmNkZIZTZoKzcxZkZrNk9HeVI2Y1hYSFArY1FrWnBKbDJoR1NqUDVj?=
 =?utf-8?B?WnZVQzNOdi9WaUdEb2VMWDFuMzlaczNhcm9jdDRWc3VvNU1ZbjY3YzRDTEs1?=
 =?utf-8?B?UnJMc1hDUEx3allPbUJTYnVEbFM0c0hsTEt1MTZ5blhJb1BQVi9FRjVVUVh1?=
 =?utf-8?B?TTBUREVJanB2RXRZUnpLV1draU13SmZJZDEvVCtKRUJWcXNWR09vdGU4dHZE?=
 =?utf-8?B?VjRGODR6VG05L3dRQ0UrTHo5eWoxaWJoeWE1NnE4VE5wRENwMUhucm5meVpQ?=
 =?utf-8?B?TW1EUWpZWlFHd3pVOUdROVczZVVKQUx2Rk5EeXBYNXNiS2E5MG1UNFd5SjBq?=
 =?utf-8?B?U3BFS1RjYStDb1dWSHhQaHZYcHBxN0pCZDZrWS9jWDdMOWxtUHhWZnJzOFNO?=
 =?utf-8?B?TllWVHNvSVRONm9xUCtlbXRDbkI5MjJWYjhzTEZBTHA5UEdtbWdFT05GS3dW?=
 =?utf-8?Q?qvy+8Ana7XYmkjrV3cUAg87GkrCnfPIFIQVogTm07Gly?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <143D72957BF3B641951906DE8FD8710B@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc54f76-1f15-489f-28b9-08dc20bb63a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 11:13:58.1901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5+wKMffytjjoxJmpiSglebK0EyBtv3TkFNYiG/ItEAOaxTZtXc4NvTRJVRCrY8mEfU0awYB/2SK175iUfqiAHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925

T24gMS8yMy8yNCAxNDo1NSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBUcmlnZ2VyIGFu
ZCB0ZXN0IG52bWUtcGNpIHRpbWVvdXQgd2l0aCBjb25jdXJyZW50IGZpbyBqb2JzLg0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KPiAtLS0N
Cj4gVjM6LQ0KPg0KPiAxLiBBZGQgQ0FOX0JFX1pPTkVELg0KPiAyLiBBZGQgRkFVTFRfSU5KRUNU
SU9OX0RFQlVHX0ZTIGNoZWNrIGluIHJlcXVpcmVzLg0KPiAzLiBSZW1vdmUgX3JlcXVpcmVfbnZt
ZV90cnR5cGUgcGNpIGluIHJlcXVpcmVzKCkuDQo+IDQuIFJlbW92ZSBkZXZpY2VfcmVxdWlyZXMo
KS4NCj4gNS4gU3RvcmUgZmlvIG91dHB1dCBpbiBGVUxMLg0KPiA2LiBSZXZtb2Ugc2hlbGxjaGVj
ayBhbmQgdXNlIGdyZXAgSS9PIGVycm9yIHZhbHVlIHRvIHBhc3MvZmFpbCB0ZXN0Y2FzZS4NCj4N
Cj4gLS0tDQo+DQoNCmlzIHRoZXJlIGFueSBvYmplY3Rpb25zIG9uIHRoaXMgcGF0Y2ggPw0KDQot
Y2sNCg0KDQo=
