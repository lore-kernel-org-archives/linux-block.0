Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77131289347;
	Wed, 25 Jun 2025 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750849729; cv=fail; b=TLgtifDC8VBUN9OI+J63KMAqX9G3N56xYKdlqzh6TMYeZg0bwZBMVsuXRXoDBTvW24faTwgzJDqEwLxY6zYcEza4+Y9QK388b2+GF5hN6NZp3OVJgF1fHBh6COdpS4Z+Pv5ytKtNeO/aIzYG99fqdh44/zocGRK/qjYeTvwxCqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750849729; c=relaxed/simple;
	bh=wuHQup7Y74/87PcujVToMJAgI8nxEq3lozeBCISjNWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M80yKRtxKdEd858ip0s7hEt/Oq78s3OPyi8+3B9kjKK6k04vk2dWF9Eg8hlYrtTJFFafnmICJ0EzOX4vgZ7yKufZvuurdcyXNNUN2Gn+XukS9EaGVOybjpxy+J5wW0LbtFGJRS1JV5ZO5pADUJlFxhqm0Uxx84Hi/BWLpaizxkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kkadm0zB; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kkadm0zB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUHIYv646A9vRIgnVdGydJc23GMMPH+/rQW8LqFI2pcAWOnkcv2NbBSX+xJg+cYp98Xap/OK+nOi9CZyIEHTLSR5QBhnvtD3dAef5TZ02z/WaDsd0hHZpSxfDwG657g3Zc8F05bGfvahS/F1yGQdyzHBuWGprzgOmaA5g7goRGek4vTBtB7z8HJ7CbBOaGPXj2BFAgfKYlxFhvvQq1D5X0QTMxt8o2TQHGO/c7Stn+oijnaiOu43UgZ5dIqVqNjAzalahE/ruUc5vgDlIWI+ghtAE0K1eaLRjlmp+7faJSW+1iD1luesILy/Cso9d9PwScGNXNM9ozPYdlw6PaU0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8A8X2LgglMD1OstPSxSThVe+FQ8eGWYgZkvf0j9ps4=;
 b=Swk+6PSdwBlJ/2LmPktl231eDMD+nie2HBN2Rk5zvvXGAItQdsYGAKX12eui1ucxEGNhSwCQnLtrAXfRB6cG6pNNpKVCVR4Rvu8Mi/I7CS9jMpFZBQR5jN8dJzhHXT19NndnJe+Du0rgSmCFb0xYJbRsC/lIA5B14/pvLraaX/yC2uCJeRwuvC6gGt/YlNTKY81gK835vc9FhFO1ZzuQYXBkSJyP3ntD5fgoFineBa9HdNyCXZ7GYQqxAaEclZQAn6Bb1+RJLvyrsqLF9uL20tSmmrk8vGYPf16RfjhStSAcdHaZJZk21IIobyvyBID0cT8b9u9MmHUP74Mi+ci6og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8A8X2LgglMD1OstPSxSThVe+FQ8eGWYgZkvf0j9ps4=;
 b=kkadm0zBnVzldeb0/piNP8Jmj/VwPPeqeLseDq2xHlcb7qlRzfCaIYTgi9qm9Ct+buDuX58DVtEb3OsM/cTbllWFwk6N3ENQHiT4w8v92Ddf2zWt3tmMusLEaYuY+aCCmGSzzUhPTViAFzwXx6OJ99ldoJEhBXgm4MBrP+PZ4A43v6sQmCvzybnf8rnvfGZpZYS5Mn49yKHe0IV7e8JcrLIy9qo/BhemVDNaUr6VGf5xYuyaEdXhu2/Cx0Mv20PHJh7lF9nSk+YSAgfm1UhuSd7gDkxBWKpTfzTvCEnZVM5mVESg6HzCrovdwDotqJtlRKq/8iEsVC3xKzDtF8bHyw==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Wed, 25 Jun
 2025 11:08:42 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%4]) with mapi id 15.20.8857.022; Wed, 25 Jun 2025
 11:08:42 +0000
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
 AQHb02hI8rTGAA49eUeotBFzOHU9FbQSzIkAgAAAcqCAAAJ6gIAAARbQgAAMIgCAAHNgsIAAitiAgAAAT1A=
Date: Wed, 25 Jun 2025 11:08:42 +0000
Message-ID:
 <CY8PR12MB7195AF9E34DF2A4821F590A8DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250602024358.57114-1-parav@nvidia.com>
 <20250624185622.GB5519@fedora>
 <CY8PR12MB719579F7DAD8B0C0A98CBC7FDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250624150635-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71953552AE196A592A1892DDDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250624155157-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71953EFA4BD60651BFD66BD7DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625070228-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250625070228-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DM6PR12MB4124:EE_
x-ms-office365-filtering-correlation-id: 91a12432-ff9b-4277-9d48-08ddb3d8a522
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kMMFdl0/lv08Iw+Ni5YNCa19kzmyENEjmIllWe7Is4rDHZVav4+iSuEmIYdk?=
 =?us-ascii?Q?Z80w1V/qEl2r2oqEMnaT8U1vDqJBfgFbcHJuHoaHZOJu8pHRNt6pubSbioBS?=
 =?us-ascii?Q?QhdmRud1KClp8rngY44Xl2nBqEVKeIMTG7KWvV1k8UxjmMiwXZTV6AGv4d17?=
 =?us-ascii?Q?CEfTMAm18N+D/5hHQ5yp6KmzU2r3ptT47JYBdB6i7FAXQ+AEN8iJst9yauog?=
 =?us-ascii?Q?m1L3Wvf4PHdyaJevYv5MMhrYjvmkOIVlWHxfWZlVbOL3kw5Fa5M7jgqZ6HA+?=
 =?us-ascii?Q?/vCfLkKjNTGkJWLdGOWRt6zJxlT3thM7peusT6CmUe1jHO/Ir8s7RWb8rNae?=
 =?us-ascii?Q?o6I06/j1g12Ul3UIb6H+9BEtlp1+bykg4H901E0PB+XQroyGgm7oIecisIZp?=
 =?us-ascii?Q?gDhy+wVLRXHgjgdRb8nRTsbKyPF79eloucbTsbO3FlWvSJa6CweCesiDgcm1?=
 =?us-ascii?Q?nuhx5rhBPq8X6OHNTm7nMleYu+UtLkK26/6czGpyDvrtspwYL/08wGMCNYjA?=
 =?us-ascii?Q?PoZhx9D8Ml7gsuJ3IxtT4JKqMDK2VddomJCnFp2LL1/NKCbUvI0urq6W5wVA?=
 =?us-ascii?Q?nxjB9795OHbMBZSovD6Uid1xXhsZnpg8JsuyFd2ww51TzoOj3tWqkGtMDzk7?=
 =?us-ascii?Q?Rcvk/15zlIdWs0Ba0jGwqVGnJFT751kbYnBj/R5DLhGcCiBIMAVZpGxomNnE?=
 =?us-ascii?Q?NSYaXDSMfieBQChx6WZLR2+QxvLgBgpcNlNZr3QaR1xRSO6xc2rHWJNvLwWD?=
 =?us-ascii?Q?TcR+mWa4flLqc5SS7n6FefBIVGLfWZk17mR6SssxspTlyJjCWpYJrfabF6Fs?=
 =?us-ascii?Q?4KmZ6ZgzNNuJ8G5nYiC5tAYbrHrbcMxNReAke2FoZ5nlrfB17Kaq8+csDTTG?=
 =?us-ascii?Q?oMJwUIKbtB/PiHu+hDFaSU0rlxjrEtKAR3KL1z9Vff1xyiDHyJefDKfbefR4?=
 =?us-ascii?Q?5XE+4SEVvevpuHGatBrRl9rzOX+wt3Tcfo0cjFYKBjLXM5oy6locDIMhquM3?=
 =?us-ascii?Q?n6fGQimHRGWdEoiwxrEcA4TjwSMNJLeepbKHw8i6uoYiMHKeAdQko3EXusmL?=
 =?us-ascii?Q?QpNmWSNNFdgC8o0d/pEKjK1qOKBbn7f2ylhaVugDwtEG+C23acYU+uohgC2V?=
 =?us-ascii?Q?widt396fxLJ1vl4T9Z/7xTZACOfwZpdFkVemfxNEmF8dSqQnjbCmT+WNGv7C?=
 =?us-ascii?Q?U20o0S6iAAdddybPc/8Mh1R82ylnK5WjhZq0VsbHS11feb8XCwKKsCpLthMb?=
 =?us-ascii?Q?fDWc5PYHrbFGiK6x2EGuzyRBA4eqYgSqKiup4yHf8+nUzjW02Kq8rzH4HZVD?=
 =?us-ascii?Q?jI56O7zxFuaRIz9qZA0ZHT+lFNoIqFWSZ2QRf5PKOdTVUsESO3tITSaV6OnI?=
 =?us-ascii?Q?HvvZKxm4HoS6aGb14nFIEXqjmuPfEhrQ7t6yLSZHRqjcy462WVb5UFL8FvZq?=
 =?us-ascii?Q?1cm0HjL8fZRS7o0GPPQN9R3P56/XZeqCU35lLx9+KRi9jFaj1hUSyGIGi5QK?=
 =?us-ascii?Q?cvtEi07i/V3mf2Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eLSn5br5tFxDcQpbAJZWd+lYa2Dot1zkCHFw6Yx03TbhVXCuEG3YmMu4QmHQ?=
 =?us-ascii?Q?QDjuG8F5HKQ4g7hcLTX6l4lvbyVeQZspyA8yE1fgiDmeO/cujZc+eaW3h+sF?=
 =?us-ascii?Q?SeegO1FxHj4uo/6T24q5EnGDtAE3KUBKxFlVOVCYJ4M+VZD+OiyswPPNEYtV?=
 =?us-ascii?Q?SqM0oj48jD/oF3TQx26N3LqVc+kx26SqynBRv3MxDsW6nwd6pcowZkNxZEHu?=
 =?us-ascii?Q?Wv09zpFxSUcKdGIQFzDYyFGF0/uS5r5NyeclLCtdmQuOiNTAwboHpaaxjikd?=
 =?us-ascii?Q?AxXayjSE0jJTc5dSh72H3DSfs0MXUJAWH9HufZ9/aYKHcNR3aJAGX/3C2QNV?=
 =?us-ascii?Q?6Chad/TqT5ZKd8KXrKsw9pz7Wp1SDWSb49fWJ4VygwtOmorxsp36zpczNQ1/?=
 =?us-ascii?Q?QFoHwJRl+Xl+TNrcyOp1F162RyHE6IspPYFKSbejOvn7yHiHTPVmjxNDg9FJ?=
 =?us-ascii?Q?4tQgnmSQ/suCCsGU2cZOODqdvfTE0qdWAnlXGtmQt9XY65bNewpKfzNspKl/?=
 =?us-ascii?Q?xckxbgC1YUSF76yIbmVxp0dlsCriewCOlrRdy1hvSSCQimrbbajOVGdSKSpn?=
 =?us-ascii?Q?RkUPaqD344J0REm4vxaMUP+7Bx+9+3uZmF8fJ01FAJJ7wEs6egsAmJgserJy?=
 =?us-ascii?Q?Fu99caZ/Sj8mjifpmejtqoixOTTJ+wj+mkr8RYbrpECn5AUDQNAaBwfxLyX3?=
 =?us-ascii?Q?v42ekQp3deKOpo4toePAVsdLDoeYG5n8w5VCR7f7YflHRFELa6dBkbxky1Im?=
 =?us-ascii?Q?I+dE6/hBFNBUS8OksGfq6CkMtqGNJGs5zncHJDkPTOUauFxq4m9dflkF9eFc?=
 =?us-ascii?Q?/2PiRwVq7FUUbUPWx8+9OMMEdZoEWV9S2hGTHDgVwrh+pBpGwq4CabS6SS3+?=
 =?us-ascii?Q?AUajGfpUbg4sqCP9qhemN9gu0fBlnlNKTKynriiT/WxYjbl6TrPqscYCY0eV?=
 =?us-ascii?Q?IFHEhtPuBgL/3jshu6FyetE5sUdHh+/q7fcn6TlJnFxp8zem/iZREVcNv4Oj?=
 =?us-ascii?Q?9S9a1Te0vaWquEB4OlukMItI2sxv8+RmHDD8wbqQ7oDi4Y0NkM2ljBkBRaEZ?=
 =?us-ascii?Q?zrn+D4H01LNMWWeImUynAophrkBCibgTSlDj0kSMEZM4mnYUYc/f6YHIdgZ0?=
 =?us-ascii?Q?93uQfu3P2gNUI8fY6NZVQz1G5nQcfQfk5jd9AADNZyFLqaHDXsfpzoKnC0mO?=
 =?us-ascii?Q?skMX2PUsu6//NKCvFqvqANYEC1RM0Yvmj/Lvb49tqRC8B2lb7Sf5iQ2exOwv?=
 =?us-ascii?Q?W5xwNHi6xwe5VrQl0UtxmJuuq5ve6zyk4Qp4pz2jK2Cn51f+4FK1aKabrINO?=
 =?us-ascii?Q?eyNuNXzljaX0HrGJqiWkT8tOrqYYWcRdCUppb9pFn7kYNgpSjslBX4Wh1JLC?=
 =?us-ascii?Q?0d8+pht6e+V9Nkxa5J3We1K1EeG07bgbxesLHCI4tHNtyzyY9nKADGGaM9rp?=
 =?us-ascii?Q?3wuGGBAA9lunaEM6bjgYE1VzjM90JGrGG6/FGF2eBA8wTct+gbBNetuIDt87?=
 =?us-ascii?Q?dqgbaX2t1MxsFytjFfjyGynogMPyMxrLwZf25nrfC+YlhWsUtMONxiS1r6bH?=
 =?us-ascii?Q?KSDivN4vaQqw5lkV6WM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a12432-ff9b-4277-9d48-08ddb3d8a522
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 11:08:42.1221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6OB174U+88NjMSAqdSSUcVJjz4pYZzLE86JFvEKcT9zbZKfpDl/2d67CBBFyc6p0kzIAHepkFXIVDW7lDSUTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 25 June 2025 04:34 PM
>=20
> On Wed, Jun 25, 2025 at 02:55:27AM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: 25 June 2025 01:24 AM
> > >
> > > On Tue, Jun 24, 2025 at 07:11:29PM +0000, Parav Pandit wrote:
> > > >
> > > >
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: 25 June 2025 12:37 AM
> > > > >
> > > > > On Tue, Jun 24, 2025 at 07:01:44PM +0000, Parav Pandit wrote:
> > > > > >
> > > > > >
> > > > > > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > > Sent: 25 June 2025 12:26 AM
> > > > > > >
> > > > > > > On Mon, Jun 02, 2025 at 02:44:33AM +0000, Parav Pandit wrote:
> > > > > > > > When the PCI device is surprise removed, requests may not
> > > > > > > > complete the device as the VQ is marked as broken. Due to
> > > > > > > > this, the disk deletion hangs.
> > > > > > >
> > > > > > > There are loops in the core virtio driver code that expect
> > > > > > > device register reads to eventually return 0:
> > > > > > > drivers/virtio/virtio_pci_modern.c:vp_reset()
> > > > > > > drivers/virtio/virtio_pci_modern_dev.c:vp_modern_set_queue_r
> > > > > > > eset
> > > > > > > ()
> > > > > > >
> > > > > > > Is there a hang if these loops are hit when a device has
> > > > > > > been surprise removed? I'm trying to understand whether
> > > > > > > surprise removal is fully supported or whether this patch is
> > > > > > > one step in that
> > > direction.
> > > > > > >
> > > > > > In one of the previous replies I answered to Michael, but
> > > > > > don't have the link
> > > > > handy.
> > > > > > It is not fully supported by this patch. It will hang.
> > > > > >
> > > > > > This patch restores driver back to the same state what it was
> > > > > > before the fixes
> > > > > tag patch.
> > > > > > The virtio stack level work is needed to support surprise
> > > > > > removal, including
> > > > > the reset flow you rightly pointed.
> > > > >
> > > > > Have plans to do that?
> > > > >
> > > > Didn't give enough thoughts on it yet.
> > >
> > > This one is kind of pointless then? It just fixes the specific race
> > > window that your test harness happens to hit?
> > >
> > It was reported by Li from Baidu, whose tests failed.
> > I missed to tag "reported-by" in v5. I had it until v4. :(
> >
> > > Maybe it's better to wait until someone does a comprehensive fix..
> > >
> > >
> > Oh, I was under impression is that you wanted to step forward in discus=
sion
> of v4.
> > If you prefer a comprehensive support across layers of virtio, I sugges=
t you
> should revert the cited patch in fixes tag.
> >
> > Otherwise, it is in degraded state as virtio never supported surprise r=
emoval.
> > By reverting the cited patch (or with this fix), the requests and disk =
deletion
> will not hang.
>=20
> But they will hung in virtio core on reset, will they not? The tests just=
 do not
> happen to trigger this?
>=20
It will hang if it a true surprise removal which no device did so far becau=
se it never worked.
(or did, but always hung that no one reported yet)

I am familiar with 2 or more PCI devices who reports surprise removal, whic=
h do not complete the requests but yet allows device reset flow.
This is because device is still there on the PCI bus. Only via side band si=
gnals device removal was reported.

But I agree that for full support, virtio all layer changes would be needed=
 as new functionality (without fixes tag  :) ).

> > Please let me know if I should re-send to revert the patch listed in fi=
xes tag.
> >
> > > > > > > Apart from that, I'm happy with the virtio_blk.c aspects of t=
he
> patch:
> > > > > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > >
> > > > > > Thanks.
> > > > > >
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
> > > > > > > > Reported-by: Li RongQing <lirongqing@baidu.com>
> > > > > > > > Closes:
> > > > > > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c5
> > > > > > > > 5fb7
> > > > > > > > 3ca9
> > > > > > > > b474
> > > > > > > > 1@baidu.com/
> > > > > > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > > > > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > > > > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > > > >
> > > > > > > > ---
> > > > > > > > v4->v5:
> > > > > > > > - fixed comment style where comment to start with one
> > > > > > > > empty line at start
> > > > > > > > - Addressed comments from Alok
> > > > > > > > - fixed typo in broken vq check
> > > > > > > > v3->v4:
> > > > > > > > - Addressed comments from Michael
> > > > > > > > - renamed virtblk_request_cancel() to
> > > > > > > >   virtblk_complete_request_with_ioerr()
> > > > > > > > - Added comments for virtblk_complete_request_with_ioerr()
> > > > > > > > - Renamed virtblk_broken_device_cleanup() to
> > > > > > > >   virtblk_cleanup_broken_device()
> > > > > > > > - Added comments for virtblk_cleanup_broken_device()
> > > > > > > > - Moved the broken vq check in virtblk_remove()
> > > > > > > > - Fixed comment style to have first empty line
> > > > > > > > - replaced freezed to frozen
> > > > > > > > - Fixed comments rephrased
> > > > > > > >
> > > > > > > > v2->v3:
> > > > > > > > - Addressed comments from Michael
> > > > > > > > - updated comment for synchronizing with callbacks
> > > > > > > >
> > > > > > > > v1->v2:
> > > > > > > > - Addressed comments from Stephan
> > > > > > > > - fixed spelling to 'waiting'
> > > > > > > > - Addressed comments from Michael
> > > > > > > > - Dropped checking broken vq from queue_rq() and queue_rqs(=
)
> > > > > > > >   because it is checked in lower layer routines in virtio
> > > > > > > > core
> > > > > > > >
> > > > > > > > v0->v1:
> > > > > > > > - Fixed comments from Stefan to rename a cleanup function
> > > > > > > > - Improved logic for handling any outstanding requests
> > > > > > > >   in bio layer
> > > > > > > > - improved cancel callback to sync with ongoing done()
> > > > > > > > ---
> > > > > > > >  drivers/block/virtio_blk.c | 95
> > > > > > > > ++++++++++++++++++++++++++++++++++++++
> > > > > > > >  1 file changed, 95 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/block/virtio_blk.c
> > > > > > > > b/drivers/block/virtio_blk.c index
> > > > > > > > 7cffea01d868..c5e383c0ac48
> > > > > > > > 100644
> > > > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > > > @@ -1554,6 +1554,98 @@ static int virtblk_probe(struct
> > > > > > > > virtio_device
> > > > > > > *vdev)
> > > > > > > >  	return err;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +/*
> > > > > > > > + * If the vq is broken, device will not complete requests.
> > > > > > > > + * So we do it for the device.
> > > > > > > > + */
> > > > > > > > +static bool virtblk_complete_request_with_ioerr(struct
> > > > > > > > +request *rq, void *data) {
> > > > > > > > +	struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(rq);
> > > > > > > > +	struct virtio_blk *vblk =3D data;
> > > > > > > > +	struct virtio_blk_vq *vq;
> > > > > > > > +	unsigned long flags;
> > > > > > > > +
> > > > > > > > +	vq =3D &vblk->vqs[rq->mq_hctx->queue_num];
> > > > > > > > +
> > > > > > > > +	spin_lock_irqsave(&vq->lock, flags);
> > > > > > > > +
> > > > > > > > +	vbr->in_hdr.status =3D VIRTIO_BLK_S_IOERR;
> > > > > > > > +	if (blk_mq_request_started(rq) &&
> > > !blk_mq_request_completed(rq))
> > > > > > > > +		blk_mq_complete_request(rq);
> > > > > > > > +
> > > > > > > > +	spin_unlock_irqrestore(&vq->lock, flags);
> > > > > > > > +	return true;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +/*
> > > > > > > > + * If the device is broken, it will not use any buffers
> > > > > > > > +and waiting
> > > > > > > > + * for that to happen is pointless. We'll do the cleanup
> > > > > > > > +in the driver,
> > > > > > > > + * completing all requests for the device.
> > > > > > > > + */
> > > > > > > > +static void virtblk_cleanup_broken_device(struct virtio_bl=
k *vblk)
> {
> > > > > > > > +	struct request_queue *q =3D vblk->disk->queue;
> > > > > > > > +
> > > > > > > > +	/*
> > > > > > > > +	 * Start freezing the queue, so that new requests keeps
> > > waiting at the
> > > > > > > > +	 * door of bio_queue_enter(). We cannot fully freeze the
> > > > > > > > +queue
> > > > > > > because
> > > > > > > > +	 * frozen queue is an empty queue and there are pending
> > > requests, so
> > > > > > > > +	 * only start freezing it.
> > > > > > > > +	 */
> > > > > > > > +	blk_freeze_queue_start(q);
> > > > > > > > +
> > > > > > > > +	/*
> > > > > > > > +	 * When quiescing completes, all ongoing dispatches have
> > > completed
> > > > > > > > +	 * and no new dispatch will happen towards the driver.
> > > > > > > > +	 */
> > > > > > > > +	blk_mq_quiesce_queue(q);
> > > > > > > > +
> > > > > > > > +	/*
> > > > > > > > +	 * Synchronize with any ongoing VQ callbacks that may
> > > > > > > > +have
> > > started
> > > > > > > > +	 * before the VQs were marked as broken. Any outstanding
> > > requests
> > > > > > > > +	 * will be completed by
> > > virtblk_complete_request_with_ioerr().
> > > > > > > > +	 */
> > > > > > > > +	virtio_synchronize_cbs(vblk->vdev);
> > > > > > > > +
> > > > > > > > +	/*
> > > > > > > > +	 * At this point, no new requests can enter the
> > > > > > > > +queue_rq()
> > > and
> > > > > > > > +	 * completion routine will not complete any new requests
> > > > > > > > +either for
> > > > > > > the
> > > > > > > > +	 * broken vq. Hence, it is safe to cancel all requests wh=
ich are
> > > > > > > > +	 * started.
> > > > > > > > +	 */
> > > > > > > > +	blk_mq_tagset_busy_iter(&vblk->tag_set,
> > > > > > > > +				virtblk_complete_request_with_ioerr,
> > > vblk);
> > > > > > > > +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> > > > > > > > +
> > > > > > > > +	/*
> > > > > > > > +	 * All pending requests are cleaned up. Time to resume
> > > > > > > > +so
> > > that disk
> > > > > > > > +	 * deletion can be smooth. Start the HW queues so that
> > > > > > > > +when queue
> > > > > > > is
> > > > > > > > +	 * unquiesced requests can again enter the driver.
> > > > > > > > +	 */
> > > > > > > > +	blk_mq_start_stopped_hw_queues(q, true);
> > > > > > > > +
> > > > > > > > +	/*
> > > > > > > > +	 * Unquiescing will trigger dispatching any pending
> > > > > > > > +requests
> > > to the
> > > > > > > > +	 * driver which has crossed bio_queue_enter() to the driv=
er.
> > > > > > > > +	 */
> > > > > > > > +	blk_mq_unquiesce_queue(q);
> > > > > > > > +
> > > > > > > > +	/*
> > > > > > > > +	 * Wait for all pending dispatches to terminate which
> > > > > > > > +may
> > > have been
> > > > > > > > +	 * initiated after unquiescing.
> > > > > > > > +	 */
> > > > > > > > +	blk_mq_freeze_queue_wait(q);
> > > > > > > > +
> > > > > > > > +	/*
> > > > > > > > +	 * Mark the disk dead so that once we unfreeze the
> > > > > > > > +queue,
> > > requests
> > > > > > > > +	 * waiting at the door of bio_queue_enter() can be
> > > > > > > > +aborted right
> > > > > > > away.
> > > > > > > > +	 */
> > > > > > > > +	blk_mark_disk_dead(vblk->disk);
> > > > > > > > +
> > > > > > > > +	/* Unfreeze the queue so that any waiting requests will
> > > > > > > > +be
> > > aborted. */
> > > > > > > > +	blk_mq_unfreeze_queue_nomemrestore(q);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  static void virtblk_remove(struct virtio_device *vdev)  {
> > > > > > > >  	struct virtio_blk *vblk =3D vdev->priv; @@ -1561,6 +1653,=
9
> > > > > > > > @@ static void virtblk_remove(struct virtio_device *vdev)
> > > > > > > >  	/* Make sure no work handler is accessing the device. */
> > > > > > > >  	flush_work(&vblk->config_work);
> > > > > > > >
> > > > > > > > +	if (virtqueue_is_broken(vblk->vqs[0].vq))
> > > > > > > > +		virtblk_cleanup_broken_device(vblk);
> > > > > > > > +
> > > > > > > >  	del_gendisk(vblk->disk);
> > > > > > > >  	blk_mq_free_tag_set(&vblk->tag_set);
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.34.1
> > > > > > > >

