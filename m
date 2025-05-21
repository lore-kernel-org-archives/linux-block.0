Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74314238C3A;
	Wed, 21 May 2025 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747823691; cv=fail; b=AGMNTcQzoCfpcAa6p2pd1Y8hfVA7q/cJFLvBr9JqTiTQy1IjByRH4VmrxjSd53LH1Kf74EPNVIK+XZzmboyn6WopETeu/Iotyv4r5CFwuhL3tP+sREKYy+n9BQE1E0sczzH1g7iAhnwSigX3JurEOItngC4XQGYCr5FMpWAqH+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747823691; c=relaxed/simple;
	bh=/n8DaOS9N0zRwtMaO4Vy1BHAJkZaYe4xqBxi8phIkq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Klk+vf5ALuBcjc24IzUOC10qb7zG+4k4XWOKzQW7s9CC4s+1bVumFT0QLHMg3Htcifb2t6nuLV0BO1e4/IPXP69fdL30hFKMdWehY1AthY7THawG3ZGxeXrMksGpjJNt5YXIbN7sspTGTKlmBc7TiFdug0mlH5K0M/JVeSHUzIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SiQumkWE; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SiQumkWE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6nx6TWxWITCM9kp87pMb0RX/cSrGhXyLtWrq/u2pKkRvGBpghtOk7iTVte9SzMvMMAm+et0qH0LuDFo0dyJQB8UtvIpaLFLAiyDnUsXnqtTDRFiepZ08ZDcoO6IaUWPWv2D2WVg5DilX7eDrhNfje4x8lYWbfYzUWpqm6VlR0XsEiyYAkHkexHGCe0ZJjuqsZ624q4+CzY6FxXXQDRrCAw74q5DD1g/G36P/Lts+55W75PDR2twYkIr8MRD/557qQoNGv2syWeQ5Q2t+x+MMHheqv3yRcB4DVKxKQv1rKmLQbLzeXDRJva4qkrpXf97khHLe2NutcWwl98JO39pxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXTFhBAoK5PEgX1IMM/OoAIRm+EZeFfiZA0tf5JDuE0=;
 b=HYsL3KByltKV8KcjIcYpN2AwVgGLSaUWdZw3JPq/m5xoBFDLv0sEg70xiAoCd+wNuEvEseVzBsieMFS7ZVb/zeRLq9vWVYQETxPW8KRkzQ/Kwe/CO6mYB+As04v5/+0UW4Ryu7jJUfO9LGpmpPudsA0Olh+z0b0urX5R2BKIHtpZl3Oz+wsdcCQ7qm5esrw6KLRNodRPiYvi2mOhCnNS+thH4aK4lB/Miomcsx0pISBdgI/IEru0DDohFc8U+UMzNIyd8ze+NwYWUgqFyFD9tdUKmtL1wGMQ5P7Wb2wXeEUFPjbbNkLW3URP9ltCIfCsGB6tZoTNVSeJwPGiaI+lsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXTFhBAoK5PEgX1IMM/OoAIRm+EZeFfiZA0tf5JDuE0=;
 b=SiQumkWEa9msghObvLKsxaBmMAfQNViFdssI9ln/k0yXw++IEEj+QF9qIEo0Gu+KJg5xSx6LjEEIiSQsR1qd1HpdOWpTiTB1H9MT5jp3IFHGbLfhuWVpLMH8/EcxbQLdOB/KACmq6m7xe2zk++WHjUW0V2XfZRIIER81ieGdeIukG8PUw5Kz5whY/Cur1M7hGBZ7HkJW4kyqNVzQOzZskb1xRRfmNNHG66W/Dl0JpeNpzx+vX/Ae9YxswVnJeHrFZYOVQ6vXBAQl8kaTzMkFbQSIpN+AsW7n/yk5n78UVOZlxpm2KTi/vTBBksl0+2QvkvDiuqxe5QCD4NfUPfYjbA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Wed, 21 May 2025 10:34:46 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%4]) with mapi id 15.20.8699.026; Wed, 21 May 2025
 10:34:46 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "stefanha@redhat.com" <stefanha@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "NBU-Contact-Li Rongqing (EXTERNAL)"
	<lirongqing@baidu.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Israel Rukshin
	<israelr@nvidia.com>
Subject: RE: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Topic: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Index:
 AQHbyhrdL96Oqawka0G+Ryv5JzR6PLPcvXWAgAALoUCAAAWOgIAAALHggAAPPoCAAAHooA==
Date: Wed, 21 May 2025 10:34:46 +0000
Message-ID:
 <CY8PR12MB7195A01F9B43B25B19A64770DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250521062744.1361774-1-parav@nvidia.com>
 <20250521041506-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195F56A84CAF0D486B82239DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250521051556-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195A306A9A8CFE8FFC1B033DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250521061236-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250521061236-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DS0PR12MB8344:EE_
x-ms-office365-filtering-correlation-id: 95f94453-1aed-4311-f84e-08dd98531b38
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KjYwVhK0w07Hrv+1q2I0uDryGw76qYsxdDH4lAdWWKs0M21MoH53mINmQj6T?=
 =?us-ascii?Q?QpIBPtFnto8VU90oFGBUBnUD8D3P07jswAUQyMgm2Q2dxmaNRnIVwNXADNGk?=
 =?us-ascii?Q?2NetdHUQBI6HEQCN6YqxIhG0apxnZz5Im6ZlfnTRCijFBF0v9YIPJaiCiUAl?=
 =?us-ascii?Q?OzvUXvGEF66+fjngN8jEIbNULPQQmyKIRyZc09LtCe/u9jvyCUsi+S4VO6dE?=
 =?us-ascii?Q?IPHxbRgPM1JBeGGBGJlgpqFnSruY8yv5D3cDN6+R5mQ+4FJpZm5nwc/geLWi?=
 =?us-ascii?Q?CLTUZ9Jz8NbMLrsjQVKjgkGS2iwvFgLbXavT/VgrvUoEOKkh3IQ67qWwEUil?=
 =?us-ascii?Q?1gJ31BDlbKFi8pnfsu6N4NhwVQpgPs/GCRr+BMWe8613bxOXA1/e+bPWFIC3?=
 =?us-ascii?Q?/yBPDAdDOHPpOSY5cqSxab6YWtnQZPXvS5WZVbR+Ofc35Cnw+8GKhmH06N9K?=
 =?us-ascii?Q?1mZAVOYBH/cA6FVw63CDTGHtTuIYffE3hxERK2q6T+H/XswQGqnIdZvt0g6p?=
 =?us-ascii?Q?t4VQ9wOI5a0hDV8OVSdkQbTtxP/YJwurmTl6k7PW0aFh351sguz3EAUK3EPM?=
 =?us-ascii?Q?xvo+86QFJl2+1qXMpmkAD1tRYg0MrkjlSIKM/QuBuq5Yy3WiM0g7Cxs0d5vh?=
 =?us-ascii?Q?0GcDHh+5dd7E1rx2xuC5si35I82R8FvjOK6yN7zSQI0jS3ADe9IRz9ziL6CO?=
 =?us-ascii?Q?k/NIH+9uqprMBP6ybolk3gJDSkgUgDGQ5QzZjtPTEBwMAAVrdMr1f9mFupeW?=
 =?us-ascii?Q?PctITIxKRJI/mpc7ziMdWWPRosn75T5xE9vMi2KBaJuvZqOaF4roZpZzXh/p?=
 =?us-ascii?Q?8SVS/8t0E0hyn5xmvkUSTBtwAcMDYHWvTEOqU5mVcKfxBDVZPLp+9E/4GLcH?=
 =?us-ascii?Q?3/IGiHh7LOlChjUA9s1AFUJcRPVqhmwbQOGp2NVIcM54I6yzwY+Ng0DjtbW7?=
 =?us-ascii?Q?ll4nvxIslHK6jZ8FZWgfPumGXdXO+3R7DyIMbUlVFk81/pBAOGOqmxNBInCL?=
 =?us-ascii?Q?neGYSf9TrszM/9EbSChndSmUetmJPA2YaKW+Kx6V3cjWJlSLx7BPaLodMcFe?=
 =?us-ascii?Q?uLCoCF485fngP9kAB5CpMXfEVWg3YBl5COM97zaQVeZdGsGB31/Kb8H+JRp7?=
 =?us-ascii?Q?3v/iwjLoc+DilqCwo2Enfjr3VIeNW4mYON3BcqD/LMWqM+UyEAvilf0wnCC8?=
 =?us-ascii?Q?vweSw+Uuc529bOqrJ69JV8Prs+cXC83T1g6HN0peRC7K1lSWDXEeJHz3EAAR?=
 =?us-ascii?Q?w5qoHG6YP1xfvdI6MPTu4UeQMAKONXzGTb9Sq/arKy4e54QLVLnpjhAv3TMd?=
 =?us-ascii?Q?h7bDJiyG465TELo5dO2XhtMUoDAN63MPq4ZmITeKJPyGUrAUhtg8Chucmlep?=
 =?us-ascii?Q?FbeWGmv/6gqxgxWo3yz4EviN4RjJ7E203wi4uJQqOwB/0VyzCpVwK1mVhZlp?=
 =?us-ascii?Q?ptELENbnhBcOxtt2QEMmc4NrgN+olpMoyWpZE2xL/HHKotz8naKAHRBtR5DU?=
 =?us-ascii?Q?Xi5LrsXM1lFDrvM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yatsZ05Xy5T58Jm16L+9Ra/i2JsOH7gvWFSIkAIr8bQ574ZkEPx/KNyyAKUY?=
 =?us-ascii?Q?/pqeET5AcX0Ljrv1/6AOsbQOnE0vJfZQH8xO3BaAtWAs02KKJErYPlSqHw9K?=
 =?us-ascii?Q?iRXxiFnHWF1Oihqp5Lq5zphbJO1jiCMfsYdPUIrcoT/WBeZEN8qnQWb2T9ya?=
 =?us-ascii?Q?ibbv7kmRSQ9NwJEYJTY/u+K7R3DASMis3GPJJkLKi0L5NemyvXM1ACXSFssb?=
 =?us-ascii?Q?b1g9xngjOdY1rWDc1c2pviqUbfq+xcnFk4eO18xGjgby9Y5pJ3i31DhOTXGX?=
 =?us-ascii?Q?po5WTNoNl2e0XywbmcYUmQuZ6lW0PMryPmkGw73WjHf7FEm73yVUswdvcnKG?=
 =?us-ascii?Q?9wsVtpUjFRD/9AUam9faCpZ7DirBHlBD4Dgh8zLvJ8AwY3RS67tj9vyzSgk/?=
 =?us-ascii?Q?jnf9GxaTRXnyUg7kOqb1/XYxn+uwgyXYPq1z52fBnP6mVTjgxQn3mAyDIdBv?=
 =?us-ascii?Q?80xcT5qrGX8dlq0GSNVRgAKuxxSuIvljxATrmRPuNdfz00USBiN4kpC7kD3I?=
 =?us-ascii?Q?ThhmdeW6VbFMIJSRmk60CcArBO/AuUP2iTCpiF4P5efTmSyxZzWYhSJ5mJwW?=
 =?us-ascii?Q?6HGoH/hNeeZ5hp1PwpyU3gB49NbQTansO5v+AlwevyoZ71eSZWbakihUaye9?=
 =?us-ascii?Q?yp9B0n5yJtw1zU8PS3WDEB5xizpoKUE2S5KJbWJg+beuUwMWmR89WN2lL2uY?=
 =?us-ascii?Q?g4ONDzOMLnT11hDTMTfE8d1YB74xD7gYMI5eHIGZWAxxKL63OPDn0zEVrBzH?=
 =?us-ascii?Q?XjcJFJOLl2OARQTjLKZzLG6j+YJLiC4e5lUyYX5Kk5u4G5/X8NlNrHwz6Q5m?=
 =?us-ascii?Q?W/G9G4/dla+mBBf90CjZLoeAQA/DoqD5fQg7TbtWswMhb5IM2JF8IEcQ8lSu?=
 =?us-ascii?Q?WqqeGdt6Hs0LR74ulxFm+lekTvMc633rkL8kTccbKFC5H25Q8PtcIc0QV/x+?=
 =?us-ascii?Q?ADYn6UsdDI9x5m4WBHT2tbDJ8SJNXwJFRjRv1ZpWrWZY8OFdyraVy1pAgr3J?=
 =?us-ascii?Q?OuqKGvNwO11SNf2+ws4IG9+XTBNGyxfI5uVqNDERS72gO3/DJn0TDYKHb5pp?=
 =?us-ascii?Q?xCLgJ6NyyhLJudyIwHTwgMeQMQZV1VILU7zaij4SRMvDXmSvBS8UZjijepWn?=
 =?us-ascii?Q?zmN2mo9oZpJTPWnmuO/I7OJipqzQWW1XZpfV9GNxL5DF3BDrkcRPqh8hoVqo?=
 =?us-ascii?Q?RgPqCKMyCqPYQYBCgNJmxGIIygVjXXQD8WWLiX2l+sWHk1XQ/cSh1VEz80HV?=
 =?us-ascii?Q?E/u8lOMr0db9SpZldWKeHIlhJNFHRTk3fGyllqOASet+UGcv72Su2UOvqKpL?=
 =?us-ascii?Q?LAfukJmxC4+jxkwaEq19BV+bjbY27ZtEzaitsjw8ZN7VdJuLt8sliJeNgkVW?=
 =?us-ascii?Q?cSgm8JJfmPuFQGSaryzdPachELQE9paU25zm96WTfSX+OJURCQDhdwe3ptrp?=
 =?us-ascii?Q?oeeyKyG8RXmC3mDGhsk/jdf2ghTexSbYxH/QHJHALTD+ey+QfpuMKndUA3qa?=
 =?us-ascii?Q?M0cAErC7hpGX2ctBCz1benH/K2ma1+7bsVf7/xUn7tYFnjNAg/3nzim8zxGD?=
 =?us-ascii?Q?nr5xNBYuxzP/oMXDjBA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f94453-1aed-4311-f84e-08dd98531b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 10:34:46.2407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thmqVd2QtmeLkAeWN4VGM4qxm3CLL7pNoQ4Vkg1DIkotMiUK4ulcm5aj33ac6UMrhr0Ks76vQTF+jpXsN0HHTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, May 21, 2025 3:46 PM
>=20
> On Wed, May 21, 2025 at 09:32:30AM +0000, Parav Pandit wrote:
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, May 21, 2025 2:49 PM
> > > To: Parav Pandit <parav@nvidia.com>
> > > Cc: stefanha@redhat.com; axboe@kernel.dk;
> > > virtualization@lists.linux.dev; linux-block@vger.kernel.or;
> > > stable@vger.kernel.org; NBU-Contact-Li Rongqing
> > > (EXTERNAL) <lirongqing@baidu.com>; Chaitanya Kulkarni
> > > <chaitanyak@nvidia.com>; xuanzhuo@linux.alibaba.com;
> > > pbonzini@redhat.com; jasowang@redhat.com; Max Gurtovoy
> > > <mgurtovoy@nvidia.com>; Israel Rukshin <israelr@nvidia.com>
> > > Subject: Re: [PATCH v1] virtio_blk: Fix disk deletion hang on device
> > > surprise removal
> > >
> > > On Wed, May 21, 2025 at 09:14:31AM +0000, Parav Pandit wrote:
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Wednesday, May 21, 2025 1:48 PM
> > > > >
> > > > > On Wed, May 21, 2025 at 06:37:41AM +0000, Parav Pandit wrote:
> > > > > > When the PCI device is surprise removed, requests may not
> > > > > > complete the device as the VQ is marked as broken. Due to
> > > > > > this, the disk deletion hangs.
> > > > > >
> > > > > > Fix it by aborting the requests when the VQ is broken.
> > > > > >
> > > > > > With this fix now fio completes swiftly.
> > > > > > An alternative of IO timeout has been considered, however when
> > > > > > the driver knows about unresponsive block device, swiftly
> > > > > > clearing them enables users and upper layers to react quickly.
> > > > > >
> > > > > > Verified with multiple device unplug iterations with pending
> > > > > > requests in virtio used ring and some pending with the device.
> > > > > >
> > > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > > > > > virtio pci device")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Reported-by: lirongqing@baidu.com
> > > > > > Closes:
> > > > > >
> > > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73c
> > > > > a9b4
> > > > > 74
> > > > > > 1@baidu.com/
> > > > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > > ---
> > > > > > changelog:
> > > > > > v0->v1:
> > > > > > - Fixed comments from Stefan to rename a cleanup function
> > > > > > - Improved logic for handling any outstanding requests
> > > > > >   in bio layer
> > > > > > - improved cancel callback to sync with ongoing done()
> > > > >
> > > > > thanks for the patch!
> > > > > questions:
> > > > >
> > > > >
> > > > > > ---
> > > > > >  drivers/block/virtio_blk.c | 95
> > > > > > ++++++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 95 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/block/virtio_blk.c
> > > > > > b/drivers/block/virtio_blk.c index 7cffea01d868..5212afdbd3c7
> > > > > > 100644
> > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > @@ -435,6 +435,13 @@ static blk_status_t
> > > > > > virtio_queue_rq(struct
> > > > > blk_mq_hw_ctx *hctx,
> > > > > >  	blk_status_t status;
> > > > > >  	int err;
> > > > > >
> > > > > > +	/* Immediately fail all incoming requests if the vq is broken=
.
> > > > > > +	 * Once the queue is unquiesced, upper block layer flushes
> > > > > > +any
> > > > > pending
> > > > > > +	 * queued requests; fail them right away.
> > > > > > +	 */
> > > > > > +	if (unlikely(virtqueue_is_broken(vblk->vqs[qid].vq)))
> > > > > > +		return BLK_STS_IOERR;
> > > > > > +
> > > > > >  	status =3D virtblk_prep_rq(hctx, vblk, req, vbr);
> > > > > >  	if (unlikely(status))
> > > > > >  		return status;
> > > > >
> > > > > just below this:
> > > > >         spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> > > > >         err =3D virtblk_add_req(vblk->vqs[qid].vq, vbr);
> > > > >         if (err) {
> > > > >
> > > > >
> > > > > and virtblk_add_req calls virtqueue_add_sgs, so it will fail on a=
 broken
> vq.
> > > > >
> > > > > Why do we need to check it one extra time here?
> > > > >
> > > > It may work, but for some reason if the hw queue is stopped in
> > > > this flow, it
> > > can hang the IOs flushing.
> > >
> > > > I considered it risky to rely on the error code ENOSPC returned by
> > > > non virtio-
> > > blk driver.
> > > > In other words, if lower layer changed for some reason, we may end
> > > > up in
> > > stopping the hw queue when broken, and requests would hang.
> > > >
> > > > Compared to that one-time entry check seems more robust.
> > >
> > > I don't get it.
> > > Checking twice in a row is more robust?
> > No. I am not confident on the relying on the error code -ENOSPC from la=
yers
> outside of virtio-blk driver.
>=20
> You can rely on virtio core to return an error on a broken vq.
> The error won't be -ENOSPC though, why would it?
>=20
Presently that is not the API contract between virtio core and driver.
When the VQ is broken the error code is EIO. This is from the code inspecti=
on.

If you prefer to rely on the code inspection of lower layer to define the v=
irtio-blk, I am fine and remove the two checks.
I just find it fragile, but if you prefer this way, I am fine.

> > If for a broken VQ, ENOSPC arrives, then hw queue is stopped and reques=
ts
> could be stuck.
>=20
> Can you describe the scenario in more detail pls?
> where does ENOSPC arrive from? when is the vq get broken ...
>=20
ENOSPC arrives when it fails to enqueue the request in present form.
EIO arrives when VQ is broken.

If in the future, ENOSPC arrives for broken VQ, following flow can trigger =
a hang.

cpu_0:
virtblk_broken_device_cleanup()
...
    blk_mq_unquiesce_queue();
    ... stage_1:
    blk_mq_freeze_queue_wait().


Cpu_1:
Queue_rq()
  virtio_queue_rq()
     virtblk_add_req()
        -ENOSPC
            Stop_hw_queue()
                At this point, new requests in block layer may get stuck an=
d may not be enqueued to queue_rq().

>=20
> > > What am I missing?
> > > Can you describe the scenario in more detail?
> > >
> > > >
> > > > >
> > > > >
> > > > > > @@ -508,6 +515,11 @@ static void virtio_queue_rqs(struct
> > > > > > rq_list
> > > *rqlist)
> > > > > >  	while ((req =3D rq_list_pop(rqlist))) {
> > > > > >  		struct virtio_blk_vq *this_vq =3D get_virtio_blk_vq(req-
> > > > > >mq_hctx);
> > > > > >
> > > > > > +		if (unlikely(virtqueue_is_broken(this_vq->vq))) {
> > > > > > +			rq_list_add_tail(&requeue_list, req);
> > > > > > +			continue;
> > > > > > +		}
> > > > > > +
> > > > > >  		if (vq && vq !=3D this_vq)
> > > > > >  			virtblk_add_req_batch(vq, &submit_list);
> > > > > >  		vq =3D this_vq;
> > > > >
> > > > > similarly
> > > > >
> > > > The error code is not surfacing up here from virtblk_add_req().
> > >
> > >
> > > but wait a sec:
> > >
> > > static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
> > >                 struct rq_list *rqlist) {
> > >         struct request *req;
> > >         unsigned long flags;
> > >         bool kick;
> > >
> > >         spin_lock_irqsave(&vq->lock, flags);
> > >
> > >         while ((req =3D rq_list_pop(rqlist))) {
> > >                 struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(req);
> > >                 int err;
> > >
> > >                 err =3D virtblk_add_req(vq->vq, vbr);
> > >                 if (err) {
> > >                         virtblk_unmap_data(req, vbr);
> > >                         virtblk_cleanup_cmd(req);
> > >                         blk_mq_requeue_request(req, true);
> > >                 }
> > >         }
> > >
> > >         kick =3D virtqueue_kick_prepare(vq->vq);
> > >         spin_unlock_irqrestore(&vq->lock, flags);
> > >
> > >         if (kick)
> > >                 virtqueue_notify(vq->vq); }
> > >
> > >
> > > it actually handles the error internally?
> > >
> > For all the errors it requeues the request here.
>=20
> ok and they will not prevent removal will they?
>=20
It should not prevent removal.
One must be careful every single time changing it to make sure that hw queu=
es are not stopped in lower layer, but may be this is ok.

>=20
> > >
> > >
> > >
> > > > It would end up adding checking for special error code here as
> > > > well to abort
> > > by translating broken VQ -> EIO to break the loop in
> virtblk_add_req_batch().
> > > >
> > > > Weighing on specific error code-based data path that may require
> > > > audit from
> > > lower layers now and future, an explicit check of broken in this
> > > layer could be better.
> > > >
> > > > [..]
> > >
> > >
> > > Checking add was successful is preferred because it has to be done
> > > *anyway* - device can get broken after you check before add.
> > >
> > > So I would like to understand why are we also checking explicitly
> > > and I do not get it so far.
> >
> > checking explicitly to not depend on specific error code-based logic.
>=20
>=20
> I do not understand. You must handle vq add errors anyway.

I believe removal of the two vq broken checks should also be fine.
I would probably add the comment in the code indicating virtio block driver=
 assumes that ENOSPC is not returned for broken VQ.
