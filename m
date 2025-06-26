Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECEE2185AC;
	Thu, 26 Jun 2025 06:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750919357; cv=fail; b=VfaUXtG5eD8DKrLbyeLaoSugehWXTnyqGe8X1YJoEac8ecs/0t9pNnL+WKIOrAQYsnVZrzYMj9G2Z53kxUw7QQX/LJe2Wh4emJU99YWTGXPHtZbPCDYEVF0t/eRxGy76gG+UVDgfZmZUUj+/z92eJCGB/reoU9BstvE/Ajnjaps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750919357; c=relaxed/simple;
	bh=GydiSYOViYN+DV5y1HnZ8etkHLUHeO6GRWHBzhGVDUY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t5GiY23NK6G6KOK54u3Yn6dDZDYzCDzN71156G0gzPlxWZqvH63WFgxo+ni8jVJDaJecjXVLwOJy4Mo60KFY3zviEXuOYHb4TeUI19+UXecQ0eIUiu36yqsDP3WRzhYcBhhkuBTx9kXOaSRqJ68s9d3nUAtc++opu1HDjlXvDR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qhLvbS8f; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qhLvbS8f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2Q2hor8vfXNOCdbSbfWlpztfwF3xydVFd9fbYqY9bFPXFFLpBlB745HOqV3MM0Jm0GmYWCigrmmZh1pDwKTOo1r9nEEMTcDKTellVG7Kqih8xFGDYrQoRtUgGKp0RXo4dig8Fjdy8lfA1qxxfrYocM6sBAaU+2K6su+y4NizlBJ4bdwJfFmpGYjJ+dV9Qo5kX5YkgnqDeo79HYJCdy6AU5acMWLNt1rAUafy0a+JnDWZF/pwVMoKTLJIArtFH9OP8Glx94wqeAKrD5x28HgSnmXy7URRgmADcgg/fE/9NkWd57Sd7tY3c+szJMh2wZERqg6PuwAVzf4SvILG4t4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKlK1qvwb11BNIey74UVo+PJZEKe1A4oUNEyngbMOIM=;
 b=wTz2/6zkPedDmNXyYDs3lss7pn8DncceYhm7ZPb4rKUWv8c5bsJBgfWf/w97+pDYyLpKVazFLh7f+yrW5axAGtFKUptzQeOFIOxVGxxp4eEA37WRHBcnni8DBWGn1oC9kuds8iqQ1uBD+Fg+/aU6ujZmHdzElWitd19Jg0lIE2U7We/T4dgIk25aPGfh0PoE0iHYmDV6vHoLaP6rHSi6OFn/EEH69od4QfLSfLr7ctW5Oarc9DhFBKlqRGwoaoCGZ1sbisgk7xCT9yxR+RiyecS5Gp99fRw4cs8NNJbjZ2ZbfbOOHbJgh1CQepmXxBJHIkeylWA07SbtRNX+P+N4BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKlK1qvwb11BNIey74UVo+PJZEKe1A4oUNEyngbMOIM=;
 b=qhLvbS8fPABRpFm/7NS940gylv3Grzx8KgKlNlRxJgOTgcCqld9b6cFW3D8KZsv0gE4zCJou8B8uMPFUDLVubqvJ9rAhKpkUQsR3fdHNAe65EFaS90D3vRzRuZ2SX4eDKPvmbAPOIHp7Y5k6OjRJ0W/FD4X3aAxQFXYlel4W1pKCOr72zqT54VMvld80lTriC8G4JkwoDQiqKVcVp80Ptlj0ckR+2NHMd5/9ylX6UOzGNKdKh/QHNV0oOMhTYHeUg1sBm/Zc3i0V+1gi0M50ckCj1UfAHguij27BAA/VtpaCvU6UhF5zDceB7KcJapezV9igwqGWeEKMNRXA4G9Z2g==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 26 Jun
 2025 06:29:09 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%4]) with mapi id 15.20.8857.022; Thu, 26 Jun 2025
 06:29:09 +0000
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
 AQHb02hI8rTGAA49eUeotBFzOHU9FbQSzIkAgAAAcqCAAAJ6gIAAARbQgAAMIgCAAHNgsIAAitiAgAAAT1CAAAsNAIAAeh/AgAAFwYCAAIZBkIAALRYAgAAGIWA=
Date: Thu, 26 Jun 2025 06:29:09 +0000
Message-ID:
 <CY8PR12MB7195435970A9B3F64E45825ADC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250624150635-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71953552AE196A592A1892DDDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250624155157-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71953EFA4BD60651BFD66BD7DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625070228-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195AF9E34DF2A4821F590A8DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625074112-mutt-send-email-mst@kernel.org>
 <CY8PR12MB719531F26136254CC4764CD4DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625151732-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195D92360146FFE1A59941CDC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250626020230-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250626020230-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|IA0PR12MB8254:EE_
x-ms-office365-filtering-correlation-id: 4ed8040f-bae2-4289-f310-08ddb47ac223
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4ad2PoIbM4kjgRkJYDxmnlRzkXS0apjboXpGECLFxZwKx/3ve4NAh/7Dqmbc?=
 =?us-ascii?Q?Jec/xTGS0jxDENWPUOR5G0AKXOvgFVjd9KArmn9lY2Xe6laW9oh7c/1wlS48?=
 =?us-ascii?Q?exmAY38+ni/UBtTOuu311dQlz1SSGlNU/lt3Kbl+mRny1YhTI3WrwGNOQFwN?=
 =?us-ascii?Q?dJ9nFtjsafX9jIMUUiR5Nm/Z02zOFimx0WEbd7AnoC/3wyBzsVBfIPCMCnLF?=
 =?us-ascii?Q?Bcn6/UEmvS0ydhxRsJDb5gutnwep9C/UpFBioSnBE+kjF0yrKhfRXkDxGd0n?=
 =?us-ascii?Q?wj3v7w7ksHkBvNZwM7QK7ANetBaxRoEZRuhlQW50gDzFK+4S+T6R+idkpmp/?=
 =?us-ascii?Q?VCXujZZWAVlsCezkb3zmFQnBQFnTFbdKPoaVLQmFE5OeqFSeH7IdaSExonYx?=
 =?us-ascii?Q?PHfQjKMa0BM83k/5nAsZKXXg7RQoamOgK2Gz019Xt42LBYbq1llanAXgqUfV?=
 =?us-ascii?Q?az5BV+af7eYneTTWHVb8nwtIIr/eqDM0mnjaa5XfyzOBr6ZYYz7jRD4qXwGc?=
 =?us-ascii?Q?BpeqpNQL4E5e28P6tE5+u2GhryQO/18yg1vlffIQ+DP2Zv3UhV4OJkXk2BWj?=
 =?us-ascii?Q?zfZpD+3CyAR1Tg9fqpe5oM/5iHhLKKXlmKeIgMLMCGFsvByPavM2k31vu4PB?=
 =?us-ascii?Q?7ij7ONlFUTtjm36vP7UAzvVLIgzFJknFJInvNr0edI4+awQJo2cPCv5nreTS?=
 =?us-ascii?Q?ETm9P/0p016WosEhdJpQBgKLQYgRcrNJpLWZvCJ6+UJS2pXT+YniRLEIaUqC?=
 =?us-ascii?Q?LwYX13aB92P1CDhBrhL9SqYa190Hy6a1YrE6D/zbhz/XIXrQa2FDpmBfqRoT?=
 =?us-ascii?Q?njdiYvjfbHTQ1g5f6Jo9LskiP1uGuS1WV0qfOT3FVzQo/labdfU4f7tF/39Y?=
 =?us-ascii?Q?+5uzXXiLKlrfhIsClV87Ud2Yahw/xXLye16n6UxAJ5lSuIQQqIRI7eb+ImL4?=
 =?us-ascii?Q?ZHQo8qVZ0IB7Q3PK+CKNbxMz4l9YL3us+iv1eq82f6kzM0IPDokiDdpEXc/V?=
 =?us-ascii?Q?e/yRNYDK4vriWb88N5u4BJbAIs0YZRYBoqNvIIg3BYApTZe/bQlX+fpS2K5J?=
 =?us-ascii?Q?Zge/V4cNMjflP8T4pXHEtZ+6X+yjZvCZSXf6E19osmU+ECc94sqVQKugwcHe?=
 =?us-ascii?Q?iBIUg/JaGr2pct3LOidjOMOdvDyJQ1Icub922JtkP21MlS9wYcfZVR/jrSue?=
 =?us-ascii?Q?GSviCsNGwCEYVxAqbuGJ5LiaI4m5P4l4LS6NXSpYZMuvUWA9zCOnvuegA0v/?=
 =?us-ascii?Q?QYsmrCb8BDJC2i1CSYu+7HaWgcXRWni3tBJBhRJycTUvHY8qUlTqkNTbWZvX?=
 =?us-ascii?Q?TrI+T62G9xo+SEtZzvnuQQw4VaJHp52LkRGdjV5X7++kYeKuIhFVXOVo5b+W?=
 =?us-ascii?Q?vVZjgkEU+uvuPKZixU2z3ewPqRYo3Ll7kF0J5Bs4Cier7kwidyxKmCcXiIVi?=
 =?us-ascii?Q?j50eDosSCZSe1/BSo8cG5GnL8fKOQiNjXNgtdvYy2FMo2XDNZhANUV/M1GKD?=
 =?us-ascii?Q?Blnamxwt1uhBBVg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TZMJpTgMOa5/R2SqHyZFmkfJDNq5VZwIO88LZqBjgBugtkomfujv9zt1wkeT?=
 =?us-ascii?Q?K1sel8ADotv4W+TgKgwI9csJxBdvEpqGqvoTJ0M5jfqL55walvDNKuFZSmBl?=
 =?us-ascii?Q?E3ombuCW7Jr68bal8HPqofBD3vSOUQFfv8ydtGOykveG1AsxWIydNo6Vm3pX?=
 =?us-ascii?Q?iP7iM6F+sVH1VJOlHBIHN40hAR4mBHwrVGq7EvhoXZvKbV6xvCWUO4T39BLO?=
 =?us-ascii?Q?+1I0k+YPimqE14cv5JALVj7lWIJxbTOOca1hsXLoWR/NUnJ+OLvwWPridTA/?=
 =?us-ascii?Q?8Vwq1elYkTnmnl+8mzW07ZaC8kUQu/0kJWMFdvQuIxbvosty68YAniK7U+Ws?=
 =?us-ascii?Q?H2bwbEJ8TMej9f4Zo5zq9TMqGQQ24FQSKhAcVX7KEf7GAf27o/8JwUY4wz2T?=
 =?us-ascii?Q?l8OrAMuSodFfkw5Xi7ARmrdGi3VFAs1aJx0vlBZvu0tYfUGT95iQFoV+jSom?=
 =?us-ascii?Q?QU50Xmokm2/BI6+3bNI+GIQGU2xIJxuCDptsyiD0qZnhmTYQxT0+pWQBwVob?=
 =?us-ascii?Q?aJgrLrXrwExwZptVAMIZSJlBa8KNhf8fj+aqWtDla2Zyf7TAYDvzb8JRz6vg?=
 =?us-ascii?Q?WMw6PyM6vfEYlogo5IyYMD5YnyHd7Htu5YlR857VSVz1EzhdvlaW2ofwUECc?=
 =?us-ascii?Q?gm/ziYZvRm1hMnywjfQlZcGKmtXX43RUNN2LHS1zEJp1Qme9w6pCYhXVeFVD?=
 =?us-ascii?Q?GijAG8hhzHhnLHngmg6SydZSUMkfp36YE0uSx7rOXXasUblcAhIReixjUBHw?=
 =?us-ascii?Q?0fAkJjW2AIiqV809wDWRQ5TjLQZMYZXlz44DXEvCuCyvrjEjJjm6HgT8PzNx?=
 =?us-ascii?Q?HYLRtqqHN5/4fMhTeyTD9vq+BwdNxvBmmYwIQRf/H+va8TY6s62+BQEAvd7A?=
 =?us-ascii?Q?kWCa/7EGhL2xSjjerrPdmjBuN/6trTjn4PFBIidi5CCbmvM6kwbWjTyOABmK?=
 =?us-ascii?Q?yWSbmBBwDVJkBJk03yO5B+yFQyBQ1J/VuRJnmB07AAXXE9S67aofCfh2xfq7?=
 =?us-ascii?Q?/uTK0NKOXG5SfCWr3kTStxmesPtTIKOj46akk8WVlG/lViPy03ko5gQEEeEL?=
 =?us-ascii?Q?K/1PkVCfwAXRiijxIUC57hWgMCUvlGa/KpXyeVBHM3OXdMSIisbtNntlWyPU?=
 =?us-ascii?Q?mZCQC4OBJR6O2HhcWrVRN4Fl/VWHvBRHWiTJbTpMnUDlcBzpXn7sg6qTO6zp?=
 =?us-ascii?Q?FZDGgt7pAhuez0bgDwP6iij635/dS6DQBEaOp1aDctC5gkCJkMtsWqE7Zjdy?=
 =?us-ascii?Q?mmMZVFQfdfs9shbEMcp1jjL8qJwSGCNfA/rtTQYsoxobem3FPOGVEUkeMMk5?=
 =?us-ascii?Q?SIXfSol1FMScaHGrCSvqcRtbAL8tyZep2XVBvqxLKqKNXGJcr5nPAdEvxO91?=
 =?us-ascii?Q?I6Syg3WQIdacJJvfGu+ohjm/eeSMkN9/5yntEaOo+CEUVk3yyLj+gwK8kskV?=
 =?us-ascii?Q?LaZv2N15HDxn6Fmbo0gIezsAIGhV1oZJoUznorklscs88tN/nrXs3lQix1xb?=
 =?us-ascii?Q?ijt14kd3jPOjW8uNQPWCxaI7x0gvZaebnhHJFUpcNT1jvOLyWBLEZaqXKc8F?=
 =?us-ascii?Q?JsE3ZmvoZk7Cfn49Hxc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed8040f-bae2-4289-f310-08ddb47ac223
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 06:29:09.2388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pBdk6jq4V9rOMRqIuYhO0/k0JR8RhoF9ERpljEPhPxuLVp/1kRLLkDCsBj0h8mVOhC3CkXpHNXY9DLwlI36x1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 26 June 2025 11:34 AM
>=20
> On Thu, Jun 26, 2025 at 03:26:12AM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: 26 June 2025 12:52 AM
> > >
> > > On Wed, Jun 25, 2025 at 07:08:54PM +0000, Parav Pandit wrote:
> > > >
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: 25 June 2025 05:15 PM
> > > > >
> > > > > On Wed, Jun 25, 2025 at 11:08:42AM +0000, Parav Pandit wrote:
> > > > > >
> > > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > Sent: 25 June 2025 04:34 PM
> > > > > > >
> > > > > > > On Wed, Jun 25, 2025 at 02:55:27AM +0000, Parav Pandit wrote:
> > > > > > > >
> > > > > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > > > Sent: 25 June 2025 01:24 AM
> > > > > > > > >
> > > > > > > > > On Tue, Jun 24, 2025 at 07:11:29PM +0000, Parav Pandit wr=
ote:
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > > > > > Sent: 25 June 2025 12:37 AM
> > > > > > > > > > >
> > > > > > > > > > > On Tue, Jun 24, 2025 at 07:01:44PM +0000, Parav Pandi=
t
> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > > > > > > > > Sent: 25 June 2025 12:26 AM
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Mon, Jun 02, 2025 at 02:44:33AM +0000, Parav
> > > > > > > > > > > > > Pandit
> > > > > wrote:
> > > > > > > > > > > > > > When the PCI device is surprise removed,
> > > > > > > > > > > > > > requests may not complete the device as the VQ
> > > > > > > > > > > > > > is marked as
> > > broken.
> > > > > > > > > > > > > > Due to this, the disk deletion hangs.
> > > > > > > > > > > > >
> > > > > > > > > > > > > There are loops in the core virtio driver code
> > > > > > > > > > > > > that expect device register reads to eventually r=
eturn 0:
> > > > > > > > > > > > > drivers/virtio/virtio_pci_modern.c:vp_reset()
> > > > > > > > > > > > > drivers/virtio/virtio_pci_modern_dev.c:vp_modern
> > > > > > > > > > > > > _set
> > > > > > > > > > > > > _que
> > > > > > > > > > > > > ue_r
> > > > > > > > > > > > > eset
> > > > > > > > > > > > > ()
> > > > > > > > > > > > >
> > > > > > > > > > > > > Is there a hang if these loops are hit when a
> > > > > > > > > > > > > device has been surprise removed? I'm trying to
> > > > > > > > > > > > > understand whether surprise removal is fully
> > > > > > > > > > > > > supported or whether this patch is one step in
> > > > > > > > > > > > > that
> > > > > > > > > direction.
> > > > > > > > > > > > >
> > > > > > > > > > > > In one of the previous replies I answered to
> > > > > > > > > > > > Michael, but don't have the link
> > > > > > > > > > > handy.
> > > > > > > > > > > > It is not fully supported by this patch. It will ha=
ng.
> > > > > > > > > > > >
> > > > > > > > > > > > This patch restores driver back to the same state
> > > > > > > > > > > > what it was before the fixes
> > > > > > > > > > > tag patch.
> > > > > > > > > > > > The virtio stack level work is needed to support
> > > > > > > > > > > > surprise removal, including
> > > > > > > > > > > the reset flow you rightly pointed.
> > > > > > > > > > >
> > > > > > > > > > > Have plans to do that?
> > > > > > > > > > >
> > > > > > > > > > Didn't give enough thoughts on it yet.
> > > > > > > > >
> > > > > > > > > This one is kind of pointless then? It just fixes the
> > > > > > > > > specific race window that your test harness happens to hi=
t?
> > > > > > > > >
> > > > > > > > It was reported by Li from Baidu, whose tests failed.
> > > > > > > > I missed to tag "reported-by" in v5. I had it until v4. :(
> > > > > > > >
> > > > > > > > > Maybe it's better to wait until someone does a comprehens=
ive
> fix..
> > > > > > > > >
> > > > > > > > >
> > > > > > > > Oh, I was under impression is that you wanted to step
> > > > > > > > forward in discussion
> > > > > > > of v4.
> > > > > > > > If you prefer a comprehensive support across layers of
> > > > > > > > virtio, I suggest you
> > > > > > > should revert the cited patch in fixes tag.
> > > > > > > >
> > > > > > > > Otherwise, it is in degraded state as virtio never
> > > > > > > > supported surprise
> > > > > removal.
> > > > > > > > By reverting the cited patch (or with this fix), the
> > > > > > > > requests and disk deletion
> > > > > > > will not hang.
> > > > > > >
> > > > > > > But they will hung in virtio core on reset, will they not?
> > > > > > > The tests just do not happen to trigger this?
> > > > > > >
> > > > > > It will hang if it a true surprise removal which no device did
> > > > > > so far because it
> > > > > never worked.
> > > > > > (or did, but always hung that no one reported yet)
> > > > > >
> > > > > > I am familiar with 2 or more PCI devices who reports surprise
> > > > > > removal,
> > > > > which do not complete the requests but yet allows device reset fl=
ow.
> > > > > > This is because device is still there on the PCI bus. Only via
> > > > > > side band signals
> > > > > device removal was reported.
> > > > >
> > > > > So why do we care about it so much? I think it's great this
> > > > > patch exists, for example it makes it easier to test surprise
> > > > > removal and find more bugs. But is it better to just have it
> > > > > hang unconditionally? Are we now making a commitment that it's
> > > > > working -
> > > one we don't seem to intend to implement?
> > > > >
> > > > The patch improves the situation from its current state.
> > > > But as you posted, more changes in pci layer are needed.
> > > > I didn't audit where else it may be needed.
> > > >
> > > > vp_reset() may need to return the status back of successful/failure=
 reset.
> > > > Otherwise during probe(), vp_reset() aborts the reset and attempts
> > > > to load
> > > the driver for removed device.
> > >
> > > yes however this is not at all different that hotunplug right after r=
eset.
> > >
> > For hotunplug after reset, we likely need a timeout handler.
> > Because block driver running inside the remove() callback waiting for t=
he IO,
> may not get notified from driver core to synchronize ongoing remove().
>=20
>=20
> Notified of what?=20
Notification that surprise-removal occurred.

> So is the scenario that graceful remove starts, and
> meanwhile a surprise removal happens?
>=20
Right.

> >
> > > > I guess suspend() callback also infinitely waits during freezing
> > > > the queue
> > > also needs adaptation.
> > >
> > > Which callback is that I don't understand.
> > virtblk_freeze() at [1].
> >
> > [1]
> > https://elixir.bootlin.com/linux/v6.15.3/source/drivers/block/virtio_b
> > lk.c#L1622
> >
> > >
> > >
> > > > > > But I agree that for full support, virtio all layer changes
> > > > > > would be needed as
> > > > > new functionality (without fixes tag  :) ).
> > > > >
> > > > >
> > > > > Or with a fixes tag - lots of people just use it as a signal to
> > > > > mean "where can this be reasonably backported to".
> > > > >
> > > > Yes, I think the fix for the older kernels is needed, hence I cced =
stable too.
> > > >
> > > > >
> > > > > > > > Please let me know if I should re-send to revert the patch
> > > > > > > > listed in fixes
> > > > > tag.
> > > > > > > >
> > > > > > > > > > > > > Apart from that, I'm happy with the virtio_blk.c
> > > > > > > > > > > > > aspects of the
> > > > > > > patch:
> > > > > > > > > > > > > Reviewed-by: Stefan Hajnoczi
> > > > > > > > > > > > > <stefanha@redhat.com>
> > > > > > > > > > > > >
> > > > > > > > > > > > Thanks.
> > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Fix it by aborting the requests when the VQ is =
broken.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > With this fix now fio completes swiftly.
> > > > > > > > > > > > > > An alternative of IO timeout has been
> > > > > > > > > > > > > > considered, however when the driver knows
> > > > > > > > > > > > > > about unresponsive block device, swiftly
> > > > > > > > > > > > > > clearing them enables users and upper layers
> > > > > > > > > > > > > > to react
> > > > > > > quickly.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Verified with multiple device unplug
> > > > > > > > > > > > > > iterations with pending requests in virtio
> > > > > > > > > > > > > > used ring and some pending with the
> > > > > > > device.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support
> > > > > > > > > > > > > > surprise removal of virtio pci device")
> > > > > > > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > > > > > > Reported-by: Li RongQing
> > > > > > > > > > > > > > <lirongqing@baidu.com>
> > > > > > > > > > > > > > Closes:
> > > > > > > > > > > > > > https://lore.kernel.org/virtualization/c45dd68
> > > > > > > > > > > > > > 698c
> > > > > > > > > > > > > > d472
> > > > > > > > > > > > > > 38c5
> > > > > > > > > > > > > > 5fb7
> > > > > > > > > > > > > > 3ca9
> > > > > > > > > > > > > > b474
> > > > > > > > > > > > > > 1@baidu.com/
> > > > > > > > > > > > > > Reviewed-by: Max Gurtovoy
> > > > > > > > > > > > > > <mgurtovoy@nvidia.com>
> > > > > > > > > > > > > > Reviewed-by: Israel Rukshin
> > > > > > > > > > > > > > <israelr@nvidia.com>
> > > > > > > > > > > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > v4->v5:
> > > > > > > > > > > > > > - fixed comment style where comment to start
> > > > > > > > > > > > > > with one empty line at start
> > > > > > > > > > > > > > - Addressed comments from Alok
> > > > > > > > > > > > > > - fixed typo in broken vq check
> > > > > > > > > > > > > > v3->v4:
> > > > > > > > > > > > > > - Addressed comments from Michael
> > > > > > > > > > > > > > - renamed virtblk_request_cancel() to
> > > > > > > > > > > > > >   virtblk_complete_request_with_ioerr()
> > > > > > > > > > > > > > - Added comments for
> > > > > > > > > > > > > > virtblk_complete_request_with_ioerr()
> > > > > > > > > > > > > > - Renamed virtblk_broken_device_cleanup() to
> > > > > > > > > > > > > >   virtblk_cleanup_broken_device()
> > > > > > > > > > > > > > - Added comments for
> > > > > > > > > > > > > > virtblk_cleanup_broken_device()
> > > > > > > > > > > > > > - Moved the broken vq check in
> > > > > > > > > > > > > > virtblk_remove()
> > > > > > > > > > > > > > - Fixed comment style to have first empty line
> > > > > > > > > > > > > > - replaced freezed to frozen
> > > > > > > > > > > > > > - Fixed comments rephrased
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > v2->v3:
> > > > > > > > > > > > > > - Addressed comments from Michael
> > > > > > > > > > > > > > - updated comment for synchronizing with
> > > > > > > > > > > > > > callbacks
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > v1->v2:
> > > > > > > > > > > > > > - Addressed comments from Stephan
> > > > > > > > > > > > > > - fixed spelling to 'waiting'
> > > > > > > > > > > > > > - Addressed comments from Michael
> > > > > > > > > > > > > > - Dropped checking broken vq from queue_rq()
> > > > > > > > > > > > > > and
> > > > > queue_rqs()
> > > > > > > > > > > > > >   because it is checked in lower layer
> > > > > > > > > > > > > > routines in virtio core
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > v0->v1:
> > > > > > > > > > > > > > - Fixed comments from Stefan to rename a
> > > > > > > > > > > > > > cleanup function
> > > > > > > > > > > > > > - Improved logic for handling any outstanding r=
equests
> > > > > > > > > > > > > >   in bio layer
> > > > > > > > > > > > > > - improved cancel callback to sync with
> > > > > > > > > > > > > > ongoing
> > > > > > > > > > > > > > done()
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > > >  drivers/block/virtio_blk.c | 95
> > > > > > > > > > > > > > ++++++++++++++++++++++++++++++++++++++
> > > > > > > > > > > > > >  1 file changed, 95 insertions(+)
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > diff --git a/drivers/block/virtio_blk.c
> > > > > > > > > > > > > > b/drivers/block/virtio_blk.c index
> > > > > > > > > > > > > > 7cffea01d868..c5e383c0ac48
> > > > > > > > > > > > > > 100644
> > > > > > > > > > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > > > > > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > > > > > > > > > @@ -1554,6 +1554,98 @@ static int
> > > > > > > > > > > > > > virtblk_probe(struct virtio_device
> > > > > > > > > > > > > *vdev)
> > > > > > > > > > > > > >  	return err;
> > > > > > > > > > > > > >  }
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > +/*
> > > > > > > > > > > > > > + * If the vq is broken, device will not comple=
te requests.
> > > > > > > > > > > > > > + * So we do it for the device.
> > > > > > > > > > > > > > + */
> > > > > > > > > > > > > > +static bool
> > > > > > > > > > > > > > +virtblk_complete_request_with_ioerr(struct
> > > > > > > > > > > > > > +request *rq, void *data) {
> > > > > > > > > > > > > > +	struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(=
rq);
> > > > > > > > > > > > > > +	struct virtio_blk *vblk =3D data;
> > > > > > > > > > > > > > +	struct virtio_blk_vq *vq;
> > > > > > > > > > > > > > +	unsigned long flags;
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +	vq =3D &vblk->vqs[rq->mq_hctx->queue_num];
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +	spin_lock_irqsave(&vq->lock, flags);
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +	vbr->in_hdr.status =3D VIRTIO_BLK_S_IOERR;
> > > > > > > > > > > > > > +	if (blk_mq_request_started(rq) &&
> > > > > > > > > !blk_mq_request_completed(rq))
> > > > > > > > > > > > > > +		blk_mq_complete_request(rq);
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +	spin_unlock_irqrestore(&vq->lock, flags);
> > > > > > > > > > > > > > +	return true; }
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +/*
> > > > > > > > > > > > > > + * If the device is broken, it will not use
> > > > > > > > > > > > > > +any buffers and waiting
> > > > > > > > > > > > > > + * for that to happen is pointless. We'll do
> > > > > > > > > > > > > > +the cleanup in the driver,
> > > > > > > > > > > > > > + * completing all requests for the device.
> > > > > > > > > > > > > > + */
> > > > > > > > > > > > > > +static void
> > > > > > > > > > > > > > +virtblk_cleanup_broken_device(struct
> > > > > > > > > > > > > > +virtio_blk *vblk)
> > > > > > > {
> > > > > > > > > > > > > > +	struct request_queue *q =3D vblk->disk->queue=
;
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +	/*
> > > > > > > > > > > > > > +	 * Start freezing the queue, so that new
> > > > > > > > > > > > > > +requests keeps
> > > > > > > > > waiting at the
> > > > > > > > > > > > > > +	 * door of bio_queue_enter(). We cannot
> > > > > > > > > > > > > > +fully freeze the queue
> > > > > > > > > > > > > because
> > > > > > > > > > > > > > +	 * frozen queue is an empty queue and there
> > > > > > > > > > > > > > +are pending
> > > > > > > > > requests, so
> > > > > > > > > > > > > > +	 * only start freezing it.
> > > > > > > > > > > > > > +	 */
> > > > > > > > > > > > > > +	blk_freeze_queue_start(q);
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +	/*
> > > > > > > > > > > > > > +	 * When quiescing completes, all ongoing
> > > > > > > > > > > > > > +dispatches have
> > > > > > > > > completed
> > > > > > > > > > > > > > +	 * and no new dispatch will happen towards
> > > > > > > > > > > > > > +the
> > > > > driver.
> > > > > > > > > > > > > > +	 */
> > > > > > > > > > > > > > +	blk_mq_quiesce_queue(q);
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +	/*
> > > > > > > > > > > > > > +	 * Synchronize with any ongoing VQ callbacks
> > > > > > > > > > > > > > +that may have
> > > > > > > > > started
> > > > > > > > > > > > > > +	 * before the VQs were marked as broken. Any
> > > > > > > > > > > > > > +outstanding
> > > > > > > > > requests
> > > > > > > > > > > > > > +	 * will be completed by
> > > > > > > > > virtblk_complete_request_with_ioerr().
> > > > > > > > > > > > > > +	 */
> > > > > > > > > > > > > > +	virtio_synchronize_cbs(vblk->vdev);
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +	/*
> > > > > > > > > > > > > > +	 * At this point, no new requests can enter
> > > > > > > > > > > > > > +the
> > > > > > > > > > > > > > +queue_rq()
> > > > > > > > > and
> > > > > > > > > > > > > > +	 * completion routine will not complete any
> > > > > > > > > > > > > > +new requests either for
> > > > > > > > > > > > > the
> > > > > > > > > > > > > > +	 * broken vq. Hence, it is safe to cancel
> > > > > > > > > > > > > > +all requests
> > > > > which are
> > > > > > > > > > > > > > +	 * started.
> > > > > > > > > > > > > > +	 */
> > > > > > > > > > > > > > +	blk_mq_tagset_busy_iter(&vblk->tag_set,
> > > > > > > > > > > > > > +
> > > > > 	virtblk_complete_request_with_ioerr,
> > > > > > > > > vblk);
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +blk_mq_tagset_wait_completed_request(&vblk->t
> > > > > > > > > > > > > > +ag_s
> > > > > > > > > > > > > > +et);
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +	/*
> > > > > > > > > > > > > > +	 * All pending requests are cleaned up. Time
> > > > > > > > > > > > > > +to resume so
> > > > > > > > > that disk
> > > > > > > > > > > > > > +	 * deletion can be smooth. Start the HW
> > > > > > > > > > > > > > +queues so that when queue
> > > > > > > > > > > > > is
> > > > > > > > > > > > > > +	 * unquiesced requests can again enter the dr=
iver.
> > > > > > > > > > > > > > +	 */
> > > > > > > > > > > > > > +	blk_mq_start_stopped_hw_queues(q, true);
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +	/*
> > > > > > > > > > > > > > +	 * Unquiescing will trigger dispatching any
> > > > > > > > > > > > > > +pending requests
> > > > > > > > > to the
> > > > > > > > > > > > > > +	 * driver which has crossed
> > > > > > > > > > > > > > +bio_queue_enter() to the
> > > > > driver.
> > > > > > > > > > > > > > +	 */
> > > > > > > > > > > > > > +	blk_mq_unquiesce_queue(q);
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +	/*
> > > > > > > > > > > > > > +	 * Wait for all pending dispatches to
> > > > > > > > > > > > > > +terminate which may
> > > > > > > > > have been
> > > > > > > > > > > > > > +	 * initiated after unquiescing.
> > > > > > > > > > > > > > +	 */
> > > > > > > > > > > > > > +	blk_mq_freeze_queue_wait(q);
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +	/*
> > > > > > > > > > > > > > +	 * Mark the disk dead so that once we
> > > > > > > > > > > > > > +unfreeze the queue,
> > > > > > > > > requests
> > > > > > > > > > > > > > +	 * waiting at the door of bio_queue_enter()
> > > > > > > > > > > > > > +can be aborted right
> > > > > > > > > > > > > away.
> > > > > > > > > > > > > > +	 */
> > > > > > > > > > > > > > +	blk_mark_disk_dead(vblk->disk);
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +	/* Unfreeze the queue so that any waiting
> > > > > > > > > > > > > > +requests will be
> > > > > > > > > aborted. */
> > > > > > > > > > > > > > +	blk_mq_unfreeze_queue_nomemrestore(q);
> > > > > > > > > > > > > > +}
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > >  static void virtblk_remove(struct virtio_devic=
e *vdev)  {
> > > > > > > > > > > > > >  	struct virtio_blk *vblk =3D vdev->priv; @@
> > > > > > > > > > > > > > -1561,6
> > > > > > > > > > > > > > +1653,9 @@ static void virtblk_remove(struct
> > > > > > > > > > > > > > +virtio_device
> > > > > *vdev)
> > > > > > > > > > > > > >  	/* Make sure no work handler is accessing the=
 device.
> > > > > */
> > > > > > > > > > > > > >  	flush_work(&vblk->config_work);
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > +	if (virtqueue_is_broken(vblk->vqs[0].vq))
> > > > > > > > > > > > > > +		virtblk_cleanup_broken_device(vblk);
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > >  	del_gendisk(vblk->disk);
> > > > > > > > > > > > > >  	blk_mq_free_tag_set(&vblk->tag_set);
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > --
> > > > > > > > > > > > > > 2.34.1
> > > > > > > > > > > > > >

