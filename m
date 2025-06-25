Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA14268C55;
	Wed, 25 Jun 2025 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750878541; cv=fail; b=G70k1z4G/KG+5ViByYMXIngBDr1EnAn9LF2c9aWKgx0gETpwvwNcjWNcDSDAJGaPT+f62ugkJyHOqU7eJWqPQbHKtwse5c4GXs+zSj6P/t3EitHQ+Cf6MYk/bRak9+tNWkbVaJBNUzr51/D0m00L4LiI64fs5u4Wppt8vSvZMqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750878541; c=relaxed/simple;
	bh=DKndFJaevdIzDqf1/tytyB0kUjjKaJPtvntU/Tz6KMU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WVI4EuYRsBg/TyAlQPUN3bfKwfj/zpvrGe7L5Ya/4AOcWI7Izhwa5TNMuAdCqd/gH4MpPSYIWeriLa52yQ/zSEvRsEGrswVVDgMnsnJh+oGuN2BnewvWdevSx5f/uGfGabksjK+UXy1I6g6OtslgeLKezIfC+xDp55ntNP2I2rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MxdLjtIA; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MxdLjtIA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpbNtQDK3p2OFRG2wcJmftrY7SriJsAuRDiQus4ekIbaksMkmgR0B4cWfcvBZ9e2DEV+n6TtPe7c3C2buOm1WNuiHsxAqPHkv/GcYDHUg13889Ygmv4Gru7QiMWKi2Dc8tcaKQ0PDPSyTu2c3Tx5dRRV0SXcqeBkps7X9WhOUc/pretfH4gdckYFu9+un6NcsGZzC8nRkE6R+o3e9rOzdfk1pS8zq0luHaTr/VdnBWHN4M7sLLvZD/BNnZ6roWwnEKBinFCuQqYMbM3rDgEQwcxZ00XOJ8nlGXFF52EZYGmtdY4dWm3nG7cGQkZWHloCO0aeof0g+km+k5ClLrSHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MX1VvHZtS4P0vDePl3BErzuh4GUdQg6K+JhLKwf0CE=;
 b=U0HSa6Ngz3+K4DYJhiDGqwksbeMinbDsj3CdIJ8kakLT6GgA1fub9y8uH/ehh6Utdnkra4QyeGjJajEan2ekWwOs6wJz3GI5U7tblUbM23fdvoZVSnClH5DrsstSgmOoh8QQpNSRWXW+6dyn1GoiMQlARmCwflf4Ejb/fm+9BMlyxyxXeq9EOJHbYFxmJaE4SDY3n9JzkyWDJGT3dtiHaMIYvvwPlqj00/Y6/GazWlrL0Kv+8fjcbvgNG3R2d7qNKdb/AaB1xlEHZqqtUWFZOqhB8BzgXAeBTtkvBRWAg3llQxecAexi9uR22O2E5nWBkkhzIQeRbTSL2CcQU6hh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MX1VvHZtS4P0vDePl3BErzuh4GUdQg6K+JhLKwf0CE=;
 b=MxdLjtIANIPtQ3T71zJmSl5dQBlQWpE3PjeygyzyYp+AAf+0+dKtf5vLO5VbhtkCfqOdkeou/rncEhO2bV1RTLRKAfQcg/6OefBC86sl1GYsZo1KzIQtQsuBJ0gEATcM3t+6johGagygTaTNzRZNA200e8qrSH1gocCYXwLeyU3U73r17lUhy/wP9XuEghkl+aRm/jqKNdHaHbsArDS8+i1sRD0ax/1NIUS5GefKn2vNvndcVp+jQ3vTpNb84MxacuFC0EgY2E3kWDsvAGhbs7WCi5DQED6mKPGSFF9xXlv5wpdRU7cd/hyPhh5m4rEVmRc9N4d404PGuTzyMxYv9A==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 19:08:54 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%4]) with mapi id 15.20.8857.022; Wed, 25 Jun 2025
 19:08:54 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "NBU-Contact-Li Rongqing (EXTERNAL)"
	<lirongqing@baidu.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>, Israel Rukshin <israelr@nvidia.com>
Subject: RE: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Topic: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Index:
 AQHb02hI8rTGAA49eUeotBFzOHU9FbQSzIkAgAAAcqCAAAJ6gIAAARbQgAAMIgCAAHNgsIAAitiAgAAAT1CAAAsNAIAAeh/A
Date: Wed, 25 Jun 2025 19:08:54 +0000
Message-ID:
 <CY8PR12MB719531F26136254CC4764CD4DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250602024358.57114-1-parav@nvidia.com>
 <20250624185622.GB5519@fedora>
 <CY8PR12MB719579F7DAD8B0C0A98CBC7FDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250624150635-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71953552AE196A592A1892DDDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250624155157-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71953EFA4BD60651BFD66BD7DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625070228-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195AF9E34DF2A4821F590A8DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625074112-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250625074112-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DM4PR12MB6565:EE_
x-ms-office365-filtering-correlation-id: 3ca8a634-f597-4bcf-a4cd-08ddb41bbaa3
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?k+T86kuAEpuoOqt1pzbVG1dLf5Jw0QQ3CT8Vs0ocpcULb7CJgCijurbAPGTY?=
 =?us-ascii?Q?u6ItRLYFkKTX60x/4dVYazvUaR9xMfb5Tt2bonHH2G4DzIG7rhvqVgCScXfy?=
 =?us-ascii?Q?KBK4RmMjaFcPfOO/Sg/V4r3IGYZtltWLM/ZyQwe1yPm/x+w6gTqLKnNdJJId?=
 =?us-ascii?Q?ReKrjuDNCCk4jp4yvsSB4lEH8U7TpMzPvS5E3dIcnJfhfSYCqlXhZ6ztDkt5?=
 =?us-ascii?Q?ZuzhDBSzK2iVAC7nkMprddQ2DwgdyfwqFITLuC/GDe6JF+tiBIIdoS44JorL?=
 =?us-ascii?Q?K472CbR2fUXOGqD1oKHU7WxVi3s7Js3Oz4/O1w8oIUNvZCdgvUZG0XMp5sGg?=
 =?us-ascii?Q?GQAhdytBndqW17Qg0aEZzWLr0SS4naWA157jffpwY8oELjiwqT5gNe+K12cA?=
 =?us-ascii?Q?OcpFb3lkdMpAIJ6/KhLBT9VYh5hyFNDCMTIFMEjglkjdlfmU2j1zrfqWmPMw?=
 =?us-ascii?Q?D3C+0PyZQlKBUpcbfzx/JqgTrgpZGXHD/aos0QbECb7mLIs12COXoE4uId6b?=
 =?us-ascii?Q?r5xSKZEIjPucTE3Jm+xOzB//GeYFXglFs2ySDv0gQmSkIOnAYIGTLGIxsVpc?=
 =?us-ascii?Q?aokYRoQPTeHzc3MU3YQnfwuKhim5YeQ278bSBsV5wpuXg8dftO8rbHhOx68v?=
 =?us-ascii?Q?8cHPkxg3dV2tTdSPGtP5f/PoWXQPV3tiHNc/mt8u8rOCHBftyxpn0DBO7UcW?=
 =?us-ascii?Q?6YlvdRtG+OHUU0Izn7XhRZpfMsTfV2C8cx/lfD7ZT0DF3IkfPX+lZCOLw6Mq?=
 =?us-ascii?Q?FGunSkrFv/k+LioPNz+GPTiv5bcuLvDMOv0tfIY0f5nooQdVNIPtm6fOKa9b?=
 =?us-ascii?Q?JPemW5MCZqV1f1ICq075pY2lZNSYKioYpJTrzfiV38oi/kJ5pq7HGKnMNjeG?=
 =?us-ascii?Q?e/YGMpgOf/usORlIa1+M7FstGyVUZBI43KxG0/1sAVKYVE7zS1jtWS9+NY5L?=
 =?us-ascii?Q?/giaekjzAzKxBgnLUjPH8zSgkuQEj2fc5ZmNCHlWtyEvANea96Q7BiC0yCLW?=
 =?us-ascii?Q?aSYmh8CMVONDzG55r2WClbhOknjPM0zT1Cb05I4fC/4AeXaYzxJnZlHpbGHu?=
 =?us-ascii?Q?0OR64GXY5LxYJ88b+lRLYn/ss3QKFr5F0u8qTJRp+lzFwYbdCBqaAnUW9tgt?=
 =?us-ascii?Q?G+qfQf/Yx6m+Fp6gnbm7Czu7o4dhti+gLogE16K5sA/U8wrt5/VSA72fFxAQ?=
 =?us-ascii?Q?auQXWQmqewwTMYQiWpAYMLJSEqD31prTtx2By8e5CKrnrHOk9Z+knYQ6uOJh?=
 =?us-ascii?Q?Z5ZRBMB1MYHDR1XoMH00TCD0ezE/cwwCu2ykhMMRAntLk/H33aydA7ZE5j7f?=
 =?us-ascii?Q?C70zm1maw7d3jKDn+nrQvDfkfVYSJ++/HaMEu6HU5sXWE9B+VQ1EhbvsXZVU?=
 =?us-ascii?Q?oZMnoJExXO1sTVzOcC2J4vVzZd8YZqKuTXZVGjeb39CMaXM4GtFpSlJJBo2G?=
 =?us-ascii?Q?BKQPAropkNODLtFXTII7fx8ThXDA37ZlVwtFObD0DWbItMmH9fQxMGdcLhln?=
 =?us-ascii?Q?CSJQLFTl1lGsdUg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CAj6PkO3QqVOSYXB6QH2W7FKy8/k1DBMX7PfNTdC19nZWs74qZsqQfDLHC5j?=
 =?us-ascii?Q?aGrXhy0rLtDeAjX5cynsqPVehuEjxnI4qkkDsKbv3OPg/yCFyCfWguEuPB8S?=
 =?us-ascii?Q?Ln+ql6WF+gIMGyFtmEpfWyX9rUHhjyZHMib+spogoP/0r8TYh2imdExE3AcT?=
 =?us-ascii?Q?yyQEzBrqBJphqE7ibu1W/Q2T0+oRYeGemSyGgSqsVMzIo/PYD9WywR6ifD5m?=
 =?us-ascii?Q?ci/F+JFvK/T10qwXfEEIXGMVjRwILpWwLfl66ij55iZzaThttHicc0Y2YixI?=
 =?us-ascii?Q?c2Cb8EYaLc/k+lc0KUijcQk1AbtsyrjRWWnQVGMM1PSrv02aYm2c0DqiFxYa?=
 =?us-ascii?Q?gHhXXwlfb3qsH0/RZDrXWvH20ItOt/EIy5OhL0rfJHGkE7MTy/DEaS6ON3Tq?=
 =?us-ascii?Q?bxtzfOBv8By3lQ6YinPp8gZd1gO67qdoBSrXJkBGymm7LgVF5xOseloFFvMK?=
 =?us-ascii?Q?0VCz7JVEOkv45ZSaa9sZIF9Ty9GaE/vL9qMykwu6w4ZgIqboFvkzMDdar+/k?=
 =?us-ascii?Q?XC+ounQfJh33P1Hj99xVeEkMR6AdG51GAtDijm8KSWFASlpNHjDj0KMRpYh6?=
 =?us-ascii?Q?+83vnqLolzBDbu5z7YUokQw9+w5mSPMqGd73GBAt9fjIe/NFBY8eKyRdgd+6?=
 =?us-ascii?Q?HAb1tmOLwoO35B+AJRI+BTUvpuTdVkSvx/RBph63Xs70LDhNjxIAbuXyaPKT?=
 =?us-ascii?Q?oLlpKv2JnsKXRtvPgVrK8v2XYCiww8Zxyeorwmkvyq1pN7PEP/HDTXWR28Kv?=
 =?us-ascii?Q?Fb9zTdGdvLvg7YT1gpVwbEbvNSOIBAG5jPcDVAWuZXs/mZrtrLWmFDE281MA?=
 =?us-ascii?Q?T5/XDcnlWkE1q1lj/XCHldDxqUaSkCAwRiXfzievWqhYQJLsl/yVYapHcyZE?=
 =?us-ascii?Q?mnjAif46DD2J7QcLMsYWpOoAC+mrWeJNoBTAqtnahHxFLAR1hHWYAjHtG/fa?=
 =?us-ascii?Q?ux7Bi/hLG00vgT7P+nHfqXfANGXet+jO00bzSQFoOrli++Xi8zgVsObcVx7u?=
 =?us-ascii?Q?UFeZo+VtRKUmL5VArNxVDoyQnnineafMAGQ5UH0/99OIEofCLHvXohDgF84M?=
 =?us-ascii?Q?vP3X9v8JfrfXqJ7jNHTGtAYXfCFyGOjqtQwqQ6nVA+wpka+FyC4qOJq52zL2?=
 =?us-ascii?Q?0KaK0phxQvrcs9xRselEqQuQVdR9R4d1CvKpTqlXskWkXRjVl5eAAOnCBA+t?=
 =?us-ascii?Q?/uHLm+1M9QhmUbgFUckQ0iHE+8+KbM7/F0x7k5UVYue6iXwqHRHJ8zP4oQ+Z?=
 =?us-ascii?Q?d9XKqcnFXzHnvnFlm3+sZfB310WbvVJPjGZ2QCdgFLQ/PNawRzvnZURE8qph?=
 =?us-ascii?Q?+zpj8YcQSRqmtyAmHkntiVOwsYVvhGtAx/hElbIIC9MI2+NXah9ApL2H4zTa?=
 =?us-ascii?Q?aQlDGCiu+T2GzWi/NYinpj8dIMEfuiVlzzdrUl9wE3gQcTWhAilGfQy9D/zo?=
 =?us-ascii?Q?UhV/hGBOgA0uF0EeBFqwwdZ10hYOKr3MB81TSFgJsi8UCyq/sSpXnzjN5+oM?=
 =?us-ascii?Q?RyjSSdnw/0ZRswtfw88kM+Imv+2dSOYhH9SU9roVX0UYyNyvecek9LaXCOPp?=
 =?us-ascii?Q?StM6DvFr0A3cAxZgBNc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca8a634-f597-4bcf-a4cd-08ddb41bbaa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 19:08:54.4605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pe0X0+3D3Rcn88HJi30sobRrbd2scik+RtEdw1BPqOztBUSCYnuY8OngHP/b1Wdkzo6ajKy4RPDiTBwJy0yG0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6565


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 25 June 2025 05:15 PM
>=20
> On Wed, Jun 25, 2025 at 11:08:42AM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: 25 June 2025 04:34 PM
> > >
> > > On Wed, Jun 25, 2025 at 02:55:27AM +0000, Parav Pandit wrote:
> > > >
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: 25 June 2025 01:24 AM
> > > > >
> > > > > On Tue, Jun 24, 2025 at 07:11:29PM +0000, Parav Pandit wrote:
> > > > > >
> > > > > >
> > > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > Sent: 25 June 2025 12:37 AM
> > > > > > >
> > > > > > > On Tue, Jun 24, 2025 at 07:01:44PM +0000, Parav Pandit wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > > > > Sent: 25 June 2025 12:26 AM
> > > > > > > > >
> > > > > > > > > On Mon, Jun 02, 2025 at 02:44:33AM +0000, Parav Pandit
> wrote:
> > > > > > > > > > When the PCI device is surprise removed, requests may
> > > > > > > > > > not complete the device as the VQ is marked as broken.
> > > > > > > > > > Due to this, the disk deletion hangs.
> > > > > > > > >
> > > > > > > > > There are loops in the core virtio driver code that
> > > > > > > > > expect device register reads to eventually return 0:
> > > > > > > > > drivers/virtio/virtio_pci_modern.c:vp_reset()
> > > > > > > > > drivers/virtio/virtio_pci_modern_dev.c:vp_modern_set_que
> > > > > > > > > ue_r
> > > > > > > > > eset
> > > > > > > > > ()
> > > > > > > > >
> > > > > > > > > Is there a hang if these loops are hit when a device has
> > > > > > > > > been surprise removed? I'm trying to understand whether
> > > > > > > > > surprise removal is fully supported or whether this
> > > > > > > > > patch is one step in that
> > > > > direction.
> > > > > > > > >
> > > > > > > > In one of the previous replies I answered to Michael, but
> > > > > > > > don't have the link
> > > > > > > handy.
> > > > > > > > It is not fully supported by this patch. It will hang.
> > > > > > > >
> > > > > > > > This patch restores driver back to the same state what it
> > > > > > > > was before the fixes
> > > > > > > tag patch.
> > > > > > > > The virtio stack level work is needed to support surprise
> > > > > > > > removal, including
> > > > > > > the reset flow you rightly pointed.
> > > > > > >
> > > > > > > Have plans to do that?
> > > > > > >
> > > > > > Didn't give enough thoughts on it yet.
> > > > >
> > > > > This one is kind of pointless then? It just fixes the specific
> > > > > race window that your test harness happens to hit?
> > > > >
> > > > It was reported by Li from Baidu, whose tests failed.
> > > > I missed to tag "reported-by" in v5. I had it until v4. :(
> > > >
> > > > > Maybe it's better to wait until someone does a comprehensive fix.=
.
> > > > >
> > > > >
> > > > Oh, I was under impression is that you wanted to step forward in
> > > > discussion
> > > of v4.
> > > > If you prefer a comprehensive support across layers of virtio, I
> > > > suggest you
> > > should revert the cited patch in fixes tag.
> > > >
> > > > Otherwise, it is in degraded state as virtio never supported surpri=
se
> removal.
> > > > By reverting the cited patch (or with this fix), the requests and
> > > > disk deletion
> > > will not hang.
> > >
> > > But they will hung in virtio core on reset, will they not? The tests
> > > just do not happen to trigger this?
> > >
> > It will hang if it a true surprise removal which no device did so far b=
ecause it
> never worked.
> > (or did, but always hung that no one reported yet)
> >
> > I am familiar with 2 or more PCI devices who reports surprise removal,
> which do not complete the requests but yet allows device reset flow.
> > This is because device is still there on the PCI bus. Only via side ban=
d signals
> device removal was reported.
>=20
> So why do we care about it so much? I think it's great this patch exists,=
 for
> example it makes it easier to test surprise removal and find more bugs. B=
ut is
> it better to just have it hang unconditionally? Are we now making a
> commitment that it's working - one we don't seem to intend to implement?
>
The patch improves the situation from its current state.
But as you posted, more changes in pci layer are needed.
I didn't audit where else it may be needed.

vp_reset() may need to return the status back of successful/failure reset.
Otherwise during probe(), vp_reset() aborts the reset and attempts to load =
the driver for removed device.

I guess suspend() callback also infinitely waits during freezing the queue =
also needs adaptation.

> > But I agree that for full support, virtio all layer changes would be ne=
eded as
> new functionality (without fixes tag  :) ).
>=20
>=20
> Or with a fixes tag - lots of people just use it as a signal to mean "whe=
re can
> this be reasonably backported to".
>
Yes, I think the fix for the older kernels is needed, hence I cced stable t=
oo.
=20
>=20
> > > > Please let me know if I should re-send to revert the patch listed i=
n fixes
> tag.
> > > >
> > > > > > > > > Apart from that, I'm happy with the virtio_blk.c aspects
> > > > > > > > > of the
> > > patch:
> > > > > > > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > > > >
> > > > > > > > Thanks.
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Fix it by aborting the requests when the VQ is broken.
> > > > > > > > > >
> > > > > > > > > > With this fix now fio completes swiftly.
> > > > > > > > > > An alternative of IO timeout has been considered,
> > > > > > > > > > however when the driver knows about unresponsive block
> > > > > > > > > > device, swiftly clearing them enables users and upper
> > > > > > > > > > layers to react
> > > quickly.
> > > > > > > > > >
> > > > > > > > > > Verified with multiple device unplug iterations with
> > > > > > > > > > pending requests in virtio used ring and some pending
> > > > > > > > > > with the
> > > device.
> > > > > > > > > >
> > > > > > > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise
> > > > > > > > > > removal of virtio pci device")
> > > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > > Reported-by: Li RongQing <lirongqing@baidu.com>
> > > > > > > > > > Closes:
> > > > > > > > > > https://lore.kernel.org/virtualization/c45dd68698cd472
> > > > > > > > > > 38c5
> > > > > > > > > > 5fb7
> > > > > > > > > > 3ca9
> > > > > > > > > > b474
> > > > > > > > > > 1@baidu.com/
> > > > > > > > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > > > > > > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > > > > > > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > > > > > >
> > > > > > > > > > ---
> > > > > > > > > > v4->v5:
> > > > > > > > > > - fixed comment style where comment to start with one
> > > > > > > > > > empty line at start
> > > > > > > > > > - Addressed comments from Alok
> > > > > > > > > > - fixed typo in broken vq check
> > > > > > > > > > v3->v4:
> > > > > > > > > > - Addressed comments from Michael
> > > > > > > > > > - renamed virtblk_request_cancel() to
> > > > > > > > > >   virtblk_complete_request_with_ioerr()
> > > > > > > > > > - Added comments for
> > > > > > > > > > virtblk_complete_request_with_ioerr()
> > > > > > > > > > - Renamed virtblk_broken_device_cleanup() to
> > > > > > > > > >   virtblk_cleanup_broken_device()
> > > > > > > > > > - Added comments for virtblk_cleanup_broken_device()
> > > > > > > > > > - Moved the broken vq check in virtblk_remove()
> > > > > > > > > > - Fixed comment style to have first empty line
> > > > > > > > > > - replaced freezed to frozen
> > > > > > > > > > - Fixed comments rephrased
> > > > > > > > > >
> > > > > > > > > > v2->v3:
> > > > > > > > > > - Addressed comments from Michael
> > > > > > > > > > - updated comment for synchronizing with callbacks
> > > > > > > > > >
> > > > > > > > > > v1->v2:
> > > > > > > > > > - Addressed comments from Stephan
> > > > > > > > > > - fixed spelling to 'waiting'
> > > > > > > > > > - Addressed comments from Michael
> > > > > > > > > > - Dropped checking broken vq from queue_rq() and
> queue_rqs()
> > > > > > > > > >   because it is checked in lower layer routines in
> > > > > > > > > > virtio core
> > > > > > > > > >
> > > > > > > > > > v0->v1:
> > > > > > > > > > - Fixed comments from Stefan to rename a cleanup
> > > > > > > > > > function
> > > > > > > > > > - Improved logic for handling any outstanding requests
> > > > > > > > > >   in bio layer
> > > > > > > > > > - improved cancel callback to sync with ongoing done()
> > > > > > > > > > ---
> > > > > > > > > >  drivers/block/virtio_blk.c | 95
> > > > > > > > > > ++++++++++++++++++++++++++++++++++++++
> > > > > > > > > >  1 file changed, 95 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/block/virtio_blk.c
> > > > > > > > > > b/drivers/block/virtio_blk.c index
> > > > > > > > > > 7cffea01d868..c5e383c0ac48
> > > > > > > > > > 100644
> > > > > > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > > > > > @@ -1554,6 +1554,98 @@ static int virtblk_probe(struct
> > > > > > > > > > virtio_device
> > > > > > > > > *vdev)
> > > > > > > > > >  	return err;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +/*
> > > > > > > > > > + * If the vq is broken, device will not complete reque=
sts.
> > > > > > > > > > + * So we do it for the device.
> > > > > > > > > > + */
> > > > > > > > > > +static bool
> > > > > > > > > > +virtblk_complete_request_with_ioerr(struct
> > > > > > > > > > +request *rq, void *data) {
> > > > > > > > > > +	struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(rq);
> > > > > > > > > > +	struct virtio_blk *vblk =3D data;
> > > > > > > > > > +	struct virtio_blk_vq *vq;
> > > > > > > > > > +	unsigned long flags;
> > > > > > > > > > +
> > > > > > > > > > +	vq =3D &vblk->vqs[rq->mq_hctx->queue_num];
> > > > > > > > > > +
> > > > > > > > > > +	spin_lock_irqsave(&vq->lock, flags);
> > > > > > > > > > +
> > > > > > > > > > +	vbr->in_hdr.status =3D VIRTIO_BLK_S_IOERR;
> > > > > > > > > > +	if (blk_mq_request_started(rq) &&
> > > > > !blk_mq_request_completed(rq))
> > > > > > > > > > +		blk_mq_complete_request(rq);
> > > > > > > > > > +
> > > > > > > > > > +	spin_unlock_irqrestore(&vq->lock, flags);
> > > > > > > > > > +	return true;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +/*
> > > > > > > > > > + * If the device is broken, it will not use any
> > > > > > > > > > +buffers and waiting
> > > > > > > > > > + * for that to happen is pointless. We'll do the
> > > > > > > > > > +cleanup in the driver,
> > > > > > > > > > + * completing all requests for the device.
> > > > > > > > > > + */
> > > > > > > > > > +static void virtblk_cleanup_broken_device(struct
> > > > > > > > > > +virtio_blk *vblk)
> > > {
> > > > > > > > > > +	struct request_queue *q =3D vblk->disk->queue;
> > > > > > > > > > +
> > > > > > > > > > +	/*
> > > > > > > > > > +	 * Start freezing the queue, so that new requests
> > > > > > > > > > +keeps
> > > > > waiting at the
> > > > > > > > > > +	 * door of bio_queue_enter(). We cannot fully freeze
> > > > > > > > > > +the queue
> > > > > > > > > because
> > > > > > > > > > +	 * frozen queue is an empty queue and there are
> > > > > > > > > > +pending
> > > > > requests, so
> > > > > > > > > > +	 * only start freezing it.
> > > > > > > > > > +	 */
> > > > > > > > > > +	blk_freeze_queue_start(q);
> > > > > > > > > > +
> > > > > > > > > > +	/*
> > > > > > > > > > +	 * When quiescing completes, all ongoing dispatches
> > > > > > > > > > +have
> > > > > completed
> > > > > > > > > > +	 * and no new dispatch will happen towards the
> driver.
> > > > > > > > > > +	 */
> > > > > > > > > > +	blk_mq_quiesce_queue(q);
> > > > > > > > > > +
> > > > > > > > > > +	/*
> > > > > > > > > > +	 * Synchronize with any ongoing VQ callbacks that
> > > > > > > > > > +may have
> > > > > started
> > > > > > > > > > +	 * before the VQs were marked as broken. Any
> > > > > > > > > > +outstanding
> > > > > requests
> > > > > > > > > > +	 * will be completed by
> > > > > virtblk_complete_request_with_ioerr().
> > > > > > > > > > +	 */
> > > > > > > > > > +	virtio_synchronize_cbs(vblk->vdev);
> > > > > > > > > > +
> > > > > > > > > > +	/*
> > > > > > > > > > +	 * At this point, no new requests can enter the
> > > > > > > > > > +queue_rq()
> > > > > and
> > > > > > > > > > +	 * completion routine will not complete any new
> > > > > > > > > > +requests either for
> > > > > > > > > the
> > > > > > > > > > +	 * broken vq. Hence, it is safe to cancel all request=
s
> which are
> > > > > > > > > > +	 * started.
> > > > > > > > > > +	 */
> > > > > > > > > > +	blk_mq_tagset_busy_iter(&vblk->tag_set,
> > > > > > > > > > +
> 	virtblk_complete_request_with_ioerr,
> > > > > vblk);
> > > > > > > > > > +
> > > > > > > > > > +blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> > > > > > > > > > +
> > > > > > > > > > +	/*
> > > > > > > > > > +	 * All pending requests are cleaned up. Time to
> > > > > > > > > > +resume so
> > > > > that disk
> > > > > > > > > > +	 * deletion can be smooth. Start the HW queues so
> > > > > > > > > > +that when queue
> > > > > > > > > is
> > > > > > > > > > +	 * unquiesced requests can again enter the driver.
> > > > > > > > > > +	 */
> > > > > > > > > > +	blk_mq_start_stopped_hw_queues(q, true);
> > > > > > > > > > +
> > > > > > > > > > +	/*
> > > > > > > > > > +	 * Unquiescing will trigger dispatching any pending
> > > > > > > > > > +requests
> > > > > to the
> > > > > > > > > > +	 * driver which has crossed bio_queue_enter() to the
> driver.
> > > > > > > > > > +	 */
> > > > > > > > > > +	blk_mq_unquiesce_queue(q);
> > > > > > > > > > +
> > > > > > > > > > +	/*
> > > > > > > > > > +	 * Wait for all pending dispatches to terminate
> > > > > > > > > > +which may
> > > > > have been
> > > > > > > > > > +	 * initiated after unquiescing.
> > > > > > > > > > +	 */
> > > > > > > > > > +	blk_mq_freeze_queue_wait(q);
> > > > > > > > > > +
> > > > > > > > > > +	/*
> > > > > > > > > > +	 * Mark the disk dead so that once we unfreeze the
> > > > > > > > > > +queue,
> > > > > requests
> > > > > > > > > > +	 * waiting at the door of bio_queue_enter() can be
> > > > > > > > > > +aborted right
> > > > > > > > > away.
> > > > > > > > > > +	 */
> > > > > > > > > > +	blk_mark_disk_dead(vblk->disk);
> > > > > > > > > > +
> > > > > > > > > > +	/* Unfreeze the queue so that any waiting requests
> > > > > > > > > > +will be
> > > > > aborted. */
> > > > > > > > > > +	blk_mq_unfreeze_queue_nomemrestore(q);
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >  static void virtblk_remove(struct virtio_device *vdev)=
  {
> > > > > > > > > >  	struct virtio_blk *vblk =3D vdev->priv; @@ -1561,6
> > > > > > > > > > +1653,9 @@ static void virtblk_remove(struct virtio_dev=
ice
> *vdev)
> > > > > > > > > >  	/* Make sure no work handler is accessing the device.
> */
> > > > > > > > > >  	flush_work(&vblk->config_work);
> > > > > > > > > >
> > > > > > > > > > +	if (virtqueue_is_broken(vblk->vqs[0].vq))
> > > > > > > > > > +		virtblk_cleanup_broken_device(vblk);
> > > > > > > > > > +
> > > > > > > > > >  	del_gendisk(vblk->disk);
> > > > > > > > > >  	blk_mq_free_tag_set(&vblk->tag_set);
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > 2.34.1
> > > > > > > > > >

