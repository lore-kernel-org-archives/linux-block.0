Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7844223C4F2
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819115; cv=fail; b=V+MJbak7Hx0RJM3TkhPlQIQ52JrvRhqPGT7KfIcSuMBzxWQPlN82J+X5wnR81jpzgrx/TekP2ra0nNlgZLQ+tmV0u2UgJizjgvX5xzBjDtiNBAnrELWdJW2PJBDvBi08bqjCKOr8A5ZEDy0sd6sqMhC2zaNO2fLZqxEaf+y2k3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819115; c=relaxed/simple;
	bh=4p0Qb2oela3kJ1ALp0Od/1qzYEM3yQNrASHjUIAYOo0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X+8gYQ6je7Fo2oZVcqCUjkyAIz8BmIURX8wYkgpvatA61ub3urEza+tCjsJ8qvrOl64yU/41c7Y93VclHZhdXkGicdzMcKpMcskQNEC1lSA+Vwv5yypmH2pWIDUyaj7FWO6kWuAQEPR+6bIR6pxk7z7AUAgYbLWib8p/aVNhmtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UIz1lkBK; arc=fail smtp.client-ip=40.107.100.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UIz1lkBK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkdJ4V7N6ygrZOc0vJpvBOfRWmUsBRN9DEUmieSLb1ttpFRRO6hgFP8QpLTbjqeqdKEUGTc7LvapNc5mPARHZeW0sokDEaepvkTYhQPYqkQ3Y/cRQuEX4T4lPBQJY871qJhm2O6psGQmu6fpL5d/q9vLPMCBZu85SfA745G/Z/BbLee5HD8DwTMySbyuT9ctHtWo4Mmz0mFBq3tihRTnZIpofJjr6BxpH7W9TUTyvVwEGjVbEWC3xZyB9RgmOorThS1tXKYQodYf8udrbZCDJX7sYYXRCQpEt10OBdRoPWisFWt5k/c7ZN3kFD8jHgAqz8A/zoJZaI3WCysMlvOk+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4p0Qb2oela3kJ1ALp0Od/1qzYEM3yQNrASHjUIAYOo0=;
 b=aCn5kWnYzneuTfBgaaa8ycFqrjo9sNMxdYEN0RlG2W+6Ne5K6/Tj3HHyk8AY+TAiO/CjiaCAYqxEKvcxJqJkQ+r96KIJ5Q0NlLRIBUv7NYuhOQr2d89Nexi1BuG3PQlq2tUEAfRLjAACHMsCB3SlzjDgWCxscWVK4iwrzevk5ydXNohoRutI8n6eIJcFfmDp6tBNXS4XtlF7jS5nFdAmB+9qOkcrU94BtGracOACz8x5DOlKAHrnYEEQ1tUApSwHp27F6a/zs93aESTNlr1zkqYjva7BizxdGxI2pBb93kUI6W7ty1I4126EGYX5JYKQbdRx3j4WJ/MZhyHgW76qNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p0Qb2oela3kJ1ALp0Od/1qzYEM3yQNrASHjUIAYOo0=;
 b=UIz1lkBKFpRqEXgqru4zOsJapxxVIbekeuUGuermOe4sprasGARf+H4dmaU1Ub3wXA8KwouSSmPU7aP8GlOE6UDIF5QHHRWPfmwIJXzxHbsMTztC0j1U3kFUw8bKGLuzkJOrCsUmvAJwTdAbpSVSnHv1g7aPfvwKS4k8r47p9pD8of5J6xAmctbdtBYmBU1XJyXQDeuA7mMexAXvRK5sU758n5R4Vb6vReCl090olpaX5H6QrdP95I6sNr85l/hTgq7Ewkiuf/TYApDyjyeBsIYgl1Sscps2wIVMstRQZqSWwZzHPI/5CBSdTiBG8ARTrukX4IhDlc3ebBgfmeJmeA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 09:18:30 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%4]) with mapi id 15.20.8699.026; Wed, 21 May 2025
 09:18:29 +0000
From: Parav Pandit <parav@nvidia.com>
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "stefanha@redhat.com" <stefanha@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "NBU-Contact-Li Rongqing (EXTERNAL)"
	<lirongqing@baidu.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Israel Rukshin
	<israelr@nvidia.com>
Subject: RE: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Topic: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Index: AQHbyhrdL96Oqawka0G+Ryv5JzR6PLPcvXWAgAALoUCAAASOUA==
Date: Wed, 21 May 2025 09:18:29 +0000
Message-ID:
 <CY8PR12MB719585BEB8E62DDB228942BDDC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250521062744.1361774-1-parav@nvidia.com>
 <20250521041506-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195F56A84CAF0D486B82239DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
In-Reply-To:
 <CY8PR12MB7195F56A84CAF0D486B82239DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|MN2PR12MB4189:EE_
x-ms-office365-filtering-correlation-id: 070d3d02-28cb-4f18-4513-08dd9848737b
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bmdjARbc/O9B3ySUczB2Hj34ZeaUqhxVYX1GXVU6Paf1CxIrdSM6xhPPaPxt?=
 =?us-ascii?Q?m59YEGbcXWdOormKKnAoHFmTKKXYHViS+CwavZ0R6I+AepWptGraaHwsQb6r?=
 =?us-ascii?Q?S2tEtEUaXHbrEXkoIX+IuKmmD+keJlB4rm+uSIQG6J+PhhiVGACd/KPZEMW9?=
 =?us-ascii?Q?RR919EEs/6gsowQtlPBs8jms7H0yjlh2T9qEVVxZeCAjMpzKvTuD32HRecYW?=
 =?us-ascii?Q?OfpjD5yeun8EonGca13MD723spele9bws8Vh5+c1weSCC/Ga9R44n19zJzwj?=
 =?us-ascii?Q?6EtVmr/6DOJ2YE4BXqfCNQLBqxMA7iKWKrZEEI+74xli3qD1n6QBh4S+sVxc?=
 =?us-ascii?Q?Th9COAm9vdqsp0+w4KMkviz5EiR92rWRiYca5g70nlqxsZHx/vbDSM8DUNv5?=
 =?us-ascii?Q?CKeGBEbkJOr/XTKGq871DK3L0YUJ0/X04DdSAK8tWp4dCbP/f01gD8fJvs+2?=
 =?us-ascii?Q?vQbilgo9oz0RduFq2oXj2X8m+hjJDj0GdJtXju4WVSw7p4Q/0M+yza0BuYOM?=
 =?us-ascii?Q?36oW62HdsXm3sDgdWxTyR8EwKntRnK+izdKGwz3ZRaWKUdW8UeAUJ5hKNGbZ?=
 =?us-ascii?Q?O3vqOhefUEk7OuCATo5pzjsApY/8uyPCiL+wIpSfdhSP6ca/hM/19WbDFiFR?=
 =?us-ascii?Q?Z7vNZ6RYrqF4Tu77j4DK9F/ynDFcWdsQ6cSrFPu7IlKead4gt9csPA6K3OI/?=
 =?us-ascii?Q?WSVXjGZodXAfVB/SaiJ1AcFkKrc5U/hscdrHkdwgpM86rpnEGVkFfgBB6zxW?=
 =?us-ascii?Q?zIkOtCF320SFKj8IsuN3Y7qZRM0hGaN2kdpcMd5R6tMdsnrlXbrocfReE+Bt?=
 =?us-ascii?Q?EW4b0IkHolE+tmveNJDaVOhBgtSNCMwCRUDSASCBdVqbLQQ84OUWc3alS2ov?=
 =?us-ascii?Q?3bGgDagbt4iODkupaoWcm5O90xNEKm/HhcmVx7vA4h6GF++udrwdQgPPQtiS?=
 =?us-ascii?Q?8+o4nRwxv/C3Y1Jrw69iQqoowtNr0DpWkuBBqVbeaYjzaoKeW75uHRuvPSDY?=
 =?us-ascii?Q?g6o3h5+6hcj23J4OgRVSU/A/9TEqz4h8oJMUGSds34/iWpDvqoPtACOPlhvm?=
 =?us-ascii?Q?hHV8atRzRHVdmrK/xNNCu6COKgOXWTEmUqm40A1lM4vjQUjvvK33AittFm8d?=
 =?us-ascii?Q?LU1tJGb9mMnrC/2yIbG7Vo6/tQB9xeSRfNujdr8j3A3z2qilDnoTphWeIXJV?=
 =?us-ascii?Q?3UXBoCPIXAHVj6611MTNkrfcN79mCAE+Ovs64EdCe1fQ6wqZFxumiSqCi2td?=
 =?us-ascii?Q?yYTY1Tf6haV9bEiCyL9X5kDzncgYfgvNJiBWthl+qnDQZ1CYd2kcwm9PKano?=
 =?us-ascii?Q?p9797wQLAw5liY0HBJGKSlvt+xQFa7DtNDmSkBVCujbT3F1nlxet7I/9jpGt?=
 =?us-ascii?Q?Gw7hGAp7KMDDoyiYiE9JnkFpBv4Z5/7XC+sEZN1y5qnTtNTeZY3eQfRkpqwj?=
 =?us-ascii?Q?H9ybBZU8+5yGWbKJUgU8p6cInS9TVoknxsCYdHOVRGwXI1SOo3S3NA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SLY1kUp4DOVUP4WK1o6uwL6AsIIDqnKTQxQVDVJDAFZQDC1D0wKFgm37ogCU?=
 =?us-ascii?Q?MxBCkKGCH81LHXZUhPzvyBnmw+Pmo2n3OmVk2fDXTk1QkqBFcau9WG+RHtIs?=
 =?us-ascii?Q?KY6ncCTw5A/t2M4mrV/RGz1AXHbyum44hyQwABEUT1hkgl37ZXDLeun4R803?=
 =?us-ascii?Q?tYcEEoWlOjex5iBIrRpUBHBpHOFITOqza+Fun/U89dhAWWTydtqx/bjNSPme?=
 =?us-ascii?Q?5lF6FN6Q1FZCgZVLMUD026Bb6c/QF2w3QRtoj7TiOqcgfZ7Os56LWEmainKf?=
 =?us-ascii?Q?cYMXzwxurHzaUYfS9XhKFkl9N+2eSb2DJO19n23D47H2B+dfku5f6X4DT1Py?=
 =?us-ascii?Q?f6oBqAclVn5oBvgOI90J8mDQl1/D3B+i92CGg2tGqIzJN4oIk3AtaD/GXqG6?=
 =?us-ascii?Q?8DPPef7vXDNxswxkIpJsrlLUzhkTZYdVsg58+jCDwXUOUMYbSwVg9FSD/vUa?=
 =?us-ascii?Q?GgSojY2iUK3H3od5KCdv3lw+Ln4PHYDrljp05wwkgxOSfpzg5zE7TeM74zMH?=
 =?us-ascii?Q?zhuNaQ5zu5Mr0/QF7uEuhkn7gzj7d3UBGOcOZuFvhmV0oBrZFgrOSE16cxp4?=
 =?us-ascii?Q?+uzJppEi/zFq7gvHNN8tKFCSX2JsxarCituv0qmlZCQsQcn7jwSkj2m/36Ny?=
 =?us-ascii?Q?v2OQOTimuDywk3X+Me75w5+/aOJcBb6fwTNj1OZE8r3GetHD0+Ie3StUC2lx?=
 =?us-ascii?Q?Dy/30r/TP8/d69yMltlL9quEDbBBck4iG3iDeNhOKkwd+Mlur5QmqnBH1+YS?=
 =?us-ascii?Q?JrEwwFAfV3mzUOZoexFa5182usgZlYq4WpdS75zooaOzikXznlJAE1TCR/U7?=
 =?us-ascii?Q?ELGc4nohZnl/PDaNIx+IZg9oh7tn87EolGiU56geqOxJxN+RRC2LntlkdWoc?=
 =?us-ascii?Q?hAGv5LhhDc4TF3rKdwl3cXVvsaSoqbBrQnwzvmgTMdHg+Az/tHTGYP4/7UBG?=
 =?us-ascii?Q?6n0+mrmwz/RYLJwWyJ6bjjWKxj6zvFiH7kqJdvsgGCa5dvtfPhGfLBov9992?=
 =?us-ascii?Q?qs/Oez63OC1a9XfHxzKsv6OkYobeViuLUC0YjRR1HZqqVWnOLBl/YMyoBzhS?=
 =?us-ascii?Q?Uain1WeEZyZbx/leoNOJ5E+ypuXCxFpNZGbNGhuSVYPvBolOnxnA0V/UFNja?=
 =?us-ascii?Q?ezqxNrdbvh9siZDq8MQra4DPdnxmAsWbiv/Y7g3Fa5NUk109ZNeB7DVgqlUM?=
 =?us-ascii?Q?2At+v3KApprSxfAxH4NBKZCwNqRwNRKGuWe1/Ww/kuaX/5RHe4L3qBxCFbEJ?=
 =?us-ascii?Q?7MQlh65PBfMJNMOYWQkcrKh9OOSPqmfjsB2MjlSR3zG4RtCxBC9SRcbOaXWm?=
 =?us-ascii?Q?aOX4bAKnOkJ1Gc0sAXqPS/16vM3fg85n/WtzeoJnEJPQOxBDzF7zyqS4bwZ3?=
 =?us-ascii?Q?iML2XPerYLDAOw2ibS2LVkTq15BjGATgNV/uSu9GK+OqmKTWBI9FQfsbVM7R?=
 =?us-ascii?Q?/GcPg63kJSRkeFYUqrdURb46yUk5p3ZlPZX7nVcYDlweoYFNx7I6B+c+O7y/?=
 =?us-ascii?Q?WIkBZMlsIB/L7o92os5ddAWAIog0M/UClLC3RW5TnolZfWc6XdTyFAaFh5+q?=
 =?us-ascii?Q?ltiwINJSf4zbY3VUY0w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 070d3d02-28cb-4f18-4513-08dd9848737b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 09:18:29.8800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XSWkpKVU+TmIqqIUP/anu8/ugO7CBEjd61MDw2rhd0/YgnyI3rVCAyes91CLX0cvAm9x9Acq2PyGaaspqKMbVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189


> From: Parav Pandit <parav@nvidia.com>
> Sent: Wednesday, May 21, 2025 2:45 PM
> To: Michael S. Tsirkin <mst@redhat.com>
> Cc: stefanha@redhat.com; axboe@kernel.dk; virtualization@lists.linux.dev;
> linux-block@vger.kernel.or;=20

I had a typo in the addressing block driver's mailing list.
Will resend with right email shortly.
