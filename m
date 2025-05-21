Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8774D248F49;
	Wed, 21 May 2025 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747831218; cv=fail; b=EgZ6HLOHeQMoOLGV4VCBEzZV49ZceND07GyIrGukiBa7tcYQeVk8zry8Y9tZuQP03AplO9pqLT4gIKkfwmfIocl2AhMNx+XkD5JXbYkW/Z+xc41OrWOg9gBl5ogn9GauJpyxMKUWZVs6X431v7ggLbtAEATnywuyA4caHnlLsQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747831218; c=relaxed/simple;
	bh=+vM1zQC6laS2iBnsDy3cvkT8v7QF4VBnJqbZP4sDMdE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XlT6q9BaVYr76gB10IntIQ7htJKRGLRUV/w0s2ut62YShcIPkCTZGXeLk4P53VpkmeAcYa3jy6DAEF/Xu9kPvsRQr7Dqs0flMKS+pdyMoXKoqXeXkE0vQOjGIVRoOPhihbao7AA59np1kNGQffM1u6GJcZe7V0FwYztkEMWZkz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R1Lpz67y; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R1Lpz67y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZQ+w5j3/kD6lnLTCIpkSOKYMlmlq7//muyoYnXJPdCUOx/8E9A3yMSu0jWd2Khh9J7QB4K3bHHrX6vStaBv8YBm65ZjGw0owuhv5kAH6ZFE2Hllo9aIdSb6a3/K6WrmEGmwC/xT3SREIokPF1gHvV/VFqxRsngeOdjL5IWck7ZUmUR7aQxUvlltf15AaK/ojhXzz7CD17qjNs2U5+4DN8dMBIkfevmWbeL12VU8UBWwCuj4l8J8H9zRVmekXrYBjDLhbxw8iCqVtjgbBvFTaO5F8TfrSGXuJC1LtQ4ChyQjJWlv2bWYBz5cSEJDja0VwiH+Ew/3rI5f3q2WKUUHrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pP9DobPMwvXlzJw9oFwIGVx7jFcsGm0xSHYaUg9sBqg=;
 b=EbzuPi52LUq1V3dRoSR+3dvCU3uEma+x6P5kWznVACqx3cRJq6uQOU7Ae+7eUrXuys82Y0TdwnFe1aWwfe7DjMGkN2+1stqfG+pRSpVzchj4lnqimO3TjZ5AeoQtXF63AY60Dlc8rnGiWwPt82P6nfBfEJq8QGwAEC6t8eCoKYQC7LNFPUVNrs4HgUAKYBg2nVIFaO6vVO8YaxlOvmOQ/YXF8At4/z28DWn+TLQV9fhr+l5xJ3PWLxmi9qrUJdPuNUj5jX1stX2gBrWpgr9tj8GFhztkhTLtq4UQagLGcZfns0GsZHsowUPLvj7M5kPXsI0bhZdP2IoLwPvRgbgbTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pP9DobPMwvXlzJw9oFwIGVx7jFcsGm0xSHYaUg9sBqg=;
 b=R1Lpz67yF8p2ha6I2/GVguZe9qUCP/ablSzR/dTzn0KWWsyUKbEyFp7YYA/M4Ffh5f6mQhSn6Q4ymzb7tq0GYDiHX6g91ZIwF02/o/48BZvnPSscPAGcPnngbF+fI2yGRChB8igCB6Q87ottAdWAJHvR7C2Ec6TqCGiRKgtsmlvQIhpq7be7GMQKdZqd0rN242Hn8VZKalDvgGLAxzEmaoaRGbPIn/vG1qXtDLJ2JSpVL6HUhFtOpUq+CmD0CEZR4xfASxW1OGTwr06jDSjRKw4qMeFmB73gZiiEJVuaAMBQH6bRd8trgJx/JeAzMXzkGIukVzbxBnkg4wwsAyIJ8Q==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 21 May
 2025 12:40:10 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%4]) with mapi id 15.20.8699.026; Wed, 21 May 2025
 12:40:10 +0000
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
 AQHbyhrdL96Oqawka0G+Ryv5JzR6PLPcvXWAgAALoUCAAAWOgIAAALHggAAPPoCAAAHooIAABZyAgAAf9OA=
Date: Wed, 21 May 2025 12:40:10 +0000
Message-ID:
 <CY8PR12MB7195200C1F5D877448DF1D3BDC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250521062744.1361774-1-parav@nvidia.com>
 <20250521041506-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195F56A84CAF0D486B82239DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250521051556-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195A306A9A8CFE8FFC1B033DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250521061236-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195A01F9B43B25B19A64770DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250521063626-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250521063626-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|IA1PR12MB7759:EE_
x-ms-office365-filtering-correlation-id: 97686bcb-123b-4b13-d421-08dd98649fee
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NK2g1V0oE0bZsqG0I5ktNTXxN7P/kA7yh3M+ygCfSk37fs9/nfApY0cv41fb?=
 =?us-ascii?Q?RNgQn+p5WNm7vVVOg5E2qiEBNx7lvSgzRJh/TlNBlVIqv03wdqA55Agwb6NG?=
 =?us-ascii?Q?U1v6eY7mSZdIdWrcfcZphsV3/lcE7O7q3Yae5xBBboKlyi7b2QSgi1dVYqHe?=
 =?us-ascii?Q?qu2U0Yep9lRInlUhrOo3DxZPme9N38fnx4a/mNlewD3j3ee6NstC4Y9vhwTp?=
 =?us-ascii?Q?G3y7yJLkHNr2JnDsVJWM/udOpdlbcVnzugxDRGaom9jxVQADpCmTOmylXbPN?=
 =?us-ascii?Q?pHzU2HNNI884mbaW7W/rDlC1rdy0tUKJECrY+mPvqoL+wVOYIzS197r26KNx?=
 =?us-ascii?Q?io8cK5csHjqLYvaEq5V+8OTLxaF4vA4ING5DUE8jCG8QSGsW+WXWa7sRqvKe?=
 =?us-ascii?Q?/ErX4ji23DKNt5rOiLl2Bu23ri5W8sEnR5307Sd1f2Bor0u/9oYC4UxB7mIv?=
 =?us-ascii?Q?5Ycfqq6gg/Uou5vGXTw8rkfWgu0MrdjW2fGFrpzB1zuE/995LUITdJdg864o?=
 =?us-ascii?Q?WfdhEGJfVkU/++1yZMgd95nWnx2u6UkvNewLMA11QgOutdumKbDp1eEp3Cu7?=
 =?us-ascii?Q?Lxmt9NC2WQnoFCDgtV2YVbfd9VUrWoYqnSFS1Kt300Ka4Pa3d43J19EbVcvI?=
 =?us-ascii?Q?8ncVBP80XZS74Y8TALcxLDf/RUR0FAtqBgacCFzGTgY+hIuoMrMYVOZkL1su?=
 =?us-ascii?Q?m11Hhd2ZVWCkXEEx3UZpTf9IZAYmEifhld/UJy8QnJ01TmoVleMrxpwlsnga?=
 =?us-ascii?Q?6Gpk37vjA4dHcp2YWv6oRmL5yGJRnnyjRAEtXntpnv/WTvjOP137OkVoDUk/?=
 =?us-ascii?Q?8jw5gnLkwepX6NC3iDKyVB9XuYbt7XobVP4cC4vgMKwzjNk/CVuN1iTIcbRW?=
 =?us-ascii?Q?QOp3ZDq+mwCgDNWqE9ceNr9vsXx36OHcLCo7RBa8SpHv31IhGfvErEdi8FvQ?=
 =?us-ascii?Q?58QhwqCbf9omBHmg8qljLqlkEae+3z3NxvHYcxAne8xOOaWnYAi1yG72w75g?=
 =?us-ascii?Q?PeZj3C5G5zxbMyc2kLYaQfxcW9DAyCCvbETaERGWK76Ls4DiSw2V6ErO8lV6?=
 =?us-ascii?Q?BXJY70Y2OKO5AkU2OocZR37kaA7JvwDMK/BkXtFd9q8bIvjhyjJ5kgwGLhrR?=
 =?us-ascii?Q?eRrdmdFk1ZbCA0lGrzNZLspnsqjXNyj+NjGvxv8JDmdY0xJ5VlC6qFvQVRtJ?=
 =?us-ascii?Q?gQPvumEsvdyOOMJLgDbXVWajF/bNpeRQqd2246E2ZaWqsx0J5gTCtkfZKtkL?=
 =?us-ascii?Q?j5ldDNH6aItW/h+9WVSnk3N8ofZn0u6VVwhVo+zhvQ0qDikN8buvvoi0lASE?=
 =?us-ascii?Q?kfOath2GFILpLfGZp1bppEUsRpRA91KNn5UJNAAYKcsZYC9WNjwVv3a+AFOs?=
 =?us-ascii?Q?fkJLOc8fgr/oa0jcKymHcZFCm60Uy2aB6LhvlbIUetL5SeYaxlQWrhqFfhiy?=
 =?us-ascii?Q?KOWimVhHxgG2EMVvOf9SgnREP5CahVbonV+Y5RY9WIKs2Ph5sR1JK7f7xBnv?=
 =?us-ascii?Q?FIgJWVcXWCxjHUY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?J0Kuv6NNwVQpz3b4IP3S1zqMw/KeQSsiOrumVPSRBvZd3mm+eF8B0zR6RtGA?=
 =?us-ascii?Q?w609PVX+fsgml6MjePdw+6+fjvKY8BkaORLsZYKdSS5azgyEjiG+IhNgXGxZ?=
 =?us-ascii?Q?rOPOjm2X1422xp9OlaIF56aaQeypzaxiQV7oHxjQhac0o01wULvdP722zxR+?=
 =?us-ascii?Q?7OHNEXOMNE8m9Zn0JjVEeYE7OrXRnQGybNGAFsTor2sLsDCoVtgqrvbCA4Wh?=
 =?us-ascii?Q?vFtwQ9/2cGRMMI7UQckaPKdiGJMK0j+viyGb6zlXBQ35y4X5XYsBtEth+2aN?=
 =?us-ascii?Q?Mem4iDKXKAg6q/OVgTYk9FKdpKMIRDnOTAKld+hz0JpNT84EANfgochjlTP5?=
 =?us-ascii?Q?L1PJG5/wik7w8pFu6ZMs4rr3FiLYOGsohBxlfM4wJlcOj6vFNu4eFcGvCK+u?=
 =?us-ascii?Q?oFrJExObx+5zMSWzlLEq+MeffkRKdMMYHTfwN8/AEqRahkhX7NhLEw72h8/7?=
 =?us-ascii?Q?WtLKOcjWee0lVn3MuQP2TO0sFGbzhx+g6AtjSpnQbankcK2TqgC0HBgL8CzT?=
 =?us-ascii?Q?w6EXIdZOWAxzy59UCxRvrsmjpPhMvRp1dOmVR1rmNJyKP2wJkQpI4+oxkvZm?=
 =?us-ascii?Q?3DL5Q+vMpS1DP5SCRrbFWmwdftbeOsj3NSugxKALgFjAQbGVSjy2C0kMlfgQ?=
 =?us-ascii?Q?nB8/FOJeXAcHKS9M5agatKMFPXdHwdyBiHF487FglWiTTLV74UuK/90A7BBF?=
 =?us-ascii?Q?0uKnYScyNk06a3kKWjBoszAr81JA1Pi5GJIq2cXt6zAxSK/duTZ7TrulVB0d?=
 =?us-ascii?Q?D6i8XY9XCMCqmmMnpbhl/jG4YayzhSXmrfa/7euzy66QdHZj9FClovPOKDC7?=
 =?us-ascii?Q?fUEGp2AgZhP2VWuvN/iZzDwJTx2jNvE2P1/5X/L++FcuH6GpbTlklH8gMcWQ?=
 =?us-ascii?Q?KOC3AAFOePMou/TJ+gOsYYZ37ls5dHop+oXdTZIo+lI6OahxfFk0hOoOuwbH?=
 =?us-ascii?Q?OKcyU9fHw5tiZ8W0AiXsXR5Abr4ArIAM6GmoMzgpAVZ1jHbxV4Yfo/Ydmu/7?=
 =?us-ascii?Q?Gsx56oqSZPjzuzfXnttdnyjFDalX1lfcD84DwrqiJrwlkcPmtMLMZmsizBQj?=
 =?us-ascii?Q?2F4Q2ZeH3Cq/hqJK/SscBx4ZeJZI7bWnn4/uxXrIk84clWAsO5V/w3mK0ZGg?=
 =?us-ascii?Q?CmqVkw69tA0tp0mGdVkjWKQO9++hIdubT2QRmTd6Yxc5XEmj7AgHQHyxtJIv?=
 =?us-ascii?Q?JFlVazqxzInA4Jd4kLheDfBmiRv+ZQiq+EBQ5D3DPh7l6CSzINmLorx+Gox3?=
 =?us-ascii?Q?w1lpoNvQVvGWCYrG+9jR2+D2jUNL0wNVGPUaDyLHeGOA6EIlE88aZeQy+5Sm?=
 =?us-ascii?Q?4tJgx2Qa/5HC4OCaoqXlmVODzTbGDfoJ4/JP86VZZM/RoLtTFioIAe73ZoO2?=
 =?us-ascii?Q?5s0LawT6jxEXJAg7kD7rZyco8Om3DwNd9g6CQTd6n3twsXcOZdmkFIVUov1D?=
 =?us-ascii?Q?gsB6xhjgkW0BE93qFfcbTxO1QwZX0fKe1V3o3iYnULzsIW1+ya2gSxTBESy2?=
 =?us-ascii?Q?6fzYcKTsJV3vWAtULVtgcVODWQ/cPhAYgXb5Rq0tBBCwExzhiZuKITLPev8V?=
 =?us-ascii?Q?0PUDjrgaOdJ4YUuAPXU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 97686bcb-123b-4b13-d421-08dd98649fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 12:40:10.3421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OjBe6uW6TwcQxe/aQ7aFCFxsOz3B7MEKVl0CAdb9vIK2JoxWgIzPaRZQDncvoRiVm9fSt5i0KZBwbm1KYNbfWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, May 21, 2025 4:13 PM
>=20
> On Wed, May 21, 2025 at 10:34:46AM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, May 21, 2025 3:46 PM
> > >
> > > On Wed, May 21, 2025 at 09:32:30AM +0000, Parav Pandit wrote:
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Wednesday, May 21, 2025 2:49 PM
> > > > > To: Parav Pandit <parav@nvidia.com>
> > > > > Cc: stefanha@redhat.com; axboe@kernel.dk;
> > > > > virtualization@lists.linux.dev; linux-block@vger.kernel.or;
> > > > > stable@vger.kernel.org; NBU-Contact-Li Rongqing
> > > > > (EXTERNAL) <lirongqing@baidu.com>; Chaitanya Kulkarni
> > > > > <chaitanyak@nvidia.com>; xuanzhuo@linux.alibaba.com;
> > > > > pbonzini@redhat.com; jasowang@redhat.com; Max Gurtovoy
> > > > > <mgurtovoy@nvidia.com>; Israel Rukshin <israelr@nvidia.com>
> > > > > Subject: Re: [PATCH v1] virtio_blk: Fix disk deletion hang on
> > > > > device surprise removal
> > > > >
> > > > > On Wed, May 21, 2025 at 09:14:31AM +0000, Parav Pandit wrote:
> > > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > Sent: Wednesday, May 21, 2025 1:48 PM
> > > > > > >
> > > > > > > On Wed, May 21, 2025 at 06:37:41AM +0000, Parav Pandit wrote:
> > > > > > > > When the PCI device is surprise removed, requests may not
> > > > > > > > complete the device as the VQ is marked as broken. Due to
> > > > > > > > this, the disk deletion hangs.
> > > > > > > >
> > > > > > > > Fix it by aborting the requests when the VQ is broken.
> > > > > > > >
> > > > > > > > With this fix now fio completes swiftly.
> > > > > > > > An alternative of IO timeout has been considered, however
> > > > > > > > when the driver knows about unresponsive block device,
> > > > > > > > swiftly clearing them enables users and upper layers to rea=
ct
> quickly.
> > > > > > > >
> > > > > > > > Verified with multiple device unplug iterations with
> > > > > > > > pending requests in virtio used ring and some pending with =
the
> device.
> > > > > > > >
> > > > > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal
> > > > > > > > of virtio pci device")
> > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > Reported-by: lirongqing@baidu.com
> > > > > > > > Closes:
> > > > > > > >
> > > > > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55f
> > > > > > > b73c
> > > > > > > a9b4
> > > > > > > 74
> > > > > > > > 1@baidu.com/
> > > > > > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > > > > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > > > > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > > > > ---
> > > > > > > > changelog:
> > > > > > > > v0->v1:
> > > > > > > > - Fixed comments from Stefan to rename a cleanup function
> > > > > > > > - Improved logic for handling any outstanding requests
> > > > > > > >   in bio layer
> > > > > > > > - improved cancel callback to sync with ongoing done()
> > > > > > >
> > > > > > > thanks for the patch!
> > > > > > > questions:
> > > > > > >
> > > > > > >
> > > > > > > > ---
> > > > > > > >  drivers/block/virtio_blk.c | 95
> > > > > > > > ++++++++++++++++++++++++++++++++++++++
> > > > > > > >  1 file changed, 95 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/block/virtio_blk.c
> > > > > > > > b/drivers/block/virtio_blk.c index
> > > > > > > > 7cffea01d868..5212afdbd3c7
> > > > > > > > 100644
> > > > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > > > @@ -435,6 +435,13 @@ static blk_status_t
> > > > > > > > virtio_queue_rq(struct
> > > > > > > blk_mq_hw_ctx *hctx,
> > > > > > > >  	blk_status_t status;
> > > > > > > >  	int err;
> > > > > > > >
> > > > > > > > +	/* Immediately fail all incoming requests if the vq is br=
oken.
> > > > > > > > +	 * Once the queue is unquiesced, upper block layer
> > > > > > > > +flushes any
> > > > > > > pending
> > > > > > > > +	 * queued requests; fail them right away.
> > > > > > > > +	 */
> > > > > > > > +	if (unlikely(virtqueue_is_broken(vblk->vqs[qid].vq)))
> > > > > > > > +		return BLK_STS_IOERR;
> > > > > > > > +
> > > > > > > >  	status =3D virtblk_prep_rq(hctx, vblk, req, vbr);
> > > > > > > >  	if (unlikely(status))
> > > > > > > >  		return status;
> > > > > > >
> > > > > > > just below this:
> > > > > > >         spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> > > > > > >         err =3D virtblk_add_req(vblk->vqs[qid].vq, vbr);
> > > > > > >         if (err) {
> > > > > > >
> > > > > > >
> > > > > > > and virtblk_add_req calls virtqueue_add_sgs, so it will fail
> > > > > > > on a broken
> > > vq.
> > > > > > >
> > > > > > > Why do we need to check it one extra time here?
> > > > > > >
> > > > > > It may work, but for some reason if the hw queue is stopped in
> > > > > > this flow, it
> > > > > can hang the IOs flushing.
> > > > >
> > > > > > I considered it risky to rely on the error code ENOSPC
> > > > > > returned by non virtio-
> > > > > blk driver.
> > > > > > In other words, if lower layer changed for some reason, we may
> > > > > > end up in
> > > > > stopping the hw queue when broken, and requests would hang.
> > > > > >
> > > > > > Compared to that one-time entry check seems more robust.
> > > > >
> > > > > I don't get it.
> > > > > Checking twice in a row is more robust?
> > > > No. I am not confident on the relying on the error code -ENOSPC
> > > > from layers
> > > outside of virtio-blk driver.
> > >
> > > You can rely on virtio core to return an error on a broken vq.
> > > The error won't be -ENOSPC though, why would it?
> > >
> > Presently that is not the API contract between virtio core and driver.
> > When the VQ is broken the error code is EIO. This is from the code
> inspection.
>=20
> yes
>=20
> > If you prefer to rely on the code inspection of lower layer to define t=
he virtio-
> blk, I am fine and remove the two checks.
> > I just find it fragile, but if you prefer this way, I am fine.
>=20
> I think it's better, yes.
>=20
Ok. Will adapt this in v2.

> > > > If for a broken VQ, ENOSPC arrives, then hw queue is stopped and
> > > > requests
> > > could be stuck.
> > >
> > > Can you describe the scenario in more detail pls?
> > > where does ENOSPC arrive from? when is the vq get broken ...
> > >
> > ENOSPC arrives when it fails to enqueue the request in present form.
> > EIO arrives when VQ is broken.
> >
> > If in the future, ENOSPC arrives for broken VQ, following flow can trig=
ger a
> hang.
> >
> > cpu_0:
> > virtblk_broken_device_cleanup()
> > ...
> >     blk_mq_unquiesce_queue();
> >     ... stage_1:
> >     blk_mq_freeze_queue_wait().
> >
> >
> > Cpu_1:
> > Queue_rq()
> >   virtio_queue_rq()
> >      virtblk_add_req()
> >         -ENOSPC
> >             Stop_hw_queue()
> >                 At this point, new requests in block layer may get stuc=
k and may not
> be enqueued to queue_rq().
> >
> > >
> > > > > What am I missing?
> > > > > Can you describe the scenario in more detail?
> > > > >
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > @@ -508,6 +515,11 @@ static void virtio_queue_rqs(struct
> > > > > > > > rq_list
> > > > > *rqlist)
> > > > > > > >  	while ((req =3D rq_list_pop(rqlist))) {
> > > > > > > >  		struct virtio_blk_vq *this_vq =3D get_virtio_blk_vq(req-
> > > > > > > >mq_hctx);
> > > > > > > >
> > > > > > > > +		if (unlikely(virtqueue_is_broken(this_vq->vq))) {
> > > > > > > > +			rq_list_add_tail(&requeue_list, req);
> > > > > > > > +			continue;
> > > > > > > > +		}
> > > > > > > > +
> > > > > > > >  		if (vq && vq !=3D this_vq)
> > > > > > > >  			virtblk_add_req_batch(vq, &submit_list);
> > > > > > > >  		vq =3D this_vq;
> > > > > > >
> > > > > > > similarly
> > > > > > >
> > > > > > The error code is not surfacing up here from virtblk_add_req().
> > > > >
> > > > >
> > > > > but wait a sec:
> > > > >
> > > > > static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
> > > > >                 struct rq_list *rqlist) {
> > > > >         struct request *req;
> > > > >         unsigned long flags;
> > > > >         bool kick;
> > > > >
> > > > >         spin_lock_irqsave(&vq->lock, flags);
> > > > >
> > > > >         while ((req =3D rq_list_pop(rqlist))) {
> > > > >                 struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(req)=
;
> > > > >                 int err;
> > > > >
> > > > >                 err =3D virtblk_add_req(vq->vq, vbr);
> > > > >                 if (err) {
> > > > >                         virtblk_unmap_data(req, vbr);
> > > > >                         virtblk_cleanup_cmd(req);
> > > > >                         blk_mq_requeue_request(req, true);
> > > > >                 }
> > > > >         }
> > > > >
> > > > >         kick =3D virtqueue_kick_prepare(vq->vq);
> > > > >         spin_unlock_irqrestore(&vq->lock, flags);
> > > > >
> > > > >         if (kick)
> > > > >                 virtqueue_notify(vq->vq); }
> > > > >
> > > > >
> > > > > it actually handles the error internally?
> > > > >
> > > > For all the errors it requeues the request here.
> > >
> > > ok and they will not prevent removal will they?
> > >
> > It should not prevent removal.
> > One must be careful every single time changing it to make sure that hw
> queues are not stopped in lower layer, but may be this is ok.
> >
> > >
> > > > >
> > > > >
> > > > >
> > > > > > It would end up adding checking for special error code here as
> > > > > > well to abort
> > > > > by translating broken VQ -> EIO to break the loop in
> > > virtblk_add_req_batch().
> > > > > >
> > > > > > Weighing on specific error code-based data path that may
> > > > > > require audit from
> > > > > lower layers now and future, an explicit check of broken in this
> > > > > layer could be better.
> > > > > >
> > > > > > [..]
> > > > >
> > > > >
> > > > > Checking add was successful is preferred because it has to be
> > > > > done
> > > > > *anyway* - device can get broken after you check before add.
> > > > >
> > > > > So I would like to understand why are we also checking
> > > > > explicitly and I do not get it so far.
> > > >
> > > > checking explicitly to not depend on specific error code-based logi=
c.
> > >
> > >
> > > I do not understand. You must handle vq add errors anyway.
> >
> > I believe removal of the two vq broken checks should also be fine.
> > I would probably add the comment in the code indicating virtio block dr=
iver
> assumes that ENOSPC is not returned for broken VQ.
>=20
> You can include this in the series if you like. Tweak to taste:
>=20
Thanks for the patch. This virtio core comment update can be done at later =
point without fixes tag.
Will park for the later.

> -->
>=20
> virtio: document ENOSPC
>=20
> drivers handle ENOSPC specially since it's an error one can get from a wo=
rking
> VQ. Document the semantics.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> ---
>=20
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c =
index
> b784aab66867..97ab0cce527d 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2296,6 +2296,10 @@ static inline int virtqueue_add(struct virtqueue
> *_vq,
>   * at the same time (except where noted).
>   *
>   * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> + *
> + * NB: ENOSPC is a special code that is only returned on an attempt to
> + add a
> + * buffer to a full VQ. It indicates that some buffers are outstanding
> + and that
> + * the operation can be retried after some buffers have been used.
>   */
>  int virtqueue_add_sgs(struct virtqueue *_vq,
>  		      struct scatterlist *sgs[],

