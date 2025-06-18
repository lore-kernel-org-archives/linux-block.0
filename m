Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFA9283682;
	Wed, 18 Jun 2025 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238994; cv=fail; b=FtjTngfNJHq8dGqovluuw2yqvKwr/G0ISvEOq21pMPeBaFKViJ+7SofkKMCb4Bc0Cb0NKa1qaMH1tVdjKeyvaxJ6loZzV+aP36vXlHmtbMxAHmR6HxoeQbH2ZahtXhrcChsmT0c+QuZxNrDi/xgdKVuRxWAcEj5ZuOnn+MDyyFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238994; c=relaxed/simple;
	bh=8klkMjjNJtqWwe/u7JB6J3FQGy07JIc0BNl8O4Q0Btg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gJfhey37o78mEcbEyZqF2yyvUPeyxixu7wHKQGyd2sEYK+7oYLgcrsZNIHgfQgfEISajV7Rwo5iJcvAoTaaFOBPkjJm+ebksDrSwyDPDrQ7p5WZAwJDBDoQRqA93lM7+Yfjmz/+QX3gUIbkolZ6vi8MXvmkfFSxKyMtbQZZ5seY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FBFuZqPH; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FBFuZqPH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2eHC02WTdyHeQBFZgQUYqtXJECDn5LgjAdiNdXFTmnU2hNSRpexDpL9faBMbpzn8hyCtShBhL+bJnS0iJlQNEFJYM1N53AZw2VPNT0+L2T+HcoRLHRvICmDXcYXFAMKNKPxI+5ncTFscvODwBbChT7KqnQow4WdXUHM4kg2OX1TL4rbKjOGyKQ2XRlLlKibEW3jqYepf0CioZP1h85kLG6KFwzPRLTBgKrnpCzpPlmbjX6UvFyuAVRoWZ5trzgj1Q5mAk0X+097F79kU050WskqVUuAxDdGuZUpwze223JfEDwrrOIlOcohJOOwu1g/rN1/tRLMyWCaAuzW+jYpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8klkMjjNJtqWwe/u7JB6J3FQGy07JIc0BNl8O4Q0Btg=;
 b=bxenpDYW+R/Ipnv21DPG+3eXwNnfuPjzaUxwDxYfza+qmMptYk1SkC5dP4z6z6cVHJcScseWXdCi3h//1EHAlekkpG8Q+tBPV2rLTZQLaf/hL1VMad9Xfthyo2L4tGhMGhqLB8Hos4PFQoKfyWQ/eu89m8QCwxNQmdQYBUOPCv3ChDzJgqGzVJ+mEZCdyUorF974OTXZRmsqqklEJ8tajqn3r014EGd6EFv5ty+lkTY87+uegTxukE6w7UvTMsh9mmhugr7G2LE6nak6Fvz3cZHLiJGK1JZdImO9XTdNFBvHgg4CsnFM7KdRskhpkUrBOL9/vw/g1fgbOFiAc7ES5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8klkMjjNJtqWwe/u7JB6J3FQGy07JIc0BNl8O4Q0Btg=;
 b=FBFuZqPHkMz2mxY3yuid7n4Tpz+2yPj1ooQuEvJPGiXPLaMQzNE8rTDRBAEVNsVRZ2JV0zQVivNxi8ioklAyzPYjpKb1SILM3G1a57PMNYSZKwPkum3JfEQbW6kRol2oFWymKNnAtupJYQW/dWmlMqJePEzfuUyKyoEDmU4sADHz9DZc6FbksgEDwKjAfNp36WDMhRVMywayAf+gdUOBIogEEF89kBbQiqMj2N02RP4TFPUZaOetGYlRZKVvBqL8f4MWux2kO7Szt4U23d5UlO53ptdQX7S0wdG2MEnV/7QrMd4Bri2mJtThpTlBHsGIcDF2T71plLWKAbYrpsawsA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 09:29:50 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%5]) with mapi id 15.20.8792.033; Wed, 18 Jun 2025
 09:29:50 +0000
From: Parav Pandit <parav@nvidia.com>
To: Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "NBU-Contact-Li
 Rongqing (EXTERNAL)" <lirongqing@baidu.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Israel
 Rukshin <israelr@nvidia.com>
Subject: RE: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Topic: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Index: AQHb02hI8rTGAA49eUeotBFzOHU9FbQIv9cQ
Date: Wed, 18 Jun 2025 09:29:50 +0000
Message-ID:
 <CY8PR12MB71959F7FC80E1BA50889C3CBDC72A@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250602024358.57114-1-parav@nvidia.com>
In-Reply-To: <20250602024358.57114-1-parav@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DM6PR12MB4172:EE_
x-ms-office365-filtering-correlation-id: e0ca794e-40b5-4078-b540-08ddae4aac8b
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Xe0v8Z/AispFOcXp1/+SrDIXOFQV325YYpa0/pv3wC9GMDIaPtsgAL0+Ebxj?=
 =?us-ascii?Q?w4TS5+aXr3juKYFqSMAIHXctqQ8fkFT+TfbqR5AB1v0U3gff0aDxD6oZe7NC?=
 =?us-ascii?Q?KMhpeAuGl1hMNy+aLms4kWYxeIqL5D4of9NiRHVF7swecY7jjipxaFEyQ/hk?=
 =?us-ascii?Q?w58K2sancWQoCUA1zQJFQlmkAOARHT57IttJP7idEghi1REfTiV86RwRq5py?=
 =?us-ascii?Q?uHBF/dAPxYhlGoSYe66yy320QbVUqTgnTohR3eKB8MF2lGP02QY8qNuOxUsh?=
 =?us-ascii?Q?M2+S8HpHs1Z7dPB8FOUIxBIHkQdRxPGeXRmLdLE2SOM10LCbx+k0pcKyu+qB?=
 =?us-ascii?Q?0dR/ZyNvTKBpW+nwg/gwn/BeOk4ds5aBybpLCPUvXWhz9YND3l1Fka+xxnIz?=
 =?us-ascii?Q?5KfFm4JT/5MB+z996l41ZfkzHEKDseGyLpRNZiTqAeH864OBjkwsEmtS6tGS?=
 =?us-ascii?Q?sUvsXuPKLZUNrgwUkiYEow23T7uX9kBcHZRnQWXMv30US+sRVg01+VcgAhCX?=
 =?us-ascii?Q?uUcigdrsVndQPqtZMjKdyQ/VaqB4dScvSiFO4GHbTjPoDxMT35z34452vEo+?=
 =?us-ascii?Q?vVpt3uBPS7giQw6dwtlomuT1yrUgRSPSFUhYZiJTqdGVKu2wSfnWFWF6bfJ+?=
 =?us-ascii?Q?F6tA8gu9/zZtnsmjVLTNhVWI7AHrVf7d0w55lGoP8p+iQ/z4HhKSKeGyzZHP?=
 =?us-ascii?Q?mqHTjOVaoCLsl1JsopdeFSVk8d+j+toJor/NbKXrhLhHijHMX8AkydoHjUjr?=
 =?us-ascii?Q?4s/QEWAQpdcL23jAaeri/J1mm5sIn1QIXyXKOWd5/8jXJ3lZM5wy7lTD9bQk?=
 =?us-ascii?Q?MP/UWS3mCbo3gD2ep+oQYHA3Es8dc4RLVbYmn1ZDEDX6+tdZmgH8YOfGkyd8?=
 =?us-ascii?Q?ZVZke+8cwATfr77Ps9tNLt6Y/F1nhb4ryBvdjX0jhb6Zxpow3V6ygjRsbZ2k?=
 =?us-ascii?Q?wQnEbSa9/Df1WQydYO2CnKGjwx5ANlmq2/W0g9Nogyn/80m3rv4i2PflJhF/?=
 =?us-ascii?Q?LS7uYpqfx+mNGw+UcmorvkkGvQOLtSc3ZX2cQXPDaeBKHSQFkLsMrNeXFSMi?=
 =?us-ascii?Q?NDgld/8PIsesmHubmbO+rwFWKVqOB7Iwd6DKZO++hJogxUKqu5kZXpx83CZo?=
 =?us-ascii?Q?abF0cZlwWC8sSboTb8WnJz7f4rRxS7zm9SJJLmPMLtC7WU3b3KM2yvomprXB?=
 =?us-ascii?Q?NKbJmTCNfxEc7au/ZXgJqiALwf2dBRX7mFiQv5yBrzfVlc+qeM+TeozDbjz4?=
 =?us-ascii?Q?F3ojp27dEKbDz4RfvnD75sLhTP8kHOpgJ0sJx0/WDq8dIYnsuryY9g4PzZTk?=
 =?us-ascii?Q?0erk9WScjiU6pU47CYutavygAY6MDEHqYz5WIIoOyAHf6iZMH4zSae9nlkjm?=
 =?us-ascii?Q?aOPlh7lOQdtokBIco5Oy5eRz3w8/OlDMbdN0KdbBXDFxjYieSMf0wx1PD7XN?=
 =?us-ascii?Q?RX38awm/Q9hrOFh018Fu3bY5Ezxj40rCy2o09mny4BdYqKa3cfIXIap69dJC?=
 =?us-ascii?Q?gnUGybrH8ZqSP1A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KPyRDi6R/g8Ug8aeeUNgTk+iHzqrjTlUDI6DLF1kvdHljJ3Vgk+Eaa3pE1Ys?=
 =?us-ascii?Q?ImLvs8p7evMwK68ZvcvcodbaPoyikvqtQtSFJMhc1MTIcKLaUfsiIPBv65Rt?=
 =?us-ascii?Q?TI00KP+nzYUwJ0ZMiBY+J4EC56BPZBMTrHB/MkyfFzWsi3Vzj+nFq0rK+ThP?=
 =?us-ascii?Q?HgxKYGqaKnco4Wqf5xEYKwz1//1kxxjN/g32sOq23+5y8H97zkqsqwxLXhSJ?=
 =?us-ascii?Q?A1V3oDe1tqGu0+zJJy+2WZJg4xCXEVBBsMO2wSGT/P53TnnKmgBQSzIuWd4C?=
 =?us-ascii?Q?Dqy0rCtzG1t7CZGwCwH0W5TSCxa3lzDDqEmwG8Yk80iUH28zhSzMyIsEDBu+?=
 =?us-ascii?Q?dcvSLkzjhvXZd5JttgYYpg0ogJkvX/czLl3hDVOh7o/bueCvNdWBZ2qNmNoX?=
 =?us-ascii?Q?tMAa9uDXXxdARCuVVgqt7d/F30oCk/11pTkz9vm41uPMBd2apMRC+sMxqTYx?=
 =?us-ascii?Q?maj6Edm3VeiJ8l5/vz2XktGSg7tGlGx8Skr71bZxF+xG4Rm0EjBQILe+uY8V?=
 =?us-ascii?Q?ahAeYeAS4z8q4vFZ9I62zvppv5rg0K6xoJOnLk924zPUGK0fLa6k4PxfeoCL?=
 =?us-ascii?Q?dWFNtpTiedtr3uVcn3JxAU9IdD4hA3uMv76VBr7ZV1ijfgCeHwRLi8Out0iP?=
 =?us-ascii?Q?2IEIHmPo+6PA1Hu4B+le52s7yLvarcn+WjtDUqDMzm7mTquRYZIzH3Rgz1YZ?=
 =?us-ascii?Q?UHvCetZFBvFi0rRNpmnGsHx8FVdDxV+ua+NwrEEuBxitKrFDc2dCZmcl3/b7?=
 =?us-ascii?Q?kQtYT7h61AnA7lscWEd6StclvUswkQdRbiEaZvtkU3tZINm1kgXJ5rKjhUZo?=
 =?us-ascii?Q?k2EOopCsQRg11xLqS81rytSsJ/6ruGwqq4TmaxzWikJQybHxH6Sz/6LXJuCP?=
 =?us-ascii?Q?7tiyslbz65ohKPZVppRvP4XFFdOlJTNlpP5P+9SezsCbYkRXenAnAZq1xdYe?=
 =?us-ascii?Q?yaEOyKYH6sjyn4LFsOn7mTT3JYodXXdu2TrFKmDICSNnoXwWTzwbyPRCuV5U?=
 =?us-ascii?Q?CGJsREVTiWWSP9iM/oIPOGHVMzqcg6sF6csjinBuLT1ef8XOBfrr9OdasgJG?=
 =?us-ascii?Q?/bGV1Dlel+wuDdOolZK2O10I4Q/0xVRBuX/ZjcSemlAHpYmO1ukfrxMEmVw6?=
 =?us-ascii?Q?A+4len8FqNGUpvNrSERJ66UgsNgTSrNuu4PKmXYkusTDLpYP4cxASZK2Ieyv?=
 =?us-ascii?Q?o0nDEc1q3nU/unXt8mfOE8ljqqhGtJiC06q7gRTdBqnOCxbm/pYc+4JwDAYH?=
 =?us-ascii?Q?RTj5b34VhcyXfV2VmAiINH/1KVa/E7H1usaLtSLpAn6tqdN/E/eh9ZJMFVxK?=
 =?us-ascii?Q?FCHrtEMjQB6uLEQ2ifXCqh226ENQDRmZyeevErDzA5YygBtTZK3n3rcmz6SF?=
 =?us-ascii?Q?Im1K9Vjw4DUlRYY5+U15tahRnXsfVzAi5nWfpcXbIba5LdZ+wNVhieCWNQbf?=
 =?us-ascii?Q?6XMER+eVLtsho2DWhsC8nCD6OpE6NNp31x+VAP+tL7qmJaGkjxKCzbMZI+UD?=
 =?us-ascii?Q?pbdEBXX/writ7EOrBHGBYBM1yA4MIQ/w7ROFuML672rT2q8hEWwfJnWS8jeB?=
 =?us-ascii?Q?SNMR26hI87R9Gum9QMY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ca794e-40b5-4078-b540-08ddae4aac8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 09:29:50.1753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GDL8S9J+pTAWYWlKweWn5gmcVl0YK7JSgaVbKxPwSpu2LXvBbAqgc/M+MT+BkMMgbvkDM7xTwGvuo0sHVOCyXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172

Hi Michael, Stefan,

> From: Parav Pandit <parav@nvidia.com>
> Sent: 02 June 2025 08:15 AM
> To: mst@redhat.com; stefanha@redhat.com; axboe@kernel.dk;
> virtualization@lists.linux.dev; linux-block@vger.kernel.org
> Cc: stable@vger.kernel.org; NBU-Contact-Li Rongqing (EXTERNAL)
> <lirongqing@baidu.com>; Chaitanya Kulkarni <kch@nvidia.com>;
> xuanzhuo@linux.alibaba.com; pbonzini@redhat.com;
> jasowang@redhat.com; alok.a.tiwari@oracle.com; Parav Pandit
> <parav@nvidia.com>; Max Gurtovoy <mgurtovoy@nvidia.com>; Israel
> Rukshin <israelr@nvidia.com>
> Subject: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
> removal
>=20
> When the PCI device is surprise removed, requests may not complete the
> device as the VQ is marked as broken. Due to this, the disk deletion hang=
s.
>=20
> Fix it by aborting the requests when the VQ is broken.
>=20
> With this fix now fio completes swiftly.
> An alternative of IO timeout has been considered, however when the driver
> knows about unresponsive block device, swiftly clearing them enables user=
s
> and upper layers to react quickly.
>=20
> Verified with multiple device unplug iterations with pending requests in =
virtio
> used ring and some pending with the device.
>=20
> Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci
> device")
> Cc: stable@vger.kernel.org
> Reported-by: Li RongQing <lirongqing@baidu.com>
> Closes:
> https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4741
> @baidu.com/
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
>=20
> ---
> v4->v5:
> - fixed comment style where comment to start with one empty line at start
> - Addressed comments from Alok
> - fixed typo in broken vq check

Did you get a chance to review this version where I fixed all the comments =
you proposed?

[..]
