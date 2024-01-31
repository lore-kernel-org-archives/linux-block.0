Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E73039AE0
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 23:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742623; cv=fail; b=dDPEtjjEy+GHAYhdXWejoGM342i+W1204IvlEn3O1KSfSmiPyh0ApKfjnvMWJuPV8klLKdoLfEnFJ2HQOhpw6og5iWYqbDric483FlrXXSS5izzryoub7nQUrLSn9j/g2a0WhXTZH2CGWr/m5PxP7UMtTYRWYodH8fBY/wX/Fk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742623; c=relaxed/simple;
	bh=6RYGTSFGqbrxyV6IP+CPwqcs1x/X2dCodnt54JZ6h4A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WZJwPRb0nzCMRkH/yZO1xZmwIFZpEABgkiIxN42z4Ne5T1vO4iMK8oVXik4IqPiFA+qzFZEXGIR+/l4WD29GroJEp8PPuv0dp3wsK88sMg0b7mobVjJfpdh7mWHDEVbs58dorRUGZxqKsqDOqK9uyFL/m/BHYYtgB6WT5XtvdMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fTNB+mI1; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fTNB+mI1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdAN4kF095qAAR+rTPR+hX1WwH4MaZtkXElIJI0ShwFrvh5dZzkbBvsCWIvZ35n9hu96iIkAZwU7gVNZXVyTahs+FP3Xfu1VkgY/oF2aKzahea1hs/iUYb/t9CYdymi/CFkFNYf7ikkDAGoiZHt8oCTEHgmpKUwbxzrYkiXH8FQn/0liiOwiXAyxIVazKKkccYvm3/dygvdDm6TC3P6pCdEho0nD9pFgR2O6U6vI2phbaVMi2jhzymMw9as+GoYXmuRYQHQwyISbBOJ5LL174Y2mJ8Wpi8HeTJd01Hlx/4mPBWF8tIaIR26+RtnPnaOTp1Q0aFq4hKP5+GijT1F6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RYGTSFGqbrxyV6IP+CPwqcs1x/X2dCodnt54JZ6h4A=;
 b=UKMl8stNjd/N2hzS0sk7WA7CYZXQ/48G7HbWXiW76UQUXtFLWo7jUpBjwknK/qKkd+Fy6LW3+njXESdo349j1jEebQQWChb4nzgyz5u7op8WS/DSGNmcW0/XYNviTJaD7ojo0yVT0GFSk+9FuOfetFjoyAekKeSPSLJlah/xFdeUzVfCyz3aD/4litn6HH2xT535ctRPh4cXPuTtPO5satwy9lTAR0Xd2QZFcGlAKnGbVHS3JIfJeATTDpo+aOMy6ro+VNe6t1caoEAV8dRGU/+Ftc57cWnl/6TTyUIssJ+c/7QzZNhGHsLGVSsPLJWXk2PGOzMPu1me9OvXht/6lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RYGTSFGqbrxyV6IP+CPwqcs1x/X2dCodnt54JZ6h4A=;
 b=fTNB+mI1Jt60VrS/P7hZOKsA+YvPoroGz4bMzZGosERPWUbv5XEXsrT8ByiK07TYxN83B+YZE4XmU2eJVdAGYDW3VG6uc/i+MByWWLUPW9Ocxx9PGEBvCak8uDd0M6PN3Cd6io53fZUfJrXPj5ffvrwCRdGsDFPx7PNEQi7KegZH3vlNkzRYY2lS25YlRoPE/z4ikcpQ5cQ6Do2/FnaRk840YKObfZBRk9KHWE5EBZZiXJ6AR1tjAcqQPb3VwoFxkybkE/IITsWVP6cxR/YYW7VzKOgabbgxQe01BH0fbSul9mB4kwPlZ7tL2icRmIfYsnKHrke8T1t7a0XLYjKm/w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 23:10:17 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 23:10:17 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Damien Le Moal <dlemoal@kernel.org>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH 01/14] block: move max_{open,active}_zones to struct
 queue_limits
Thread-Topic: [PATCH 01/14] block: move max_{open,active}_zones to struct
 queue_limits
Thread-Index: AQHaVEYG9vIPszc0h0GrAkGzSDKvFLD0jMEA
Date: Wed, 31 Jan 2024 23:10:17 +0000
Message-ID: <dafd9deb-86a2-4ad8-b565-7d5bed67044f@nvidia.com>
References: <20240131130400.625836-1-hch@lst.de>
 <20240131130400.625836-2-hch@lst.de>
In-Reply-To: <20240131130400.625836-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB8496:EE_
x-ms-office365-filtering-correlation-id: 113840a8-69a2-4b17-285f-08dc22b1c9ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VAaPNnaV3UYrriIQbcIdpUseMioqzdS969mK1Geib/89UOZG92EHuBe1XQESCiv5caAKXAMgRp1GTM0XJs0qjTxNjFl4CM++1PfaTkJBUTxHWpBSCHf+Kpe3dzocdckunYSic2EeU9YTQH25VbM6cKJ8wXbNoOZqGtl/dzfWHOkhILjY+NahhFxL9C7s8qT2i61LLUY6lf7p6+LBfN4/KDPGC8OsWZ7BiyE4zLYgoGkQueHZaOtZGSYcYIpAqa8QWjY10qNIUxnzBoFQt3Vk0zgOQ0wDP16v2bHfm/mAu3+GvFV2MQolXbmZ3fNNb/O+vzUn6TuZC+ZWut/31rgS4jUizMSwLAdQGKYQid1B3q4wyaHP3oWfiYU19eGYJCrxioY57E9Oq/QAi8bqerIy9QJzw4KGo/Bh/DWhUCP8q4Oj1eMR6q39TKLRH77asnwRXXzjzwRdDJoVNg53ssdhF3UTkmg0TxQI2/2L3P3SDFWkmO0KxJCvaFTKFUO7KrKC7cxfNH168+NtFjq0UAZZ9gxgx+kQsj74N+BFYLHoDECVVr1noy6zyeBjxcEMawrDBcBkfEERQw6QJJkaOmpNPZNiJ5hfT2xUB4Dz/QIOSS/9lhCQwRT5wl/WqBDOgMrY3snRtJbKh4+/xawL8ftZpuWdACdDbIiTGHxNH/zUOcKTczRbgGrOEAZZk7YFu65Z
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(41300700001)(2616005)(6512007)(38100700002)(8676002)(4326008)(64756008)(5660300002)(66556008)(7416002)(8936002)(478600001)(66446008)(6506007)(2906002)(6486002)(53546011)(76116006)(4744005)(316002)(54906003)(66946007)(71200400001)(66476007)(91956017)(110136005)(122000001)(38070700009)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEtacUJaWDJQV29OcnI0ck9oKzRjOWYwS3BjeWVaT2VLYVdqalgrZ3pnT2Vu?=
 =?utf-8?B?UzVRWkJxOTFIQlR2T3ZzL1l2Qy9QVVVJTGxZUlprOWhxUFROYW04ZDdIYTNU?=
 =?utf-8?B?ayt5dFA5UFNQSDV6UllOQVhSeXlrTlFITTRLL1pkeTNQZDYraDRyUkJFRFQ4?=
 =?utf-8?B?UHNzejl5VEZGZEE0bzlMYjc3Q3NZMkdzZmNYcGNrNDJBWXFJK25DaWNjNFpt?=
 =?utf-8?B?V0JwRWd6TGF1aUwxWWFXTDBIYVg2N3NCLzJESGV1MlhybEhTWE9DNENMWnU2?=
 =?utf-8?B?b1AydHNlNENPSkhtZkY1bVI2Mkt1NC9EazhBMUhzNjg4UkJaRzliVm9GckRz?=
 =?utf-8?B?ODlTQkR5cHRvTnNWNXhuSExrZDJOT3hwSi9iZGEweFhvZTJmeTAzQXkwV2da?=
 =?utf-8?B?V3R2R2d6bnVIOUNLbk0xNlh0b1YvNEdBcWVSUEJPSEJBbjdoTFpLajhRRVF1?=
 =?utf-8?B?YUcwS2Rod1FmeHVBSEc2SURPZnl3TWdBd3ZRb1FaZjVkd2pGYkJDTVpjVzNv?=
 =?utf-8?B?TlFSSWpxSmtCRVYvUWNDRithRW82RTB4MmRaVGR5b3czTzZiRWJoNFU0dUlr?=
 =?utf-8?B?R3JxbjdXQm1SUFRZV2VGRjVXNjdyV1E1emtkWEN0am1ONmVQRTMydEo4WGk2?=
 =?utf-8?B?cTFyVGh1T25lallhVVRlakZrNWxienFJYzNINmppMXFSdDNPNjIyZXkxSjUz?=
 =?utf-8?B?RG1CRS9ob3A2b2dLYUxZcnkrNWhoWnVqVk9WWnkwYi83MmRnWGFmVE12Z2Zy?=
 =?utf-8?B?QVRVMitwd0RYQjVXMnZXSkxnSGNvUWtJL2ZzT2tuUEJmc0NXVlN3UWx3OEhW?=
 =?utf-8?B?V2pLREs2V2x5MTR2b1JRMnlHZmVpSlZic0E3aDNWVXZtOHhZZndzZWEyTkRP?=
 =?utf-8?B?R0p2RUhMYVdBRVJjOWZXc3FrWFFFWGZtTGgxbnZUb0RtUy9JN2ZrUnRKb3ZS?=
 =?utf-8?B?YnZOQmd4dWo1eHBrOTJsMHkxcDgvdE1BbHl0S3k3Q3Q5VTJ3SnkrK1pxNjN3?=
 =?utf-8?B?R3lWbi9QZE0yaFhLaDlibXI5REUzVmFaV0lJdkdiR2o2aHRyQzZIWkhzcGtU?=
 =?utf-8?B?enV2d0oxZmlnRURiYWcvTVkyOHZjL0ZtTE5KMGZ3blM4V0ZMUGZucmR5T2Ju?=
 =?utf-8?B?RW9iSXg1b2lLVm5yYzVyVVBFenJsNS9YWVRXWnNHRXJtN0xzZlhKN3lpYkYy?=
 =?utf-8?B?RTBQclIyUHV2d3VZNGIwNEE4MXhjc0pHSkJDUjhmaFY2VTlxUTZpWDZIek8y?=
 =?utf-8?B?VWwvWDVCUDFvOEszRkJFczQ4UWRqZFNCWkdURG1kWTljb1dOeitLUmhQc0pw?=
 =?utf-8?B?aU8yK2t1ME9GVDQ1ZnFqUzM4QVpaSnAyMjl6aHgrNzBwTFpybk1SaHhBQ0RQ?=
 =?utf-8?B?dWx6VWkxQ1lUZ1UzR3pwcFp0OFdJMkQ1ejFkOGtJYU0rbW4rdG5IQ2s3YnRo?=
 =?utf-8?B?eUVqUW50bTVMQUdzZzJ2Y0luVU93bVg4cEJxREl1emFRZEZVQUMvcWF1aEVZ?=
 =?utf-8?B?K0w0Um82VHBES3hvNzhFQ0phNmdqY2VFNng4UzA1YU13RE43THBuRGRnYTFX?=
 =?utf-8?B?cXJYVHZzMU44V2h3dTFGc2dndjBYQ1BkMGxWekZvMzMvRmpadUI2NG1ibDdK?=
 =?utf-8?B?N3ZGZGMrQ2UzM3ZoVTcvOEQrNlZmUmUyYUdObDFsTEQ0K0d5NnoySzFRVkti?=
 =?utf-8?B?REc2TFBVbVhtYWozSUpLZmtGV1JNcVJ2U01hb09pQlhBWHlaUlE5UGNxUWc5?=
 =?utf-8?B?bG9BblVWaTJFRmNuVU5EMmNhK2xGRTFRQkZDanRsZndzektVdGxBbi9XTnZw?=
 =?utf-8?B?cXdqeEJNTmdNQnhrS3ZlR0ZkT3JkeVZTRkQvUmhhZXFjM2YzYjdXa0JpRVRp?=
 =?utf-8?B?VDZ2a0N4dThxOTJHVFRNV0hMRktNS3ZXM0pxc0R2NWgxVW9rbndEbU1DUFVu?=
 =?utf-8?B?Nk9laEt3RStFbXQ1RXFPM1JGRDdqU3ZNa0lJYzI5aEMwSURiRmZmbTNFZ1dR?=
 =?utf-8?B?bG1nUVZKMzNDNjV4eVdtTE9WTjlJRkxtQzFFMUNEWnRMaVBHNEQ2QmRJcXQr?=
 =?utf-8?B?akttcWkzdUpUMExzbFNEUi9nUDJxQm1RcmpsT3d6bjRobCtxcTU5a1MwK3BC?=
 =?utf-8?B?YVdVMld4VjZ5cUdGRzNKWTZXYWprTnBaUExLdVFSOE1tS3JDL1hXOUNxZEpW?=
 =?utf-8?Q?4huEDHlIem2P5mmVwPeMR+xK0QADJgyXHM2olYA/Que+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11C512EE33FF7F4F9C74EEC094FB26D1@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 113840a8-69a2-4b17-285f-08dc22b1c9ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 23:10:17.1652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBWD1xRQ3LvbV5iNc1FylFAYReXZgdAhbkH+xMoI/qH7cPbz+9UaY5la9HS3dskgdt3GcbOkzJqn7fej/+cBnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496

T24gMS8zMS8yNCAwNTowMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoZSBtYXhpbXVt
IG51bWJlciBvZiBvcGVuIGFuZCBhY3RpdmUgem9uZXMgaXMgYSBsaW1pdCBvbiB0aGUgcXVldWUN
Cj4gYW5kIHNob3VsZCBiZSBwbGFjZXMgdGhlcmUgc28gdGhhdCB3ZSBjYW4gaW5jbHVkaW5nIGl0
IGluIHRoZSB1cGNvbWluZw0KPiBxdWV1ZSBsaW1pdHMgYmF0Y2ggdXBkYXRlIEFQSS4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFJldmlld2Vk
LWJ5OiBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTog
SGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IC0tLQ0KPg0KDQpMb29rcyBnb29kLg0K
DQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNr
DQoNCg0K
